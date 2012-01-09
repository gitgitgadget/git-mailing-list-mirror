From: Pete Wyckoff <pw@padd.com>
Subject: leaky cherry-pick
Date: Mon, 9 Jan 2012 17:37:37 -0500
Message-ID: <20120109223737.GA1589@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 09 23:38:03 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkNqq-0002sk-Tc
	for gcvg-git-2@lo.gmane.org; Mon, 09 Jan 2012 23:38:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933472Ab2AIWho (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Jan 2012 17:37:44 -0500
Received: from honk.padd.com ([74.3.171.149]:37996 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933455Ab2AIWhm (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jan 2012 17:37:42 -0500
Received: from arf.padd.com (unknown [50.55.142.76])
	by honk.padd.com (Postfix) with ESMTPSA id 2270E2106;
	Mon,  9 Jan 2012 14:37:41 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id C38FA315A9; Mon,  9 Jan 2012 17:37:37 -0500 (EST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188196>

I've got a big tree, and rebased 200 commits today using
cherry-pick.  It ran out of memory.  Both 1.7.4 and recent
master (eac2d83 (Git 1.7.9-rc0, 2012-01-06)) behave similarly.

Here's a valgrind dump for rebasing just 9 commits, if someone is
interested to track this down.  This was invoked as:

    valgrind --log-file=/tmp/vg.out --leak-check=full \
    /home/pw/src/git/git cherry-pick 8d535b6^..2cf53a0

I can re-test if you like, or provide more detail if this seems
unusual.

Scroll to the end to see the biggest leaks.

		-- Pete

==18789== Memcheck, a memory error detector
==18789== Copyright (C) 2002-2010, and GNU GPL'd, by Julian Seward et al.
==18789== Using Valgrind-3.6.1 and LibVEX; rerun with -h for copyright info
==18789== Command: /home/pw/src/git/git cherry-pick 8d535b6^..2cf53a0
==18789== Parent PID: 2325
==18789== 
==18789== Conditional jump or move depends on uninitialised value(s)
==18789==    at 0x4E37290: inflateReset2 (in /usr/lib/libz.so.1.2.3.4)
==18789==    by 0x4E3737F: inflateInit2_ (in /usr/lib/libz.so.1.2.3.4)
==18789==    by 0x5260FB: git_inflate_init (zlib.c:72)
==18789==    by 0x5025B2: unpack_sha1_header (sha1_file.c:1320)
==18789==    by 0x5028A1: unpack_sha1_file (sha1_file.c:1426)
==18789==    by 0x50447D: read_object (sha1_file.c:2220)
==18789==    by 0x504512: read_sha1_file_extended (sha1_file.c:2245)
==18789==    by 0x4D3880: read_sha1_file (cache.h:760)
==18789==    by 0x4D3E9F: parse_object (object.c:194)
==18789==    by 0x494A13: lookup_commit_reference_gently (commit.c:31)
==18789==    by 0x494A6C: lookup_commit_reference (commit.c:40)
==18789==    by 0x50691A: get_parent (sha1_name.c:371)
==18789== 
==18789== Conditional jump or move depends on uninitialised value(s)
==18789==    at 0x4E37290: inflateReset2 (in /usr/lib/libz.so.1.2.3.4)
==18789==    by 0x4E3737F: inflateInit2_ (in /usr/lib/libz.so.1.2.3.4)
==18789==    by 0x5260FB: git_inflate_init (zlib.c:72)
==18789==    by 0x502E9E: unpack_compressed_entry (sha1_file.c:1629)
==18789==    by 0x503810: unpack_entry (sha1_file.c:1880)
==18789==    by 0x5030B5: cache_or_unpack_entry (sha1_file.c:1690)
==18789==    by 0x5041E4: read_packed_sha1 (sha1_file.c:2162)
==18789==    by 0x50442F: read_object (sha1_file.c:2215)
==18789==    by 0x504512: read_sha1_file_extended (sha1_file.c:2245)
==18789==    by 0x494981: read_sha1_file (cache.h:760)
==18789==    by 0x49561E: parse_commit (commit.c:317)
==18789==    by 0x4F52DC: add_parents_to_list (revision.c:543)
==18789== 
==18789== Warning: set address range perms: large range [0x133a0000, 0x37dad000) (defined)
==18789== Warning: set address range perms: large range [0x4c438000, 0x7b85a000) (defined)
==18789== Conditional jump or move depends on uninitialised value(s)
==18789==    at 0x537450F: __strspn_sse42 (strspn-c.c:126)
==18789==    by 0x488910: parse_attr (attr.c:189)
==18789==    by 0x488ABC: parse_attr_line (attr.c:232)
==18789==    by 0x488CFB: handle_attr_line (attr.c:320)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789== 
==18789== Conditional jump or move depends on uninitialised value(s)
==18789==    at 0x488AC6: parse_attr_line (attr.c:233)
==18789==    by 0x488CFB: handle_attr_line (attr.c:320)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789==    by 0x4B69B1: write_entry (entry.c:191)
==18789==    by 0x4B6FDD: checkout_entry (entry.c:318)
==18789== 
==18789== Use of uninitialised value of size 8
==18789==    at 0x488ADA: parse_attr_line (attr.c:231)
==18789==    by 0x488CFB: handle_attr_line (attr.c:320)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789==    by 0x4B69B1: write_entry (entry.c:191)
==18789==    by 0x4B6FDD: checkout_entry (entry.c:318)
==18789== 
==18789== Conditional jump or move depends on uninitialised value(s)
==18789==    at 0x537450F: __strspn_sse42 (strspn-c.c:126)
==18789==    by 0x488910: parse_attr (attr.c:189)
==18789==    by 0x488BD1: parse_attr_line (attr.c:253)
==18789==    by 0x488CFB: handle_attr_line (attr.c:320)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789== 
==18789== Use of uninitialised value of size 8
==18789==    at 0x488BDE: parse_attr_line (attr.c:252)
==18789==    by 0x488CFB: handle_attr_line (attr.c:320)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789==    by 0x4B69B1: write_entry (entry.c:191)
==18789==    by 0x4B6FDD: checkout_entry (entry.c:318)
==18789== 
==18789== 
==18789== HEAP SUMMARY:
==18789==     in use at exit: 511,786,999 bytes in 3,954,180 blocks
==18789==   total heap usage: 6,352,564 allocs, 2,398,384 frees, 2,610,529,433 bytes allocated
==18789== 
==18789== 1 bytes in 1 blocks are definitely lost in loss record 2 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x52DC421: strdup (strdup.c:43)
==18789==    by 0x51FDC8: xstrdup (wrapper.c:23)
==18789==    by 0x4B7181: expand_namespace (environment.c:104)
==18789==    by 0x4B7480: setup_git_env (environment.c:144)
==18789==    by 0x4B750B: get_git_dir (environment.c:162)
==18789==    by 0x4D918B: git_vsnpath (path.c:53)
==18789==    by 0x4D93D8: git_pathdup (path.c:85)
==18789==    by 0x499E96: git_config (config.c:925)
==18789==    by 0x4047A4: check_pager_config (git.c:48)
==18789==    by 0x40522D: run_builtin (git.c:293)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 5 bytes in 1 blocks are definitely lost in loss record 6 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x52DC421: strdup (strdup.c:43)
==18789==    by 0x51FDC8: xstrdup (wrapper.c:23)
==18789==    by 0x4986C9: git_config_string (config.c:475)
==18789==    by 0x4990B4: git_default_core_config (config.c:646)
==18789==    by 0x499955: git_default_config (config.c:796)
==18789==    by 0x497E22: get_value (config.c:222)
==18789==    by 0x498150: git_parse_file (config.c:330)
==18789==    by 0x499BFB: git_config_from_file (config.c:847)
==18789==    by 0x499DD5: git_config_early (config.c:896)
==18789==    by 0x499EB1: git_config (config.c:926)
==18789==    by 0x476839: cmd_cherry_pick (revert.c:1160)
==18789== 
==18789== 11 bytes in 1 blocks are definitely lost in loss record 8 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x4B73F8: setup_git_env (environment.c:136)
==18789==    by 0x4B750B: get_git_dir (environment.c:162)
==18789==    by 0x4D918B: git_vsnpath (path.c:53)
==18789==    by 0x4D93D8: git_pathdup (path.c:85)
==18789==    by 0x499E96: git_config (config.c:925)
==18789==    by 0x4047A4: check_pager_config (git.c:48)
==18789==    by 0x40522D: run_builtin (git.c:293)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789==    by 0x40571B: main (git.c:588)
==18789== 
==18789== 13 bytes in 1 blocks are definitely lost in loss record 10 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x4B737B: setup_git_env (environment.c:131)
==18789==    by 0x4B750B: get_git_dir (environment.c:162)
==18789==    by 0x4D918B: git_vsnpath (path.c:53)
==18789==    by 0x4D93D8: git_pathdup (path.c:85)
==18789==    by 0x499E96: git_config (config.c:925)
==18789==    by 0x4047A4: check_pager_config (git.c:48)
==18789==    by 0x40522D: run_builtin (git.c:293)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789==    by 0x40571B: main (git.c:588)
==18789== 
==18789== 16 bytes in 1 blocks are definitely lost in loss record 14 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x49578D: commit_list_insert (commit.c:356)
==18789==    by 0x495886: commit_list_insert_by_date (commit.c:390)
==18789==    by 0x4F51BC: commit_list_insert_by_date_cached (revision.c:508)
==18789==    by 0x4F5344: add_parents_to_list (revision.c:550)
==18789==    by 0x4F5C62: limit_list (revision.c:836)
==18789==    by 0x4FA49B: prepare_revision_walk (revision.c:2068)
==18789==    by 0x47522F: prepare_revs (revert.c:650)
==18789==    by 0x475B6D: walk_revs_populate_todo (revert.c:855)
==18789==    by 0x4766BF: pick_revisions (revert.c:1123)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789== 
==18789== 17 bytes in 1 blocks are definitely lost in loss record 17 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x52DC421: strdup (strdup.c:43)
==18789==    by 0x51FDC8: xstrdup (wrapper.c:23)
==18789==    by 0x4D93E7: git_pathdup (path.c:87)
==18789==    by 0x4B744E: setup_git_env (environment.c:141)
==18789==    by 0x4B750B: get_git_dir (environment.c:162)
==18789==    by 0x4D918B: git_vsnpath (path.c:53)
==18789==    by 0x4D93D8: git_pathdup (path.c:85)
==18789==    by 0x499E96: git_config (config.c:925)
==18789==    by 0x4047A4: check_pager_config (git.c:48)
==18789==    by 0x40522D: run_builtin (git.c:293)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 24 bytes in 1 blocks are definitely lost in loss record 21 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x4C27927: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x509A01: strbuf_grow (strbuf.c:72)
==18789==    by 0x50A03A: strbuf_add (strbuf.c:190)
==18789==    by 0x4D9CB4: expand_user_path (path.c:255)
==18789==    by 0x49870C: git_config_pathname (config.c:483)
==18789==    by 0x499186: git_default_core_config (config.c:655)
==18789==    by 0x499955: git_default_config (config.c:796)
==18789==    by 0x497E22: get_value (config.c:222)
==18789==    by 0x498150: git_parse_file (config.c:330)
==18789==    by 0x499BFB: git_config_from_file (config.c:847)
==18789== 
==18789== 40 bytes in 8 blocks are definitely lost in loss record 23 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x52DC421: strdup (strdup.c:43)
==18789==    by 0x51FDC8: xstrdup (wrapper.c:23)
==18789==    by 0x4986C9: git_config_string (config.c:475)
==18789==    by 0x4990B4: git_default_core_config (config.c:646)
==18789==    by 0x499955: git_default_config (config.c:796)
==18789==    by 0x525EBD: git_xmerge_config (xdiff-interface.c:362)
==18789==    by 0x4CD25A: merge_recursive_config (merge-recursive.c:2032)
==18789==    by 0x497E22: get_value (config.c:222)
==18789==    by 0x498150: git_parse_file (config.c:330)
==18789==    by 0x499BFB: git_config_from_file (config.c:847)
==18789==    by 0x499DD5: git_config_early (config.c:896)
==18789== 
==18789== 65 bytes in 1 blocks are definitely lost in loss record 30 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x4C27927: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x509A01: strbuf_grow (strbuf.c:72)
==18789==    by 0x50A1E3: strbuf_vaddf (strbuf.c:216)
==18789==    by 0x50A1AA: strbuf_addf (strbuf.c:206)
==18789==    by 0x475CAF: save_head (revert.c:884)
==18789==    by 0x476737: pick_revisions (revert.c:1131)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789== 
==18789== 144 (16 direct, 128 indirect) bytes in 1 blocks are definitely lost in loss record 41 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x47536C: commit_list_append (revert.c:692)
==18789==    by 0x475B8A: walk_revs_populate_todo (revert.c:859)
==18789==    by 0x4766BF: pick_revisions (revert.c:1123)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789==    by 0x40571B: main (git.c:588)
==18789== 
==18789== 192 bytes in 8 blocks are definitely lost in loss record 48 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x4C27927: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x509A01: strbuf_grow (strbuf.c:72)
==18789==    by 0x50A03A: strbuf_add (strbuf.c:190)
==18789==    by 0x4D9CB4: expand_user_path (path.c:255)
==18789==    by 0x49870C: git_config_pathname (config.c:483)
==18789==    by 0x499186: git_default_core_config (config.c:655)
==18789==    by 0x499955: git_default_config (config.c:796)
==18789==    by 0x525EBD: git_xmerge_config (xdiff-interface.c:362)
==18789==    by 0x4CD25A: merge_recursive_config (merge-recursive.c:2032)
==18789==    by 0x497E22: get_value (config.c:222)
==18789== 
==18789== 281 bytes in 2 blocks are possibly lost in loss record 51 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x4E483E: create_from_disk (read-cache.c:1255)
==18789==    by 0x4E4B7F: read_index_from (read-cache.c:1328)
==18789==    by 0x4E4758: read_index (read-cache.c:1224)
==18789==    by 0x47469F: do_recursive_merge (revert.c:411)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789==    by 0x476756: pick_revisions (revert.c:1133)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 704 bytes in 8 blocks are definitely lost in loss record 58 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51C1F5: unpack_trees (unpack-trees.c:1063)
==18789==    by 0x4A46BD: diff_cache (diff-lib.c:474)
==18789==    by 0x4A46FC: run_diff_index (diff-lib.c:482)
==18789==    by 0x4A48DA: index_differs_from (diff-lib.c:517)
==18789==    by 0x474AC2: do_pick_commit (revert.c:503)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789== 
==18789== 1,107 bytes in 9 blocks are definitely lost in loss record 62 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x519DCD: setup_unpack_trees_porcelain (unpack-trees.c:79)
==18789==    by 0x4C8160: git_merge_trees (merge-recursive.c:235)
==18789==    by 0x4CC907: merge_trees (merge-recursive.c:1817)
==18789==    by 0x4747B8: do_recursive_merge (revert.c:425)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789==    by 0x476756: pick_revisions (revert.c:1133)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 1,143 bytes in 9 blocks are definitely lost in loss record 63 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x519E8F: setup_unpack_trees_porcelain (unpack-trees.c:82)
==18789==    by 0x4C8160: git_merge_trees (merge-recursive.c:235)
==18789==    by 0x4CC907: merge_trees (merge-recursive.c:1817)
==18789==    by 0x4747B8: do_recursive_merge (revert.c:425)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789==    by 0x476756: pick_revisions (revert.c:1133)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 1,269 bytes in 9 blocks are definitely lost in loss record 64 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x519CE0: setup_unpack_trees_porcelain (unpack-trees.c:66)
==18789==    by 0x4C8160: git_merge_trees (merge-recursive.c:235)
==18789==    by 0x4CC907: merge_trees (merge-recursive.c:1817)
==18789==    by 0x4747B8: do_recursive_merge (revert.c:425)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789==    by 0x476756: pick_revisions (revert.c:1133)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789== 
==18789== 1,316 bytes in 10 blocks are possibly lost in loss record 65 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789== 
==18789== 1,728 bytes in 9 blocks are definitely lost in loss record 67 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x4C27927: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x488D5B: handle_attr_line (attr.c:325)
==18789==    by 0x488DDD: read_attr_from_array (attr.c:340)
==18789==    by 0x48924E: bootstrap_attr_stack (attr.c:501)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789==    by 0x4B69B1: write_entry (entry.c:191)
==18789== 
==18789== 2,072 (1,496 direct, 576 indirect) bytes in 1 blocks are definitely lost in loss record 70 of 97
==18789==    at 0x4C2779D: malloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FE4E: xmalloc (wrapper.c:35)
==18789==    by 0x473F5B: parse_args (revert.c:228)
==18789==    by 0x47684E: cmd_cherry_pick (revert.c:1161)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789==    by 0x40571B: main (git.c:588)
==18789== 
==18789== 2,376 bytes in 27 blocks are definitely lost in loss record 72 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51C1F5: unpack_trees (unpack-trees.c:1063)
==18789==    by 0x4C81C2: git_merge_trees (merge-recursive.c:241)
==18789==    by 0x4CC907: merge_trees (merge-recursive.c:1817)
==18789==    by 0x4747B8: do_recursive_merge (revert.c:425)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789== 
==18789== 7,726 (4,320 direct, 3,406 indirect) bytes in 9 blocks are definitely lost in loss record 77 of 97
==18789==    at 0x4C27882: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x488D5B: handle_attr_line (attr.c:325)
==18789==    by 0x488E86: read_attr_from_file (attr.c:358)
==18789==    by 0x489130: read_attr (attr.c:428)
==18789==    by 0x489335: bootstrap_attr_stack (attr.c:525)
==18789==    by 0x48940F: prepare_attr_stack (attr.c:568)
==18789==    by 0x489A27: collect_all_attrs (attr.c:725)
==18789==    by 0x489AED: git_check_attr (attr.c:739)
==18789==    by 0x49E314: convert_attrs (convert.c:730)
==18789==    by 0x49F230: get_stream_filter (convert.c:1247)
==18789==    by 0x4B69B1: write_entry (entry.c:191)
==18789== 
==18789== 744,353 bytes in 7,493 blocks are definitely lost in loss record 88 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51C1F5: unpack_trees (unpack-trees.c:1063)
==18789==    by 0x4A46BD: diff_cache (diff-lib.c:474)
==18789==    by 0x4A46FC: run_diff_index (diff-lib.c:482)
==18789== 
==18789== 1,865,981 bytes in 18,806 blocks are definitely lost in loss record 90 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51C1F5: unpack_trees (unpack-trees.c:1063)
==18789==    by 0x4C81C2: git_merge_trees (merge-recursive.c:241)
==18789==    by 0x4CC907: merge_trees (merge-recursive.c:1817)
==18789== 
==18789== 8,386,453 (1,031,576 direct, 7,354,877 indirect) bytes in 1 blocks are definitely lost in loss record 91 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x4E4B38: read_index_from (read-cache.c:1319)
==18789==    by 0x4E4758: read_index (read-cache.c:1224)
==18789==    by 0x4DB50F: read_index_preload (preload-index.c:105)
==18789==    by 0x4752A1: read_and_refresh_cache (revert.c:661)
==18789==    by 0x47657B: pick_revisions (revert.c:1081)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789==    by 0x40571B: main (git.c:588)
==18789== 
==18789== 69,782,106 (6,793,984 direct, 62,988,122 indirect) bytes in 8 blocks are definitely lost in loss record 94 of 97
==18789==    at 0x4C27882: realloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x51FFCD: xrealloc (wrapper.c:82)
==18789==    by 0x4E3D7C: add_index_entry (read-cache.c:976)
==18789==    by 0x519FFE: add_entry (unpack-trees.c:119)
==18789==    by 0x51D0A6: merged_entry (unpack-trees.c:1501)
==18789==    by 0x51D444: threeway_merge (unpack-trees.c:1615)
==18789==    by 0x51A645: call_unpack_fn (unpack-trees.c:289)
==18789==    by 0x51B1E2: unpack_nondirectories (unpack-trees.c:586)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789== 
==18789== 105,619,300 (9,284,184 direct, 96,335,116 indirect) bytes in 9 blocks are definitely lost in loss record 96 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x4E4B38: read_index_from (read-cache.c:1319)
==18789==    by 0x4E4758: read_index (read-cache.c:1224)
==18789==    by 0x47469F: do_recursive_merge (revert.c:411)
==18789==    by 0x474FA5: do_pick_commit (revert.c:598)
==18789==    by 0x47635D: pick_commits (revert.c:1022)
==18789==    by 0x476756: pick_revisions (revert.c:1133)
==18789==    by 0x47685A: cmd_cherry_pick (revert.c:1162)
==18789==    by 0x4052E1: run_builtin (git.c:308)
==18789==    by 0x405474: handle_internal_command (git.c:467)
==18789==    by 0x40558E: run_argv (git.c:513)
==18789== 
==18789== 313,333,787 bytes in 2,509,382 blocks are definitely lost in loss record 97 of 97
==18789==    at 0x4C25E84: calloc (in /usr/lib/valgrind/vgpreload_memcheck-amd64-linux.so)
==18789==    by 0x520084: xcalloc (wrapper.c:98)
==18789==    by 0x51AFD1: create_ce_entry (unpack-trees.c:532)
==18789==    by 0x51B1AE: unpack_nondirectories (unpack-trees.c:582)
==18789==    by 0x51B843: unpack_callback (unpack-trees.c:772)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789==    by 0x51AD8D: traverse_trees_recursive (unpack-trees.c:460)
==18789==    by 0x51B973: unpack_callback (unpack-trees.c:809)
==18789==    by 0x5190F8: traverse_trees (tree-walk.c:407)
==18789== 
==18789== LEAK SUMMARY:
==18789==    definitely lost: 333,068,408 bytes in 2,535,805 blocks
==18789==    indirectly lost: 166,682,225 bytes in 1,331,950 blocks
==18789==      possibly lost: 1,597 bytes in 12 blocks
==18789==    still reachable: 12,034,769 bytes in 86,413 blocks
==18789==         suppressed: 0 bytes in 0 blocks
==18789== Reachable blocks (those to which a pointer was found) are not shown.
==18789== To see them, rerun with: --leak-check=full --show-reachable=yes
==18789== 
==18789== For counts of detected and suppressed errors, rerun with: -v
==18789== Use --track-origins=yes to see where uninitialised values come from
==18789== ERROR SUMMARY: 241596 errors from 34 contexts (suppressed: 4 from 4)
