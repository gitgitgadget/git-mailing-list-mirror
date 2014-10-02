From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/24] refs.c: refuse to lock badly named refs in
 lock_ref_sha1_basic
Date: Wed, 1 Oct 2014 19:01:31 -0700
Message-ID: <20141002020131.GZ1175@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <20141002014817.GS1175@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Oct 02 04:01:39 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZVi7-00078z-7N
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:01:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754157AbaJBCBf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:01:35 -0400
Received: from mail-pd0-f175.google.com ([209.85.192.175]:64200 "EHLO
	mail-pd0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754143AbaJBCBe (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:01:34 -0400
Received: by mail-pd0-f175.google.com with SMTP id v10so1187886pde.34
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=PmJ5xUhYBpIAOMU0foNUwza9NsQuhxfRx3S4by4LLtY=;
        b=0DCAaJMG+TSQciCPjY4Ngh0YxL6xd81lXQi+Iahgi5vpzhxXmBBZkz8Rf8Gi3PLQzM
         gRDLgmn0JenxD4zgui25Qx3G6E6M/9+hy12OzrwDEcqQXwZWEIDYuFIMBBxhjNMY1C+7
         PW3BlkarL5NiQI8fx/ocZoKgOVQ9HEdAJODf8ViwAiCs+f3XPcsCkY707BwiuxjnqYlj
         vSJdTBAI2Mk09KFmRCz15clzwZBXdPdP/v6QpSy6kFTTbtzOjRYiQKP5WeWERpImIIW8
         o8ZT/mimE3+59/6lqIS85Q73htPBE3v7ngGn9/sVipjghS2vnWxCc0yJQ6j+AhmNiJPw
         vyfg==
X-Received: by 10.70.48.142 with SMTP id l14mr35371339pdn.29.1412215294449;
        Wed, 01 Oct 2014 19:01:34 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id uu17sm2113074pab.43.2014.10.01.19.01.33
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:01:33 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257778>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 10:40:10 -0700

Move the check for check_refname_format from lock_any_ref_for_update to
lock_ref_sha1_basic.  At some later stage we will get rid of
lock_any_ref_for_update completely.  This has no visible impact to callers
except for the inability to lock badly named refs, which is not possible
today already for other reasons.(*)

Keep lock_any_ref_for_update as a no-op wrapper.  It is the public facing
version of this interface and keeping it as a separate function will make
it easier to experiment with the internal lock_ref_sha1_basic signature.

(*) For example, if lock_ref_sha1_basic checks the refname format and
refuses to lock badly named refs, it will not be possible to delete
such refs because the first step of deletion is to lock the ref.  We
currently already fail in that case because these refs are not recognized
to exist:

 $ cp .git/refs/heads/master .git/refs/heads/echo...\*\*
 $ git branch -D .git/refs/heads/echo...\*\*
 error: branch '.git/refs/heads/echo...**' not found.

This has been broken for a while.  Later patches in the series will start
repairing the handling of badly named refs.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Change since v21:
- clarified commit message

 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 39571f5..3c2ce57 100644
--- a/refs.c
+++ b/refs.c
@@ -2091,6 +2091,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2182,8 +2187,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.1.0.rc2.206.gedb03e5
