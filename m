From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 14/18] fsck: allow upgrading fsck warnings to errors
Date: Wed, 10 Dec 2014 10:08:51 -0800
Message-ID: <xmqq4mt3idho.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:09:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xylh4-0000et-Jr
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:08:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932612AbaLJSIy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:08:54 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:63746 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932479AbaLJSIy (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:08:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 599D222906;
	Wed, 10 Dec 2014 13:08:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=GQ08CCmMHt4A7uulyhykyqUx1r0=; b=Z5kIe+
	NKv+/StHJFx2aF8hPumJdfYVyJo6mTtk9UTkf6oC8HST90OfhOVk03O3xJkNExFI
	kjlz+P2ImobsVugqEEwVsPe3/XmDr+cnld3lNIlmr9L0NFi/ba3vR4IgdSWprMXp
	+x7DBkjbpXzS0NkYupIMwo9RcFFT5946t9UUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Npr04qJvUqeDRocYQJkMl2MJnhScu1vQ
	PxSQxKAhrZwJ3IqlIlbBdRdO5zLsW2uumbcJf8xrB95c0Z62IMnFCnAFoX83I9OS
	FLYJcQVfDHquuTPdAX96+Jt2qzO5RjKGbPS/JpiZgMPiB02+XbhE2rFbFS31Ucul
	GeQvZ0KgdU4=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5006222905;
	Wed, 10 Dec 2014 13:08:53 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 79CC022904;
	Wed, 10 Dec 2014 13:08:52 -0500 (EST)
In-Reply-To: <c70409e8e6a42bdc7cacd19cbd49d5d1adbedd1a.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:25 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 991B2CD0-8097-11E4-A545-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261232>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The 'invalid tag name' and 'missing tagger entry' warnings can now be
> upgraded to errors by setting receive.fsck.invalid-tag-name and
> receive.fsck.missing-tagger-entry to 'error'.

Hmm, why can't all warnings promotable to errors, or are the above
two mentioned only as examples?

>
> Incidentally, the missing tagger warning is now really shown as a warning
> (as opposed to being reported with the "error:" prefix, as it used to be
> the case before this commit).
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  fsck.c                | 24 ++++++++++++++++--------
>  t/t5302-pack-index.sh |  2 +-
>  2 files changed, 17 insertions(+), 9 deletions(-)
>
> diff --git a/fsck.c b/fsck.c
> index abfd3af..154f361 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -52,13 +52,15 @@
>  	FUNC(HAS_DOT) \
>  	FUNC(HAS_DOTDOT) \
>  	FUNC(HAS_DOTGIT) \
> -	FUNC(INVALID_TAG_NAME) \
> -	FUNC(MISSING_TAGGER_ENTRY) \
>  	FUNC(NULL_SHA1) \
> -	FUNC(ZERO_PADDED_FILEMODE)
> +	FUNC(ZERO_PADDED_FILEMODE) \
> +	/* infos (reported as warnings, but ignored by default) */ \
> +	FUNC(INVALID_TAG_NAME) \
> +	FUNC(MISSING_TAGGER_ENTRY)
>  
>  #define FIRST_NON_FATAL_ERROR FSCK_MSG_BAD_DATE
>  #define FIRST_WARNING FSCK_MSG_BAD_FILEMODE
> +#define FIRST_INFO FSCK_MSG_INVALID_TAG_NAME
>  
>  #define MSG_ID(x) FSCK_MSG_##x,
>  enum fsck_msg_id {
> @@ -103,7 +105,7 @@ int fsck_msg_type(enum fsck_msg_id msg_id, struct fsck_options *options)
>  	if (options->strict_mode && msg_id >= 0 && msg_id < FSCK_MSG_MAX)
>  		return options->strict_mode[msg_id];
>  	if (options->strict)
> -		return FSCK_ERROR;
> +		return msg_id < FIRST_INFO ? FSCK_ERROR : FSCK_WARN;
>  	return msg_id < FIRST_WARNING ? FSCK_ERROR : FSCK_WARN;
>  }
>  
> @@ -643,13 +645,19 @@ static int fsck_tag_buffer(struct tag *tag, const char *data,
>  		goto done;
>  	}
>  	strbuf_addf(&sb, "refs/tags/%.*s", (int)(eol - buffer), buffer);
> -	if (check_refname_format(sb.buf, 0))
> -		report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME, "invalid 'tag' name: %s", buffer);
> +	if (check_refname_format(sb.buf, 0)) {
> +		ret = report(options, &tag->object, FSCK_MSG_INVALID_TAG_NAME, "invalid 'tag' name: %s", buffer);
> +		if (ret)
> +			goto done;
> +	}
>  	buffer = eol + 1;
>  
> -	if (!skip_prefix(buffer, "tagger ", &buffer))
> +	if (!skip_prefix(buffer, "tagger ", &buffer)) {
>  		/* early tags do not contain 'tagger' lines; warn only */
> -		report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
> +		ret = report(options, &tag->object, FSCK_MSG_MISSING_TAGGER_ENTRY, "invalid format - expected 'tagger' line");
> +		if (ret)
> +			goto done;
> +	}
>  	else
>  		ret = fsck_ident(&buffer, &tag->object, options);
>  
> diff --git a/t/t5302-pack-index.sh b/t/t5302-pack-index.sh
> index 61bc8da..3dc5ec4 100755
> --- a/t/t5302-pack-index.sh
> +++ b/t/t5302-pack-index.sh
> @@ -259,7 +259,7 @@ EOF
>      thirtyeight=${tag#??} &&
>      rm -f .git/objects/${tag%$thirtyeight}/$thirtyeight &&
>      git index-pack --strict tag-test-${pack1}.pack 2>err &&
> -    grep "^error:.* expected .tagger. line" err
> +    grep "^warning:.* expected .tagger. line" err
>  '
>  
>  test_done
