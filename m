From: Thomas Rast <trast@student.ethz.ch>
Subject: [RFC PATCH 2b] parse_commit: refuse to load commit without \n\n separator
Date: Tue, 28 Feb 2012 11:37:01 +0100
Message-ID: <3f4c4b0656305bec08e87ad56ee3253b010a5a9d.1330425111.git.trast@student.ethz.ch>
References: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Junio C Hamano <gitster@pobox.com>, <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Feb 28 11:37:30 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S2KQw-0007im-S3
	for gcvg-git-2@plane.gmane.org; Tue, 28 Feb 2012 11:37:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755549Ab2B1KhJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 Feb 2012 05:37:09 -0500
Received: from edge10.ethz.ch ([82.130.75.186]:27110 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752271Ab2B1KhH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 Feb 2012 05:37:07 -0500
Received: from CAS10.d.ethz.ch (172.31.38.210) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
Received: from thomas.inf.ethz.ch (129.132.153.233) by cas10.d.ethz.ch
 (172.31.38.210) with Microsoft SMTP Server (TLS) id 14.1.355.2; Tue, 28 Feb
 2012 11:37:01 +0100
X-Mailer: git-send-email 1.7.9.2.467.g7fee4
In-Reply-To: <010901fbfffe0f806bb19d556ebc1e512a4697f4.1330425111.git.trast@student.ethz.ch>
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/191709>

A commit object consists of a series of headers, terminated by a blank
line (\n\n), followed by the message.

Refuse to parse a commit which does not contain this \n\n.  This also
lets git-fsck detect the breakage.

Signed-off-by: Thomas Rast <trast@student.ethz.ch>
---

This is the more drastic approach compared to 2a.  Since the code in
pretty.c was broken given such input, I would favor this.  It does,
however, remove the possibility of fixing up such a broken commit with
the tools git provides (other than resorting to git-hash-object and
git-replace).


 commit.c |    3 +++
 1 file changed, 3 insertions(+)

diff --git a/commit.c b/commit.c
index 4b39c19..502675c 100644
--- a/commit.c
+++ b/commit.c
@@ -265,6 +265,9 @@ int parse_commit_buffer(struct commit *item, const void *buffer, unsigned long s
 	if (get_sha1_hex(bufptr + 5, parent) < 0)
 		return error("bad tree pointer in commit %s",
 			     sha1_to_hex(item->object.sha1));
+	if (!memmem(bufptr, size, "\n\n", 2))
+		return error("commit object %s is missing \\n\\n separator",
+			     sha1_to_hex(item->object.sha1));
 	item->tree = lookup_tree(parent);
 	bufptr += 46; /* "tree " + "hex sha1" + "\n" */
 	pptr = &item->parents;
-- 
1.7.9.2.467.g7fee4
