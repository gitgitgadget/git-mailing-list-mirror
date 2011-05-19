From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [RFC PATCH] unpack-trees: add check_worktree flag to enable dry-run
 functionality
Date: Thu, 19 May 2011 19:47:27 +0200
Message-ID: <4DD557AF.4030700@web.de>
References: <7vd3jm74gv.fsf@alter.siamese.dyndns.org> <4DD0043D.1050101@web.de> <7vfwofpvai.fsf@alter.siamese.dyndns.org> <4DD2CFD4.7060508@web.de> <7vpqnheygi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 19 19:48:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QN7KP-0007tQ-GB
	for gcvg-git-2@lo.gmane.org; Thu, 19 May 2011 19:48:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933700Ab1ESRsA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 May 2011 13:48:00 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:45349 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932617Ab1ESRr7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 May 2011 13:47:59 -0400
Received: from smtp08.web.de  ( [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id 8B78618F3FE84;
	Thu, 19 May 2011 19:47:27 +0200 (CEST)
Received: from [93.246.62.6] (helo=[192.168.178.43])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #2)
	id 1QN7Jn-000119-00; Thu, 19 May 2011 19:47:27 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.17) Gecko/20110414 Lightning/1.0b2 Thunderbird/3.1.10
In-Reply-To: <7vpqnheygi.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/8Rawnv/gPXMIH7eNlKMFWweGSUcsQDC5MQ4Fm
	Qp9qCkSeYoY/um50z6DAuwWdUUxYN287C/BCN4wEsVkC/pNxdR
	pjp9gylxlUXL3gFnQGyQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/173981>

To enable the users of unpack_trees() to check if a work tree update would
succeed without actually touching the work tree the new check_worktree
flag is added to struct unpack_trees_options. This is necessary because
when update is set to 0 testing for absent new files and sparse handling
were disabled. This is fine when e.g. only the index should be updated but
is not sufficient when the user wants to check if a work tree update would
succeed.

Now users can set update to 0 and check_worktree to 1 to see if an
unpack_tree() with update=1 run would succeed. The only class of problems
that are not detected at the moment are file system conditions like ENOSPC
or missing permissions.

Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
---
Am 18.05.2011 00:47, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> The only exceptions where I could not make that replacement without
>> breaking a test were:
>>
>> * t1001:381 (#25) new file conflicts with untracked directory
>>   This should have been detected by verify_absent_1(), but that function
>>   is left early when opts->update is 0. Will look into that.
> 
> Thanks. This is the kind of corner case I was worried about when I said
> "we might have a case where read-tree -m succeeds but read-tree -m -u
> doesn't". Fixing it would mean that ...

Maybe something like this patch?

>> @@ -183,6 +184,8 @@ int cmd_read_tree(int argc, const char **argv, const char *unused_prefix)
>>  		die("--exclude-per-directory is meaningless unless -u");
>>  	if (opts.merge && !opts.index_only)
>>  		setup_work_tree();
>> +	if (opts.update && dry_run)
>> +		opts.update = 0;
>>
>>  	if (opts.merge) {
>>  		if (stage < 2)
> 
> ... this hunk must go, right?

But this is the "don't update the work tree when -n is used together
with -u" part, so it is needed, no? With this patch applied first and
opts.check_worktree set to 1 inside that if() added there all tests
succeed.

> Now at this point wouldn't it make more sense to move these helpers to
> lib-read-tree.sh or something and .-source it from all nine tests?

Sure, will do in the next round.


 unpack-trees.c |    4 ++--
 unpack-trees.h |    3 ++-
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/unpack-trees.c b/unpack-trees.c
index 500ebcf..b6dca8f 100644
--- a/unpack-trees.c
+++ b/unpack-trees.c
@@ -1001,7 +1001,7 @@ int unpack_trees(unsigned len, struct tree_desc *t, struct unpack_trees_options
 	state.refresh_cache = 1;

 	memset(&el, 0, sizeof(el));
-	if (!core_apply_sparse_checkout || !o->update)
+	if (!core_apply_sparse_checkout || (!o->update && !o->check_worktree))
 		o->skip_sparse_checkout = 1;
 	if (!o->skip_sparse_checkout) {
 		if (add_excludes_from_file_to_list(git_path("info/sparse-checkout"), "", 0, NULL, &el, 0) < 0)
@@ -1368,7 +1368,7 @@ static int verify_absent_1(struct cache_entry *ce,
 	int len;
 	struct stat st;

-	if (o->index_only || o->reset || !o->update)
+	if (o->index_only || o->reset || (!o->update && !o->check_worktree))
 		return 0;

 	len = check_leading_path(ce->name, ce_namelen(ce));
diff --git a/unpack-trees.h b/unpack-trees.h
index cd11a08..402bbdb 100644
--- a/unpack-trees.h
+++ b/unpack-trees.h
@@ -46,7 +46,8 @@ struct unpack_trees_options {
 		     debug_unpack,
 		     skip_sparse_checkout,
 		     gently,
-		     show_all_errors;
+		     show_all_errors,
+		     check_worktree; /* check work tree contents even if !update */
 	const char *prefix;
 	int cache_bottom;
 	struct dir_struct *dir;
-- 
1.7.5.1.340.g5ecaf
