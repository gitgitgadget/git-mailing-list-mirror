From: Stephen Boyd <sboyd@codeaurora.org>
Subject: git rev-list | git cherry-pick --stdin is leaky
Date: Mon, 29 Apr 2013 16:30:24 -0700
Message-ID: <517F0290.5020301@codeaurora.org>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010106000103040807060500"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 30 01:30:39 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWxWo-0006lw-Km
	for gcvg-git-2@plane.gmane.org; Tue, 30 Apr 2013 01:30:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932259Ab3D2Xa2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Apr 2013 19:30:28 -0400
Received: from wolverine02.qualcomm.com ([199.106.114.251]:31530 "EHLO
	wolverine02.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759140Ab3D2XaZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Apr 2013 19:30:25 -0400
X-IronPort-AV: E=Sophos;i="4.87,576,1363158000"; 
   d="scan'208";a="42734684"
Received: from pdmz-ns-mip.qualcomm.com (HELO mostmsg01.qualcomm.com) ([199.106.114.10])
  by wolverine02.qualcomm.com with ESMTP/TLS/DHE-RSA-AES256-SHA; 29 Apr 2013 16:30:24 -0700
Received: from [10.46.166.8] (pdmz-ns-snip_218_1.qualcomm.com [192.168.218.1])
	by mostmsg01.qualcomm.com (Postfix) with ESMTPA id 80B1110004BF
	for <git@vger.kernel.org>; Mon, 29 Apr 2013 16:30:24 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222878>

This is a multi-part message in MIME format.
--------------010106000103040807060500
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

Hi,

I'm running git rev-list | git cherry-pick --stdin on a range of about
300 commits. Eventually the chery-pick dies with:

    error: cannot fork() for commit: Cannot allocate memory

Running valgrind shows me that the tree traversal code is leaking
gigabytes of memory (particularly unpack_callback). Since cherry-pick is
a very long running process all these allocations are never freed and
eventually I run out of memory. Attached is the valgrind output. The
worst offender and summary is:

==7986== 938,956,692 (929,961,582 direct, 8,995,110 indirect) bytes in 7,765,439 blocks are definitely lost in loss record 257 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==
==7986== LEAK SUMMARY:
==7986==    definitely lost: 2,514,117,692 bytes in 21,210,861 blocks
==7986==    indirectly lost: 885,481,947 bytes in 10,165,801 blocks
==7986==      possibly lost: 650,712,395 bytes in 6,014,309 blocks
==7986==    still reachable: 7,734,870 bytes in 47,794 blocks
==7986==         suppressed: 0 bytes in 0 blocks

This is against recent git.git
(89740333e8d398f1da701e9023675321bbb9a85b). A workaround is to limit the
amount of commits per cherry-pick invocation, but can we somehow fix the
leaks?

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
hosted by The Linux Foundation


--------------010106000103040807060500
Content-Type: text/plain; charset=us-ascii;
 name="vlog"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="vlog"

==7986== Memcheck, a memory error detector
==7986== Copyright (C) 2002-2009, and GNU GPL'd, by Julian Seward et al.
==7986== Using Valgrind-3.6.0.SVN-Debian and LibVEX; rerun with -h for copyright info
==7986== Command: git cherry-pick --stdin
==7986== Parent PID: 7975
==7986== 
==7986== Warning: set address range perms: large range [0x39187000, 0x79187000) (defined)
==7986== 
==7986== HEAP SUMMARY:
==7986==     in use at exit: 4,058,046,904 bytes in 37,438,765 blocks
==7986==   total heap usage: 67,457,729 allocs, 30,018,964 frees, 76,125,942,518 bytes allocated
==7986== 
==7986== 1 bytes in 1 blocks are definitely lost in loss record 2 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x49BC0D: setup_git_env (environment.c:109)
==7986==    by 0x49BF4C: get_git_dir (environment.c:167)
==7986==    by 0x4BB052: vsnpath (path.c:61)
==7986==    by 0x4BB60C: git_pathdup (path.c:94)
==7986==    by 0x483DD0: git_config_with_options (config.c:1015)
==7986==    by 0x4B8465: check_pager_config (pager.c:173)
==7986==    by 0x404DAB: handle_internal_command (git.c:269)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 11 bytes in 1 blocks are definitely lost in loss record 5 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x49BDEC: setup_git_env (environment.c:141)
==7986==    by 0x49BF4C: get_git_dir (environment.c:167)
==7986==    by 0x4BB052: vsnpath (path.c:61)
==7986==    by 0x4BB60C: git_pathdup (path.c:94)
==7986==    by 0x483DD0: git_config_with_options (config.c:1015)
==7986==    by 0x4B8465: check_pager_config (pager.c:173)
==7986==    by 0x404DAB: handle_internal_command (git.c:269)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 13 bytes in 1 blocks are definitely lost in loss record 7 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x49BDA4: setup_git_env (environment.c:136)
==7986==    by 0x49BF4C: get_git_dir (environment.c:167)
==7986==    by 0x4BB052: vsnpath (path.c:61)
==7986==    by 0x4BB60C: git_pathdup (path.c:94)
==7986==    by 0x483DD0: git_config_with_options (config.c:1015)
==7986==    by 0x4B8465: check_pager_config (pager.c:173)
==7986==    by 0x404DAB: handle_internal_command (git.c:269)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 17 bytes in 1 blocks are definitely lost in loss record 9 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4BB614: git_pathdup (path.c:96)
==7986==    by 0x49BD79: setup_git_env (environment.c:146)
==7986==    by 0x49BF4C: get_git_dir (environment.c:167)
==7986==    by 0x4BB052: vsnpath (path.c:61)
==7986==    by 0x4BB60C: git_pathdup (path.c:94)
==7986==    by 0x483DD0: git_config_with_options (config.c:1015)
==7986==    by 0x4B8465: check_pager_config (pager.c:173)
==7986==    by 0x404DAB: handle_internal_command (git.c:269)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 65 bytes in 1 blocks are definitely lost in loss record 27 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4C27522: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E69FA: strbuf_grow (strbuf.c:74)
==7986==    by 0x4E71A9: strbuf_vaddf (strbuf.c:261)
==7986==    by 0x4E7355: strbuf_addf (strbuf.c:203)
==7986==    by 0x49C44F: system_path (exec_cmd.c:36)
==7986==    by 0x49C571: setup_path (exec_cmd.c:103)
==7986==    by 0x40540B: main (git.c:562)
==7986== 
==7986== 65 bytes in 1 blocks are definitely lost in loss record 28 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4C27522: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E69FA: strbuf_grow (strbuf.c:74)
==7986==    by 0x4E71A9: strbuf_vaddf (strbuf.c:261)
==7986==    by 0x4E7355: strbuf_addf (strbuf.c:203)
==7986==    by 0x4DAEE5: sequencer_pick_revisions (sequencer.c:857)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 192 bytes in 1 blocks are possibly lost in loss record 47 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4C27522: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C6F8C: add_entry_to_dir (refs.c:280)
==7986==    by 0x4C7CA0: find_containing_dir (refs.c:393)
==7986==    by 0x4C7CC1: add_ref (refs.c:447)
==7986==    by 0x4C7F48: read_packed_refs (refs.c:860)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986== 
==7986== 207 bytes in 9 blocks are possibly lost in loss record 49 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF504: merge_trees (merge-recursive.c:1828)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 316 bytes in 1 blocks are definitely lost in loss record 53 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E69FA: strbuf_grow (strbuf.c:74)
==7986==    by 0x4ABF01: output (merge-recursive.c:166)
==7986==    by 0x4AE598: merge_content (merge-recursive.c:1629)
==7986==    by 0x4AFDB1: merge_trees (merge-recursive.c:1777)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 317 bytes in 2 blocks are definitely lost in loss record 54 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E69FA: strbuf_grow (strbuf.c:74)
==7986==    by 0x4E6E23: strbuf_add (strbuf.c:187)
==7986==    by 0x4ABF92: output (merge-recursive.c:174)
==7986==    by 0x4AE598: merge_content (merge-recursive.c:1629)
==7986==    by 0x4AFDB1: merge_trees (merge-recursive.c:1777)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986== 
==7986== 480 bytes in 1 blocks are possibly lost in loss record 60 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C6F8C: add_entry_to_dir (refs.c:280)
==7986==    by 0x4C7CA0: find_containing_dir (refs.c:393)
==7986==    by 0x4C7CC1: add_ref (refs.c:447)
==7986==    by 0x4C7F48: read_packed_refs (refs.c:860)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986==    by 0x4D5374: handle_revision_arg (revision.c:1227)
==7986== 
==7986== 517 bytes in 5 blocks are definitely lost in loss record 62 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C06: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 532 bytes in 84 blocks are possibly lost in loss record 64 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986== 
==7986== 536 bytes in 4 blocks are definitely lost in loss record 65 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 879 bytes in 28 blocks are possibly lost in loss record 70 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF504: merge_trees (merge-recursive.c:1828)
==7986== 
==7986== 1,088 bytes in 1 blocks are possibly lost in loss record 73 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4FB19B: xmemdupz (wrapper.c:86)
==7986==    by 0x4E17C9: read_packed_sha1 (sha1_file.c:1891)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4AC1EB: init_tree_desc_from_tree (merge-recursive.c:212)
==7986==    by 0x4AD085: git_merge_trees (merge-recursive.c:239)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 2,040 bytes in 2 blocks are possibly lost in loss record 80 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C6F8C: add_entry_to_dir (refs.c:280)
==7986==    by 0x4C7CD6: add_ref (refs.c:450)
==7986==    by 0x4C7F48: read_packed_refs (refs.c:860)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986==    by 0x4D5374: handle_revision_arg (revision.c:1227)
==7986==    by 0x4D5CEA: setup_revisions (revision.c:1279)
==7986== 
==7986== 2,261 bytes in 20 blocks are possibly lost in loss record 81 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C06: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 2,371 bytes in 23 blocks are definitely lost in loss record 82 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6D5B: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 2,371 bytes in 23 blocks are definitely lost in loss record 83 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C24: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 3,122 bytes in 35 blocks are possibly lost in loss record 88 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986==    by 0x4D9B99: do_pick_commit (sequencer.c:492)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986== 
==7986== 3,424 bytes in 107 blocks are definitely lost in loss record 90 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4AF513: merge_trees (merge-recursive.c:334)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 3,424 bytes in 107 blocks are definitely lost in loss record 91 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4AC5AC: get_renames (merge-recursive.c:485)
==7986==    by 0x4AF618: merge_trees (merge-recursive.c:1832)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 3,424 bytes in 107 blocks are definitely lost in loss record 92 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4AC5AC: get_renames (merge-recursive.c:485)
==7986==    by 0x4AF637: merge_trees (merge-recursive.c:1833)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 3,588 bytes in 44 blocks are possibly lost in loss record 94 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C6C36: create_dir_entry (refs.c:313)
==7986==    by 0x4C7C90: find_containing_dir (refs.c:392)
==7986==    by 0x4C7CC1: add_ref (refs.c:447)
==7986==    by 0x4C7F48: read_packed_refs (refs.c:860)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986==    by 0x4D5374: handle_revision_arg (revision.c:1227)
==7986== 
==7986== 3,774 bytes in 374 blocks are possibly lost in loss record 95 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986== 
==7986== 4,104 bytes in 1 blocks are possibly lost in loss record 97 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x5034F7: hash_chars (diffcore-delta.c:133)
==7986==    by 0x503971: diffcore_count_changes (diffcore-delta.c:182)
==7986==    by 0x50551D: diffcore_rename (diffcore-rename.c:185)
==7986==    by 0x490104: diffcore_std (diff.c:4654)
==7986==    by 0x4AC623: get_renames (merge-recursive.c:498)
==7986==    by 0x4AF618: merge_trees (merge-recursive.c:1832)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986== 
==7986== 4,721 bytes in 47 blocks are possibly lost in loss record 99 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986==    by 0x4D9B99: do_pick_commit (sequencer.c:492)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 5,792 (16 direct, 5,776 indirect) bytes in 1 blocks are definitely lost in loss record 105 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x47E25D: commit_list_append (commit.c:1432)
==7986==    by 0x4DA9B2: sequencer_pick_revisions (sequencer.c:832)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 6,329 bytes in 60 blocks are definitely lost in loss record 107 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E69FA: strbuf_grow (strbuf.c:74)
==7986==    by 0x4E720E: strbuf_vaddf (strbuf.c:268)
==7986==    by 0x4ABF80: output (merge-recursive.c:171)
==7986==    by 0x4AE598: merge_content (merge-recursive.c:1629)
==7986==    by 0x4AFDB1: merge_trees (merge-recursive.c:1777)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986== 
==7986== 6,819 bytes in 129 blocks are possibly lost in loss record 108 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986== 
==7986== 7,147 bytes in 61 blocks are definitely lost in loss record 109 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C06: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 7,680 bytes in 40 blocks are possibly lost in loss record 111 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4C27522: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C6F8C: add_entry_to_dir (refs.c:280)
==7986==    by 0x4C7CD6: add_ref (refs.c:450)
==7986==    by 0x4C7F48: read_packed_refs (refs.c:860)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986==    by 0x4D5374: handle_revision_arg (revision.c:1227)
==7986== 
==7986== 8,731 bytes in 9 blocks are possibly lost in loss record 114 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4E0439: unpack_compressed_entry (sha1_file.c:1797)
==7986==    by 0x4E20E2: unpack_entry (sha1_file.c:2072)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986== 
==7986== 9,557 bytes in 82 blocks are possibly lost in loss record 115 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 10,408 bytes in 253 blocks are possibly lost in loss record 117 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986== 
==7986== 11,447 bytes in 5 blocks are possibly lost in loss record 118 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4FB19B: xmemdupz (wrapper.c:86)
==7986==    by 0x4E17C9: read_packed_sha1 (sha1_file.c:1891)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986== 
==7986== 12,231 bytes in 105 blocks are possibly lost in loss record 120 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C24: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 12,696 bytes in 109 blocks are possibly lost in loss record 122 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6D5B: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 13,895 (12,635 direct, 1,260 indirect) bytes in 110 blocks are definitely lost in loss record 125 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C4FE6: make_cache_entry (read-cache.c:694)
==7986==    by 0x4AC90C: add_cacheinfo (merge-recursive.c:204)
==7986==    by 0x4AD2F5: update_file_flags (merge-recursive.c:790)
==7986==    by 0x4AE7B7: merge_content (merge-recursive.c:1665)
==7986==    by 0x4AFDB1: merge_trees (merge-recursive.c:1777)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986== 
==7986== 19,311 bytes in 157 blocks are definitely lost in loss record 132 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F5A28: setup_unpack_trees_porcelain (unpack-trees.c:79)
==7986==    by 0x4AD062: git_merge_trees (merge-recursive.c:235)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 19,939 bytes in 157 blocks are definitely lost in loss record 134 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F5A87: setup_unpack_trees_porcelain (unpack-trees.c:82)
==7986==    by 0x4AD062: git_merge_trees (merge-recursive.c:235)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 21,953 (96 direct, 21,857 indirect) bytes in 3 blocks are definitely lost in loss record 136 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4AC685: get_renames (merge-recursive.c:509)
==7986==    by 0x4AF637: merge_trees (merge-recursive.c:1833)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 22,137 bytes in 157 blocks are definitely lost in loss record 137 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F59A6: setup_unpack_trees_porcelain (unpack-trees.c:66)
==7986==    by 0x4AD062: git_merge_trees (merge-recursive.c:235)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 26,112 bytes in 24 blocks are possibly lost in loss record 140 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4FB19B: xmemdupz (wrapper.c:86)
==7986==    by 0x4E17C9: read_packed_sha1 (sha1_file.c:1891)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4B6866: parse_object (cache.h:752)
==7986==    by 0x4F2D05: parse_tree_indirect (tree.c:243)
==7986==    by 0x48B63E: diff_cache (diff-lib.c:461)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986== 
==7986== 27,439 bytes in 17 blocks are possibly lost in loss record 141 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4FB19B: xmemdupz (wrapper.c:86)
==7986==    by 0x4E17C9: read_packed_sha1 (sha1_file.c:1891)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986== 
==7986== 27,719 bytes in 1,955 blocks are possibly lost in loss record 143 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 30,464 bytes in 28 blocks are possibly lost in loss record 149 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4BA085: patch_delta (patch-delta.c:36)
==7986==    by 0x4E1DD4: unpack_entry (sha1_file.c:2136)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4AC1EB: init_tree_desc_from_tree (merge-recursive.c:212)
==7986==    by 0x4AD06D: git_merge_trees (merge-recursive.c:237)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986== 
==7986== 35,545 bytes in 305 blocks are definitely lost in loss record 151 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C4FE6: make_cache_entry (read-cache.c:694)
==7986==    by 0x4AC90C: add_cacheinfo (merge-recursive.c:204)
==7986==    by 0x4AE918: merge_content (merge-recursive.c:1624)
==7986==    by 0x4AFDB1: merge_trees (merge-recursive.c:1777)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 43,802 bytes in 1,315 blocks are possibly lost in loss record 159 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986== 
==7986== 43,837 bytes in 364 blocks are definitely lost in loss record 160 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6D5B: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 43,948 bytes in 365 blocks are definitely lost in loss record 161 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4F474C: add_entry (unpack-trees.c:123)
==7986==    by 0x4F6C24: threeway_merge (unpack-trees.c:1535)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 46,901 bytes in 444 blocks are possibly lost in loss record 162 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986== 
==7986== 50,510 bytes in 3 blocks are possibly lost in loss record 165 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4FB19B: xmemdupz (wrapper.c:86)
==7986==    by 0x4E17C9: read_packed_sha1 (sha1_file.c:1891)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986== 
==7986== 71,448 bytes in 3,657 blocks are possibly lost in loss record 171 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 81,156 bytes in 2,946 blocks are possibly lost in loss record 173 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986== 
==7986== 102,678 bytes in 1,145 blocks are possibly lost in loss record 177 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986== 
==7986== 144,704 bytes in 133 blocks are possibly lost in loss record 179 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4BA085: patch_delta (patch-delta.c:36)
==7986==    by 0x4E1DD4: unpack_entry (sha1_file.c:2136)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4B6866: parse_object (cache.h:752)
==7986==    by 0x4F2D05: parse_tree_indirect (tree.c:243)
==7986==    by 0x48B63E: diff_cache (diff-lib.c:461)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986== 
==7986== 146,615 (3,424 direct, 143,191 indirect) bytes in 107 blocks are definitely lost in loss record 180 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4D1862: resolve_undo_read (resolve-undo.c:59)
==7986==    by 0x4C4D14: read_index_from (read-cache.c:1281)
==7986==    by 0x4D99BC: do_pick_commit (sequencer.c:297)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 148,521 bytes in 1,648 blocks are definitely lost in loss record 181 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986==    by 0x4D9B99: do_pick_commit (sequencer.c:492)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986== 
==7986== 163,840 bytes in 4 blocks are possibly lost in loss record 183 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 169,728 bytes in 156 blocks are possibly lost in loss record 185 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4BA085: patch_delta (patch-delta.c:36)
==7986==    by 0x4E1DD4: unpack_entry (sha1_file.c:2136)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4AC1EB: init_tree_desc_from_tree (merge-recursive.c:212)
==7986==    by 0x4AD085: git_merge_trees (merge-recursive.c:239)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986== 
==7986== 214,165 bytes in 2,364 blocks are definitely lost in loss record 191 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986== 
==7986== 220,650 bytes in 1,833 blocks are possibly lost in loss record 192 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986== 
==7986== 241,692 (40 direct, 241,652 indirect) bytes in 1 blocks are definitely lost in loss record 193 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4787E2: cache_tree (cache-tree.c:12)
==7986==    by 0x4795AB: read_one (cache-tree.c:477)
==7986==    by 0x479760: cache_tree_read (cache-tree.c:546)
==7986==    by 0x4C4CDC: read_index_from (read-cache.c:1278)
==7986==    by 0x4D99BC: do_pick_commit (sequencer.c:297)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 499,592 bytes in 1 blocks are possibly lost in loss record 200 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C4AE4: read_index_from (read-cache.c:1452)
==7986==    by 0x4BC44D: read_index_preload (preload-index.c:105)
==7986==    by 0x4D8F52: read_and_refresh_cache (sequencer.c:661)
==7986==    by 0x4DA829: sequencer_pick_revisions (sequencer.c:1055)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 540,022 bytes in 27,914 blocks are possibly lost in loss record 201 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 645,306 bytes in 1,329 blocks are possibly lost in loss record 202 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4E0439: unpack_compressed_entry (sha1_file.c:1797)
==7986==    by 0x4E20E2: unpack_entry (sha1_file.c:2072)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986== 
==7986== 669,184 bytes in 1 blocks are possibly lost in loss record 204 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF504: merge_trees (merge-recursive.c:1828)
==7986== 
==7986== 779,677 (76,384 direct, 703,293 indirect) bytes in 308 blocks are definitely lost in loss record 206 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4AF0AF: process_renames (merge-recursive.c:109)
==7986==    by 0x4AF652: merge_trees (merge-recursive.c:1834)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 1,077,563 bytes in 381 blocks are possibly lost in loss record 209 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4BA085: patch_delta (patch-delta.c:36)
==7986==    by 0x4E1DD4: unpack_entry (sha1_file.c:2136)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986== 
==7986== 1,282,860 bytes in 22,625 blocks are possibly lost in loss record 213 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986== 
==7986== 1,534,720 (9,760 direct, 1,524,960 indirect) bytes in 305 blocks are definitely lost in loss record 214 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4AC685: get_renames (merge-recursive.c:509)
==7986==    by 0x4AF618: merge_trees (merge-recursive.c:1832)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 1,613,604 bytes in 17,120 blocks are possibly lost in loss record 215 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4C779F: T.258 (refs.c:251)
==7986==    by 0x4C7F2C: read_packed_refs (refs.c:856)
==7986==    by 0x4C8063: get_packed_refs (refs.c:892)
==7986==    by 0x4CAC52: do_for_each_ref (refs.c:1323)
==7986==    by 0x4CF2F3: do_lookup_replace_object (replace_object.c:86)
==7986==    by 0x4B6934: parse_object (cache.h:759)
==7986==    by 0x4D1DD3: get_reference (revision.c:233)
==7986==    by 0x4D5374: handle_revision_arg (revision.c:1227)
==7986==    by 0x4D5CEA: setup_revisions (revision.c:1279)
==7986==    by 0x463C1C: parse_args (revert.c:203)
==7986== 
==7986== 2,029,107 (669,184 direct, 1,359,923 indirect) bytes in 1 blocks are definitely lost in loss record 218 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF504: merge_trees (merge-recursive.c:1828)
==7986== 
==7986== 2,774,251 bytes in 27,262 blocks are possibly lost in loss record 221 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986== 
==7986== 3,395,088 bytes in 9 blocks are possibly lost in loss record 222 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C335E: add_index_entry (read-cache.c:981)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 6,089,404 bytes in 137,534 blocks are possibly lost in loss record 225 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986== 
==7986== 6,577,250 bytes in 1,825 blocks are possibly lost in loss record 226 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4FB162: xmallocz (wrapper.c:73)
==7986==    by 0x4BA085: patch_delta (patch-delta.c:36)
==7986==    by 0x4E1DD4: unpack_entry (sha1_file.c:2136)
==7986==    by 0x4E177D: read_packed_sha1 (sha1_file.c:1884)
==7986==    by 0x4E18AD: read_object (sha1_file.c:2480)
==7986==    by 0x4E2192: read_sha1_file_extended (sha1_file.c:2510)
==7986==    by 0x4F2D78: parse_tree (cache.h:752)
==7986==    by 0x4F2F53: read_tree_1 (tree.c:59)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986== 
==7986== 6,661,120 bytes in 10 blocks are possibly lost in loss record 227 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986== 
==7986== 8,249,350 bytes in 330,633 blocks are possibly lost in loss record 228 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 9,941,457 (4,055,040 direct, 5,886,417 indirect) bytes in 99 blocks are definitely lost in loss record 229 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC373: save_files_dirs (merge-recursive.c:288)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 12,711,934 bytes in 127,958 blocks are definitely lost in loss record 230 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986==    by 0x4D9B99: do_pick_commit (sequencer.c:492)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 13,693,775 bytes in 372,583 blocks are possibly lost in loss record 232 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986== 
==7986== 15,320,576 bytes in 23 blocks are possibly lost in loss record 233 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 16,205,717 bytes in 523,734 blocks are possibly lost in loss record 234 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x52E3D81: strdup (strdup.c:43)
==7986==    by 0x4FB218: xstrdup (wrapper.c:35)
==7986==    by 0x4E92C3: string_list_insert_at_index (string-list.c:48)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986== 
==7986== 18,338,771 bytes in 166,590 blocks are possibly lost in loss record 236 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 18,861,600 bytes in 50 blocks are possibly lost in loss record 237 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C335E: add_index_entry (read-cache.c:981)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 31,332,891 (31,321,067 direct, 11,824 indirect) bytes in 316,872 blocks are definitely lost in loss record 240 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986== 
==7986== 31,974,952 bytes in 64 blocks are possibly lost in loss record 241 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C4AE4: read_index_from (read-cache.c:1452)
==7986==    by 0x4D99BC: do_pick_commit (sequencer.c:297)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 95,529,146 bytes in 804,649 blocks are possibly lost in loss record 243 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 99,630,664 bytes in 901,364 blocks are possibly lost in loss record 244 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 117,624,806 (11,316,960 direct, 106,307,846 indirect) bytes in 30 blocks are definitely lost in loss record 245 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C335E: add_index_entry (read-cache.c:981)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== 143,358,402 (47,293,952 direct, 96,064,450 indirect) bytes in 71 blocks are definitely lost in loss record 246 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4E9283: string_list_insert_at_index (string-list.c:40)
==7986==    by 0x4AC323: save_files_dirs (merge-recursive.c:290)
==7986==    by 0x4F3011: read_tree_1 (tree.c:73)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F30E7: read_tree_1 (tree.c:107)
==7986==    by 0x4F3216: read_tree_recursive (tree.c:126)
==7986==    by 0x4AC255: get_files_dirs (merge-recursive.c:301)
==7986==    by 0x4AF4F9: merge_trees (merge-recursive.c:1827)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986== 
==7986== 159,205,379 (159,098,360 direct, 107,019 indirect) bytes in 1,515,960 blocks are definitely lost in loss record 249 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986==    by 0x48B840: run_diff_index (diff-lib.c:488)
==7986==    by 0x48B92B: index_differs_from (diff-lib.c:523)
==7986== 
==7986== 242,060,134 (23,388,384 direct, 218,671,750 indirect) bytes in 62 blocks are definitely lost in loss record 250 of 257
==7986==    at 0x4C275A2: realloc (vg_replace_malloc.c:525)
==7986==    by 0x4FB02B: xrealloc (wrapper.c:100)
==7986==    by 0x4C335E: add_index_entry (read-cache.c:981)
==7986==    by 0x4F6288: merged_entry (unpack-trees.c:1513)
==7986==    by 0x4F5714: unpack_callback (unpack-trees.c:296)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 266,149,871 (266,142,203 direct, 7,668 indirect) bytes in 2,399,197 blocks are definitely lost in loss record 251 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x48B6EA: diff_cache (diff-lib.c:480)
==7986== 
==7986== 299,768,892 bytes in 2,663,569 blocks are possibly lost in loss record 252 of 257
==7986==    at 0x4C274A8: malloc (vg_replace_malloc.c:236)
==7986==    by 0x4FB0CD: xmalloc (wrapper.c:50)
==7986==    by 0x4C4878: cache_entry_from_ondisk (read-cache.c:1323)
==7986==    by 0x4C4D4E: read_index_from (read-cache.c:1395)
==7986==    by 0x4D99BC: do_pick_commit (sequencer.c:297)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 433,116,790 (432,950,308 direct, 166,482 indirect) bytes in 4,146,402 blocks are definitely lost in loss record 253 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986==    by 0x4AF3D5: merge_trees (merge-recursive.c:1811)
==7986==    by 0x4D9A7A: do_pick_commit (sequencer.c:311)
==7986== 
==7986== 482,083,201 (46,465,928 direct, 435,617,273 indirect) bytes in 93 blocks are definitely lost in loss record 255 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4C4AE4: read_index_from (read-cache.c:1452)
==7986==    by 0x4D99BC: do_pick_commit (sequencer.c:297)
==7986==    by 0x4DA750: pick_commits (sequencer.c:995)
==7986==    by 0x4DAFD6: sequencer_pick_revisions (sequencer.c:1124)
==7986==    by 0x463E7C: cmd_cherry_pick (revert.c:236)
==7986==    by 0x404C86: handle_internal_command (git.c:284)
==7986==    by 0x40541C: main (git.c:492)
==7986== 
==7986== 557,706,880 (548,062,684 direct, 9,644,196 indirect) bytes in 4,931,819 blocks are definitely lost in loss record 256 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F6FAE: unpack_trees (unpack-trees.c:1074)
==7986==    by 0x4AD095: git_merge_trees (merge-recursive.c:241)
==7986== 
==7986== 938,956,692 (929,961,582 direct, 8,995,110 indirect) bytes in 7,765,439 blocks are definitely lost in loss record 257 of 257
==7986==    at 0x4C267CC: calloc (vg_replace_malloc.c:467)
==7986==    by 0x4FAF57: xcalloc (wrapper.c:119)
==7986==    by 0x4F5281: unpack_callback (unpack-trees.c:539)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986==    by 0x4F586C: unpack_callback (unpack-trees.c:467)
==7986==    by 0x4F40E5: traverse_trees (tree-walk.c:407)
==7986== 
==7986== LEAK SUMMARY:
==7986==    definitely lost: 2,514,117,692 bytes in 21,210,861 blocks
==7986==    indirectly lost: 885,481,947 bytes in 10,165,801 blocks
==7986==      possibly lost: 650,712,395 bytes in 6,014,309 blocks
==7986==    still reachable: 7,734,870 bytes in 47,794 blocks
==7986==         suppressed: 0 bytes in 0 blocks
==7986== Reachable blocks (those to which a pointer was found) are not shown.
==7986== To see them, rerun with: --leak-check=full --show-reachable=yes
==7986== 
==7986== For counts of detected and suppressed errors, rerun with: -v
==7986== ERROR SUMMARY: 102 errors from 102 contexts (suppressed: 4 from 4)

--------------010106000103040807060500--
