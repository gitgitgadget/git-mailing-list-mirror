Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1B49A1FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:43:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753167AbdBMUnz (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:43:55 -0500
Received: from avasout02.plus.net ([212.159.14.17]:58787 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752127AbdBMUny (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:43:54 -0500
Received: from [10.0.2.15] ([146.90.175.113])
        by avasout02 with smtp
        id kLjm1u0012TAAPE01Ljnds; Mon, 13 Feb 2017 20:43:47 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=F9YnTupN c=1 sm=1 tr=0
 a=xPbQrKg7pJ/t022iV9eLWw==:117 a=xPbQrKg7pJ/t022iV9eLWw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Z8O4IJeI1ghXi98fkIkA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 03/11] files-backend: add files_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170213152011.12050-4-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <efab3ec2-e7c6-595a-8781-699bdc685a26@ramsayjones.plus.com>
Date:   Mon, 13 Feb 2017 20:43:46 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170213152011.12050-4-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/02/17 15:20, Nguyễn Thái Ngọc Duy wrote:
> This will be the replacement for both git_path() and git_path_submodule()
> in this file. The idea is backend takes a git path and use that,
> oblivious of submodule, linked worktrees and such.
> 
> This is the middle step towards that. Eventually the "submodule" field
> in 'struct files_ref_store' should be replace by "gitdir". And a
> compound ref_store is created to combine two files backends together,
> one represents the shared refs in $GIT_COMMON_DIR, one per-worktree. At
> that point, files_path() becomes a wrapper of strbuf_vaddf().
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 20 ++++++++++++++++++++
>  1 file changed, 20 insertions(+)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 6582c9b2d..39217a2ca 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -169,6 +169,9 @@ static int files_log_ref_write(const char *refname, const unsigned char *old_sha
>  			       const unsigned char *new_sha1, const char *msg,
>  			       int flags, struct strbuf *err);
>  
> +void files_path(struct files_ref_store *refs, struct strbuf *sb,
> +		const char *fmt, ...) __attribute__((format (printf, 3, 4)));
> +

Why?

>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  {
>  	struct ref_dir *dir;
> @@ -930,6 +933,23 @@ struct files_ref_store {
>  /* Lock used for the main packed-refs file: */
>  static struct lock_file packlock;
>  
> +void files_path(struct files_ref_store *refs, struct strbuf *sb,
> +		const char *fmt, ...)
> +{
> +	struct strbuf tmp = STRBUF_INIT;
> +	va_list vap;
> +
> +	va_start(vap, fmt);
> +	strbuf_vaddf(&tmp, fmt, vap);
> +	va_end(vap);
> +	if (refs->submodule)
> +		strbuf_git_path_submodule(sb, refs->submodule,
> +					  "%s", tmp.buf);
> +	else
> +		strbuf_git_path(sb, "%s", tmp.buf);
> +	strbuf_release(&tmp);
> +}
> +
>  /*
>   * Increment the reference count of *packed_refs.
>   */
> 

ATB,
Ramsay Jones


