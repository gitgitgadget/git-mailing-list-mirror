From: =?utf-8?q?Tor=20Arne=20Vestb=C3=B8?= <tor.arne.vestbo@nokia.com>
Subject: [PATCH v3 1/2] Move find_ref_by_name_abbrev to refs.c so it can be used globally
Date: Fri, 27 Mar 2009 18:45:12 +0100
Message-ID: <1238175913-19175-2-git-send-email-tor.arne.vestbo@nokia.com>
References: <1238175913-19175-1-git-send-email-tor.arne.vestbo@nokia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Mar 27 18:46:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LnG8w-0007DF-L5
	for gcvg-git-2@gmane.org; Fri, 27 Mar 2009 18:46:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753742AbZC0RpZ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Mar 2009 13:45:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753643AbZC0RpZ
	(ORCPT <rfc822;git-outgoing>); Fri, 27 Mar 2009 13:45:25 -0400
Received: from smtp.nokia.com ([192.100.122.230]:42670 "EHLO
	mgw-mx03.nokia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750925AbZC0RpX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Mar 2009 13:45:23 -0400
Received: from vaebh105.NOE.Nokia.com (vaebh105.europe.nokia.com [10.160.244.31])
	by mgw-mx03.nokia.com (Switch-3.2.6/Switch-3.2.6) with ESMTP id n2RHj6Qt014613;
	Fri, 27 Mar 2009 19:45:16 +0200
Received: from esebh102.NOE.Nokia.com ([172.21.138.183]) by vaebh105.NOE.Nokia.com with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:33 +0200
Received: from mgw-int01.ntc.nokia.com ([172.21.143.96]) by esebh102.NOE.Nokia.com over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Fri, 27 Mar 2009 19:44:32 +0200
Received: from localhost.localdomain (olwst90124.europe.nokia.com [172.24.90.124])
	by mgw-int01.ntc.nokia.com (Switch-3.2.5/Switch-3.2.5) with ESMTP id n2RHiSXw032239;
	Fri, 27 Mar 2009 19:44:31 +0200
X-Mailer: git-send-email 1.6.2.GIT
In-Reply-To: <1238175913-19175-1-git-send-email-tor.arne.vestbo@nokia.com>
X-OriginalArrivalTime: 27 Mar 2009 17:44:32.0826 (UTC) FILETIME=[AFEFC9A0:01C9AF03]
X-Nokia-AV: Clean
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114918>

Signed-off-by: Tor Arne Vestb=C3=B8 <tor.arne.vestbo@nokia.com>
---
 cache.h  |    1 +
 refs.c   |   10 ++++++++++
 remote.c |   10 ----------
 3 files changed, 11 insertions(+), 10 deletions(-)

diff --git a/cache.h b/cache.h
index f48e80b..23699a8 100644
--- a/cache.h
+++ b/cache.h
@@ -815,6 +815,7 @@ struct ref {
 #define REF_TAGS	(1u << 2)
=20
 extern struct ref *find_ref_by_name(const struct ref *list, const char=
 *name);
+extern struct ref *find_ref_by_name_abbrev(const struct ref *list, con=
st char *name);
=20
 #define CONNECT_VERBOSE       (1u << 0)
 extern struct child_process *git_connect(int fd[2], const char *url, c=
onst char *prog, int flags);
diff --git a/refs.c b/refs.c
index 26b0014..161e053 100644
--- a/refs.c
+++ b/refs.c
@@ -1644,3 +1644,13 @@ struct ref *find_ref_by_name(const struct ref *l=
ist, const char *name)
 			return (struct ref *)list;
 	return NULL;
 }
+
+struct ref *find_ref_by_name_abbrev(const struct ref *list, const char=
 *name)
+{
+	for ( ; list; list =3D list->next) {
+		if (refname_match(name, list->name, ref_fetch_rules))
+			return (struct ref *)list;
+	}
+	return NULL;
+}
+
diff --git a/remote.c b/remote.c
index e5d6b10..e903b39 100644
--- a/remote.c
+++ b/remote.c
@@ -1220,16 +1220,6 @@ static struct ref *get_expanded_map(const struct=
 ref *remote_refs,
 	return ret;
 }
=20
-static const struct ref *find_ref_by_name_abbrev(const struct ref *ref=
s, const char *name)
-{
-	const struct ref *ref;
-	for (ref =3D refs; ref; ref =3D ref->next) {
-		if (refname_match(name, ref->name, ref_fetch_rules))
-			return ref;
-	}
-	return NULL;
-}
-
 struct ref *get_remote_ref(const struct ref *remote_refs, const char *=
name)
 {
 	const struct ref *ref =3D find_ref_by_name_abbrev(remote_refs, name);
--=20
1.6.2.GIT
