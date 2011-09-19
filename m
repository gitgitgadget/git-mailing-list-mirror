From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Re: git checkout under 1.7.6 does not properly list untracked files
 and aborts
Date: Mon, 19 Sep 2011 14:06:30 -0600
Message-ID: <4E77A0C6.1060703@workspacewhiz.com>
References: <4E6A7167.6070408@workspacewhiz.com> <4E779BA4.8070109@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Sep 19 22:05:50 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R5k69-000349-J3
	for gcvg-git-2@lo.gmane.org; Mon, 19 Sep 2011 22:05:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755169Ab1ISUFp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Sep 2011 16:05:45 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:48556 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755050Ab1ISUFo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Sep 2011 16:05:44 -0400
Received: (qmail 32472 invoked by uid 399); 19 Sep 2011 14:05:40 -0600
Received: from unknown (HELO ?192.168.1.10?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 19 Sep 2011 14:05:40 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:6.0.2) Gecko/20110902 Thunderbird/6.0.2
In-Reply-To: <4E779BA4.8070109@workspacewhiz.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181699>

----- Original Message -----
From: Joshua Jensen
Date: 9/19/2011 1:44 PM
> ----- Original Message -----
> From: Joshua Jensen
> Date: 9/9/2011 2:04 PM
>> This may be an msysGit 1.7.6 issue, as that is what I am using.  It 
>> also occurs in msysGit 1.7.5, but I am almost certain it did not 
>> happen in msysGit 1.7.2.
>>
>> Given an untracked file in the working directory that has been added 
>> to an alternate branch, when switching to that alternate branch, 'git 
>> checkout' exits with an error code but does not print anything to the 
>> console.  It should print an untracked file error.
>>
>> I have been trying to track this down in code.  The point where the 
>> error messages are printed, display_error_msgs, is never hit.
> Okay, so I've tracked this down, but I am unsure what the correct fix is.
>
> In unpack-trees.c's unpack_trees() function, there are some lines that 
> read:
>
>     if (ce->ce_flags & CE_ADDED &&
>         verify_absent(ce, ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
>             return -1;
>
> If the 'return -1' is changed to 'goto return_failed', then a proper 
> error message appears:
>
>     error: The following untracked working tree files would be 
> overwritten by checkout:
>         one/file/listed/here.txt
>     Please move or remove them before you can switch branches.
>     Aborting
>
> The thing is, there are multiple files that would be overwritten by 
> checkout, and I believe an older version of Git showed me the entire 
> list before aborting.
While probably not correct, the following patch collects all files that 
would be overwritten and logs them to the output:

---
  unpack-trees.c |   11 +++++++----
  1 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index cc616c3..e1f7263 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -993,7 +993,7 @@ static int verify_absent(struct cache_entry *, enum 
unpack_trees_error_types, st
   */
  int unpack_trees(unsigned len, struct tree_desc *t, struct 
unpack_trees_options *o)
  {
-    int i, ret;
+    int i, ret = 0;
      static struct cache_entry *dfc;
      struct exclude_list el;

@@ -1100,9 +1100,10 @@ int unpack_trees(unsigned len, struct tree_desc 
*t, struct unpack_trees_options
               * Do the real check now because we have had
               * correct CE_NEW_SKIP_WORKTREE
               */
-            if (ce->ce_flags & CE_ADDED &&
-                verify_absent(ce, 
ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o))
-                    return -1;
+            if (ce->ce_flags & CE_ADDED) {
+                int result = verify_absent(ce, 
ERROR_WOULD_LOSE_UNTRACKED_OVERWRITTEN, o);
+                ret = min(ret, result);
+            }

              if (apply_sparse_checkout(ce, o)) {
                  ret = -1;
@@ -1112,6 +1113,8 @@ int unpack_trees(unsigned len, struct tree_desc 
*t, struct unpack_trees_options
                  empty_worktree = 0;

          }
+        if (ret == -1)
+            goto return_failed;
          if (o->result.cache_nr && empty_worktree) {
              /* dubious---why should this fail??? */
              ret = unpack_failed(o, "Sparse checkout leaves no entry on 
working directory");
-- 
1.7.6.msysgit.1
