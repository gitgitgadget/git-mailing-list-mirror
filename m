From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] git-daemon(1): assorted improvements.
Date: Wed, 29 Aug 2007 03:33:11 -0700
Message-ID: <7v3ay2r5p4.fsf_-_@gitster.siamese.dyndns.org>
References: <ejhm3gs6.fsf@cante.net>
	<7vabsasqk2.fsf@gitster.siamese.dyndns.org> <zm0a1vw9.fsf@cante.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jari Aalto <jari.aalto@cante.net>
X-From: git-owner@vger.kernel.org Wed Aug 29 12:33:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IQKrQ-0005jx-9J
	for gcvg-git@gmane.org; Wed, 29 Aug 2007 12:33:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751303AbXH2KdQ (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 29 Aug 2007 06:33:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751251AbXH2KdQ
	(ORCPT <rfc822;git-outgoing>); Wed, 29 Aug 2007 06:33:16 -0400
Received: from rune.sasl.smtp.pobox.com ([208.210.124.37]:49850 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750765AbXH2KdP (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 29 Aug 2007 06:33:15 -0400
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id D3DDC12923C;
	Wed, 29 Aug 2007 06:33:34 -0400 (EDT)
In-Reply-To: <zm0a1vw9.fsf@cante.net> (Jari Aalto's message of "Wed, 29 Aug
	2007 13:24:06 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/56932>

Jari Aalto noticed a handful places in git-daemon documentation
that need to be improved.

 * --inetd makes --pid-file to be ignored, in addition to --user
   and --group

 * receive-pack service was not described at all.  We should, if
   only to warn about the security implications of it.

 * There was no example of per repository configuration.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * I'm planning to commit this one.

 Documentation/git-daemon.txt |   36 ++++++++++++++++++++++++++++++++++--
 1 files changed, 34 insertions(+), 2 deletions(-)

diff --git a/Documentation/git-daemon.txt b/Documentation/git-daemon.txt
index f902161..efdcdad 100644
--- a/Documentation/git-daemon.txt
+++ b/Documentation/git-daemon.txt
@@ -124,7 +124,8 @@ OPTIONS
 	Detach from the shell. Implies --syslog.
 
 --pid-file=file::
-	Save the process id in 'file'.
+	Save the process id in 'file'.  Ignored when the daemon
+	is run under `--inetd`.
 
 --user=user, --group=group::
 	Change daemon's uid and gid before entering the service loop.
@@ -157,6 +158,13 @@ the facility of inet daemon to achieve the same before spawning
 SERVICES
 --------
 
+These services can be globally enabled/disabled using the
+command line options of this command.  If a finer-grained
+control is desired (e.g. to allow `git-archive` to be run
+against only in a few selected repositories the daemon serves),
+the per-repository configuration file can be used to enable or
+disable them.
+
 upload-pack::
 	This serves `git-fetch-pack` and `git-peek-remote`
 	clients.  It is enabled by default, but a repository can
@@ -164,7 +172,19 @@ upload-pack::
 	item to `false`.
 
 upload-archive::
-	This serves `git-archive --remote`.
+	This serves `git-archive --remote`.  It is disabled by
+	default, but a repository can enable it by setting
+	`daemon.uploadarchive` configuration item to `true`.
+
+receive-pack::
+	This serves `git-send-pack` clients, allowing anonymous
+	push.  It is disabled by default, as there is _no_
+	authentication in the protocol (in other words, anybody
+	can push anything into the repository, including removal
+	of refs).  This is solely meant for a closed LAN setting
+	where everybody is friendly.  This service can be
+	enabled by `daemon.receivepack` configuration item to
+	`true`.
 
 EXAMPLES
 --------
@@ -229,6 +249,18 @@ Repositories can still be accessed by hostname though, assuming
 they correspond to these IP addresses.
 
 
+To enable `git-archive --remote` and disable `git-fetch` against
+a repository, have the following in the configuration file in the
+repository (that is the file 'config' next to 'HEAD', 'refs' and
+'objects').
++
+----------------------------------------------------------------
+[daemon]
+	uploadpack = false
+	uploadarchive = true
+----------------------------------------------------------------
+
+
 Author
 ------
 Written by Linus Torvalds <torvalds@osdl.org>, YOSHIFUJI Hideaki
-- 
1.5.3.rc7
