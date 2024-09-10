Received: from aib29agh127.zrh1.oracleemaildelivery.com (aib29agh127.zrh1.oracleemaildelivery.com [192.29.178.127])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E325176252
	for <git@vger.kernel.org>; Tue, 10 Sep 2024 20:44:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.29.178.127
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726001088; cv=none; b=GvEEqxQR/kTSq1wabIrIVgtqV30Fod58RLaNEgAoBvpxCU7p5WWTo81Gzd8tLjZ/4Bq0sRzWusaXBCOqTBUTJDpFCSTBdKNsiWd3gI6g11zvQJepZTBv6Dbrs6sXicKZN1avl1FHRk7I2hgrIPR9wvupA1SYOTe6fBvS3YPM5f8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726001088; c=relaxed/simple;
	bh=b5NrbsBixKD2I1DrQJ1TlOrzd6gVpzK7pQW9yz0tf+o=;
	h=From:To:Cc:Subject:Date:Message-id:In-reply-to:References:
	 MIME-version; b=jiIxvrBPDrP0evUlYOo/QctfcV4cow3HqqIriyh20WC7eKrXO1chCF55ZmwrxXO38mzVrjXMeWM/v3W9jrrTd02jd8QaEZmEGO/MwK2tAlhG7w0fgOKeQVS/I58yGoxiIGqv0jB5gGeSxBUSP9wsOQ5oMteBNIBLjglzXTMstLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com; dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b=nqnJuJTN; arc=none smtp.client-ip=192.29.178.127
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=none dis=none) header.from=ferdinandy.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=zrh1.rp.oracleemaildelivery.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=zrh1.rp.oracleemaildelivery.com header.i=@zrh1.rp.oracleemaildelivery.com header.b="nqnJuJTN"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-zrh-20200406;
 d=zrh1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender:List-Unsubscribe:List-Unsubscribe-Post;
 bh=6U7X65IS9yvt5ArGE0vZuKwRwAVma+9LaJi7Q8pWPzQ=;
 b=nqnJuJTNzql3qYiQL237Dqd9brNIq9W54pyWyQv+b9B2krX4FaPCN6DT/fAuwverZA5ngqryH9fd
   NQntR0l1KjoINPzeeaCyDPPhCGJMgqNwhCpuTw/3NukGSsCYBimuUiO5qFiHN71RH/kIo3KuIp/b
   1fvycWKioCI98SHyPyidSfUgA2tSR6/ZdSaSSBrB7ekvkgMqNHnWCMVuiLhhxvoP8GSJueLEE60j
   4WtJAr8hehCkL4eY4PpBJbJ831PNGCOpe8ntJWKxJJtM+N0k5qhwWRwaBbpMniom15pZpwGzsunF
   aNUCKZVZElo0MOmRzcfXUrxh94eG+SZC24/ruw==
Received: by omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20240709 64bit (built Jul  9
 2024))
 with ESMTPS id <0SJM00F9W6Q09650@omta-ad1-fd3-402-eu-zurich-1.omtaad1.vcndpzrh.oraclevcn.com> for
 git@vger.kernel.org; Tue, 10 Sep 2024 20:39:36 +0000 (GMT)
List-Unsubscribe-Post: List-Unsubscribe=One-Click
From: Bence Ferdinandy <bence@ferdinandy.com>
To: git@vger.kernel.org
Cc: Junio C Hamano <gitster@pobox.com>,	Taylor Blau <me@ttaylorr.com>,
	Patrick Steinhardt <ps@pks.im>,
	=?UTF-8?q?Ren=C3=A9=20Scharfe?= <l.s.r@web.de>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Bence Ferdinandy <bence@ferdinandy.com>
Subject: [RFC PATCH v2 2/2] set-head: do not update if there is no change
Date: Tue, 10 Sep 2024 22:37:14 +0200
Message-id: <20240910203835.2288291-3-bence@ferdinandy.com>
In-reply-to: <20240910203835.2288291-1-bence@ferdinandy.com>
References: <20240910203835.2288291-1-bence@ferdinandy.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-version: 1.0
Content-transfer-encoding: 8bit
Reporting-Meta:
 AAHIA+iLW4+N8FNUHnoGYkiKLbs40IIVsmNPEs115GzgtOnvxOAVQo5dP7oU0E8L
 5HrmiweWSocxnOTcAeMz4JOUZCPureDjUHq0lD5oSUxf2fmQN14iKA7v1SJMfweX
 K1DWQiYie6CMSge1Z1G+aB4xP7uTH6Q8suIBUjNwj6N1PcWPpsWHgq/vTPmWgvRa
 mMly2lDNdrQ9un5CoohhCvoNwntFnPcfMQ21Yp0A85wFFAJQmvnq5QJ5l6VoRdx4
 j3CRqfyY1MK5z739vd5aAzlsahAJE2wGWm6NUaUlVsJYTUZIV8A2Jy7YdKcN5XyF
 mEy/gTKRBrCgTArhOY+1JA5FPaaZk28/cEViPSjy0e2OrtEgo2uroEtDScuRJ1h8
 jNX3hwpTBBoxcYyhpWzAPtrMOJi26Hk2QKcRrEP4rUOtANzXANWuElgoUfF0FldD
 qBaz1shwxEJHnJjP3rnkVbnQYRyyLAojZPtGcBGsk3vePM85lua+r57z

Currently, even if there is no actual change to remote/HEAD calling
remote set-head will overwrite the appropriate file and if set to --auto
will also print a message saying "remote/HEAD set to branch", which
implies something was changed. In contrast, on a nil operation e.g. pull
will clearly state that nothing was done, while fetch will not output
anything.

Change the behaviour of remote set-head so that the reference is only
updated if it actually needs to change. Since set-head --auto is
essentially a fetch-like operation, align it's behaviour with fetch and
only print output if something was actually done.

Signed-off-by: Bence Ferdinandy <bence@ferdinandy.com>
---
 builtin/remote.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 35c54dd103..e220e51b84 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -1400,8 +1400,8 @@ static int show(int argc, const char **argv, const char *prefix)
 
 static int set_head(int argc, const char **argv, const char *prefix)
 {
-	int i, opt_a = 0, opt_d = 0, result = 0;
-	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT;
+	int i, opt_a = 0, opt_d = 0, is_ref_changed = 0, result = 0;
+	struct strbuf buf = STRBUF_INIT, buf2 = STRBUF_INIT, buf3 = STRBUF_INIT;
 	char *head_name = NULL;
 
 	struct option options[] = {
@@ -1440,12 +1440,14 @@ static int set_head(int argc, const char **argv, const char *prefix)
 
 	if (head_name) {
 		strbuf_addf(&buf2, "refs/remotes/%s/%s", argv[0], head_name);
+		refs_read_symbolic_ref(get_main_ref_store(the_repository),buf.buf,&buf3);
+		is_ref_changed = strcmp(buf2.buf,buf3.buf);
 		/* make sure it's valid */
 		if (!refs_ref_exists(get_main_ref_store(the_repository), buf2.buf))
 			result |= error(_("Not a valid ref: %s"), buf2.buf);
-		else if (refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
+		else if (is_ref_changed && refs_update_symref(get_main_ref_store(the_repository), buf.buf, buf2.buf, "remote set-head"))
 			result |= error(_("Could not setup %s"), buf.buf);
-		else if (opt_a)
+		else if (opt_a && is_ref_changed)
 			printf("%s/HEAD set to %s\n", argv[0], head_name);
 		free(head_name);
 	}
-- 
2.46.0

