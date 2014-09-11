From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 07/19] refs.c: move the check for valid refname to
 lock_ref_sha1_basic
Date: Wed, 10 Sep 2014 20:07:22 -0700
Message-ID: <20140911030721.GK18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Thu Sep 11 05:07:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XRujJ-0001Jp-Hn
	for gcvg-git-2@plane.gmane.org; Thu, 11 Sep 2014 05:07:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751690AbaIKDH0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Sep 2014 23:07:26 -0400
Received: from mail-pd0-f176.google.com ([209.85.192.176]:61335 "EHLO
	mail-pd0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751372AbaIKDHZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Sep 2014 23:07:25 -0400
Received: by mail-pd0-f176.google.com with SMTP id y13so8664371pdi.35
        for <git@vger.kernel.org>; Wed, 10 Sep 2014 20:07:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=12dSH2J1Xj57pA84vCcZTahzKJoDAlLTvSR9QCQa6/A=;
        b=GIEs7GZlDaClabU+1g7r99zFOmjTC9cGwNOSoBT1B6JnhADjaTYXEmSsqNGCBGYV2s
         1nAmPR2HG1dRVhRMoaBdaGNduI+s3Kwplvj8u5q9gS61fyVrd+G0KAgkhqBzSAl3BxLU
         A6hMkUwjrJi9rpLiL+6BBaW3aS4okTTg+yf+sbLW5yGZk1vN3WEzBBZsWs/isdnnCQ8T
         qBjyD6flx4E5ab9YuMa8XNcNu8Gj7w0NjnTJafoSZ+T2lPcdvrTXw++nAUAJ1Rotvg6y
         KW4Q7LhR3ZSMIU5S7oTP5s06GukllOi9YFQtDo0z4loqUJBcklaOYx2FCG0aFsls1B8r
         aY8Q==
X-Received: by 10.66.157.231 with SMTP id wp7mr1406880pab.151.1410404844784;
        Wed, 10 Sep 2014 20:07:24 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id q1sm15904401pdq.67.2014.09.10.20.07.23
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 10 Sep 2014 20:07:24 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20140911030318.GD18279@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256819>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 1 May 2014 10:40:10 -0700

Move the check for check_refname_format from lock_any_ref_for_update
to lock_ref_sha1_basic. At some later stage we will get rid of
lock_any_ref_for_update completely. This has no visible impact to callers,
except for inability to lock badly named refs which is not possible today
anyway but for other reasons.

Keep lock_any_ref_for_update as a no-op wrapper --- it is the public facing
version of this interface and keeping it as a separate function will make
it easier to experiment with the internal lock_ref_sha1_basic signature.

Note that if lock_ref_sha1_basic now checks the refname format and fails to
lock the ref it will not be possible to delete such a ref since deletion
implies we first lock the ref. In fact, we currently fail even earlier than
that since these refs are not even recognized to exist.

Example:
$ cp .git/refs/heads/master .git/refs/heads/echo...\*\*
$ ./git branch -D .git/refs/heads/echo...\*\*
error: branch '.git/refs/heads/echo...**' not found.

This is not a new regression and this has been broken for a while.
Later patches in the series will start repairing the handling of badly
named refs, at which time we will need to modify lock_ref_sha1_basic once more
in order to allow locking these refs for certain use cases such as rename
and delete.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
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
