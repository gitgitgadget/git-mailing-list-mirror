From: Robin Rosenberg <robin.rosenberg@dewire.com>
Subject: Re: [PATCH] Abort mergetool on read error from stdinput
Date: Fri, 3 Dec 2010 10:05:01 +0100
Message-ID: <70B726FD-EC6A-47B2-9AB1-1CDA3B19358A@dewire.com>
References: <1291271301-12511-1-git-send-email-robin.rosenberg@dewire.com> <20101202063851.GA1407@burratino>
Mime-Version: 1.0 (Apple Message framework v1082)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: junkio@cox.net, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 03 10:05:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PORZx-0005HU-0q
	for gcvg-git-2@lo.gmane.org; Fri, 03 Dec 2010 10:05:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754995Ab0LCJFM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Dec 2010 04:05:12 -0500
Received: from mail.dewire.com ([83.140.172.130]:6787 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752689Ab0LCJFH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 3 Dec 2010 04:05:07 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id C16E88003EA;
	Fri,  3 Dec 2010 10:05:04 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 5KDrIj8NPUwq; Fri,  3 Dec 2010 10:05:03 +0100 (CET)
Received: from [10.9.0.3] (unknown [10.9.0.3])
	by dewire.com (Postfix) with ESMTP id A2C21800367;
	Fri,  3 Dec 2010 10:05:02 +0100 (CET)
In-Reply-To: <20101202063851.GA1407@burratino>
X-Mailer: Apple Mail (2.1082)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/162778>


2 dec 2010 kl. 07:38 skrev Jonathan Nieder:

> Hi Robin,
> 
> Robin Rosenberg wrote:
> 
>> infinite loop that is somewhat tricky to stop. Abort the script
>> if bash read fails.
>> 
>> Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
> 
> That motivates half the change.
> 
>> --- a/git-mergetool--lib.sh
>> +++ b/git-mergetool--lib.sh
>> @@ -35,7 +35,7 @@ check_unchanged () {
>> 		while true; do
>> 			echo "$MERGED seems unchanged."
>> 			printf "Was the merge successful? [y/n] "
>> -			read answer
>> +			read answer < /dev/tty || exit 1
> 
> Why not
> 			read answer || exit 1
> 
> so tests can still run without blocking?  Aside from that, this looks
> like a good change; thanks.
> 
> What platform are you on?  ^C kills the entire process group here.

Here is a better version and motivation.

-- robin

>From 3aa3793a4d1dff940ca6b698a9c01a1fc9bdb9b3 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Fri, 3 Dec 2010 09:23:23 +0100
Subject: [PATCH] Abort mergetool on read error from stdinput

If the mergetool has not quit (by mistake like pressing
Command-W instead of Command-Q) and the user pressed Ctrl-C
in the shell that runs mergetool, bash goes into an infinite
look, at least on Mac OS X. Ctrl-C kills the diff program
but not the mergetool script.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 git-mergetool--lib.sh |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/git-mergetool--lib.sh b/git-mergetool--lib.sh
index 77d4aee..1d1413d 100644
--- a/git-mergetool--lib.sh
+++ b/git-mergetool--lib.sh
@@ -35,7 +35,7 @@ check_unchanged () {
 		while true; do
 			echo "$MERGED seems unchanged."
 			printf "Was the merge successful? [y/n] "
-			read answer
+			read answer || exit 1
 			case "$answer" in
 			y*|Y*) status=0; break ;;
 			n*|N*) status=1; break ;;
-- 
1.7.3.2.452.gb3012.dirty
