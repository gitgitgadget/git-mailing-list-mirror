From: Johan Herland <johan@herland.net>
Subject: [PATCH/RFC 6/7] git-init: Apply correct mode bits to template files in
 shared/restricted repo
Date: Wed, 25 Mar 2009 22:41:23 +0100
Message-ID: <200903252241.23302.johan@herland.net>
References: <200903250105.05808.johan@herland.net>
 <7v63hybaqd.fsf@gitster.siamese.dyndns.org>
 <200903252236.03010.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: 7BIT
Cc: Junio C Hamano <gitster@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 25 22:44:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmatK-0007ud-2Y
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 22:44:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755807AbZCYVl3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Mar 2009 17:41:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752391AbZCYVl3
	(ORCPT <rfc822;git-outgoing>); Wed, 25 Mar 2009 17:41:29 -0400
Received: from mx.getmail.no ([84.208.15.66]:43010 "EHLO
	get-mta-out02.get.basefarm.net" rhost-flags-OK-OK-OK-FAIL)
	by vger.kernel.org with ESMTP id S1755350AbZCYVl2 (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 25 Mar 2009 17:41:28 -0400
Content-disposition: inline
Received: from mx.getmail.no ([10.5.16.4]) by get-mta-out02.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300M8Q091LV00@get-mta-out02.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:41:25 +0100 (MET)
Received: from alpha.localnet ([84.215.102.95])
 by get-mta-in01.get.basefarm.net
 (Sun Java(tm) System Messaging Server 7.0-0.04 64bit (built Jun 20 2008))
 with ESMTP id <0KH300BNE08ZRQ00@get-mta-in01.get.basefarm.net> for
 git@vger.kernel.org; Wed, 25 Mar 2009 22:41:25 +0100 (MET)
X-PMX-Version: 5.5.3.366731, Antispam-Engine: 2.7.0.366912,
 Antispam-Data: 2009.3.25.212528
User-Agent: KMail/1.11.1 (Linux/2.6.28-ARCH; KDE/4.2.1; x86_64; ; )
In-reply-to: <200903252236.03010.johan@herland.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114677>

Template dirs/files are copied into the new repo before the config file is
parsed. This causes them to be created with default permissions (i.e. from
umask). When "--shared" and/or "--restricted" is given, this patch teaches
git-init to initialize the global variables controlling permissions on
created files (shared_repository and/or restricted_repository) _before_
the templates are copied. They are thus created with the appropriate
permissions.

Signed-off-by: Johan Herland <johan@herland.net>
---
 builtin-init-db.c |    9 +++++++++
 1 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/builtin-init-db.c b/builtin-init-db.c
index 8e7fa2d..fb88f65 100644
--- a/builtin-init-db.c
+++ b/builtin-init-db.c
@@ -187,6 +187,15 @@ static int create_default_files(const char *template_path)
 	safe_create_dir(git_path("refs/heads"), 1);
 	safe_create_dir(git_path("refs/tags"), 1);
 
+	/*
+	 * Set up shared/restricted_repository before copying templates, so
+	 * that they are created with appropriate permissions.
+	 */
+	if (init_shared_repository != -1)
+		shared_repository = init_shared_repository;
+	if (init_restricted_repository != -1)
+		restricted_repository = init_restricted_repository;
+
 	/* First copy the templates -- we might have the default
 	 * config file there, in which case we would want to read
 	 * from it after installing.
-- 
1.6.2.1.473.g92672
