From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Mon, 11 May 2015 12:42:39 -0700
Message-ID: <xmqqh9ri3nps.fsf@gitster.dls.corp.google.com>
References: <1431366989-7405-1-git-send-email-dturner@twopensource.com>
	<1431366989-7405-3-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Mon May 11 21:42:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YrtbD-00049h-F3
	for gcvg-git-2@plane.gmane.org; Mon, 11 May 2015 21:42:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932119AbbEKTmm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 May 2015 15:42:42 -0400
Received: from mail-ie0-f171.google.com ([209.85.223.171]:35621 "EHLO
	mail-ie0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751926AbbEKTmm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 May 2015 15:42:42 -0400
Received: by ieczm2 with SMTP id zm2so117411409iec.2
        for <git@vger.kernel.org>; Mon, 11 May 2015 12:42:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=/K4/XO34yJILGu17HWgd728ic/kwe4fKaw4mpr4/gcY=;
        b=cksbk63ampqxaiyK5mVgMV81ULOHOh77nE90QwR+WADuAF4LyEVAilZLAvpxQyOenY
         m8hzxlN/9nMt1888oNSdmUQCv6WRNTHL+d0GuWbep8paRbspLF5eQNYlKVy1pHr08vdG
         2QLKFOLJ439cJv1NvYP4accWXlktX+QOVq/6CYOTMvowGu48Nka52vfRGMs3myrciQ1P
         +3XTZO6pzaVPc6U/7FK4ZljCzQRkRZn57K08KcqVeCMV5x+1Hp+LW+llLJqtr+9nubjt
         Hj5i2oYV9MTtmN5/hUT5/caSR8V2iYNJkOz9TkPwBeim5zT+DhZQu1Og7s0OG95hZwt0
         /K5Q==
X-Received: by 10.42.152.67 with SMTP id h3mr12695170icw.56.1431373361443;
        Mon, 11 May 2015 12:42:41 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:e888:82ed:a88f:f5e4])
        by mx.google.com with ESMTPSA id o9sm10337433ioe.35.2015.05.11.12.42.40
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 11 May 2015 12:42:40 -0700 (PDT)
In-Reply-To: <1431366989-7405-3-git-send-email-dturner@twopensource.com>
	(dturner@twopensource.com's message of "Mon, 11 May 2015 13:56:28
	-0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268819>

dturner@twopensource.com writes:

> From: David Turner <dturner@twitter.com>
>
> Wire up get_sha1_with_context to call get_tree_entry_follow_symlinks
> when GET_SHA1_FOLLOW_SYMLINKS is passed in flags. G_S_FOLLOW_SYMLINKS
> is incompatible with G_S_ONLY_TO_DIE because the diagnosis
> that ONLY_TO_DIE triggers does not at present consider symlinks, and
> it would be a significant amount of additional code to allow it to
> do so.
>
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  cache.h     | 20 +++++++++++++-------
>  sha1_name.c | 20 +++++++++++++++-----
>  2 files changed, 28 insertions(+), 12 deletions(-)
>
> diff --git a/cache.h b/cache.h
> index 3d3244b..65505d1 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -922,15 +922,21 @@ struct object_context {
>  	unsigned char tree[20];
>  	char path[PATH_MAX];
>  	unsigned mode;
> +	/*
> +	 * symlink_path is only used by get_tree_entry_follow_symlinks,
> +	 * and only for symlinks that point outside the repository.
> +	 */
> +	struct strbuf symlink_path;
>  };
>...
> @@ -1469,5 +1477,7 @@ void maybe_die_on_misspelt_object_name(const char *name, const char *prefix)
>  
>  int get_sha1_with_context(const char *str, unsigned flags, unsigned char *sha1, struct object_context *orc)
>  {
> +	if (flags & GET_SHA1_FOLLOW_SYMLINKS && flags & GET_SHA1_ONLY_TO_DIE)
> +		die("BUG: incompatible flags for get_sha1_with_context");
>  	return get_sha1_with_context_1(str, flags, NULL, sha1, orc);
>  }

Looks good; thanks.
