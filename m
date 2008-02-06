From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] [v9] safecrlf: Add mechanism to warn about irreversible crlf conversions
Date: Wed, 06 Feb 2008 11:42:05 -0800
Message-ID: <7vk5lhyir6.fsf@gitster.siamese.dyndns.org>
References: <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
	<12022971582185-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Wed Feb 06 20:43:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JMqAc-0008Dn-Qg
	for gcvg-git-2@gmane.org; Wed, 06 Feb 2008 20:42:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755674AbYBFTmU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Feb 2008 14:42:20 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758980AbYBFTmT
	(ORCPT <rfc822;git-outgoing>); Wed, 6 Feb 2008 14:42:19 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:63533 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758919AbYBFTmS (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Feb 2008 14:42:18 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CDF8B3CC7;
	Wed,  6 Feb 2008 14:42:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id AFE113CC6;
	Wed,  6 Feb 2008 14:42:12 -0500 (EST)
In-Reply-To: <12022971582185-git-send-email-prohaska@zib.de> (Steffen
	Prohaska's message of "Wed, 6 Feb 2008 12:25:58 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72833>

Steffen Prohaska <prohaska@zib.de> writes:

> This repaces v9 of the patch and should be applied.
> It contains modifications as suggested by Junio in
> <7vbq6u32mq.fsf@gitster.siamese.dyndns.org>
>
>     Steffen
>
> -- >8 --

This v9 replaces itself, ah it repaces ;-)

> git diff, git add, and any other command that calls
> index_fd(..., write_object=1) also behave as requested by
> safecrlf.  The user still has the chance to save her data before
> checkout or applying the diff.

"git diff" writes by calling index_fd(..., write_object=1)???

I think warning in "git diff" is probably a good thing to do but
that is not because it writes.  The warning would trigger only
when you are comparing what you have in the work tree with
something else, and if you get such a warning, it means what you
can potentially commit (i.e. what you have in the work tree) is
not "autocrlf" safe.  You would get the same warning when you
later runn "git add" on such a file anyway, but it is nicer to
catch the potential problem earlier.

I do not know if the above "why this command should behave this
way with respect to safecrlf" needs to be in the commit log
message.  But I think that information should be in the
documentation to help the end users (the end users typically do
not have access to the commit log of git.git).

The rest of the patch looked sane.  Thanks.

So I'd suggest the following change to the commit log message,
and then another patch at the end squashed into the
Documentation/ part.

If you agree with these, you can just say "Ok, amend it like
so".  Or you can say "Here is an even better replacement."

----------------------------------------------------------------
[proposed change to the commit log message]

--- /var/tmp/1	2008-02-06 11:36:28.000000000 -0800
+++ /var/tmp/2	2008-02-06 11:36:19.000000000 -0800
@@ -49,28 +49,29 @@
     leave core.autocrlf unset, so users will not see warnings unless
     they deliberately chose to activate the autocrlf mechanism.
     
-    The safecrlf mechanism's details depend on the git command.  If
-    safecrlf is active (not false), files in the work tree must not
-    be modified in an irreversible way without giving the user a
-    chance to backup the original file.  However, for read-only
-    operations that do not modify files in the work tree git should
-    not print annoying warnings.
-    
-    git apply behaves as requested by by safecrlf.  Even though git
-    apply writes changes directly back to the work tree, we assume
-    that the user still can get the original files back by checking
-    out from the index or HEAD.  git apply is about applying patches,
-    which means we are talking about "text" and therefore it is
-    safe to write the results directly back to the work tree even
-    if CRLFs were converted to LFs.
-    
-    git diff, git add, and any other command that calls
-    index_fd(..., write_object=1) also behave as requested by
-    safecrlf.  The user still has the chance to save her data before
-    checkout or applying the diff.
+    The safecrlf mechanism's details depend on the git command.  The
+    general principles when safecrlf is active (not false) are:
     
-    git blame will never warn nor fail because it never writes to the
-    work tree.
+     - we warn/error out if files in the work tree can modified in an
+       irreversible way without giving the user a chance to backup the
+       original file.
+    
+     - for read-only operations that do not modify files in the work tree
+       we do not not print annoying warnings.
+    
+    There are exceptions.  Even though...
+    
+     - "git add" itself does not touch the files in the work tree, the
+       next checkout would, so the safety triggers;
+    
+     - "git apply" to update a text file with a patch does touch the files
+       in the work tree, but the operation is about text files and CRLF
+       conversion is about fixing the line ending inconsistencies, so the
+       safety does not trigger;
+    
+     - "git diff" itself does not touch the files in the work tree, it is
+       often run to inspect the changes you intend to next "git add".  To
+       catch potential problems early, safety triggers.
     
     The concept of a safety check was originally proposed in a similar
     way by Linus Torvalds.  Thanks to Dimitry Potapov for insisting

----------------------------------------------------------------
[adding the general rule and per-command behaviour to the doc]

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 2ffe1fb..84ec962 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -137,7 +137,22 @@ If `core.safecrlf` is set to "true" or "warn", git verifies if
 the conversion is reversible for the current setting of
 `core.autocrlf`.  For "true", git rejects irreversible
 conversions; for "warn", git only prints a warning but accepts
-an irreversible conversion.
+an irreversible conversion.  The safety triggers to prevent such
+a conversion done to the files in the work tree, but there are a
+few exceptions.  Even though...
+
+- "git add" itself does not touch the files in the work tree, the
+  next checkout would, so the safety triggers;
+
+- "git apply" to update a text file with a patch does touch the files
+  in the work tree, but the operation is about text files and CRLF
+  conversion is about fixing the line ending inconsistencies, so the
+  safety does not trigger;
+
+- "git diff" itself does not touch the files in the work tree, it is
+  often run to inspect the changes you intend to next "git add".  To
+  catch potential problems early, safety triggers.
+
 
 `ident`
 ^^^^^^^
