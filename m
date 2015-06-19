From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v6 19/19] fsck: support ignoring objects in `git fsck` via
 fsck.skiplist
Date: Fri, 19 Jun 2015 15:35:41 +0200
Organization: gmx
Message-ID: <692a41377d0bd47934170ea9b22a68f9dd893f38.1434720655.git.johannes.schindelin@gmx.de>
References: <cover.1434657920.git.johannes.schindelin@gmx.de>
 <cover.1434720655.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri Jun 19 15:36:46 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5wTI-00024I-3D
	for gcvg-git-2@plane.gmane.org; Fri, 19 Jun 2015 15:36:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753710AbbFSNft (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Jun 2015 09:35:49 -0400
Received: from mout.gmx.net ([212.227.15.15]:65200 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752603AbbFSNfr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Jun 2015 09:35:47 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lmr1w-1YcMKo34F2-00h3xw; Fri, 19 Jun 2015 15:35:42
 +0200
In-Reply-To: <cover.1434720655.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:9/CJmXD7kZ3WLtg7C4HFf+uTEiLhyFXc0JFG5tZSLpO2z6qWuwK
 DISydagaHH4ZxJta4FoheHvV69mxyw3ucOztDv7IfxPMwYumIq61SURadvQA8ZaJ9AsRz1k
 +WSbqJR+j1kVylTCNtG+QbLhbjg8ZFYO9/axJSSl1RdYf82pf/kzylv03fc6tkYF5NPB2/T
 DBdKzq3rQKkPurNkaDGOA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:imsZZXmxEOc=:OmpaJb79gIw6ZCBu6gcBwZ
 cKp3SJ/S9Wg+DutBMF+QmEDSf9QDcRkD9DFeaUHFQUnM52cw87NBwayvAUnqeXFFoaZTlmc1n
 8juLJ8t5x3R+ZkhIr5AG4TfY4BaC6v6ee97nTde+QUtNQcS9bdM1nr5hu15IgYoXLRKm77FQi
 LDSrWXmKWRGfzNV5YBEKYWR4Pzw5rGrrNmgijsjUhGznLa6bg8mtADEs0TQkf8L6rR58bdWo0
 INujuI1nL7sD6BQoay6JMRn2GNugfCAgmq7+UIwEPu4mX3Q5e4SJr3rPJFrxLXh9gXCwR+qRp
 rLXG8u8o0bdHVZyjzb8PwUyJ+2ZpxKUvG51KPfuxC7eKKKl78ZTHaGsqb22rdVPU+QGnOPs3Q
 KwBLWpGJ0FzVSDDpqbjE7tTz8/f0wtAJZeLEy36vbS8qGILf0z7dpBLpqztv/xvwsB22lGXxH
 hGSePLJnZajRkeZAnTHWcdo2bp1VjG9koCLSziV+PiPQGqXepy3Q6iIBNiRS/LHuwKz4gX2PI
 0Y8+9hIj64Kbd4IdRP+r1h8hE9ete31sVPoqEHUIy8eOqLrzHVhdiOkbOr5e+9KrtNK5OUYry
 vPcDCQSO3nXy1Xr5rcLnXVzznG+gO6+VrIP6SCLSMv1x7q8Y37hZlmjkI3Z8PV4pZ1WBo2H3x
 +Yqofc8xPBNT72me2WACYCUKXsjpo2voeKswftsYmUy2Q3nfpaQo01Aqa0m8lv1m7FSg=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272151>

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
index 5f45115..5aba63a 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1261,6 +1261,13 @@ that setting `fsck.missingemail = ignore` will hide that issue.
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
index 75fcb5f..ce538ac 100644
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
+		fsck_set_msg_types(&fsck_obj_options, sb.buf);
+		strbuf_release(&sb);
+		return 0;
+	}
+
 	return git_default_config(var, value, cb);
 }
 
-- 
2.3.1.windows.1.9.g8c01ab4
