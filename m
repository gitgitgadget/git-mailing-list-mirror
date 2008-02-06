From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: [PATCH (repost)] Improve bash prompt to detect merge / rebase in progress
Date: Wed, 6 Feb 2008 23:14:38 +0100
Message-ID: <200802062314.39440.robin.rosenberg.lists@dewire.com>
References: <9b3e2dc20802061152q63bc61acuaecf3f33d4df8b19@mail.gmail.com> <7vodatvmtl.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: "Stephen Sinclair" <radarsat1@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Feb 06 23:15:38 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMsYD-0001bM-PE
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 23:15:30 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755637AbYBFWOy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 17:14:54 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756109AbYBFWOy
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 17:14:54 -0500
Received: from [83.140.172.130] ([83.140.172.130]:11746 "EHLO dewire.com"
	rhost-flags-FAIL-FAIL-OK-OK) by vger.kernel.org with ESMTP
	id S1755637AbYBFWOx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 6 Feb 2008 17:14:53 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 425B5800697;
	Wed,  6 Feb 2008 23:14:51 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id Hz6VRGj2SJiR; Wed,  6 Feb 2008 23:14:50 +0100 (CET)
Received: from [10.9.0.6] (unknown [10.9.0.6])
	by dewire.com (Postfix) with ESMTP id B1672800680;
	Wed,  6 Feb 2008 23:14:45 +0100 (CET)
User-Agent: KMail/1.9.6 (enterprise 0.20071123.740460)
In-Reply-To: <7vodatvmtl.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72861>

Hi Junio,

I'm not sure whether you didn't like it or not or just lost it. Here
is the vastly enhanced prompt again, rebased.

-- robin

>From 76aa8bae8491c1ffbd6e3f5c99ab014ef87794c8 Mon Sep 17 00:00:00 2001
From: Shawn O. Pearce <spearce@spearce.org>
Date: Tue, 4 Sep 2007 03:13:01 -0400
Subject: 

This patch makes the git prompt (when enabled) show if a merge or a
rebase is unfinished. It also detects if a bisect is being done as
well as detached checkouts.

Signed-off-by: Robin Rosenberg <robin.rosenberg@dewire.com>
---
 contrib/completion/git-completion.bash |   37 ++++++++++++++++++++++++++++---
 1 files changed, 33 insertions(+), 4 deletions(-)

diff --git a/contrib/completion/git-completion.bash b/contrib/completion/git-completion.bash
index 0d33f9a..4ea727b 100755
--- a/contrib/completion/git-completion.bash
+++ b/contrib/completion/git-completion.bash
@@ -64,12 +64,41 @@ __gitdir ()
 
 __git_ps1 ()
 {
-	local b="$(git symbolic-ref HEAD 2>/dev/null)"
-	if [ -n "$b" ]; then
+	local g="$(git rev-parse --git-dir 2>/dev/null)"
+	if [ -n "$g" ]; then
+		local r
+		local b
+		if [ -d "$g/../.dotest" ]
+		then
+			r="|AM/REBASE"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		elif [ -f "$g/.dotest-merge/interactive" ]
+		then
+			r="|REBASE-i"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -d "$g/.dotest-merge" ]
+		then
+			r="|REBASE-m"
+			b="$(cat $g/.dotest-merge/head-name)"
+		elif [ -f "$g/MERGE_HEAD" ]
+		then
+			r="|MERGING"
+			b="$(git symbolic-ref HEAD 2>/dev/null)"
+		else
+			if [ -f $g/BISECT_LOG ]
+			then
+				r="|BISECTING"
+			fi
+			if ! b="$(git symbolic-ref HEAD 2>/dev/null)"
+			then
+				b="$(cut -c1-7 $g/HEAD)..."
+			fi
+		fi
+
 		if [ -n "$1" ]; then
-			printf "$1" "${b##refs/heads/}"
+			printf "$1" "${b##refs/heads/}$r"
 		else
-			printf " (%s)" "${b##refs/heads/}"
+			printf " (%s)" "${b##refs/heads/}$r"
 		fi
 	fi
 }
-- 
1.5.4.rc4.25.g81cc
