From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] pre-commit hook: less easily-tripped conflict marker detection
Date: Tue, 27 Jun 2006 15:32:26 -0700
Message-ID: <20060627223226.GA10178@soma>
References: <11513991771758-git-send-email-normalperson@yhbt.net> <7vodwe8qbc.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 28 00:32:49 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvM6t-0005Di-OU
	for gcvg-git@gmane.org; Wed, 28 Jun 2006 00:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1422687AbWF0Wcb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 18:32:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1422688AbWF0Wca
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 18:32:30 -0400
Received: from hand.yhbt.net ([66.150.188.102]:47317 "EHLO hand.yhbt.net")
	by vger.kernel.org with ESMTP id S1422687AbWF0Wc2 (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 27 Jun 2006 18:32:28 -0400
Received: from hand.yhbt.net (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with SMTP id C86B17DC022;
	Tue, 27 Jun 2006 15:32:26 -0700 (PDT)
Received: by hand.yhbt.net (sSMTP sendmail emulation); Tue, 27 Jun 2006 15:32:26 -0700
To: Junio C Hamano <junkio@cox.net>
Content-Disposition: inline
In-Reply-To: <7vodwe8qbc.fsf@assigned-by-dhcp.cox.net>
User-Agent: Mutt/1.5.11+cvs20060403
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22756>

Junio C Hamano <junkio@cox.net> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> 
> > This should make adding asciidoc files to Documentation easier.
> >
> > Only complain about conflict markers if we see that we have
> > some combination of '<<<<<<< ', '>>>>>>> ', and '======='.
> 
> Are you sure everybody uses exactly seven?  I did not have SP
> after a run of '<' and '>' because I didn't know.

That's what rerere checks for.  I'm not sure about other programs
leave 3-way merge markers besides merge(1).

> > @@ -24,8 +25,9 @@ perl -e '
> >...
> > +    my $in_unresolved;
> 
> Unused as far as I can see.

Oops, I was planning to store the entire hunk in @unresolved, but
decided line numbers were enough.

> > +    sub show_unresolved {
> > +	# if we want even less easily-tripped checks,
> > +	# change the "||" to "&&" here.  Right now, we can deal with
> > +	# the case where somebody removed one of the <{7} or >{7} lines
> > +	# but left the other one (as well as ={7}) in there.
> 
> I think '||' is fine as is -- I think <<< and === removed with
> >>> left is a common mistake (think of superseding a smallish
> "our change" between <<< and === with much larger and polished
> upstream "their change" after ===).  But I am not sure about the
> code around here:

My code won't detect when <<< and === are removed with only >>>
left.  I didn't think it was a common mistake at all.

> > +	if (($unresolved[0]->[0] =~ /^<{7} / ||
> > +				$unresolved[-1]->[0] =~ /^>{7} /) &&
> > +				grep { $_->[0] =~ /^={7}$/ } @unresolved) {
> > +	    bad_common();
> > +	    foreach my $l (@unresolved) {
> > +		print STDERR "* unresolved merge conflict (line $l->[1])\n";
> > +		print STDERR "$filename:$l->[1]:$l->[0]\n"
> > +	    }
> > +	}
> 
>  - why check only the first and last element in @unresolved but
>    use all of them without checking the ones in-between?

I assume that any partially finished resolutions would either start with
<<< or end with >>>.  I don't actually know which are the most oftenly
made mistakes when accidentally committing merge-conflicts.

>  - if you are keeping the range in an array, maybe the error
>    message can point at the range.
> 
> Printing $l->[0] is not so useful (the user sees only the
> conflict marker) but the original code did so only because it
> operated on one-line at a time.

I agree.  I was thinking about adding entire hunks with $in_unresolved,
but forgot or decided against it (probably out of laziness, as it was
late when I did this).

> > +	@unresolved = ();
> > +    }
> > +
> >      while (<>) {
> >  	if (m|^diff --git a/(.*) b/\1$|) {
> >  	    $filename = $1;
> > +	    show_unresolved() if @unresolved;
> >  	    next;
> >  	}
> >  	if (/^@@ -\S+ \+(\d+)/) {
> > @@ -61,8 +85,8 @@ perl -e '
> >  	    if (/^\s* 	/) {
> >  		bad_line("indent SP followed by a TAB", $_);
> >  	    }
> > -	    if (/^(?:[<>=]){7}/) {
> > -		bad_line("unresolved merge conflict", $_);
> > +	    if (/^[<>]{7} / || /^={7}$/) {
> > +		push @unresolved, [ $_, $lineno ];
> >  	    }
> >  	}
> >      }
> 
> Maybe you are missing show_unresolved() for the last patch here?

Oops, good catch.

<finally, moved from above>:
> > Also add a NO_VERIFY environment check to this hook, in case
> > there's something that we want to force in but still gets
> > tripped by this hook.
> 
> Hmm.  Undecided.

At this point, I think this is probably the best change to make.  There
are many things that a user could do that an automated checker could
miss, and there are also many things that it could be overchecking for.


-	    if (/^(?:[<>=]){7}/) {
+	    if (/^[<>]{7} / || /^={7}$/) {

I would also make this change, because I'm pretty certain 7 characters
(and one space for [<>]) is standard for merge(1).  We already rely on
that for rerere.

-- 
Eric Wong
