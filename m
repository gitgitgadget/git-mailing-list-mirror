From: Johannes Sixt <j6t@kdbg.org>
Subject: [PATCH/RFC 0/3] git rerere unresolve file
Date: Sat, 21 Nov 2009 19:58:40 +0100
Message-ID: <200911211958.40872.j6t@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 21 21:51:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NBwsF-00041R-NI
	for gcvg-git-2@lo.gmane.org; Sat, 21 Nov 2009 21:48:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753934AbZKUS6r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 21 Nov 2009 13:58:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753907AbZKUS6r
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Nov 2009 13:58:47 -0500
Received: from [93.83.142.38] ([93.83.142.38]:62813 "EHLO dx.sixt.local"
	rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org with ESMTP
	id S1753373AbZKUS6q (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Nov 2009 13:58:46 -0500
Received: from localhost (localhost [127.0.0.1])
	by dx.sixt.local (Postfix) with ESMTP id ECE6E19F694;
	Sat, 21 Nov 2009 19:58:40 +0100 (CET)
User-Agent: KMail/1.9.10
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133404>

When you commit an incorrect conflict resolution, git rerere gets in the way: 
rerere clear only clears cache entries of not yet resolved conflicts. But 
there is no other way to remove an incorrect resolution short of purging the 
whole rr-cache.

This series implements 'git rerere unresolve' that removes a recorded 
resolution.

This is RFC for two reasons:

- It changes the contents of MERGE_RR in a way that *may* interfer in unwanted 
ways with older versions that do not understand unresolve.

- rerere unresolve also restores the conflict regions. I'm not sure whether 
this is good because there is 'git checkout --conflict=merge file' that does 
it in a better way. See the commit message of patch 3.

If rerere unresolve does *not* restore conflict regions (and record the result 
as preimage right away) we are facing a problem: When the resolution is 
committed, the postimage has differences from the preimage that are not 
related to the conflict. This may inhibit reusing the resolution later when 
the file has new changes.

Johannes Sixt (3):
  rerere: keep a list of resolved files in MERGE_RR
  rerere: make recording of the preimage reusable
  git rerere unresolve file...

 Documentation/git-rerere.txt |   10 +++-
 builtin-rerere.c             |   13 +++-
 rerere.c                     |  153 ++++++++++++++++++++++++++++++++++-------
 rerere.h                     |    4 +-
 4 files changed, 148 insertions(+), 32 deletions(-)
