From: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: [PATCH v3] gc: call "prune --expire 2.weeks.ago" by default
Date: Wed, 12 Mar 2008 20:55:28 +0100 (CET)
Message-ID: <alpine.LSU.1.00.0803122054570.1656@racer.site>
References: <alpine.LSU.1.00.0803112157560.3873@racer.site> <7vskywadum.fsf@gitster.siamese.dyndns.org> <alpine.LFD.1.00.0803112234470.2947@xanadu.home> <alpine.LSU.1.00.0803121833210.1656@racer.site> <47D8193B.901@nrlssc.navy.mil> <m3prtzyens.fsf@localhost.localdomain>
 <alpine.LSU.1.00.0803122005330.1656@racer.site> <7viqzr69ka.fsf@gitster.siamese.dyndns.org> <alpine.LSU.1.00.0803122051340.1656@racer.site>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Jakub Narebski <jnareb@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Nicolas Pitre <nico@cam.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 12 20:56:30 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JZX3k-0007Ca-LU
	for gcvg-git-2@gmane.org; Wed, 12 Mar 2008 20:56:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754196AbYCLTzY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Mar 2008 15:55:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751623AbYCLTzX
	(ORCPT <rfc822;git-outgoing>); Wed, 12 Mar 2008 15:55:23 -0400
Received: from mail.gmx.net ([213.165.64.20]:59363 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752469AbYCLTzW (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Mar 2008 15:55:22 -0400
Received: (qmail invoked by alias); 12 Mar 2008 19:55:21 -0000
Received: from unknown (EHLO [138.251.11.74]) [138.251.11.74]
  by mail.gmx.net (mp042) with SMTP; 12 Mar 2008 20:55:21 +0100
X-Authenticated: #1490710
X-Provags-ID: V01U2FsdGVkX1/w2nVf3NnwrgUHfAWr/alkZX/On4Pul6Yl7FIpkL
	250xjzjh6U1W7i
X-X-Sender: gene099@racer.site
In-Reply-To: <alpine.LSU.1.00.0803122051340.1656@racer.site>
User-Agent: Alpine 1.00 (LSU 882 2007-12-20)
X-Y-GMX-Trusted: 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76980>

... and here is the interdiff:

 builtin-gc.c     |    3 ++-
 t/t5304-prune.sh |   10 +++++++++-
 2 files changed, 11 insertions(+), 2 deletions(-)

diff --git a/builtin-gc.c b/builtin-gc.c
index 8d07350..9663fae 100644
--- a/builtin-gc.c
+++ b/builtin-gc.c
@@ -59,7 +59,8 @@ static int gc_config(const char *var, const char *value)
 	if (!strcmp(var, "gc.pruneexpire")) {
 		if (!value)
 			return config_error_nonbool(var);
-		if (!approxidate(value))
+		if (strcmp(value, "now") &&
+				approxidate(value) - approxidate("now") >= 0)
 			return error("Invalid gc.pruneExpire: '%s'", value);
 		prune_expire = xstrdup(value);
 		return 0;
diff --git a/t/t5304-prune.sh b/t/t5304-prune.sh
index 2a88b3f..3b6b01d 100644
--- a/t/t5304-prune.sh
+++ b/t/t5304-prune.sh
@@ -50,7 +50,6 @@ test_expect_success 'gc: implicit prune --expire' '
 
 	before=$(git count-objects | sed "s/ .*//") &&
 	BLOB=$(echo aleph_0 | git hash-object -w --stdin) &&
-echo blob: $BLOB &&
 	BLOB_FILE=.git/objects/$(echo $BLOB | sed "s/^../&\//") &&
 	test $((1 + $before)) = $(git count-objects | sed "s/ .*//") &&
 	test -f $BLOB_FILE &&
@@ -65,4 +64,13 @@ echo blob: $BLOB &&
 
 '
 
+test_expect_success 'gc: refuse to start with invalid gc.pruneExpire' '
+
+	git config gc.pruneExpire invalid &&
+	test_must_fail git gc &&
+	git config gc.pruneExpire now &&
+	git gc
+
+'
+
 test_done
