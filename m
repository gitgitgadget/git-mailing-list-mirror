From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 5/9] transport-helper: fix pushing with straight refspec
Date: Sat, 24 Nov 2012 04:25:16 +0100
Message-ID: <1353727520-26039-6-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nh-0006y1-W4
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932620Ab2KXDZw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:52 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2KXDZv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:51 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=SO9uqBgje0SGNFRcf7VYyJs5wOHGz3qxwtvS/jaBLNw=;
        b=c8tYhl0NJcwoMFwktgL40+m4LUGBxWS1xw2Kvv1sjs8Za/GQMiwidgQwGdxCc5p9Ur
         FStxjP+u2B+BDB8pbrQt0aRfDfJoBEYJHeRAt/+4fWA5QVUgvSE+1aS5RyspuNhDhBSy
         VTP0gujYaZYdZ5p7yiJYy5R7dAJ2XLdtr5vFZ3OaRHnaG58vYwOxwXy5Gf1gK8jjHp0g
         ADczKfYoc6dUy9BSr05F/Rw00GE3fVoCkbrVCePA1LC2m92nSItafvyFFDKX1JhLHiBm
         V1vDmQVe6X+iCbzzjz0OM3+fOxqKwAI1fBEHvSAlYrKOwc20k01TnfHnu8PTCH5z6fYQ
         UIUw==
Received: by 10.204.148.195 with SMTP id q3mr1648254bkv.122.1353727550429;
        Fri, 23 Nov 2012 19:25:50 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id i20sm5468560bkw.5.2012.11.23.19.25.48
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:49 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210304>

For example '*:*'.

Obviously '^refs/heads/master refs/heads/master' is not going to work,
so lets check that the ref we are negating is not the same we are
pushing.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index b268cd2..9c7871b 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -126,7 +126,7 @@ test_expect_success 'pulling with straight refspec' '
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pushing with straight refspec' '
+test_expect_success 'pushing with straight refspec' '
 	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
diff --git a/transport-helper.c b/transport-helper.c
index 899eb36..6dbb72e 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -784,7 +784,7 @@ static int push_refs_with_export(struct transport *transport,
 		if (!data->refspecs)
 			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
-		if (private && !get_sha1(private, sha1)) {
+		if (private && strcmp(private, ref->name) && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
 		}
-- 
1.8.0
