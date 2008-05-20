From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: builtin-clone does not fallback to copy when link fails
Date: Tue, 20 May 2008 11:45:14 -0500
Message-ID: <C6tFzFdDycYRRcjxtVG00CVX-Nsu7-UblPCaZmTxmWIUTFAsgReYbQ@cipher.nrlssc.navy.mil>
References: <oguFi9b5ZAq84dsDzWpm0tpI_xzucMxL23YhxIjDS5NTdpslAnzo6w@cipher.nrlssc.navy.mil>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Tue May 20 18:47:00 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JyUym-0005l0-08
	for gcvg-git-2@gmane.org; Tue, 20 May 2008 18:46:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755496AbYETQpc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 20 May 2008 12:45:32 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755858AbYETQpc
	(ORCPT <rfc822;git-outgoing>); Tue, 20 May 2008 12:45:32 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:44618 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753733AbYETQpb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 20 May 2008 12:45:31 -0400
Received: by mail.nrlssc.navy.mil id m4KGjFrq012354; Tue, 20 May 2008 11:45:15 -0500
In-Reply-To: <oguFi9b5ZAq84dsDzWpm0tpI_xzucMxL23YhxIjDS5NTdpslAnzo6w@cipher.nrlssc.navy.mil>
X-OriginalArrivalTime: 20 May 2008 16:45:15.0543 (UTC) FILETIME=[E1293A70:01C8BA98]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82484>


Brandon Casey wrote:
> 
> When cloning with the new builtin-clone, if the src repo is not
> on the same disk as the dest repo, cloning fails. This is because
> hard linking does not fall back to copying like the shell version
> did.
> 
> The shell version also made a distinction between defaulting to
> hard linking and an explicit request to hard link. In the latter
> case it would not fall back to copying, but would die.

Something like this (if not too ugly) might do the trick:

diff --git a/builtin-clone.c b/builtin-clone.c
index 8713128..1062371 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -208,11 +208,17 @@ static void copy_or_link_directory(char *src, char *dest)
 		if (unlink(dest) && errno != ENOENT)
 			die("failed to unlink %s\n", dest);
 		if (option_no_hardlinks) {
+FALLBACK_TO_COPY:
 			if (copy_file(dest, src, 0666))
 				die("failed to copy file to %s\n", dest);
 		} else {
-			if (link(src, dest))
+			if (link(src, dest)) {
+				if (errno == EXDEV && !option_local) {
+				    	option_no_hardlinks = 1;
+					goto FALLBACK_TO_COPY;
+				}
 				die("failed to create link %s\n", dest);
+			}
 		}
 	}
 }
