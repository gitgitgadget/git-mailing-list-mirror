From: Junio C Hamano <gitster@pobox.com>
Subject: [RFC] sending errors to stdout under $PAGER
Date: Sat, 16 Feb 2008 11:15:41 -0800
Message-ID: <7vbq6g90gy.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Feb 16 20:17:03 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQSWv-0007z6-Hy
	for gcvg-git-2@gmane.org; Sat, 16 Feb 2008 20:16:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756131AbYBPTQX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 16 Feb 2008 14:16:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756165AbYBPTQX
	(ORCPT <rfc822;git-outgoing>); Sat, 16 Feb 2008 14:16:23 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:64429 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755610AbYBPTQW (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 16 Feb 2008 14:16:22 -0500
Received: from a-sasl-quonix.pobox.com (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 8F6D65661;
	Sat, 16 Feb 2008 14:16:20 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.pobox.com (Postfix) with ESMTP id
 6ADB1565F; Sat, 16 Feb 2008 14:16:14 -0500 (EST)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74062>

If you do this (and you are not an Emacs user who uses PAGER=cat
in your *shell* buffer):

        $ git init
        Initialized empty Git repository in .git/
        $ echo hello world >foo
        $ H=$(git hash-object -w foo)
        $ git tag -a foo-tag -m "Tags $H" $H
        $ echo $H
        3b18e512dba79e4c8300dd08aeb37f8e728b8dad
        $ rm -f .git/objects/3b/18e5*
        $ git show foo-tag
        tag foo-tag
        Tagger: Junio C Hamano <gitster@pobox.com>
        Date:   Sat Feb 16 10:43:23 2008 -0800

        Tags 3b18e512dba79e4c8300dd08aeb37f8e728b8dad

you do not get any indication of error.  If you are careful, you
would notice that no contents from the tagged object is
displayed, but that is about it.  If you run the "show" command
without pager, however, you will see the error:

        $ git --no-pager show foo-tag
        tag foo-tag
        Tagger: Junio C Hamano <gitster@pobox.com>
        Date:   Sat Feb 16 10:43:23 2008 -0800

        Tags 3b18e512dba79e4c8300dd08aeb37f8e728b8dad
        error: Could not read object 3b18e512dba79e4c8300dd08aeb37f8e728b8dad

Because we spawn the pager as the foreground process and feed
its input via pipe from the real command, we cannot affect the
exit status the shell sees from git command when the pager is in
use (I think there is not much gain we can have by working it
around, though).  But at least it may make sense to show the
error message to the user sitting in front of the pager, perhaps
like this.

What do people think?  Have I overlooked any downsides?

---
 usage.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/usage.c b/usage.c
index a5fc4ec..681b84a 100644
--- a/usage.c
+++ b/usage.c
@@ -4,12 +4,15 @@
  * Copyright (C) Linus Torvalds, 2005
  */
 #include "git-compat-util.h"
+#include "cache.h"
 
 static void report(const char *prefix, const char *err, va_list params)
 {
 	char msg[256];
+	FILE *outto = (pager_in_use() ? stdout : stderr);
+
 	vsnprintf(msg, sizeof(msg), err, params);
-	fprintf(stderr, "%s%s\n", prefix, msg);
+	fprintf(outto, "%s%s\n", prefix, msg);
 }
 
 static NORETURN void usage_builtin(const char *err)
