From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Wed, 18 Jun 2014 20:52:46 +0100
Message-ID: <53A1EE0E.6040000@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Jun 18 21:53:00 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxLuh-000057-8p
	for gcvg-git-2@plane.gmane.org; Wed, 18 Jun 2014 21:52:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754664AbaFRTww (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 15:52:52 -0400
Received: from mdfmta004.mxout.tch.inty.net ([91.221.169.45]:58917 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754537AbaFRTwv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 15:52:51 -0400
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id B8F34AC40B3;
	Wed, 18 Jun 2014 20:53:00 +0100 (BST)
Received: from mdfmta004.tch.inty.net (unknown [127.0.0.1])
	by mdfmta004.tch.inty.net (Postfix) with ESMTP id 6E76BAC40AD;
	Wed, 18 Jun 2014 20:53:00 +0100 (BST)
Received: from [192.168.254.9] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta004.tch.inty.net (Postfix) with ESMTP;
	Wed, 18 Jun 2014 20:52:59 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
X-MDF-HostID: 17
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252046>

In order to encapsulate the setting of the unique commit index, commit
969eba63 ("commit: push commit_index update into alloc_commit_node",
10-06-2014) introduced a (logically private) intermediary allocator
function. However, this function (alloc_raw_commit_node()) was declared
as a public function, which undermines its entire purpose.

Remove the alloc_raw_commit_node() function and inline its code into
the (public) alloc_commit_node() function.

Noticed by sparse ("symbol 'alloc_raw_commit_node' was not declared.
Should it be static?").

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---

Hi Jeff,

I noticed this while it was still in 'pu', but got distracted and
didn't send this in time ... sorry about that! :(

My first attempt at fixing this involved changing the DEFINE_ALLOCATOR
macro to include a 'scope' parameter so that I could declare the
raw_commit allocator 'static'. Unfortunately, I could not pass the
extern keyword as the scope parameter to all the other allocators,
because that made sparse even more upset - you can't use extern on
a function _definition_. That meant passing an empty argument (or a
comment token) to the scope parameter. This worked for gcc 4.8.2 and
clang 3.4, but I was a little concerned about portability.

This seems a better solution to me. Having said that ... as I'm typing
this I realized that I could have removed the 'commit_count' variable
and used 'commit_allocs' to set c->index instead! :-P Oh well ...

ATB,
Ramsay Jones

 alloc.c | 22 ++++++++++++++++++----
 1 file changed, 18 insertions(+), 4 deletions(-)

diff --git a/alloc.c b/alloc.c
index eb22a45..124d710 100644
--- a/alloc.c
+++ b/alloc.c
@@ -47,16 +47,30 @@ union any_object {
 
 DEFINE_ALLOCATOR(blob, struct blob)
 DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(raw_commit, struct commit)
 DEFINE_ALLOCATOR(tag, struct tag)
 DEFINE_ALLOCATOR(object, union any_object)
 
+static unsigned int commit_allocs;
+
 void *alloc_commit_node(void)
 {
 	static int commit_count;
-	struct commit *c = alloc_raw_commit_node();
+	static int nr;
+	static struct commit *block;
+	struct commit *c;
+	void *ret;
+
+	if (!nr) {
+		nr = BLOCKING;
+		block = xmalloc(BLOCKING * sizeof(struct commit));
+	}
+	nr--;
+	commit_allocs++;
+	ret = block++;
+	memset(ret, 0, sizeof(struct commit));
+	c = (struct commit *) ret;
 	c->index = commit_count++;
-	return c;
+	return ret;
 }
 
 static void report(const char *name, unsigned int count, size_t size)
@@ -72,7 +86,7 @@ void alloc_report(void)
 {
 	REPORT(blob, struct blob);
 	REPORT(tree, struct tree);
-	REPORT(raw_commit, struct commit);
+	REPORT(commit, struct commit);
 	REPORT(tag, struct tag);
 	REPORT(object, union any_object);
 }
-- 
2.0.0
