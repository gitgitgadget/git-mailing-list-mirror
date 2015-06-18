From: Johannes Schindelin <johannes.schindelin@gmx.de>
Subject: [PATCH v5 06/19] fsck: Report the ID of the error/warning
Date: Thu, 18 Jun 2015 22:08:25 +0200
Organization: gmx
Message-ID: <d0cab23cd7755a080b4a2b9b51d65684632bf4f9.1434657920.git.johannes.schindelin@gmx.de>
References: <cover.1422737997.git.johannes.schindelin@gmx.de>
 <cover.1434657920.git.johannes.schindelin@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, mhagger@alum.mit.edu, peff@peff.net
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Thu Jun 18 22:08:38 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z5g72-0002go-W0
	for gcvg-git-2@plane.gmane.org; Thu, 18 Jun 2015 22:08:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756255AbbFRUId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Jun 2015 16:08:33 -0400
Received: from mout.gmx.net ([212.227.15.19]:53694 "EHLO mout.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756926AbbFRUIa (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Jun 2015 16:08:30 -0400
Received: from www.dscho.org ([87.106.4.80]) by mail.gmx.com (mrgmx002) with
 ESMTPSA (Nemesis) id 0Lj1Xa-1YZNIN2G9m-00dC1n; Thu, 18 Jun 2015 22:08:25
 +0200
In-Reply-To: <cover.1434657920.git.johannes.schindelin@gmx.de>
X-Sender: johannes.schindelin@gmx.de
User-Agent: Roundcube Webmail/1.1.0
X-Provags-ID: V03:K0:yuEl4m/hvP0bPF6Sim6MRWeMjKzWKJ/uMZcSDWE5JwvePIiZOL5
 drx6m6Y/7Pl4Mt0EIFFV9KWFtlWskAptdcJNoejGZWPz4CX5nRAqRBmaCDIHTBIWaBk/QPj
 whdHbQPmZtxOw+DG6Tlfv+RvYFhkgZDilHu7GlBUCvRRQSvPiqtdiJUl2u36hWEk02eE3tB
 tOXLVhr4psYrnGsRoIWqA==
X-UI-Out-Filterresults: notjunk:1;V01:K0:wIu2MjjV3cA=:VbOhHB0Q9+1OdWdytBsNKW
 k5u67D2FqqCtV0mkH7SzROO8br7Yt2sOzIbSg3O1INoF53X6pfpPL9Dn6txw5VsKiLrE6nuWJ
 pyoLBhGPaelxBaIEPsj7qkyRglofJE3hFCi+On7KmUtBzPwLYj/4gos6ofG9i9PizwOsk7T4y
 mVz+vxzTzGzlk2ZOHWTNWYnBc9wcH8lzJTBwDupjuqo9ELYZtirLvp1RSffLuyYGi1ysNnhqQ
 Yxk0aHu6bmjAbwwCL0h+V+aL+UEqYx0nnkIlPKf3IokFLdAsRwLVmtae20JoupUftWn7lSQ34
 rJq89HHk9Rx1e5PDJpGMDT7ht4xeeGuc1GgaBGKJHb0FFEm9AzR7KpYOXLK8EVrZlJckM/N/u
 BN0f9ry2PS38nc6EHWclC/2xFPAqmzD1R+2gVZKsm+1twIfckFg55hGBKdIu9BPJU9Ru7v8xi
 dIp2XkmIx8N6yfoU0lzrbvJUEtPe3xODCvQ18tcSZS6c23njWyvncTrXJN7rsZjKm3MgzfLxv
 JXlqcSRV5IqO7Ad2V49ZCV5iwrzIUb+4sgolAJZKcn15vJkHRoeaBnlOxwFySnRs3xHfP6sWy
 TRMASJepGs97afxLOsTDSyIkTjwISzR66Xgz4u3PtlqDJ52ghNsbwoet7Y9FlzDxibvD940m7
 1TCn7U8h80pCP7H85XKPD3nZKT4yNMS/iiieklxAe0Te9w/mC5+EoC80pmHTns87DK/o=
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272046>

Some legacy code has objects with non-fatal fsck issues; To enable the
user to ignore those issues, let's print out the ID (e.g. when
encountering "missingemail", the user might want to call `git config
--add receive.fsck.missingemail=warn`).

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
---
 fsck.c          | 16 ++++++++++++++++
 t/t1450-fsck.sh |  4 ++--
 2 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 0c7cc26..47cb686 100644
--- a/fsck.c
+++ b/fsck.c
@@ -190,6 +190,20 @@ void fsck_set_msg_types(struct fsck_options *options, const char *values)
 	}
 }
 
+static void append_msg_id(struct strbuf *sb, const char *msg_id)
+{
+	for (;;) {
+		char c = *(msg_id)++;
+
+		if (!c)
+			break;
+		if (c != '_')
+			strbuf_addch(sb, tolower(c));
+	}
+
+	strbuf_addstr(sb, ": ");
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -198,6 +212,8 @@ static int report(struct fsck_options *options, struct object *object,
 	struct strbuf sb = STRBUF_INIT;
 	int msg_type = fsck_msg_type(id, options), result;
 
+	append_msg_id(&sb, msg_id_info[id].id_string);
+
 	va_start(ap, fmt);
 	strbuf_vaddf(&sb, fmt, ap);
 	result = options->error_func(object, msg_type, sb.buf);
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index cfb32b6..286a643 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -231,8 +231,8 @@ test_expect_success 'tag with incorrect tag name & missing tagger' '
 	git fsck --tags 2>out &&
 
 	cat >expect <<-EOF &&
-	warning in tag $tag: invalid '\''tag'\'' name: wrong name format
-	warning in tag $tag: invalid format - expected '\''tagger'\'' line
+	warning in tag $tag: invalidtagname: invalid '\''tag'\'' name: wrong name format
+	warning in tag $tag: missingtaggerentry: invalid format - expected '\''tagger'\'' line
 	EOF
 	test_cmp expect out
 '
-- 
2.3.1.windows.1.9.g8c01ab4
