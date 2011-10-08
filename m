From: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
Subject: Re: [PATCH 2/3] Fix some "variable might be used uninitialized" warnings
Date: Sat, 08 Oct 2011 17:06:52 +0100
Message-ID: <4E90751C.4030409@ramsay1.demon.co.uk>
References: <4E6D0E74.1020801@ramsay1.demon.co.uk> <7vpqj6olfa.fsf@alter.siamese.dyndns.org> <4E6FDBA4.6050505@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sat Oct 08 19:29:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCaiS-0001qi-MZ
	for gcvg-git-2@lo.gmane.org; Sat, 08 Oct 2011 19:29:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753001Ab1JHR3d (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 8 Oct 2011 13:29:33 -0400
Received: from anchor-post-3.mail.demon.net ([195.173.77.134]:55428 "EHLO
	anchor-post-3.mail.demon.net" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1752860Ab1JHR3c (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 8 Oct 2011 13:29:32 -0400
Received: from ramsay1.demon.co.uk ([193.237.126.196])
	by anchor-post-3.mail.demon.net with esmtp (Exim 4.69)
	id 1RCaiG-0002gJ-o8; Sat, 08 Oct 2011 17:29:31 +0000
User-Agent: Thunderbird 1.5.0.2 (Windows/20060308)
In-Reply-To: <4E6FDBA4.6050505@ramsay1.demon.co.uk>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183155>

Ramsay Jones wrote:
> Junio C Hamano wrote:
>> Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:
>>
>>> In particular, gcc complains as follows:
>>>
>>>         CC tree-walk.o
>>>     tree-walk.c: In function `traverse_trees':
>>>     tree-walk.c:347: warning: 'e' might be used uninitialized in this \
>>>         function
>>>
>>>         CC builtin/revert.o
>>>     builtin/revert.c: In function `verify_opt_mutually_compatible':
>>>     builtin/revert.c:113: warning: 'opt2' might be used uninitialized in \
>>>         this function
>> Could you also add something to this effect to the commit log message:
>>
>> 	but I have verified that these are gcc being not careful
>> 	enough and they are never used uninitialized.
> 
> see below for the v2 patch.
> 
>> If that is what you indeed have done, that is.
> 
> Indeed. The builtin/revert.c warning is straight-forward, but the tree-walk.c
> warning is somewhat less so! ;-)
> 
> Imagine traverse_trees() (tree-walk.c:324) was called with n == 0 (let's ignore
> the effective calls to xmalloc(0) and xcalloc(0,..) at the start of that function).
> At first blush it looked like 'e' would remain uninitialized in the call to
> prune_traversal() at line 403.  Indeed it *would* be if you ever got to that line.
> However, since the 'mask' variable (set at line 391) remains set to zero at line 401,
> the flow of control leaves the loop before 'e' is used.
> 
> [I don't think traverse_trees() would ever be called with n == 0 anyway; the call
> site in builtin/merge-tree.c is called with the constant 3, and the call-chains(s)
> which start from unpack_trees() are protected by "if (len)", where 'len' is unsigned.]

When patches don't even make it to pu I just assume you hate them so much that
there is not much chance of them being applied and simply forget about them.
In this case, since compiler warnings are a bugbear of mine, I'm hoping that
you just forgot about this one ... :-D  [if not, sorry for the noise].

For your convenience, I've attached the patch below (rebased against current master).

ATB,
Ramsay Jones

-- >8 --
Subject: [PATCH] Fix some "variable might be used uninitialized" warnings

In particular, gcc complains as follows:

        CC tree-walk.o
    tree-walk.c: In function `traverse_trees':
    tree-walk.c:347: warning: 'e' might be used uninitialized in this \
        function

        CC builtin/revert.o
    builtin/revert.c: In function `verify_opt_mutually_compatible':
    builtin/revert.c:113: warning: 'opt2' might be used uninitialized in \
        this function

However, I have verified that the analysis performed by gcc was too
conservative and that these variables are not, in fact, used while
uninitialized.

In order to suppress the warnings, we add an NULL pointer initializer
to the declarations of the 'e' and 'opt2' variables.

Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
---
 builtin/revert.c |    2 +-
 tree-walk.c      |    2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/revert.c b/builtin/revert.c
index ba27cf1..200149e 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -110,7 +110,7 @@ static void verify_opt_compatible(const char *me, const char *base_opt, ...)
 
 static void verify_opt_mutually_compatible(const char *me, ...)
 {
-	const char *opt1, *opt2;
+	const char *opt1, *opt2 = NULL;
 	va_list ap;
 
 	va_start(ap, me);
diff --git a/tree-walk.c b/tree-walk.c
index 808bb55..a8d8a66 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -344,7 +344,7 @@ int traverse_trees(int n, struct tree_desc *t, struct traverse_info *info)
 		unsigned long mask, dirmask;
 		const char *first = NULL;
 		int first_len = 0;
-		struct name_entry *e;
+		struct name_entry *e = NULL;
 		int len;
 
 		for (i = 0; i < n; i++) {
-- 
1.7.7
