From: Simo Melenius <simo.melenius@iki.fi>
Subject: [PATCH 2/2] branch: don't fail listing branches if one of the commits wasn't found
Date: Thu,  3 Jun 2010 10:48:02 +0300
Message-ID: <1275551282-21557-2-git-send-email-simo.melenius@iki.fi>
References: <20100603065527.GA23439@progeny.tock>
Cc: git@vger.kernel.org, Simo Melenius <simo.melenius@iki.fi>
To: jrnieder@gmail.com
X-From: git-owner@vger.kernel.org Thu Jun 03 09:49:05 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OK5Ai-0005LT-3C
	for gcvg-git-2@lo.gmane.org; Thu, 03 Jun 2010 09:49:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932102Ab0FCHsn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 3 Jun 2010 03:48:43 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:44068 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757890Ab0FCHsl (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 3 Jun 2010 03:48:41 -0400
Received: by mail-pw0-f46.google.com with SMTP id 2so2096226pwj.19
        for <git@vger.kernel.org>; Thu, 03 Jun 2010 00:48:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:sender:from:to:cc:subject
         :date:message-id:x-mailer:in-reply-to:references;
        bh=kS9LAGoRJDiTbqzXnb+zhKY/3ooQcXnMSmMs0EpN2pg=;
        b=EO4nQVj6xZl+7xvSkjRVKaxqYO0DJd5Bj5UhjFutzHPYJXcHvEdHRgRWyLqVkrN9uK
         uzbqVfAixT0viGSEtTpZ4o5mnw2dDsObgtK71hg/lHIt4ZqCwt+pdoxZfsJrJt3CarAK
         mal0n/sodb4oKA/29z6aqJ0ruPtflyAFxQbgU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=sender:from:to:cc:subject:date:message-id:x-mailer:in-reply-to
         :references;
        b=fvnHuz+kPEdgTbgwn8eaL/Fp0WZ1s9bYg5Z6JCTNkYyd7zQZKb2YwaAdLbH5IfTe3T
         mVzsGfX7geb7hYpOFW/IMLbCQ3CFMEZl5idnK8HIODVjUaaQFI36DtUJNK3bKzf533A5
         AVjTH94b9YPP8MV8OBdrVUq0Ye0B/ZFyY1u68=
Received: by 10.140.252.3 with SMTP id z3mr2104268rvh.285.1275551321700;
        Thu, 03 Jun 2010 00:48:41 -0700 (PDT)
Received: from localhost.localdomain (xdsl-83-150-84-41.nebulazone.fi [83.150.84.41])
        by mx.google.com with ESMTPS id h11sm2833977rvm.0.2010.06.03.00.48.39
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 03 Jun 2010 00:48:41 -0700 (PDT)
X-Mailer: git-send-email 1.7.0.4
In-Reply-To: <20100603065527.GA23439@progeny.tock>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/148298>

When listing branches with ref lookups, if one of the known raw refs
doesn't point to a commit then "git branch" would return error(),
terminating the whole for_each_rawref() iteration and possibly hiding
any remaining refs.

Signed-off-by: Simo Melenius <simo.melenius@iki.fi>
---
 builtin/branch.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/builtin/branch.c b/builtin/branch.c
index 46ca59c..2242743 100644
--- a/builtin/branch.c
+++ b/builtin/branch.c
@@ -303,7 +303,7 @@ static int append_ref(const char *refname, const unsigned char *sha1, int flags,
 		if (!commit)
 		{
 			cb->ret = error("branch '%s' does not point at a commit", refname);
-			return cb->ret;
+			return 0;
 		}
 
 		/* Filter with with_commit if specified */
@@ -541,6 +541,9 @@ static int print_ref_list(int kinds, int detached, int verbose, int abbrev, stru
 
 	free_ref_list(&ref_list);
 
+	if (cb.ret)
+		error("some refs could not be read, review stderr");
+
 	return cb.ret;
 }
 
-- 
1.7.0.4
