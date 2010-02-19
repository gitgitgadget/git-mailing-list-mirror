From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/7] Make 'git var GIT_PAGER' always print the configured
 pager
Date: Fri, 19 Feb 2010 01:00:53 -0600
Message-ID: <20100219070053.GB29916@progeny.tock>
References: <20100219065010.GA22258@progeny.tock>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Sebastian Celis <sebastian@sebastiancelis.com>,
	Jeff King <peff@peff.net>, Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j6t@kdbg.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 19 08:00:56 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NiMr8-0006FP-Q8
	for gcvg-git-2@lo.gmane.org; Fri, 19 Feb 2010 08:00:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753986Ab0BSHAq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 19 Feb 2010 02:00:46 -0500
Received: from mail-yw0-f197.google.com ([209.85.211.197]:41931 "EHLO
	mail-yw0-f197.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753670Ab0BSHAp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Feb 2010 02:00:45 -0500
Received: by ywh35 with SMTP id 35so1806871ywh.4
        for <git@vger.kernel.org>; Thu, 18 Feb 2010 23:00:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=4tvTOEZr/y+jxZvM/lC+Bo9YoIlChc3pnplbmVaPx7I=;
        b=dV+/JIQ8U/yFFTbkyDzNhvQsrrmY7nNjqG1YyBphQx9bFWbtJuPhcXqyIz6fN9IC3j
         xzqVl3wVLUR9AG8fhWx1jK45lHBZpJLCS5LfBqiTGNhLrqye+equCHaMO+gJNUPRNYTj
         ls5LRuQp/NBThdPzubhmL+NBWaCrKdgYKhVH4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=K5QgpQzH8q+pCna62bLOnLW0pw0Av4L7DuLJ89KkNsj0YbvuGv+V4SmbnT6NYhOCMY
         VvAmhcE7Zumj8Q+kiqk/MCrgxX1DywBZS3IRMF/leF+UjfjHrA9bcg21sZNLQg4JxxFz
         71P2gWOhuhTeXiXZeY+WnTIi100o1D6QSNhIs=
Received: by 10.90.10.38 with SMTP id 38mr6666682agj.74.1266562844666;
        Thu, 18 Feb 2010 23:00:44 -0800 (PST)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id 15sm1265258gxk.2.2010.02.18.23.00.43
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 18 Feb 2010 23:00:44 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20100219065010.GA22258@progeny.tock>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140418>

Scripted commands that want to use git=E2=80=99s configured pager know =
better
than =E2=80=98git var=E2=80=99 does whether stdout is going to be a tty=
 at the
appropriate time.  Checking isatty(1) as git_pager() does now won=E2=80=
=99t
cut it, since the output of git var itself is almost never a terminal.
The symptom is that when used by humans, =E2=80=98git var GIT_PAGER=E2=80=
=99 behaves
as it should, but when used by scripts, it always returns =E2=80=98cat=E2=
=80=99!

So avoid tricks with isatty() and just always print the configured
pager.

This does not fix callers to check isatty(1) themselves yet.
Nevertheless, this patch alone is enough to fix 'am --interactive',
since as an interactive command its behavior before before dec543
(2009-10-30) was to always paginate.

There are unfortunately no tests for am --interactive or git svn log
in the test suite, so test suite runs would detect none of this.

Thanks to Sebastian Celis for the report and Jeff King for the
analysis.

Reported-by: Sebastian Celis <sebastian@sebastiancelis.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
This commit message should be clearer, I hope.

 builtin-var.c |    2 +-
 cache.h       |    2 +-
 pager.c       |    6 +++---
 3 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/builtin-var.c b/builtin-var.c
index e6ee7bc..70fdb4d 100644
--- a/builtin-var.c
+++ b/builtin-var.c
@@ -20,7 +20,7 @@ static const char *editor(int flag)
=20
 static const char *pager(int flag)
 {
-	const char *pgm =3D git_pager();
+	const char *pgm =3D git_pager(1);
=20
 	if (!pgm)
 		pgm =3D "cat";
diff --git a/cache.h b/cache.h
index d478eff..d454b7e 100644
--- a/cache.h
+++ b/cache.h
@@ -775,7 +775,7 @@ extern const char *git_committer_info(int);
 extern const char *fmt_ident(const char *name, const char *email, cons=
t char *date_str, int);
 extern const char *fmt_name(const char *name, const char *email);
 extern const char *git_editor(void);
-extern const char *git_pager(void);
+extern const char *git_pager(int stdout_is_tty);
=20
 struct checkout {
 	const char *base_dir;
diff --git a/pager.c b/pager.c
index 2c7e8ec..dac358f 100644
--- a/pager.c
+++ b/pager.c
@@ -48,11 +48,11 @@ static void wait_for_pager_signal(int signo)
 	raise(signo);
 }
=20
-const char *git_pager(void)
+const char *git_pager(int stdout_is_tty)
 {
 	const char *pager;
=20
-	if (!isatty(1))
+	if (!stdout_is_tty)
 		return NULL;
=20
 	pager =3D getenv("GIT_PAGER");
@@ -73,7 +73,7 @@ const char *git_pager(void)
=20
 void setup_pager(void)
 {
-	const char *pager =3D git_pager();
+	const char *pager =3D git_pager(isatty(1));
=20
 	if (!pager)
 		return;
--=20
1.7.0
