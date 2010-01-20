From: Tim Olsen <tim@brooklynpenguin.com>
Subject: Re: git-merge segfault in 1.6.6 and master
Date: Wed, 20 Jan 2010 16:57:19 -0500
Message-ID: <4B577C3F.7040608@brooklynpenguin.com>
References: <hj7abm$5vc$1@ger.gmane.org> <7vocko3802.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Miklos Vajna <vmiklos@frugalware.org>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jan 20 22:58:09 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NXiYy-0001qT-Pp
	for gcvg-git-2@lo.gmane.org; Wed, 20 Jan 2010 22:58:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752360Ab0ATV6F (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 Jan 2010 16:58:05 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751900Ab0ATV6D
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Jan 2010 16:58:03 -0500
Received: from lo.gmane.org ([80.91.229.12]:44832 "EHLO lo.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751663Ab0ATV6B (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Jan 2010 16:58:01 -0500
Received: from list by lo.gmane.org with local (Exim 4.50)
	id 1NXiYe-0001hN-5q
	for git@vger.kernel.org; Wed, 20 Jan 2010 22:57:48 +0100
Received: from nyc01.limewire.com ([38.108.107.34])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 22:57:48 +0100
Received: from tim by nyc01.limewire.com with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Wed, 20 Jan 2010 22:57:48 +0100
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: nyc01.limewire.com
User-Agent: Mozilla-Thunderbird 2.0.0.22 (X11/20090707)
In-Reply-To: <7vocko3802.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137589>

Junio C Hamano wrote:
> Thanks.

Thanks for taking the time to look into this!

> 
> Since you can build and run git yourself, can I ask you to run another
> experiment with this one-liner patch applied?

It appears that a segfault still happens with your patch applied, but
this time it is caught:

tolsen@neurofunk:~/git/site-build-dav-sync-05 [git:build-dav-sync-05]$
git merge origin/deployed
error: merge-recursive died of signal 11
Merge with strategy recursive failed.
tolsen@neurofunk:~/git/site-build-dav-sync-05 [git:build-dav-sync-05]$


> "common = NULL" means merged_common_ancestors->tree is NULL in the caller.
> Somebody is passing a bogus commit in "ca" (aka common ancestors) list
> when calling merge_recursive(), or forgetting to parse them before calling
> it.  In your debugger could you find out where it comes from and what it
> has before this call into merge_trees() is made?  Specifically, what the
> "ca" list at 0x7b3c00 contains, and how "merged_common_ancestors" at
> 0x121e360 looks like. in this trace we see below:

Here is the replay of the flow of execution from the first time we enter
merge_recursive().  The repository has been modified slightly so the
pointers are different this time but the segfault is still happening
(I'll stop modifying the repository now ;-) .

Upon entering merge_recursive() for the first time, ca is a two-item
list and both items have non-null trees:

Breakpoint 1, merge_recursive (o=0x7fffffffd560, h1=0x793350,
h2=0x7932c0, ca=0x7b4a40, result=0x7fffffffd5d8) at merge-recursive.c:1286
(gdb) p *ca
$1 = {item = 0x793db8, next = 0x7b4a20}
(gdb) p *(ca->next)
$2 = {item = 0x793aa0, next = 0x0}
(gdb) p ca->item->tree
$3 = (struct tree *) 0x77be10
(gdb) p ca->next->item->tree
$4 = (struct tree *) 0x77b488
(gdb)

Then on line 1303, the head of ca is popped off into
merged_common_ancestors:

Breakpoint 2, merge_recursive (o=0x7fffffffd560, h1=0x793350,
h2=0x7932c0, ca=0x7b4a20, result=0x7fffffffd5d8) at merge-recursive.c:1304
(gdb) list
1299			for (iter = ca; iter; iter = iter->next)
1300				output_commit_title(o, iter->item);
1301		}
1302	
1303		merged_common_ancestors = pop_commit(&ca);
1304		if (merged_common_ancestors == NULL) {
1305			/* if there is no common ancestor, make an empty tree */
1306			struct tree *tree = xcalloc(1, sizeof(struct tree));
1307	
1308			tree->object.parsed = 1;
(gdb) p merged_common_ancestors
$5 = (struct commit *) 0x793db8
(gdb) p ca
$8 = (struct commit_list *) 0x7b4a20

merge_recursive() is then called recursively at line 1329 with a pointer
to merged_common_ancestors passed as the "result" argument:

Breakpoint 3, merge_recursive (o=0x7fffffffd560, h1=0x793350,
h2=0x7932c0, ca=0x7b4a20, result=0x7fffffffd5d8) at merge-recursive.c:1329
(gdb) list
1324			discard_cache();
1325			saved_b1 = o->branch1;
1326			saved_b2 = o->branch2;
1327			o->branch1 = "Temporary merge branch 1";
1328			o->branch2 = "Temporary merge branch 2";
1329			merge_recursive(o, merged_common_ancestors, iter->item,
1330					NULL, &merged_common_ancestors);
1331			o->branch1 = saved_b1;
1332			o->branch2 = saved_b2;
1333			o->call_depth--;
(gdb)

In the second call to merged_common_ancestors(), result's pointee is
replaced by a commit with a null tree at line 1347:

Breakpoint 4, merge_recursive (o=0x7fffffffd560, h1=0x793db8,
h2=0x793aa0, ca=0x0, result=0x7fffffffd500) at merge-recursive.c:1347
(gdb) n
(gdb) p (*result)->tree
$10 = (struct tree *) 0x0
(gdb) list
1343		clean = merge_trees(o, h1->tree, h2->tree,
merged_common_ancestors->tree,
1344				    &mrtree);
1345	
1346		if (o->call_depth) {
1347			*result = make_virtual_commit(mrtree, "merged tree");
1348			commit_list_insert(h1, &(*result)->parents);
1349			commit_list_insert(h2, &(*result)->parents->next);
1350		}
1351		flush_output(o);
1352		return clean;
(gdb)

make_virtual_commit() is just setting its tree to mrtree:

Breakpoint 5, make_virtual_commit (tree=0x0, comment=0x5016fc "merged
tree") at merge-recursive.c:44
(gdb) list
39	 * A virtual commit has (const char *)commit->util set to the name.
40	 */
41	
42	static struct commit *make_virtual_commit(struct tree *tree, const
char *comment)
43	{
44		struct commit *commit = xcalloc(1, sizeof(struct commit));
45		commit->tree = tree;
46		commit->util = (void*)comment;
47		/* avoid warnings */
48		commit->object.parsed = 1;
(gdb)
49		return commit;
50	}

At the beginning of merge_recursive(), the local mrtree appears to be
set to some globally defined mrtree which is not null:

Breakpoint 1, merge_recursive (o=0x7fffffffd560, h1=0x793db8,
h2=0x793aa0, ca=0x0, result=0x7fffffffd500) at merge-recursive.c:1286
(gdb) p mrtree
$13 = (struct tree *) 0x7ffff732d0ac
(gdb) list
1281		struct commit_list *iter;
1282		struct commit *merged_common_ancestors;
1283		struct tree *mrtree = mrtree;
1284		int clean;
1285	
1286		if (show(o, 4)) {
1287			output(o, 4, "Merging:");
1288			output_commit_title(o, h1);
1289			output_commit_title(o, h2);
1290		}
(gdb)

Which leads me to believe the problem is in the call to merge_trees() at
line 1343:

Breakpoint 6, merge_recursive (o=0x7fffffffd560, h1=0x793db8,
h2=0x793aa0, ca=0x0, result=0x7fffffffd500) at merge-recursive.c:1343
(gdb) list
1338	
1339		discard_cache();
1340		if (!o->call_depth)
1341			read_cache();
1342	
1343		clean = merge_trees(o, h1->tree, h2->tree,
merged_common_ancestors->tree,
1344				    &mrtree);
1345	
1346		if (o->call_depth) {
1347			*result = make_virtual_commit(mrtree, "merged tree");
(gdb)

In merge_trees(), mrtree is the argument **result.  It is at line 1255
that write_tree_from_memory nulls out the pointee of result:

Breakpoint 7, merge_trees (o=0x7fffffffd560, head=0x77be10,
merge=0x77b488, common=0x77c0b8, result=0x7fffffffd478) at
merge-recursive.c:1255
(gdb) p *result
$16 = (struct tree *) 0x7ffff732d0ac
(gdb) n
(gdb) p *result
$17 = (struct tree *) 0x0
(gdb) list
1252			clean = 1;
1253	
1254		if (o->call_depth)
1255			*result = write_tree_from_memory(o);
1256	
1257		return clean;
1258	}
1259	
1260	static struct commit_list *reverse_commit_list(struct commit_list
*list)
1261	{
(gdb)

Then in write_tree_from_memory() we find the offending return NULL at
line 210:

Breakpoint 8, write_tree_from_memory (o=0x7fffffffd560) at
merge-recursive.c:210
(gdb) list
205				struct cache_entry *ce = active_cache[i];
206				if (ce_stage(ce))
207					output(o, 0, "%d %.*s", ce_stage(ce),
208					       (int)ce_namelen(ce), ce->name);
209			}
210			return NULL;
211		}
212	
213		if (!active_cache_tree)
214			active_cache_tree = cache_tree();
(gdb)


Let me know if you need any more information.

Thanks,
Tim
