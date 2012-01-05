From: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
Subject: [PATCH] clone: allow detached checkout when --branch takes a tag
Date: Thu,  5 Jan 2012 20:49:40 +0700
Message-ID: <1325771380-18862-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jan 05 14:50:17 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Rinhx-0003JG-8B
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 14:50:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198Ab2AENuK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 Jan 2012 08:50:10 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:40011 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1757071Ab2AENuJ (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 Jan 2012 08:50:09 -0500
Received: by obcwo16 with SMTP id wo16so600116obc.19
        for <git@vger.kernel.org>; Thu, 05 Jan 2012 05:50:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        bh=FiYshrO+YHG54UGYQl6Nmsf6sxyH1+Dl/Cgw6k4yLbU=;
        b=wgQ9phh43Gf+vj93pzTzQDxgchVrsHE81ph44gLl9CNBOM4wbugWqE2aTT4BvGu3j/
         laNDbENE1/yzZ25IAX5c2XL2qir1H8E+oBGNcxyrmIARlV+KozkM3BmOg2soOwkHQ3O1
         OTupZql4D/kAjUoUXJtCnaVtS4D/2QGlCVTt4=
Received: by 10.50.184.134 with SMTP id eu6mr2685927igc.17.1325771408681;
        Thu, 05 Jan 2012 05:50:08 -0800 (PST)
Received: from pclouds@gmail.com ([115.74.56.82])
        by mx.google.com with ESMTPS id x18sm201807962ibi.2.2012.01.05.05.50.04
        (version=TLSv1/SSLv3 cipher=OTHER);
        Thu, 05 Jan 2012 05:50:07 -0800 (PST)
Received: by pclouds@gmail.com (sSMTP sendmail emulation); Thu, 05 Jan 2012 20:49:41 +0700
X-Mailer: git-send-email 1.7.8.36.g69ee2
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187976>

This allows you to do "git clone --branch=3Dv1.7.8 git.git" and work
right away from there. No big deal, just one more convenient step, I
think. --branch taking a tag may be confusing though.

We can still have master in this case instead of detached HEAD, which
may make more sense because we use --branch. I don't care much which
way should be used.

Like? Dislike?

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
---
 builtin/clone.c |   20 +++++++++++++++++++-
 1 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/builtin/clone.c b/builtin/clone.c
index 8f29912..97af4bd 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -23,6 +23,7 @@
 #include "branch.h"
 #include "remote.h"
 #include "run-command.h"
+#include "tag.h"
=20
 /*
  * Overall FIXMEs:
@@ -721,6 +722,14 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			strbuf_release(&head);
=20
 			if (!our_head_points_at) {
+				strbuf_addstr(&head, "refs/tags/");
+				strbuf_addstr(&head, option_branch);
+				our_head_points_at =3D
+					find_ref_by_name(mapped_refs, head.buf);
+				strbuf_release(&head);
+			}
+
+			if (!our_head_points_at) {
 				warning(_("Remote branch %s not found in "
 					"upstream %s, using HEAD instead"),
 					option_branch, option_origin);
@@ -750,7 +759,16 @@ int cmd_clone(int argc, const char **argv, const c=
har *prefix)
 			      reflog_msg.buf);
 	}
=20
-	if (our_head_points_at) {
+	if (our_head_points_at &&
+	    !prefixcmp(our_head_points_at->name, "refs/tags/")) {
+		const struct ref *ref =3D our_head_points_at;
+		struct object *o;
+
+		/* Detached HEAD */
+		o =3D deref_tag(parse_object(ref->old_sha1), NULL, 0);
+		update_ref(reflog_msg.buf, "HEAD", o->sha1, NULL,
+			   REF_NODEREF, DIE_ON_ERR);
+	} else if (our_head_points_at) {
 		/* Local default branch link */
 		create_symref("HEAD", our_head_points_at->name, NULL);
 		if (!option_bare) {
--=20
1.7.8.36.g69ee2
