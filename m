From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH] transport-helper: barf when user tries old:new
Date: Mon, 20 May 2013 20:02:45 -0500
Message-ID: <1369098165-8727-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Jeff King <peff@peff.net>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue May 21 03:04:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ueb04-0004lk-6e
	for gcvg-git-2@plane.gmane.org; Tue, 21 May 2013 03:04:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755855Ab3EUBEU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 May 2013 21:04:20 -0400
Received: from mail-ob0-f177.google.com ([209.85.214.177]:40035 "EHLO
	mail-ob0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753386Ab3EUBET (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 May 2013 21:04:19 -0400
Received: by mail-ob0-f177.google.com with SMTP id wn6so76022obc.8
        for <git@vger.kernel.org>; Mon, 20 May 2013 18:04:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:x-mailer;
        bh=xHOnknG0UoGOsfDqGh8bXF26w617XT7xJxN1I733G50=;
        b=rwqVZO9EFHpfnF3XYf/uwXqiwzg3hihcRWwd4MG7xg0s9bKhLtaEk/oTMhd3nmjlBF
         Ypw1eUVCC+nHU9m4BL4sRSbvXnrfi8BoEKb6JdjCxKHxu0/HXz8ePcT7PA2twfcjtfA2
         lqmabcMY4agD6j7R9OpnpYBnIncfY++iw9QMBf4zHgkIbsyQfKV3JaLMRPlfZWLWEd8x
         isCZDd4b4qsAZnXMnnkPWjElCSFqb3XKttbZTzTBqo9wmCPD/sIX7WwOTXIkRGxS27ne
         2FzdEb30+PxcMinsgM+Ec/xCvw7nW2kHdVmgSoNHUdqw5eCcOt2TrMQi6rFtZIRhjsck
         wv9g==
X-Received: by 10.60.79.33 with SMTP id g1mr58776oex.51.1369098259186;
        Mon, 20 May 2013 18:04:19 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id q4sm373750obl.1.2013.05.20.18.04.17
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 20 May 2013 18:04:18 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc3.1.gf572ce5.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225008>

Otherwise with certain remote helpers (the ones that support 'export'),
the users will be pushing to the wrong branch:

  git push topic:master

Will push the topic branch, as if the user typed:

  git push topic

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---

I did fix this properly, but was beaten by shoots from the hip[1]. I won't
bother rationalizing if this makes sense for 'master', or writing tests. This
patch can't possibly make anything worst. If somebody is interested, there's
proper fix: [1], with explanation, tests, and everything.

[1] http://article.gmane.org/gmane.comp.version-control.git/223706

 transport-helper.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/transport-helper.c b/transport-helper.c
index 522d791..a782a9b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -813,9 +813,11 @@ static int push_refs_with_export(struct transport *transport,
 			die("remote-helpers do not support ref deletion");
 		}
 
-		if (ref->peer_ref)
+		if (ref->peer_ref) {
+			if (strcmp(ref->peer_ref->name, ref->name))
+				die("remote-helpers do not support old:new syntax");
 			string_list_append(&revlist_args, ref->peer_ref->name);
-
+		}
 	}
 
 	if (get_exporter(transport, &exporter, &revlist_args))
-- 
1.8.3.rc3.1.gf572ce5.dirty
