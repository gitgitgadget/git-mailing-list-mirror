From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-am: Keep index in case of abort with dirty index
Date: Thu, 26 Feb 2009 11:23:48 -0800
Message-ID: <7vfxi1rohn.fsf@gitster.siamese.dyndns.org>
References: <7v8wnu2x67.fsf@gitster.siamese.dyndns.org>
 <1235641973-18307-1-git-send-email-git@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Thu Feb 26 20:25:30 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LclrJ-0006sO-Sa
	for gcvg-git-2@gmane.org; Thu, 26 Feb 2009 20:25:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752479AbZBZTX4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Feb 2009 14:23:56 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752419AbZBZTX4
	(ORCPT <rfc822;git-outgoing>); Thu, 26 Feb 2009 14:23:56 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbZBZTXz (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Feb 2009 14:23:55 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id D87AF10EA;
	Thu, 26 Feb 2009 14:23:52 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 05AA410E9; Thu,
 26 Feb 2009 14:23:49 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 00AF6436-043B-11DE-AE3F-8D02133F2F75-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111588>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> git am --abort resets the index unconditionally. But in case a previous
> git am exited due to a dirty index it is preferable to keep that index.
> Make it so.
>
> Signed-off-by: Michael J Gruber <git@drmicha.warpmail.net>
> ---
> Something like this?

Thanks; I think it is a good start.

>  git-am.sh |   12 +++++++++---
>  1 files changed, 9 insertions(+), 3 deletions(-)
>
> diff --git a/git-am.sh b/git-am.sh
> index 8bcb206..7013fea 100755
> --- a/git-am.sh
> +++ b/git-am.sh
> @@ -230,8 +230,10 @@ then
>  		;;
>  	,t)
>  		git rerere clear
> -		git read-tree --reset -u HEAD ORIG_HEAD
> -		git reset ORIG_HEAD
> +		test -f "$dotest/dirtyindex" || {
> +			git read-tree --reset -u HEAD ORIG_HEAD
> +			git reset ORIG_HEAD
> +		}
>  		rm -fr "$dotest"
>  		exit ;;
>  	esac
> @@ -287,7 +289,11 @@ fi
>  case "$resolved" in
>  '')
>  	files=$(git diff-index --cached --name-only HEAD --) || exit
> -	test "$files" && die "Dirty index: cannot apply patches (dirty: $files)"
> +	if test "$files"
> +	then
> +		: >"$dotest/dirtyindex"
> +		die "Dirty index: cannot apply patches (dirty: $files)"
> +	fi
>  esac
>  
>  if test "$(cat "$dotest/utf8")" = t

This certainly would catch this case:

	$ git add hello.c
        $ git am -3 patch.mbox
        ... oops, I had already added my changes
        $ git am --abort

But I think there should be some other code that resets "dirtyindex" flag
file to deal with a case like this:

	... start from a clean index
	$ git am -3 patch.mbox
        ... applies a first few cleanly and creates commits
        ... then stops with a conflict
        $ edit hello.c
	$ git add hello.c
        ... conflict resolved and this is good
        $ git am
        ... oops, I meant --resolved
        $ git am --resolved
        ... goes a bit more and then gets another conflict
        ... after examining the situation, decide the whole series
        ... is not worth it
        $ git am --abort


I guess you would probably want this single liner on top of your patch
(not tested if it fixes the above sequence, though).

diff --git a/git-am.sh b/git-am.sh
index 7013fea..351b4f8 100755
--- a/git-am.sh
+++ b/git-am.sh
@@ -237,6 +237,7 @@ then
 		rm -fr "$dotest"
 		exit ;;
 	esac
+	rm -f "$dotest/dirtyindex"
 else
 	# Make sure we are not given --skip, --resolved, nor --abort
 	test "$skip$resolved$abort" = "" ||
