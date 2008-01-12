From: Eric Wong <normalperson@yhbt.net>
Subject: Re: [PATCH] git-svn: handle leading/trailing whitespace from svnsync revprops
Date: Sat, 12 Jan 2008 01:12:42 -0800
Message-ID: <20080112091242.GA27109@soma>
References: <200801081738.56624.devurandom@gmx.net> <200801101813.45938.devurandom@gmx.net> <7v63y178a3.fsf@gitster.siamese.dyndns.org> <200801102213.04082.devurandom@gmx.net> <7vmyrd5p81.fsf@gitster.siamese.dyndns.org> <20080112071355.GA17021@soma> <7vzlvbv5m9.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 12 10:13:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDcQU-0001G9-IG
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 10:13:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643AbYALJMr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 04:12:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759171AbYALJMq
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 04:12:46 -0500
Received: from hand.yhbt.net ([66.150.188.102]:39030 "EHLO hand.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751746AbYALJMo (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 04:12:44 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by hand.yhbt.net (Postfix) with ESMTP id E91332DC08B;
	Sat, 12 Jan 2008 01:12:43 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <7vzlvbv5m9.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70302>

Junio C Hamano <gitster@pobox.com> wrote:
> Eric Wong <normalperson@yhbt.net> writes:
> > diff --git a/git-svn.perl b/git-svn.perl
> > index 3308fe1..f40ad2c 100755
> > --- a/git-svn.perl
> > +++ b/git-svn.perl
> > @@ -1758,10 +1758,16 @@ sub svnsync {
> >  	# see if we have it in our config, first:
> >  	eval {
> >  		my $section = "svn-remote.$self->{repo_id}";
> > -		$svnsync = {
> > -		  url => tmp_config('--get', "$section.svnsync-url"),
> > -		  uuid => tmp_config('--get', "$section.svnsync-uuid"),
> > -		}
> > +
> > +	        my $url = tmp_config('--get', "$section.svnsync-url");
> > +		($url) = ($url =~ m{^([a-z\+]+://\S+)$}) or
> > +	           die "doesn't look right - svn:sync-from-url is '$url'\n";
> 
> When I checked tmp_config(), I thought that it was returning the
> first element (taking the output of "config --get" as a
> LF-terminated list) when called in list context, so this would
> give the correct sync-url after stripping the trailing LF for
> Dennis's case.  The first assignment looks fine, but the second
> one looks very funny.
> 
> Is it only me who finds that
> 
> 	($var) = ($var =~ m{^(any regexp)$}) or die "message"
> 
> is extremely a roundabout and hard-to-read way to say:
> 
> 	if ($var !~ m{^(the same regexp)$} {
>         	die "message";
> 	}
> 
> which is much easier to read?

The statements are not equivalent, however.  I'd have to add

	$var = $1;

too, because I needed to extract what was inside the ( ) since the '$'
doesn't catch the trailing newline, either.  I also couldn't find any of
the /sm, /m, /s switches useful for making '$' not accept the trailing
newline, either.

I also consider the "or die " part of the line to be uninteresting,
and would rather not waste extra space on it.

> I said the first one looks fine, but actually I really _hate_
> Perl subs that use wantarray and return one element in scalar
> context, and return a list in list context.
> 
> This forces the programmer who calls the sub to read the code of
> the sub and know that it uses this unusual calling convention.
> It forbids them to rely on their common-sense acquired from
> experience while coding in Perl, that most functions do not do
> that, and a usual sub that is capable of returning a list in a
> list context you can find out the number of elemenets, the first
> element, and the first few elements by using:
> 
> 	sub returns_list {
>         	my @a = qw(a b c);
>                 return @a;
> 	}
> 
> 	my $number_of_elems = returns_list();
> 	my ($first_element) = returns_list();
> 	my ($first, $second) = returns_list();
> 
> IOW, writing
> 
> 	sub returns_funny {
>         	my @a = qw(a b c);
>                 return wantarray ? @a : $a[0];
> 	}
> 
> may make you feel as if you have become a power-coder, and might
> even give you a false sense that some parts of your code can
> become simpler thanks to that, because you can now write:
> 
> 	my $first_element = returns_list();
> 
> i.e. you did not have to type WHOLE TWO LETTERS ( and )!
> 
> But in the longer run, when you want/need other people to help
> maintaining such a code, you create unnecessary burden on them.

Good points, I've been mindlessly taking "interesting" things from other
Perl code I've seen over the years and using it in my own without
thinking about it too hard :x

I'll avoid them in the future.  Unfortunately, Git.pm also suffers from
this as well.

-- 
Eric Wong
