From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index-pack: add a helper function to derive .idx/.keep filename
Date: Thu, 03 Mar 2016 13:37:18 -0800
Message-ID: <xmqqsi071bw1.fsf@gitster.mtv.corp.google.com>
References: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 03 22:37:26 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1abaw2-0005gh-9d
	for gcvg-git-2@plane.gmane.org; Thu, 03 Mar 2016 22:37:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757792AbcCCVhW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Mar 2016 16:37:22 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:57858 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754573AbcCCVhV (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Mar 2016 16:37:21 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 435414850B;
	Thu,  3 Mar 2016 16:37:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=SmFUn6K2QuBMKB6YNsX/DLRCjGQ=; b=NOjX/J
	TcDNPetGaOuvx+3pjqOFFykmE6Q6CiSv/SPalBATqZGGlSMJ1UJPjoKIu6yuELkq
	Z3PgwcC9js68oB8LHZXLZ5IjJnKyPYt2WWM4f/JZnkW0+qnUTka0pVDn4cy3L4fQ
	/FUD2DJwxMJ39+BYabivKwGYC/L05zPKWx5sI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:subject
	:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=H0UeBL4bPKeCjcvMhI1waMmhZcZ2F+ve
	9qBz3v9zBlhDlzzPDtJQjIlKO/pT5iVsJ4G7hveMLgVS65bExh5qs8h/41l7ypur
	e0SZqfj1faQlO6H+aJqP9x5AthyRnagubF0l65Vxuu4WAJFI3r6yHN3ZhpD3DJl1
	7oZ/oWQFVhE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3AE2B48509;
	Thu,  3 Mar 2016 16:37:20 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id AF9D848508;
	Thu,  3 Mar 2016 16:37:19 -0500 (EST)
In-Reply-To: <xmqq1t7r2x21.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Thu, 03 Mar 2016 11:14:46 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 1B77D668-E188-11E5-9505-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288213>

These are automatically named by replacing .pack suffix in the
name of the packfile.  Add a small helper to do so, as I'll be
adding another one soonish.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin/index-pack.c | 35 +++++++++++++++++------------------
 1 file changed, 17 insertions(+), 18 deletions(-)

diff --git a/builtin/index-pack.c b/builtin/index-pack.c
index 285424f..a5588a2 100644
--- a/builtin/index-pack.c
+++ b/builtin/index-pack.c
@@ -1598,6 +1598,18 @@ static void show_pack_info(int stat_only)
 	}
 }
 
+static const char *derive_filename(const char *pack_name, const char *suffix,
+				   struct strbuf *buf)
+{
+	size_t len;
+	if (!strip_suffix(pack_name, ".pack", &len))
+		die(_("packfile name '%s' does not end with '.pack'"),
+		    pack_name);
+	strbuf_add(buf, pack_name, len);
+	strbuf_addstr(buf, suffix);
+	return buf->buf;
+}
+
 int cmd_index_pack(int argc, const char **argv, const char *prefix)
 {
 	int i, fix_thin_pack = 0, verify = 0, stat_only = 0;
@@ -1706,24 +1718,11 @@ int cmd_index_pack(int argc, const char **argv, const char *prefix)
 		usage(index_pack_usage);
 	if (fix_thin_pack && !from_stdin)
 		die(_("--fix-thin cannot be used without --stdin"));
-	if (!index_name && pack_name) {
-		size_t len;
-		if (!strip_suffix(pack_name, ".pack", &len))
-			die(_("packfile name '%s' does not end with '.pack'"),
-			    pack_name);
-		strbuf_add(&index_name_buf, pack_name, len);
-		strbuf_addstr(&index_name_buf, ".idx");
-		index_name = index_name_buf.buf;
-	}
-	if (keep_msg && !keep_name && pack_name) {
-		size_t len;
-		if (!strip_suffix(pack_name, ".pack", &len))
-			die(_("packfile name '%s' does not end with '.pack'"),
-			    pack_name);
-		strbuf_add(&keep_name_buf, pack_name, len);
-		strbuf_addstr(&keep_name_buf, ".keep");
-		keep_name = keep_name_buf.buf;
-	}
+	if (!index_name && pack_name)
+		index_name = derive_filename(pack_name, ".idx", &index_name_buf);
+	if (keep_msg && !keep_name && pack_name)
+		keep_name = derive_filename(pack_name, ".keep", &keep_name_buf);
+
 	if (verify) {
 		if (!index_name)
 			die(_("--verify with no packfile name given"));
-- 
2.8.0-rc0-116-g5beb0d5
