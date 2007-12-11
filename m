From: Christian Couder <chriscool@tuxfamily.org>
Subject: Re: [PATCH 0/3] git-help -i (info): finishing touches
Date: Tue, 11 Dec 2007 06:22:51 +0100
Message-ID: <200712110622.51583.chriscool@tuxfamily.org>
References: <1197279969-10613-1-git-send-email-gitster@pobox.com> <7v8x42n9s4.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, David Kastrup <dak@gnu.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Dec 11 06:16:57 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1xUF-0003Bu-Bf
	for gcvg-git-2@gmane.org; Tue, 11 Dec 2007 06:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751645AbXLKFQe convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 11 Dec 2007 00:16:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751563AbXLKFQe
	(ORCPT <rfc822;git-outgoing>); Tue, 11 Dec 2007 00:16:34 -0500
Received: from smtp1-g19.free.fr ([212.27.42.27]:41549 "EHLO smtp1-g19.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbXLKFQd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 11 Dec 2007 00:16:33 -0500
Received: from smtp1-g19.free.fr (localhost.localdomain [127.0.0.1])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 6BC571AB2B3;
	Tue, 11 Dec 2007 06:16:31 +0100 (CET)
Received: from bureau.boubyland (gre92-7-82-243-130-161.fbx.proxad.net [82.243.130.161])
	by smtp1-g19.free.fr (Postfix) with ESMTP id 44AA11AB2B2;
	Tue, 11 Dec 2007 06:16:31 +0100 (CET)
User-Agent: KMail/1.9.7
In-Reply-To: <7v8x42n9s4.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67789>

Le lundi 10 d=E9cembre 2007, Junio C Hamano a =E9crit :
> Junio C Hamano <gitster@pobox.com> writes:
> > This series attempts to add finishing touches to "git help -i" (inf=
o)
> > support.

It looks like the patch series you talk about was not sent to the list.

In the last patch there is:

diff --git a/help.c b/help.c
index 9d7ad6f..c96b167 100644
--- a/help.c
+++ b/help.c
@@ -286,6 +286,7 @@ static void show_man_page(const char *git_cmd)
 static void show_info_page(const char *git_cmd)
 {
        const char *page =3D cmd_to_page(git_cmd);
+       setenv("INFOPATH", GIT_INFO_PATH, 1);
        execlp("info", "info", "gitman", page, NULL);
 }

But I wonder if something like this would be better:

diff --git a/help.c b/help.c
index c96b167..933d850 100644
--- a/help.c
+++ b/help.c
@@ -255,23 +255,23 @@ static const char *cmd_to_page(const char *git_cm=
d)
        }
 }

-static void setup_man_path(void)
+static void prepend_to_env_path(const char *name, const char *value)
 {
        struct strbuf new_path;
-       const char *old_path =3D getenv("MANPATH");
+       const char *old_path =3D getenv(name);

        strbuf_init(&new_path, 0);

        /* We should always put ':' after our path. If there is no
-        * old_path, the ':' at the end will let 'man' to try
-        * system-wide paths after ours to find the manual page. If
+        * old_path, the ':' at the end will let some commands
+        * like 'man' to try system-wide paths after ours. If
         * there is old_path, we need ':' as delimiter. */
-       strbuf_addstr(&new_path, GIT_MAN_PATH);
+       strbuf_addstr(&new_path, value);
        strbuf_addch(&new_path, ':');
        if (old_path)
                strbuf_addstr(&new_path, old_path);

-       setenv("MANPATH", new_path.buf, 1);
+       setenv(name, new_path.buf, 1);

        strbuf_release(&new_path);
 }
@@ -279,14 +279,14 @@ static void setup_man_path(void)
 static void show_man_page(const char *git_cmd)
 {
        const char *page =3D cmd_to_page(git_cmd);
-       setup_man_path();
+       prepend_to_env_path("MANPATH", GIT_MAN_PATH);
        execlp("man", "man", page, NULL);
 }

 static void show_info_page(const char *git_cmd)
 {
        const char *page =3D cmd_to_page(git_cmd);
-       setenv("INFOPATH", GIT_INFO_PATH, 1);
+       prepend_to_env_path("INFOPATH", GIT_INFO_PATH);
        execlp("info", "info", "gitman", page, NULL);
 }

Tell me if you want a proper path.

Christian.
