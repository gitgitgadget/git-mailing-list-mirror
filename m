From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] stash: don't leak underlying error messages
Date: Thu, 12 Apr 2012 12:30:20 -0700
Message-ID: <7vaa2g694j.fsf@alter.siamese.dyndns.org>
References: <1334169379-20827-1-git-send-email-rosslagerwall@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ross Lagerwall <rosslagerwall@gmail.com>
X-From: git-owner@vger.kernel.org Thu Apr 12 21:30:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIPiw-00014c-HR
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 21:30:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762493Ab2DLTaZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 15:30:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:47662 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761550Ab2DLTaY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 15:30:24 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 776BF6060;
	Thu, 12 Apr 2012 15:30:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4t7Stwgw/GfnwebJ+8XPh53Q4Lo=; b=tKKBUw
	aN5SLf2k8Qkg92e0gdVYtV3ToR4b3JaG+k1/4poAvTekBhqq9+/LH/Zh/WS7xIFx
	DNjGYJKNPCi04/VH+3UqOrRzQyFV6l8dTeaz96nIOHcIKJ0Q8yswclBrHPTVNThN
	ZfpSDZE1Yt4bzgYOVcvoLixqoTFJfwn5yLf/c=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=qsQnk/jxWWEZVaEuFF06g5pH7rvKrfcp
	UVdOcVFrrKDVxkkM+3+WXmS51X0NhXehiseXAtOcw/ACRCQ7N7mtEJF+Dk35uxMy
	JgD+fSRADPByEegrl+d7JDxn1PpslsZaUOvWvFETeKhM2QbxxP5t0Km/vkQKERvV
	79KKQXseqqw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6C0F2605E;
	Thu, 12 Apr 2012 15:30:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id E3EDF605C; Thu, 12 Apr 2012
 15:30:21 -0400 (EDT)
In-Reply-To: <1334169379-20827-1-git-send-email-rosslagerwall@gmail.com>
 (Ross Lagerwall's message of "Wed, 11 Apr 2012 20:36:19 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: F1EB170A-84D5-11E1-BD73-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195358>

Ross Lagerwall <rosslagerwall@gmail.com> writes:

> When running git-stash on an empty repository, don't let the underlying
> error messages leak through to the surface; instead, redirect them to
> /dev/null.
> ---

Sign-off?

Is create_stash (hence save_stash) the only operation that do not make
sense when HEAD is not born yet?  I am wondering if it makes more sense to
either:

 (1) catch the case where HEAD is not born yet a lot earlier and do not
     let the control even reach these functions (i.e. die inside the
     case/esac statement at the end of the script); or

 (2) pretend as if HEAD is a commit that records an empty tree, and not
     error out to begin with.

If either one of the above turns out to make sense, then the issue this
patch addresses becomes irrelevant, so...

>  git-stash.sh |    6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>
> diff --git a/git-stash.sh b/git-stash.sh
> index fe4ab28..5c72d1b 100755
> --- a/git-stash.sh
> +++ b/git-stash.sh
> @@ -34,8 +34,8 @@ else
>  fi
>  
>  no_changes () {
> -	git diff-index --quiet --cached HEAD --ignore-submodules -- &&
> -	git diff-files --quiet --ignore-submodules &&
> +	git diff-index --quiet --cached HEAD --ignore-submodules -- 2>/dev/null &&
> +	git diff-files --quiet --ignore-submodules 2>/dev/null &&
>  	(test -z "$untracked" || test -z "$(untracked_files)")
>  }
>  
> @@ -67,7 +67,7 @@ create_stash () {
>  	fi
>  
>  	# state of the base commit
> -	if b_commit=$(git rev-parse --verify HEAD)
> +	if b_commit=$(git rev-parse --verify HEAD 2>/dev/null)
>  	then
>  		head=$(git rev-list --oneline -n 1 HEAD --)
>  	else
