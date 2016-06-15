From: Junio C Hamano <gitster@pobox.com>
Subject: What's cooking in git.git (Feb 2009, #01; Sun, 01)
Date: Sun, 01 Feb 2009 23:59:48 -0800
Message-ID: <7vk589l157.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Feb 02 09:01:29 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTtkG-000898-27
	for gcvg-git-2@gmane.org; Mon, 02 Feb 2009 09:01:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584AbZBBIAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Feb 2009 03:00:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751474AbZBBIAA
	(ORCPT <rfc822;git-outgoing>); Mon, 2 Feb 2009 03:00:00 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:38104 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751159AbZBBH76 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Feb 2009 02:59:58 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 0976F953A8;
	Mon,  2 Feb 2009 02:59:56 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6A323953A4; Mon,
  2 Feb 2009 02:59:50 -0500 (EST)
X-master-at: 2ea3c17189bf9ca459879129ca190792b5451f05
X-next-at: 5bad675db98a79d08ce5abadd3347d829c6c5b36
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 7AE6C194-F0FF-11DD-BF97-CC4CC92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108065>

Here are the topics that have been cooking.  Commits prefixed with '-' are
only in 'pu' while commits prefixed with '+' are in 'next'.  The ones
marked with '.' do not appear in any of the branches, but I am still
holding onto them.

The topics list the commits in reverse chronological order.  The topics
meant to be merged to the maintenance series have "maint-" in their names.

----------------------------------------------------------------
[New Topics]

* gt/utf8-width (Fri Jan 30 04:41:29 2009 -0500) 2 commits
 - builtin-blame.c: Use utf8_strwidth for author's names
 - utf8: add utf8_strwidth()

I am not sure if utf8_strwidth() behaves sensibly when fed a non-UTF8
string (a possible failure mode is utf8_width() says "no" and it returns
0, resulting in width of all zero and causing division by zero somewhere
downstream, or something silly like that), but other than that, I do not
think it would hurt, and will actively improve the current code.

* jc/refuse-push-to-current (Sat Jan 31 17:34:05 2009 -0800) 2 commits
 - Set receive.denyCurrentBranch to true in a new non-bare repository
 - receive-pack: explain what to do when push updates the current
   branch

This prepares to finally switch the default for receive.denyCurrentBranch
to "refuse".  The idea is to issue a big warning to people who push into
currently checked out branch when the configuration is unset and we
default to "warn", and explain in detail (1) why it is not likely to be
what they want to do (to help new people), (2) if it is what they want,
how to squelch that annoyingly long message, and (3) the default will be
changed to "refuse" in a future release of git.  The tip commit also sets
the configuration to refuse in a newly created repository, but with a
twist.  People who get the "refusal" configuration this way may be
expecting the recipe they picked up to push into a live repository,
perhaps a website, and let its post-update hook to "reset --hard" the
deployment, and we will explain that (1) it will no longer work (because
we default to "refuse" in a newly created repository), (2) how to
configure it to work again, and (3) how to squelch the annoying message.

I personally do not think anything short of an approach like this would
work without a huge fallout like we had when yanked git-foo commands from
people's $PATH in 1.6.0, but I can still be pursuaded by a better
alternative, and that is why they are not in 'next' yet.  Saying "old
timers can flip a single switch just once" is not a better alternative, as
I explained already.

* jc/fsck (Fri Jan 30 02:44:13 2009 -0800) 7 commits
 - fsck: revert --quick to the default and introduce --medium
 - fsck: three levels of validation
 - verify-pack: add --quick
 - verify_pack(): allow a quicker verification for a pack with
   version 2 idx
 - pack-check.c: minor formatting fix to match coding style
 + fsck: check loose objects from alternate object stores by default
 + fsck: HEAD is part of refs

I haven't heard anything positive nor negative about this series.  I
consider the bottom two changes are pure bugfixes and should probably be
in 1.6.2.

I think the tip two commits should be squashed (and perhaps the option
parser cleaned up as suggested on the list) if we were to take the
remainder.

* rc/http-push (Sat Jan 31 07:51:55 2009 +0800) 1 commit
 + http-push: refactor request url creation

Looked fine for 1.6.2.

* jk/head-symref (Thu Jan 29 03:33:02 2009 -0500) 2 commits
 + symbolic ref: refuse non-ref targets in HEAD
 + validate_headref: tighten ref-matching to just branches

Looked fine for 1.6.2.

* kb/checkout-optim (Sun Feb 1 21:23:39 2009 +0100) 7 commits
 - unpack-trees.c: introduce schedule_dir_for_removal()
 - lstat_cache(): print a warning if doing ping-pong between cache
   types
 - combine-diff.c: remove a call to fstat() inside show_patch_diff()
 - write_entry(): use fstat() instead of lstat() when file is open
 - cleanup of write_entry() in entry.c
 - remove some memcpy() and strchr() calls inside
   create_directories()
 - symlinks.c: small cleanup and optimisation

Love to have in 1.6.2

----------------------------------------------------------------
[Stalled and may need help and prodding to go forward]

* jc/merge-convert (Mon Jan 26 16:45:01 2009 -0800) 1 commit
 - git-merge-file: allow converting the results for the work tree

This is a feature waiting for a user.  I do not need it in 1.6.2

We did not give scripted Porcelains a way to say "this temporary file I am
using for merging is for this path, so use the core.autocrlf and attributes
rules for that final path".  Instead, merge-file simply wrote out the
data in the canonical repository representation.

rerere has the same issue, but it is a lot worse.  It reads the three
files (preimage, postimage and thisimage) from the work tree in the work
tree representation, merges them without converting them to the canonical
representation first but inserts the conflict markers with the canonical
representation and writes the resulting mess out.  It needs to be fixed to
read with convert_to_git(), merge them while they are still in the
canonical representation and possibly add conflict markers, and then write
the results out after convert_to_working_tree().  It also needs to write
in binary mode as well.

* jc/blame (Wed Jun 4 22:58:40 2008 -0700) 2 commits
 + blame: show "previous" information in --porcelain/--incremental
   format
 + git-blame: refactor code to emit "porcelain format" output

This gives Porcelains (like gitweb) the information on the commit _before_
the one that the final blame is laid on, which should save them one
rev-parse to dig further.  The line number in the "previous" information
may need refining, and sanity checking code for reference counting may
need to be resurrected before this can move forward.

* db/foreign-scm (Sun Jan 11 15:12:10 2009 -0500) 3 commits
 - Support fetching from foreign VCSes
 - Add specification of git-vcs helpers
 - Add "vcs" config option in remotes

The "spec" did not seem quite well cooked yet, but in the longer term I
think something like this to allow interoperating with other SCMs as if
the other end is a native git repository is a very worthy goal.

* cc/replace (Mon Feb 2 06:13:06 2009 +0100) 11 commits
 - builtin-replace: use "usage_msg_opt" to give better error messages
 - parse-options: add new function "usage_msg_opt"
 - builtin-replace: teach "git replace" to actually replace
 - Add new "git replace" command
 - environment: add global variable to disable replacement
 - mktag: call "check_sha1_signature" with the replacement sha1
 - replace_object: add a test case
 - object: call "check_sha1_signature" with the replacement sha1
 - sha1_file: add a "read_sha1_file_repl" function
 - replace_object: add mechanism to replace objects found in
   "refs/replace/"
 - refs: add a "for_each_replace_ref" function

I think the code is much cleaner than the first round, but I am not
convinced it is doing the right thing in the connectivity traverser.  
I'd like to keep this out of 1.6.2.

* lh/submodule-tree-traversal (Sun Jan 25 01:52:06 2009 +0100) 6 commits
 - archive.c: add support for --submodules[=(all|checkedout)]
 - tree.c: allow read_tree_recursive() to traverse gitlink entries
 + Revert round #1 of the series
 + builtin-ls-tree: enable traversal of submodules
 + archive.c: enable traversal of submodules
 + tree.c: add support for traversal of submodules

Sorry, but what's the status of this one?  I am not particularly
interested in this new feature myself, so unless I hear otherwise from
people, I'd like to keep this out of 1.6.2.  That would have the added
benefit of being able to discard the first four that is already in 'next'
to get a fresh start post 1.6.2 ;-)

* sc/gitweb-category (Fri Dec 12 00:45:12 2008 +0100) 3 commits
 - gitweb: Optional grouping of projects by category
 - gitweb: Split git_project_list_body in two functions
 - gitweb: Modularized git_get_project_description to be more generic

Design discussion between Jakub and Sebastien seems to have stalled.

----------------------------------------------------------------
[Reverted]

* mh/unify-color (Fri Jan 23 01:25:23 2009 -0800) 3 commits
 ? Revert previous two commits
 ? move the color variables to color.c
 ? handle color.ui at a central place

This broke git-format-patch badly.

----------------------------------------------------------------
[Actively cooking]

* wp/add-patch-find (Thu Nov 27 04:08:03 2008 +0000) 3 commits
 + In add --patch, Handle K,k,J,j slightly more gracefully.
 + Add / command in add --patch
 + git-add -i/-p: Change prompt separater from slash to comma

I think this is Ok to have in 1.6.2

* cb/mergetool (Fri Jan 30 23:20:11 2009 +0000) 3 commits
 - mergetool: fix running mergetool in sub-directories
 - mergetool: Add a test for running mergetool in a sub-directory
 + mergetool: respect autocrlf by using checkout-index

The fix to its subdirectory behaviour looked somewhat iffy and may have a
potential for cleaning up.  But we should have it in 1.6.2.

* js/valgrind (Wed Jan 21 02:36:40 2009 +0100) 2 commits
 - valgrind: ignore ldso errors
 - Add valgrind support in test scripts

Dscho and Peff had further exchanges on the list; I am sort of waiting for
the conclusion before picking any intermediate version up.

* js/notes (Tue Jan 13 20:57:16 2009 +0100) 6 commits
 + git-notes: fix printing of multi-line notes
 + notes: fix core.notesRef documentation
 + Add an expensive test for git-notes
 + Speed up git notes lookup
 + Add a script to edit/inspect notes
 + Introduce commit notes

It would be nice to hear a real world success story using the notes
mechanism; Dscho says he also wants to make sure the current choice
of the structure scales well before casting it in stone.

----------------------------------------------------------------
[Graduated to "master"]

* jc/maint-1.6.0-split-diff-metainfo (Mon Jan 26 00:08:24 2009 -0800) 1 commit
 + diff.c: output correct index lines for a split diff

This is slated for maintenance series 1.6.0.X.

* jc/maint-split-diff-metainfo (Tue Jan 27 01:08:02 2009 -0800) 2 commits
 + Merge branch 'jc/maint-1.6.0-split-diff-metainfo' into jc/maint-
   split-diff-metainfo
 + diff.c: output correct index lines for a split diff

Early conflict resolution branch for the above to carry it to 1.6.1.X
series.

* js/maint-rebase-i-submodule (Tue Jan 27 12:42:31 2009 +0100) 2 commits
 + Fix submodule squashing into unrelated commit
 + rebase -i squashes submodule changes into unrelated commit

* jg/tag-contains (Mon Jan 26 09:13:25 2009 -0500) 3 commits
 + git-tag: Add --contains option
 + Make has_commit() non-static
 + Make opt_parse_with_commit() non-static

* jc/maint-allow-uninteresting-missing (Tue Jan 27 23:19:30 2009 -0800) 1 commit
 + revision traversal: allow UNINTERESTING objects to be missing

This is a small follow-up to the fix to send-pack in 1.6.1; meant to go in
1.6.1.X maintenance series and newer.

* am/maint-push-doc (Mon Jan 26 00:45:33 2009 +0100) 3 commits
 + Documentation: rework src/dst description in git push
 + Documentation: more git push examples
 + Documentation: simplify refspec format description

* jc/maint-apply-fix (Sun Jan 25 23:41:26 2009 -0800) 1 commit
 + builtin-apply.c: do not set bogus mode in check_preimage() for
   deleted path

* ks/maint-mailinfo-folded (Tue Jan 13 01:21:04 2009 +0300) 4 commits
 + mailinfo: tests for RFC2047 examples
 + mailinfo: add explicit test for mails like '<a.u.thor@example.com>
   (A U Thor)'
 + mailinfo: 'From:' header should be unfold as well
 + mailinfo: correctly handle multiline 'Subject:' header

Graduated with a follow-up patch from the original author.

* jg/mergetool (Sat Jan 24 00:12:45 2009 +0100) 1 commit
 + mergetool: Don't repeat merge tool candidates

* jk/signal-cleanup (Thu Jan 22 01:03:28 2009 -0500) 5 commits
 + pager: do wait_for_pager on signal death
 + refactor signal handling for cleanup functions
 + chain kill signals for cleanup functions
 + diff: refactor tempfile cleanup handling
 + Windows: Fix signal numbers

* sp/runtime-prefix (Sun Jan 18 13:00:15 2009 +0100) 7 commits
 + Windows: Revert to default paths and convert them by
   RUNTIME_PREFIX
 + Compute prefix at runtime if RUNTIME_PREFIX is set
 + Modify setup_path() to only add git_exec_path() to PATH
 + Add calls to git_extract_argv0_path() in programs that call
   git_config_*
 + git_extract_argv0_path(): Move check for valid argv0 from caller
   to callee
 + Refactor git_set_argv0_path() to git_extract_argv0_path()
 + Move computation of absolute paths from Makefile to runtime (in
   preparation for RUNTIME_PREFIX)

There was a report that this breaks with older GNU Make.

----------------------------------------------------------------
[Will merge to "master" soon]

* jc/maint-add-u-remove-conflicted (Wed Jan 28 14:24:53 2009 -0800) 1 commit
 - add -u: do not fail to resolve a path as deleted

This has been updated from the posted version with a correction.  We
should have it in 1.6.2

* jk/maint-cleanup-after-exec-failure (Wed Jan 28 02:38:14 2009 -0500) 4 commits
 + git: use run_command() to execute dashed externals
 + run_command(): help callers distinguish errors
 + run_command(): handle missing command errors more gracefully
 + git: s/run_command/run_builtin/

Looked good for 1.6.2.

* ns/am-slacker (Sat Jan 24 10:18:02 2009 +0900) 2 commits
 + git-am: Add --ignore-date option
 + am: Add --committer-date-is-author-date option

It is a (probably) useful new feature with a sort-of cute explanation.
I am not sure if it needs further work (such as hooking it to rebase),
but other than that, I think it is Ok to have in 1.6.2.

----------------------------------------------------------------
[On Hold]

* jc/commit-assume-also-during-merge (Thu Jan 22 22:21:49 2009 -0800) 3 commits
 - git commit: pathspec without -i/-o implies -i semantics during a
   merge
 - builtin-commit: shorten eye-sore overlong lines
 - Add "partial commit" tests during a conflicted merge

This is only meant as a weatherballoon to help facilitate discussion.

* jk/renamelimit (Sat May 3 13:58:42 2008 -0700) 1 commit
 . diff: enable "too large a rename" warning when -M/-C is explicitly
   asked for

* jc/stripspace (Sun Mar 9 00:30:35 2008 -0800) 6 commits
 . git-am --forge: add Signed-off-by: line for the author
 . git-am: clean-up Signed-off-by: lines
 . stripspace: add --log-clean option to clean up signed-off-by:
   lines
 . stripspace: use parse_options()
 . Add "git am -s" test
 . git-am: refactor code to add signed-off-by line for the committer

* jc/post-simplify (Fri Aug 15 01:34:51 2008 -0700) 2 commits
 . revision --simplify-merges: incremental simplification
 . revision --simplify-merges: prepare for incremental simplification
