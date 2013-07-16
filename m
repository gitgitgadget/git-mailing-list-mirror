From: Dirk Wallenstein <halsmit@t-online.de>
Subject: [PATCH] request-pull: improve error message for invalid revision args
Date: Tue, 16 Jul 2013 12:46:48 +0200
Message-ID: <20130716104648.GA13275@bottich>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 16 12:47:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uz2mh-0006u0-0q
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 12:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754976Ab3GPKrB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jul 2013 06:47:01 -0400
Received: from mailout08.t-online.de ([194.25.134.20]:38305 "EHLO
	mailout08.t-online.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754204Ab3GPKrA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jul 2013 06:47:00 -0400
Received: from fwd15.aul.t-online.de (fwd15.aul.t-online.de )
	by mailout08.t-online.de with smtp 
	id 1Uz2mW-00054V-Kd; Tue, 16 Jul 2013 12:46:56 +0200
Received: from localhost (rPdTpZZArhnycZLVdUflCjYDWnXv--SSaoxFkEVTIVJfEp75okp0U0BcxolGJRagKt@[178.202.201.83]) by fwd15.t-online.de
	with esmtp id 1Uz2mQ-0kxEmW0; Tue, 16 Jul 2013 12:46:50 +0200
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
X-ID: rPdTpZZArhnycZLVdUflCjYDWnXv--SSaoxFkEVTIVJfEp75okp0U0BcxolGJRagKt
X-TOI-MSGID: ca9042aa-c751-492b-bfd6-72a07c1f1500
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230563>

When an invalid revision is specified, the error message is:

    fatal: Needed a single revision

This is misleading because, you might think there is something wrong
with the command line as a whole.

Now the user gets a more meaningful error message, showing the invalid
revision.

Signed-off-by: Dirk Wallenstein <halsmit@t-online.de>
---

Notes:
    I assume, it is not worth the trouble to even try to change the message from
    rev-parse for this.  People might parse the messages, which is probably why
    this message still exists.

 git-request-pull.sh | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/git-request-pull.sh b/git-request-pull.sh
index d566015..f38f0f9 100755
--- a/git-request-pull.sh
+++ b/git-request-pull.sh
@@ -51,8 +51,18 @@ fi
 tag_name=$(git describe --exact "$head^0" 2>/dev/null)
 
 test -n "$base" && test -n "$url" || usage
-baserev=$(git rev-parse --verify "$base"^0) &&
-headrev=$(git rev-parse --verify "$head"^0) || exit
+
+baserev=$(git rev-parse --verify "$base"^0 2>/dev/null)
+if test -z "$baserev"
+then
+    die "fatal: Not a valid revision: $base"
+fi
+
+headrev=$(git rev-parse --verify "$head"^0 2>/dev/null)
+if test -z "$headrev"
+then
+    die "fatal: Not a valid revision: $head"
+fi
 
 merge_base=$(git merge-base $baserev $headrev) ||
 die "fatal: No commits in common between $base and $head"
-- 
1.8.3.2.51.g8658a4c
