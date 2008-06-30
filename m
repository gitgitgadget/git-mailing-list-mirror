From: Olivier Marin <dkr+ml.git@free.fr>
Subject: Re: [PATCH 13/13] Build in merge
Date: Tue, 01 Jul 2008 00:44:23 +0200
Message-ID: <486961C7.2090603@free.fr>
References: <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Tue Jul 01 00:45:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDS7k-0005hz-Ke
	for gcvg-git-2@gmane.org; Tue, 01 Jul 2008 00:45:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762584AbYF3WoN convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Jun 2008 18:44:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762700AbYF3WoN
	(ORCPT <rfc822;git-outgoing>); Mon, 30 Jun 2008 18:44:13 -0400
Received: from smtp2-g19.free.fr ([212.27.42.28]:48253 "EHLO smtp2-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762436AbYF3WoM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Jun 2008 18:44:12 -0400
Received: from smtp2-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp2-g19.free.fr (Postfix) with ESMTP id 08A4C12B6B2;
	Tue,  1 Jul 2008 00:44:11 +0200 (CEST)
Received: from [10.253.21.40] (hhe95-1-82-225-56-14.fbx.proxad.net [82.225.56.14])
	by smtp2-g19.free.fr (Postfix) with ESMTP id A315112B6D2;
	Tue,  1 Jul 2008 00:44:10 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <e8d1385cc49a06ca3fae28231ebc66a333ce4ffb.1214789764.git.vmiklos@frugalware.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/86952>

Miklos Vajna a =E9crit :
>=20
> +static void finish(const unsigned char *new_head, const char *msg)
> +{

[...]

> +	if (new_head && show_diffstat) {
> +		struct diff_options opts;
> +		diff_setup(&opts);
> +		opts.output_format |=3D
> +			DIFF_FORMAT_SUMMARY | DIFF_FORMAT_DIFFSTAT;
> +		opts.detect_rename =3D DIFF_DETECT_RENAME;
> +		if (diff_use_color_default > 0)
> +			DIFF_OPT_SET(&opts, COLOR_DIFF);

Ah, I missed that. You should call diff_setup_done(), to finish diff_se=
tup()
and have a recursive diffstat.

=46or example:

$ git checkout -b test c0f5c69
$ git merge 2dce956
Updating c0f5c69..2dce956
=46ast forward
 help.c |   22 ++++++++++++++--------
 1 files changed, 14 insertions(+), 8 deletions(-)

is wrong. Correct diffstat is:

$ git diff --stat c0f5c69..2dce956
 Documentation/gitcli.txt        |   37 +++++++++++++++++++++++++++++++=
++----
 Documentation/gittutorial-2.txt |   10 +++++-----
 help.c                          |   22 ++++++++++++++--------
 t/test-lib.sh                   |    2 +-
 4 files changed, 53 insertions(+), 18 deletions(-)

> +		diff_tree_sha1(head, new_head, "", &opts);
> +		diffcore_std(&opts);
> +		diff_flush(&opts);
> +	}

[...]

> +int cmd_merge(int argc, const char **argv, const char *prefix)
> +{

[...]

> +	git_config(git_merge_config, NULL);
> +
> +	/* for color.diff and diff.color */
> +	git_config(git_diff_ui_config, NULL);

Also, what about doing "return git_diff_ui_config(k, v, cb)" at the end=
 of
git_merge_config() instead, to avoid parsing config files twice.

> +
> +	/* for color.ui */
> +	if (diff_use_color_default =3D=3D -1)
> +		diff_use_color_default =3D git_use_color_default;
> +

Olivier.
