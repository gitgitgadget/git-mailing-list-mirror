From: Alex Riesen <raa.lkml@gmail.com>
Subject: [PATCH] Make use of stat.ctime configurable
Date: Mon, 28 Jul 2008 08:31:28 +0200
Message-ID: <20080728063128.GA4234@blimp.local>
References: <20080722203128.GB5113@blimp.local> <7vr69lihkt.fsf@gitster.siamese.dyndns.org> <20080723164614.GB5283@blimp.local> <alpine.DEB.1.00.0807231757550.8986@racer> <20080723191647.GF5283@blimp.local> <alpine.LFD.1.10.0807241854580.5249@nehalem.linux-foundation.org> <20080725055547.GA3699@blimp.local> <alpine.DEB.1.00.0807260256030.11976@eeepc-johanness> <20080726153802.GA16868@blimp.local> <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
Reply-To: Alex Riesen <raa.lkml@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jul 28 08:32:37 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KNMHc-0001t8-JX
	for gcvg-git-2@gmane.org; Mon, 28 Jul 2008 08:32:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751496AbYG1Gbh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Jul 2008 02:31:37 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751003AbYG1Gbh
	(ORCPT <rfc822;git-outgoing>); Mon, 28 Jul 2008 02:31:37 -0400
Received: from mo-p05-ob.rzone.de ([81.169.146.182]:49302 "EHLO
	mo-p05-ob.rzone.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750726AbYG1Gbg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Jul 2008 02:31:36 -0400
X-RZG-CLASS-ID: mo05
X-RZG-AUTH: :YSxENQjhO8RswxTRIGdg2r44guxV
Received: from tigra.home (Fa949.f.strato-dslnet.de [195.4.169.73])
	by post.webmailer.de (fruni mo61) (RZmta 16.47)
	with ESMTP id o03a77k6S6Lb1w ; Mon, 28 Jul 2008 08:31:29 +0200 (MEST)
	(envelope-from: <raa.lkml@gmail.com>)
Received: from blimp (unknown [192.168.0.8])
	by tigra.home (Postfix) with ESMTP id 2E7CD277BD;
	Mon, 28 Jul 2008 08:31:29 +0200 (CEST)
Received: by blimp (Postfix, from userid 1000)
	id F3F6E36D18; Mon, 28 Jul 2008 08:31:28 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <7v1w1f155p.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/90418>

because there are situations where it produces too much false
positives. Like when file system crawlers keep changing it when
scanning and using the ctime for marking scanned files.

The default is to allow use of ctime.

Signed-off-by: Alex Riesen <raa.lkml@gmail.com>
---
Junio C Hamano, Sun, Jul 27, 2008 21:46:42 +0200:
> Alex Riesen <raa.lkml@gmail.com> writes:
> 
> > because there are situations where it produces too much false
> > positives. Like when file system crawlers keep changing it when
> > scanning and using the ctime for marking scanned files.
> 
> This justification is good and I am very inclined to advocate for its
> inclusion in 1.6.0, but any new configuration needs to be in the
> documentation.

Done.

> It appears there is "gui.trustmtime"; shouldn't this be called
> "core.trustctime" or something?

Getting old... I even called the global flag trust_file_ctime!
Corrected. Changed trust_file_ctime to trust_ctime.

 Documentation/config.txt           |    7 +++++++
 Documentation/git-update-index.txt |    5 +++++
 cache.h                            |    1 +
 config.c                           |    4 ++++
 environment.c                      |    1 +
 read-cache.c                       |    2 +-
 6 files changed, 19 insertions(+), 1 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 1a13abc..552c134 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -149,6 +149,13 @@ core.safecrlf::
 	`core.autocrlf`, git will reject the file.  The variable can
 	be set to "warn", in which case git will only warn about an
 	irreversible conversion but continue the operation.
+
+core.trustctime::
+	If false, the ctime differences between the index and the
+	working copy are ignored; useful when the inode change time
+	is regularly modified by something outside Git (file system
+	crawlers and some backup systems).
+	See linkgit:git-update-index[1]. True by default.
 +
 CRLF conversion bears a slight chance of corrupting data.
 autocrlf=true will convert CRLF to LF during commit and LF to
diff --git a/Documentation/git-update-index.txt b/Documentation/git-update-index.txt
index 6b930bc..1d9d81a 100644
--- a/Documentation/git-update-index.txt
+++ b/Documentation/git-update-index.txt
@@ -323,6 +323,11 @@ from symbolic link to regular file.
 The command looks at `core.ignorestat` configuration variable.  See
 'Using "assume unchanged" bit' section above.
 
+The command also looks at `core.trustctime` configuration variable.
+It can be useful when the inode change time is regularly modified by
+something outside Git (file system crawlers and backup systems use
+ctime for marking files processed) (see linkgit:git-config[1]).
+
 
 SEE ALSO
 --------
diff --git a/cache.h b/cache.h
index 4b6c0a6..2475de9 100644
--- a/cache.h
+++ b/cache.h
@@ -423,6 +423,7 @@ extern int delete_ref(const char *, const unsigned char *sha1);
 
 /* Environment bits from configuration mechanism */
 extern int trust_executable_bit;
+extern int trust_ctime;
 extern int quote_path_fully;
 extern int has_symlinks;
 extern int ignore_case;
diff --git a/config.c b/config.c
index 1e066c7..53f04a0 100644
--- a/config.c
+++ b/config.c
@@ -341,6 +341,10 @@ static int git_default_core_config(const char *var, const char *value)
 		trust_executable_bit = git_config_bool(var, value);
 		return 0;
 	}
+	if (!strcmp(var, "core.trustctime")) {
+		trust_ctime = git_config_bool(var, value);
+		return 0;
+	}
 
 	if (!strcmp(var, "core.quotepath")) {
 		quote_path_fully = git_config_bool(var, value);
diff --git a/environment.c b/environment.c
index 4a88a17..0c6d11f 100644
--- a/environment.c
+++ b/environment.c
@@ -13,6 +13,7 @@ char git_default_email[MAX_GITNAME];
 char git_default_name[MAX_GITNAME];
 int user_ident_explicitly_given;
 int trust_executable_bit = 1;
+int trust_ctime = 1;
 int has_symlinks = 1;
 int ignore_case;
 int assume_unchanged;
diff --git a/read-cache.c b/read-cache.c
index 6c08803..1cae361 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -197,7 +197,7 @@ static int ce_match_stat_basic(struct cache_entry *ce, struct stat *st)
 	}
 	if (ce->ce_mtime != (unsigned int) st->st_mtime)
 		changed |= MTIME_CHANGED;
-	if (ce->ce_ctime != (unsigned int) st->st_ctime)
+	if (trust_ctime && ce->ce_ctime != (unsigned int) st->st_ctime)
 		changed |= CTIME_CHANGED;
 
 	if (ce->ce_uid != (unsigned int) st->st_uid ||
-- 
1.6.0.rc0.76.g581e
