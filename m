From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] bundle: split out a helper function to compute and write prerequisites
Date: Thu, 30 Oct 2014 11:08:17 -0700
Message-ID: <xmqqh9ylwhv2.fsf_-_@gitster.dls.corp.google.com>
References: <54500212.7040603@web.de> <20141029172109.GA32234@peff.net>
	<xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 30 19:08:42 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Xju9F-0006hH-AE
	for gcvg-git-2@plane.gmane.org; Thu, 30 Oct 2014 19:08:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759170AbaJ3SId (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Oct 2014 14:08:33 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52431 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1758787AbaJ3SIU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Oct 2014 14:08:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 8BF9C199D4;
	Thu, 30 Oct 2014 14:08:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=KjA/asSf7jDcuiLznsTxgXY24WU=; b=mbI5LS
	tgHYYyUt7IYh9/WSp3oqzqCq+Szva/Z+fzhuMOE86Z8vTkFi4/CfKWFYAs4IAPX7
	Vq2AEAB4IAUzAmwQgpr8qWsKsQ+2E3Pz/7bAR2Fx4J2hxVwmWDxdEoq2VUJMVVcU
	LW14o9kZ/Va0G4yJ89WCMqR4A3qLOwENGULM8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xdTcicegsDrv7CoXnl2YXxIL2dDx4lje
	8Wk8mxRB7ensqpqtAv6KEj4+t3TSEXFyGTawggVPGVjlPWJBnehOE3zTlvobRuZK
	zjZwFGEubLC5+dfmmnp27kNnMng0HPIT+GI6f6UR+/KDHz+evnG7utXCAWki4927
	mrbkEIoUoms=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80C64199D3;
	Thu, 30 Oct 2014 14:08:19 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 01DC7199D2;
	Thu, 30 Oct 2014 14:08:18 -0400 (EDT)
In-Reply-To: <xmqqlhnyy9e2.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 29 Oct 2014 12:16:05 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: BA384B80-605F-11E4-9BC0-692F9F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The new helper compute_and_write_prerequistes() is ugly, but it
cannot be avoided.  Ideally we should avoid a function that computes
and does I/O at the same time, but the prerequisites lines in the
output needs the human readable title only to help the recipient of
the bundle.  The code copies them straight from the rev-list output
and immediately discards as no other internal computation needs that
information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * And this is to address the first one in the three-bullet list.

 bundle.c | 59 +++++++++++++++++++++++++++++++++++------------------------
 1 file changed, 35 insertions(+), 24 deletions(-)

diff --git a/bundle.c b/bundle.c
index 9c87532..0ca8737 100644
--- a/bundle.c
+++ b/bundle.c
@@ -270,33 +270,15 @@ static int write_pack_data(int bundle_fd, struct lock_file *lock, struct rev_inf
 	return 0;
 }
 
-int create_bundle(struct bundle_header *header, const char *path,
-		  int argc, const char **argv)
+static int compute_and_write_prerequistes(int bundle_fd,
+					  struct rev_info *revs,
+					  int argc, const char **argv)
 {
-	static struct lock_file lock;
-	int bundle_fd = -1;
-	int bundle_to_stdout;
-	int i, ref_count = 0;
-	struct strbuf buf = STRBUF_INIT;
-	struct rev_info revs;
 	struct child_process rls = CHILD_PROCESS_INIT;
+	struct strbuf buf = STRBUF_INIT;
 	FILE *rls_fout;
+	int i;
 
-	bundle_to_stdout = !strcmp(path, "-");
-	if (bundle_to_stdout)
-		bundle_fd = 1;
-	else
-		bundle_fd = hold_lock_file_for_update(&lock, path,
-						      LOCK_DIE_ON_ERROR);
-
-	/* write signature */
-	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
-
-	/* init revs to list objects for pack-objects later */
-	save_commit_buffer = 0;
-	init_revisions(&revs, NULL);
-
-	/* write prerequisites */
 	argv_array_pushl(&rls.args,
 			 "rev-list", "--boundary", "--pretty=oneline",
 			 NULL);
@@ -314,7 +296,7 @@ int create_bundle(struct bundle_header *header, const char *path,
 			if (!get_sha1_hex(buf.buf + 1, sha1)) {
 				struct object *object = parse_object_or_die(sha1, buf.buf);
 				object->flags |= UNINTERESTING;
-				add_pending_object(&revs, object, buf.buf);
+				add_pending_object(revs, object, buf.buf);
 			}
 		} else if (!get_sha1_hex(buf.buf, sha1)) {
 			struct object *object = parse_object_or_die(sha1, buf.buf);
@@ -325,6 +307,35 @@ int create_bundle(struct bundle_header *header, const char *path,
 	fclose(rls_fout);
 	if (finish_command(&rls))
 		return error(_("rev-list died"));
+	return 0;
+}
+
+int create_bundle(struct bundle_header *header, const char *path,
+		  int argc, const char **argv)
+{
+	static struct lock_file lock;
+	int bundle_fd = -1;
+	int bundle_to_stdout;
+	int i, ref_count = 0;
+	struct rev_info revs;
+
+	bundle_to_stdout = !strcmp(path, "-");
+	if (bundle_to_stdout)
+		bundle_fd = 1;
+	else
+		bundle_fd = hold_lock_file_for_update(&lock, path,
+						      LOCK_DIE_ON_ERROR);
+
+	/* write signature */
+	write_or_die(bundle_fd, bundle_signature, strlen(bundle_signature));
+
+	/* init revs to list objects for pack-objects later */
+	save_commit_buffer = 0;
+	init_revisions(&revs, NULL);
+
+	/* write prerequisites */
+	if (compute_and_write_prerequistes(bundle_fd, &revs, argc, argv))
+		return -1;
 
 	/* write references */
 	argc = setup_revisions(argc, argv, &revs, NULL);
-- 
2.1.3-612-g493e79e
