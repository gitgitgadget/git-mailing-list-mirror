From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-rm -n leaves .git/index.lock if not allowed to finish
Date: Thu, 18 Dec 2008 17:31:57 -0800
Message-ID: <7vljuddk6q.fsf@gitster.siamese.dyndns.org>
References: <87prjptfo7.fsf@jidanni.org>
 <20081219002524.GB21154@genesis.frugalware.org>
 <7v4p11f18d.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: jidanni@jidanni.org, git@vger.kernel.org
To: Miklos Vajna <vmiklos@frugalware.org>
X-From: git-owner@vger.kernel.org Fri Dec 19 02:33:24 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDUF1-00034a-2c
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 02:33:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752162AbYLSBcH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Dec 2008 20:32:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752089AbYLSBcG
	(ORCPT <rfc822;git-outgoing>); Thu, 18 Dec 2008 20:32:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50968 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751742AbYLSBcF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Dec 2008 20:32:05 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B3A08836D;
	Thu, 18 Dec 2008 20:32:03 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 7AFB78836C; Thu,
 18 Dec 2008 20:31:59 -0500 (EST)
In-Reply-To: <7v4p11f18d.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Thu, 18 Dec 2008 16:38:26 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D6D7529A-CD6C-11DD-8A30-5720C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103527>

Subject: [PATCH] Make sure lockfiles are unlocked when dying on SIGPIPE

We cleaned up lockfiles upon receiving the usual suspects HUP, TERM, QUIT
but a wicked user could kill us of asphyxiation by piping our output to a
pipe that does not read.  Protect ourselves by catching SIGPIPE and clean
up the lockfiles as well in such a case.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 lockfile.c    |    1 +
 t/t3600-rm.sh |   17 +++++++++++++++++
 2 files changed, 18 insertions(+), 0 deletions(-)

diff --git c/lockfile.c w/lockfile.c
index 6d75608..8589155 100644
--- c/lockfile.c
+++ w/lockfile.c
@@ -140,6 +140,7 @@ static int lock_file(struct lock_file *lk, const char *path, int flags)
 			signal(SIGHUP, remove_lock_file_on_signal);
 			signal(SIGTERM, remove_lock_file_on_signal);
 			signal(SIGQUIT, remove_lock_file_on_signal);
+			signal(SIGPIPE, remove_lock_file_on_signal);
 			atexit(remove_lock_file);
 		}
 		lk->owner = getpid();
diff --git c/t/t3600-rm.sh w/t/t3600-rm.sh
index b7d46e5..95542e9 100755
--- c/t/t3600-rm.sh
+++ w/t/t3600-rm.sh
@@ -251,4 +251,21 @@ test_expect_success 'refresh index before checking if it is up-to-date' '
 
 '
 
+test_expect_success 'choking "git rm" should not let it die with cruft' '
+	git reset -q --hard &&
+	H=0000000000000000000000000000000000000000 &&
+	i=0 &&
+	while test $i -lt 12000
+	do
+	    echo "100644 $H 0	some-file-$i"
+	    i=$(( $i + 1 ))
+	done | git update-index --index-info &&
+	git rm -n "some-file-*" | :;
+	test -f .git/index.lock
+	status=$?
+	rm -f .git/index.lock
+	git reset -q --hard
+	test "$status" != 0
+'
+
 test_done
