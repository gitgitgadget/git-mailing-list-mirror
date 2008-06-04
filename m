From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] rollback lock files on more signals than just SIGINT
Date: Wed, 04 Jun 2008 10:29:28 -0700
Message-ID: <7vhcc9xg5j.fsf@gitster.siamese.dyndns.org>
References: <E1K1eXC-0005xW-Jd@fencepost.gnu.org>
 <alpine.DEB.1.00.0805291341290.13507@racer.site.net>
 <483EAD69.9090001@gnu.org>
 <alpine.DEB.1.00.0805291456030.13507@racer.site.net>
 <483EBF1F.9000809@gnu.org>
 <alpine.DEB.1.00.0805291541430.13507@racer.site.net>
 <E1K1jnV-0007HC-Om@fencepost.gnu.org>
 <e2b179460806040440m29f2326ek3757660646686623@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Paolo Bonzini" <bonzini@gnu.org>,
	"Johannes Schindelin" <Johannes.Schindelin@gmx.de>,
	"Git mailing list" <git@vger.kernel.org>
To: "Mike Ralphson" <mike.ralphson@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 04 19:30:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K3wor-0001LY-Cq
	for gcvg-git-2@gmane.org; Wed, 04 Jun 2008 19:30:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754902AbYFDR3s (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Jun 2008 13:29:48 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754324AbYFDR3s
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Jun 2008 13:29:48 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:54585 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754493AbYFDR3r (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Jun 2008 13:29:47 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id E9B145919;
	Wed,  4 Jun 2008 13:29:42 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id B9C8D590F; Wed,  4 Jun 2008 13:29:36 -0400 (EDT)
In-Reply-To: <e2b179460806040440m29f2326ek3757660646686623@mail.gmail.com>
 (Mike Ralphson's message of "Wed, 4 Jun 2008 12:40:37 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D1836024-325B-11DD-B066-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83798>

"Mike Ralphson" <mike.ralphson@gmail.com> writes:

> 2008/5/29 Paolo Bonzini <bonzini@gnu.org>:
> ...
> This addition to the testsuite breaks it on AIX with the default sh
> (ksh). Replacing the explicit sh -c with $SHELL_PATH -c fixes it for
> me (as I have SHELL_PATH pointing to bash). If that's acceptable I can
> post a patch if necessary.

Like the attached one?

I noticed quite a many "sh" dependencies in other test scripts:

 - t0021: rot13.sh does not begin with "#!$SHELL_PATH" nor any "#!"
 - t6026: custom-merge begins with "#!/bin/sh", not "#!$SHELL_PATH".
 - t6030: test_script.sh begins with "#!/bin/sh", not "#!$SHELL_PATH".
 - t7005: e-<editor>.sh do not begin with "#!$SHELL_PATH" nor any "#!"
 - t7402: fake-editor.sh begins with "#!/bin/sh", not "#!$SHELL_PATH".
 - t7502: you noticed
 - t9100: exec.sh begins with "#!/bin/sh", not "#!$SHELL_PATH".

I presume most of the scripts the above incorrectly feeds to "sh" not to
the shell you specify are plain vanilla scripts that not-quite-POSIX
shells can grok them, so in practice this may not be a problem, but we
should eventually fix them.

 t/t7502-commit.sh |    6 +++---
 1 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/t/t7502-commit.sh b/t/t7502-commit.sh
index a5801df..f43c1b1 100755
--- a/t/t7502-commit.sh
+++ b/t/t7502-commit.sh
@@ -217,14 +217,14 @@ test_expect_success 'do not fire editor in the presence of conflicts' '
 '
 
 pwd=`pwd`
-cat > .git/FAKE_EDITOR << EOF
-#! /bin/sh
+cat >.git/FAKE_EDITOR <<"EOF"
+#! $SHELL_PATH
 # kill -TERM command added below.
 EOF
 
 test_expect_success 'a SIGTERM should break locks' '
 	echo >>negative &&
-	sh -c '\''
+	"$SHELL_PATH" -c '\''
 	  echo kill -TERM $$ >> .git/FAKE_EDITOR
 	  GIT_EDITOR=.git/FAKE_EDITOR exec git commit -a'\'' && exit 1  # should fail
 	! test -f .git/index.lock
