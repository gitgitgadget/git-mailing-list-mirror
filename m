From: Johannes Sixt <j6t@kdbg.org>
Subject: Re: [PATCH] Handle UNC paths everywhere
Date: Mon, 25 Jan 2010 21:07:44 +0100
Message-ID: <201001252107.45745.j6t@kdbg.org>
References: <201001250155.47664.robin.rosenberg@dewire.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 21:09:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZVFH-0007L1-3n
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 21:09:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752332Ab0AYUJF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 15:09:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752107Ab0AYUJE
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 15:09:04 -0500
Received: from bsmtp4.bon.at ([195.3.86.186]:25297 "EHLO bsmtp.bon.at"
	rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
	id S1751550Ab0AYUJE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 15:09:04 -0500
Received: from dx.sixt.local (unknown [93.83.142.38])
	by bsmtp.bon.at (Postfix) with ESMTP id 662C0A7EBA;
	Mon, 25 Jan 2010 21:08:52 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id 0FA9F19F5B2;
	Mon, 25 Jan 2010 21:07:46 +0100 (CET)
User-Agent: KMail/1.9.10
In-Reply-To: <201001250155.47664.robin.rosenberg@dewire.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137988>

On Montag, 25. Januar 2010, Robin Rosenberg wrote:
> In Windows paths beginning with // are knows as UNC paths. They are
> absolute paths, usually referring to a shared resource on a server.
>
> Examples of legal UNC paths
>
> 	\\hub\repos\repo
> 	\\?\unc\hub\repos
> 	\\?\d:\repo

I agree that that the problem that you are addressing needs a solution.

However, the solution is not a whole-sale replacement of 
have_dos_drive_prefix() by a function that is only a tiny bit fancier. 
Accompanying changes are needed, and perhaps more code locations need change.

> @@ -648,7 +648,7 @@ int safe_create_leading_directories_const(const char
> *path);
>  char *enter_repo(char *path, int strict);
>  static inline int is_absolute_path(const char *path)
>  {
> -	return path[0] == '/' || has_dos_drive_prefix(path);
> +	return path[0] == '/' || has_win32_abs_prefix(path);

Perhaps we need is_dir_sep(path[0]) here? But since I have not observed any 
breakage in connection with this code, I think that all callers feed only 
normalized paths (i.e. with forward slash). (Note that our getcwd() 
implementation converts backslashes to forward slashes.) This means that a 
full-fledged check is not needed.

> @@ -5,7 +5,7 @@ char *gitbasename (char *path)
>  {
>  	const char *base;
>  	/* Skip over the disk name in MSDOS pathnames. */
> -	if (has_dos_drive_prefix(path))
> +	if (has_win32_abs_prefix(path))
>  		path += 2;

This change is unnecessary; it really is only to skip an initial driver 
prefix. If you want to support \\?\X: style paths, more work is needed here  
so that you do not return X: or ? as the basename.

> +#define has_win32_abs_prefix(path) \

Do we really have to name everything "win32" when it is about Windows?

> @@ -535,7 +535,7 @@ struct child_process *git_connect(int fd[2], const char
> *url_orig,
>  		end = host;
>
>  	path = strchr(end, c);
> -	if (path && !has_dos_drive_prefix(end)) {
> +	if (path && !has_win32_abs_prefix(end)) {

This change is wrong because the check is really only about the drive prefix: 
It checks that we do not mistake c:/foo as a ssh connection to host c, 
path /foo. Yes, it does mean that on Windows we cannot have remotes to hosts 
whose name consists only of a single letter using the rcp notation (you must 
say ssh://c/foo if you mean it).

> @@ -409,7 +409,7 @@ int normalize_path_copy(char *dst, const char *src)
>  {
>  	char *dst0;
>
> -	if (has_dos_drive_prefix(src)) {
> +	if (has_win32_abs_prefix(src)) {
>  		*dst++ = *src++;
>  		*dst++ = *src++;
>  	}

Is skipping just two characters for \\ or \\?\whatever paths the right thing?

> @@ -342,7 +342,7 @@ const char *setup_git_directory_gently(int *nongit_ok)
>  		die_errno("Unable to read current working directory");
>
>  	ceil_offset = longest_ancestor_length(cwd, env_ceiling_dirs);
> -	if (ceil_offset < 0 && has_dos_drive_prefix(cwd))
> +	if (ceil_offset < 0 && has_win32_abs_prefix(cwd))
>  		ceil_offset = 1;

I doubt that this is correct. The purpose of this check is that "c:/" is the 
last directory that is checked (on Unix it would be "/") when path components 
are stripped from cwd. For UNC paths this must be adjusted depending on how 
you want to support \\server\share and \\?\c:\paths: You do not want to check 
whether \\server\.git or \\.git or \\?\.git are git directories.

> --- a/transport.c
> +++ b/transport.c
> @@ -797,7 +797,7 @@ static int is_local(const char *url)
>  	const char *colon = strchr(url, ':');
>  	const char *slash = strchr(url, '/');
>  	return !colon || (slash && slash < colon) ||
> -		has_dos_drive_prefix(url);
> +		has_win32_abs_prefix(url);

This check is again to not mistake c:/foo as rcp style connection. No change 
needed.

As I said, changes to other parts are perhaps also needed, most prominently, 
make_relative_path() that prompted this patch. What about 
make_absolute_path() and make_non_relative_path()?

-- Hannes
