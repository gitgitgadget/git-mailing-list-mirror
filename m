From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v3 19/19] fsck: support ignoring objects in `git fsck` via
 fsck.skiplist
Date: Wed, 21 Jan 2015 20:27:46 +0100
Organization: gmx
Message-ID: <fe744590eab4ee0b9ba25ac3473d93ab581956aa.1421868116.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1421868116.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Jan 21 20:27:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YE0wY-0003so-Jm
	for gcvg-git-2@plane.gmane.org; Wed, 21 Jan 2015 20:27:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbbAUT1z (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Jan 2015 14:27:55 -0500
Received: from mout.gmx.net ([212.227.17.20]:65000 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753138AbbAUT1x (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Jan 2015 14:27:53 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0MFctN-1XzNo60MK5-00EhAx; Wed, 21 Jan 2015 20:27:47
 +0100
In-Reply-To: <cover.1421868116.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:8SvIE0subrxhgi52fdt/26szfZj5fz44zi46VWDkvzpiNhJ8nEd
 FkGiXBeeVqeUjGVKlerbMEOh3a1eVOHTGVRHkAfVOxQ9gQsovTC2loFl8jt9z1bKTA+yoY3
 JKyqmNMvXCYW6XsiXeWZxfp9iJf/Us5cC8q+xRAGNJXELux9PRSVoFahNKZQkBdalB8DZCz
 bCfZk/prkcgzF73WSLUYw==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262764>

Identical to support in `git receive-pack for the config option
`receive.fsck.skiplist`, we now support ignoring given objects in
`git fsck` altogether.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  7 +++++++
 builtin/fsck.c           | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 636adff..644411a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1223,6 +1223,13 @@ that setting `fsck.ignore = missing-email` will hide that issue.
 This feature is intended to support working with legacy repositories
 which cannot be repaired without disruptive changes.
 
+fsck.skipList::
+	The path to a sorted list of object names (i.e. one SHA-1 per
+	line) that are known to be broken in a non-fatal way and should
+	be ignored. This feature is useful when an established project
+	should be accepted despite early commits containing errors that
+	can be safely ignored such as invalid committer email addresses.
+
 gc.aggressiveDepth::
 	The depth parameter used in the delta compression
 	algorithm used by 'git gc --aggressive'.  This defaults
diff --git a/builtin/fsck.c b/builtin/fsck.c
index 7ae4715..760b4bd 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -49,6 +49,16 @@ static int show_dangling = 1;
 
 static int fsck_config(const char *var, const char *value, void *cb)
 {
+	if (strcmp(var, "receive.fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		fsck_set_severity(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	if (skip_prefix(var, "fsck.", &var)) {
 		struct strbuf sb = STRBUF_INIT;
 		strbuf_addf(&sb, "%s=%s", var, value);
-- 
2.2.0.33.gc18b867
