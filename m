From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] fast-import: make tagger information optional
Date: Fri, 19 Dec 2008 16:33:38 -0800
Message-ID: <7vfxkj65y5.fsf@gitster.siamese.dyndns.org>
References: <20081218164614.GS5691@genesis.frugalware.org>
 <7vbpv9guqd.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0812182044100.6952@intel-tinevez-2-302>
 <20081218213407.GX5691@genesis.frugalware.org>
 <7viqphf4ua.fsf@gitster.siamese.dyndns.org>
 <alpine.DEB.1.00.0812200059480.30769@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org,
	scott@canonical.com
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Sat Dec 20 01:35:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDpoC-0006XV-Kk
	for gcvg-git-2@gmane.org; Sat, 20 Dec 2008 01:35:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752403AbYLTAdu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 19:33:50 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752514AbYLTAdu
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 19:33:50 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:61266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752325AbYLTAdu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Dec 2008 19:33:50 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A65801AAD2;
	Fri, 19 Dec 2008 19:33:47 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 325BD1AAC7; Fri,
 19 Dec 2008 19:33:39 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DD8A84BA-CE2D-11DD-8BCD-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103610>

Even though newer Porcelain tools always record the tagger information
when creating new tags, export/import pair should be able to faithfully
reproduce ancient tag objects that lack tagger information.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * ... and corresponding patch to fast-import may look like this.

 fast-import.c          |   24 ++++++++++++++----------
 t/t9300-fast-import.sh |   18 ++++++++++++++++++
 2 files changed, 32 insertions(+), 10 deletions(-)

diff --git a/fast-import.c b/fast-import.c
index 201d4ff..d107896 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -2265,23 +2265,27 @@ static void parse_new_tag(void)
 	read_next_command();
 
 	/* tagger ... */
-	if (prefixcmp(command_buf.buf, "tagger "))
-		die("Expected tagger command, got %s", command_buf.buf);
-	tagger = parse_ident(command_buf.buf + 7);
+	if (!prefixcmp(command_buf.buf, "tagger ")) {
+		tagger = parse_ident(command_buf.buf + 7);
+		read_next_command();
+	} else
+		tagger = NULL;
 
 	/* tag payload/message */
-	read_next_command();
 	parse_data(&msg);
 
 	/* build the tag object */
 	strbuf_reset(&new_data);
+
 	strbuf_addf(&new_data,
-		"object %s\n"
-		"type %s\n"
-		"tag %s\n"
-		"tagger %s\n"
-		"\n",
-		sha1_to_hex(sha1), commit_type, t->name, tagger);
+		    "object %s\n"
+		    "type %s\n"
+		    "tag %s\n",
+		    sha1_to_hex(sha1), commit_type, t->name);
+	if (tagger)
+		strbuf_addf(&new_data,
+			    "tagger %s\n", tagger);
+	strbuf_addch(&new_data, '\n');
 	strbuf_addbuf(&new_data, &msg);
 	free(tagger);
 
diff --git a/t/t9300-fast-import.sh b/t/t9300-fast-import.sh
index 91b5ace..5a2aaf2 100755
--- a/t/t9300-fast-import.sh
+++ b/t/t9300-fast-import.sh
@@ -56,6 +56,12 @@ M 644 :2 file2
 M 644 :3 file3
 M 755 :4 file4
 
+tag series-A
+from :5
+data <<EOF
+An annotated tag without an tagger
+EOF
+
 INPUT_END
 test_expect_success \
     'A: create pack from stdin' \
@@ -102,6 +108,18 @@ test_expect_success \
 	'git cat-file blob master:file4 >actual && test_cmp expect actual'
 
 cat >expect <<EOF
+object $(git rev-parse refs/heads/master)
+type commit
+tag series-A
+
+An annotated tag without an tagger
+EOF
+test_expect_success 'A: verify tag/series-A' '
+	git cat-file tag tags/series-A >actual &&
+	test_cmp expect actual
+'
+
+cat >expect <<EOF
 :2 `git rev-parse --verify master:file2`
 :3 `git rev-parse --verify master:file3`
 :4 `git rev-parse --verify master:file4`
-- 
1.6.1.rc3.48.g2724
