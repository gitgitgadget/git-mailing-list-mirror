From: Junio C Hamano <gitster@pobox.com>
Subject: git-describe: use tags found in packed-refs correctly
Date: Mon, 03 Mar 2008 09:13:59 -0800
Message-ID: <7vejarivc8.fsf@gitster.siamese.dyndns.org>
References: <20080228062236.GA15845@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Mar 03 18:15:09 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JWEFS-0002f5-GI
	for gcvg-git-2@gmane.org; Mon, 03 Mar 2008 18:14:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758598AbYCCROM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Mar 2008 12:14:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758572AbYCCROL
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Mar 2008 12:14:11 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:36713 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758481AbYCCROJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Mar 2008 12:14:09 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9D3818FA;
	Mon,  3 Mar 2008 12:14:06 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 51CE618F6; Mon,  3 Mar 2008 12:14:03 -0500 (EST)
In-Reply-To: <20080228062236.GA15845@spearce.org> (Shawn O. Pearce's message
 of "Thu, 28 Feb 2008 01:22:36 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75951>

When your refs are packed, "git-describe" can find the tag that is the
best match without ever parsing the tag itself.  But lookup_tag() in
display_name() says "I've never seen it", creates an empty shell, and
returns it.  We need to make sure that we actually have parsed the tag
data into it.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 builtin-describe.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index 2f1e7ba..c549d36 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -156,7 +156,7 @@ static void display_name(struct commit_name *n)
 {
 	if (n->prio == 2 && !n->tag) {
 		n->tag = lookup_tag(n->sha1);
-		if (!n->tag || !n->tag->tag)
+		if (parse_tag(n->tag) || !n->tag || !n->tag->tag)
 			die("annotated tag %s not available", n->path);
 		if (strcmp(n->tag->tag, n->path))
 			warning("tag '%s' is really '%s' here", n->tag->tag, n->path);

