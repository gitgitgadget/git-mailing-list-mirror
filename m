From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Make git revert warn the user when reverting a merge
 commit.
Date: Sun, 21 Dec 2008 14:17:12 -0800
Message-ID: <7vprjlkwbb.fsf@gitster.siamese.dyndns.org>
References: <200812182039.15169.bss@iguanasuicide.net>
 <200812211359.31991.bss@iguanasuicide.net>
 <7vwsdtmg5m.fsf@gitster.siamese.dyndns.org>
 <200812211513.26808.bss@iguanasuicide.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Robin Rosenberg <robin.rosenberg.lists@dewire.com>,
	git@vger.kernel.org
To: "Boyd Stephen Smith Jr." <bss@iguanasuicide.net>
X-From: git-owner@vger.kernel.org Sun Dec 21 23:18:44 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LEWdE-0006nf-AS
	for gcvg-git-2@gmane.org; Sun, 21 Dec 2008 23:18:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751498AbYLUWRW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Dec 2008 17:17:22 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751435AbYLUWRW
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Dec 2008 17:17:22 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:56868 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751291AbYLUWRV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Dec 2008 17:17:21 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 7D1B51AD00;
	Sun, 21 Dec 2008 17:17:19 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 97C921ACF9; Sun,
 21 Dec 2008 17:17:14 -0500 (EST)
In-Reply-To: <200812211513.26808.bss@iguanasuicide.net> (Boyd Stephen Smith,
 Jr.'s message of "Sun, 21 Dec 2008 15:13:22 -0600")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 21D6D706-CFAD-11DD-8FDD-F83E113D384A-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103722>

From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: git-revert: record the parent against which a revert was made

As described in Documentation/howto/revert-a-faulty-merge.txt, re-merging
from a previously reverted a merge of a side branch may need a revert of
the revert beforehand.  Record against which parent the revert was made in
the commit, so that later the user can figure out what went on.

[jc: original had the logic in the message reversed, so I tweaked it.]

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
  "Boyd Stephen Smith Jr." <bss@iguanasuicide.net> writes:

  > I still think the parent we are reverting to should be mentioned in the 
  > automatically generated commit message, even if it is the first parent.  Even 
  > if it is decided to elide that information for the first parent, I agree 
  > that, at least for now, the "-m" should still be required when reverting a 
  > merge commit.

  Ok, so here is Robin's patch with a bit of rewording.  I want to have
  something usable now, so that I can tag -rc4 and still have time left
  for sipping my Caipirinha in the evening ;-)

  I think we later _could_ use this information inside ancestry traversal
  made while computing the merge base in such a way to eliminate the
  necessity of the "revert of the revert".  When we see a message that
  records a revert of a merge, we keep a mental note of it, and when we
  encounter such a merge during the ancestry traversal, we pretend as if
  the merge never happened (i.e. instead we traverse only the named
  parent).

  But that needs more thought, and we do not have to do that now.

 builtin-revert.c |    5 +++++
 1 files changed, 5 insertions(+), 0 deletions(-)

diff --git c/builtin-revert.c w/builtin-revert.c
index 4038b41..fae0fe8 100644
--- c/builtin-revert.c
+++ w/builtin-revert.c
@@ -352,6 +352,11 @@ static int revert_or_cherry_pick(int argc, const char **argv)
 		add_to_msg(oneline_body + 1);
 		add_to_msg("\"\n\nThis reverts commit ");
 		add_to_msg(sha1_to_hex(commit->object.sha1));
+
+		if (commit->parents->next) {
+			add_to_msg(",\nreverting damages made to %s");
+			add_to_msg(sha1_to_hex(parent->object.sha1));
+		}
 		add_to_msg(".\n");
 	} else {
 		base = parent;
