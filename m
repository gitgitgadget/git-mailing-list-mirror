Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.8 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 178292035F
	for <e@80x24.org>; Fri, 28 Oct 2016 19:25:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1756671AbcJ1TZg (ORCPT <rfc822;e@80x24.org>);
        Fri, 28 Oct 2016 15:25:36 -0400
Received: from pb-smtp1.pobox.com ([64.147.108.70]:64249 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1756668AbcJ1TZe (ORCPT <rfc822;git@vger.kernel.org>);
        Fri, 28 Oct 2016 15:25:34 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 1037A491E8;
        Fri, 28 Oct 2016 15:25:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; s=sasl; bh=+
        7MxM5ju4j3JFGfgOslUO98jbIY=; b=TbZuXX8eqIPU0+5NThiDat5UtFEeGOXUs
        +25sbpOo9swQ+h+DkhEKB60H8VeClJlrZpUGgYtLALey+twnMmcLpWTI2tXhTbH2
        +GlWKHojHS7ntXLEHZyra/5IpP4v9RoytL9+KnQeAIdWocKXUHOYwsgC2wIhj+Bg
        BCue5TYRAM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:date:message-id:mime-version:content-type; q=dns; s=
        sasl; b=alUozAyGkMk7Df73ytBdOHxIgMRdOPvFyHsUSO2bGp/jpe2WbQ12AGtO
        ogS98vJSfXdM3sxPwPCnLLj+388oeUXvgZ99uu18bqvHQJ2PzNXIJBXR4Kn4FFdd
        VmXY/Osh9LK6MhF/RVD8q3/OM7bA/dkHriPnuWnpt+EkugmoPTk=
Received: from pb-smtp1.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp1.pobox.com (Postfix) with ESMTP id 082F2491E7;
        Fri, 28 Oct 2016 15:25:33 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 7DAD6491E6;
        Fri, 28 Oct 2016 15:25:32 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     git@vger.kernel.org
Cc:     Kannan Goundan <kannan@cakoose.com>
Subject: [PATCH] push: do not use potentially ambiguous default refspec
Date:   Fri, 28 Oct 2016 12:25:30 -0700
Message-ID: <xmqqvawcz36d.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/25.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 4B2308C4-9D44-11E6-9020-987C12518317-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

When the user does the lazy "git push" with no parameters with
push.default set to either "upstream", "simple" or "current",
we internally generated a refspec that has the current branch name
on the source side and used it to push.

However, the branch name (say "test") may be an ambiguous refname in
the context of the source repository---there may be a tag with the
same name, for example.  This would trigger an unnecessary error
without any fault on the end-user's side.

Be explicit and give a full refname as the source side to avoid the
ambiguity.  The destination side when pushing with the "current"
sent only the name of the branch and forcing the receiving end to
guess, which is the same issue.  Be explicit there as well.

Reported-by: Kannan Goundan <kannan@cakoose.com>
Signed-off-by: Junio C Hamano <gitster@pobox.com>
---

 * It is appreciated if somebody with spare cycles can add a test or
   two for this in t/t5523-push-upstream.sh or somewhere nearby.

 builtin/push.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/push.c b/builtin/push.c
index 4e9e4dbab2..00a1b68483 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -194,15 +194,18 @@ static void setup_push_upstream(struct remote *remote, struct branch *branch,
 			die_push_simple(branch, remote);
 	}
 
-	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
+	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
 
 static void setup_push_current(struct remote *remote, struct branch *branch)
 {
+	struct strbuf refspec = STRBUF_INIT;
+
 	if (!branch)
 		die(_(message_detached_head_die), remote->name);
-	add_refspec(branch->name);
+	strbuf_addf(&refspec, "%s:%s", branch->refname, branch->refname);
+	add_refspec(refspec.buf);
 }
 
 static int is_workflow_triangular(struct remote *remote)
-- 
2.10.2-722-gd3f6888e25

