From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH] alloc.c: remove alloc_raw_commit_node() function
Date: Wed, 18 Jun 2014 23:30:50 +0100
Message-ID: <53A2131A.30900@ramsay1.demon.co.uk>
References: <53A1EE0E.6040000@ramsay1.demon.co.uk> <20140618200854.GA23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jun 19 00:31:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WxONg-0007w8-EV
	for gcvg-git-2@plane.gmane.org; Thu, 19 Jun 2014 00:31:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753567AbaFRWa4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 18 Jun 2014 18:30:56 -0400
Received: from mdfmta009.mxout.tch.inty.net ([91.221.169.50]:60108 "EHLO
	smtp.demon.co.uk" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751310AbaFRWaz (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 18 Jun 2014 18:30:55 -0400
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id E3D82128087;
	Wed, 18 Jun 2014 23:30:58 +0100 (BST)
Received: from mdfmta009.tch.inty.net (unknown [127.0.0.1])
	by mdfmta009.tch.inty.net (Postfix) with ESMTP id 9F05A12807D;
	Wed, 18 Jun 2014 23:30:58 +0100 (BST)
Received: from [192.168.254.9] (unknown [80.176.147.220])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by mdfmta009.tch.inty.net (Postfix) with ESMTP;
	Wed, 18 Jun 2014 23:30:58 +0100 (BST)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:24.0) Gecko/20100101 Thunderbird/24.5.0
In-Reply-To: <20140618200854.GA23098@sigill.intra.peff.net>
X-MDF-HostID: 22
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252077>

On 18/06/14 21:08, Jeff King wrote:
> On Wed, Jun 18, 2014 at 08:52:46PM +0100, Ramsay Jones wrote:
> 
[snip]
> Yeah, I noticed it while writing the patch but decided it wasn't worth
> the trouble to deal with (since after all, it's not advertised to any
> callers, the very thing that sparse is complaining about. :) ).
> 
> I don't mind fixing it, though I really don't like repeating the
> contents of DEFINE_ALLOCATOR. I know it hasn't changed in a while, but
> it just feels wrong.

So, the patch below is a slight variation on the original patch.
I'm still slightly concerned about portability, but given that it
has been at least a decade since I last used a (pre-ANSI) compiler
which had a problem with this ...

[I have several versions of the C standard that I can use to check
up on the legalise, but I'm not sure I can be bothered! ;-) ]

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] alloc.c: make alloc_raw_commit_node() a static function

In order to encapsulate the setting of the unique commit index, commit
969eba63 ("commit: push commit_index update into alloc_commit_node",
10-06-2014) introduced a (logically private) intermediary allocator
function. However, this function (alloc_raw_commit_node()) was declared
as a public function, which undermines its entire purpose.

Add a scope parameter to the DEFINE_ALLOCATOR macro to allow the
raw commit allocator definition to include the 'static' qualifier.

Noticed by sparse ("symbol 'alloc_raw_commit_node' was not declared.
Should it be static?").

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 alloc.c | 17 ++++++++++-------
 1 file changed, 10 insertions(+), 7 deletions(-)

diff --git a/alloc.c b/alloc.c
index eb22a45..5392d13 100644
--- a/alloc.c
+++ b/alloc.c
@@ -18,9 +18,12 @@
 
 #define BLOCKING 1024
 
-#define DEFINE_ALLOCATOR(name, type)				\
+#define PUBLIC
+#define PRIVATE static
+
+#define DEFINE_ALLOCATOR(scope, name, type)			\
 static unsigned int name##_allocs;				\
-void *alloc_##name##_node(void)					\
+scope void *alloc_##name##_node(void)				\
 {								\
 	static int nr;						\
 	static type *block;					\
@@ -45,11 +48,11 @@ union any_object {
 	struct tag tag;
 };
 
-DEFINE_ALLOCATOR(blob, struct blob)
-DEFINE_ALLOCATOR(tree, struct tree)
-DEFINE_ALLOCATOR(raw_commit, struct commit)
-DEFINE_ALLOCATOR(tag, struct tag)
-DEFINE_ALLOCATOR(object, union any_object)
+DEFINE_ALLOCATOR(PUBLIC, blob, struct blob)
+DEFINE_ALLOCATOR(PUBLIC, tree, struct tree)
+DEFINE_ALLOCATOR(PRIVATE, raw_commit, struct commit)
+DEFINE_ALLOCATOR(PUBLIC, tag, struct tag)
+DEFINE_ALLOCATOR(PUBLIC, object, union any_object)
 
 void *alloc_commit_node(void)
 {
-- 
2.0.0
