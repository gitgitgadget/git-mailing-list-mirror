From: =?ISO-8859-15?Q?Ren=E9_Scharfe?= <l.s.r@web.de>
Subject: Re: [[RFC memory leak, v.2]] Minor memory leak fix
Date: Tue, 11 Mar 2014 20:40:07 +0100
Message-ID: <531F6697.1030703@web.de>
References: <CACsJy8Bp6rpe4hLg0eMBCjPjL5uDwXj-7ZVmZtUZvR26unAuoQ@mail.gmail.com> <1394541371-2960-1-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Tue Mar 11 20:41:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNSYK-0003QH-2U
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 20:41:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755477AbaCKTlR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 15:41:17 -0400
Received: from mout.web.de ([212.227.17.12]:59840 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755472AbaCKTlO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 15:41:14 -0400
Received: from [192.168.178.27] ([79.250.161.106]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LsyRS-1XKLVC2cQM-012b7T; Tue, 11 Mar 2014 20:41:12
 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <1394541371-2960-1-git-send-email-iveqy@iveqy.com>
X-Provags-ID: V03:K0:DBxSa/ItsFtq+YCtTJKJ1eQcZ70btD+0UivKy7ZZMukMhTzER8n
 MdQvc8k0rkiDifRVcNWTEe8UC1KmmWkryC6Dqpk7EBq7zbg1whWLWFc9dkAVNroEmAcatY9
 UYLnNoBGZbqp7u0J05GRDsaguIx0qDEeY2AtZBIKdXDmeo96g1O/VUF+938TdtRQpNpbSTl
 praEG6WCoRlkXHRc65FOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243884>

Am 11.03.2014 13:36, schrieb Fredrik Gustafsson:
> Strbuf needs to be released even if it's locally declared.
>
> Signed-off-by: Fredrik Gustafsson <iveqy@iveqy.com>
> ---
>   archive.c | 16 ++++++++++------
>   1 file changed, 10 insertions(+), 6 deletions(-)
>
> diff --git a/archive.c b/archive.c
> index 346f3b2..dfc557d 100644
> --- a/archive.c
> +++ b/archive.c
> @@ -113,6 +113,7 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>   	struct git_attr_check check[2];
>   	const char *path_without_prefix;
>   	int err;
> +	int to_ret = 0;
>
>   	args->convert = 0;
>   	strbuf_reset(&path);
> @@ -127,22 +128,25 @@ static int write_archive_entry(const unsigned char *sha1, const char *base,
>   	setup_archive_check(check);
>   	if (!git_check_attr(path_without_prefix, ARRAY_SIZE(check), check)) {
>   		if (ATTR_TRUE(check[0].value))
> -			return 0;
> +			goto cleanup;
>   		args->convert = ATTR_TRUE(check[1].value);
>   	}
>
>   	if (S_ISDIR(mode) || S_ISGITLINK(mode)) {
>   		if (args->verbose)
>   			fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -		err = write_entry(args, sha1, path.buf, path.len, mode);
> -		if (err)
> -			return err;
> -		return (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +		to_ret = write_entry(args, sha1, path.buf, path.len, mode);
> +		if (!to_ret)
> +			to_ret = (S_ISDIR(mode) ? READ_TREE_RECURSIVE : 0);
> +		goto cleanup;

Why add to_ret when you can use the existing variable err directly?  Or 
at least remove it when it's not used anymore.

>   	}
>
>   	if (args->verbose)
>   		fprintf(stderr, "%.*s\n", (int)path.len, path.buf);
> -	return write_entry(args, sha1, path.buf, path.len, mode);
> +	to_ret = write_entry(args, sha1, path.buf, path.len, mode);
> +cleanup:
> +	strbuf_release(&path);
> +	return to_ret;

If you free the memory of the strbuf at the end of the function then 
there is no point in keeping it static anymore.  Growing it to PATH_MAX 
also doesn't make as much sense as before then.

The patch makes git archive allocate and free the path strbuf once per 
archive entry, while before it allocated only once per run and left 
freeing to the OS.  What's the performance impact of this change?

>   }
>
>   int write_archive_entries(struct archiver_args *args,
>
