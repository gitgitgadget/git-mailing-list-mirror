From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 6/7] Export rerere() and launch_editor().
Date: Wed, 19 Sep 2007 16:52:04 -0700
Message-ID: <7vr6kunrh7.fsf@gitster.siamese.dyndns.org>
References: <1190074008617-git-send-email-krh@redhat.com>
	<1190074014548-git-send-email-krh@redhat.com>
	<11900740142347-git-send-email-krh@redhat.com>
	<11900740153845-git-send-email-krh@redhat.com>
	<11900740154136-git-send-email-krh@redhat.com>
	<1190074016669-git-send-email-krh@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Kristian =?utf-8?Q?H=C3=B8gsberg?= <krh@redhat.com>
X-From: git-owner@vger.kernel.org Thu Sep 20 01:52:45 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IY9LX-0004aW-I7
	for gcvg-git-2@gmane.org; Thu, 20 Sep 2007 01:52:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757285AbXISXwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 19 Sep 2007 19:52:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752929AbXISXwL
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Sep 2007 19:52:11 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:59158 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756454AbXISXwK convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 19 Sep 2007 19:52:10 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id AC649136000;
	Wed, 19 Sep 2007 19:52:28 -0400 (EDT)
In-Reply-To: <1190074016669-git-send-email-krh@redhat.com> (Kristian
	=?utf-8?Q?H=C3=B8gsberg's?= message of "Mon, 17 Sep 2007 20:06:47 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/58743>

Kristian H=C3=B8gsberg <krh@redhat.com> writes:

> +/* Export for builtin-commit. */
> +int rerere(void)
> +{
> +	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
> +	int fd;
> +
> +	git_config(git_rerere_config);
> +	if (!is_rerere_enabled())
> +		return 0;
> +
> +	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
> +	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
> +	read_rr(&merge_rr);
> +	return do_plain_rerere(&merge_rr, fd);
> +}

Is it just me who sees a suboptimal cut and paste here?

BTW, [1-5/7] look good so far.

diff --git a/builtin-rerere.c b/builtin-rerere.c
index 29d057c..2f51ae0 100644
--- a/builtin-rerere.c
+++ b/builtin-rerere.c
@@ -415,18 +415,39 @@ static int is_rerere_enabled(void)
 	return 1;
 }
=20
-int cmd_rerere(int argc, const char **argv, const char *prefix)
+static int setup_rerere(struct path_list *merge_rr)
 {
-	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
-	int i, fd =3D -1;
+	int fd;
=20
 	git_config(git_rerere_config);
 	if (!is_rerere_enabled())
-		return 0;
+		return -1;
=20
 	merge_rr_path =3D xstrdup(git_path("rr-cache/MERGE_RR"));
 	fd =3D hold_lock_file_for_update(&write_lock, merge_rr_path, 1);
-	read_rr(&merge_rr);
+	read_rr(merge_rr);
+	return fd;
+}
+
+int rerere(void)
+{
+	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
+	int fd;
+
+	fd =3D setup_rerere(&merge_rr);
+	if (fd < 0)
+		return 0;
+	return do_plain_rerere(&merge_rr, fd);
+}
+
+int cmd_rerere(int argc, const char **argv, const char *prefix)
+{
+	struct path_list merge_rr =3D { NULL, 0, 0, 1 };
+	int i, fd;
+
+	fd =3D setup_rerere(&merge_rr);
+	if (fd < 0)
+		return 0;
=20
 	if (argc < 2)
 		return do_plain_rerere(&merge_rr, fd);
