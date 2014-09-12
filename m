From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH v21 0/19] rs/ref-transaction (Re: Transaction patch
 series overview)
Date: Thu, 11 Sep 2014 17:47:17 -0700
Message-ID: <20140912004717.GY18279@google.com>
References: <CAL=YDWmtitT7kHsZqXmojbv8eKYwKwVn7c+gC180FPQN1uxBvQ@mail.gmail.com>
 <CAL=YDWnd=GNycrPO-5yq+a_g569fZDOmzpat+AWrXd+5+bXDQA@mail.gmail.com>
 <CAL=YDWka47hV2TMcwcY1hm+RhbiD6HD=_ED4zB84zX5e5ABf4Q@mail.gmail.com>
 <CAL=YDWm9VaKUBRAmmybHzOBhAg_VvNc0KMG0W_uTA02YYzQrzA@mail.gmail.com>
 <20140820231723.GF20185@google.com>
 <20140911030318.GD18279@google.com>
 <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ronnie Sahlberg <sahlberg@google.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 12 02:47:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XSF1J-00034Z-Ie
	for gcvg-git-2@plane.gmane.org; Fri, 12 Sep 2014 02:47:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754272AbaILArV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2014 20:47:21 -0400
Received: from mail-pa0-f41.google.com ([209.85.220.41]:57901 "EHLO
	mail-pa0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbaILArU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2014 20:47:20 -0400
Received: by mail-pa0-f41.google.com with SMTP id bj1so12980pad.0
        for <git@vger.kernel.org>; Thu, 11 Sep 2014 17:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=NP8mfBo1N+9rjiVP1tV0RqMkzfO/HDoAp7Z1e+I3p44=;
        b=AnwaPwczIBpap4I0bcMKByWwo2vwg0DzHhc5yee7cEWTPO9+niCDrvhZAR28ESpjp4
         tWsBHyoH79mEtJ720ekSD3fNZl3QrNoeB2jUwRFSBYStpFlJmN7l2ZBMhG6u7UX9dFT5
         GppdbVGWCvYHkJBm0/LYXkHJba2Xicxa6lPAqpXOK1SOZxMyj6uVAZE7ikY9cADqWLX2
         d2qgjhE9chRzK/mf4ZShDAfz00OOjkkA+7WCGEuxMLBCVL31sRZPWqRDL5yTITqF718i
         NGOInk9piGs2ZGdxliu5JO2A6MjBhr/RiaKlCuL/K9vHXB+CuqTuVHPjgNmn0z2bBYpY
         QPYw==
X-Received: by 10.68.94.34 with SMTP id cz2mr6420007pbb.7.1410482840271;
        Thu, 11 Sep 2014 17:47:20 -0700 (PDT)
Received: from google.com (aiede.mtv.corp.google.com [172.27.69.120])
        by mx.google.com with ESMTPSA id ry9sm2239745pab.37.2014.09.11.17.47.19
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 11 Sep 2014 17:47:19 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <xmqqfvfxdcjz.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256890>

Junio C Hamano wrote:
> Jonathan Nieder <jrnieder@gmail.com> writes:

>> These patches are also available from the git repository at
>>
>>   git://repo.or.cz/git/jrn.git tags/rs/ref-transaction
>
> The tag fetched and built as-is seems to break 5514 among other
> things ("git remote rm" segfaults).

Yeah, I noticed that right after sending the series out. :/

The patch below fixes it[1].

-- >8 --
From: Ronnie Sahlberg <sahlberg@google.com>
Date: Thu, 11 Sep 2014 08:42:57 -0700
Subject: remote rm/prune: print a message when writing packed-refs fails

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

Change-Id: Ifb8a726ef03d0aa282a25a102313064d2e8ec283
Signed-off-by: Ronnie Sahlberg <sahlberg@google.com>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
[1] https://code-review.googlesource.com/1110
    https://code-review.googlesource.com/1060

 builtin/remote.c | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/builtin/remote.c b/builtin/remote.c
index 6eaeee7..ef1ffc3 100644
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
