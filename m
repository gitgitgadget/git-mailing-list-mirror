From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: git update-index not delete lock file when using different
 worktree
Date: Thu, 17 Jul 2014 17:36:54 +0700
Message-ID: <20140717103654.GA18897@lanh>
References: <1405567125455-7615300.post@n2.nabble.com>
 <1405585628972-7615306.post@n2.nabble.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Yue Lin Ho <yuelinho777@gmail.com>
X-From: git-owner@vger.kernel.org Thu Jul 17 12:37:10 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7j3l-00011o-Sb
	for gcvg-git-2@plane.gmane.org; Thu, 17 Jul 2014 12:37:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932117AbaGQKhF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 17 Jul 2014 06:37:05 -0400
Received: from mail-pa0-f52.google.com ([209.85.220.52]:46704 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755370AbaGQKhB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 06:37:01 -0400
Received: by mail-pa0-f52.google.com with SMTP id bj1so3084380pad.25
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 03:37:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NoUyPoG4/lovoVWKJh6qDBfe7b2lKERIujLqaQhH7GM=;
        b=qTq/QJGJdIbstp+AqVkqwKvzsyC1daAkq8RbqXm6y+T6stv5rNguXPOFn1gaq1EvAT
         DQ7eYBIIGGdV48yCWrhk/e2AuJMSseAbMvlMzanR8wxd3nVblOl8kOsqgjdGdCDCBYPs
         rH2DJxSCXCGvgSWHR1rZhgjdcB8eg044m3mevq67kTOZrilIv1glbQC4ePEIwIaoXHd+
         BAoNaDopUAkWxE2pblGEYOQ92yJB/yn7Dl02ZmnjslrUkUfeCwPtqDJFAaaK4tVpqWb/
         Y+fJt4OvNtW0U40iaL4NDt+KtHlyFCcli77Wv5r1+xj99rjnW5yrWsfY7wSddSOyDRNJ
         7PEA==
X-Received: by 10.66.235.232 with SMTP id up8mr35476889pac.55.1405593420399;
        Thu, 17 Jul 2014 03:37:00 -0700 (PDT)
Received: from lanh ([115.73.251.38])
        by mx.google.com with ESMTPSA id cz3sm2109129pbc.9.2014.07.17.03.36.57
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 17 Jul 2014 03:36:59 -0700 (PDT)
Received: by lanh (sSMTP sendmail emulation); Thu, 17 Jul 2014 17:36:54 +0700
Content-Disposition: inline
In-Reply-To: <1405585628972-7615306.post@n2.nabble.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253729>

On Thu, Jul 17, 2014 at 01:27:08AM -0700, Yue Lin Ho wrote:
> I see that refresh() of update_index.c calls setup_work_tree() to change dir
> to working tree.
> And the dir is not changed back to git dir before commit_lock_file() or
> rollback_lock_file() is called.
> 
> So, commit_lock_file() rename file failed.
> or rollback_lock_file() delete file failed.

I think you're on the right track. Although the problem is
hold_locked_index() in cmd_update_index() when the index path is
relative. After setup_work_tree(), the saved path points to a wrong
place and can't be unlinked anymore.

This patch seems to fix it

-- 8< --
diff --git a/lockfile.c b/lockfile.c
index 2a800ce..69fe837 100644
--- a/lockfile.c
+++ b/lockfile.c
@@ -264,7 +264,8 @@ int commit_lock_file(struct lock_file *lk)
 
 int hold_locked_index(struct lock_file *lk, int die_on_error)
 {
-	return hold_lock_file_for_update(lk, get_index_file(),
+	return hold_lock_file_for_update(lk,
+					 absolute_path(get_index_file()),
 					 die_on_error
 					 ? LOCK_DIE_ON_ERROR
 					 : 0);
-- 8< --

We could turn all lockfile's path absolute when setup_work_tree()
moves pwd, but that seems dangerous without looking through how all
lockfiles are used.

--
Duy
