From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: Re: [PATCH 2/2] setup: Don't dereference in-tree symlinks for absolute
 paths
Date: Sun, 26 Jan 2014 18:19:25 +0100
Message-ID: <52E5439D.7060002@web.de>
References: <20140115124859.GA4283@mule> <1390746146-9478-1-git-send-email-martinerikwerner@gmail.com> <1390746146-9478-3-git-send-email-martinerikwerner@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: richih@debian.org
To: Martin Erik Werner <martinerikwerner@gmail.com>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jan 26 18:19:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W7TMu-0002P0-P3
	for gcvg-git-2@plane.gmane.org; Sun, 26 Jan 2014 18:19:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752602AbaAZRTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 26 Jan 2014 12:19:33 -0500
Received: from mout.web.de ([212.227.17.11]:57626 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752365AbaAZRTc (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 26 Jan 2014 12:19:32 -0500
Received: from [192.168.209.26] ([78.72.74.102]) by smtp.web.de (mrweb103)
 with ESMTPSA (Nemesis) id 0LkPjj-1VatNB2OgF-00cTKA for <git@vger.kernel.org>;
 Sun, 26 Jan 2014 18:19:30 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:24.0) Gecko/20100101 Thunderbird/24.2.0
In-Reply-To: <1390746146-9478-3-git-send-email-martinerikwerner@gmail.com>
X-Provags-ID: V03:K0:Jnrv2KBBh8OKbMTGdWzgEyPr3J3koHjO2IVohszpQfW6Pf1U/G0
 zdU2a+ByrAMXkJzLVVwZPGD2MGpdC5UpGW8l3Ou0Jb85B+h8Z9RmVxW3evF+ma9aEMsfJ/x
 K/z2rY+hBk2IVfJEvOjLLqfpVzZWHAl4sBSP6waLncg8kJ98JBW9MWzcGHf4xuTsnYSiaUm
 EwJTXOvug6Bvzeba27Oxw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241092>

On 2014-01-26 15.22, Martin Erik Werner wrote:
> The prefix_path_gently() function currently applies real_path to
> everything if given an absolute path, dereferencing symlinks both
> outside and inside the work tree. In order to manipulate symliks in the
> work tree using absolute paths, symlinks should only be dereferenced
> outside the work tree.
> 
> Modify prefix_path_gently() to first normalize the path in order to
> make sure path levels are separated by '/', then use this separator to
> check the real path of each level of the path until it has found the
> length that corresponds to the work tree.
> 
> For absolute paths, the function did not, nor does now do, any actual
> prefixing, hence we simply remove the path corresponding to the work
> tree and return the remaining in-tree part of the path.
> 
> Fixes t0060-82.
> 
> Signed-off-by: Martin Erik Werner <martinerikwerner@gmail.com>
> ---
>  setup.c               | 54 ++++++++++++++++++++++++++++++++-------------------
>  t/t0060-path-utils.sh |  2 +-
>  2 files changed, 35 insertions(+), 21 deletions(-)
> 
> diff --git a/setup.c b/setup.c
> index 6c3f85f..bec587e 100644
> --- a/setup.c
> +++ b/setup.c
> @@ -22,11 +22,41 @@ char *prefix_path_gently(const char *prefix, int len,
>  	const char *orig = path;
>  	char *sanitized;
>  	if (is_absolute_path(orig)) {
> -		const char *temp = real_path(path);
> -		sanitized = xmalloc(len + strlen(temp) + 1);
> -		strcpy(sanitized, temp);
> +		char npath[strlen(path)];
Is this portable ?
This is variable-length array, isn't it ?
Using xmalloc() may be better
>  		if (remaining_prefix)
>  			*remaining_prefix = 0;
> +		if (normalize_path_copy_len(npath, path, remaining_prefix))
> +			return NULL;
> +		const char *work_tree = get_git_work_tree();
declaration after statements should be avoided (not only here)
