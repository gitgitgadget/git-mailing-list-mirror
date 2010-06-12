From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 2/4] Unify code paths of threaded greps
Date: Sat, 12 Jun 2010 11:32:11 -0500
Message-ID: <20100612163211.GB5657@burratino>
References: <20100605005116.GA8774@progeny.tock>
 <alpine.DEB.1.00.1006051810300.1732@bonsai2>
 <20100612075542.GB2918@burratino>
 <alpine.DEB.1.00.1006121139290.2689@bonsai2>
 <20100612162945.GB1406@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Sat Jun 12 18:32:23 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ONTd8-0005Uh-T8
	for gcvg-git-2@lo.gmane.org; Sat, 12 Jun 2010 18:32:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751923Ab0FLQcS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Jun 2010 12:32:18 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:43006 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751539Ab0FLQcS (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Jun 2010 12:32:18 -0400
Received: by iwn9 with SMTP id 9so1590802iwn.19
        for <git@vger.kernel.org>; Sat, 12 Jun 2010 09:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=5cJgakwDHNbQocIa/cNvRtIYKQVI/KEtvbjg61Qw050=;
        b=GvJAbt8G762l4fnxGeS8uR0ymmWkkyMvXbIt4/RlDXUg0V7SdXhLilTFEPdm3opIup
         nu7TQBg5uHtEKXJR5ua1tBf0HpduYvNTpDsvvCSIBGleh3J9Lb5QGo8gakEv0RHFITer
         7MLc6PGsfdyibWxfcH7Vi8nEouDQNVidqaZfc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=bSPE6yZezJLx0ZPqLBgdHb9gQYf7len54Y4xbnZEqhqdv29zYU7LFUm5J9pZPGPyrH
         3SZMDdqSAc9qQUkJIOtcHO0tpeybKc+PId+l8ypUr+w92BwTfsSSmIBuK4EgcLAbsWYt
         x0FU5ZHR/qezY4KhXy38zat+PMjNkDrwW0eps=
Received: by 10.231.124.5 with SMTP id s5mr3521621ibr.195.1276360337022;
        Sat, 12 Jun 2010 09:32:17 -0700 (PDT)
Received: from burratino (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id d9sm11093956ibl.16.2010.06.12.09.32.16
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 12 Jun 2010 09:32:16 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100612162945.GB1406@burratino>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/149017>

From: Johannes Schindelin <johannes.schindelin@gmx.de>

There were three awfully similar code paths ending the threaded grep. It
is better to avoid duplicated code, though.

This change might very well prevent a race, where the grep patterns were
free()d before waiting that all threads finished.

Signed-off-by: Johannes Schindelin <johannes.schindelin@gmx.de>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 builtin/grep.c |   22 +++++-----------------
 1 files changed, 5 insertions(+), 17 deletions(-)

diff --git a/builtin/grep.c b/builtin/grep.c
index 5b8879f..2111212 100644
--- a/builtin/grep.c
+++ b/builtin/grep.c
@@ -590,7 +590,6 @@ static int grep_cache(struct grep_opt *opt, const char **paths, int cached)
 		if (hit && opt->status_only)
 			break;
 	}
-	free_grep_patterns(opt);
 	return hit;
 }
 
@@ -708,7 +707,6 @@ static int grep_directory(struct grep_opt *opt, const char **paths)
 		if (hit && opt->status_only)
 			break;
 	}
-	free_grep_patterns(opt);
 	return hit;
 }
 
@@ -1019,32 +1017,22 @@ int cmd_grep(int argc, const char **argv, const char *prefix)
 	}
 
 	if (!use_index) {
-		int hit;
 		if (cached)
 			die("--cached cannot be used with --no-index.");
 		if (list.nr)
 			die("--no-index cannot be used with revs.");
 		hit = grep_directory(&opt, paths);
-		if (use_threads)
-			hit |= wait_all();
-		return !hit;
-	}
-
-	if (!list.nr) {
-		int hit;
+	} else if (!list.nr) {
 		if (!cached)
 			setup_work_tree();
 
 		hit = grep_cache(&opt, paths, cached);
-		if (use_threads)
-			hit |= wait_all();
-		return !hit;
+	} else {
+		if (cached)
+			die("both --cached and trees are given.");
+		hit = grep_objects(&opt, paths, &list);
 	}
 
-	if (cached)
-		die("both --cached and trees are given.");
-	hit = grep_objects(&opt, paths, &list);
-
 	if (use_threads)
 		hit |= wait_all();
 	free_grep_patterns(&opt);
-- 
1.7.1
