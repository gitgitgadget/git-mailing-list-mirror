Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1C5D51FC44
	for <e@80x24.org>; Mon, 13 Feb 2017 20:58:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1753233AbdBMU6l (ORCPT <rfc822;e@80x24.org>);
        Mon, 13 Feb 2017 15:58:41 -0500
Received: from avasout02.plus.net ([212.159.14.17]:34207 "EHLO
        avasout02.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753062AbdBMU6k (ORCPT <rfc822;git@vger.kernel.org>);
        Mon, 13 Feb 2017 15:58:40 -0500
Received: from [10.0.2.15] ([146.90.175.113])
        by avasout02 with smtp
        id kLyd1u00C2TAAPE01Lye6i; Mon, 13 Feb 2017 20:58:39 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.2 cv=F9YnTupN c=1 sm=1 tr=0
 a=xPbQrKg7pJ/t022iV9eLWw==:117 a=xPbQrKg7pJ/t022iV9eLWw==:17
 a=IkcTkHD0fZMA:10 a=pGLkceISAAAA:8 a=Ym66rJlgl9hrx2s2FWYA:9 a=QEXdDO2ut3YA:10
 a=6kGIvZw6iX1k4Y-7sg4_:22
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 04/11] files-backend: replace *git_path*() with
 files_path()
To:     =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
        <pclouds@gmail.com>, git@vger.kernel.org
References: <20170213152011.12050-1-pclouds@gmail.com>
 <20170213152011.12050-5-pclouds@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        Michael Haggerty <mhagger@alum.mit.edu>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        sbeller@google.com, novalis@novalis.org
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <8f6e09aa-f578-6faf-6acc-e35be71ee990@ramsayjones.plus.com>
Date:   Mon, 13 Feb 2017 20:58:37 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:45.0) Gecko/20100101
 Thunderbird/45.7.0
MIME-Version: 1.0
In-Reply-To: <20170213152011.12050-5-pclouds@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8bit
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 13/02/17 15:20, Nguyễn Thái Ngọc Duy wrote:
> This centralizes all path rewriting of files-backend.c in one place so
> we have easier time removing the path rewriting later. There could be
> some hidden indirect git_path() though, I didn't audit the code to the
> bottom.
> 
> Side note: set_worktree_head_symref() is a bad boy and should not be in
> files-backend.c (probably should not exist in the first place). But
> we'll leave it there until we have better multi-worktree support in refs
> before we update it.
> 
> Signed-off-by: Nguyễn Thái Ngọc Duy <pclouds@gmail.com>
> ---
>  refs/files-backend.c | 193 ++++++++++++++++++++++++++-------------------------
>  1 file changed, 98 insertions(+), 95 deletions(-)
> 
> diff --git a/refs/files-backend.c b/refs/files-backend.c
> index 39217a2ca..c69e4fe84 100644
> --- a/refs/files-backend.c
> +++ b/refs/files-backend.c
> @@ -165,12 +165,13 @@ static struct ref_entry *create_dir_entry(struct files_ref_store *ref_store,
>  					  const char *dirname, size_t len,
>  					  int incomplete);
>  static void add_entry_to_dir(struct ref_dir *dir, struct ref_entry *entry);
> -static int files_log_ref_write(const char *refname, const unsigned char *old_sha1,
> +static int files_log_ref_write(struct files_ref_store *refs,
> +			       const char *refname, const unsigned char *old_sha1,
>  			       const unsigned char *new_sha1, const char *msg,
>  			       int flags, struct strbuf *err);
>  
> -void files_path(struct files_ref_store *refs, struct strbuf *sb,
> -		const char *fmt, ...) __attribute__((format (printf, 3, 4)));

You only added this in the last commit, so maybe mark it static in
the previous patch! Also, just in case you were wondering, the 'Why?'
of the previous email was, "Why do you need this forward declaration?"
(hint: you don't ;-)

> +static void files_path(struct files_ref_store *refs, struct strbuf *sb,
> +		       const char *fmt, ...) __attribute__((format (printf, 3, 4)));
>  
>  static struct ref_dir *get_ref_dir(struct ref_entry *entry)
>  {
> @@ -933,8 +934,8 @@ struct files_ref_store {
>  /* Lock used for the main packed-refs file: */
>  static struct lock_file packlock;
>  
> -void files_path(struct files_ref_store *refs, struct strbuf *sb,
> -		const char *fmt, ...)
> +static void files_path(struct files_ref_store *refs, struct strbuf *sb,
> +		       const char *fmt, ...)
>  {
>  	struct strbuf tmp = STRBUF_INIT;
>  	va_list vap;

ATB,
Ramsay Jones

