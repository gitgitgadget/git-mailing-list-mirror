From: Alex Chiang <achiang@hp.com>
Subject: [StGIT PATCH] allow --cc=myself to work again
Date: Fri, 13 Nov 2009 12:27:42 -0700
Message-ID: <20091113192742.GC1800@ldl.fc.hp.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Andrew Patterson <andrew.patterson@hp.com>,
	scameron@beardog.cce.hp.com, git@vger.kernel.org
To: catalin.marinas@gmail.com
X-From: git-owner@vger.kernel.org Fri Nov 13 20:27:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N91oE-0001XS-Le
	for gcvg-git-2@lo.gmane.org; Fri, 13 Nov 2009 20:27:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757191AbZKMT1i (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Nov 2009 14:27:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757070AbZKMT1i
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Nov 2009 14:27:38 -0500
Received: from g5t0006.atlanta.hp.com ([15.192.0.43]:32886 "EHLO
	g5t0006.atlanta.hp.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757039AbZKMT1h (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Nov 2009 14:27:37 -0500
Received: from g1t0038.austin.hp.com (g1t0038.austin.hp.com [16.236.32.44])
	by g5t0006.atlanta.hp.com (Postfix) with ESMTP id 2A7D9C38B;
	Fri, 13 Nov 2009 19:27:43 +0000 (UTC)
Received: from ldl (linux.corp.hp.com [15.11.146.101])
	by g1t0038.austin.hp.com (Postfix) with ESMTP id E64403008F;
	Fri, 13 Nov 2009 19:27:42 +0000 (UTC)
Received: from localhost (ldl.fc.hp.com [127.0.0.1])
	by ldl (Postfix) with ESMTP id C7662CF0012;
	Fri, 13 Nov 2009 12:27:42 -0700 (MST)
Received: from ldl ([127.0.0.1])
	by localhost (ldl.fc.hp.com [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id YDI8cr260Okm; Fri, 13 Nov 2009 12:27:42 -0700 (MST)
Received: by ldl (Postfix, from userid 17609)
	id B2859CF0008; Fri, 13 Nov 2009 12:27:42 -0700 (MST)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132840>

commit cd74a041 filtered duplicate email addresses, especially
with the --auto option.

However, it broke a common practice of cc'ing yourself on a
patch. [nb, I don't do this myself, but there are several legit
reasons]

This patch allows you to do something like:

	stg mail --to=<someaddr> --cc=<myaddr> --auto <patch>

Under my testing, with <myaddr> in the Signed-off-by: path:

	- we still do not send duplicates to <myaddr> (cd74a041 still holds)
	- we do not Cc: <myaddr> unless explicitly specified with --cc=

I believe this is the behaviour that closest matches what a user
actually wants without sending multiple, annoying Cc:'s.

Signed-off-by: Alex Chiang <achiang@hp.com>
---
diff --git a/stgit/commands/mail.py b/stgit/commands/mail.py
index abd42e4..4b0ac7b 100644
--- a/stgit/commands/mail.py
+++ b/stgit/commands/mail.py
@@ -272,9 +272,8 @@ def __build_address_headers(msg, options, extra_cc = []):
     cc_set = __update_header('Cc', cc_addr, to_set)
     bcc_set = __update_header('Bcc', bcc_addr, to_set.union(cc_set))
 
-    # --auto generated addresses, don't include the sender
-    from_set = __update_header('From')
-    __update_header('Cc', extra_cc_addr, to_set.union(bcc_set).union(from_set))
+    # --auto generated addresses
+    __update_header('Cc', extra_cc_addr, to_set.union(bcc_set))
 
     # update other address headers
     __update_header('Reply-To')
@@ -528,8 +527,11 @@ def __build_message(tmpl, patch, patch_nr, total_nr, msg_id, ref_id, options):
     except Exception, ex:
         raise CmdException, 'template parsing error: %s' % str(ex)
 
+    # Get signers, but filter sender from list. Results in:
+    # do not auto-cc the sender unless explicitly specified with --cc=
     if options.auto:
         extra_cc = __get_signers_list(descr)
+        extra_cc = list(set.symmetric_difference(set([sender]), set(extra_cc)))
     else:
         extra_cc = []
 
