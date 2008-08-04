From: Johannes Sixt <johannes.sixt@telecom.at>
Subject: [PATCH] git-gui: Adapt discovery of oguilib to execdir 'libexec/git-core'
Date: Mon,  4 Aug 2008 21:58:32 +0200
Message-ID: <1217879912.48975f6809e10@webmail.nextra.at>
References: <1217177383-25272-1-git-send-email-prohaska@zib.de> <1217177383-25272-2-git-send-email-prohaska@zib.de> <20080727212405.GA10075@spearce.org> <AF6C526A-57ED-4386-A4CF-5260D82026B7@zib.de> <1217756103.48957bc76eda2@webmail.nextra.at> <58FBF585-377C-40A7-818E-6B47F8FD2EB8@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Git Mailing List <git@vger.kernel.org>
To: Steffen Prohaska <prohaska@zib.de>,
	"Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Aug 04 21:59:40 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KQ6DS-0000Ai-4n
	for gcvg-git-2@gmane.org; Mon, 04 Aug 2008 21:59:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755571AbYHDT6h (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Aug 2008 15:58:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753711AbYHDT6h
	(ORCPT <rfc822;git-outgoing>); Mon, 4 Aug 2008 15:58:37 -0400
Received: from smtp5.srv.eunet.at ([193.154.160.227]:59120 "EHLO
	smtp5.srv.eunet.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753273AbYHDT6f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Aug 2008 15:58:35 -0400
Received: from webmail01.si.eunet.at (webmail01.srv.eunet.at [193.154.180.195])
	by smtp5.srv.eunet.at (Postfix) with ESMTPS id 25B7B13A27B;
	Mon,  4 Aug 2008 21:58:33 +0200 (CEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by webmail01.si.eunet.at (8.13.1/8.13.1) with ESMTP id m74JwW4u020323;
	Mon, 4 Aug 2008 21:58:32 +0200
Received: from 77.118.59.205 ([77.118.59.205]) 
	by webmail.nextra.at (IMP) with HTTP 
	for <johsixt@mbox.eunet.at>; Mon,  4 Aug 2008 21:58:32 +0200
In-Reply-To: <58FBF585-377C-40A7-818E-6B47F8FD2EB8@zib.de>
User-Agent: Internet Messaging Program (IMP) 3.2.8
X-Originating-IP: 77.118.59.205
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/91388>

The new execdir has is two levels below the root directory, while
the old execdir 'bin' was only one level below.  This commit
adapts the discovery of oguilib that uses relative paths
accordingly. We determine whether we have the extra level in the same
way in which the Makefile defines sharedir, i.e. whether the last
directory part is 'git-core'.

Inspired-by: Steffen Prohaska <prohaska@zib.de>
Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
---

Zitat von Steffen Prohaska <prohaska@zib.de>:
>
> On Aug 3, 2008, at 11:35 AM, Johannes Sixt wrote:
> > I run git-gui effectivly with
> >
> >   wish $prefix/libexec/git-core/git-gui
> >
> > (and I have $PATH set up to contain $bindir, but not $gitexecdir),
> > and this
> > needs the original hunk with the three [file dirname ... ], because
> > $argv0
> > points to $prefix/libexec/git-core/git-gui.
>
> The original hunk fixes the discovery of oguilib, i.e.
> from $prefix/libexec/git-core/git-gui to $prefix/share/git-gui/lib
>
> I didn't recognize that the the 'three [file dinames ...]' have
> not been applied because I had this change already in 4msysgit
> (and still have).  Apologies for not checking this more carefully.
>
>
> > I thought I understood what's going on, but I don't anymore.
> >
> > Mybe the relative discovery of oguilib must be conditional on the
> > "git-core"
> > part as well, just like you discover sharedir?
>
> Hmm... you are right.  If we want to maintain compatibility
> with *both* directory layouts, obviously all computations
> that depend on the layout need to be conditional on it.

Here is a patch that does just this.

-- Hannes

 git-gui/git-gui.sh |    6 +++++-
 1 files changed, 5 insertions(+), 1 deletions(-)

diff --git a/git-gui/git-gui.sh b/git-gui/git-gui.sh
index fd3875a..fa08d49 100755
--- a/git-gui/git-gui.sh
+++ b/git-gui/git-gui.sh
@@ -52,7 +52,11 @@ catch {rename send {}} ; # What an evil concept...
 set oguilib {@@GITGUI_LIBDIR@@}
 set oguirel {@@GITGUI_RELATIVE@@}
 if {$oguirel eq {1}} {
-	set oguilib [file dirname [file dirname [file normalize $argv0]]]
+	set oguilib [file dirname [file normalize $argv0]]
+	if {[lindex [file split $oguilib] end] eq {git-core}} {
+		set oguilib [file dirname $oguilib]
+	}
+	set oguilib [file dirname $oguilib]
 	set oguilib [file join $oguilib share git-gui lib]
 	set oguimsg [file join $oguilib msgs]
 } elseif {[string match @@* $oguirel]} {
-- 
1.6.0.rc1.958.gce1ed
