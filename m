From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-svn: handle leading/trailing whitespace from svnsync revprops
Date: Fri, 11 Jan 2008 23:57:02 -0800
Message-ID: <7vzlvbv5m9.fsf@gitster.siamese.dyndns.org>
References: <200801081738.56624.devurandom@gmx.net>
	<200801101813.45938.devurandom@gmx.net>
	<7v63y178a3.fsf@gitster.siamese.dyndns.org>
	<200801102213.04082.devurandom@gmx.net>
	<7vmyrd5p81.fsf@gitster.siamese.dyndns.org>
	<20080112071355.GA17021@soma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dennis Schridde <devurandom@gmx.net>, git@vger.kernel.org
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Sat Jan 12 08:57:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JDbFM-0004kS-CW
	for gcvg-git-2@gmane.org; Sat, 12 Jan 2008 08:57:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755266AbYALH5M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jan 2008 02:57:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1759719AbYALH5M
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Jan 2008 02:57:12 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:45126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751658AbYALH5L (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jan 2008 02:57:11 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id E475E4C17;
	Sat, 12 Jan 2008 02:57:07 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 196C34C16;
	Sat, 12 Jan 2008 02:57:03 -0500 (EST)
In-Reply-To: <20080112071355.GA17021@soma> (Eric Wong's message of "Fri, 11
	Jan 2008 23:13:55 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/70293>

Eric Wong <normalperson@yhbt.net> writes:
> diff --git a/git-svn.perl b/git-svn.perl
> index 3308fe1..f40ad2c 100755
> --- a/git-svn.perl
> +++ b/git-svn.perl
> @@ -1758,10 +1758,16 @@ sub svnsync {
>  	# see if we have it in our config, first:
>  	eval {
>  		my $section = "svn-remote.$self->{repo_id}";
> -		$svnsync = {
> -		  url => tmp_config('--get', "$section.svnsync-url"),
> -		  uuid => tmp_config('--get', "$section.svnsync-uuid"),
> -		}
> +
> +	        my $url = tmp_config('--get', "$section.svnsync-url");
> +		($url) = ($url =~ m{^([a-z\+]+://\S+)$}) or
> +	           die "doesn't look right - svn:sync-from-url is '$url'\n";

When I checked tmp_config(), I thought that it was returning the
first element (taking the output of "config --get" as a
LF-terminated list) when called in list context, so this would
give the correct sync-url after stripping the trailing LF for
Dennis's case.  The first assignment looks fine, but the second
one looks very funny.

Is it only me who finds that

	($var) = ($var =~ m{^(any regexp)$}) or die "message"

is extremely a roundabout and hard-to-read way to say:

	if ($var !~ m{^(the same regexp)$} {
        	die "message";
	}

which is much easier to read?

I said the first one looks fine, but actually I really _hate_
Perl subs that use wantarray and return one element in scalar
context, and return a list in list context.

This forces the programmer who calls the sub to read the code of
the sub and know that it uses this unusual calling convention.
It forbids them to rely on their common-sense acquired from
experience while coding in Perl, that most functions do not do
that, and a usual sub that is capable of returning a list in a
list context you can find out the number of elemenets, the first
element, and the first few elements by using:

	sub returns_list {
        	my @a = qw(a b c);
                return @a;
	}

	my $number_of_elems = returns_list();
	my ($first_element) = returns_list();
	my ($first, $second) = returns_list();

IOW, writing

	sub returns_funny {
        	my @a = qw(a b c);
                return wantarray ? @a : $a[0];
	}

may make you feel as if you have become a power-coder, and might
even give you a false sense that some parts of your code can
become simpler thanks to that, because you can now write:

	my $first_element = returns_list();

i.e. you did not have to type WHOLE TWO LETTERS ( and )!

But in the longer run, when you want/need other people to help
maintaining such a code, you create unnecessary burden on them.
