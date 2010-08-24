From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH 30/32] merge: support merging when narrow bases are different
Date: Wed, 25 Aug 2010 08:20:20 +1000
Message-ID: <1282688422-7738-31-git-send-email-pclouds@gmail.com>
References: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Aug 25 00:25:21 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oo1ve-0004Dg-W8
	for gcvg-git-2@lo.gmane.org; Wed, 25 Aug 2010 00:25:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756169Ab0HXWYY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 24 Aug 2010 18:24:24 -0400
Received: from mail-pz0-f46.google.com ([209.85.210.46]:60997 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756168Ab0HXWYV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Aug 2010 18:24:21 -0400
Received: by pzk26 with SMTP id 26so2825579pzk.19
        for <git@vger.kernel.org>; Tue, 24 Aug 2010 15:24:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references:mime-version
         :content-type:content-transfer-encoding;
        bh=ulRgC5/3YN5DETISwT6xod2a/fTHSkdECyg7qAu4lkk=;
        b=M2br6mEtr3sfWtgSLvXom3U9iBVUslapYa4amayn4Ukj3wJowfFb6crrfvr0rX6Yrl
         nXhiqbhKqGjiXUmfLlkb4iIQYJiEJp/5/Uh2G/+8hP3/GgkywH42o9/uqwQw89tW5ZZs
         D4Cj1WI8BwzXCzBNV4JxsZQKd0PinhgDCJw3Y=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        b=Lt0p2uhUuKvWg+yjIb6NmanA8bt03EoEOVEnSFBi8wP2Xm743DQagU/f2uYMmO+5fv
         RVYSNrMNwKWoIgoUCiVHCre1Ic2L2mSqeSt03dMfCtdozIb/RWUvGzQL0sXpGnmXAcwU
         FPZXSFebaNhS6ilQ0l6bYkqAogpL2Kw+SPnrY=
Received: by 10.142.126.4 with SMTP id y4mr6130483wfc.249.1282688661428;
        Tue, 24 Aug 2010 15:24:21 -0700 (PDT)
Received: from dektop (dektec3.lnk.telstra.net [165.228.202.174])
        by mx.google.com with ESMTPS id t11sm643493wfc.4.2010.08.24.15.24.17
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 24 Aug 2010 15:24:20 -0700 (PDT)
Received: by dektop (sSMTP sendmail emulation); Wed, 25 Aug 2010 08:24:13 +1000
X-Mailer: git-send-email 1.7.1.rc1.69.g24c2f7
In-Reply-To: <1282688422-7738-1-git-send-email-pclouds@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/154374>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/merge.c |   25 ++++++++++++++++++++++---
 1 files changed, 22 insertions(+), 3 deletions(-)

diff --git a/builtin/merge.c b/builtin/merge.c
index d05c528..1c70193 100644
--- a/builtin/merge.c
+++ b/builtin/merge.c
@@ -58,6 +58,7 @@ static const char *branch;
 static int verbosity;
 static int allow_rerere_auto;
 static unsigned char narrow_base[20];
+static const char *narrow_remote, *narrow_exec;
=20
 static struct strategy all_strategy[] =3D {
 	{ "recursive",  DEFAULT_TWOHEAD | NO_TRIVIAL },
@@ -195,6 +196,10 @@ static struct option builtin_merge_options[] =3D {
 	OPT_CALLBACK('m', "message", &merge_msg, "message",
 		"message to be used for the merge commit (if any)",
 		option_parse_message),
+	OPT_STRING(0, "remote", &narrow_remote, "repo",
+		   "remote repo to perform narrow base calculation"),
+	OPT_STRING(0, "upload-narrow-base", &narrow_exec, "path",
+		   "path to git-upload-narrow-base"),
 	OPT__VERBOSITY(&verbosity),
 	OPT_END()
 };
@@ -1065,9 +1070,23 @@ int cmd_merge(int argc, const char **argv, const=
 char *prefix)
 				break;
 			item =3D item->next;
 		}
-		if (item)
-			die("Different narrow base, couldn't do merge (yet)");
-		hashcpy(narrow_base, lookup_commit(head)->tree->object.sha1);
+		if (item) {
+			unsigned char sha1[2][20];
+
+			if (remoteheads->next)
+				die("Octopus merge is not supported in narrow repository");
+			if (!narrow_remote)
+				die("This merge cannot be fully performed locally.\n"
+				    "Please specify remote repo with --remote.");
+			oldest_narrow_base(head, sha1[0]);
+			oldest_narrow_base(remoteheads->item->object.sha1, sha1[1]);
+			if (fetch_narrow_base(sha1[0], sha1[1], narrow_base,
+					      get_narrow_prefix(),
+					      narrow_remote, narrow_exec))
+				die("Failed to request narrow base from remote repo");
+		}
+		else
+			hashcpy(narrow_base, lookup_commit(head)->tree->object.sha1);
 	}
=20
 	if (!remoteheads->next)
--=20
1.7.1.rc1.69.g24c2f7
