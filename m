From: Michele Ballabio <barra_cuda@katamail.com>
Subject: git-gui: more issues with diff parsing
Date: Tue, 9 Sep 2008 10:30:04 +0200
Message-ID: <200809091030.04507.barra_cuda@katamail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Tue Sep 09 10:22:59 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KcyUy-0003rX-NW
	for gcvg-git-2@gmane.org; Tue, 09 Sep 2008 10:22:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754706AbYIIIVu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Sep 2008 04:21:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754480AbYIIIVt
	(ORCPT <rfc822;git-outgoing>); Tue, 9 Sep 2008 04:21:49 -0400
Received: from smtp.katamail.com ([62.149.157.154]:55904 "HELO
	smtp1.pc.aruba.it" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1754639AbYIIIVs (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Sep 2008 04:21:48 -0400
Received: (qmail 13398 invoked by uid 89); 9 Sep 2008 08:21:32 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on smtp1-pc
X-Spam-Level: *
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_50,RDNS_NONE
	autolearn=no version=3.2.3
Received: from unknown (HELO host15-57-dynamic.104-80-r.retail.telecomitalia.it) (barra?cuda@katamail.com@80.104.57.15)
  by smtp1-pc with SMTP; 9 Sep 2008 08:21:32 -0000
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95350>

The patch
	git-gui: Fix diff parsing for lines starting with "--" or "++"
seems to have introduced some glitches. With this sequence:

git init
touch g
git add g
git commit -m"g is a file"
rm g
echo "vvvv" > file
ln -s file g
git add g file
git gui

Now clicking on "g" in the staged changes, git-gui gives this line:
	error: Unhandled 2 way diff marker: {d}

The following patch seems to fix this particular issue, but I don't think
it's the right fix...

diff --git a/lib/diff.tcl b/lib/diff.tcl
index a30c80a..0dac732 100644
--- a/lib/diff.tcl
+++ b/lib/diff.tcl
@@ -345,6 +345,8 @@ proc read_diff {fd scroll_pos} {
 				set tags {}
 			}
 			}
+		} elseif [string match {diff --git *} $line] {
+			continue
 		} else {
 			set op [string index $line 0]
 			switch -- $op {
