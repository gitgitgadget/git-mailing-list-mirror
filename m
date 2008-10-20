From: Jeff King <peff@peff.net>
Subject: Re: git add --patch newfile doesn't add newfile to cache ?
Date: Mon, 20 Oct 2008 19:50:50 -0400
Message-ID: <20081020235049.GA23120@coredump.intra.peff.net>
References: <20081020143636.GB3988@gmx.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Marc Weber <marco-oweber@gmx.de>
X-From: git-owner@vger.kernel.org Tue Oct 21 01:55:55 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Ks4Xg-0004Is-AK
	for gcvg-git-2@gmane.org; Tue, 21 Oct 2008 01:52:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752256AbYJTXuz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 20 Oct 2008 19:50:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752109AbYJTXuz
	(ORCPT <rfc822;git-outgoing>); Mon, 20 Oct 2008 19:50:55 -0400
Received: from peff.net ([208.65.91.99]:3417 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751502AbYJTXuz (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 20 Oct 2008 19:50:55 -0400
Received: (qmail 16889 invoked by uid 111); 20 Oct 2008 23:50:51 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 20 Oct 2008 19:50:51 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 20 Oct 2008 19:50:50 -0400
Content-Disposition: inline
In-Reply-To: <20081020143636.GB3988@gmx.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98745>

On Mon, Oct 20, 2008 at 04:36:36PM +0200, Marc Weber wrote:

> Is this desired behaviour?
> [...]
>         git init
>         echo test > test
>         git add --patch test
>         echo "running status, nothing has been added"
>         git status

I think your example makes sense, but nobody ever really tried it
before. I use "git add -p" all the time, but almost always when I am
adding a new file, I add the whole contents.

I think there are two ways to go about fixing it:

  - in git-add--interactive.perl, the function patch_update_cmd
    explicitly looks at the list of modified files. It would have to
    also check for untracked files, which is easy. But we also need to
    keep track of which files are modified and which are untracked
    through the whole patching procedure, which is a bit more invasive.

  - the recently-added "git add -N" adds an empty file into the index,
    at which point we could add content in the normal way. So:

      git add -N test
      git add -p test

    should just work (but obviously requires two steps from the user).
    You could do something more automatic like the patch below, but I
    think the semantics aren't quite right. If you stage nothing for a
    newly added file, then you still end up with an empty version of the
    staged file in the index. I would expect the semantics to be:

      1. if you stage any content, then the file is added to the index
         with that content

      2. if you stage no content, then the file remains untracked

---
diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index da768ee..72f8a67 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -811,6 +811,12 @@ EOF
 }
 
 sub patch_update_cmd {
+	my @new = list_untracked();
+	if (@new) {
+		system(qw(git add -N), @new)
+			and die "git add reported failure";
+	}
+
 	my @mods = grep { !($_->{BINARY}) } list_modified('file-only');
 	my @them;
 
