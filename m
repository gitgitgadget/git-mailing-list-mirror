From: "Kyle J. McKay" <mackyle@gmail.com>
Subject: [PATCH] gc: notice gc processes run by other users
Date: Tue, 31 Dec 2013 04:07:39 -0800
Message-ID: <720d7a5676f8cbfc76c80198f9d3816@74d39fa044aa309eaea14b9f57fe79c>
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?q?Nguy=E1=BB=85n=20Th=C3=A1i=20Ng=E1=BB=8Dc=20Duy?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Dec 31 13:07:57 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxy71-0001WF-No
	for gcvg-git-2@plane.gmane.org; Tue, 31 Dec 2013 13:07:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752842Ab3LaMHv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Dec 2013 07:07:51 -0500
Received: from mail-pd0-f172.google.com ([209.85.192.172]:53773 "EHLO
	mail-pd0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752796Ab3LaMHv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Dec 2013 07:07:51 -0500
Received: by mail-pd0-f172.google.com with SMTP id g10so12293214pdj.31
        for <git@vger.kernel.org>; Tue, 31 Dec 2013 04:07:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=kmXztA3o75KmZTh9r3qnd6UQYiISVOfI5RBeJqo12HE=;
        b=hEVQOcQ1vWXs5dZvd5+2FY3983BwHTsUMzbCwq0DG+GtqDseZfLw5lzvZNi60uPHYJ
         3oJ+LyXHzIQOat2UcziwgZEfbQfTmP9UC9deeuvd00dsdz2gGPJIohHAT3VpcLE1lszW
         upl+yFhuteKlidNzRnj4VVDAMitQOyl7hJFyH/zjWMLhrBlQryn3wQ+QUfeEATe/SYZQ
         vYrUTJEa874GegmTNwq83Qks6FXc47s97YOVDZN6vRE8baae9i48nOp2Vw+dSQWnOr+E
         xI/kxba01IBjHcLA8N5/iyWei/uOFrshwc5qpZfM6Fwl0wgPEBs2NAW1wlGHvuqC3ghk
         VfSA==
X-Received: by 10.66.231.6 with SMTP id tc6mr75974710pac.68.1388491670610;
        Tue, 31 Dec 2013 04:07:50 -0800 (PST)
Received: from localhost.localdomain (ip72-192-173-141.sd.sd.cox.net. [72.192.173.141])
        by mx.google.com with ESMTPSA id yd4sm88109087pbc.13.2013.12.31.04.07.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 31 Dec 2013 04:07:50 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239838>

Since 64a99eb4 git gc refuses to run without the --force option if
another gc process on the same repository is already running.

However, if the repository is shared and user A runs git gc on the
repository and while that gc is still running user B runs git gc on
the same repository the gc process run by user A will not be noticed
and the gc run by user B will go ahead and run.

The problem is that the kill(pid, 0) test fails with an EPERM error
since user B is not allowed to signal processes owned by user A
(unless user B is root).

Update the test to recognize an EPERM error as meaning the process
exists and another gc should not be run (unless --force is given).
---

I suggest this be included in maint as others may also have expected the
shared repository, different user gc scenario to be caught by the new
code when in fact it's not without this patch.

 builtin/gc.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/builtin/gc.c b/builtin/gc.c
index c14190f8..25f2237c 100644
--- a/builtin/gc.c
+++ b/builtin/gc.c
@@ -222,7 +222,7 @@ static const char *lock_repo_for_gc(int force, pid_t* ret_pid)
 			time(NULL) - st.st_mtime <= 12 * 3600 &&
 			fscanf(fp, "%"PRIuMAX" %127c", &pid, locking_host) == 2 &&
 			/* be gentle to concurrent "gc" on remote hosts */
-			(strcmp(locking_host, my_host) || !kill(pid, 0));
+			(strcmp(locking_host, my_host) || !kill(pid, 0) || errno == EPERM);
 		if (fp != NULL)
 			fclose(fp);
 		if (should_exit) {
-- 
1.8.5.2
