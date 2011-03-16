From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH/RFC] reflog: silence -O3 -Wuninitialized warning
Date: Tue, 15 Mar 2011 21:49:59 -0500
Message-ID: <20110316024959.GA24932@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 03:50:13 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PzgoP-0006vf-HF
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 03:50:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751859Ab1CPCuI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Mar 2011 22:50:08 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:59278 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751808Ab1CPCuH (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Mar 2011 22:50:07 -0400
Received: by qwk3 with SMTP id 3so977311qwk.19
        for <git@vger.kernel.org>; Tue, 15 Mar 2011 19:50:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:date:from:to:cc:subject:message-id:mime-version
         :content-type:content-disposition:user-agent;
        bh=2SXomh0EF+FprQBjj+Y8L3NoomBBRCVFj1TTZFsssS4=;
        b=Jd+MD+z99+KI63d2FQTUtoIcjPUnjm0fL+NlxX13aFrK50Xo1804bJ4RwIkiCzntcV
         xuJJDda7X5R5D4KKuRU6pt02fmMr5KODs2cNGKOlkGYqI0/OBbXTQvOPXIkJVn+ueHCt
         FdTP/AmQV7jxRpOYIYWl00M8pzlAdgmdVf/2o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:mime-version:content-type
         :content-disposition:user-agent;
        b=hUyVTup0qYDZp3/j2aBxg2p155z3qd9UlEO8ajUw5eYI1KeA+xJmZI09HEqZqCphwF
         CIFWedRT4lJEUx+stVrVn9s8U7kMzKYFiTwbFBYDpsDQUM/gbSkJvZX65oJ2vLNjaMpa
         IO75mNbMis7fxCSRR8SjCbhzhn2RKrdMnFmSI=
Received: by 10.229.53.79 with SMTP id l15mr191808qcg.83.1300243806488;
        Tue, 15 Mar 2011 19:50:06 -0700 (PDT)
Received: from elie (adsl-69-209-56-53.dsl.chcgil.sbcglobal.net [69.209.56.53])
        by mx.google.com with ESMTPS id l17sm386907qck.8.2011.03.15.19.50.04
        (version=SSLv3 cipher=OTHER);
        Tue, 15 Mar 2011 19:50:05 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169098>

Date: Fri, 04 Mar 2011 00:54:53 -0600

Starting with gcc 4.5 (r147852, Pretty-ipa merge: Inliner heruistics
reorg, 2009-05-25), gcc -O3 -Wall warns when building
reflog_expire_config:

    warning: 'expire' may be used uninitialized in this function [-Wuninitialized]

The cause: starting with that version, gcc realizes it can inline the
call to parse_expire_cfg_value.  In the error case, 'expire' is not
initialized and the function returns early, but gcc does not have
enough information to figure out that this is an error return.

Squash the warning by letting the optimizer peek at the return value
from config_error_nonbool.  This also decreases the text size by a
tiny (negligible) amount when building with -Os --- before:

    text    data     bss     dec     hex filename
 1002184   24856  316928 1343968  1481e0 git

After:

    text    data     bss     dec     hex filename
 1002120   24856  316928 1343904  1481a0 git

Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Hi,

Another patch that was sitting around in my tree.  (I had the somewhat
insane idea of turning on as many warnings as feasible and getting git
to build with -Werror.  The effect on running time for tests was
encouraging but within noise.)

While it might make sense to do something like this for error()
itself, I don't know a clean and portable way to make a variadic macro
or inline function.

Anyway, maybe this can provide some amusement.

 cache.h  |    8 +++++++-
 config.c |    4 ++--
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/cache.h b/cache.h
index c4ef999..c8ce53a 100644
--- a/cache.h
+++ b/cache.h
@@ -1022,10 +1022,16 @@ extern int check_repository_format_version(const char *var, const char *value, v
 extern int git_env_bool(const char *, int);
 extern int git_config_system(void);
 extern int git_config_global(void);
-extern int config_error_nonbool(const char *);
 extern const char *get_log_output_encoding(void);
 extern const char *get_commit_output_encoding(void);
 
+extern void config_print_error_nonbool(const char *);
+static inline int config_error_nonbool(const char *var)
+{
+	config_print_error_nonbool(var);
+	return -1;
+}
+
 extern const char *config_exclusive_filename;
 
 #define MAX_GITNAME (1000)
diff --git a/config.c b/config.c
index b94de8f..cf41c1c 100644
--- a/config.c
+++ b/config.c
@@ -1506,7 +1506,7 @@ int git_config_rename_section(const char *old_name, const char *new_name)
  * Call this to report error for your variable that should not
  * get a boolean value (i.e. "[my] var" means "true").
  */
-int config_error_nonbool(const char *var)
+void config_print_error_nonbool(const char *var)
 {
-	return error("Missing value for '%s'", var);
+	error("Missing value for '%s'", var);
 }
-- 
1.7.4.1
