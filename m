Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 648011F453
	for <e@80x24.org>; Tue,  6 Nov 2018 15:54:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389065AbeKGBUk (ORCPT <rfc822;e@80x24.org>);
        Tue, 6 Nov 2018 20:20:40 -0500
Received: from avasout03.plus.net ([84.93.230.244]:51110 "EHLO
        avasout03.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389044AbeKGBUk (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 6 Nov 2018 20:20:40 -0500
Received: from [10.0.2.15] ([80.189.70.193])
        by smtp with ESMTPA
        id K3glgxaGGd3rWK3gmg09S7; Tue, 06 Nov 2018 15:54:48 +0000
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=Uv9Nyd4B c=1 sm=1 tr=0
 a=wSR+GDtF+fsrIzE5OYgxVg==:117 a=wSR+GDtF+fsrIzE5OYgxVg==:17
 a=IkcTkHD0fZMA:10 a=ikcUr5-O2QTVsThrSaQA:9 a=QEXdDO2ut3YA:10 a=fAsHhm-Fa0MA:10
X-AUTH: ramsayjones@:2500
Subject: Re: [PATCH 1/1] mingw: handle absolute paths in expand_user_path()
To:     Johannes Schindelin via GitGitGadget <gitgitgadget@gmail.com>,
        git@vger.kernel.org
Cc:     Junio C Hamano <gitster@pobox.com>,
        Johannes Schindelin <johannes.schindelin@gmx.de>
References: <pull.66.git.gitgitgadget@gmail.com>
 <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Message-ID: <9174a750-3498-c2fc-d7fa-29c1926c95fc@ramsayjones.plus.com>
Date:   Tue, 6 Nov 2018 15:54:47 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.2.1
MIME-Version: 1.0
In-Reply-To: <2287dd96cf0b9e9e250fdf92a32dcf666510e67d.1541515994.git.gitgitgadget@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfGnv/0yOwlxBX8h9+KGuaxxpdFJlqeccF9DFedFax2tb9zsMXZybyR8OZfRntYW41SNTZTxI387sCC2LeGxclc65s49OkVBX6y5kYX7RSe4NTKGH/3PL
 E8QAPGiA9mgscz80DoUjMrVJ3BRurfZbZ/vHxHq0oqqAiQsIKi0juHWohQARQZ6yc0LOFcFmM3Y4WA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org



On 06/11/2018 14:53, Johannes Schindelin via GitGitGadget wrote:
> From: Johannes Schindelin <johannes.schindelin@gmx.de>
> 
> On Windows, an absolute POSIX path needs to be turned into a Windows
> one.
> 
> Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
> ---
>  path.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/path.c b/path.c
> index 34f0f98349..a72abf0e1f 100644
> --- a/path.c
> +++ b/path.c
> @@ -11,6 +11,7 @@
>  #include "path.h"
>  #include "packfile.h"
>  #include "object-store.h"
> +#include "exec-cmd.h"
>  
>  static int get_st_mode_bits(const char *path, int *mode)
>  {
> @@ -709,6 +710,10 @@ char *expand_user_path(const char *path, int real_home)
>  
>  	if (path == NULL)
>  		goto return_null;
> +#ifdef __MINGW32__
> +	if (path[0] == '/')
> +		return system_path(path + 1);
> +#endif

Hmm, this doesn't quite fit with the intended use of this
function! ;-) (even on windows!)

I haven't looked very deeply, but doesn't this affect all
absolute paths in the config read by git_config_pathname(),
along with all 'included config' files?

I am pretty sure that I would not want the absolute paths
in my config file(s) magically 'moved' depending on whether
git has been compiled with 'runtime prefix' support or not!

ATB,
Ramsay Jones

>  	if (path[0] == '~') {
>  		const char *first_slash = strchrnul(path, '/');
>  		const char *username = path + 1;
> 
