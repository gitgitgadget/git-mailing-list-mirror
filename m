X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.176.0/21
X-Spam-Status: No, score=-3.5 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MSGID_FROM_MTA_HEADER,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
From: Nicolas Pitre <nico@cam.org>
Subject: Re: Progress reporting (was: VCS comparison table)
Date: Mon, 30 Oct 2006 10:21:09 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0610301018310.11384@xanadu.home>
References: <200610270202.k9R22Wxf004208@laptop13.inf.utfsm.cl>
 <4541D291.5020205@op5.se> <20061027144656.GA32451@fieldses.org>
 <m3mz7gheoe.fsf@iny.iki.fi> <ehvnal$tjg$1@sea.gmane.org>
 <ei4jia$vj0$1@sea.gmane.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
NNTP-Posting-Date: Mon, 30 Oct 2006 15:22:50 +0000 (UTC)
Cc: git@vger.kernel.org
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
In-reply-to: <ei4jia$vj0$1@sea.gmane.org>
X-X-Sender: nico@xanadu.home
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/30501>
Received: from vger.kernel.org ([209.132.176.167]) by ciao.gmane.org with
 esmtp (Exim 4.43) id 1GeYx0-0004cb-0x for gcvg-git@gmane.org; Mon, 30 Oct
 2006 16:21:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand id
 S1030430AbWJ3PVR (ORCPT <rfc822;gcvg-git@m.gmane.org>); Mon, 30 Oct 2006
 10:21:17 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1030458AbWJ3PVR
 (ORCPT <rfc822;git-outgoing>); Mon, 30 Oct 2006 10:21:17 -0500
Received: from relais.videotron.ca ([24.201.245.36]:46562 "EHLO
 relais.videotron.ca") by vger.kernel.org with ESMTP id S1030430AbWJ3PVQ
 (ORCPT <rfc822;git@vger.kernel.org>); Mon, 30 Oct 2006 10:21:16 -0500
Received: from xanadu.home ([74.56.106.175]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java System Messaging Server 6.2-2.05 (built Apr 28 2005)) with ESMTP id
 <0J7Y00BNTFZ9VDB0@VL-MH-MR002.ip.videotron.ca> for git@vger.kernel.org; Mon,
 30 Oct 2006 10:21:09 -0500 (EST)
To: Jakub Narebski <jnareb@gmail.com>
Sender: git-owner@vger.kernel.org

On Mon, 30 Oct 2006, Jakub Narebski wrote:

> I was bitten lately by git lack of progress reporting for git-push.
> While it nicely reports local progress (generating data) it unfortunately
> lacks wget like, "curl -o" like or scp like pack upload progress
> reporting. And while usually push is fast, initial push of whole
> project to empty repository can be quite slow on low-bandwidth link
> (or busy network).

What about this patch?

diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 41e1e74..7f87ae8 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -1524,6 +1524,10 @@ int cmd_pack_objects(int argc, const cha
 			progress = 1;
 			continue;
 		}
+		if (!strcmp("--all-progress", arg)) {
+			progress = 2;
+			continue;
+		}
 		if (!strcmp("--incremental", arg)) {
 			incremental = 1;
 			continue;
@@ -1641,7 +1645,7 @@ int cmd_pack_objects(int argc, const cha
 	else {
 		if (nr_result)
 			prepare_pack(window, depth);
-		if (progress && pack_to_stdout) {
+		if (progress == pack_to_stdout) {
 			/* the other end usually displays progress itself */
 			struct itimerval v = {{0,},};
 			setitimer(ITIMER_REAL, &v, NULL);
diff --git a/send-pack.c b/send-pack.c
index 0e90548..9280481 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -30,6 +30,7 @@ static void exec_pack_objects(void)
 {
 	static const char *args[] = {
 		"pack-objects",
+		"--all-progress",
 		"--stdout",
 		NULL
