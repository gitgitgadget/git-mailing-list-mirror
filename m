From: David Turner <dturner@twopensource.com>
Subject: [PATCH v7 06/19] daemonize(): set a flag before exiting the main process
Date: Fri, 29 Apr 2016 21:02:00 -0400
Message-ID: <1461978133-13966-7-git-send-email-dturner@twopensource.com>
References: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: David Turner <dturner@twopensource.com>
To: git@vger.kernel.org, pclouds@gmail.com
X-From: git-owner@vger.kernel.org Sat Apr 30 03:03:25 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1awJJc-0008GT-2N
	for gcvg-git-2@plane.gmane.org; Sat, 30 Apr 2016 03:03:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753135AbcD3BDT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 29 Apr 2016 21:03:19 -0400
Received: from mail-qk0-f180.google.com ([209.85.220.180]:34559 "EHLO
	mail-qk0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752344AbcD3BCb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2016 21:02:31 -0400
Received: by mail-qk0-f180.google.com with SMTP id r184so53109643qkc.1
        for <git@vger.kernel.org>; Fri, 29 Apr 2016 18:02:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=twopensource-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=z3l1YgXHlC8ImA/K2VLTYEQE2HnZW9YRDLlO01Efaa9JjQmlRsRdJ8sp0vmKDwd+QD
         do93uNf5ii13KZngT246AQwTu5PUUv+GXJtVfcrUtv0xDkPRNhHF2A+mNK05f9tp3yuN
         DZd6wEjRfnJhbnq47f5hf170aX3QcY/jfKyzGjOzhWWom8m3FvsNcpBr1p067oSG5do9
         14UVMWg8LvUHT59dKJgpgtTWC1Z4rJmjR0ggWX2dEOEHKA6XWR78ZTbEJGIyeA9IWn6s
         QJTRIp0O12GkHr/WmL23ctG6GdWeLuA6Z73aymwScPhIdaXw2DGXavAAqg1TPQn6t+/x
         jEAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YWgUhX/x6Lc604mI1EfACARwLR71lPeDNbTsIjhalcI=;
        b=QC3UiLXEgxaYqUeqHu8+HNYPSUb+BfzCda//1SICfn+WtEBkz4RP0pw8IQnk53GEfO
         XCjOAtMKPMO6Nn0xQPCbo8gUgp1PxmJEbhJrJsdpkdyFaQpoAPBew/lr2CyslaPaD4GA
         OEjqzBEzH3+s5tPMIdtya93zW1quTIRLRyfHEn956NOKqsTkowyMO5CApRz2Qh3vtAc8
         FsYi8rm8Z6MxeGb7i9RGJx/KG1jp7/aZRKx0UYbUgjeqOC8qbzV7DRFYDuQOx+hL7o84
         4leRL8plSBXEoB0v0hnpf0N/w+4swUqQKnrV3mRXHGU2uFDkKdMBvcCQKvzEDcypBztH
         G0xw==
X-Gm-Message-State: AOPr4FU8cczrEOrARaMczJiJppeeH0/8YLfLHTDioNrJ+bFcmTKSYstw2AcIxj8lj3eKpw==
X-Received: by 10.55.198.89 with SMTP id b86mr163469qkj.120.1461978150445;
        Fri, 29 Apr 2016 18:02:30 -0700 (PDT)
Received: from ubuntu.twitter.biz ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id g11sm5284485qhg.22.2016.04.29.18.02.29
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 29 Apr 2016 18:02:29 -0700 (PDT)
X-Mailer: git-send-email 2.4.2.767.g62658d5-twtrsrc
In-Reply-To: <1461978133-13966-1-git-send-email-dturner@twopensource.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293117>

=46rom: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail.com>

This allows signal handlers and atexit functions to realize this
situation and not clean up.

Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gmail=
=2Ecom>
Signed-off-by: David Turner <dturner@twopensource.com>
---
 builtin/gc.c | 2 +-
 cache.h      | 2 +-
 daemon.c     | 2 +-
 setup.c      | 4 +++-
 4 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c583aad..37180de 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -385,7 +385,7 @@ int cmd_gc(int argc, const char **argv, const char =
*prefix)
 			 * failure to daemonize is ok, we'll continue
 			 * in foreground
 			 */
-			daemonized =3D !daemonize();
+			daemonized =3D !daemonize(NULL);
 		}
 	} else
 		add_repack_all_option();
diff --git a/cache.h b/cache.h
index 6cb0d02..4c1529a 100644
--- a/cache.h
+++ b/cache.h
@@ -539,7 +539,7 @@ extern int set_git_dir_init(const char *git_dir, co=
nst char *real_git_dir, int);
 extern int init_db(const char *template_dir, unsigned int flags);
=20
 extern void sanitize_stdfds(void);
-extern int daemonize(void);
+extern int daemonize(int *);
=20
 #define alloc_nr(x) (((x)+16)*3/2)
=20
diff --git a/daemon.c b/daemon.c
index 8d45c33..a5cf954 100644
--- a/daemon.c
+++ b/daemon.c
@@ -1365,7 +1365,7 @@ int main(int argc, char **argv)
 		return execute();
=20
 	if (detach) {
-		if (daemonize())
+		if (daemonize(NULL))
 			die("--detach not supported on this platform");
 	} else
 		sanitize_stdfds();
diff --git a/setup.c b/setup.c
index de1a2a7..9adf13f 100644
--- a/setup.c
+++ b/setup.c
@@ -1017,7 +1017,7 @@ void sanitize_stdfds(void)
 		close(fd);
 }
=20
-int daemonize(void)
+int daemonize(int *daemonized)
 {
 #ifdef NO_POSIX_GOODIES
 	errno =3D ENOSYS;
@@ -1029,6 +1029,8 @@ int daemonize(void)
 		case -1:
 			die_errno("fork failed");
 		default:
+			if (daemonized)
+				*daemonized =3D 1;
 			exit(0);
 	}
 	if (setsid() =3D=3D -1)
--=20
2.4.2.767.g62658d5-twtrsrc
