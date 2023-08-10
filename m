Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97168C04A94
	for <git@archiver.kernel.org>; Thu, 10 Aug 2023 20:32:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235583AbjHJUcS (ORCPT <rfc822;git@archiver.kernel.org>);
        Thu, 10 Aug 2023 16:32:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234597AbjHJUcR (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 10 Aug 2023 16:32:17 -0400
Received: from pb-smtp21.pobox.com (pb-smtp21.pobox.com [173.228.157.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996EF2737
        for <git@vger.kernel.org>; Thu, 10 Aug 2023 13:32:15 -0700 (PDT)
Received: from pb-smtp21.pobox.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 37FA21E426;
        Thu, 10 Aug 2023 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=U7nVMb/MJc3EUwleBeVkFP3p9dzfRUhieHN6Vc
        rmFvM=; b=cgShXJubDH0Fy/NVOXMgDBxZcSfAJ4KK8NtR1/rWY4mLlv3IjoB2yJ
        eTHA58Ex2a2ghf3pTxHg/Gr0fBpAqLnZ/sM2GhGIINIZEAAqi4/RkXe9/efPnIW6
        xFfA73Oe6HksoAa0ulH7K76y3u0Lj85Rq3DmTmHfzkmG/fGJEKYpU=
Received: from pb-smtp21.sea.icgroup.com (unknown [127.0.0.1])
        by pb-smtp21.pobox.com (Postfix) with ESMTP id 2FE101E425;
        Thu, 10 Aug 2023 16:32:15 -0400 (EDT)
        (envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.83.58.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by pb-smtp21.pobox.com (Postfix) with ESMTPSA id D094B1E424;
        Thu, 10 Aug 2023 16:32:11 -0400 (EDT)
        (envelope-from junio@pobox.com)
From:   Junio C Hamano <gitster@pobox.com>
To:     Calvin Wan <calvinwan@google.com>
Cc:     git@vger.kernel.org, nasamuffin@google.com, chooglen@google.com,
        jonathantanmy@google.com, linusa@google.com,
        phillip.wood123@gmail.com, vdye@github.com
Subject: Re: [RFC PATCH v2 2/7] object: move function to object.c
References: <20230810163346.274132-1-calvinwan@google.com>
        <20230810163654.275023-2-calvinwan@google.com>
Date:   Thu, 10 Aug 2023 13:32:10 -0700
In-Reply-To: <20230810163654.275023-2-calvinwan@google.com> (Calvin Wan's
        message of "Thu, 10 Aug 2023 16:36:49 +0000")
Message-ID: <xmqqy1iir645.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.2 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: FC24D534-37BC-11EE-A548-B31D44D1D7AA-77302942!pb-smtp21.pobox.com
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Calvin Wan <calvinwan@google.com> writes:

> While remove_or_warn() is a simple ternary operator to call two other
> wrapper functions, it creates an unnecessary dependency to object.h in
> wrapper.c. Therefore move the function to object.[ch] where the concept
> of GITLINKs is first defined.

An untold assumption here is that we would want to make wrapper.[ch]
independent of Git's internals?

If so, where the thing is moved to (i.e. object.c) is much less
interesting than the fact that the goal of this function is to make
wrapper.[ch] less dependent on Git, so the title should reflect
that, no?

> +/*
> + * Calls the correct function out of {unlink,rmdir}_or_warn based on
> + * the supplied file mode.
> + */
> +int remove_or_warn(unsigned int mode, const char *path);

OK.  That "file mode" thing is not a regular "struct stat .st_mode",
but knows Git's internals, hence it makes sense to have it on our
side, not on the wrapper.[ch] side.  That makes sense.

>  #endif /* OBJECT_H */
> diff --git a/wrapper.c b/wrapper.c
> index 22be9812a7..118d3033de 100644
> --- a/wrapper.c
> +++ b/wrapper.c
> @@ -5,7 +5,6 @@
>  #include "abspath.h"
>  #include "config.h"
>  #include "gettext.h"
> -#include "object.h"
>  #include "repository.h"
>  #include "strbuf.h"
>  #include "trace2.h"
> @@ -647,11 +646,6 @@ int rmdir_or_warn(const char *file)
>  	return warn_if_unremovable("rmdir", file, rmdir(file));
>  }
>  
> -int remove_or_warn(unsigned int mode, const char *file)
> -{
> -	return S_ISGITLINK(mode) ? rmdir_or_warn(file) : unlink_or_warn(file);
> -}
> -
>  static int access_error_is_ok(int err, unsigned flag)
>  {
>  	return (is_missing_file_error(err) ||
> diff --git a/wrapper.h b/wrapper.h
> index c85b1328d1..272795f863 100644
> --- a/wrapper.h
> +++ b/wrapper.h
> @@ -111,11 +111,6 @@ int unlink_or_msg(const char *file, struct strbuf *err);
>   * not exist.
>   */
>  int rmdir_or_warn(const char *path);
> -/*
> - * Calls the correct function out of {unlink,rmdir}_or_warn based on
> - * the supplied file mode.
> - */
> -int remove_or_warn(unsigned int mode, const char *path);
>  
>  /*
>   * Call access(2), but warn for any error except "missing file"
