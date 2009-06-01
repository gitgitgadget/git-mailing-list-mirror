From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH 3/3 v2] test-lib: fix http exit codes
Date: Mon, 1 Jun 2009 14:28:25 +0200
Message-ID: <20090601122825.GA29406@localhost>
References: <1243858482-6353-1-git-send-email-drizzd@aon.at> <1243858482-6353-2-git-send-email-drizzd@aon.at> <1243858482-6353-3-git-send-email-drizzd@aon.at> <1243858482-6353-4-git-send-email-drizzd@aon.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 01 14:29:02 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MB6dO-0001rA-W7
	for gcvg-git-2@gmane.org; Mon, 01 Jun 2009 14:28:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752850AbZFAM23 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Jun 2009 08:28:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752214AbZFAM22
	(ORCPT <rfc822;git-outgoing>); Mon, 1 Jun 2009 08:28:28 -0400
Received: from postman.fh-hagenberg.at ([193.170.124.96]:42384 "EHLO
	mail.fh-hagenberg.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752083AbZFAM22 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Jun 2009 08:28:28 -0400
Received: from darc.dnsalias.org ([80.123.242.182]) by mail.fh-hagenberg.at over TLS secured channel with Microsoft SMTPSVC(6.0.3790.3959);
	 Mon, 1 Jun 2009 14:28:29 +0200
Received: from drizzd by darc.dnsalias.org with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MB6cr-0001sa-Ho; Mon, 01 Jun 2009 14:28:25 +0200
Content-Disposition: inline
In-Reply-To: <1243858482-6353-4-git-send-email-drizzd@aon.at>
User-Agent: Mutt/1.5.18 (2008-05-17)
X-OriginalArrivalTime: 01 Jun 2009 12:28:29.0374 (UTC) FILETIME=[781A25E0:01C9E2B4]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120467>

Previously, die() would report the exit code of stop_httpd. Instead,
save and reset the exit code before dying.

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

On Mon, Jun 01, 2009 at 02:14:42PM +0200, Clemens Buchacher wrote:
> Previously, die() would report the exit code of stop_httpd. Instead,
> save the exit code and pass it to die() explicitly.

Oops, I forgot to fix the commit message. (I tried to pass the exit code to
die() explicitly, but then I realized that this is much easier.)

Clemens

 t/lib-httpd.sh |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/t/lib-httpd.sh b/t/lib-httpd.sh
index cde659d..6765b08 100644
--- a/t/lib-httpd.sh
+++ b/t/lib-httpd.sh
@@ -93,14 +93,16 @@ prepare_httpd() {
 start_httpd() {
 	prepare_httpd >&3 2>&4
 
-	trap 'stop_httpd; die' EXIT
+	trap 'code=$?; stop_httpd; (exit $code); die' EXIT
 
 	"$LIB_HTTPD_PATH" -d "$HTTPD_ROOT_PATH" \
 		-f "$TEST_PATH/apache.conf" $HTTPD_PARA \
 		-c "Listen 127.0.0.1:$LIB_HTTPD_PORT" -k start \
 		>&3 2>&4
-	if ! test $? = 0; then
+	if test $? -ne 0
+	then
 		say "skipping test, web server setup failed"
+		trap 'die' EXIT
 		test_done
 	fi
 }
-- 
1.6.3.1.147.g637c3
