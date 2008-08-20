From: Junio C Hamano <gitster@pobox.com>
Subject: "git-merge": allow fast-forwarding in a stat-dirty tree
Date: Wed, 20 Aug 2008 15:09:28 -0700
Message-ID: <7vljyrnxt3.fsf_-_@gitster.siamese.dyndns.org>
References: <1508D1DF-EDE7-4A64-B354-E2F26578E24D@ai.rug.nl>
 <7v7iabpejv.fsf@gitster.siamese.dyndns.org>
 <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git Mailinglist <git@vger.kernel.org>,
	Miklos Vajna <vmiklos@frugalware.org>
To: Pieter de Bie <pdebie@ai.rug.nl>
X-From: git-owner@vger.kernel.org Thu Aug 21 00:10:48 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVvtA-00032K-0X
	for gcvg-git-2@gmane.org; Thu, 21 Aug 2008 00:10:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754221AbYHTWJn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Aug 2008 18:09:43 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754113AbYHTWJm
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 18:09:42 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:56592 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754073AbYHTWJl (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 18:09:41 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 578B055E05;
	Wed, 20 Aug 2008 18:09:37 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id E09C655E04; Wed, 20 Aug 2008 18:09:30 -0400 (EDT)
In-Reply-To: <EAFC48F0-5512-4A83-B9B2-44FF53319285@ai.rug.nl> (Pieter de
 Bie's message of "Wed, 20 Aug 2008 23:29:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: AD8F8B12-6F04-11DD-A386-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/93061>

We used to refresh the index to clear stat-dirtyness before a fast-forward
merge.  Recent C rewrite forgot to do this.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-merge.c  |    2 +-
 t/t7600-merge.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 1 deletions(-)

diff --git c/builtin-merge.c w/builtin-merge.c
index dde0c7e..a201c66 100644
--- c/builtin-merge.c
+++ w/builtin-merge.c
@@ -566,6 +566,7 @@ static int checkout_fast_forward(unsigned char *head, unsigned char *remote)
 
 	if (read_cache_unmerged())
 		die("you need to resolve your current index first");
+	refresh_cache(REFRESH_QUIET);
 
 	fd = hold_locked_index(lock_file, 1);
 
@@ -936,7 +937,6 @@ int cmd_merge(int argc, const char **argv, const char *prefix)
 			hex,
 			find_unique_abbrev(remoteheads->item->object.sha1,
 			DEFAULT_ABBREV));
-		refresh_cache(REFRESH_QUIET);
 		strbuf_init(&msg, 0);
 		strbuf_addstr(&msg, "Fast forward");
 		if (have_message)
diff --git c/t/t7600-merge.sh w/t/t7600-merge.sh
index 5eeb6c2..fee8fb7 100755
--- c/t/t7600-merge.sh
+++ w/t/t7600-merge.sh
@@ -488,4 +488,14 @@ test_expect_success 'merge c1 with c1 and c2' '
 
 test_debug 'gitk --all'
 
+test_expect_success 'merge fast-forward in a dirty tree' '
+       git reset --hard c0 &&
+       mv file file1 &&
+       cat file1 >file &&
+       rm -f file1 &&
+       git merge c2
+'
+
+test_debug 'gitk --all'
+
 test_done
