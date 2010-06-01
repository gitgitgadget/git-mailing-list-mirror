From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 5/8] revert: allow cherry-picking more than one commit
Date: Tue, 1 Jun 2010 03:35:49 -0500
Message-ID: <20100601083549.GA28377@progeny.tock>
References: <20100531193359.28729.55562.chriscool@tuxfamily.org>
 <20100531194240.28729.9164.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Tue Jun 01 10:36:03 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OJMx7-0004wA-0t
	for gcvg-git-2@lo.gmane.org; Tue, 01 Jun 2010 10:36:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753434Ab0FAIfz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 1 Jun 2010 04:35:55 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:57915 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752127Ab0FAIfy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 1 Jun 2010 04:35:54 -0400
Received: by iwn6 with SMTP id 6so703206iwn.19
        for <git@vger.kernel.org>; Tue, 01 Jun 2010 01:35:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=w4eS+mK3NzXFmhAiu/BNc8qGI3ojh6hTjiWG9oo5X8M=;
        b=kchfB/D/k7JHfedJNiUiPJhOPLZHhdYHCi9QgsecysAi4QQVLlwADIjG60uzemduQ2
         Qh/uCPKZG5ruHfafW1aFwhVRpu1I++o1KZP7bLwk81xLgBVj7svEL4GVN5igebiIpc09
         V29NcIGkGCQCD4cXll500zXarsOgrKyZpQotc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=owG14aQ85UxbX2mGE3dSRDsCrpgqUCS812P/ztyRoVSp0+mrziFKJwop45sE55nJbA
         psL6/jw1cdxwuzJOGb49AJ4qrLXN0wWYepFeZJWHdGBSfT5bvWWgCqELjPEOYRH0dNVk
         hAyP6l/t55aWzi72Gv7veBY7brLj+kirbZ8xQ=
Received: by 10.231.158.130 with SMTP id f2mr7387378ibx.40.1275381353455;
        Tue, 01 Jun 2010 01:35:53 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm30322767ibl.16.2010.06.01.01.35.51
        (version=SSLv3 cipher=RC4-MD5);
        Tue, 01 Jun 2010 01:35:52 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100531194240.28729.9164.chriscool@tuxfamily.org>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148091>

Christian Couder wrote:

> The following should be possible but does not work:
>=20
> 	git cherry-pick -2 master
>=20
> because "git rev-list --no-walk -2 master" only outputs
> one commit as "--no-walk" seems to take over "-2".

Are the semantics of --no-walk documented anywhere?

In the spirit of v1.6.4-rc1~3 (Make 'git show' more useful,
2009-07-13), we could make -n imply --do-walk.

This would change the meaning of git show -5 --all, so I am not too
happy with it.

-- 8< --
Subject: DWIM 'git show -5' to 'git show --do-walk -5'

To show the last two commits with one command, one might try

 1) git show -s master~2..
 2) git show -s ^master~2 master
 3) git show -s master^ master
 4) git show -s -2 master

Choice (3) works because both commits are listed on the command line.
Choices (1) and (2) have worked ever since v1.6.4-rc~3 (Make 'git
show' more useful, 2009-07-13) disabled --no-walk in this case because
there is no other useful meaning for them to have.  Unfortunately, (4)
does not work: it outputs only one commit, because --no-walk stays on.

So disable --no-walk in this case so =E2=80=98git show=E2=80=99 and fut=
ure =E2=80=98git
cherry-pick=E2=80=99 can behave as expected.

As a side effect, this unfortunately changes the meaning of
=E2=80=98git log --oneline --decorate --no-walk -5 --all=E2=80=99: inst=
ead of listing
five refs, after this patch that command would list the five most
recent commits.

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 revision.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/revision.c b/revision.c
index f4b8b38..7b881a8 100644
--- a/revision.c
+++ b/revision.c
@@ -1063,18 +1063,22 @@ static int handle_revision_opt(struct rev_info =
*revs, int argc, const char **arg
=20
 	if (!prefixcmp(arg, "--max-count=3D")) {
 		revs->max_count =3D atoi(arg + 12);
+		revs->no_walk =3D 0;
 	} else if (!prefixcmp(arg, "--skip=3D")) {
 		revs->skip_count =3D atoi(arg + 7);
 	} else if ((*arg =3D=3D '-') && isdigit(arg[1])) {
 	/* accept -<digit>, like traditional "head" */
 		revs->max_count =3D atoi(arg + 1);
+		revs->no_walk =3D 0;
 	} else if (!strcmp(arg, "-n")) {
 		if (argc <=3D 1)
 			return error("-n requires an argument");
 		revs->max_count =3D atoi(argv[1]);
+		revs->no_walk =3D 0;
 		return 2;
 	} else if (!prefixcmp(arg, "-n")) {
 		revs->max_count =3D atoi(arg + 2);
+		revs->no_walk =3D 0;
 	} else if (!prefixcmp(arg, "--max-age=3D")) {
 		revs->max_age =3D atoi(arg + 10);
 	} else if (!prefixcmp(arg, "--since=3D")) {
--=20
1.7.1.246.g2fc1b.dirty
