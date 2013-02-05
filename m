From: John Keeping <john@keeping.me.uk>
Subject: [PATCH] t4038: add tests for "diff --cc --raw <trees>"
Date: Tue, 5 Feb 2013 20:25:58 +0000
Message-ID: <20130205202558.GX1342@serenity.lan>
References: <cover.1359901732.git.john@keeping.me.uk>
 <6995fd5e4d9cb3320ab80c983f1b25ae8a399284.1359901732.git.john@keeping.me.uk>
 <7vwqup890o.fsf@alter.siamese.dyndns.org>
 <20130203203150.GU1342@serenity.lan>
 <7v8v7585sr.fsf@alter.siamese.dyndns.org>
 <20130203231549.GV1342@serenity.lan>
 <7vip696i3v.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 05 21:26:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2p68-0003lX-AN
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 21:26:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756633Ab3BEU0J (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Feb 2013 15:26:09 -0500
Received: from coyote.aluminati.org ([72.9.247.114]:44004 "EHLO
	coyote.aluminati.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755621Ab3BEU0H (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Feb 2013 15:26:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by coyote.aluminati.org (Postfix) with ESMTP id 30D9F6064CF;
	Tue,  5 Feb 2013 20:26:06 +0000 (GMT)
X-Virus-Scanned: Debian amavisd-new at caracal.aluminati.org
X-Spam-Flag: NO
X-Spam-Score: -12.9
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 tagged_above=-9999 required=6.31
	tests=[ALL_TRUSTED=-1, ALUMINATI_LOCAL_TESTS=-10, BAYES_00=-1.9]
	autolearn=ham
Received: from coyote.aluminati.org ([127.0.0.1])
	by localhost (coyote.aluminati.org [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id g-SwnRNSw3Jw; Tue,  5 Feb 2013 20:26:05 +0000 (GMT)
Received: from serenity.lan (tg2.aluminati.org [10.0.7.178])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by coyote.aluminati.org (Postfix) with ESMTPSA id 4A2156064CD;
	Tue,  5 Feb 2013 20:26:00 +0000 (GMT)
Content-Disposition: inline
In-Reply-To: <7vip696i3v.fsf@alter.siamese.dyndns.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215534>

Signed-off-by: John Keeping <john@keeping.me.uk>
---
On Sun, Feb 03, 2013 at 04:24:52PM -0800, Junio C Hamano wrote:
>                             Ideally it should also have test cases
> to show "git diff --cc --raw blob1 blob2...blob$n" for n=4 and n=40
> (or any two values clearly below and above the old hardcoded limit)
> behave sensibly, exposing the old breakage, which I'll leave as a
> LHF (low-hanging-fruit).  Hint, hint...

Hint taken ;-)

git-diff uses a different code path for blobs, so I've had to use trees
to trigger this.  The last test fails without
jc/combine-diff-many-parents and passes with it.

 t/t4038-diff-combined.sh | 29 +++++++++++++++++++++++++++++
 1 file changed, 29 insertions(+)

diff --git a/t/t4038-diff-combined.sh b/t/t4038-diff-combined.sh
index 40277c7..a0701bc 100755
--- a/t/t4038-diff-combined.sh
+++ b/t/t4038-diff-combined.sh
@@ -89,4 +89,33 @@ test_expect_success 'diagnose truncated file' '
 	grep "diff --cc file" out
 '
 
+test_expect_success 'setup for --cc --raw' '
+	blob=$(echo file |git hash-object --stdin -w) &&
+	base_tree=$(echo "100644 blob $blob	file" | git mktree) &&
+	trees= &&
+	for i in `test_seq 1 40`
+	do
+		blob=$(echo file$i |git hash-object --stdin -w) &&
+		trees="$trees $(echo "100644 blob $blob	file" |git mktree)"
+	done
+'
+
+test_expect_success 'check --cc --raw with four trees' '
+	four_trees=$(echo "$trees" |awk -e "{
+		print \$1
+		print \$2
+		print \$3
+		print \$4
+	}") &&
+	git diff --cc --raw $four_trees $base_tree >out &&
+	# Check for four leading colons in the output:
+	grep "^::::[^:]" out
+'
+
+test_expect_success 'check --cc --raw with forty trees' '
+	git diff --cc --raw $trees $base_tree >out &&
+	# Check for forty leading colons in the output:
+	grep "^::::::::::::::::::::::::::::::::::::::::[^:]" out
+'
+
 test_done
-- 
1.8.1.2
