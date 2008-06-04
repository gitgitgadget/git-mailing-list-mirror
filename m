From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] describe: match pattern for lightweight tags too
Date: Wed, 04 Jun 2008 13:09:52 -0700
Message-ID: <7vod6hvu5r.fsf@gitster.siamese.dyndns.org>
References: <alpine.LNX.1.10.0806042101080.3410@pollux>
 <20080604195516.GT12896@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Michael Dressel <MichaelTiloDressel@t-online.de>,
	git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Wed Jun 04 22:11:01 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3zJz-00058B-KL
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 22:11:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756841AbYFDUKH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 16:10:07 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756926AbYFDUKG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 16:10:06 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49879 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755638AbYFDUKF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 16:10:05 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 1AD774503;
	Wed,  4 Jun 2008 16:10:04 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id CA8DD4502; Wed,  4 Jun 2008 16:09:59 -0400 (EDT)
In-Reply-To: <20080604195516.GT12896@spearce.org> (Shawn O. Pearce's message
 of "Wed, 4 Jun 2008 15:55:16 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 382AB848-3272-11DD-AE2D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83822>

Thanks both.  I've reworded the log message to make it clear that this is
not a random new feature but is a bugfix.

-- >8 --
From: Michael Dressel <MichaelTiloDressel@t-online.de>
Date: Wed, 4 Jun 2008 21:06:31 +0200
Subject: [PATCH] describe: match pattern for lightweight tags too

The <pattern> given "git describe --match" was used only to filter tag
objects, and not to filter lightweight tags.  This fixes it.

[jc: made the log to clarify this is a bugfix, not an enhancement, with
additional test]

Signed-off-by: Michael Dressel <MichaelTiloDressel@t-online.de>
Acked-by: Shawn O. Pearce <spearce@spearce.org>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-describe.c  |    9 +++++----
 t/t6120-describe.sh |   22 ++++++++++++++++++++++
 2 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/builtin-describe.c b/builtin-describe.c
index df554b3..3da99c1 100644
--- a/builtin-describe.c
+++ b/builtin-describe.c
@@ -80,12 +80,13 @@ static int get_name(const char *path, const unsigned char *sha1, int flag, void
 	 * Otherwise only annotated tags are used.
 	 */
 	if (might_be_tag) {
-		if (is_tag) {
+		if (is_tag)
 			prio = 2;
-			if (pattern && fnmatch(pattern, path + 10, 0))
-				prio = 0;
-		} else
+		else
 			prio = 1;
+
+		if (pattern && fnmatch(pattern, path + 10, 0))
+			prio = 0;
 	}
 	else
 		prio = 0;
diff --git a/t/t6120-describe.sh b/t/t6120-describe.sh
index 56bbd85..c6bfef5 100755
--- a/t/t6120-describe.sh
+++ b/t/t6120-describe.sh
@@ -117,4 +117,26 @@ test_expect_success 'rename tag Q back to A' '
 test_expect_success 'pack tag refs' 'git pack-refs'
 check_describe A-* HEAD
 
+test_expect_success 'set-up matching pattern tests' '
+	git tag -a -m test-annotated test-annotated &&
+	echo >>file &&
+	test_tick &&
+	git commit -a -m "one more" &&
+	git tag test1-lightweight &&
+	echo >>file &&
+	test_tick &&
+	git commit -a -m "yet another" &&
+	git tag test2-lightweight &&
+	echo >>file &&
+	test_tick &&
+	git commit -a -m "even more"
+
+'
+
+check_describe "test-annotated-*" --match="test-*"
+
+check_describe "test1-lightweight-*" --tags --match="test1-*"
+
+check_describe "test2-lightweight-*" --tags --match="test2-*"
+
 test_done
-- 
1.5.6.rc1.5.gadf60
