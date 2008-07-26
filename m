From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make use of stat.ctime configurable
Date: Sat, 26 Jul 2008 17:38:02 +0200
Message-ID: <20080726153802.GA16868@blimp.local>
References: <20080722193901.GA5113@blimp.local> <alpine.DEB.1.00.0807222115440.8986@racer> <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sun Jul 27 12:10:06 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KN3Bh-00076U-AN
	for gcvg-git-2@gmane.org; Sun, 27 Jul 2008 12:09:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751224AbYG0KG3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 27 Jul 2008 06:06:29 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751205AbYG0KG3
	(ORCPT <rfc822;git-outgoing>); Sun, 27 Jul 2008 06:06:29 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:18088 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751215AbYG0KG2 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 27 Jul 2008 06:06:28 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44guxV
Received: from tigra.home (Fa949.f.strato-dslnet.de [195.4.169.73])
	by post.webmailer.de (klopstock mo33) (RZmta 16.47)
	with ESMTP id c027c3k6R93Oiw ; Sun, 27 Jul 2008 12:06:20 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.1.28])
	by tigra.home (Postfix) with ESMTP id 6AF02277BD;
	Sun, 27 Jul 2008 12:06:20 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id 8BDB636D18; Sat, 26 Jul 2008 17:38:02 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90328>

because there are situations where it produces too much false
positives. Like when file system crawlers keep changing it when
scanning and using the ctime for marking scanned files.

The default is to allow use of ctime.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Johannes Schindelin, Sat, Jul 26, 2008 02:57:25 +0200:
> On Fri, 25 Jul 2008, Alex Riesen wrote:
> > But, given the fact, that somewhere sometimes its very-very annoying to 
> > have even one (un)changed file, something must be done about it. Maybe 
> > just direct
> > 
> > [...]
> > 	trustctime = false
> 
> ... which is all Junio and I were asking all along: a separate way to ask 
> for ignoring ctime; not just DWIM it on top of the executable bit.

Oh...

 cache.h       |    1 +
 config.c      |    4 ++++
 environment.c |    1 +
 read-cache.c  |    2 +-
 4 files changed, 7 insertions(+), 1 deletions(-)

diff --git a/cache.h b/cache.h
index 38985aa..00d02d3 100644
--- a/cache.h
+++ b/cache.h
@@ -421,6 +421,7 @@ extern int delete_ref(const char *, const unsigned char *sha1);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
+extern int trust_file_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int ignore_case;
diff --git a/config.c b/config.c
index 1e066c7..860e8ab 100644
--- a/config.c
+++ b/config.c
@@ -341,6 +341,10 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.filectime")) {
+		trust_file_ctime = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index 4a88a17..4982771 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
+int trust_file_ctime = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/read-cache.c b/read-cache.c
index a50a851..00d39dc 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -181,7 +181,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime != (unsigned int) st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (ce->ce_ctime != (unsigned int) st->st_ctime)
+	if (trust_file_ctime && ce->ce_ctime != (unsigned int) st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
-- 
1.6.0.rc0.76.g581e
