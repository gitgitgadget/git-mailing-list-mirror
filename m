From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v2 1/2] am: learn passing -b to mailinfo
Date: Fri, 20 Jan 2012 14:04:03 +0100
Message-ID: <87ehuucypo.fsf@thomas.inf.ethz.ch>
References: <8762ghxpxw.fsf@thomas.inf.ethz.ch>
	<a804650f805fd8c89a843302cb92bbbdf36b8c0b.1326710194.git.trast@student.ethz.ch>
	<7vd3afidt3.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Cc: <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 20 14:04:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoE8e-0003xB-Vz
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 14:04:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753178Ab2ATNEN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 20 Jan 2012 08:04:13 -0500
Received: from edge20.ethz.ch ([82.130.99.26]:26361 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752830Ab2ATNEM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 08:04:12 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 14:04:09 +0100
Received: from thomas.inf.ethz.ch.ethz.ch (192.101.176.246) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Fri, 20 Jan
 2012 14:04:10 +0100
In-Reply-To: <7vd3afidt3.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
	message of "Thu, 19 Jan 2012 13:26:48 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [192.101.176.246]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188876>

Junio C Hamano <gitster@pobox.com> writes:

> After re-reading the code that parses the command line options given to
> "am" and the previous invocation state we read from $dotest/*, however, I
> think the way this change uses $keep makes things somewhat inconsistent
> and harder to follow.
>
> Currently the variables are given abstract meaning (e.g. "are we told to
> record to utf8? yes or no") when we parse our command line options and
> read from the previous invocation state, and then based on that abstract
> meaning, a later code decides what exact option we throw at the git
> commands we invoke (e.g. "utf8=t" -> "-u").
>
> How about doing something like this instead at least for now?  It might be
> better to decide when we parse our options and $dotest/* immediately what
> options we give to the git commands we run (which your patch does but only
> to $keep option), but that kind of change (1) belongs to a separate topic
> and should be done consistently to all options, and (2) I am not convinced
> if it is necessarily a good change.

Yes, at second glance it's probably better to remain consistent.  I
didn't like it at first because it's layering complexity on it, but you
are right, the existing code follows the same pattern.

> diff --git a/git-am.sh b/git-am.sh
> index 6cdd591..8b755d9 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -15,6 +15,7 @@ q,quiet         be quiet
>  s,signoff       add a Signed-off-by line to the commit message
>  u,utf8          recode into utf8 (default)
>  k,keep          pass -k flag to git-mailinfo
> +keep-non-patch  pass -b flag to git-mailinfo
>  keep-cr         pass --keep-cr flag to git-mailsplit for mbox format
>  no-keep-cr      do not pass --keep-cr flag to git-mailsplit independent of am.keepcr
>  c,scissors      strip everything before a scissors line
> @@ -345,6 +346,8 @@ do
>  		utf8= ;;
>  	-k|--keep)
>  		keep=t ;;
> +	--keep-non-patch)
> +		keep=b ;;
>  	-c|--scissors)
>  		scissors=t ;;
>  	--no-scissors)
> @@ -522,16 +525,25 @@ case "$resolved" in
>  	fi
>  esac
>  
> +# Now, decide what command line options we will give to the git
> +# commands we invoke, based on the result of parsing command line
> +# options and previous invocation state stored in $dotest/ files.
> +
>  if test "$(cat "$dotest/utf8")" = t
>  then
>  	utf8=-u
>  else
>  	utf8=-n
>  fi
> -if test "$(cat "$dotest/keep")" = t
> -then
> -	keep=-k
> -fi
> +keep=$(cat "$dotest/keep")
> +case "$keep" in
> +t)
> +	keep=-k ;;
> +b)
> +	keep=-b ;;
> +*)
> +	keep= ;;
> +esac
>  case "$(cat "$dotest/keepcr")" in
>  t)
>  	keepcr=--keep-cr ;;

-- 
Thomas Rast
trast@{inf,student}.ethz.ch
