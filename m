Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.0 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 8F62C1F45F
	for <e@80x24.org>; Thu,  9 May 2019 21:32:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727152AbfEIVcb (ORCPT <rfc822;e@80x24.org>);
        Thu, 9 May 2019 17:32:31 -0400
Received: from cloud.peff.net ([104.130.231.41]:53732 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727138AbfEIVcb (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 9 May 2019 17:32:31 -0400
Received: (qmail 10130 invoked by uid 109); 9 May 2019 21:32:31 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Thu, 09 May 2019 21:32:31 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 6625 invoked by uid 111); 9 May 2019 21:33:08 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (ECDHE-RSA-AES256-GCM-SHA384 encrypted) SMTP; Thu, 09 May 2019 17:33:08 -0400
Authentication-Results: peff.net; auth=none
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 09 May 2019 17:32:29 -0400
Date:   Thu, 9 May 2019 17:32:29 -0400
From:   Jeff King <peff@peff.net>
To:     git@vger.kernel.org
Subject: [PATCH 14/14] verify-commit: simplify parameters to run_gpg_verify()
Message-ID: <20190509213229.GN15837@sigill.intra.peff.net>
References: <20190509212558.GA15438@sigill.intra.peff.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20190509212558.GA15438@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

The buf/len parameters of run_gpg_verify() have never been used since
the function was added in d07b00b7f3 (verify-commit: scriptable commit
signature verification, 2014-06-23). Instead, check_commit_signature()
accesses the commit struct directly.

Worse, we read the whole object just to check its type and do not attach
it to the "struct commit". Meaning we end up loading the object from
disk twice for no good reason.

And to further confuse matters, our type check is comes from what we
read from disk, but we later assume that lookup_commit() will return
non-NULL. This might not be true if some other object previously
referenced the same oid as a non-commit (though this may be impossible
to trigger in practice since we don't generally parse any other objects
in this command).

Instead, let's do our type check by loading the object via
parse_object(). That will attach the buffer to the struct so it can be
used later by check_commit_signature(). And it ensures that
lookup_commit() will return something sane.

And then we can just drop the unused "buf" and "len" parameters
entirely.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/verify-commit.c | 23 ++++++++---------------
 1 file changed, 8 insertions(+), 15 deletions(-)

diff --git a/builtin/verify-commit.c b/builtin/verify-commit.c
index 7772c07ed7..4b9e823f8f 100644
--- a/builtin/verify-commit.c
+++ b/builtin/verify-commit.c
@@ -21,15 +21,14 @@ static const char * const verify_commit_usage[] = {
 		NULL
 };
 
-static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned long size, unsigned flags)
+static int run_gpg_verify(struct commit *commit, unsigned flags)
 {
 	struct signature_check signature_check;
 	int ret;
 
 	memset(&signature_check, 0, sizeof(signature_check));
 
-	ret = check_commit_signature(lookup_commit(the_repository, oid),
-				     &signature_check);
+	ret = check_commit_signature(commit, &signature_check);
 	print_signature_buffer(&signature_check, flags);
 
 	signature_check_clear(&signature_check);
@@ -38,26 +37,20 @@ static int run_gpg_verify(const struct object_id *oid, const char *buf, unsigned
 
 static int verify_commit(const char *name, unsigned flags)
 {
-	enum object_type type;
 	struct object_id oid;
-	char *buf;
-	unsigned long size;
-	int ret;
+	struct object *obj;
 
 	if (get_oid(name, &oid))
 		return error("commit '%s' not found.", name);
 
-	buf = read_object_file(&oid, &type, &size);
-	if (!buf)
+	obj = parse_object(the_repository, &oid);
+	if (!obj)
 		return error("%s: unable to read file.", name);
-	if (type != OBJ_COMMIT)
+	if (obj->type != OBJ_COMMIT)
 		return error("%s: cannot verify a non-commit object of type %s.",
-				name, type_name(type));
-
-	ret = run_gpg_verify(&oid, buf, size, flags);
+				name, type_name(obj->type));
 
-	free(buf);
-	return ret;
+	return run_gpg_verify((struct commit *)obj, flags);
 }
 
 static int git_verify_commit_config(const char *var, const char *value, void *cb)
-- 
2.21.0.1382.g4c6032d436
