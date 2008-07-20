From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] index: be careful when handling long names
Date: Sat, 19 Jul 2008 17:51:13 -0700
Message-ID: <7vhcaljs3i.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Petr Baudis <pasky@suse.cz>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Jul 20 02:52:22 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KKN9x-0007uL-Qa
	for gcvg-git-2@gmane.org; Sun, 20 Jul 2008 02:52:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754656AbYGTAvV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Jul 2008 20:51:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754576AbYGTAvV
	(ORCPT <rfc822;git-outgoing>); Sat, 19 Jul 2008 20:51:21 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42095 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754528AbYGTAvU (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Jul 2008 20:51:20 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 6AD12398A3;
	Sat, 19 Jul 2008 20:51:18 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id A2167398A2; Sat, 19 Jul 2008 20:51:15 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F6A33EDE-55F5-11DD-93D5-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/89147>

This is a follow-up to 7fec10b (index: be careful when handling long
names, 2008-01-18) where we fixed handling of index entries with long
names.  There still remained a few remaining unsafe codepaths.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 builtin-apply.c        |    2 +-
 builtin-update-index.c |    2 +-
 read-cache.c           |    2 +-
 3 files changed, 3 insertions(+), 3 deletions(-)

diff --git a/builtin-apply.c b/builtin-apply.c
index e15471b..f2377fe 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -2758,7 +2758,7 @@ static void add_index_file(const char *path, unsigned mode, void *buf, unsigned
 	ce = xcalloc(1, ce_size);
 	memcpy(ce->name, path, namelen);
 	ce->ce_mode = create_ce_mode(mode);
-	ce->ce_flags = namelen;
+	ce->ce_flags = create_ce_flags(namelen, 0);
 	if (S_ISGITLINK(mode)) {
 		const char *s = buf;
 
diff --git a/builtin-update-index.c b/builtin-update-index.c
index 38eb53c..003cb98 100644
--- a/builtin-update-index.c
+++ b/builtin-update-index.c
@@ -95,7 +95,7 @@ static int add_one_path(struct cache_entry *old, const char *path, int len, stru
 	size = cache_entry_size(len);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, len);
-	ce->ce_flags = len;
+	ce->ce_flags = create_ce_flags(len, 0);
 	fill_stat_cache_info(ce, st);
 	ce->ce_mode = ce_mode_from_stat(old, st->st_mode);
 
diff --git a/read-cache.c b/read-cache.c
index 1648428..2dd8131 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -498,7 +498,7 @@ int add_to_index(struct index_state *istate, const char *path, struct stat *st,
 	size = cache_entry_size(namelen);
 	ce = xcalloc(1, size);
 	memcpy(ce->name, path, namelen);
-	ce->ce_flags = namelen;
+	ce->ce_flags = create_ce_flags(namelen, 0);
 	fill_stat_cache_info(ce, st);
 
 	if (trust_executable_bit && has_symlinks)
