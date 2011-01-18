From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH 39/47] setup: limit get_git_work_tree()'s to explicit
 setup case only
Date: Tue, 18 Jan 2011 01:44:00 -0600
Message-ID: <20110118074400.GA4185@burratino>
References: <1290785563-15339-1-git-send-email-pclouds@gmail.com>
 <1290785563-15339-40-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jan 18 08:44:23 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pf6En-0006t3-KJ
	for gcvg-git-2@lo.gmane.org; Tue, 18 Jan 2011 08:44:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752081Ab1ARHoR convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 18 Jan 2011 02:44:17 -0500
Received: from mail-gy0-f174.google.com ([209.85.160.174]:34647 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751899Ab1ARHoQ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 18 Jan 2011 02:44:16 -0500
Received: by gyb11 with SMTP id 11so2207384gyb.19
        for <git@vger.kernel.org>; Mon, 17 Jan 2011 23:44:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:references
         :mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=SoKPbRydb73vCV10EpuGBc+jER7MD0Boti0ALQAz2jQ=;
        b=KN+cFIWY06dXxS2XBPLVRaXPjCY1m/z+VUE/SUHumCThLigVmWdL8NH4OM1v57YXRW
         cfrTdZUtRp1oZbqaq3GT9t7noRCklcTSN/g9PF05G5Pn6I70qBzgZs6ZZIBV9RBxbgp5
         RtfyWrvDctKNovZDx4Zm6SLObaPT3V7P3wOYg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=aaAxqwQwdmC/09ZQcvEK+TUsEOtP31JU4AfvwHpAk7EXoExC3N/UcE6a6sNznMuZGK
         dDoWpPmAUNjHGiQDAXHXrg1ijNXyjzDAVPl5kEVjNxw671cVzQWckjf7/FTHwjgs4fvl
         LPwOJoOQkuSnNXBtKVWzikKpKeiL1MB9VmD6U=
Received: by 10.150.13.1 with SMTP id 1mr651874ybm.400.1295336654836;
        Mon, 17 Jan 2011 23:44:14 -0800 (PST)
Received: from burratino (adsl-69-209-76-37.dsl.chcgil.ameritech.net [69.209.76.37])
        by mx.google.com with ESMTPS id w24sm2779233ybk.9.2011.01.17.23.44.08
        (version=SSLv3 cipher=RC4-MD5);
        Mon, 17 Jan 2011 23:44:09 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <1290785563-15339-40-git-send-email-pclouds@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165192>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:

> get_git_work_tree() takes input as core.worktree, core.bare,
> GIT_WORK_TREE and decides correct worktree setting.
>
> Unfortunately it does not do its job well. core.worktree and
> GIT_WORK_TREE should only be taken into account, if GIT_DIR is set

As advertised, before this change

	GIT_WORK_TREE=3D$path git add .

paid attention to $GIT_WORK_TREE (and set GIT_DIR=3D.git), and
afterwards the GIT_WORK_TREE setting has been ignored when GIT_DIR is
not set explicitly.

Unfortunately, that breaks some scripts.  Example: using the "git
import-dsc" utility from git-buildpackage to import a source package:

	debsnap libwpd 0.7.2-1
	git clone git://libwpd.git.sourceforge.net/gitroot/libwpd/libwpd
	git tag upstream/0.7.2 RELEASE-0-7-2^{commit}
	git reset --keep origin/master
	git import-dsc ../source-libwpd/libwpd_0.7.2-1.dsc=20
	echo $?
	git show --raw
	echo done.

With git v1.7.4-rc2:

	HEAD is now at d183cc6 Imported Debian patch 0.7.2-1
	gbp:info: Everything imported under 'libwpd'
	0
	commit d183cc6c4b8dcaf22b1b0875aad0655846ed3b1b
	Author: Masayuki Hatta (mhatta) <mhatta@debian.org>
	Date:   Tue Aug 10 00:37:47 2004 +0900

	    Imported Debian patch 0.7.2-1

	done

versus v1.7.3.2:

	HEAD is now at 735a8f2 Imported Debian patch 0.7.2-1
	gbp:info: Everything imported under 'libwpd'
	0
	commit 735a8f21ea817417ecc035817f777bd2943d4efc
	Author: Masayuki Hatta (mhatta) <mhatta@debian.org>
	Date:   Tue Aug 10 00:37:47 2004 +0900

	    Imported Debian patch 0.7.2-1

	:100644 000000 038cd09... 0000000... D  .gitignore
	:000000 100644 0000000... 0189791... A  CHANGES
	[...]

git-buildpackage uses the equivalent of

	GIT_INDEX_FILE=3D$(pwd)/.git/gbp_index \
	GIT_WORK_TREE=3D$unpack_dir \
	git add -f .

when creating the commit, so with v1.7.4-rc0 and later it is taking
its content from the cwd, producing an incorrect result without
complaint.

How about something like this patch?  It only concerns the
GIT_WORK_TREE variable and --work-tree command line option; the
semantics of core.worktree are unaffected.

(Sorry, no real patch yet.  Updating the test to reflect the change is
a pain in the neck.)

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
diff --git a/setup.c b/setup.c
index 3d73269..28b2fef 100644
--- a/setup.c
+++ b/setup.c
@@ -419,6 +419,11 @@ static const char *setup_discovered_git_dir(const =
char *gitdir,
 		return NULL;
 	}
=20
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT)) {
+		warning("GIT_WORK_TREE without explicit GIT_DIR is deprecated");
+		return setup_explicit_git_dir(gitdir, cwd, offset, nongit_ok);
+	}
+
 	/* #0, #1, #5, #8, #9, #12, #13 */
 	set_git_work_tree(".");
 	if (strcmp(gitdir, DEFAULT_GIT_DIR_ENVIRONMENT))
@@ -443,6 +448,11 @@ static const char *setup_bare_git_dir(char *cwd, i=
nt offset, int len, int *nongi
 	if (check_repository_format_gently(".", nongit_ok))
 		return NULL;
=20
+	if (getenv(GIT_WORK_TREE_ENVIRONMENT)) {
+		warning("GIT_WORK_TREE without explicit GIT_DIR is deprecated");
+		return setup_explicit_git_dir(".", cwd, offset, nongit_ok);
+	}
+
 	inside_git_dir =3D 1;
 	inside_work_tree =3D 0;
 	if (offset !=3D len) {
