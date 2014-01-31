From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH v3 3/4] setup: Add 'abspath_part_inside_repo' function
Date: Fri, 31 Jan 2014 23:37:29 +0100
Message-ID: <52EC25A9.1050807@web.de>
References: <1390781250-20389-2-git-send-email-martinerikwerner@gmail.com> <20140131202248.GD9731@mule>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: richih@debian.org, gitster@pobox.com, tboegi@web.de,
	pclouds@gmail.com
To: Martin Erik Werner <martinerikwerner@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 31 23:37:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W9MiW-0007If-1E
	for gcvg-git-2@plane.gmane.org; Fri, 31 Jan 2014 23:37:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933108AbaAaWhj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 31 Jan 2014 17:37:39 -0500
Received: from mout.web.de ([212.227.17.11]:59079 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932271AbaAaWhi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 31 Jan 2014 17:37:38 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LfAwe-1VThEV0RLs-00opT0 for <git@vger.kernel.org>;
 Fri, 31 Jan 2014 23:37:35 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <20140131202248.GD9731@mule>
X-Provags-ID: V03:K0:YTKxehlQzaVF4RtEgQBYs2bxraZgAigV/MeMdhdScQxG8iWK8HS
 S0wfeSj/gMCwo8rEs5vVdBVEXNotDVAEjqGNudz+txc6Sp77g4ydq1k02fPrDrxuh48SgQX
 t0v8dvITzJkIpj7fZ+lbZjIJluVS9LGJjgW3u6zZRdQmIG1LLKMJZKdEzKAJYLEIKLNlNom
 SmX9haMYFHvHaLyrRs7wg==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241322>

On 2014-01-31 21.22, Martin Erik Werner wrote:
> In order to extract the part of an absolute path which lies inside the
> repo, it is not possible to directly use real_path, since that would
> dereference symlinks both outside and inside the work tree.
>
> Add an 'abspath_part_inside_repo' function which incrementally checks
> each path level by temporarily NUL-terminating at each '/' and comparing
> against the work tree path. When a match is found, it copies the
> remainder (which will be the in-repo part) to a destination
> buffer.
>
> The path being the filesystem root or exactly equal to the work tree are
> special cases handled separately, since then there is no directory
> separator between the work tree and in-repo part.
>
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  cache.h |  1 +
>  setup.c | 63 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 64 insertions(+)
>
> diff --git a/cache.h b/cache.h
> index ce377e1..242f27d 100644
> --- a/cache.h
> +++ b/cache.h
> @@ -426,6 +426,7 @@ extern void verify_filename(const char *prefix,
>  			    int diagnose_misspelt_rev);
>  extern void verify_non_filename(const char *prefix, const char *name);
>  extern int path_inside_repo(const char *prefix, const char *path);
> +extern int abspath_part_inside_repo(char *dst, const char *path);
abspath_part_inside_repo() is only used in setup.c, isn't it?
In this case we don't need it in cache.h, it can be declared inside setup.c as

static int abspath_part_inside_repo(char *dst, const char *path);
(or "static inline" )

-----------------
(And not in this patch: see the final setup.c:)

        if (g) {
            free(npath);
            return NULL;
        }

If this is the only caller of abspath_part_inside_repo(),
then  do we need npath 2 times as a parameter ?
Or can we re-write it to look like this:

static inline int abspath_part_inside_repo(char *path)
[
]
