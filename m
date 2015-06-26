From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 3/7] bisect: treat BISECT_HEAD as a ref
Date: Fri, 26 Jun 2015 14:46:17 -0700
Message-ID: <xmqqtwturvme.fsf@gitster.dls.corp.google.com>
References: <1435278548-3790-1-git-send-email-dturner@twopensource.com>
	<1435278548-3790-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Fri Jun 26 23:46:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z8bS5-0007WX-Ku
	for gcvg-git-2@plane.gmane.org; Fri, 26 Jun 2015 23:46:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752460AbbFZVqV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jun 2015 17:46:21 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:33010 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752466AbbFZVqT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jun 2015 17:46:19 -0400
Received: by igtg8 with SMTP id g8so10680381igt.0
        for <git@vger.kernel.org>; Fri, 26 Jun 2015 14:46:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=i8TPUQarrM914HFcLIMVyAXCXzIDz/yIus6Vjd+9KiA=;
        b=iGVd8nIvz2ffDJ9IP1lM4ocDTc/vwTjEMnoGEwq2dMIvT8QcBrpfq5xA+6uGtuxK4a
         FJ+Uhm0RgnsQBJ9Mx4A0B8JlaV/0t8/wovp2Grdnj07Uopb5BMGkttTXvs/Uqi/YSIxm
         0Ra8KcJoHjsXrZjlJkOGMgUaKz0Hc/xRzu3irVUL++CGly+S3c5V095pdb6gP96OuWQU
         PaF1WVqzmWTIp6bQAGrTFVzetPztQkv7O3aBpSPZQwCo+d/TG/khlAVqxYPHiWjmnQrN
         kVxZX5URkBcmRswgI+ZnlEK1eJXdi5h2QUnwz1ySbTEXG8RojgImYbIv0u6rXOYi8Xsa
         zUBA==
X-Received: by 10.43.45.130 with SMTP id uk2mr5834087icb.38.1435355179312;
        Fri, 26 Jun 2015 14:46:19 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6587:7c7a:db33:ca35])
        by mx.google.com with ESMTPSA id j20sm103936igt.5.2015.06.26.14.46.18
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 26 Jun 2015 14:46:18 -0700 (PDT)
In-Reply-To: <1435278548-3790-3-git-send-email-dturner@twopensource.com>
	(David Turner's message of "Thu, 25 Jun 2015 20:29:04 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272832>

David Turner <dturner@twopensource.com> writes:

> Instead of directly writing to and reading from files in
> $GIT_DIR, use ref API to interact with BISECT_HEAD.
>
> Signed-off-by: David Turner <dturner@twopensource.com>
> ---

Interesting.  From the patch, it seems that the codepath that writes
BISECT_HEAD were already doing update-ref instead of writing into or
removing a file.

The result of applying this patch looked sane.  Thanks.

>  git-bisect.sh | 10 +++++++---
>  1 file changed, 7 insertions(+), 3 deletions(-)
>
> diff --git a/git-bisect.sh b/git-bisect.sh
> index ae3fec2..dddcc89 100755
> --- a/git-bisect.sh
> +++ b/git-bisect.sh
> @@ -35,7 +35,7 @@ _x40="$_x40$_x40$_x40$_x40$_x40$_x40$_x40$_x40"
>  
>  bisect_head()
>  {
> -	if test -f "$GIT_DIR/BISECT_HEAD"
> +	if bisect_head_exists
>  	then
>  		echo BISECT_HEAD
>  	else
> @@ -209,6 +209,10 @@ check_expected_revs() {
>  	done
>  }
>  
> +bisect_head_exists() {
> +    git rev-parse --quiet --verify "BISECT_HEAD" >/dev/null
> +}
> +
>  bisect_skip() {
>  	all=''
>  	for arg in "$@"
> @@ -310,7 +314,7 @@ bisect_next() {
>  	bisect_next_check good
>  
>  	# Perform all bisection computation, display and checkout
> -	git bisect--helper --next-all $(test -f "$GIT_DIR/BISECT_HEAD" && echo --no-checkout)
> +	git bisect--helper --next-all $(bisect_head_exists && echo --no-checkout)
>  	res=$?
>  
>  	# Check if we should exit because bisection is finished
> @@ -377,7 +381,7 @@ bisect_reset() {
>  		usage ;;
>  	esac
>  
> -	if ! test -f "$GIT_DIR/BISECT_HEAD" && ! git checkout "$branch" --
> +	if ! bisect_head_exists && ! git checkout "$branch" --
>  	then
>  		die "$(eval_gettext "Could not check out original HEAD '\$branch'.
>  Try 'git bisect reset <commit>'.")"
