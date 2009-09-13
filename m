From: Clemens Buchacher <drizzd@aon.at>
Subject: [PATCH] git-gui: search 4 directories to improve statistic of gc
	hint
Date: Mon, 14 Sep 2009 00:20:44 +0200
Message-ID: <20090913222044.GA17146@localhost>
References: <20090909195158.GA12968@localhost> <20090913160637.GA15256@localhost> <7vr5uasp4a.fsf@alter.siamese.dyndns.org> <20090913184150.GA19209@localhost> <20090913204433.GA8796@coredump.intra.peff.net> <20090913211916.GA5029@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, msysgit@googlegroups.com,
	"Shawn O. Pearce" <spearce@spearce.org>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Sep 14 00:20:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MmxRL-0004E3-Al
	for gcvg-git-2@lo.gmane.org; Mon, 14 Sep 2009 00:20:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751738AbZIMWUt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Sep 2009 18:20:49 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751207AbZIMWUs
	(ORCPT <rfc822;git-outgoing>); Sun, 13 Sep 2009 18:20:48 -0400
Received: from fg-out-1718.google.com ([72.14.220.159]:1843 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751094AbZIMWUr (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Sep 2009 18:20:47 -0400
Received: by fg-out-1718.google.com with SMTP id 22so390524fge.1
        for <git@vger.kernel.org>; Sun, 13 Sep 2009 15:20:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:received:received:sender:received:date:from:to
         :cc:bcc:subject:message-id:references:mime-version:content-type
         :content-disposition:in-reply-to:user-agent;
        bh=8/6LeqiRZCJhCiPrSPT6YU7bNB8/20woCoq/QKH1Gfc=;
        b=ruwjqPCyglYG5BiJVOzAFSF5rYkJnat8tpLF9Q3GZOaY+gyospYyL9PV6JJjhXuaJI
         K072k9mGL5k0611Lpt2CLG4ivzbqx7E8SBexFQalV0WwTieTiGRByMhvuQYHrMAnfRH3
         rE8nhNHUBDgPaa8uoUatRATOxy/onoELP54Cs=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=sender:date:from:to:cc:bcc:subject:message-id:references
         :mime-version:content-type:content-disposition:in-reply-to
         :user-agent;
        b=FHxpaMG6Wi0ifuMoUk9oSZbxfATqtIlii24JQ2ziUw2xJX5oWVKNVvF9hCRwrma2ZJ
         q/Hzz8o3MfooQiZBkXFreYXLInv8ObQEoie4dceAi46iLO9SBoWs/2ECEbWBmt0s4aPL
         2bJ/go/KpUUHwcM7Qis5llg7usM6hGUPEjNDE=
Received: by 10.87.42.14 with SMTP id u14mr630056fgj.28.1252880449448;
        Sun, 13 Sep 2009 15:20:49 -0700 (PDT)
Received: from darc.lan (p549A51F1.dip.t-dialin.net [84.154.81.241])
        by mx.google.com with ESMTPS id l12sm1553162fgb.23.2009.09.13.15.20.48
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 13 Sep 2009 15:20:49 -0700 (PDT)
Received: from drizzd by darc.lan with local (Exim 4.69)
	(envelope-from <drizzd@aon.at>)
	id 1MmxR6-0004wT-QV; Mon, 14 Sep 2009 00:20:44 +0200
Content-Disposition: inline
In-Reply-To: <20090913211916.GA5029@localhost>
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128424>

On Windows, git-gui suggests running the garbage collector if it finds
1 or more files in .git/objects/42 (as opposed to 8 files on other
platforms). The probability of that happening if the repo contains
about 100 loose objects is 32%. The probability for the same to happen
when searching 4 directories is only 8%, which is bit more reasonable.

Also remove $objects_limit from the message, because we already know
that we are above (or close to) that limit. Telling the user about
that number does not really give him any useful information.

The following octave script shows the probability for at least m*q
objects to be found in q subdirectories of .git/objects if n is the
total number of objects.

q = 4;
m = [1 2 8];
n = 0:10:2000;

P = zeros(length(n), length(m));
for k = 1:length(n)
        P(k, :) = 1-binocdf(q*m-1, n(k), q/(256-q));
end
plot(n, P);

n \ q   1       4
50      18%     1%
100     32%     8%
200     54%     39%
500     86%     96%

Signed-off-by: Clemens Buchacher <drizzd@aon.at>
---

 git-gui/lib/database.tcl |   21 ++++++++++-----------
 1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/git-gui/lib/database.tcl b/git-gui/lib/database.tcl
index a18ac8b..d4e0bed 100644
--- a/git-gui/lib/database.tcl
+++ b/git-gui/lib/database.tcl
@@ -89,27 +89,26 @@ proc do_fsck_objects {} {
 }
 
 proc hint_gc {} {
-	set object_limit 8
+	set ndirs 1
+	set limit 8
 	if {[is_Windows]} {
-		set object_limit 1
+		set ndirs 4
+		set limit 1
 	}
 
-	set objects_current [llength [glob \
-		-directory [gitdir objects 42] \
+	set count [llength [glob \
 		-nocomplain \
-		-tails \
 		-- \
-		*]]
+		[gitdir objects 4\[0-[expr {$ndirs-1}]\]/*]]]
 
-	if {$objects_current >= $object_limit} {
-		set objects_current [expr {$objects_current * 250}]
-		set object_limit    [expr {$object_limit    * 250}]
+	if {$count >= $limit * $ndirs} {
+		set objects_current [expr {$count * 256/$ndirs}]
 		if {[ask_popup \
 			[mc "This repository currently has approximately %i loose objects.
 
-To maintain optimal performance it is strongly recommended that you compress the database when more than %i loose objects exist.
+To maintain optimal performance it is strongly recommended that you compress the database.
 
-Compress the database now?" $objects_current $object_limit]] eq yes} {
+Compress the database now?" $objects_current]] eq yes} {
 			do_gc
 		}
 	}
-- 
1.6.5.rc0.164.g5f6b0
