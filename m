From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [RESEND/PATCH] transport-helper: improve push messages
Date: Fri,  3 May 2013 18:41:59 -0500
Message-ID: <1367624519-12623-1-git-send-email-felipe.contreras@gmail.com>
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	John Keeping <john@keeping.me.uk>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat May 04 01:43:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYPdK-0005mb-IZ
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 01:43:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763886Ab3ECXnS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 19:43:18 -0400
Received: from mail-ye0-f182.google.com ([209.85.213.182]:44281 "EHLO
	mail-ye0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759932Ab3ECXnR (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 19:43:17 -0400
Received: by mail-ye0-f182.google.com with SMTP id m15so378249yen.13
        for <git@vger.kernel.org>; Fri, 03 May 2013 16:43:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:from:to:cc:subject:date:message-id:x-mailer;
        bh=BUJx4vsPMwvf5gZiIfC8014ocG4QKBy4sUMPZYyo/Dc=;
        b=gLGBAL6QWmCpWgtW0xFeBIH5LKVH4YACg1bORpbwoMGQbp6fJSKaZ6VwWjmYN9qemq
         zOCjPFEeMNAPMjCrlg0U8RSROl0SI+OVZAiGDa6T9bWboPITbozg+QWYv2wKNrmKLA4T
         YsWOhWX+m/csTxg/YFa6CirZHKH8gCr3A9JXZKttozpoz9vIJoLd9sMSLvMz/sKR6cW4
         CiBLIc+rJCPaUiymAz38kU9qbvao+uZVy+N671fUFnfZRsDJ49sEHOlmk/mxU/LbP+NO
         b5hSdiJL5PJOhHOAcqzeSlcOM5K31BxdAlHNhpjGA6viVBCknt9HF1YeAXU1U10ImlX4
         WaAw==
X-Received: by 10.236.135.103 with SMTP id t67mr11065521yhi.54.1367624597308;
        Fri, 03 May 2013 16:43:17 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id i44sm24619624yhk.17.2013.05.03.16.43.15
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 03 May 2013 16:43:16 -0700 (PDT)
X-Mailer: git-send-email 1.8.3.rc0.401.g45bba44
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223334>

If there's already a remote-helper tracking ref, we can fetch the SHA-1
to report proper push messages (as opposed to always reporting
[new branch]).

The remote-helper currently can specify the old SHA-1 to avoid this
problem, but there's no point in forcing all remote-helpers to be aware
of git commit ids; they should be able to be agnostic of them.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
Reviewed-by: Jeff King <peff@peff.net>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

I already sent this, but it has had the unfortunate luck of getting stuck with
a bunch of irrelevant patches in 'next'.

This is not only good enough for 'master', but probably even 'maint'.

 t/t5801-remote-helpers.sh | 14 ++++++++++++++
 transport-helper.c        |  1 +
 2 files changed, 15 insertions(+)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index 69212cd..dbb02e2 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -186,4 +186,18 @@ test_expect_success GPG 'push signed tag with signed-tags capability' '
 	compare_refs local signed-tag-2 server signed-tag-2
 '
 
+test_expect_success 'push messages' '
+	(cd local &&
+	git checkout -b new_branch master &&
+	echo new >>file &&
+	git commit -a -m new &&
+	git push origin new_branch &&
+	git fetch origin &&
+	echo new >>file &&
+	git commit -a -m new &&
+	git push origin new_branch 2> msg &&
+	! grep "\[new branch\]" msg
+	)
+'
+
 test_done
diff --git a/transport-helper.c b/transport-helper.c
index 5f8d075..835815f 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -806,6 +806,7 @@ static int push_refs_with_export(struct transport *transport,
 		if (private && !get_sha1(private, sha1)) {
 			strbuf_addf(&buf, "^%s", private);
 			string_list_append(&revlist_args, strbuf_detach(&buf, NULL));
+			hashcpy(ref->old_sha1, sha1);
 		}
 		free(private);
 
-- 
1.8.3.rc0.401.g45bba44
