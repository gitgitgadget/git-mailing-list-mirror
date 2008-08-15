From: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
Subject: [PATCH 2/9] update-index: add --checkout/--no-checkout options to
	update CE_NO_CHECKOUT bit
Date: Fri, 15 Aug 2008 21:25:15 +0700
Message-ID: <20080815142515.GA10667@laptop>
References: <cover.1218807249.git.pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Aug 15 16:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KU0GB-00052g-8v
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 16:26:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755699AbYHOOZb convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Aug 2008 10:25:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755737AbYHOOZa
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Aug 2008 10:25:30 -0400
Received: from py-out-1112.google.com ([64.233.166.181]:26857 "EHLO
	py-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755665AbYHOOZ3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Aug 2008 10:25:29 -0400
Received: by py-out-1112.google.com with SMTP id p76so868457pyb.10
        for <git@vger.kernel.org>; Fri, 15 Aug 2008 07:25:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:received:date:from:to:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=DSpGdu9J/Dxg6hM7AwaCPm9Q77inUpYFNabHr5ObYuk=;
        b=klfOQGHjxgB2xVKCPk8FnwVEauRzj9sVI+67nhw/GM3I0YGWoB2dOkradMTbVGNOwm
         gq7Cjj9TFtAFk2ri8V6QUL86aqoBzpEEnMFZe4Qa0zAX1Cun9TEAN7Y13JL0aht7ugJQ
         mu4XEQ/TjinX31zU+50Hqw0YAgKzTLIh05iRg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=Qx6dg6DeYptCcyEDy5GubLK326Ckvx2YrvHP1CwbsB83RIeKYFSlR38/tPbgRtOb24
         SWaxgjlvNd9RSVyhEjE46mXXzdp+NXManW1p/GkNaLn4Q44wCbp4f240UCkjA8/fsKw/
         kxbbCdsQmIfJq0D53B17zjPqZuJKlEFmmmVZg=
Received: by 10.114.74.18 with SMTP id w18mr2558097waa.125.1218810328927;
        Fri, 15 Aug 2008 07:25:28 -0700 (PDT)
Received: from pclouds@gmail.com ( [125.234.152.212])
        by mx.google.com with ESMTPS id y11sm70823pod.5.2008.08.15.07.25.26
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Fri, 15 Aug 2008 07:25:27 -0700 (PDT)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Fri, 15 Aug 2008 21:25:15 +0700
Content-Disposition: inline
In-Reply-To: <cover.1218807249.git.pclouds@gmail.com>
User-Agent: Mutt/1.5.16 (2007-06-09)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92475>


Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin-update-index.c |   40 +++++++++++++++++++++++++---------------
 1 files changed, 25 insertions(+), 15 deletions(-)

diff --git a/builtin-update-index.c b/builtin-update-index.c
index 434cb8e..1d6bb65 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -24,8 +24,9 @@ static int info_only;
 static int force_remove;
 static int verbose;
 static int mark_valid_only;
-#define MARK_VALID 1
-#define UNMARK_VALID 2
+static int mark_no_checkout_only;
+#define MARK_FLAG 1
+#define UNMARK_FLAG 2
=20
 static void report(const char *fmt, ...)
 {
@@ -40,19 +41,15 @@ static void report(const char *fmt, ...)
 	va_end(vp);
 }
=20
-static int mark_valid(const char *path)
+static int mark_ce_flags(const char *path, int flag, int mark)
 {
 	int namelen =3D strlen(path);
 	int pos =3D cache_name_pos(path, namelen);
 	if (0 <=3D pos) {
-		switch (mark_valid_only) {
-		case MARK_VALID:
-			active_cache[pos]->ce_flags |=3D CE_VALID;
-			break;
-		case UNMARK_VALID:
-			active_cache[pos]->ce_flags &=3D ~CE_VALID;
-			break;
-		}
+		if (mark)
+			active_cache[pos]->ce_flags |=3D flag;
+		else
+			active_cache[pos]->ce_flags &=3D ~flag;
 		cache_tree_invalidate_path(active_cache_tree, path);
 		active_cache_changed =3D 1;
 		return 0;
@@ -276,7 +273,12 @@ static void update_one(const char *path, const cha=
r *prefix, int prefix_length)
 		goto free_return;
 	}
 	if (mark_valid_only) {
-		if (mark_valid(p))
+		if (mark_ce_flags(p, CE_VALID, mark_valid_only =3D=3D MARK_FLAG))
+			die("Unable to mark file %s", path);
+		goto free_return;
+	}
+	if (mark_no_checkout_only) {
+		if (mark_ce_flags(p, CE_NO_CHECKOUT, mark_no_checkout_only =3D=3D MA=
RK_FLAG))
 			die("Unable to mark file %s", path);
 		goto free_return;
 	}
@@ -390,7 +392,7 @@ static void read_index_info(int line_termination)
 }
=20
 static const char update_index_usage[] =3D
-"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--info-only] [--force-remove] [--stdin] [--index-info] [--u=
nresolve] [--again | -g] [--ignore-missing] [-z] [--verbose] [--] <file=
>...";
+"git update-index [-q] [--add] [--replace] [--remove] [--unmerged] [--=
refresh] [--really-refresh] [--cacheinfo] [--chmod=3D(+|-)x] [--assume-=
unchanged] [--checkout|--no-checkout] [--info-only] [--force-remove] [-=
-stdin] [--index-info] [--unresolve] [--again | -g] [--ignore-missing] =
[-z] [--verbose] [--] <file>...";
=20
 static unsigned char head_sha1[20];
 static unsigned char merge_head_sha1[20];
@@ -647,11 +649,19 @@ int cmd_update_index(int argc, const char **argv,=
 const char *prefix)
 				continue;
 			}
 			if (!strcmp(path, "--assume-unchanged")) {
-				mark_valid_only =3D MARK_VALID;
+				mark_valid_only =3D MARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--no-assume-unchanged")) {
-				mark_valid_only =3D UNMARK_VALID;
+				mark_valid_only =3D UNMARK_FLAG;
+				continue;
+			}
+			if (!strcmp(path, "--checkout")) {
+				mark_no_checkout_only =3D UNMARK_FLAG;
+				continue;
+			}
+			if (!strcmp(path, "--no-checkout")) {
+				mark_no_checkout_only =3D MARK_FLAG;
 				continue;
 			}
 			if (!strcmp(path, "--info-only")) {
--=20
1.6.0.rc3.250.g8dd0
