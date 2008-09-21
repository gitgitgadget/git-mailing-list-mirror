From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [funny] "git checkout -t origin/xyzzy" seems to misbehave
Date: Sun, 21 Sep 2008 14:36:06 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0809211406150.19665@iabervon.org>
References: <7v1vzd29i3.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Sep 21 20:37:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KhToA-0002ct-6Y
	for gcvg-git-2@gmane.org; Sun, 21 Sep 2008 20:37:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751393AbYIUSgK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 21 Sep 2008 14:36:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751940AbYIUSgI
	(ORCPT <rfc822;git-outgoing>); Sun, 21 Sep 2008 14:36:08 -0400
Received: from iabervon.org ([66.92.72.58]:44228 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751274AbYIUSgI (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 21 Sep 2008 14:36:08 -0400
Received: (qmail 21924 invoked by uid 1000); 21 Sep 2008 18:36:06 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 21 Sep 2008 18:36:06 -0000
In-Reply-To: <7v1vzd29i3.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96419>

On Sun, 21 Sep 2008, Junio C Hamano wrote:

> When you
> 
>  * are on a branch "foo" that is not "bar",
>  * have "origin/bar",
>  * and already have a local branch "bar",
> 
> "git checkout -t origin/bar" seems to misbehave.

It's always been the case if the thing that fails is changing the ref for 
HEAD, you're left with the index and working tree changed but the ref 
unchanged. OTOH, the C conversion lost the early checks that a new branch 
name is plausible in advance of trying anything.

commit c36a025b20ac752f8960bc36dcbab98ca1824657
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Sun Sep 21 14:25:31 2008 -0400

    Check early that a new branch is new and valid
    
    If you fail to update refs to change branches in checkout, your index
    and working tree are left already updated. We don't have an easy way
    to undo this, but at least we can check things that would make the
    creation of a new branch fail. These checks were in the shell version,
    and were lost in the C conversion.
    
    The messages are from the shell version, and should probably be made nicer.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 9377a1c..4497b70 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -580,6 +580,18 @@ no_reference:
 		return checkout_paths(source_tree, pathspec);
 	}
 
+	if (opts.new_branch) {
+		struct strbuf buf;
+		strbuf_init(&buf, 0);
+		strbuf_addstr(&buf, "refs/heads/");
+		strbuf_addstr(&buf, opts.new_branch);
+		if (!get_sha1(buf.buf, rev))
+			die("git checkout: branch %s already exists", opts.new_branch);
+		if (check_ref_format(buf.buf))
+			die("git checkout: we do not like '%s' as a branch name.", opts.new_branch);
+		strbuf_release(&buf);
+	}
+
 	if (new.name && !new.commit) {
 		die("Cannot switch branch to a non-commit.");
 	}
