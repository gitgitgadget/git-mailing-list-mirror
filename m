From: Fredrik Gustafsson <iveqy@iveqy.com>
Subject: Re: [PATCH v3 2/5] Teach mv to move submodules using a gitfile
Date: Wed, 31 Jul 2013 11:43:14 +0200
Message-ID: <20130731094314.GD19369@paksenarrion.iveqy.com>
References: <51F8187F.7040603@web.de>
 <51F818EB.8010101@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Nguyen Thai Ngoc Duy <pclouds@gmail.com>
To: Jens Lehmann <Jens.Lehmann@web.de>
X-From: git-owner@vger.kernel.org Wed Jul 31 11:40:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V4Stn-0007t9-7j
	for gcvg-git-2@plane.gmane.org; Wed, 31 Jul 2013 11:40:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759326Ab3GaJkk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Jul 2013 05:40:40 -0400
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54069 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759316Ab3GaJkh (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Jul 2013 05:40:37 -0400
Received: by mail-lb0-f178.google.com with SMTP id z5so418164lbh.9
        for <git@vger.kernel.org>; Wed, 31 Jul 2013 02:40:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=c7/YFOSvH/AhMslafSYV4gq43QLKWSxVkjwMGlZZT04=;
        b=e/TdHKdvkFQzrdfkuXB8pWrJK4KEbknmHbKHu7u3ydqMopzrEWlLEGBf3xEXpMKt0r
         J06K46YHPEkn4DSmEEcns0iDZJcyceB+nAz7ji+iUYZ9W6gs2d8FJCZUNAIM0TVWOSQJ
         WOcF8neFFRvjFCzH12GE/nCMMLl6/nqSywbcNXJ0J84UYpx4GhmAJ3eFk5iYcCfr1TR2
         QCp/HLrrsESgeiE9yfBGbSUeqBwnnuX2Oe5b5kYLe1JmtMA5MpX8fUXR+g+90lh1tVZb
         WXUvqDJh5mlV0mKNxIKtxcXOFAJaa1EKHupMa174dtlS5kn6gvCEVhjULwD6WwDRJ6No
         yc0g==
X-Received: by 10.152.2.42 with SMTP id 10mr30912271lar.77.1375263635616;
        Wed, 31 Jul 2013 02:40:35 -0700 (PDT)
Received: from paksenarrion.iveqy.com (c83-250-233-181.bredband.comhem.se. [83.250.233.181])
        by mx.google.com with ESMTPSA id 8sm939305lbq.4.2013.07.31.02.40.34
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Wed, 31 Jul 2013 02:40:34 -0700 (PDT)
Received: from iveqy by paksenarrion.iveqy.com with local (Exim 4.72)
	(envelope-from <iveqy@paksenarrion.iveqy.com>)
	id 1V4Sw6-0001aD-L3; Wed, 31 Jul 2013 11:43:14 +0200
Content-Disposition: inline
In-Reply-To: <51F818EB.8010101@web.de>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231413>

On Tue, Jul 30, 2013 at 09:50:03PM +0200, Jens Lehmann wrote:
> +/* Update gitfile and core.worktree setting to connect work tree and=
 git dir */
> +void connect_work_tree_and_git_dir(const char *work_tree, const char=
 *git_dir)
> +{
> +	struct strbuf file_name =3D STRBUF_INIT;
> +	struct strbuf rel_path =3D STRBUF_INIT;
> +	const char *real_work_tree =3D xstrdup(real_path(work_tree));
> +	FILE *fp;
> +
> +	/* Update gitfile */
> +	strbuf_addf(&file_name, "%s/.git", work_tree);
> +	fp =3D fopen(file_name.buf, "w");
> +	if (!fp)
> +		die(_("Could not create git link %s"), file_name.buf);
> +	fprintf(fp, "gitdir: %s\n", relative_path(git_dir, real_work_tree,
> +						  &rel_path));
> +	fclose(fp);
> +
> +	/* Update core.worktree setting */
> +	strbuf_reset(&file_name);
> +	strbuf_addf(&file_name, "%s/config", git_dir);
> +	if (git_config_set_in_file(file_name.buf, "core.worktree",
> +				   relative_path(real_work_tree, git_dir,
> +						 &rel_path)))
> +		die(_("Could not set core.worktree in %s"),
> +		    file_name.buf);
> +
> +	strbuf_release(&file_name);
> +	strbuf_release(&rel_path);
> +	free((void *)real_work_tree);
> +}

Would it make sense to return an int here and do the dying in
builtin/mv.c instead? Again thinking of "libgit" and the die_errno for
non-submodule errors are in mv.c and not in rename().

If that's the case the same applies for stage_updated_gitmodules() and
update_path_in_gitmodules().

update_path_in_gitmodules() also needs a strbuf_release() if you haven'=
t
already found it.

--=20
Med v=E4nliga h=E4lsningar
=46redrik Gustafsson

tel: 0733-608274
e-post: iveqy@iveqy.com
