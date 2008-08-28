From: Brandon Casey <casey@nrlssc.navy.mil>
Subject: Re: [PATCH] dir.c: avoid c99 array initialization
Date: Thu, 28 Aug 2008 16:01:58 -0500
Message-ID: <ojPuT0s3trguL5yp3hozXVxP1WsidV5hbSISvFZjv5JUCO31lWTzEw@cipher.nrlssc.navy.mil>
References: <IH0MHSTEimhAN93AedvpRKq4qfzm1QA814ZYyhbSBtSdNbq8vuE6aw@cipher.nrlssc.navy.mil> <G-ipWASixyGW7nvO1KquifehvBB7FNKwjPtIB0ukyEJ1Si1CJWM34w@cipher.nrlssc.navy.mil> <871w09kvew.fsf@lysator.liu.se> <GwKOGVPR0AVw4_Phmw1TSNzzMDtafrawMMahm2DQwh44k6uTOHkjTQ@cipher.nrlssc.navy.mil> <7vhc95dldz.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?RGF2aWQgS8OlZ2VkYWw=?= <davidk@lysator.liu.se>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Aug 28 23:03:19 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYoeF-0003hN-07
	for gcvg-git-2@gmane.org; Thu, 28 Aug 2008 23:03:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753685AbYH1VCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Aug 2008 17:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753612AbYH1VCN
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 17:02:13 -0400
Received: from mail1.nrlssc.navy.mil ([128.160.35.1]:60488 "EHLO
	mail.nrlssc.navy.mil" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753563AbYH1VCM (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 17:02:12 -0400
Received: by mail.nrlssc.navy.mil id m7SL1x1n025246; Thu, 28 Aug 2008 16:01:59 -0500
In-Reply-To: <7vhc95dldz.fsf@gitster.siamese.dyndns.org>
X-OriginalArrivalTime: 28 Aug 2008 21:01:58.0678 (UTC) FILETIME=[4F741B60:01C90951]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94149>

Junio C Hamano wrote:

> I do not mind taking this patch.  While it would not hurt (because the
> code is readable with or without the change) to convert the trivial ones
> like this patch addresses, it would not help portability if there are more
> nontrivial dependance to c99 constructs in other places in the code.  Are
> there known ones?

Only one other "c99" issue that I have encountered (while using a c99 compiler
no less) and it is similarly trivial:

------->8-------
From: Brandon Casey <casey@nrlssc.navy.mil>
Date: Wed, 13 Aug 2008 11:09:33 -0700
Subject: [PATCH] unpack-trees.c: work around run-time array initialization flaw on IRIX 6.5

The c99 MIPSpro Compiler version 7.4.4m on IRIX 6.5 does not properly
initialize run-time initialized arrays. An array which is initialized with
fewer elements than the length of the array should have the uninitialized
elements initialized to zero. This compiler does perform proper
initialization when static initialization parameters are used. So, work
around this by using compile time initialization.
---
 unpack-trees.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cba0aca..de7cb0b 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -143,7 +143,8 @@ static inline int call_unpack_fn(struct cache_entry **src, struct unpack_trees_o

 static int unpack_index_entry(struct cache_entry *ce, struct unpack_trees_options *o)
 {
-	struct cache_entry *src[5] = { ce, };
+	struct cache_entry *src[5] = { NULL, };
+	src[0] = ce;

 	o->pos++;
 	if (ce_stage(ce)) {
-- 
1.6.0.1.119.gcb7f
------->8-------


The above patch, along with minor changes to git-compat-util.h and a new entry in
Makefile allow me to compile on IRIX 6.5. (note: the dir.c patch is not necessary
on IRIX 6.5).

The dir.c patch along with two removals of the const modifier from option
structures and a few tweaks in Makefile allow me to compile using the SUNWspro
compiler on Solaris 7. I'm not sure if it is a c99 issue, but I get the following
errors when compiling without the following patches (which follow the errors):

"builtin-cat-file.c", line 121: warning: non-constant initializer: op "NAME"
"builtin-cat-file.c", line 217: warning: non-constant initializer: op "U&"
"builtin-cat-file.c", line 217: left operand must be modifiable lvalue: op "="
"builtin-cat-file.c", line 218: left operand must be modifiable lvalue: op "="
"builtin-cat-file.c", line 219: left operand must be modifiable lvalue: op "="
"builtin-cat-file.c", line 221: left operand must be modifiable lvalue: op "="
"builtin-cat-file.c", line 222: left operand must be modifiable lvalue: op "="
"builtin-cat-file.c", line 224: left operand must be modifiable lvalue: op "="
cc: acomp failed for builtin-cat-file.c

and similar errors for builtin-reset.c.

----->8-----
diff --git a/builtin-cat-file.c b/builtin-cat-file.c
index 7441a56..d954c09 100644
--- a/builtin-cat-file.c
+++ b/builtin-cat-file.c
@@ -212,7 +212,7 @@ int cmd_cat_file(int argc, const char **argv, const char *pr
 	int opt = 0, batch = 0;
 	const char *exp_type = NULL, *obj_name = NULL;
 
-	const struct option options[] = {
+	struct option options[] = {
 		OPT_GROUP("<type> can be one of: blob, tree, commit, tag"),
 		OPT_SET_INT('t', NULL, &opt, "show object type", 't'),
 		OPT_SET_INT('s', NULL, &opt, "show object size", 's'),
diff --git a/builtin-reset.c b/builtin-reset.c
index 4d246c3..28b633f 100644
--- a/builtin-reset.c
+++ b/builtin-reset.c
@@ -176,7 +176,7 @@ int cmd_reset(int argc, const char **argv, const char *prefi
				*old_orig = NULL, sha1_old_orig[20];
 	struct commit *commit;
 	char *reflog_action, msg[1024];
-	const struct option options[] = {
+	struct option options[] = {
 		OPT_SET_INT(0, "mixed", &reset_type,
 						"reset HEAD and index", MIXED),
 		OPT_SET_INT(0, "soft", &reset_type, "reset only HEAD", SOFT),
 
----->8-----

Running the tests with ksh on these two platforms requires a work around for ksh's
unique handling of trap within a function (which I do not yet have a pretty solution
for).

-brandon
