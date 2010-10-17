From: Thomas Rast <trast@student.ethz.ch>
Subject: [PATCH v2 1/2] prefix_filename(): safely handle the case where pfx_len=0
Date: Sun, 17 Oct 2010 21:23:21 +0200
Message-ID: <64b470380b8f7bd8afe8f019553cb99f72091c7d.1287342969.git.trast@student.ethz.ch>
References: <20101017160546.GD301@burratino>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Bert Wesarg <bert.wesarg@googlemail.com>
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Oct 17 21:23:41 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P7YpY-00045e-Ra
	for gcvg-git-2@lo.gmane.org; Sun, 17 Oct 2010 21:23:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932567Ab0JQTXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 17 Oct 2010 15:23:35 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:30951 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932362Ab0JQTXf (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 17 Oct 2010 15:23:35 -0400
Received: from CAS20.d.ethz.ch (172.31.51.110) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Sun, 17 Oct
 2010 21:23:33 +0200
Received: from localhost.localdomain (129.132.208.211) by CAS20.d.ethz.ch
 (172.31.51.110) with Microsoft SMTP Server (TLS) id 14.1.218.12; Sun, 17 Oct
 2010 21:23:33 +0200
X-Mailer: git-send-email 1.7.3.1.266.g3c065
In-Reply-To: <20101017160546.GD301@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159211>

Current prefix_filename() is proofed against the case where the prefix
'pfx' is NULL or a 0-length string, _except on Windows_.

Change the behaviour to work the same on both platforms, and only
check pfx_len so that callers passing a NULL prefix with a nonzero
pfx_len segfault early on both.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

Jonathan Nieder wrote:
> Yes, please!  But I'd write it as
> 
>         if (pfx_len)
>                 memcpy(...)
> 
> and rely on the commit message to explain that this is about the !pfx
> case (so callers with pfx_len == 3, !pfx get a nice, quick segfault
> instead of heisenbugs from uninitialized data).

Hrm, why not.  I think symmetry is important here, so I also changed
the non-Windows arm, which feels wrong somehow.  But it didn't break
any tests.

In writing this I also realised that "it didn't break any tests" is
pretty weak and checked them all by hand (there are only a dozen
grep matches).


 setup.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/setup.c b/setup.c
index a3b76de..346ef2e 100644
--- a/setup.c
+++ b/setup.c
@@ -46,7 +46,7 @@
 {
 	static char path[PATH_MAX];
 #ifndef WIN32
-	if (!pfx || !*pfx || is_absolute_path(arg))
+	if (!pfx_len || is_absolute_path(arg))
 		return arg;
 	memcpy(path, pfx, pfx_len);
 	strcpy(path + pfx_len, arg);
@@ -55,7 +55,7 @@
 	/* don't add prefix to absolute paths, but still replace '\' by '/' */
 	if (is_absolute_path(arg))
 		pfx_len = 0;
-	else
+	else if (pfx_len)
 		memcpy(path, pfx, pfx_len);
 	strcpy(path + pfx_len, arg);
 	for (p = path + pfx_len; *p; p++)
-- 
1.7.3.1.266.g3c065
