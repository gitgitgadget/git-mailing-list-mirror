From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] gc: remove gc.pid file at end of execution
Date: Wed, 16 Oct 2013 16:11:46 -0700
Message-ID: <20131016231146.GP9464@google.com>
References: <1380187098-8519-1-git-send-email-Matthieu.Moy@imag.fr>
 <20130928003319.GR9464@google.com>
 <xmqqeh7k6glt.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>, git@vger.kernel.org,
	pclouds@gmail.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Oct 17 01:11:54 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VWaFu-0001GQ-59
	for gcvg-git-2@plane.gmane.org; Thu, 17 Oct 2013 01:11:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760499Ab3JPXLu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 16 Oct 2013 19:11:50 -0400
Received: from mail-pd0-f172.google.com ([209.85.192.172]:62703 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752234Ab3JPXLt (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Oct 2013 19:11:49 -0400
Received: by mail-pd0-f172.google.com with SMTP id z10so1695147pdj.3
        for <git@vger.kernel.org>; Wed, 16 Oct 2013 16:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=Njg/Nf5hNt8ZSRph+p+JMTXfeAmfha1Z5o27ILQYAUw=;
        b=jWVC9TCgevxuEDS0wy6+w3foIZ3tKCBaJvTQEYHnbjbO5hV6v7ollTDvUBHyFfivCh
         W8+zRgjUeSMEVdZx0vAD1y7DqYQ0UYpeNolJlMvvJSJ3fbAG8C4TwTegX1/Kin4m35cU
         EqSLd05mb9GXJIvzvOEj9Ju4tNbwF4k/rvlRGmW+2HSBcCyq2xvgwez9lqFM41stNxfG
         SPsG/XRwGy0fF+1ksMbCPTbijFp7lkTXrKrqHjTucytjBrQyZ1SQYCruXTjI1Yd5nHcc
         /KmmWo63myE+XFKGQBY4NT+YGB9NA5i2jKoQPxl7Eodd/+IRezBB+t4l1S/mxHb10MlH
         KKSQ==
X-Received: by 10.66.66.202 with SMTP id h10mr6048409pat.70.1381965109032;
        Wed, 16 Oct 2013 16:11:49 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id xs1sm109542591pac.7.1969.12.31.16.00.00
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 16 Oct 2013 16:11:48 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqeh7k6glt.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236283>

This file isn't really harmful, but isn't useful either, and can create
minor annoyance for the user:

* It's confusing, as the presence of a *.pid file often implies that a
  process is currently running. A user running "ls .git/" and finding
  this file may incorrectly guess that a "git gc" is currently running.

* Leaving this file means that a "git gc" in an already gc-ed repo is
  no-longer a no-op. A user running "git gc" in a set of repositories,
  and then synchronizing this set (e.g. rsync -av, unison, ...) will se=
e
  all the gc.pid files as changed, which creates useless noise.

This patch unlinks the file after the garbage collection is done, so th=
at
gc.pid is actually present only during execution.

=46uture versions of Git may want to use the information left in the gc=
=2Epid
file (e.g. for policies like "don't attempt to run a gc if one has
already been ran less than X hours ago"). If so, this patch can safely =
be
reverted. For now, let's not bother the users.

Explained-by: Matthieu Moy <Matthieu.Moy@imag.fr>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Improved-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.c=
om>
---
Junio C Hamano wrote:

> Has anything further happened to this discussion?

Here's a patch implementing Duy's suggestion.

 builtin/gc.c  | 24 ++++++++++++++++++++++++
 t/t6500-gc.sh |  5 +++++
 2 files changed, 29 insertions(+)

diff --git a/builtin/gc.c b/builtin/gc.c
index 891a2c2..c14190f 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -14,6 +14,7 @@
 #include "cache.h"
 #include "parse-options.h"
 #include "run-command.h"
+#include "sigchain.h"
 #include "argv-array.h"
=20
 #define FAILED_RUN "failed to run %s"
@@ -35,6 +36,21 @@ static struct argv_array repack =3D ARGV_ARRAY_INIT;
 static struct argv_array prune =3D ARGV_ARRAY_INIT;
 static struct argv_array rerere =3D ARGV_ARRAY_INIT;
=20
+static char *pidfile;
+
+static void remove_pidfile(void)
+{
+	if (pidfile)
+		unlink(pidfile);
+}
+
+static void remove_pidfile_on_signal(int signo)
+{
+	remove_pidfile();
+	sigchain_pop(signo);
+	raise(signo);
+}
+
 static int gc_config(const char *var, const char *value, void *cb)
 {
 	if (!strcmp(var, "gc.packrefs")) {
@@ -179,6 +195,10 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
 	FILE *fp;
 	int fd, should_exit;
=20
+	if (pidfile)
+		/* already locked */
+		return NULL;
+
 	if (gethostname(my_host, sizeof(my_host)))
 		strcpy(my_host, "unknown");
=20
@@ -219,6 +239,10 @@ static const char *lock_repo_for_gc(int force, pid=
_t* ret_pid)
 	strbuf_release(&sb);
 	commit_lock_file(&lock);
=20
+	pidfile =3D git_pathdup("gc.pid");
+	sigchain_push_common(remove_pidfile_on_signal);
+	atexit(remove_pidfile);
+
 	return NULL;
 }
=20
diff --git a/t/t6500-gc.sh b/t/t6500-gc.sh
index b1a6365..63194d8 100755
--- a/t/t6500-gc.sh
+++ b/t/t6500-gc.sh
@@ -9,6 +9,11 @@ test_expect_success 'gc empty repository' '
 	git gc
 '
=20
+test_expect_success 'gc does not leave behind pid file' '
+	git gc &&
+	test_path_is_missing .git/gc.pid
+'
+
 test_expect_success 'gc --gobbledegook' '
 	test_expect_code 129 git gc --nonsense 2>err &&
 	test_i18ngrep "[Uu]sage: git gc" err
--=20
1.8.4-50-g437ce60
