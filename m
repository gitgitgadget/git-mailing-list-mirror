From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 2/2] ignorecase: Fix git mv on insensitive filesystems
Date: Wed, 07 May 2014 08:17:02 +0200
Message-ID: <5369CFDE.2070207@viscovery.net>
References: <xmqqoazaelmi.fsf@gitster.dls.corp.google.com> <1399417144-24864-1-git-send-email-dturner@twopensource.com> <1399417144-24864-2-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, gitster@pobox.com,
	David Turner <dturner@twitter.com>
To: dturner@twopensource.com
X-From: git-owner@vger.kernel.org Wed May 07 08:17:19 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WhvAK-0004zT-UC
	for gcvg-git-2@plane.gmane.org; Wed, 07 May 2014 08:17:17 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435AbaEGGRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 7 May 2014 02:17:11 -0400
Received: from so.liwest.at ([212.33.55.15]:44323 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751104AbaEGGRK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 7 May 2014 02:17:10 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.80.1)
	(envelope-from <j.sixt@viscovery.net>)
	id 1WhvA7-0007m8-Gn; Wed, 07 May 2014 08:17:04 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 1CC1416613;
	Wed,  7 May 2014 08:17:03 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.1.0
In-Reply-To: <1399417144-24864-2-git-send-email-dturner@twopensource.com>
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248284>

Am 5/7/2014 0:59, schrieb dturner@twopensource.com:
> From: David Turner <dturner@twitter.com>
> 
> Make it possible to change the case of a filename on a
> case-insensitive filesystem using git mv.  Change git mv to allow
> moves where the destination file exists if either the destination file
> has the same inode as the source file (for Mac) or the same name
> ignoring case (for Win).
> 
> Signed-off-by: David Turner <dturner@twitter.com>
> ---
>  builtin/mv.c                | 18 ++++++++++--------
>  t/t6039-merge-ignorecase.sh |  2 +-
>  2 files changed, 11 insertions(+), 9 deletions(-)
> 
> diff --git a/builtin/mv.c b/builtin/mv.c
> index 45e57f3..8cead13 100644
> --- a/builtin/mv.c
> +++ b/builtin/mv.c
> @@ -74,7 +74,7 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	};
>  	const char **source, **destination, **dest_path, **submodule_gitfile;
>  	enum update_mode { BOTH = 0, WORKING_DIRECTORY, INDEX } *modes;
> -	struct stat st;
> +	struct stat src_st,dst_st;
>  	struct string_list src_for_dst = STRING_LIST_INIT_NODUP;
>  
>  	gitmodules_config();
> @@ -102,8 +102,8 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  	if (dest_path[0][0] == '\0')
>  		/* special case: "." was normalized to "" */
>  		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
> -	else if (!lstat(dest_path[0], &st) &&
> -			S_ISDIR(st.st_mode)) {
> +	else if (!lstat(dest_path[0], &dst_st) &&
> +			S_ISDIR(dst_st.st_mode)) {
>  		dest_path[0] = add_slash(dest_path[0]);
>  		destination = internal_copy_pathspec(dest_path[0], argv, argc, DUP_BASENAME);
>  	} else {
> @@ -122,13 +122,13 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			printf(_("Checking rename of '%s' to '%s'\n"), src, dst);
>  
>  		length = strlen(src);
> -		if (lstat(src, &st) < 0)
> +		if (lstat(src, &src_st) < 0)
>  			bad = _("bad source");
>  		else if (!strncmp(src, dst, length) &&
>  				(dst[length] == 0 || dst[length] == '/')) {
>  			bad = _("can not move directory into itself");
> -		} else if ((src_is_dir = S_ISDIR(st.st_mode))
> -				&& lstat(dst, &st) == 0)
> +		} else if ((src_is_dir = S_ISDIR(src_st.st_mode))
> +				&& lstat(dst, &dst_st) == 0)
>  			bad = _("cannot move directory over file");
>  		else if (src_is_dir) {
>  			int first = cache_name_pos(src, length);
> @@ -202,14 +202,16 @@ int cmd_mv(int argc, const char **argv, const char *prefix)
>  			}
>  		} else if (cache_name_pos(src, length) < 0)
>  			bad = _("not under version control");
> -		else if (lstat(dst, &st) == 0) {
> +		else if (lstat(dst, &dst_st) == 0 &&
> +			 (src_st.st_ino != dst_st.st_ino ||
> +			  (src_st.st_ino == 0 && strcasecmp(src, dst)))) {

Don't do that. st_ino is zero on Windows only because we do not spend time
to fill in the field. Don't use it as an indicator for a case-insensitive
file system; zero may be a valid inode number on other systems.

>  			bad = _("destination exists");
>  			if (force) {
>  				/*
>  				 * only files can overwrite each other:
>  				 * check both source and destination
>  				 */
> -				if (S_ISREG(st.st_mode) || S_ISLNK(st.st_mode)) {
> +				if (S_ISREG(dst_st.st_mode) || S_ISLNK(dst_st.st_mode)) {
>  					if (verbose)
>  						warning(_("overwriting '%s'"), dst);
>  					bad = NULL;
> diff --git a/t/t6039-merge-ignorecase.sh b/t/t6039-merge-ignorecase.sh
> index ad06752..28cfb49 100755
> --- a/t/t6039-merge-ignorecase.sh
> +++ b/t/t6039-merge-ignorecase.sh
> @@ -35,7 +35,7 @@ test_expect_success 'merge with case-changing rename on both sides' '
>  	git reset --hard baseline &&
>  	git branch -D with-camel &&
>  	git checkout -b with-camel &&
> -	git mv --force TestCase testcase &&
> +	git mv TestCase testcase &&
>  	git commit -m "recase on branch" &&
>  	> foo &&
>  	git add foo &&
