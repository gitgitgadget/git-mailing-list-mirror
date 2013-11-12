From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [PATCH v6 07/10] transport-helper: add support for old:new refspec
Date: Tue, 12 Nov 2013 14:57:03 -0600
Message-ID: <1384289830-5471-11-git-send-email-felipe.contreras@gmail.com>
References: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Cc: Richard Hansen <rhansen@bbn.com>,
	Felipe Contreras <felipe.contreras@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Nov 12 22:05:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgL8w-0008IN-Pb
	for gcvg-git-2@plane.gmane.org; Tue, 12 Nov 2013 22:05:03 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932277Ab3KLVEk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Nov 2013 16:04:40 -0500
Received: from mail-oa0-f41.google.com ([209.85.219.41]:44423 "EHLO
	mail-oa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932253Ab3KLVEd (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Nov 2013 16:04:33 -0500
Received: by mail-oa0-f41.google.com with SMTP id g12so6053449oah.0
        for <git@vger.kernel.org>; Tue, 12 Nov 2013 13:04:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=ZI7ngXHEf35IUrPWjEEqQbkrZafcZvwRAvPeVhAVPBg=;
        b=AIfRlMACGiRGHzMvoYtR60J6zfmJw2yzqV2226FvTtTDdTdchyMbg0Wmz7ydK0KfXL
         jnu0WljFk0cxjKkSyeoRmmLy9qqQL/aYNKtkdyfJ6uAoGwb36P0X+2vjOk+HV6gtI9O4
         7m+IbB8qcDNoWVRYcNtDcDFQnIHSACner4RW766AEphRld8rf2CPYgoeAgbqXfBtdpvP
         I5p4tVVZVcyJdpvB1VCtYzVG2RQ0ZjtxQ2HOhC1MNxk+nDopip6X+H71aXv2P9G+XFe3
         z+FcHzHpDgi3zMubetXhYlejEDmeuBMdJ6QGFUvHJ3AQtp0s4EmAKDSwjd7ZkG7tvAKG
         VAIQ==
X-Received: by 10.182.3.71 with SMTP id a7mr3013871oba.101.1384290272429;
        Tue, 12 Nov 2013 13:04:32 -0800 (PST)
Received: from localhost (187-162-140-241.static.axtel.net. [187.162.140.241])
        by mx.google.com with ESMTPSA id s9sm35387367obu.4.2013.11.12.13.04.30
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 12 Nov 2013 13:04:31 -0800 (PST)
X-Mailer: git-send-email 1.8.4.2+fc1
In-Reply-To: <1384289830-5471-1-git-send-email-felipe.contreras@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237744>

By using fast-export's new --refspec option.

Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
---
 t/t5801-remote-helpers.sh |  2 +-
 transport-helper.c        | 13 ++++++++++---
 2 files changed, 11 insertions(+), 4 deletions(-)

diff --git a/t/t5801-remote-helpers.sh b/t/t5801-remote-helpers.sh
index c33cc25..454337e 100755
--- a/t/t5801-remote-helpers.sh
+++ b/t/t5801-remote-helpers.sh
@@ -87,7 +87,7 @@ test_expect_success 'push new branch by name' '
 	compare_refs local HEAD server refs/heads/new-name
 '
 
-test_expect_failure 'push new branch with old:new refspec' '
+test_expect_success 'push new branch with old:new refspec' '
 	(cd local &&
 	 git push origin new-name:new-refspec
 	) &&
diff --git a/transport-helper.c b/transport-helper.c
index 23af747..2da4259 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -850,7 +850,7 @@ static int push_refs_with_export(struct transport *transport,
 	struct ref *ref;
 	struct child_process *helper, exporter;
 	struct helper_data *data = transport->data;
-	struct string_list revlist_args = STRING_LIST_INIT_NODUP;
+	struct string_list revlist_args = STRING_LIST_INIT_DUP;
 	struct strbuf buf = STRBUF_INIT;
 
 	if (!data->refspecs)
@@ -888,8 +888,13 @@ static int push_refs_with_export(struct transport *transport,
 		free(private);
 
 		if (ref->peer_ref) {
-			if (strcmp(ref->peer_ref->name, ref->name))
-				die("remote-helpers do not support old:new syntax");
+			if (strcmp(ref->name, ref->peer_ref->name)) {
+				struct strbuf buf = STRBUF_INIT;
+				strbuf_addf(&buf, "%s:%s", ref->peer_ref->name, ref->name);
+				string_list_append(&revlist_args, "--refspec");
+				string_list_append(&revlist_args, buf.buf);
+				strbuf_release(&buf);
+			}
 			string_list_append(&revlist_args, ref->peer_ref->name);
 		}
 	}
@@ -897,6 +902,8 @@ static int push_refs_with_export(struct transport *transport,
 	if (get_exporter(transport, &exporter, &revlist_args))
 		die("Couldn't run fast-export");
 
+	string_list_clear(&revlist_args, 1);
+
 	if (finish_command(&exporter))
 		die("Error while running fast-export");
 	push_update_refs_status(data, remote_refs, flags);
-- 
1.8.4.2+fc1
