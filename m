From: John Keeping <john@keeping.me.uk>
Subject: Re: [PATCH] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 09:11:21 +0000
Message-ID: <20140218091121.GA1048@serenity.lan>
References: <20140218065620.GA3448@bogon.m.sigxcpu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>
X-From: git-owner@vger.kernel.org Tue Feb 18 10:11:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFgiO-0007bF-Ex
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 10:11:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754679AbaBRJLj convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Feb 2014 04:11:39 -0500
Received: from hyena.aluminati.org ([64.22.123.221]:45661 "EHLO
	hyena.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754362AbaBRJLg (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 04:11:36 -0500
Received: from localhost (localhost [127.0.0.1])
	by hyena.aluminati.org (Postfix) with ESMTP id ED33221ACE;
	Tue, 18 Feb 2014 09:11:35 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at hyena.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -1
X-Spam-Level: 
X-Spam-Status: No, score=-1 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1] autolearn=disabled
Received: from hyena.aluminati.org ([127.0.0.1])
	by localhost (hyena.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wWPe41ty44XV; Tue, 18 Feb 2014 09:11:35 +0000 (GMT)
Received: from coyote.aluminati.org (coyote.aluminati.org [10.0.16.51])
	by hyena.aluminati.org (Postfix) with ESMTP id 2F8461FFEB;
	Tue, 18 Feb 2014 09:11:35 +0000 (GMT)
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id D91F3606533;
	Tue, 18 Feb 2014 09:11:34 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NnKZOe0i4iH0; Tue, 18 Feb 2014 09:11:34 +0000 (GMT)
Received: from serenity.lan (chimera.aluminati.org [10.0.16.60])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 3F3AA6064E7;
	Tue, 18 Feb 2014 09:11:30 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <20140218065620.GA3448@bogon.m.sigxcpu.org>
User-Agent: Mutt/1.5.22 (2013-10-16)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242288>

On Tue, Feb 18, 2014 at 07:56:20AM +0100, Guido G=FCnther wrote:
> Without this when maintaining stable branches it's easy to forget to =
use
> -x to track where a patch was cherry-picked from.
>=20
> Signed-off-by: Guido G=FCnther <agx@sigxcpu.org>
> ---
>  Documentation/git-cherry-pick.txt |  8 ++++++++
>  builtin/revert.c                  | 10 ++++++++++
>  2 files changed, 18 insertions(+)
>=20
> diff --git a/Documentation/git-cherry-pick.txt b/Documentation/git-ch=
erry-pick.txt
> index c205d23..c35064f 100644
> --- a/Documentation/git-cherry-pick.txt
> +++ b/Documentation/git-cherry-pick.txt
> @@ -215,6 +215,14 @@ the working tree.
>  spending extra time to avoid mistakes based on incorrectly matching
>  context lines.
> =20
> +CONFIGURATION
> +-------------
> +
> +See linkgit:git-config[1] for core variables.
> +
> +cherrypick.record-origin::

=46or consistency, this should be "cherrypick.recordOrigin", although I
wonder if we should permit "cherry-pick" here so as to keep the config
section the same as the name of the command.

I think this should also be added to git-config(1)

> +	Default for the `-x` option. Defaults to `false`.
> +
>  SEE ALSO
>  --------
>  linkgit:git-revert[1]
> diff --git a/builtin/revert.c b/builtin/revert.c
> index 87659c9..df9718f 100644
> --- a/builtin/revert.c
> +++ b/builtin/revert.c
> @@ -196,6 +196,15 @@ int cmd_revert(int argc, const char **argv, cons=
t char *prefix)
>  	return res;
>  }
> =20
> +static int git_cherry_pick_config(const char *var, const char *value=
, void *cb)
> +{
> +	struct replay_opts *opts =3D cb;
> +
> +	if (!strcmp(var, "cherrypick.record-origin"))
> +		opts->record_origin =3D git_config_bool (var, value);
> +	return 0;

If you change this to:

    return git_default_config(var, value, cb);

then the code below won't end up walking the config twice.

> +}
> +
>  int cmd_cherry_pick(int argc, const char **argv, const char *prefix)
>  {
>  	struct replay_opts opts;
> @@ -204,6 +213,7 @@ int cmd_cherry_pick(int argc, const char **argv, =
const char *prefix)
>  	memset(&opts, 0, sizeof(opts));
>  	opts.action =3D REPLAY_PICK;
>  	git_config(git_default_config, NULL);
> +	git_config(git_cherry_pick_config, &opts);
>  	parse_args(argc, argv, &opts);
>  	res =3D sequencer_pick_revisions(&opts);
>  	if (res < 0)
