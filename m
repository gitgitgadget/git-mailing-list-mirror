From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t1301-shared-repo.sh: fix 'stat' portability issue
Date: Thu, 16 Aug 2007 12:09:16 -0700
Message-ID: <7v3ayjjnz7.fsf@gitster.siamese.dyndns.org>
References: <1187277663740-git-send-email-arjen@yaph.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailing List <git@vger.kernel.org>
To: Arjen Laarhoven <arjen@yaph.org>
X-From: git-owner@vger.kernel.org Thu Aug 16 21:09:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1ILkil-0008Sv-5F
	for gcvg-git@gmane.org; Thu, 16 Aug 2007 21:09:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751906AbXHPTJX (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 16 Aug 2007 15:09:23 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752292AbXHPTJW
	(ORCPT <rfc822;git-outgoing>); Thu, 16 Aug 2007 15:09:22 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:34015 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751720AbXHPTJV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Aug 2007 15:09:21 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A50FE122894;
	Thu, 16 Aug 2007 15:09:40 -0400 (EDT)
In-Reply-To: <1187277663740-git-send-email-arjen@yaph.org> (Arjen Laarhoven's
	message of "Thu, 16 Aug 2007 17:21:03 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56030>

Arjen Laarhoven <arjen@yaph.org> writes:

> The t1301-shared-repo.sh testscript uses /usr/bin/stat to get the file
> mode, which isn't portable.  There already is a dependency on Perl, so
> use a Perl one-liner to do the file mode test, but portable.
>
> Signed-off-by: Arjen Laarhoven <arjen@yaph.org>
> ---
>  t/t1301-shared-repo.sh |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
>
> diff --git a/t/t1301-shared-repo.sh b/t/t1301-shared-repo.sh
> index bb5f302..888c5fb 100755
> --- a/t/t1301-shared-repo.sh
> +++ b/t/t1301-shared-repo.sh
> @@ -21,7 +21,7 @@ test_expect_success 'update-server-info honors core.sharedRepository' '
>  	git commit -m a1 &&
>  	umask 0277 &&
>  	git update-server-info &&
> -	test 444 = $(stat -c %a .git/info/refs)
> +	$(perl -e '\''exit !(((stat ".git/info/refs")[2] & 0777) == 0444)'\'')
>  '

Why is this inside a $()?

I am just wondering if this is more portable and readable...

	... &&
	current="$(ls -l .git/info/refs)" &&
	case "$current" in
        -r--r--r--*)
        	: happy
                ;;
	*)
        	echo Oops, .git/info/refs is not 0444
                false
                ;;
	esac
