From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: [PATCH] Handle "git show" output correctly.
Date: Wed, 12 Sep 2012 17:40:29 +0200
Message-ID: <vpqpq5rz1ua.fsf@bauges.imag.fr>
References: <1347463571-16831-1-git-send-email-pjones@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Peter Jones <pjones@redhat.com>
X-From: git-owner@vger.kernel.org Wed Sep 12 17:40:58 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TBp3Y-0001NY-T2
	for gcvg-git-2@plane.gmane.org; Wed, 12 Sep 2012 17:40:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760132Ab2ILPkk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Sep 2012 11:40:40 -0400
Received: from mx1.imag.fr ([129.88.30.5]:52427 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757644Ab2ILPki (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Sep 2012 11:40:38 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id q8CFa2Jx001196
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 12 Sep 2012 17:36:02 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:DHE_RSA_AES_128_CBC_SHA1:16)
	(Exim 4.72)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1TBp3G-0006iJ-49; Wed, 12 Sep 2012 17:40:30 +0200
In-Reply-To: <1347463571-16831-1-git-send-email-pjones@redhat.com> (Peter
	Jones's message of "Wed, 12 Sep 2012 11:26:11 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.1 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 12 Sep 2012 17:36:03 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: q8CFa2Jx001196
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1348068965.25424@EKjNWGyB3SMT0bJAB+ErTA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/205302>

> Subject: Re: [PATCH] Handle "git show" output correctly.

No final period please.

This does not say which part of git is made to handle "git show". What
about

[PATCH] am: handle "git show" output correctly

Peter Jones <pjones@redhat.com> writes:

This lacks a proper commit message, i.e. an answer to the "why is this
change good?" question.

> Signed-off-by: Peter Jones <pjones@redhat.com>
> ---
>  git-am.sh | 46 ++++++++++++++++++++++++++++++++++++++++++++++

Documentation?

> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -216,6 +216,21 @@ check_patch_format () {
>  		read l2
>  		read l3
>  		case "$l1" in
> +                "commit "*)
> +                        case "$l2" in
> +                        "Author: "*)
> +                                case "$l3" in
> +                                "Date: "*)
> +                                        patch_format=gitshow
> +                                        ;;
> +                                *)
> +                                        ;;
> +                                esac
> +                                ;;
> +                        *)
> +                                ;;
> +                        esac
> +                        ;;

Your code is indented with space, Git indents with tabs. Please fix this
in your next version.

>  			patch_format=mbox
>  			;;
> @@ -321,6 +336,37 @@ split_patches () {
>  		this=
>  		msgnum=
>  		;;
> +        gitshow)
> +		this=0
> +		for stgit in "$@"

Probably a cut-and-paste from the stgit version, but your variable
naming doesn't make sense here.

> +		do
> +			this=`expr "$this" + 1`
> +			msgnum=`printf "%0${prec}d" $this`
> +			# Perl version of The first nonemptyline after an

Wrong cut-and-paste again, the sentense doesn't parse.

> +                        # empty line is the subject, and the body starts with
> +                        # the next nonempty line.
> +			perl -ne 'BEGIN { $subject = 0 }
> +				if ($subject > 1) { print ; }
> +				elsif (/^\s+$/) { next ; }
> +				elsif (/^Author:/) { s/Author/From/ ; print ;}
> +				elsif (/^(From|Date)/) { print ; }
> +                                elsif (/^commit/) { next ; }
> +				elsif ($subject) {
> +					$subject = 2 ;
> +					print "\n" ;
> +                                        s/^    // ;
> +					print ;
> +				} else {
> +					print "Subject: ", $_ ;
> +					$subject = 1;
> +				}

How does this react to multi-line subject, e.g

This should be the
subject line.

And this is the body.

?

git format-patch will merge the lines in a single Subject: header, and
your version seems to take only the first line.

A test showing this would be welcome.

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/
