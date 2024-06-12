Received: from pb-smtp20.pobox.com (pb-smtp20.pobox.com [173.228.157.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBDCA17BA1
	for <git@vger.kernel.org>; Wed, 12 Jun 2024 01:54:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=173.228.157.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718157266; cv=none; b=LuKoZ943GVCW8JQAlkT27fcTSIE87WSNOck1vJXOmv24k2VuU64olCKVExj68frsFHGGfF6irvqrSVGjQkHzZViPQn+CXRLP1q39SZSBHaLKSQcNeB04QCRKB0ly//T+U8/BSdVsFGr/Hbo0RSIt7cak9Wu+oNrFYdztSWjErU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718157266; c=relaxed/simple;
	bh=4QtCAc6REHgA+qk/oxHkiRjSsL//qA6lcqe3b9wE+s0=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=FSZDmMeImqZOTWmBNkglfiB6kInsVMsK66sXzmMtbXcsCc911KTwwwr8jP9hyoegKYqE4IMkNzNBvJiguSC6FEtjtLwTMLAJZ+PbCWrTbdcpKpj4dBdqSx796Phchh4E66iuP8TWaNfyyY88QFEkGnSiL74mQmzeI7Pl+mLOQhM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com; spf=pass smtp.mailfrom=pobox.com; dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b=l7DTsD/I; arc=none smtp.client-ip=173.228.157.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=pobox.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pobox.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=pobox.com header.i=@pobox.com header.b="l7DTsD/I"
Received: from pb-smtp20.pobox.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 4081C299CF;
	Tue, 11 Jun 2024 21:54:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:in-reply-to:references:date:message-id:mime-version
	:content-type; s=sasl; bh=4QtCAc6REHgA+qk/oxHkiRjSsL//qA6lcqe3b9
	wE+s0=; b=l7DTsD/IRB5HvxpwdNX9kOZMQgr7DM5XH8JB6UyvluTvt4UUbsBUMP
	STOwoN4IeqvKGrXb4pGhAF2WZlchIrBf8ZG55d+UqYouz1fHgReeiSK+yFyi3Wxz
	Zd4HpO+a3ZiuFbHIpgaWjQK05ik/j8R36OBfSez7cKxLmuBbAAI9M=
Received: from pb-smtp20.sea.icgroup.com (unknown [127.0.0.1])
	by pb-smtp20.pobox.com (Postfix) with ESMTP id 39294299CE;
	Tue, 11 Jun 2024 21:54:24 -0400 (EDT)
	(envelope-from junio@pobox.com)
Received: from pobox.com (unknown [34.125.204.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by pb-smtp20.pobox.com (Postfix) with ESMTPSA id 561AF299C5;
	Tue, 11 Jun 2024 21:54:21 -0400 (EDT)
	(envelope-from junio@pobox.com)
From: Junio C Hamano <gitster@pobox.com>
To: "Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com>
Cc: git@vger.kernel.org,  Victoria Dye <vdye@github.com>
Subject: Re: [PATCH 06/16] index-info.c: parse object type in provided in
 read_index_info
In-Reply-To: <f56eee0b48da907a27edc99ca135cf8f6c19af35.1718130288.git.gitgitgadget@gmail.com>
	(Victoria Dye via GitGitGadget's message of "Tue, 11 Jun 2024 18:24:38
	+0000")
References: <pull.1746.git.1718130288.gitgitgadget@gmail.com>
	<f56eee0b48da907a27edc99ca135cf8f6c19af35.1718130288.git.gitgitgadget@gmail.com>
Date: Tue, 11 Jun 2024 18:54:19 -0700
Message-ID: <xmqqcyonrkms.fsf@gitster.g>
User-Agent: Gnus/5.13 (Gnus v5.13)
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID:
 AFD38BBA-285E-11EF-BC60-C38742FD603B-77302942!pb-smtp20.pobox.com

"Victoria Dye via GitGitGadget" <gitgitgadget@gmail.com> writes:

> From: Victoria Dye <vdye@github.com>
>
> If the object type (e.g. "blob", "tree") is identified on a stdin line read
> by 'read_index_info()' (i.e. on lines formatted like the output of 'git
> ls-tree'), parse it into an 'enum object_type' and provide it to the
> 'read_index_info()' callback as an argument. If the type is not provided,
> pass 'OBJ_NONE' instead. If the object type is invalid, return an error.

My recollection is, when we do not know what to expect, we tend to
use OBJ_ANY rather than OBJ_NONE as convention to signal that fact
(e.g., object-name.c:peel_to_type()).

As long as the code path this series touches is internally
consistent, using OBJ_NONE may not hurt but once they need to start
interacting with existing code paths that use OBJ_ANY for that
purpose, we may need to adjust one to match the other.

> The goal of this change is to allow for more thorough validation of the
> provided object type (e.g. against the provided mode) in 'mktree' once
> 'mktree_line' is replaced with 'read_index_info()'. Note, though, that this
> change also strengthens the validation done by 'update-index', since invalid
> type names now trigger an error.

Nice.

> Signed-off-by: Victoria Dye <vdye@github.com>
> ---
>  builtin/update-index.c        |  3 ++-
>  index-info.c                  | 16 ++++++++++++----
>  index-info.h                  |  3 ++-
>  t/t2107-update-index-basic.sh |  5 +++++
>  4 files changed, 21 insertions(+), 6 deletions(-)
>
> diff --git a/builtin/update-index.c b/builtin/update-index.c
> index b1b334807f8..8882433b644 100644
> --- a/builtin/update-index.c
> +++ b/builtin/update-index.c
> @@ -510,7 +510,8 @@ static void update_one(const char *path)
>  	report("add '%s'", path);
>  }
>  
> -static int apply_index_info(unsigned int mode, struct object_id *oid, int stage,
> +static int apply_index_info(unsigned int mode, struct object_id *oid,
> +			    enum object_type obj_type UNUSED, int stage,
>  			    const char *path_name, void *cbdata UNUSED)
>  {
>  	if (!verify_path(path_name, mode)) {
> diff --git a/index-info.c b/index-info.c
> index 735cbf1f476..5d61e61e28f 100644
> --- a/index-info.c
> +++ b/index-info.c
> @@ -18,6 +18,7 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
>  		char *ptr, *tab;
>  		char *path_name;
>  		struct object_id oid;
> +		enum object_type obj_type = OBJ_NONE;
>  		unsigned int mode;
>  		unsigned long ul;
>  		int stage;
> @@ -56,18 +57,17 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
>  
>  		if (tab[-2] == ' ' && '0' <= tab[-1] && tab[-1] <= '3') {
>  			stage = tab[-1] - '0';
> -			ptr = tab + 1; /* point at the head of path */
> +			path_name = tab + 1; /* point at the head of path */
>  			tab = tab - 2; /* point at tail of sha1 */
>  		} else {
>  			stage = 0;
> -			ptr = tab + 1; /* point at the head of path */
> +			path_name = tab + 1; /* point at the head of path */
>  		}
>  
>  		if (get_oid_hex(tab - hexsz, &oid) ||
>  			tab[-(hexsz + 1)] != ' ')
>  			goto bad_line;
>  
> -		path_name = ptr;
>  		if (!nul_term_line && path_name[0] == '"') {
>  			strbuf_reset(&uq);
>  			if (unquote_c_style(&uq, path_name, NULL)) {
> @@ -77,7 +77,15 @@ int read_index_info(int nul_term_line, each_index_info_fn fn, void *cbdata)
>  			path_name = uq.buf;
>  		}
>  
> -		ret = fn(mode, &oid, stage, path_name, cbdata);
> +		/* Get the type, if provided */
> +		if (tab - hexsz - 1 > ptr + 1) {
> +			if (*(tab - hexsz - 1) != ' ')
> +				goto bad_line;
> +			*(tab - hexsz - 1) = '\0';
> +			obj_type = type_from_string(ptr + 1);
> +		}
> +
> +		ret = fn(mode, &oid, obj_type, stage, path_name, cbdata);
>  		if (ret) {
>  			ret = -1;
>  			break;
> diff --git a/index-info.h b/index-info.h
> index 1884972021d..767cf304213 100644
> --- a/index-info.h
> +++ b/index-info.h
> @@ -2,8 +2,9 @@
>  #define INDEX_INFO_H
>  
>  #include "hash.h"
> +#include "object.h"
>  
> -typedef int (*each_index_info_fn)(unsigned int, struct object_id *, int, const char *, void *);
> +typedef int (*each_index_info_fn)(unsigned int, struct object_id *, enum object_type, int, const char *, void *);
>  
>  #define INDEX_INFO_EMPTY_LINE 1
>  
> diff --git a/t/t2107-update-index-basic.sh b/t/t2107-update-index-basic.sh
> index 29696ade0d0..9c19d24cd4a 100755
> --- a/t/t2107-update-index-basic.sh
> +++ b/t/t2107-update-index-basic.sh
> @@ -153,6 +153,11 @@ test_expect_success '--index-info fails on malformed input' '
>  	test_must_fail git update-index --index-info 2>err &&
>  	grep "malformed input line" err &&
>  
> +	# invalid type
> +	printf "100644 bad $EMPTY_BLOB\tA" |
> +	test_must_fail git update-index --index-info 2>err &&
> +	grep "invalid object type" err &&
> +
>  	# invalid stage value
>  	printf "100644 $EMPTY_BLOB 5\tA" |
>  	test_must_fail git update-index --index-info 2>err &&
