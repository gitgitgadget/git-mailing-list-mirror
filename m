Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.1 (2015-04-28) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.6 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.1
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 7580B1F516
	for <e@80x24.org>; Wed, 27 Jun 2018 18:40:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S965932AbeF0Sj6 (ORCPT <rfc822;e@80x24.org>);
        Wed, 27 Jun 2018 14:39:58 -0400
Received: from avasout08.plus.net ([212.159.14.20]:39921 "EHLO
        avasout08.plus.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S965779AbeF0Sj5 (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 27 Jun 2018 14:39:57 -0400
Received: from [10.0.2.15] ([80.189.70.235])
        by smtp with ESMTPA
        id YFM9fP2B0hidhYFMAf5eu1; Wed, 27 Jun 2018 19:39:56 +0100
X-CM-Score: 0.00
X-CNFS-Analysis: v=2.3 cv=B6uXLtlM c=1 sm=1 tr=0
 a=YX39wz5waiCDnkc2J8opfw==:117 a=YX39wz5waiCDnkc2J8opfw==:17
 a=IkcTkHD0fZMA:10 a=EBOSESyhAAAA:8 a=VwQbUJbxAAAA:8 a=ixFjMXWrjZrfXPArhSAA:9
 a=QEXdDO2ut3YA:10 a=yJM6EZoI5SlJf8ks9Ge_:22 a=AjGcO6oz07-iQ99wixmX:22
X-AUTH: ramsayjones@:2500
To:     Junio C Hamano <gitster@pobox.com>
Cc:     Jeff King <peff@peff.net>, Jason@zx2c4.com,
        GIT Mailing-list <git@vger.kernel.org>
From:   Ramsay Jones <ramsay@ramsayjones.plus.com>
Subject: [PATCH] fsck: check skiplist for object in fsck_blob()
Message-ID: <2fc2d53f-e193-2a2a-9f8f-b3e1d256d940@ramsayjones.plus.com>
Date:   Wed, 27 Jun 2018 19:39:53 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.8.0
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-CMAE-Envelope: MS4wfI8y53EWj2ngySZ8/O2YNQ61dkYMUif0haqjGEXCL+7vExGt/fPqaePtZ0wgubEdVy3nZyesRP+FeH3n0o9N6d7cjg+d/J9ZMFsMZcLacNqc5NDL2iMD
 HPzVNSFddFOkQ7V6SySaFIXVGH93CWyk/7jhiPjF/v3t1Cuw9GaORDMTQjq9k0FBk3dWqDEBiQ/acQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org


Since commit ed8b10f631 ("fsck: check .gitmodules content", 2018-05-02),
fsck will issue an error message for '.gitmodules' content that cannot
be parsed correctly. This is the case, even when the corresponding blob
object has been included on the skiplist. For example, using the cgit
repository, we see the following:

  $ git fsck
  Checking object directories: 100% (256/256), done.
  error: bad config line 5 in blob .gitmodules
  error in blob 51dd1eff1edc663674df9ab85d2786a40f7ae3a5: gitmodulesParse: could not parse gitmodules blob
  Checking objects: 100% (6626/6626), done.
  $

  $ git config fsck.skiplist '.git/skip'
  $ echo 51dd1eff1edc663674df9ab85d2786a40f7ae3a5 >.git/skip
  $

  $ git fsck
  Checking object directories: 100% (256/256), done.
  error: bad config line 5 in blob .gitmodules
  Checking objects: 100% (6626/6626), done.
  $

Note that the error message issued by the config parser is still
present, despite adding the object-id of the blob to the skiplist.

One solution would be to provide a means of suppressing the messages
issued by the config parser. However, given that (logically) we are
asking fsck to ignore this object, a simpler approach is to just not
call the config parser if the object is to be skipped. Add a check to
the 'fsck_blob()' processing function, to determine if the object is
on the skiplist and, if so, exit the function early.

Signed-off-by: Ramsay Jones <ramsay@ramsayjones.plus.com>
---

Hi Junio,

I noticed recently that the 'cgit.git' repo was complaining when
doing an 'git fsck' ...

Note that 'cgit' had a '.gitmodules' file and a 'submodule.sh'
script back in 2007, which had nothing to do with the current
git submodule facilities, ... ;-)

Viz:

  $ git show 51dd1eff1e
  # This file maps a submodule path to an url from where the submodule
  # can be obtained. The script "submodules.sh" finds the url in this file
  # when invoked with -i to clone the submodules.

  git             git://git.kernel.org/pub/scm/git/git.git
  $ 

I just remembered that I had intended to review the name of the
function that this patch introduces before sending, but totally
forgot! :(

[Hmm, 'to_be_skipped' -> object_to_be_skipped, object_on_skiplist,
etc., ... suggestions welcome!]

ATB,
Ramsay Jones


 fsck.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/fsck.c b/fsck.c
index 48e7e3686..702ceb629 100644
--- a/fsck.c
+++ b/fsck.c
@@ -281,6 +281,13 @@ static void append_msg_id(struct strbuf *sb, const char *msg_id)
 	strbuf_addstr(sb, ": ");
 }
 
+static int to_be_skipped(struct fsck_options *opts, struct object *obj)
+{
+	if (opts && opts->skiplist && obj)
+		return oid_array_lookup(opts->skiplist, &obj->oid) >= 0;
+	return 0;
+}
+
 __attribute__((format (printf, 4, 5)))
 static int report(struct fsck_options *options, struct object *object,
 	enum fsck_msg_id id, const char *fmt, ...)
@@ -292,8 +299,7 @@ static int report(struct fsck_options *options, struct object *object,
 	if (msg_type == FSCK_IGNORE)
 		return 0;
 
-	if (options->skiplist && object &&
-			oid_array_lookup(options->skiplist, &object->oid) >= 0)
+	if (to_be_skipped(options, object))
 		return 0;
 
 	if (msg_type == FSCK_FATAL)
@@ -963,6 +969,9 @@ static int fsck_blob(struct blob *blob, const char *buf,
 		return 0;
 	oidset_insert(&gitmodules_done, &blob->object.oid);
 
+	if (to_be_skipped(options, &blob->object))
+		return 0;
+
 	if (!buf) {
 		/*
 		 * A missing buffer here is a sign that the caller found the
-- 
2.18.0
