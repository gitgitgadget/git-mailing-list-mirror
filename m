From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH 22/25] remote rm/prune: print a message when writing
 packed-refs fails
Date: Tue, 14 Oct 2014 17:54:48 -0700
Message-ID: <20141015005448.GZ32245@google.com>
References: <20141015004522.GD32245@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ronnie Sahlberg <sahlberg@google.com>,
	Junio C Hamano <gitster@pobox.com>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Wed Oct 15 02:54:55 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XeCrf-0004Ns-5N
	for gcvg-git-2@plane.gmane.org; Wed, 15 Oct 2014 02:54:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932681AbaJOAyv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Oct 2014 20:54:51 -0400
Received: from mail-pd0-f177.google.com ([209.85.192.177]:46614 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932479AbaJOAyv (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Oct 2014 20:54:51 -0400
Received: by mail-pd0-f177.google.com with SMTP id v10so230863pde.8
        for <git@vger.kernel.org>; Tue, 14 Oct 2014 17:54:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=B43Kat9Y5MSYC8TFwCHbuCCo+JneC6KcWD0eVsYGbnk=;
        b=giyqsDsNoRbw233X5SDjuvMU/k1XToP0t60oDGn7DYtee14pAwhHpiJoZS+2e8zu5f
         rsd2LLYOWC+dQ0ouxNFEL5j4VIIPH1e4ElM7O9PxfNszknkoZH4Bd5gtmqXEaazEGjgi
         M1FC79FbhcIvbmgFtjin/cXEEUEXt3BoX5rSNnnfGdc5rrHJDkO/ZXvDWxitKFfUcWRD
         /AvifiP6nYrpc5/wZCxcvreJO27qvjjMJDee5Rbz/daL4SyzB5A8M0ZEdmFSdZwTbRKu
         dTrmJ4gpbCrlz69jrkUFLkG+7QDK4K6tnohUla740JRDJlE9eDNDQ6Z1C1kJvXbsJ0hD
         Xbcw==
X-Received: by 10.68.234.103 with SMTP id ud7mr8991459pbc.46.1413334490776;
        Tue, 14 Oct 2014 17:54:50 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:c43b:1934:40ef:9a07])
        by mx.google.com with ESMTPSA id z15sm15407630pdi.6.2014.10.14.17.54.49
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 14 Oct 2014 17:54:50 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20141015004522.GD32245@google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

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
 builtin/remote.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 42a533a..7f28f92 100644
--- a/builtin/remote.c
+++ b/builtin/remote.c
@@ -749,13 +749,16 @@ static int mv(int argc, const char **argv)
 
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
@@ -1332,9 +1335,13 @@ static int prune_remote(const char *remote, int dry_run)
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
