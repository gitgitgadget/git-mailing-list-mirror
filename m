From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 p2 6/9] transport-helper: fix push without marks
Date: Sat, 24 Nov 2012 04:25:17 +0100
Message-ID: <1353727520-26039-7-git-send-email-felipe.contreras@gmail.com>
References: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Elijah Newren <newren@gmail.com>,
	Thiago Farina <tfransosi@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 24 04:26:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tc6Nj-0006y1-Hz
	for gcvg-git-2@plane.gmane.org; Sat, 24 Nov 2012 04:26:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932628Ab2KXDZz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 Nov 2012 22:25:55 -0500
Received: from mail-bk0-f46.google.com ([209.85.214.46]:39227 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932609Ab2KXDZy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 Nov 2012 22:25:54 -0500
Received: by mail-bk0-f46.google.com with SMTP id q16so4063663bkw.19
        for <git@vger.kernel.org>; Fri, 23 Nov 2012 19:25:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Io5ex7qbGOGGJpzFB2p74YrHWQNWRvirPquGfl39wQo=;
        b=x5IetfBxV2S0zW6Nr5N9xafbhsczzJrtxYnqtZsTXDlIli/3NFo0Z4ppndC9WPxaoq
         e8Vo6dykFI9CZ7Yq/X9ffjq94HSQ3n95HAVl9I+1KHlpYU6yTLyscNnaBh+tpEJJ2mbd
         hdhxEkFtcvXo4tMs+RJPf+QGgq4Mz6zvaaiQyXAU7pcp4wyfWUd2KQjCuRMQsf/oZDpm
         Eg9ZrmNzwe2BFQ32aaSzBNqCgT6T9AXRbthZGTYMZgEtoAEBRqqw6j5i4dy3CKcXGS1Y
         2DA6Jy3Uf7BNLt81Pto7juMSH08sVtHPnqAWNp5iQ41tByYSjVOZ72u4R8ywR5KRgnuI
         iqxA==
Received: by 10.204.157.152 with SMTP id b24mr1685351bkx.92.1353727553799;
        Fri, 23 Nov 2012 19:25:53 -0800 (PST)
Received: from localhost (ip-109-43-0-90.web.vodafone.de. [109.43.0.90])
        by mx.google.com with ESMTPS id d16sm5471436bkw.2.2012.11.23.19.25.52
        (version=TLSv1/SSLv3 cipher=OTHER);
        Fri, 23 Nov 2012 19:25:52 -0800 (PST)
X-Mailer: git-send-email 1.8.0
In-Reply-To: <1353727520-26039-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210306>

There's not much to do when marks are not available, except pushing
everything, so let's do so by avoiding the negative refs (e.g.
^refs/testgit/origin/master).

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh | 2 +-
 transport-helper.c        | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 9c7871b..456303b 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -141,7 +141,7 @@ test_expect_success 'pulling without marks' '
 	compare_refs local2 HEAD server HEAD
 '
 
-test_expect_failure 'pushing without marks' '
+test_expect_success 'pushing without marks' '
 	test_when_finished "(cd local2 && git reset --hard origin)" &&
 	(cd local2 &&
 	echo content >>file &&
diff --git a/transport-helper.c b/transport-helper.c
index 6dbb72e..78e4e82 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -781,7 +781,7 @@ static int push_refs_with_export(struct transport *transport,
 		if (ref->peer_ref)
 			string_list_append(&revlist_args, ref->peer_ref->name);
 
-		if (!data->refspecs)
+		if (!data->refspecs || !data->import_marks)
 			continue;
 		private = apply_refspecs(data->refspecs, data->refspec_nr, ref->name);
 		if (private && strcmp(private, ref->name) && !get_sha1(private, sha1)) {
-- 
1.8.0
