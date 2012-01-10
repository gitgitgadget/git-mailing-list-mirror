From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: leaky cherry-pick
Date: Tue, 10 Jan 2012 10:58:45 +0530
Message-ID: <CALkWK0nwE0c6qVvbauPrjmb3NX4NDeGSrvrC2ry2bjMeM4Hr0A@mail.gmail.com>
References: <20120109223737.GA1589@padd.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>
To: Pete Wyckoff <pw@padd.com>
X-From: git-owner@vger.kernel.org Tue Jan 10 06:29:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RkUGp-0005va-38
	for gcvg-git-2@lo.gmane.org; Tue, 10 Jan 2012 06:29:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751805Ab2AJF3J convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 10 Jan 2012 00:29:09 -0500
Received: from mail-we0-f174.google.com ([74.125.82.174]:52207 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab2AJF3H convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 10 Jan 2012 00:29:07 -0500
Received: by werm1 with SMTP id m1so3191326wer.19
        for <git@vger.kernel.org>; Mon, 09 Jan 2012 21:29:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=I0PmPynOsoROaiRcwfWHs/rOFRpxavPLKuy8UW7yRzg=;
        b=aKASV2jo0Wm1J7Szb8p3Rfwt3FykaSfDNZdRHDixITXqrzsKj4Ij8eQx7nrsPN6n6N
         1B5L/aRLaAiPFJ8zMaJQFRKPOGC7Rw+ORIAI/irmPDtAeVf39mC2j8BELa2F6mmE2ewc
         ft5ElWWYiEyHemha34GvLMNGjQYQvB+pr4b3Q=
Received: by 10.216.139.153 with SMTP id c25mr197602wej.25.1326173346345; Mon,
 09 Jan 2012 21:29:06 -0800 (PST)
Received: by 10.216.175.3 with HTTP; Mon, 9 Jan 2012 21:28:45 -0800 (PST)
In-Reply-To: <20120109223737.GA1589@padd.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188218>

Hi,

Pete Wyckoff wrote:
> =3D=3D18789=3D=3D HEAP SUMMARY:
> =3D=3D18789=3D=3D =C2=A0 =C2=A0 in use at exit: 511,786,999 bytes in =
3,954,180 blocks
> =3D=3D18789=3D=3D =C2=A0 total heap usage: 6,352,564 allocs, 2,398,38=
4 frees, 2,610,529,433 bytes allocated

This is disturbing, to say the least.  Let me try to chomp through the
Valgrind output to see what I understand.

[Re-ordering for convenience]
> [...]

Ignoring small losses from strdup(), parse_args() and other unrelated
things for the moment.

> =3D=3D18789=3D=3D 16 bytes in 1 blocks are definitely lost in loss re=
cord 14 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x49578D: commit_list_insert (commi=
t.c:356)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x495886: commit_list_insert_by_dat=
e (commit.c:390)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4F51BC: commit_list_insert_by_dat=
e_cached (revision.c:508)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4F5344: add_parents_to_list (revi=
sion.c:550)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4F5C62: limit_list (revision.c:83=
6)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4FA49B: prepare_revision_walk (re=
vision.c:2068)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47522F: prepare_revs (revert.c:65=
0)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x475B6D: walk_revs_populate_todo (=
revert.c:855)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4766BF: pick_revisions (revert.c:=
1123)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 144 (16 direct, 128 indirect) bytes in 1 blocks are=
 definitely lost in loss record 41 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47536C: commit_list_append (rever=
t.c:692)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x475B8A: walk_revs_populate_todo (=
revert.c:859)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4766BF: pick_revisions (revert.c:=
1123)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x40558E: run_argv (git.c:513)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x40571B: main (git.c:588)

Ugh, I never free the commit_list I build up in commit_list_append().
Rough sketch of fix (caution: untested):

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/builtin/revert.c b/builtin/revert.c
index 0d8020c..76be0e3 100644
--- a/builtin/revert.c
+++ b/builtin/revert.c
@@ -770,8 +770,11 @@ static int parse_insn_buffer(char *buf, struct
commit_list **todo_list,
 	for (i =3D 1; *p; i++) {
 		char *eol =3D strchrnul(p, '\n');
 		commit =3D parse_insn_line(p, eol, opts);
-		if (!commit)
+		if (!commit) {
+			if (*todo_list)
+				free_commit_list(*todo_list);
 			return error(_("Could not parse line %d."), i);
+		}
 		next =3D commit_list_append(commit, next);
 		p =3D *eol ? eol + 1 : eol;
 	}
@@ -1020,14 +1023,17 @@ static int pick_commits(struct commit_list
*todo_list, struct replay_opts *opts)
 	for (cur =3D todo_list; cur; cur =3D cur->next) {
 		save_todo(cur, opts);
 		res =3D do_pick_commit(cur->item, opts);
-		if (res)
+		if (res) {
+			free_commit_list(todo_list);
 			return res;
+		}
 	}

 	/*
 	 * Sequence of picks finished successfully; cleanup by
 	 * removing the .git/sequencer directory
 	 */
+	free_commit_list(todo_list);
 	remove_sequencer_state();
 	return 0;
 }
--

> =3D=3D18789=3D=3D 1,728 bytes in 9 blocks are definitely lost in loss=
 record 67 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C27927: realloc (in /usr/lib/val=
grind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FFCD: xrealloc (wrapper.c:82)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x488D5B: handle_attr_line (attr.c:=
325)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x488DDD: read_attr_from_array (att=
r.c:340)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x48924E: bootstrap_attr_stack (att=
r.c:501)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x48940F: prepare_attr_stack (attr.=
c:568)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489A27: collect_all_attrs (attr.c=
:725)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489AED: git_check_attr (attr.c:73=
9)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x49E314: convert_attrs (convert.c:=
730)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x49F230: get_stream_filter (conver=
t.c:1247)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4B69B1: write_entry (entry.c:191)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 7,726 (4,320 direct, 3,406 indirect) bytes in 9 blo=
cks are definitely lost in loss record 77 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C27882: realloc (in /usr/lib/val=
grind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FFCD: xrealloc (wrapper.c:82)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x488D5B: handle_attr_line (attr.c:=
325)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x488E86: read_attr_from_file (attr=
=2Ec:358)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489130: read_attr (attr.c:428)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489335: bootstrap_attr_stack (att=
r.c:525)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x48940F: prepare_attr_stack (attr.=
c:568)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489A27: collect_all_attrs (attr.c=
:725)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x489AED: git_check_attr (attr.c:73=
9)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x49E314: convert_attrs (convert.c:=
730)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x49F230: get_stream_filter (conver=
t.c:1247)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4B69B1: write_entry (entry.c:191)

Interesting- I wonder where .gitattributes parsing code fits into all
this.  The purpose of bootstrap _attr_stack() is to populate
attr_stack for its callers.  Lots of memory allocation happening in
handle_attr_line() -- that information is returned to
bootstrap_attr_stack().  We have to keep backtracking until that
information is provably useless and free it.  Hm, convert_attrs() (in
convert.c) is a common caller in both cases, but the populated
attr_stack is local to attr.c; I wonder if this is the problem.  If my
hunch is right, it should be a trivial fix (caution: untested):

Signed-off-by: Ramkumar Ramachandra <artagnon@gmail.com>

diff --git a/attr.c b/attr.c
index 76b079f..12e3824 100644
--- a/attr.c
+++ b/attr.c
@@ -745,6 +745,7 @@ int git_check_attr(const char *path, int num,
struct git_attr_check *check)
 		check[i].value =3D value;
 	}

+	drop_attr_stack();
 	return 0;
 }
 --

> =3D=3D18789=3D=3D 1,107 bytes in 9 blocks are definitely lost in loss=
 record 62 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x519DCD: setup_unpack_trees_porcel=
ain (unpack-trees.c:79)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C8160: git_merge_trees (merge-re=
cursive.c:235)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4CC907: merge_trees (merge-recurs=
ive.c:1817)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4747B8: do_recursive_merge (rever=
t.c:425)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x476756: pick_revisions (revert.c:=
1133)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 1,143 bytes in 9 blocks are definitely lost in loss=
 record 63 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x519E8F: setup_unpack_trees_porcel=
ain (unpack-trees.c:82)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C8160: git_merge_trees (merge-re=
cursive.c:235)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4CC907: merge_trees (merge-recurs=
ive.c:1817)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4747B8: do_recursive_merge (rever=
t.c:425)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x476756: pick_revisions (revert.c:=
1133)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 1,269 bytes in 9 blocks are definitely lost in loss=
 record 64 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x519CE0: setup_unpack_trees_porcel=
ain (unpack-trees.c:66)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C8160: git_merge_trees (merge-re=
cursive.c:235)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4CC907: merge_trees (merge-recurs=
ive.c:1817)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4747B8: do_recursive_merge (rever=
t.c:425)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x476756: pick_revisions (revert.c:=
1133)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 704 bytes in 8 blocks are definitely lost in loss r=
ecord 58 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51C1F5: unpack_trees (unpack-tree=
s.c:1063)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4A46BD: diff_cache (diff-lib.c:47=
4)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4A46FC: run_diff_index (diff-lib.=
c:482)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4A48DA: index_differs_from (diff-=
lib.c:517)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474AC2: do_pick_commit (revert.c:=
503)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 1,316 bytes in 10 blocks are possibly lost in loss =
record 65 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 2,376 bytes in 27 blocks are definitely lost in los=
s record 72 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51C1F5: unpack_trees (unpack-tree=
s.c:1063)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C81C2: git_merge_trees (merge-re=
cursive.c:241)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4CC907: merge_trees (merge-recurs=
ive.c:1817)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4747B8: do_recursive_merge (rever=
t.c:425)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 744,353 bytes in 7,493 blocks are definitely lost i=
n loss record 88 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51C1F5: unpack_trees (unpack-tree=
s.c:1063)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4A46BD: diff_cache (diff-lib.c:47=
4)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4A46FC: run_diff_index (diff-lib.=
c:482)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 1,865,981 bytes in 18,806 blocks are definitely los=
t in loss record 90 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51C1F5: unpack_trees (unpack-tree=
s.c:1063)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4C81C2: git_merge_trees (merge-re=
cursive.c:241)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4CC907: merge_trees (merge-recurs=
ive.c:1817)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 313,333,787 bytes in 2,509,382 blocks are definitel=
y lost in loss record 97 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AFD1: create_ce_entry (unpack-t=
rees.c:532)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1AE: unpack_nondirectories (un=
pack-trees.c:582)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)

So many issues with unpack-trees!  Let's try to look for some common
patterns, and see where the problems are occurring.  I can see two
distinct patterns: backtraces that include
setup_unpack_trees_porcelain() and those that include
create_ce_entry().  Let's go with create_ce_entry() first: it
allocates quite a bit of memory according to cache.h:247.  And it
returns the memory back to unpack_nondirectories().  What's worse?
unpack_nondirectories() calls create_ce_entry() in a loop and stuffs
all this new memory into a cache_entry provided by unpack_callback().
In the end, all the calls boil down to git_merge_trees(): I don't see
the ton of memory allocated higher in the callstack being passed down
in any way.  I don't understand- why doesn't unpack_callback() clean
up the memory in "struct cache_entry *src" after it's done?

> =3D=3D18789=3D=3D 281 bytes in 2 blocks are possibly lost in loss rec=
ord 51 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C2779D: malloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FE4E: xmalloc (wrapper.c:35)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E483E: create_from_disk (read-ca=
che.c:1255)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4B7F: read_index_from (read-cac=
he.c:1328)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4758: read_index (read-cache.c:=
1224)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47469F: do_recursive_merge (rever=
t.c:411)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x476756: pick_revisions (revert.c:=
1133)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 8,386,453 (1,031,576 direct, 7,354,877 indirect) by=
tes in 1 blocks are definitely lost in loss record 91 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4B38: read_index_from (read-cac=
he.c:1319)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4758: read_index (read-cache.c:=
1224)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4DB50F: read_index_preload (prelo=
ad-index.c:105)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4752A1: read_and_refresh_cache (r=
evert.c:661)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47657B: pick_revisions (revert.c:=
1081)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x40558E: run_argv (git.c:513)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x40571B: main (git.c:588)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 69,782,106 (6,793,984 direct, 62,988,122 indirect) =
bytes in 8 blocks are definitely lost in loss record 94 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C27882: realloc (in /usr/lib/val=
grind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51FFCD: xrealloc (wrapper.c:82)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E3D7C: add_index_entry (read-cac=
he.c:976)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x519FFE: add_entry (unpack-trees.c=
:119)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51D0A6: merged_entry (unpack-tree=
s.c:1501)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51D444: threeway_merge (unpack-tr=
ees.c:1615)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51A645: call_unpack_fn (unpack-tr=
ees.c:289)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B1E2: unpack_nondirectories (un=
pack-trees.c:586)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B843: unpack_callback (unpack-t=
rees.c:772)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x5190F8: traverse_trees (tree-walk=
=2Ec:407)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51AD8D: traverse_trees_recursive =
(unpack-trees.c:460)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x51B973: unpack_callback (unpack-t=
rees.c:809)
> =3D=3D18789=3D=3D
> =3D=3D18789=3D=3D 105,619,300 (9,284,184 direct, 96,335,116 indirect)=
 bytes in 9 blocks are definitely lost in loss record 96 of 97
> =3D=3D18789=3D=3D =C2=A0 =C2=A0at 0x4C25E84: calloc (in /usr/lib/valg=
rind/vgpreload_memcheck-amd64-linux.so)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x520084: xcalloc (wrapper.c:98)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4B38: read_index_from (read-cac=
he.c:1319)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4E4758: read_index (read-cache.c:=
1224)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47469F: do_recursive_merge (rever=
t.c:411)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x474FA5: do_pick_commit (revert.c:=
598)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47635D: pick_commits (revert.c:10=
22)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x476756: pick_revisions (revert.c:=
1133)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x47685A: cmd_cherry_pick (revert.c=
:1162)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x4052E1: run_builtin (git.c:308)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x405474: handle_internal_command (=
git.c:467)
> =3D=3D18789=3D=3D =C2=A0 =C2=A0by 0x40558E: run_argv (git.c:513)

Will investigate read-cache the context of Duy's comment- it looks
like I have to read through some more history to understand what's
going on.

Thanks.

-- Ram
