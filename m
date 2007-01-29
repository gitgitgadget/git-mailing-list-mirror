From: Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: MinGW port usable
Date: Mon, 29 Jan 2007 14:46:23 -0800 (PST)
Message-ID: <Pine.LNX.4.64.0701291438580.3611@woody.linux-foundation.org>
References: <200701292320.43888.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Jan 29 23:46:42 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HBfGr-0002Ax-3d
	for gcvg-git@gmane.org; Mon, 29 Jan 2007 23:46:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932788AbXA2Wqf (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 29 Jan 2007 17:46:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752623AbXA2Wqf
	(ORCPT <rfc822;git-outgoing>); Mon, 29 Jan 2007 17:46:35 -0500
Received: from smtp.osdl.org ([65.172.181.24]:60171 "EHLO smtp.osdl.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752091AbXA2Wqe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Jan 2007 17:46:34 -0500
Received: from shell0.pdx.osdl.net (fw.osdl.org [65.172.181.6])
	by smtp.osdl.org (8.12.8/8.12.8) with ESMTP id l0TMkO1m014576
	(version=TLSv1/SSLv3 cipher=EDH-RSA-DES-CBC3-SHA bits=168 verify=NO);
	Mon, 29 Jan 2007 14:46:25 -0800
Received: from localhost (shell0.pdx.osdl.net [10.9.0.31])
	by shell0.pdx.osdl.net (8.13.1/8.11.6) with ESMTP id l0TMkOhB001214;
	Mon, 29 Jan 2007 14:46:24 -0800
In-Reply-To: <200701292320.43888.johannes.sixt@telecom.at>
X-Spam-Status: No, hits=-0.484 required=5 tests=AWL
X-Spam-Checker-Version: SpamAssassin 2.63-osdl_revision__1.111__
X-MIMEDefang-Filter: osdl$Revision: 1.172 $
X-Scanned-By: MIMEDefang 2.36
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38102>



On Mon, 29 Jan 2007, Johannes Sixt wrote:

> I'd like to point interested parties to the MinGW port at
> 
>  git://repo.or.cz/git/mingw.git
> 
> which is now in a usable state, methinks. I'm using it with git-gui and gitk 
> on a (almost) production repository.

Can you elaborate about any performance differences, especially with 
cygwin? Does this make git perform reasonably on Windows, or are the 
performance problems as bad as with cygwin?

> Junio, you may like to cherry-pick these two non-critical commits from my 
> repository:
> 
> 8c8bb94f94f1d972c7ffadda4744cf343fac6f34 gitk: Use peek-remote instead of  ls-remote.

gitk really shouldn't use either. It should probably use

	git-show-ref -h -d

instead, which has the same output format (modulo a space vs tab issue), 
and is entirely local, with no silly unnecessary remote connext.

Something like this patch.

Does that work on mingw too?

		Linus
----
diff --git a/gitk b/gitk
index 031c829..6b4a4ac 100755
--- a/gitk
+++ b/gitk
@@ -309,9 +309,9 @@ proc readrefs {} {
     foreach v {tagids idtags headids idheads otherrefids idotherrefs} {
 	catch {unset $v}
     }
-    set refd [open [list | git ls-remote [gitdir]] r]
+    set refd [open [list | git show-ref -h -d] r]
     while {0 <= [set n [gets $refd line]]} {
-	if {![regexp {^([0-9a-f]{40})	refs/([^^]*)$} $line \
+	if {![regexp {^([0-9a-f]{40}) refs/([^^]*)$} $line \
 	    match id path]} {
 	    continue
 	}
