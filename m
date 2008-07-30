From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Fix merge name generation in "merge in C"
Date: Wed, 30 Jul 2008 01:12:19 -0700
Message-ID: <7vabfz7puk.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Miklos Vajna <vmiklos@frugalware.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jul 30 10:13:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KO6oM-0004ea-Dx
	for gcvg-git-2@gmane.org; Wed, 30 Jul 2008 10:13:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752430AbYG3IM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jul 2008 04:12:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752312AbYG3IM2
	(ORCPT <rfc822;git-outgoing>); Wed, 30 Jul 2008 04:12:28 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38718 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752152AbYG3IM1 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jul 2008 04:12:27 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id C36843A52D;
	Wed, 30 Jul 2008 04:12:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 106EC3A529; Wed, 30 Jul 2008 04:12:21 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 3DF3A1F4-5E0F-11DD-BA81-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90756>

When merging an early part of a branch, e.g. "git merge xyzzy~20", we were
supposed to say "branch 'xyzzy' (early part)", but it incorrectly said
"branch 'refs/heads/xy' (early part)" instead.

The logic was supposed to first strip away "~20" part to make sure that
what follows "~" is a non-zero posint, prefix it with "refs/heads/" and
ask resolve_ref() if it is a ref.  If it is, then we know xyzzy was a
branch, and we can give the correct message.

However, there were a few bugs.  First of all, the logic to build this
"true branch refname" did not count the characters correctly.  At this
point of the code, "len" is the number of trailing, non-name part of the
given extended SHA-1 expression given by the user, i.e. number of bytes in
"~20" in the above example.

In addition, the message forgot to skip "refs/heads/" it prefixed from the
output.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 * It is a bit surprising that after beating merge-in-C to death, we
   still find a minor breakage like this.

 builtin-merge.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin-merge.c b/builtin-merge.c
index e78fa18..dde0c7e 100644
--- a/builtin-merge.c
+++ b/builtin-merge.c
@@ -396,12 +396,12 @@ static void merge_name(const char *remote, struct strbuf *msg)
 		struct strbuf truname = STRBUF_INIT;
 		strbuf_addstr(&truname, "refs/heads/");
 		strbuf_addstr(&truname, remote);
-		strbuf_setlen(&truname, len+11);
+		strbuf_setlen(&truname, truname.len - len);
 		if (resolve_ref(truname.buf, buf_sha, 0, 0)) {
 			strbuf_addf(msg,
 				    "%s\t\tbranch '%s'%s of .\n",
 				    sha1_to_hex(remote_head->sha1),
-				    truname.buf,
+				    truname.buf + 11,
 				    (early ? " (early part)" : ""));
 			return;
 		}
