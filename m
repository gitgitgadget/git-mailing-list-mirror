From: Ken Brownfield <krb@irridia.com>
Subject: Performance issue exposed by git-filter-branch
Date: Thu, 16 Dec 2010 17:07:15 -0800
Message-ID: <41C1B4AC-8427-4D62-BEB6-689A4BE4EE5B@irridia.com>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Dec 17 02:17:30 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PTOwr-0006az-9p
	for gcvg-git-2@lo.gmane.org; Fri, 17 Dec 2010 02:17:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751250Ab0LQBRY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Dec 2010 20:17:24 -0500
Received: from endymion.irridia.com ([184.105.192.220]:42660 "EHLO
	endymion.irridia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751213Ab0LQBRX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 16 Dec 2010 20:17:23 -0500
X-Greylist: delayed 608 seconds by postgrey-1.27 at vger.kernel.org; Thu, 16 Dec 2010 20:17:23 EST
Received: from shrike2.sfo.corp.google.com (unknown [72.14.229.84])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by endymion.irridia.com (Postfix) with ESMTPSA id AAFA914561C
	for <git@vger.kernel.org>; Thu, 16 Dec 2010 17:07:15 -0800 (PST)
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163848>

I have a large git repository (1,757,784 objects, 209,282 commits) from which I have been planning to filter large tree portions (~36,000 of ~132,000 files).  When I first ran git-filter-branch on this repository about a year ago:

git filter-branch --index-filter 'git rm -r --cached --ignore-unmatch -- bigdirtree stuff/a stuff/b stuff/c stuff/dir/{a,b,c}' --prune-empty --tag-name-filter cat -- --all

The process took around 25 hours for the repository when it was at ~101k commits.  This wasn't ideal, but could be completed over a weekend maintenance.  There are 50 daily active committers to this repository, so the window has to be short.

However, we didn't have time to implement this newly filtered repo (it involves everyone recloning, etc) until now.

Now that the same repository has grown, this same filter-branch process now takes 6.5 *days* at 100% CPU on the same machine (2x4 Xeon, x86_64) on git-1.7.3.2.  There's no I/O, memory, or other resource contention.

I tend to doubt there are any multi-processing opportunities with this process, so at this point git-filter-branch is no longer feasible.

This is an oprofile sample (all samples >1%) at roughly one day into the 6.5 day Rewrite process:

[...]
11594     1.0208  git                      git                      add_index_entry
11616     1.0228  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server find_lock_page
12624     1.1115  git                      git                      decode_tree_entry
13065     1.1504  git                      git                      refresh_index
13757     1.2113  git                      git                      match_pathspec
14041     1.2363  git                      git                      read_packed_refs
18309     1.6121  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server unmap_vmas
20014     1.7622  libc-2.7.so              libc-2.7.so              _int_malloc
24248     2.1350  git                      git                      find_cache_pos
24560     2.1625  git                      git                      find_pack_entry_one
29042     2.5571  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server debug
31202     2.7473  libz.so.1.2.3.3          libz.so.1.2.3.3          inflate
34941     3.0765  git                      git                      df_name_compare
36749     3.2357  libz.so.1.2.3.3          libz.so.1.2.3.3          inflate_fast
41704     3.6720  git                      git                      index_name_pos
46908     4.1302  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server clear_page
92554     8.1493  libc-2.7.so              libc-2.7.so              memcpy
127439   11.2208  libcrypto.so.0.9.8       libcrypto.so.0.9.8       sha1_block_data_order
188373   16.5860  git                      git                      cache_name_compare

cache_name_compare (and the presumed follow-ons of memcpy/sha/malloc/etc) is the major consumer.

Sampling the filter only 2k commits into the Rewrite stage shows:

[...]
12058     1.0135  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server do_path_lookup
13532     1.1374  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server copy_user_generic_string
13934     1.1712  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server clear_page
16565     1.3924  git                      git                      cache_name_compare
16948     1.4246  libc-2.7.so              libc-2.7.so              memcpy
16969     1.4263  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server system_call
19189     1.6129  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server debug
22697     1.9078  git                      git                      add_ref
31112     2.6151  ext3                     ext3                     (no symbols)
33925     2.8516  git                      git                      sort_ref_list
34026     2.8600  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server _atomic_dec_and_lock
39304     3.3037  git                      git                      read_packed_refs
43920     3.6917  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server __link_path_walk
58504     4.9175  libc-2.7.so              libc-2.7.so              strcmp
79957     6.7208  vmlinux-debug-2.6.24-28-server vmlinux-debug-2.6.24-28-server __d_lookup
168696   14.1797  git                      git                      prepare_packed_git_one

The process is still pretty slow (1-2 commits per second) but cache_name_compare is in the background.

Is there a way to apply the optimizations mentioned in that old thread to the code paths used by git-filter-branch (mainly git-read and git-rm, seemingly), or is there another way to investigate and improve the performance of the filter?

Outside of this specific issue, it might be worth taking a look at the overall performance of git-filter-branch: bash loops iterating over core executables probably isn't ideal, but there are lower-hanging fruits.  Running the filter in a single process may allow some better caching and reduce duplication of work (maybe parallelization?), but I'm just guessing.

Our tree is quite large, but the O(n^2) nature of this process is pretty crippling for the larger repositories that are bound to be in the wild.  And while filter-branch isn't an everyday thing, when I /do/ need to use it, I won't be able to wait a week. :-)

I'd appreciate any feedback or suggestions anyone might have!

Thanks,
Ken

PS: On an unrelated note, I would recommend that the following code in git-filter-branch:

277:rev_args=$(git rev-parse --revs-only "$@")

be changed to write out to a temporary file, then piped into the "git rev-list" at line 289 with "--stdin".  For larger trees, the use of $rev_args on the "git rev-list" command-line exceeds the size of some shells' command-line buffers (from direct experience).
