From: Robin Rosenberg <robin.rosenberg.lists@dewire.com>
Subject: Re: [PATCH] Make repack less likely to corrupt repository
Date: Sun, 15 Feb 2009 17:15:19 +0100
Message-ID: <200902151715.19351.robin.rosenberg.lists@dewire.com>
References: <1234140299-29785-1-git-send-email-robin.rosenberg@dewire.com> <200902110127.18149.robin.rosenberg.lists@dewire.com> <7vwsbxizlg.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	spearce@spearce.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Feb 15 17:17:09 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LYjfr-0003x8-BU
	for gcvg-git-2@gmane.org; Sun, 15 Feb 2009 17:16:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752884AbZBOQP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Feb 2009 11:15:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752800AbZBOQP2
	(ORCPT <rfc822;git-outgoing>); Sun, 15 Feb 2009 11:15:28 -0500
Received: from mail.dewire.com ([83.140.172.130]:19712 "EHLO dewire.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752772AbZBOQP1 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 15 Feb 2009 11:15:27 -0500
Received: from localhost (localhost [127.0.0.1])
	by dewire.com (Postfix) with ESMTP id 18717147E993;
	Sun, 15 Feb 2009 17:15:21 +0100 (CET)
X-Virus-Scanned: by amavisd-new at dewire.com
Received: from dewire.com ([127.0.0.1])
	by localhost (torino.dewire.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id XGKiXC-BMsDC; Sun, 15 Feb 2009 17:15:20 +0100 (CET)
Received: from sleipner.localnet (unknown [10.9.0.4])
	by dewire.com (Postfix) with ESMTP id 3C44F147E632;
	Sun, 15 Feb 2009 17:15:20 +0100 (CET)
User-Agent: KMail/1.11.0 (Linux/2.6.27-11-generic; KDE/4.2.0; i686; ; )
In-Reply-To: <7vwsbxizlg.fsf@gitster.siamese.dyndns.org>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/110020>

onsdag 11 februari 2009 01:31:07 skrev Junio C Hamano:
> Robin Rosenberg <robin.rosenberg.lists@dewire.com> writes:
> 
> > onsdag 11 februari 2009 00:56:49 skrev Junio C Hamano:
> >> We failed to honor what the end user wanted: to repack.  Why should we
> >> exit 0 here?
> >
> > A repack may or may not yield a better packed repo. In this case, not,
> > but for a different reason than failing to find better deltas. Given the
> > circumstances that is most likely to cause the "failure (repacking on
> > windows), this is "normal" behaviour and no reason to scare the user
> > with an error code.
> 
> Up to this point, I felt my earlier misconception corrected, but then ...
> 
> > The unlink error might be enough.
> 
> ... I think we should not even show unlink errors, if "this is not an
> error, nothing to worry about" is the official stance about such failure;
> otherwise the errors will scare people, *and* others then doubly complain
> that even the command detects errors, the whole thing does *not* error
> out.

Here is an amendment, the only change is that it outputs a more verbose
explanation. Remember the issue we are trying to fix is a critical bug, not
a cosmetic error. I'd rather hear people complain about the wording of error
messages, than lost repositories.

-- robin

>From 3598881d6591e7c89b1a6a3c8da526f847382a35 Mon Sep 17 00:00:00 2001
From: Robin Rosenberg <robin.rosenberg@dewire.com>
Date: Sun, 15 Feb 2009 17:05:49 +0100
Subject: [PATCH] Try to remove the old packs if we succeed. Exit success if rollback fails after
 failing to rename old packs.

---
 git-repack.sh |   18 +++++++++++++++++-
 1 files changed, 17 insertions(+), 1 deletions(-)

diff --git a/git-repack.sh b/git-repack.sh
index 0f13043..194af86 100755
--- a/git-repack.sh
+++ b/git-repack.sh
@@ -136,8 +136,15 @@ then
 		do
 			echo >&2 "WARNING:   old-$file -> $file"
 		done
+		exit 1
 	fi
-	exit 1
+	echo >&2 "INFO: We recovered from the repack error, but your repo"
+	echo >&2 "INFO: is probably suboptimally packed. You may try to repack"
+	echo >&2 "INFO: later. A common reason for repacking failure is that"
+	echo >&2 "INFO: a Windows program was locking one of the old pack files."
+	echo >&2 "INFO: To repack successfully you may have to close that program"
+	echo >&2 "INFO: before repacking."
+	exit
 fi
 
 # Now the ones with the same name are out of the way...
@@ -152,6 +159,15 @@ do
 	exit
 done
 
+# Remove the "old-" files
+for name in $names
+do
+	rm -f "$PACKDIR/old-pack-$name.idx"
+	rm -f "$PACKDIR/old-pack-$name.pack"
+done
+
+# End of pack replacement.
+
 if test "$remove_redundant" = t
 then
 	# We know $existing are all redundant.
-- 
1.6.1.285.g35d8b
