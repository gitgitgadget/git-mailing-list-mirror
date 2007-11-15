From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH 1/3] git-bisect: war on "sed"
Date: Thu, 15 Nov 2007 01:00:56 -0800
Message-ID: <7voddv6fxz.fsf@gitster.siamese.dyndns.org>
References: <20071115081807.06fe092b.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Christian Couder <chriscool@tuxfamily.org>,
	Ralf Wildenhues <Ralf.Wildenhues@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Nov 15 10:01:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IsabA-0004ed-UG
	for gcvg-git-2@gmane.org; Thu, 15 Nov 2007 10:01:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761623AbXKOJBE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 15 Nov 2007 04:01:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761239AbXKOJBD
	(ORCPT <rfc822;git-outgoing>); Thu, 15 Nov 2007 04:01:03 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:59506 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753790AbXKOJBC (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2007 04:01:02 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 4B7322EF;
	Thu, 15 Nov 2007 04:01:23 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id C175394E75;
	Thu, 15 Nov 2007 04:01:19 -0500 (EST)
In-Reply-To: <20071115081807.06fe092b.chriscool@tuxfamily.org> (Christian
	Couder's message of "Thu, 15 Nov 2007 08:18:07 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65093>

We do not need to pipe "echo" to "sed" only to strip refs/heads/
from the beginning.  We are assuming not-so-ancient shells these
days.

Also there is no need to avoid assuming \012 is the LF; we do
not run on EBCDIC, sorry.  Other parts of the script already
uses tr to convert separator to LF that way.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-bisect.sh |    5 ++---
 1 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/git-bisect.sh b/git-bisect.sh
index 46a7b8d..3a21033 100755
--- a/git-bisect.sh
+++ b/git-bisect.sh
@@ -71,7 +71,7 @@ bisect_start() {
 		;;
 	refs/heads/*)
 		[ -s "$GIT_DIR/head-name" ] && die "won't bisect on seeked tree"
-		echo "$head" | sed 's#^refs/heads/##' >"$GIT_DIR/head-name"
+		echo "${head#refs/heads/}" >"$GIT_DIR/head-name"
 		;;
 	*)
 		die "Bad HEAD - strange symbolic ref"
@@ -275,8 +275,7 @@ exit_if_skipped_commits () {
 	if expr "$_tried" : ".*[|].*" > /dev/null ; then
 		echo "There are only 'skip'ped commit left to test."
 		echo "The first bad commit could be any of:"
-		echo "$_tried" | sed -e 's/[|]/\
-/g'
+		echo "$_tried" | tr '[|]' '[\012]'
 		echo "We cannot bisect more!"
 		exit 2
 	fi
-- 
1.5.3.5.1780.gca2b
