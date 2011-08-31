From: Matthieu Moy <Matthieu.Moy@imag.fr>
Subject: [PATCH] git-remote-helpers.txt: explain how import works with multiple refs
Date: Wed, 31 Aug 2011 18:47:02 +0200
Message-ID: <1314809222-30528-1-git-send-email-Matthieu.Moy@imag.fr>
References: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org, gitster@pobox.com
X-From: git-owner@vger.kernel.org Wed Aug 31 18:47:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qynww-0001Fp-DF
	for gcvg-git-2@lo.gmane.org; Wed, 31 Aug 2011 18:47:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932103Ab1HaQrd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 31 Aug 2011 12:47:33 -0400
Received: from mx1.imag.fr ([129.88.30.5]:40999 "EHLO shiva.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756322Ab1HaQrd (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Aug 2011 12:47:33 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by shiva.imag.fr (8.13.8/8.13.8) with ESMTP id p7VGkh1q013084
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 31 Aug 2011 18:46:43 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtps (TLS1.0:RSA_AES_256_CBC_SHA1:32)
	(Exim 4.69)
	(envelope-from <moy@imag.fr>)
	id 1Qynwf-0005LC-Ne; Wed, 31 Aug 2011 18:47:21 +0200
Received: from moy by bauges.imag.fr with local (Exim 4.72)
	(envelope-from <moy@imag.fr>)
	id 1Qynwf-00027a-Jo; Wed, 31 Aug 2011 18:47:21 +0200
X-Mailer: git-send-email 1.7.7.rc0.78.ge4b5a.dirty
In-Reply-To: <CAGdFq_gooPGQMa5D19-wag=X+mDntHF1MwXiYF0zovB=L-Sybw@mail.gmail.com>
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.0.1 (shiva.imag.fr [129.88.30.5]); Wed, 31 Aug 2011 18:46:44 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p7VGkh1q013084
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: moy@imag.fr
MailScanner-NULL-Check: 1315414006.6984@zahDCG38ptQl4Ji9qw8kjg
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180485>

This is important for two reasons:

* when two "import" lines follow each other, only one "done" command
  should be issued in the fast-import stream, not one per "import".

* The blank line terminating an import command should not be confused
  with the one terminating the sequence of commands.

While we're there, illustrate the corresponding explanation for push
batches with an example.

Signed-off-by: Matthieu Moy <Matthieu.Moy@imag.fr>
---
Sverre Rabbelier <srabbelier@gmail.com> writes:

> No, a list of 'import' statements has to be followed by a \n, similar
> to the push command. You can have multiple 'blocks' of import/push
> commands, but each block has to be followed by a newline. Again, you
> should read:
>
> import A
> import B
> \n
> import C
> import D
> \n

Thanks for the explanation. This was documented for 'push', but your
illustration made it easier for me to understand, so I've added the
example for push.

The documentation of "batch import" also fixes the "it's not
documented that remote-helpers should use 'done'" as a side-effect.

While investigating all this, I found in git-remote-testgit.py that
the remote-helpers had an "export" functionality, which seems totally
undocumented. Any volunteer to document it?

 Documentation/git-remote-helpers.txt |   22 +++++++++++++++++++++-
 1 files changed, 21 insertions(+), 1 deletions(-)

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 760b164..526fc6a 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -241,7 +241,22 @@ Supported if the helper has the "fetch" capability.
 'push' +<src>:<dst>::
 	Pushes the given local <src> commit or branch to the
 	remote branch described by <dst>.  A batch sequence of
-	one or more push commands is terminated with a blank line.
+	one or more 'push' commands is terminated with a blank line
+	(if there is only one reference to push, a single 'push' command
+	is followed by a blank line). For example, the following would
+	be two batches of 'push', the first asking the remote-helper
+	to push the local ref 'master' to the remote ref 'master' and
+	the local 'HEAD' to the remote 'branch', and the second
+	asking to push ref 'foo' to ref 'bar' (forced update requested
+	by the '+').
++
+------------
+push refs/heads/master:refs/heads/master
+push HEAD:refs/heads/branch
+\n
+push +refs/heads/foo:refs/heads/bar
+\n
+------------
 +
 Zero or more protocol options may be entered after the last 'push'
 command, before the batch's terminating blank line.
@@ -266,6 +281,11 @@ Supported if the helper has the "push" capability.
 Especially useful for interoperability with a foreign versioning
 system.
 +
+Just like 'push', a batch sequence of one or more 'import' is
+terminated with a blank line. For each batch of 'import', the remote
+helper should produce a fast-import stream terminated by a 'done'
+command.
++
 Supported if the helper has the "import" capability.
 
 'connect' <service>::
-- 
1.7.7.rc0.78.ge4b5a.dirty
