From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 6/9] builtin: remember whether repository was found
Date: Mon, 12 Apr 2010 21:28:21 -0500
Message-ID: <20100413022821.GF4118@progeny.tock>
References: <20100413021153.GA3978@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 13 04:28:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O1Vrd-0008HD-GB
	for gcvg-git-2@lo.gmane.org; Tue, 13 Apr 2010 04:28:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754638Ab0DMC22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 12 Apr 2010 22:28:28 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:51236 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754616Ab0DMC21 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Apr 2010 22:28:27 -0400
Received: by gyg13 with SMTP id 13so3218334gyg.19
        for <git@vger.kernel.org>; Mon, 12 Apr 2010 19:28:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=+JKE/E8dNojx+s4LduUiTqNSg+PqsBM5n1s9LlHTs/s=;
        b=hESAf50XX7nV3pRV7E4AVj040q408eDzrL1MC3KA8jUFlE2NbX7wuOURTNn/RSyhV5
         zHasKPktKLaPLF24pv4kH3nDUx9s6RhPWO8qPGTDgdwn607aP4ALkTgKnYCfK0PM5M0y
         2NDv84mH21n3BhqJDi8Ps7oUH1xiLEAEG1RQw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=IQZPfguyMs/U9Hi1Dv9heHYfMwSYSSdl8nAT12WQYFAXMuRJ8lS5TRyT8ROIdQdygV
         c0eyD8PMt0WohEm84Y8awKWYWwo/IaqM0XPymMrlcO83SNcxEx9Uqj//CdNzKeomi2gU
         PG6Ie0WiLQXWIHock8hDkYOJjceh6dxGH+t9Y=
Received: by 10.101.135.2 with SMTP id m2mr8687553ann.95.1271125702778;
        Mon, 12 Apr 2010 19:28:22 -0700 (PDT)
Received: from progeny.tock (wireless-239-104.uchicago.edu [128.135.239.104])
        by mx.google.com with ESMTPS id 23sm284841iwn.2.2010.04.12.19.28.21
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 12 Apr 2010 19:28:21 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100413021153.GA3978@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144785>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

Attempts to access gitdir are everywhere, even before cmd_*() is
called (in particular for alias handling, pager configuration, work
tree, and other core configuration).  Because the repository has not
been found, repository-specific information (GIT_DIR/config) can not
be read.  This can lead to obscure bugs.

The sooner we set up gitdir, the less trouble we may have to deal with.

Currently, the cmd_*() functions learn whether a repository was
found through the *nongit_ok return value to
setup_git_directory_gently().  If run_builtin() is to take care of
this sooner, then they will have to get it from somewhere else.
startup_info is a good place for this.

As a bonus, this information can be used to teach functions such as
git_config() to avoid trying to access a repository if none is
present.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 cache.h |    1 +
 setup.c |   12 +++++++++++-
 2 files changed, 12 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 1479824..030ba01 100644
--- a/cache.h
+++ b/cache.h
@@ -1060,6 +1060,7 @@ int split_cmdline(char *cmdline, const char ***ar=
gv);
=20
 /* git.c */
 struct startup_info {
+	int have_repository;
 };
 extern struct startup_info *startup_info;
=20
diff --git a/setup.c b/setup.c
index 5716d90..3b4ff09 100644
--- a/setup.c
+++ b/setup.c
@@ -315,7 +315,7 @@ const char *read_gitfile_gently(const char *path)
  * We cannot decide in this function whether we are in the work tree o=
r
  * not, since the config can only be read _after_ this function was ca=
lled.
  */
-const char *setup_git_directory_gently(int *nongit_ok)
+static const char *setup_git_directory_gently_1(int *nongit_ok)
 {
 	const char *work_tree_env =3D getenv(GIT_WORK_TREE_ENVIRONMENT);
 	const char *env_ceiling_dirs =3D getenv(CEILING_DIRECTORIES_ENVIRONME=
NT);
@@ -443,6 +443,16 @@ const char *setup_git_directory_gently(int *nongit=
_ok)
 	return cwd + offset;
 }
=20
+const char *setup_git_directory_gently(int *nongit_ok)
+{
+	const char *prefix;
+
+	prefix =3D setup_git_directory_gently_1(nongit_ok);
+	if (startup_info)
+		startup_info->have_repository =3D !nongit_ok || !*nongit_ok;
+	return prefix;
+}
+
 int git_config_perm(const char *var, const char *value)
 {
 	int i;
--=20
1.7.0.4
