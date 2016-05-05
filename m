From: =?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
Subject: [RFC PATCH] gc --auto: don't lie about running in background on Windows
Date: Thu,  5 May 2016 17:16:46 +0200
Message-ID: <20160505151646.13189-1-szeder@ira.uka.de>
References: <20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@webmail.informatik.kit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	=?UTF-8?q?SZEDER=20G=C3=A1bor?= <szeder@ira.uka.de>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu May 05 17:17:18 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ayL1i-0008T7-1r
	for gcvg-git-2@plane.gmane.org; Thu, 05 May 2016 17:17:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756756AbcEEPRI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 5 May 2016 11:17:08 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:33961 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753503AbcEEPRH (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 5 May 2016 11:17:07 -0400
Received: from x4db01ee5.dyn.telefonica.de ([77.176.30.229] helo=localhost.localdomain)
	by iramx2.ira.uni-karlsruhe.de with esmtpsa port 587 
	iface 141.3.10.81 id 1ayL1R-0000Ej-5J; Thu, 05 May 2016 17:17:02 +0200
X-Mailer: git-send-email 2.8.2.356.ge684b1d
In-Reply-To: <20160505171430.Horde.-GuvDpZBfS8VI1Zcfn4bJQI@webmail.informatik.kit.edu>
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de  esmtpsa 1462461422.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293650>

When 'git gc --auto' is invoked it tells the user whether it is about
to auto pack the repository in the background or in the foreground
depending on 'gc.autoDetach' (enabled by default).  However, going to
the background is not supported at all on Windows, yet 'git gc --auto'
by default claims that it will do so.

Add a helper function that can tell whether the platform supports
going to the background and use it in the 'git gc --auto' codepath to
print an honest message.

Signed-off-by: SZEDER G=C3=A1bor <szeder@ira.uka.de>
---

I built and tested with 'NO_POSIX_GOODIES=3DUnfortunatelyYes': it
worked.  However, I did not test it on Windows due to lack of
resources, hence the RFC out of caution.

Arguably this helper function could be just a simple variable.  I
opted for a function because:

  - I preferred a single '#ifdef NO_POSIX_GOODIES', and putting a
    static variable so near to EOF felt just wrong.  (And this is why
    it's not an inline-able function defined in a header file.)

  - currently we know already at compile time that Windows can't
    daemonize, but in the future we might want to extend this helper
    function to perform some runtime checks, too.  But this is perhaps
    like preparing for crossing a bridge where we'll never get to.

 builtin/gc.c |  1 +
 cache.h      |  1 +
 setup.c      | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad6ec28..79a0f6dc1126 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -368,6 +368,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 		 */
 		if (!need_to_gc())
 			return 0;
+		detach_auto &=3D can_daemonize();
 		if (!quiet) {
 			if (detach_auto)
 				fprintf(stderr, _("Auto packing the repository in background for o=
ptimum performance.\n"));
diff --git a/cache.h b/cache.h
index fd728f079320..3662e5aabb98 100644
--- a/cache.h
+++ b/cache.h
@@ -524,6 +524,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
+extern int can_daemonize(void);
 extern int daemonize(void);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
diff --git a/setup.c b/setup.c
index c86bf5c9fabe..6187a4ad9c47 100644
--- a/setup.c
+++ b/setup.c
@@ -1033,12 +1033,25 @@ void sanitize_stdfds(void)
 		close(fd);
 }
=20
+#ifdef NO_POSIX_GOODIES
+int can_daemonize(void)
+{
+	return 0;
+}
+
 int daemonize(void)
 {
-#ifdef NO_POSIX_GOODIES
 	errno =3D ENOSYS;
 	return -1;
+}
 #else
+int can_daemonize(void)
+{
+	return 1;
+}
+
+int daemonize(void)
+{
 	switch (fork()) {
 		case 0:
 			break;
@@ -1054,5 +1067,5 @@ int daemonize(void)
 	close(2);
 	sanitize_stdfds();
 	return 0;
-#endif
 }
+#endif /* #ifdef NO_POSIX_GOODIES */
--=20
2.8.2.356.ge684b1d
