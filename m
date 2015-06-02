From: Stefan Beller <sbeller@google.com>
Subject: [RFCv2 09/16] remote.h: add get_remote_capabilities, request_capabilities
Date: Mon,  1 Jun 2015 17:02:11 -0700
Message-ID: <1433203338-27493-10-git-send-email-sbeller@google.com>
References: <1433203338-27493-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, gitster@pobox.com, peff@peff.net,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 02 02:05:14 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YzZfV-0000j9-KK
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jun 2015 02:02:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754503AbbFBACt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2015 20:02:49 -0400
Received: from mail-ig0-f179.google.com ([209.85.213.179]:35454 "EHLO
	mail-ig0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754425AbbFBACo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2015 20:02:44 -0400
Received: by igbyr2 with SMTP id yr2so74911520igb.0
        for <git@vger.kernel.org>; Mon, 01 Jun 2015 17:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=zNq0u9MYjpxipqCpN7w3mjmuJFocEUfLGrve1B4NQMc=;
        b=BbIS+mHHgwMfzWQ+Vw3NV+s1rhihhM2N0BPAP6NjtuSi+nyHG54MOsWXr8OPFkIXc9
         GMow5Tgq60K0R9HaBrDut9xziHrW+YUVBOcowv1F6F9N+91RFK5Kxa/FCgMeR5zg1DK9
         plqY+jNTDuCuUPoxKQS0PKwnZDfnNlKCz+GLdCgDntpTlFv/oczJ4ZcjMPJYDXcoJnIP
         lyHnfCH981Rpl6fxK+Vw2FZwio2riRgTiG9hRrFMzKEw1zHEwVuUt57zacmqXQJuAtNM
         wtvWBx9RvsIG1TWO6ZlsXBGQ3Z7XbfZiGxKwYC2SvBAOxqRpSTvtluDbY7cgYYtkSREi
         8jRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=zNq0u9MYjpxipqCpN7w3mjmuJFocEUfLGrve1B4NQMc=;
        b=CD+xqd0d0UrblJgXhmVhAxTfNmqAvwCyAEANeBl1WyVZ/D9GWg1cwUO5JJfHIjq2Q2
         AqmelnogB6IcmOqqGhlq0phVh3Kc2EbrAAlZN0kyK8fXEWbtDFGnhIwJpBc3u90h4edH
         gOK/u0eZueeGUDknyh4u0C57z8p5CKA/dah+/QM9Ph47rZes5S75OB9euZ17N8B+R+Rr
         u0S5bvgc2iCvmc9vOi66HmPvJQ4x1ChPII93/3EYJjDszkhZxNQaKgKf5RToy+cxv3+T
         SsRmd8qimWN7GUhDSGces5Wo0dmzGK3NgEb+nirASgr7F0e1EmeSWEL7wGic5Tme41tc
         dt6g==
X-Gm-Message-State: ALoCoQl14P6yAxgvo6OkYGXYI5gVG8GmA2mBc89ZmLK+l+R93pdrzhns/PPu3d7frrMf8GYMVBax
X-Received: by 10.107.16.149 with SMTP id 21mr29798301ioq.53.1433203363981;
        Mon, 01 Jun 2015 17:02:43 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:3900:deed:b754:addb])
        by mx.google.com with ESMTPSA id p8sm8906381iga.13.2015.06.01.17.02.43
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 01 Jun 2015 17:02:43 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1433203338-27493-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/270497>

Instead of calling get_remote_heads as a first command during the
protocol exchange, we need to have fine grained control over the
capability negotiation in version 2 of the protocol.

Introduce get_remote_capabilities, which will just listen to
capabilities of the remote and request_capabilities which will
tell the selection of capabilities to the remote.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 connect.c | 37 +++++++++++++++++++++++++++++++++++++
 remote.h  |  3 +++
 2 files changed, 40 insertions(+)

diff --git a/connect.c b/connect.c
index a2c777e..4ebe1dc 100644
--- a/connect.c
+++ b/connect.c
@@ -105,6 +105,43 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
+void get_remote_capabilities(int in, char *src_buf, size_t src_len)
+{
+	string_list_clear(&server_capabilities, 1);
+	for (;;) {
+		int len;
+		char *line = packet_buffer;
+
+		len = packet_read(in, &src_buf, &src_len,
+				  packet_buffer, sizeof(packet_buffer),
+				  PACKET_READ_GENTLE_ON_EOF |
+				  PACKET_READ_CHOMP_NEWLINE);
+		if (len < 0)
+			die_initial_contact(0);
+
+		if (!len)
+			break;
+
+		string_list_append(&server_capabilities, line);
+	}
+}
+
+int request_capabilities(int out, struct transport_options *options)
+{
+	if (options->multi_ack == 2)    packet_write(out, "multi_ack_detailed");
+	if (options->multi_ack == 1)    packet_write(out, "multi_ack");
+	if (options->no_done)           packet_write(out, "no-done");
+	if (options->use_sideband == 2) packet_write(out, "side-band-64k");
+	if (options->use_sideband == 1) packet_write(out, "side-band");
+	if (options->use_thin_pack)     packet_write(out, "thin-pack");
+	if (options->no_progress)       packet_write(out, "no-progress");
+	if (options->include_tag)       packet_write(out, "include-tag");
+	if (options->prefer_ofs_delta)  packet_write(out, "ofs-delta");
+	if (options->agent_supported)   packet_write(out, "agent=%s",
+						     git_user_agent_sanitized());
+	packet_flush(out);
+}
+
 /*
  * Read all the refs from the other end
  */
diff --git a/remote.h b/remote.h
index 3767bed..61619c5 100644
--- a/remote.h
+++ b/remote.h
@@ -165,6 +165,9 @@ extern void get_remote_heads(int in, char *src_buf, size_t src_len,
 			     struct sha1_array *extra_have,
 			     struct sha1_array *shallow);
 
+void get_remote_capabilities(int in, char *src_buf, size_t src_len);
+int request_capabilities(int out, struct transport_options*);
+
 int resolve_remote_symref(struct ref *ref, struct ref *list);
 int ref_newer(const unsigned char *new_sha1, const unsigned char *old_sha1);
 
-- 
2.4.1.345.gab207b6.dirty
