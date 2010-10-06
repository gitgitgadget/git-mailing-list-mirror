From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] worktree: provide better prefix to go back to original
 cwd
Date: Wed, 6 Oct 2010 13:07:28 -0500
Message-ID: <20101006180727.GA2118@burratino>
References: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, judge.packham@gmail.com, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 06 20:11:01 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P3YSB-0005HN-UD
	for gcvg-git-2@lo.gmane.org; Wed, 06 Oct 2010 20:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759460Ab0JFSKk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 6 Oct 2010 14:10:40 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:36255 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754095Ab0JFSKj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Oct 2010 14:10:39 -0400
Received: by vws3 with SMTP id 3so74550vws.19
        for <git@vger.kernel.org>; Wed, 06 Oct 2010 11:10:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=Ube6yKQrPccxbgabNjuN5k8zRFk62rtulwTC0ou3v2c=;
        b=iIHKVpDFXbgtiBWNOBViEFLL0C3ZHY8ifbvDI92FAlIHZzv3OeaYeqAkABW9oox6R6
         fLdePfeDxx692SaueeLfsdcVEUsh3GrpOEXKaMpAw/IAzBVV5xFpSTlPCsYBDVEfbm2m
         7yumwHAk9eD/FKxkMdftpGTh0Jhyas0x8Vwxs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=ULbdWeLPd4VL9XSZcS/TY4b7rndY0hCxc7VZMi5b1inJpYXHjw1uY6VMPJLkGYjmDz
         eMLGb+KSGQ8LlODscr5AD4IC2YNy2xYpwESfv4emAL/saSb3y38kbHkUMKPXCTPUZ0tO
         whVQm9b2sFy8O8xgovIqDNXhKCLjxzzfzjlhM=
Received: by 10.220.186.2 with SMTP id cq2mr879148vcb.1.1286388638539;
        Wed, 06 Oct 2010 11:10:38 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id l9sm1466246vbp.11.2010.10.06.11.10.36
        (version=SSLv3 cipher=RC4-MD5);
        Wed, 06 Oct 2010 11:10:37 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <1286373578-2484-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158298>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> This patch allows builtin commands access to original cwd even if it'=
s
> outside worktree, via cwd_to_worktree and worktree_to_cwd fields.
> --- a/builtin/rev-parse.c
> +++ b/builtin/rev-parse.c
> @@ -623,6 +623,16 @@ int cmd_rev_parse(int argc, const char **argv, c=
onst char *prefix)
>  					puts(prefix);
>  				continue;
>  			}
> +			if (!strcmp(arg, "--cwd-to-worktree")) {
> +				if (startup_info->cwd_to_worktree)
> +					puts(startup_info->cwd_to_worktree);
> +				continue;
> +			}
> +			if (!strcmp(arg, "--worktree-to-cwd")) {
> +				if (startup_info->worktree_to_cwd)
> +					puts(startup_info->worktree_to_cwd);
> +				continue;
> +			}

Nice.

I wonder if this should use something like

	else
		puts(".");

or

	else
		putchar('\n');

=2E  What would be most convenient for scripted callers?

What do these commands do when run from a bare repository?  Is the
worktree the .git dir in that case, do they fail, or does something
else happen?

Are there any examples to illustrate whether teaching --show-prefix to
do what your --worktree-to-cwd does would be a good or bad idea?
(Just curious.)

> --- a/cache.h
> +++ b/cache.h
> @@ -1110,6 +1110,8 @@ const char *split_cmdline_strerror(int cmdline_=
errno);
>  /* git.c */
>  struct startup_info {
>  	int have_repository;
> +	char *cwd_to_worktree; /* chdir("this"); from cwd would return to w=
orktree */
> +	char *worktree_to_cwd; /* chdir("this"); from worktree would return=
 to cwd */

Comment nit: would

				/* path from original cwd to worktree */
				/* path from worktree to original cwd */

be clearer?  But presumably any confused people should be able to find
your log message.

> --- a/setup.c
> +++ b/setup.c
> @@ -313,10 +313,109 @@ const char *read_gitfile_gently(const char *pa=
th)
>  	return path;
>  }
> =20
> +/*
> + * Given "foo/bar" and "hey/hello/world", return "../../hey/hello/wo=
rld/"
> + * Either path1 or path2 can be NULL
> + */
> +static char *make_path_to_path(const char *path1, const char *path2)

Nice.  Do we need to worry about:

 - alternate directory separators? (hey\hello\world)
 - DOS drive prefix? (c:\foo\bar, d:\hey\hello\world)
 - relative paths with DOS drive? (c:\foo\bar, d:hello)
 - doubled-up directory separators? (hey//hello/world, //foo/bar)
 - non-canonical paths? (hey/./hello/../hello/world)

I'm guessing some of the answers are "no", depending on where these
paths come from.  Compare make_relative_path().
[...]

>  static const char *setup_explicit_git_dir(const char *gitdirenv,
>  				const char *work_tree_env, int *nongit_ok)
>  {
> -	static char buffer[1024 + 1];
> +	static char buffer[PATH_MAX];

Why?

It might make sense to error out a little before PATH_MAX (though
later than 1024), to account for subdirs (e.g., objects/).  Not sure.
