From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 18/18] git receive-pack: support excluding objects from fsck'ing
Date: Wed, 10 Dec 2014 10:23:25 -0800
Message-ID: <xmqqvbljgy8y.fsf@gitster.dls.corp.google.com>
References: <cover.1418055173.git.johannes.schindelin@gmx.de>
	<bafa42210f8885335aeacac41a81380a9a7eef24.1418055173.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Johannes Schindelin <johannes.schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 10 19:23:33 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XylvA-0008N5-D3
	for gcvg-git-2@plane.gmane.org; Wed, 10 Dec 2014 19:23:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932707AbaLJSX2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Dec 2014 13:23:28 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:50040 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932414AbaLJSX1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Dec 2014 13:23:27 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id D731822CE8;
	Wed, 10 Dec 2014 13:23:26 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=jTnYP9Pu2b7W+5+ERvSYbtVpU18=; b=DRbU6J
	argtGSrlenuK9dAKskGMM0ILM2NDIQ4cu/K10iSUqb5mODCl8Di2dcojcOXUz9VD
	sZtF3AcOyJj2/2ucVG7nUsolfiR0jJYDw6qBkY3s3OJOr7MskwYtPpwivbYtOowr
	Cr3ko2sWbmEW7DFCgz22Opteia+dXvFCowbTU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=llzYI+6TYxEgVP/iALa7m24XEVeTIuni
	yOne4tO7xezZOL/Qt1tRMy6bSzdoBiKPag+EG4y1HeFLXkzGAgPO9/xFZzeE5Dce
	egk4wzw+y/qbSM2+L7lz83oaGfWaXblLUPRR0fPsVeFUdZApf7hQgNXa+GMW/9Xp
	hyEWynBbDDw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id CDD9322CE7;
	Wed, 10 Dec 2014 13:23:26 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 5382922CE5;
	Wed, 10 Dec 2014 13:23:26 -0500 (EST)
In-Reply-To: <bafa42210f8885335aeacac41a81380a9a7eef24.1418055173.git.johannes.schindelin@gmx.de>
	(Johannes Schindelin's message of "Mon, 8 Dec 2014 17:15:40 +0100
	(CET)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: A1F56E18-8099-11E4-BDC9-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/261235>

Johannes Schindelin <johannes.schindelin@gmx.de> writes:

> The optional new config option `receive.fsck.skip-list` specifies the path
> to a file listing the names, i.e. SHA-1s, one per line, of objects that
> are to be ignored by `git receive-pack` when `receive.fsckObjects = true`.
>
> This is extremely handy in case of legacy repositories where it would
> cause more pain to change incorrect objects than to live with them
> (e.g. a duplicate 'author' line in an early commit object).
>
> The intended use case is for server administrators to inspect objects
> that are reported by `git push` as being too problematic to enter the
> repository, and to add the objects' SHA-1 to a (preferably sorted) file
> when the objects are legitimate, i.e. when it is determined that those
> problematic objects should be allowed to enter the server.
>
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  builtin/receive-pack.c          |  9 +++++++
>  fsck.c                          | 59 +++++++++++++++++++++++++++++++++++++++--
>  fsck.h                          |  2 ++
>  t/t5504-fetch-receive-strict.sh | 12 +++++++++
>  4 files changed, 80 insertions(+), 2 deletions(-)
>
> diff --git a/builtin/receive-pack.c b/builtin/receive-pack.c
> index 111e514..5169f1f 100644
> --- a/builtin/receive-pack.c
> +++ b/builtin/receive-pack.c
> @@ -110,6 +110,15 @@ static int receive_pack_config(const char *var, const char *value, void *cb)
>  		return 0;
>  	}
>  
> +	if (starts_with(var, "receive.fsck.skip-list")) {

s/skip-list/skiplist/;

> +		const char *path = is_absolute_path(value) ?
> +			value : git_path("%s", value);
> +		if (fsck_strict_mode.len)
> +			strbuf_addch(&fsck_strict_mode, ',');
> +		strbuf_addf(&fsck_strict_mode, "skip-list=%s", path);
> +		return 0;
> +	}
> +
>  	if (starts_with(var, "receive.fsck.")) {
>  		if (fsck_strict_mode.len)
>  			strbuf_addch(&fsck_strict_mode, ',');
> diff --git a/fsck.c b/fsck.c
> index 154f361..00693f2 100644
> --- a/fsck.c
> +++ b/fsck.c
> @@ -7,6 +7,7 @@
>  #include "tag.h"
>  #include "fsck.h"
>  #include "refs.h"
> +#include "sha1-array.h"
>  
>  #define FOREACH_MSG_ID(FUNC) \
>  	/* fatal errors */ \
> @@ -56,7 +57,9 @@
>  	FUNC(ZERO_PADDED_FILEMODE) \
>  	/* infos (reported as warnings, but ignored by default) */ \
>  	FUNC(INVALID_TAG_NAME) \
> -	FUNC(MISSING_TAGGER_ENTRY)
> +	FUNC(MISSING_TAGGER_ENTRY) \
> +	/* special value */ \
> +	FUNC(SKIP_LIST)

This feels like a kludge to me without comment on what "special
value" means.  Does it mean "this object has an error (which by
default is ignored) of being on the skip list?"  Should we be able
to optionally warn an object on the skip-list exists with the same
mechansim the rest of the series uses to tweak the error level?
