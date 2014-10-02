From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 21/24] remote rm/prune: print a message when writing
 packed-refs fails
Date: Wed, 1 Oct 2014 19:32:17 -0700
Message-ID: <20141002023217.GN1175@google.com>
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
X-From: git-owner@vger.kernel.org Thu Oct 02 04:32:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XZWCC-0002NI-4D
	for gcvg-git-2@plane.gmane.org; Thu, 02 Oct 2014 04:32:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751493AbaJBCci (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Oct 2014 22:32:38 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:49079 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbaJBCcU (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Oct 2014 22:32:20 -0400
Received: by mail-pa0-f49.google.com with SMTP id hz1so1391868pad.22
        for <git@vger.kernel.org>; Wed, 01 Oct 2014 19:32:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=cmMg/+Dl9jNwHTR4xG2VoGTwxeVNccxQjHh+sIsxnEo=;
        b=n67Mn1hMCDaQrDvAts8FEfSHS5r+8wzfBSWil2ZYtFlxsAW8BISLzG6L9GVxTFyJZ+
         gfPIHn5tsjPBb0F5s3YkIsQbbdKycSVLSFqd8if7ISNU5d+v8ZhfF0IR7IK9NfF/LP5A
         44dDmFgR0XOvkt9x/K1n/QAHwTOz1aJXzkb9Cluie2utQnzsQkpG8oSbuKSKw/0zKcZb
         wVpOjxOOEgOJdoqNgtKHg3nKupeW2Z7tVS/R6p1YrK6bXB2fvE2PzogciuFmqzsXJZFL
         tm+fS1QseGeoY2snKBYXQ5EUbzOZ7o9b1JCCZIpNOQ2QpNkggjov7yve1m4v6FOljFZx
         k8JQ==
X-Received: by 10.66.252.170 with SMTP id zt10mr22197577pac.111.1412217139914;
        Wed, 01 Oct 2014 19:32:19 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id uj7sm2208769pac.4.2014.10.01.19.32.18
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 01 Oct 2014 19:32:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141002014817.GS1175@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257792>

From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 11 Sep 2014 08:42:57 -0700

Until v2.1.0-rc0~22^2~11 (refs.c: add an err argument to
repack_without_refs, 2014-06-20), repack_without_refs forgot to
provide an error message when commit_packed_refs fails.  Even today,
it only provides a message for callers that pass a non-NULL err
parameter.  Internal callers in refs.c pass non-NULL err but
"git remote" does not.

That means that "git remote rm" and "git remote prune" can fail
without printing a message about why.  Fix them by passing in a
non-NULL err parameter and printing the returned message.

This is the last caller to a ref handling function passing err ==
NULL.  A later patch can drop support for err == NULL, avoiding such
problems in the future.

Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
Reviewed-by: Michael Haggerty <mhagger@alum.mit.edu>
---
Since v21:
- s/without/about/ in the commit message

 builtin/remote.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index c7f82f4..8517cfa 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -750,13 +750,16 @@ static int mv(int argc, const char **argv)
 
 static int remove_branches(struct string_list *branches)
 {
+	struct strbuf err = STRBUF_INIT;
 	const char **branch_names;
 	int i, result = 0;
 
 	branch_names = xmalloc(branches->nr * sizeof(*branch_names));
 	for (i = 0; i < branches->nr; i++)
 		branch_names[i] = branches->items[i].string;
-	result |= repack_without_refs(branch_names, branches->nr, NULL);
+	if (repack_without_refs(branch_names, branches->nr, &err))
+		result |= error("%s", err.buf);
+	strbuf_release(&err);
 	free(branch_names);
 
 	for (i = 0; i < branches->nr; i++) {
@@ -1333,9 +1336,13 @@ static int prune_remote(const char *remote, int dry_run)
 		delete_refs = xmalloc(states.stale.nr * sizeof(*delete_refs));
 		for (i = 0; i < states.stale.nr; i++)
 			delete_refs[i] = states.stale.items[i].util;
-		if (!dry_run)
-			result |= repack_without_refs(delete_refs,
-						      states.stale.nr, NULL);
+		if (!dry_run) {
+			struct strbuf err = STRBUF_INIT;
+			if (repack_without_refs(delete_refs, states.stale.nr,
+						&err))
+				result |= error("%s", err.buf);
+			strbuf_release(&err);
+		}
 		free(delete_refs);
 	}
 
-- 
2.1.0.rc2.206.gedb03e5
