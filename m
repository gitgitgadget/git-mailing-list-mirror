From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 08/25] refs.c: refuse to lock badly named refs in
 lock_ref_sha1_basic
Date: Tue, 14 Oct 2014 17:49:11 -0700
Message-ID: <20141015004911.GL32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:49:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCmE-0000wa-Mp
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:49:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932669AbaJOAtP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:49:15 -0400
Received: from mail-pa0-f44.google.com ([209.85.220.44]:37096 "EHLO
	mail-pa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932269AbaJOAtO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:49:14 -0400
Received: by mail-pa0-f44.google.com with SMTP id et14so240822pad.3
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:49:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=M/UdqlaB99sY5UTCvjsvHCkWl24KQn/gayi/smGNcIk=;
        b=TIlqauYn6R7nscCxnmXyuOOjQry3p7U46Mzno399Ss96LJWA0c8B25G82knkZRKQ48
         tZSlbZcphWdgcTFRk15EFky9JekflvO6c81J6H2wd8P4lJqkWYP5RrnvZVqFf/GCD7JR
         LDxKU3MxUDZL4n70uW5GO0JHtFGhmHJrLcIM/FmDY4KCgSxK4cyAOyOWXC+0DuXcL8SE
         nkaJ2pz2OHW3vNKnM1oyNvbx7vFYl05zj/WXZ141FWVkUPjLM4Tsfzs47K/H+ndWhy6a
         saPn3fhpB5vRYqww6YKpzfd1ODIvkIPBFD43ZpFwNW4ur2AvkPyZeWZYxze9QF6g/Ab3
         FGCg==
X-Received: by 10.66.228.35 with SMTP id sf3mr8600908pac.110.1413334154138;
        Tue, 14 Oct 2014 17:49:14 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id rg6sm15383968pdb.20.2014.10.14.17.49.13
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:49:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
 refs.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/refs.c b/refs.c
index 3c45615..9c01623 100644
--- a/refs.c
+++ b/refs.c
@@ -2150,6 +2150,11 @@ static struct ref_lock *lock_ref_sha1_basic(const char *refname,
 	int missing = 0;
 	int attempts_remaining = 3;
 
+	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL)) {
+		errno = EINVAL;
+		return NULL;
+	}
+
 	lock = xcalloc(1, sizeof(struct ref_lock));
 	lock->lock_fd = -1;
 
@@ -2241,8 +2246,6 @@ struct ref_lock *lock_any_ref_for_update(const char *refname,
 					 const unsigned char *old_sha1,
 					 int flags, int *type_p)
 {
-	if (check_refname_format(refname, REFNAME_ALLOW_ONELEVEL))
-		return NULL;
 	return lock_ref_sha1_basic(refname, old_sha1, flags, type_p);
 }
 
-- 
2.1.0.rc2.206.gedb03e5
