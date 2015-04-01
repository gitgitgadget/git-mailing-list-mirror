From: Max Kirillov <max@max630.net>
Subject: Re: [PATCH v3] config.c: split some variables to
 $GIT_DIR/config.worktree
Date: Wed, 1 Apr 2015 23:56:44 +0300
Message-ID: <20150401205644.GA3656@wheezy.local>
References: <1427371464-22237-1-git-send-email-pclouds@gmail.com>
 <1427804079-13061-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 01 22:56:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YdPgq-0004mw-MC
	for gcvg-git-2@plane.gmane.org; Wed, 01 Apr 2015 22:56:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752107AbbDAU4k convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 1 Apr 2015 16:56:40 -0400
Received: from p3plsmtpa07-01.prod.phx3.secureserver.net ([173.201.192.230]:38533
	"EHLO p3plsmtpa07-01.prod.phx3.secureserver.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751099AbbDAU4j (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 1 Apr 2015 16:56:39 -0400
Received: from wheezy.local ([82.181.81.240])
	by p3plsmtpa07-01.prod.phx3.secureserver.net with 
	id AkwX1q0085B68XE01kwd3A; Wed, 01 Apr 2015 13:56:38 -0700
Content-Disposition: inline
In-Reply-To: <1427804079-13061-1-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266618>

On Tue, Mar 31, 2015 at 07:14:39PM +0700, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=
=BB=8Dc Duy wrote:
>  The general principle is like in the last mail: .git/config is for
>  both shared and private keys of main worktree (i.e. nothing is
>  changed from today).  .git/worktrees/xx/config.worktree is for
>  private keys only (and private keys in .git/config are ignored)
> =20
>  With this we don't have to bump core.repository_format_version for
>  main worktree because nothing is changed. There will be problems
>  with info/config.worktree:
>=20
>   - it's customizable, so expect the user to break it (*)

I would rather say it's manual tuning rather than a break.

>   - if we add new stuff to the template, we'll need to help migrate
>     current info/core.worktree (which does not have new stuff).
>     Auto updating this file could be risky. I'm tend to just
>     warn the user that this and that keys should be included and let
>     them modify the file.

I don't think there even should be warning. Just don't
change the info/config.worktree in the existing repositories
and let users extend it as they feel a need for it.

Later there could be a tool (an option to git config for
example) which adds a variable or pattern to the
info/core.worktree and copied existing variable(s) from
commong config to worktree-specific ones.

=2E...

> diff --git a/config.c b/config.c
> index 15a2983..3857023 100644
> --- a/config.c
> +++ b/config.c
=2E...
> @@ -1932,6 +2002,23 @@ int git_config_set_multivar_in_file(const char=
 *config_filename,
> =20
>  	store.multi_replace =3D multi_replace;
> =20
> +	if (git_common_dir_env && is_config_local(key)) {
> +		if (!config_filename)
> +			config_filename =3D filename_buf =3D git_pathdup("config.worktree=
");
> +		/* cheap trick, but should work 90% of time */
> +		else if (!ends_with(config_filename, ".worktree"))
> +			die("%s can only be stored in %s",
> +			    key, git_path("config.worktree"));

Is `config_filename` set only for cases when config file is
explicitly set for "git config" command with "--file"
option? Then probably here should not be any intelligence at
all; if user resort to manual picking the file he must be
allowed to do stupid things.

--=20
Max
