From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH v3 2/8] upload-pack: simplify request validation
Date: Wed, 30 Jan 2013 10:45:36 -0800
Message-ID: <1359571542-19852-3-git-send-email-gitster@pobox.com>
References: <1359571542-19852-1-git-send-email-gitster@pobox.com>
Cc: Jeff King <peff@peff.net>, Shawn Pearce <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 30 19:46:37 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0cg3-0004fU-8f
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 19:46:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756662Ab3A3Spw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 13:45:52 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:33666 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756650Ab3A3Sps (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 13:45:48 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 42F02C3FA;
	Wed, 30 Jan 2013 13:45:48 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; s=sasl; bh=xWAW
	Uj8w8jjcLrhWa0mzVOkbu2g=; b=BGMD57czqMd8NV29gB0r/fgZG4HAdDo8SyKc
	Je1euC0tTaUuAUpLU8qlKUxqO0iCPPbpuio4nI/yF8bSMROp1SjO3yqv0K5FzYfz
	bz28zqQkzqFjZhmVgJ1xkziERbZVbcpH/FgQDgKNFCAF7fRg/fWWdTusIAHOu4oI
	RuOiFFs=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:in-reply-to:references; q=dns; s=sasl; b=
	uT1Tv8krRoNOHjDq15ESKKzXijeZDuA7gsX1RXBBrBuzvFRxCyGGLmQatgVLvVFi
	uN5g4MbDcrcfQ/PB9m8Ug9T7RUOsCu6QyoJoncb6gJpu1XlANVk23gk3mwBLsAI5
	oQB9ZFfKNWRMVL8zzHSJkyKhTwZ6xcoQo/4CICBxdYs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3841CC3F9;
	Wed, 30 Jan 2013 13:45:48 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 96AD5C3F6; Wed, 30 Jan 2013
 13:45:47 -0500 (EST)
X-Mailer: git-send-email 1.8.1.2.589.ga9b91ac
In-Reply-To: <1359571542-19852-1-git-send-email-gitster@pobox.com>
X-Pobox-Relay-ID: 42EEE28A-6B0D-11E2-9323-F0CE2E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215050>

Long time ago, we used to punt on a large (read: asking for more
than 256 refs) fetch request and instead sent a full pack, because
we couldn't fit many refs on the command line of rev-list we run
internally to enumerate the objects to be sent.  To fix this,
565ebbf (upload-pack: tighten request validation., 2005-10-24),
added a check to count the number of refs in the request and matched
with the number of refs we advertised, and changed the invocation of
rev-list to pass "--all" to it, still keeping us under the command
line argument limit.

However, these days we feed the list of objects requested and the
list of objects the other end is known to have via standard input,
so there is no longer a valid reason to special case a full clone
request.  Remove the code associated with "create_full_pack" to
simplify the logic.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 upload-pack.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/upload-pack.c b/upload-pack.c
index 3dd220d..3a26a7b 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -28,7 +28,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<
 
 static unsigned long oldest_have;
 
-static int multi_ack, nr_our_refs;
+static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
 static int no_progress, daemon_mode;
@@ -139,7 +139,6 @@ static void create_pack_file(void)
 {
 	struct async rev_list;
 	struct child_process pack_objects;
-	int create_full_pack = (nr_our_refs == want_obj.nr && !have_obj.nr);
 	char data[8193], progress[128];
 	char abort_msg[] = "aborting due to possible repository "
 		"corruption on the remote side.";
@@ -151,9 +150,7 @@ static void create_pack_file(void)
 	argv[arg++] = "pack-objects";
 	if (!shallow_nr) {
 		argv[arg++] = "--revs";
-		if (create_full_pack)
-			argv[arg++] = "--all";
-		else if (use_thin_pack)
+		if (use_thin_pack)
 			argv[arg++] = "--thin";
 	}
 
@@ -185,15 +182,15 @@ static void create_pack_file(void)
 	}
 	else {
 		FILE *pipe_fd = xfdopen(pack_objects.in, "w");
-		if (!create_full_pack) {
-			int i;
-			for (i = 0; i < want_obj.nr; i++)
-				fprintf(pipe_fd, "%s\n", sha1_to_hex(want_obj.objects[i].item->sha1));
-			fprintf(pipe_fd, "--not\n");
-			for (i = 0; i < have_obj.nr; i++)
-				fprintf(pipe_fd, "%s\n", sha1_to_hex(have_obj.objects[i].item->sha1));
-		}
+		int i;
 
+		for (i = 0; i < want_obj.nr; i++)
+			fprintf(pipe_fd, "%s\n",
+				sha1_to_hex(want_obj.objects[i].item->sha1));
+		fprintf(pipe_fd, "--not\n");
+		for (i = 0; i < have_obj.nr; i++)
+			fprintf(pipe_fd, "%s\n",
+				sha1_to_hex(have_obj.objects[i].item->sha1));
 		fprintf(pipe_fd, "\n");
 		fflush(pipe_fd);
 		fclose(pipe_fd);
@@ -727,10 +724,7 @@ static int mark_our_ref(const char *refname, const unsigned char *sha1, int flag
 	struct object *o = lookup_unknown_object(sha1);
 	if (!o)
 		die("git upload-pack: cannot find object %s:", sha1_to_hex(sha1));
-	if (!(o->flags & OUR_REF)) {
-		o->flags |= OUR_REF;
-		nr_our_refs++;
-	}
+	o->flags |= OUR_REF;
 	return 0;
 }
 
-- 
1.8.1.2.589.ga9b91ac
