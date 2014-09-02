From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 18/22] refs.c: remove lock_ref_sha1
Date: Tue, 2 Sep 2014 14:09:12 -0700
Message-ID: <20140902210912.GS18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140826000354.GW20185@google.com>
 <xmqqlhqbge3a.fsf@gitster.dls.corp.google.com>
 <20140826221448.GY20185@google.com>
 <20140827002804.GA20185@google.com>
 <20140902205841.GA18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 23:09:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOvKJ-00068s-U0
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 23:09:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755298AbaIBVJQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Sep 2014 17:09:16 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:37972 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754776AbaIBVJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Sep 2014 17:09:15 -0400
Received: by mail-pd0-f181.google.com with SMTP id fp1so9523764pdb.40
        for <git@vger.kernel.org>; Tue, 02 Sep 2014 14:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=qO6r5jFxYNcs6iR16oV+kuR86ZQwEk2zr7OmMgSI4nk=;
        b=uskfegrwSsyjwYaNRZZrrBTJrQt5yPn91DUjZCQvOtKqKVI9ILuuYnWDvMP6zk5sBa
         Or8VuG5M26urOhot8/DJk1qIwFZiRVc0qP1gV0nOnpK+VkAYCfWaO3ajjS2vBioM3qPB
         ksyTtzmI5N28tInShbouNNzLf+lsYYunNFkzhuT3wLHLS/fN4lJQkDveF0w6pOlpFOGd
         n+B/8vB//E80xmG9KyAiYjenmz1y3aJZ95r76bWBaCaouDh8psTh+9sIKSzemt/yl0lx
         sd5ZX86tzZG7dF7fQaDHMYUi7RxVdOCJM/rRTZEUk3gPyd8pIcLujRChkKwJrvathSmH
         cYkQ==
X-Received: by 10.66.197.132 with SMTP id iu4mr15718316pac.132.1409692154945;
        Tue, 02 Sep 2014 14:09:14 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id nz10sm4838937pbb.82.2014.09.02.14.09.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 02 Sep 2014 14:09:14 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140902205841.GA18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256364>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Tue, 29 Apr 2014 15:45:52 -0700

lock_ref_sha1 was only called from one place in refs.c and only provided
a check that the refname was sane before adding back the initial "refs/"
part of the ref path name, the initial "refs/" that this caller had already
stripped off before calling lock_ref_sha1.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/refs.c b/refs.c
index a6b39ec..fd67684 100644
--- a/refs.c
+++ b/refs.c
@@ -2173,15 +2173,6 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	return NULL;
 }
 
-static struct ref_lock *lock_ref_sha1(const char *refname, const unsigned char *old_sha1)
-{
-	char refpath[PATH_MAX];
-	if (check_refname_format(refname, 0))
-		return NULL;
-	strcpy(refpath, mkpath("refs/%s", refname));
-	return lock_ref_sha1_basic(refpath, old_sha1, 0, NULL);
-}
-
 struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
@@ -2391,8 +2382,12 @@ static void try_remove_empty_parents(char *name)
 /* make sure nobody touched the ref, and unlink */
 static void prune_ref(struct ref_to_prune *r)
 {
-	struct ref_lock *lock = lock_ref_sha1(r->name + 5, r->sha1);
+	struct ref_lock *lock;
 
+	if (check_refname_format(r->name + 5, 0))
+		return;
+
+	lock = lock_ref_sha1_basic(r->name, r->sha1, 0, NULL);
 	if (lock) {
 		unlink_or_warn(git_path("%s", r->name));
 		unlock_ref(lock);
-- 
2.1.0.rc2.206.gedb03e5
