From: ebiederm@xmission.com (Eric W. Biederman)
Subject: Re: git-applymbox broken?
Date: Mon, 12 Jun 2006 12:58:32 -0600
Message-ID: <m13bea6w13.fsf@ebiederm.dsl.xmission.com>
References: <Pine.LNX.4.64.0606111535310.5498@g5.osdl.org>
	<m1wtbn468o.fsf@ebiederm.dsl.xmission.com>
	<Pine.LNX.4.64.0606111735440.5498@g5.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <junkio@cox.net>,
	Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Jun 12 20:58:54 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Fprcd-0004PY-AB
	for gcvg-git@gmane.org; Mon, 12 Jun 2006 20:58:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752155AbWFLS6p (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 12 Jun 2006 14:58:45 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752167AbWFLS6o
	(ORCPT <rfc822;git-outgoing>); Mon, 12 Jun 2006 14:58:44 -0400
Received: from ebiederm.dsl.xmission.com ([166.70.28.69]:23180 "EHLO
	ebiederm.dsl.xmission.com") by vger.kernel.org with ESMTP
	id S1752155AbWFLS6o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Jun 2006 14:58:44 -0400
Received: from ebiederm.dsl.xmission.com (localhost [127.0.0.1])
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Debian-1) with ESMTP id k5CIwWWF005793;
	Mon, 12 Jun 2006 12:58:32 -0600
Received: (from eric@localhost)
	by ebiederm.dsl.xmission.com (8.13.6/8.13.6/Submit) id k5CIwWJr005792;
	Mon, 12 Jun 2006 12:58:32 -0600
X-Authentication-Warning: ebiederm.dsl.xmission.com: eric set sender to ebiederm@xmission.com using -f
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.64.0606111735440.5498@g5.osdl.org> (Linus Torvalds's
	message of "Sun, 11 Jun 2006 17:37:47 -0700 (PDT)")
User-Agent: Gnus/5.110004 (No Gnus v0.4) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/21724>

Linus Torvalds <torvalds@osdl.org> writes:

> What do you mean by "middle"?
>
> No, it should only look at From: and Subject: lines if they are at the 
> very top, with no other non-whitespace lines above them. But when it looks 
> at them and uses the data from them, it should then remove them from the 
> body - they are "conceptually" just extended header lines that just 
> happened to technically (from an rfc822 standpoint) be in the body of the 
> email.

Below is an example of the kind of patch that inspired me to relax the
rules on parsing in body headers (this comes from Andi Kleen quilt tree).

The first line in this instance is obviously a subject line but there
is not really good way to detect that.  Then we get a From: line.

Now I doubt any patches ever hit the mail in this format and it probably
isn't worth it to track down every variation of patch headers in existence.
But if we don't find a From: header in the body prefix it seems to make
sense to keep looking for headers in the body, and to use the information
if we find it.

---
Kdump i386 nmi event notification fix

From: Vivek Goyal <vgoyal@in.ibm.com>

After a crash we should wait for NMI IPI event and not for external NMI or
NMI watchdog tick.

Signed-off-by: Vivek Goyal <vgoyal@in.ibm.com>
Signed-off-by: Andi Kleen <ak@suse.de>
Cc: Don Zickus <dzickus@redhat.com>
Cc: Andi Kleen <ak@suse.de>
Signed-off-by: Andrew Morton <akpm@osdl.org>
---

 arch/i386/kernel/crash.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

Index: linux/arch/i386/kernel/crash.c
===================================================================
--- linux.orig/arch/i386/kernel/crash.c
+++ linux/arch/i386/kernel/crash.c
@@ -102,7 +102,7 @@ static int crash_nmi_callback(struct not
 	struct pt_regs fixed_regs;
 	int cpu;
 
-	if (val != DIE_NMI)
+	if (val != DIE_NMI_IPI)
 		return NOTIFY_OK;
 
 	regs = ((struct die_args *)data)->regs;
@@ -113,7 +113,7 @@ static int crash_nmi_callback(struct not
 	 * an NMI if system was initially booted with nmi_watchdog parameter.
 	 */
 	if (cpu == crashing_cpu)
-		return 1;
+		return NOTIFY_STOP;
 	local_irq_disable();
 
 	if (!user_mode_vm(regs)) {
