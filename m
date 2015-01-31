From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v4 19/19] fsck: support ignoring objects in `git fsck` via
 fsck.skiplist
Date: Sat, 31 Jan 2015 22:07:06 +0100
Organization: gmx
Message-ID: <efb672505c7f15b7e5775f1637a2ae7cfe30edeb.1422737997.git.johannes.schindelin@gmx.de>
References: <xmqqr3w7gxr4.fsf@gitster.dls.corp.google.com>
 <cover.1422737997.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Sat Jan 31 22:07:19 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YHfGB-0005Qo-4Z
	for gcvg-git-2@plane.gmane.org; Sat, 31 Jan 2015 22:07:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756213AbbAaVHO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2015 16:07:14 -0500
Received: from mout.gmx.net ([212.227.17.21]:59065 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753293AbbAaVHN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2015 16:07:13 -0500
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx103) with
 ESMTPSA (Nemesis) id 0LgI0W-1Xul5j1h8W-00ngdW; Sat, 31 Jan 2015 22:07:07
 +0100
In-Reply-To: <cover.1422737997.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1-git
X-Provags-ID: V03:K0:/rjtDpoe4dUX+LwK8mzIGIzGDujDEN8Wm+kUKoXkCKbyCv4jXWx
 RmsXXNKSQFRuISSMsaAs0+oQmWdFHRGCEt8kFKBTovpdNI5fZShFUKTww2rZclr+b32oWMl
 FcuvCu8YlVF447qLfEoDIVYFHslS4PJ6bGzVdW1ZOQ+h2LBbPmrBRUZOF/DZLBP9Xmh0ARl
 pR+mNEb6SH2LgQaNQtB/g==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263229>

Identical to support in `git receive-pack for the config option
`receive.fsck.skiplist`, we now support ignoring given objects in
`git fsck` via `fsck.skiplist` altogether.

This is extremely handy in case of legacy repositories where it would
cause more pain to change incorrect objects than to live with them
(e.g. a duplicate 'author' line in an early commit object).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 Documentation/config.txt |  7 +++++++
 builtin/fsck.c           | 10 ++++++++++
 2 files changed, 17 insertions(+)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index e685aef..93c43d5 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1220,6 +1220,13 @@ that setting `fsck.severity = missing-email=ignore` will hide that issue.
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
index cf61aad..81570d8 100644
--- a/builtin/fsck.c
+++ b/builtin/fsck.c
@@ -54,6 +54,16 @@ static int fsck_config(const char *var, const char *value, void *cb)
 		return 0;
 	}
 
+	if (strcmp(var, "fsck.skiplist") == 0) {
+		const char *path = is_absolute_path(value) ?
+			value : git_path("%s", value);
+		struct strbuf sb = STRBUF_INIT;
+		strbuf_addf(&sb, "skiplist=%s", path);
+		fsck_set_severity(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.2.0.33.gc18b867
