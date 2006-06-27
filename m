From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] pre-commit hook: less easily-tripped conflict marker detection
Date: Tue, 27 Jun 2006 10:24:23 -0700
Message-ID: <7vodwe8qbc.fsf@assigned-by-dhcp.cox.net>
References: <11513991771758-git-send-email-normalperson@yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 27 19:25:33 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FvHIp-0008An-SG
	for gcvg-git@gmane.org; Tue, 27 Jun 2006 19:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161234AbWF0RYb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 27 Jun 2006 13:24:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161238AbWF0RYb
	(ORCPT <rfc822;git-outgoing>); Tue, 27 Jun 2006 13:24:31 -0400
Received: from fed1rmmtao09.cox.net ([68.230.241.30]:20903 "EHLO
	fed1rmmtao09.cox.net") by vger.kernel.org with ESMTP
	id S1161234AbWF0RYa (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Jun 2006 13:24:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.9.127])
          by fed1rmmtao09.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060627172429.IXXL16011.fed1rmmtao09.cox.net@assigned-by-dhcp.cox.net>;
          Tue, 27 Jun 2006 13:24:29 -0400
To: Eric Wong <normalperson@yhbt.net>
In-Reply-To: <11513991771758-git-send-email-normalperson@yhbt.net> (Eric
	Wong's message of "Tue, 27 Jun 2006 02:06:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/22747>

Eric Wong <normalperson@yhbt.net> writes:

> This should make adding asciidoc files to Documentation easier.
>
> Only complain about conflict markers if we see that we have
> some combination of '<<<<<<< ', '>>>>>>> ', and '======='.

Are you sure everybody uses exactly seven?  I did not have SP
after a run of '<' and '>' because I didn't know.

> Also add a NO_VERIFY environment check to this hook, in case
> there's something that we want to force in but still gets
> tripped by this hook.

Hmm.  Undecided.

> @@ -24,8 +25,9 @@ perl -e '
>...
> +    my $in_unresolved;

Unused as far as I can see.

> +    sub show_unresolved {
> +	# if we want even less easily-tripped checks,
> +	# change the "||" to "&&" here.  Right now, we can deal with
> +	# the case where somebody removed one of the <{7} or >{7} lines
> +	# but left the other one (as well as ={7}) in there.

I think '||' is fine as is -- I think <<< and === removed with
>>> left is a common mistake (think of superseding a smallish
"our change" between <<< and === with much larger and polished
upstream "their change" after ===).  But I am not sure about the
code around here:

> +	if (($unresolved[0]->[0] =~ /^<{7} / ||
> +				$unresolved[-1]->[0] =~ /^>{7} /) &&
> +				grep { $_->[0] =~ /^={7}$/ } @unresolved) {
> +	    bad_common();
> +	    foreach my $l (@unresolved) {
> +		print STDERR "* unresolved merge conflict (line $l->[1])\n";
> +		print STDERR "$filename:$l->[1]:$l->[0]\n"
> +	    }
> +	}

 - why check only the first and last element in @unresolved but
   use all of them without checking the ones in-between?

 - if you are keeping the range in an array, maybe the error
   message can point at the range.

Printing $l->[0] is not so useful (the user sees only the
conflict marker) but the original code did so only because it
operated on one-line at a time.

> +	@unresolved = ();
> +    }
> +
>      while (<>) {
>  	if (m|^diff --git a/(.*) b/\1$|) {
>  	    $filename = $1;
> +	    show_unresolved() if @unresolved;
>  	    next;
>  	}
>  	if (/^@@ -\S+ \+(\d+)/) {
> @@ -61,8 +85,8 @@ perl -e '
>  	    if (/^\s* 	/) {
>  		bad_line("indent SP followed by a TAB", $_);
>  	    }
> -	    if (/^(?:[<>=]){7}/) {
> -		bad_line("unresolved merge conflict", $_);
> +	    if (/^[<>]{7} / || /^={7}$/) {
> +		push @unresolved, [ $_, $lineno ];
>  	    }
>  	}
>      }

Maybe you are missing show_unresolved() for the last patch here?
