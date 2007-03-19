From: "J. Bruce Fields" <bfields@citi.umich.edu>
Subject: [PATCH] glossary: stop generating automatically
Date: Sun, 18 Mar 2007 23:17:59 -0400
Message-ID: <40732.0443111987$1174274348@news.gmane.org>
References: <117427428145-git-send-email-> <1174274281887-git-send-email-> <11742742813855-git-send-email-> <1174274281258-git-send-email->
Cc: git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"J. Bruce Fields" <bfields@citi.umich.edu>
To: Junio C Hamano <junkio@cox.net>
X-From: git-owner@vger.kernel.org Mon Mar 19 04:18:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HT8Od-0000J6-00
	for gcvg-git@gmane.org; Mon, 19 Mar 2007 04:18:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933788AbXCSDSS (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 18 Mar 2007 23:18:18 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S933817AbXCSDSQ
	(ORCPT <rfc822;git-outgoing>); Sun, 18 Mar 2007 23:18:16 -0400
Received: from mail.fieldses.org ([66.93.2.214]:45768 "EHLO fieldses.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933806AbXCSDSH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Mar 2007 23:18:07 -0400
Received: from bfields by fieldses.org with local (Exim 4.63)
	(envelope-from <bfields@fieldses.org>)
	id 1HT8Nl-0003Jb-QA; Sun, 18 Mar 2007 23:18:01 -0400
X-Mailer: git-send-email 1.5.0.3.g6c05
In-Reply-To: <1174274281258-git-send-email->
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42574>

From: J. Bruce Fields <bfields@citi.umich.edu>

The sort_glossary.pl script sorts the glossary, checks for duplicates,
and automatically adds cross-references.

But it's not so hard to do all that by hand, and sometimes the automatic
cross-references are a little wrong; so let's run the script one last
time and check in its output.

Note: to make the output fit better into the user manual I also deleted
the acknowledgements at the end, which was maybe a little rude; feel
free to object and I can find a different solution.

Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>
Signed-off-by: "J. Bruce Fields" <bfields@citi.umich.edu>
---
 Documentation/Makefile         |    8 +-
 Documentation/glossary.txt     |  740 +++++++++++++++++++++-------------------
 Documentation/sort_glossary.pl |   69 ----
 Documentation/user-manual.txt  |    3 -
 4 files changed, 392 insertions(+), 428 deletions(-)
 delete mode 100644 Documentation/sort_glossary.pl

diff --git a/Documentation/Makefile b/Documentation/Makefile
index 48d41c5..7db3fb9 100644
--- a/Documentation/Makefile
+++ b/Documentation/Makefile
@@ -16,8 +16,9 @@ ARTICLES += repository-layout
 ARTICLES += hooks
 ARTICLES += everyday
 ARTICLES += git-tools
+ARTICLES += glossary
 # with their own formatting rules.
-SP_ARTICLES = glossary howto/revert-branch-rebase user-manual
+SP_ARTICLES = howto/revert-branch-rebase user-manual
 
 DOC_HTML += $(patsubst %,%.html,$(ARTICLES) $(SP_ARTICLES))
 
@@ -111,11 +112,6 @@ XSLTOPTS = --xinclude --stringparam html.stylesheet docbook-xsl.css
 user-manual.html: user-manual.xml
 	xsltproc $(XSLTOPTS) -o $@ $(XSLT) $<
 
-glossary.html : glossary.txt sort_glossary.pl
-	cat $< | \
-	perl sort_glossary.pl | \
-	$(ASCIIDOC) -b xhtml11 - > glossary.html
-
 howto-index.txt: howto-index.sh $(wildcard howto/*.txt)
 	rm -f $@+ $@
 	sh ./howto-index.sh $(wildcard howto/*.txt) >$@+
diff --git a/Documentation/glossary.txt b/Documentation/glossary.txt
index 9f44624..82e17db 100644
--- a/Documentation/glossary.txt
+++ b/Documentation/glossary.txt
@@ -1,365 +1,405 @@
-alternate object database::
-	Via the alternates mechanism, a repository can inherit part of its
-	object database from another object database, which is called
-	"alternate".
-
-bare repository::
-	A bare repository is normally an appropriately named
-	directory with a `.git` suffix that does not have a
-	locally checked-out copy of any of the files under revision
-	control.  That is, all of the `git` administrative and
-	control files that would normally be present in the
-	hidden `.git` sub-directory are directly present in
-	the `repository.git` directory instead, and no other files
-	are present and checked out.  Usually publishers of public
-	repositories make bare repositories available.
-
-blob object::
-	Untyped object, e.g. the contents of a file.
-
-branch::
-	A non-cyclical graph of revisions, i.e. the complete history of
-	a particular revision, which is called the branch head. The
-	branch heads are stored in `$GIT_DIR/refs/heads/`.
-
-cache::
-	Obsolete for: index.
-
-chain::
-	A list of objects, where each object in the list contains a
-	reference to its successor (for example, the successor of a commit
-	could be one of its parents).
-
-changeset::
-	BitKeeper/cvsps speak for "commit". Since git does not store
-	changes, but states, it really does not make sense to use
-	the term "changesets" with git.
-
-checkout::
-	The action of updating the working tree to a revision which was
-	stored in the object database.
-
-cherry-picking::
-	In SCM jargon, "cherry pick" means to choose a subset of
-	changes out of a series of changes (typically commits)
-	and record them as a new series of changes on top of
-	different codebase.  In GIT, this is performed by
-	"git cherry-pick" command to extract the change
-	introduced by an existing commit and to record it based
-	on the tip of the current branch as a new commit.
-
-clean::
-	A working tree is clean, if it corresponds to the revision
-	referenced by the current head.  Also see "dirty".
-
-commit::
-	As a verb: The action of storing the current state of the index in the
-	object database. The result is a revision.
-	As a noun: Short hand for commit object.
-
-commit object::
-	An object which contains the information about a particular
-	revision, such as parents, committer, author, date and the
-	tree object which corresponds to the top directory of the
-	stored revision.
-
-core git::
-	Fundamental data structures and utilities of git. Exposes only
-	limited source code management tools.
-
-DAG::
-	Directed acyclic graph. The commit objects form a directed acyclic
-	graph, because they have parents (directed), and the graph of commit
-	objects is acyclic (there is no chain which begins and ends with the
-	same object).
-
-dangling object::
-	An unreachable object which is not reachable even from other
-	unreachable objects; a dangling object has no references to it
-	from any reference or object in the repository.
-
-dircache::
+GIT Glossary
+============
+
+[[def_alternate_object_database]]alternate object database::
+	Via the alternates mechanism, a <<def_repository,repository>> can
+	inherit part of its <<def_object_database,object database>> from another
+	<<def_object_database,object database>>, which is called "alternate".
+
+[[def_bare_repository]]bare repository::
+	A <<def_bare_repository,bare repository>> is normally an appropriately
+	named <<def_directory,directory>> with a `.git` suffix that does not
+	have a locally checked-out copy of any of the files under
+	<<def_revision,revision>> control. That is, all of the `git`
+	administrative and control files that would normally be present in the
+	hidden `.git` sub-directory are directly present in the
+	`<<def_repository,repository>>.git` <<def_directory,directory>> instead,
+	and no other files are present and checked out. Usually publishers of
+	public repositories make bare repositories available.
+
+[[def_blob_object]]blob object::
+	Untyped <<def_object,object>>, e.g. the contents of a file.
+
+[[def_branch]]branch::
+	A non-cyclical graph of revisions, i.e. the complete history of a
+	particular <<def_revision,revision>>, which is called the
+	<<def_branch,branch>> <<def_head,head>>. The <<def_branch,branch>> heads
+	are stored in `$GIT_DIR/refs/heads/`.
+
+[[def_cache]]cache::
+	Obsolete for: <<def_index,index>>.
+
+[[def_chain]]chain::
+	A list of objects, where each <<def_object,object>> in the list contains
+	a reference to its successor (for example, the successor of a
+	<<def_commit,commit>> could be one of its parents).
+
+[[def_changeset]]changeset::
+	BitKeeper/cvsps speak for "<<def_commit,commit>>". Since git does not
+	store changes, but states, it really does not make sense to use the term
+	"changesets" with git.
+
+[[def_checkout]]checkout::
+	The action of updating the <<def_working_tree,working tree>> to a
+	<<def_revision,revision>> which was stored in the
+	<<def_object_database,object database>>.
+
+[[def_cherry-picking]]cherry-picking::
+	In <<def_SCM,SCM>> jargon, "cherry pick" means to choose a subset of
+	changes out of a series of changes (typically commits) and record them
+	as a new series of changes on top of different codebase. In GIT, this is
+	performed by "git cherry-pick" command to extract the change introduced
+	by an existing <<def_commit,commit>> and to record it based on the tip
+	of the current <<def_branch,branch>> as a new <<def_commit,commit>>.
+
+[[def_clean]]clean::
+	A <<def_working_tree,working tree>> is <<def_clean,clean>>, if it
+	corresponds to the <<def_revision,revision>> referenced by the current
+	<<def_head,head>>. Also see "<<def_dirty,dirty>>".
+
+[[def_commit]]commit::
+	As a verb: The action of storing the current state of the
+	<<def_index,index>> in the <<def_object_database,object database>>. The
+	result is a <<def_revision,revision>>. As a noun: Short hand for
+	<<def_commit_object,commit object>>.
+
+[[def_commit_object]]commit object::
+	An <<def_object,object>> which contains the information about a
+	particular <<def_revision,revision>>, such as parents, committer,
+	author, date and the <<def_tree_object,tree object>> which corresponds
+	to the top <<def_directory,directory>> of the stored
+	<<def_revision,revision>>.
+
+[[def_core_git]]core git::
+	Fundamental data structures and utilities of git. Exposes only limited
+	source code management tools.
+
+[[def_DAG]]DAG::
+	Directed acyclic graph. The <<def_commit,commit>> objects form a
+	directed acyclic graph, because they have parents (directed), and the
+	graph of <<def_commit,commit>> objects is acyclic (there is no
+	<<def_chain,chain>> which begins and ends with the same
+	<<def_object,object>>).
+
+[[def_dangling_object]]dangling object::
+	An <<def_unreachable_object,unreachable object>> which is not
+	<<def_reachable,reachable>> even from other unreachable objects; a
+	<<def_dangling_object,dangling object>> has no references to it from any
+	reference or <<def_object,object>> in the <<def_repository,repository>>.
+
+[[def_dircache]]dircache::
 	You are *waaaaay* behind.
 
-dirty::
-	A working tree is said to be dirty if it contains modifications
-	which have not been committed to the current branch.
-
-directory::
+[[def_directory]]directory::
 	The list you get with "ls" :-)
 
-ent::
-	Favorite synonym to "tree-ish" by some total geeks. See
+[[def_dirty]]dirty::
+	A <<def_working_tree,working tree>> is said to be <<def_dirty,dirty>> if
+	it contains modifications which have not been committed to the current
+	<<def_branch,branch>>.
+
+[[def_ent]]ent::
+	Favorite synonym to "<<def_tree-ish,tree-ish>>" by some total geeks. See
 	`http://en.wikipedia.org/wiki/Ent_(Middle-earth)` for an in-depth
-	explanation.  Avoid this term, not to confuse people.
-
-fast forward::
-	A fast-forward is a special type of merge where you have
-	a revision and you are "merging" another branch's changes
-	that happen to be a descendant of what you have.
-	In such these cases, you do not make a new merge commit but
-	instead just update to his revision. This will happen
-	frequently on a tracking branch of a remote repository.
-
-fetch::
-	Fetching a branch means to get the branch's head ref from a
-	remote repository, to find out which objects are missing from
-	the local object database, and to get them, too.
-
-file system::
-	Linus Torvalds originally designed git to be a user space file
-	system, i.e. the infrastructure to hold files and directories.
-	That ensured the efficiency and speed of git.
-
-git archive::
-	Synonym for repository (for arch people).
-
-grafts::
-	Grafts enables two otherwise different lines of development to be
-	joined together by recording fake ancestry information for commits.
-	This way you can make git pretend the set of parents a commit
-	has is different from what was recorded when the commit was created.
-	Configured via the `.git/info/grafts` file.
-
-hash::
-	In git's context, synonym to object name.
-
-head::
-	The top of a branch. It contains a ref to the corresponding
-	commit object.
-
-head ref::
-	A ref pointing to a head. Often, this is abbreviated to "head".
-	Head refs are stored in `$GIT_DIR/refs/heads/`.
-
-hook::
-	During the normal execution of several git commands,
-	call-outs are made to optional scripts that allow
-	a developer to add functionality or checking.
-	Typically, the hooks allow for a command to be pre-verified
-	and potentially aborted, and allow for a post-notification
-	after the operation is done.
-	The hook scripts are found in the `$GIT_DIR/hooks/` directory,
-	and are enabled by simply making them executable.
-
-index::
-	A collection of files with stat information, whose contents are
-	stored as objects. The index is a stored version of your working
-	tree. Truth be told, it can also contain a second, and even a third
-	version of a working tree, which are used when merging.
-
-index entry::
-	The information regarding a particular file, stored in the index.
-	An index entry can be unmerged, if a merge was started, but not
-	yet finished (i.e. if the index contains multiple versions of
-	that file).
-
-master::
-	The default development branch. Whenever you create a git
-	repository, a branch named "master" is created, and becomes
-	the active branch. In most cases, this contains the local
+	explanation. Avoid this term, not to confuse people.
+
+[[def_fast_forward]]fast forward::
+	A fast-forward is a special type of <<def_merge,merge>> where you have a
+	<<def_revision,revision>> and you are "merging" another
+	<<def_branch,branch>>'s changes that happen to be a descendant of what
+	you have. In such these cases, you do not make a new <<def_merge,merge>>
+	<<def_commit,commit>> but instead just update to his
+	<<def_revision,revision>>. This will happen frequently on a
+	<<def_tracking_branch,tracking branch>> of a remote
+	<<def_repository,repository>>.
+
+[[def_fetch]]fetch::
+	Fetching a <<def_branch,branch>> means to get the
+	<<def_branch,branch>>'s <<def_head_ref,head ref>> from a remote
+	<<def_repository,repository>>, to find out which objects are missing
+	from the local <<def_object_database,object database>>, and to get them,
+	too.
+
+[[def_file_system]]file system::
+	Linus Torvalds originally designed git to be a user space file system,
+	i.e. the infrastructure to hold files and directories. That ensured the
+	efficiency and speed of git.
+
+[[def_git_archive]]git archive::
+	Synonym for <<def_repository,repository>> (for arch people).
+
+[[def_grafts]]grafts::
+	Grafts enables two otherwise different lines of development to be joined
+	together by recording fake ancestry information for commits. This way
+	you can make git pretend the set of parents a <<def_commit,commit>> has
+	is different from what was recorded when the <<def_commit,commit>> was
+	created. Configured via the `.git/info/<<def_grafts,grafts>>` file.
+
+[[def_hash]]hash::
+	In git's context, synonym to <<def_object_name,object name>>.
+
+[[def_head]]head::
+	The top of a <<def_branch,branch>>. It contains a <<def_ref,ref>> to the
+	corresponding <<def_commit_object,commit object>>.
+
+[[def_head_ref]]head ref::
+	A <<def_ref,ref>> pointing to a <<def_head,head>>. Often, this is
+	abbreviated to "<<def_head,head>>". Head refs are stored in
+	`$GIT_DIR/refs/heads/`.
+
+[[def_hook]]hook::
+	During the normal execution of several git commands, call-outs are made
+	to optional scripts that allow a developer to add functionality or
+	checking. Typically, the hooks allow for a command to be pre-verified
+	and potentially aborted, and allow for a post-notification after the
+	operation is done. The <<def_hook,hook>> scripts are found in the
+	`$GIT_DIR/hooks/` <<def_directory,directory>>, and are enabled by simply
+	making them executable.
+
+[[def_index]]index::
+	A collection of files with stat information, whose contents are stored
+	as objects. The <<def_index,index>> is a stored version of your working
+	<<def_tree,tree>>. Truth be told, it can also contain a second, and even
+	a third version of a <<def_working_tree,working tree>>, which are used
+	when merging.
+
+[[def_index_entry]]index entry::
+	The information regarding a particular file, stored in the
+	<<def_index,index>>. An <<def_index_entry,index entry>> can be unmerged,
+	if a <<def_merge,merge>> was started, but not yet finished (i.e. if the
+	<<def_index,index>> contains multiple versions of that file).
+
+[[def_master]]master::
+	The default development <<def_branch,branch>>. Whenever you create a git
+	<<def_repository,repository>>, a <<def_branch,branch>> named
+	"<<def_master,master>>" is created, and becomes the active
+	<<def_branch,branch>>. In most cases, this contains the local
 	development, though that is purely conventional and not required.
 
-merge::
-	To merge branches means to try to accumulate the changes since a
-	common ancestor and apply them to the first branch. An automatic
-	merge uses heuristics to accomplish that. Evidently, an automatic
-	merge can fail.
-
-object::
-	The unit of storage in git. It is uniquely identified by
-	the SHA1 of its contents. Consequently, an object can not
-	be changed.
-
-object database::
-	Stores a set of "objects", and an individual object is identified
-	by its object name. The objects usually live in `$GIT_DIR/objects/`.
-
-object identifier::
-	Synonym for object name.
-
-object name::
-	The unique identifier of an object. The hash of the object's contents
-	using the Secure Hash Algorithm 1 and usually represented by the 40
-	character hexadecimal encoding of the hash of the object (possibly
-	followed by a white space).
-
-object type::
-	One of the identifiers "commit","tree","tag" and "blob" describing
-	the type of an object.
-
-octopus::
-	To merge more than two branches. Also denotes an intelligent
-	predator.
-
-origin::
-	The default upstream repository. Most projects have at
-	least one upstream project which they track. By default
-	'origin' is used for that purpose.  New upstream updates
+[[def_merge]]merge::
+	To <<def_merge,merge>> branches means to try to accumulate the changes
+	since a common ancestor and apply them to the first
+	<<def_branch,branch>>. An automatic <<def_merge,merge>> uses heuristics
+	to accomplish that. Evidently, an automatic <<def_merge,merge>> can
+	fail.
+
+[[def_object]]object::
+	The unit of storage in git. It is uniquely identified by the
+	<<def_SHA1,SHA1>> of its contents. Consequently, an
+	<<def_object,object>> can not be changed.
+
+[[def_object_database]]object database::
+	Stores a set of "objects", and an individual <<def_object,object>> is
+	identified by its <<def_object_name,object name>>. The objects usually
+	live in `$GIT_DIR/objects/`.
+
+[[def_object_identifier]]object identifier::
+	Synonym for <<def_object_name,object name>>.
+
+[[def_object_name]]object name::
+	The unique identifier of an <<def_object,object>>. The <<def_hash,hash>>
+	of the <<def_object,object>>'s contents using the Secure Hash Algorithm
+	1 and usually represented by the 40 character hexadecimal encoding of
+	the <<def_hash,hash>> of the <<def_object,object>> (possibly followed by
+	a white space).
+
+[[def_object_type]]object type::
+	One of the identifiers
+	"<<def_commit,commit>>","<<def_tree,tree>>","<<def_tag,tag>>" and "blob"
+	describing the type of an <<def_object,object>>.
+
+[[def_octopus]]octopus::
+	To <<def_merge,merge>> more than two branches. Also denotes an
+	intelligent predator.
+
+[[def_origin]]origin::
+	The default upstream <<def_repository,repository>>. Most projects have
+	at least one upstream project which they track. By default
+	'<<def_origin,origin>>' is used for that purpose. New upstream updates
 	will be fetched into remote tracking branches named
-	origin/name-of-upstream-branch, which you can see using
-	"git branch -r".
+	<<def_origin,origin>>/name-of-upstream-branch, which you can see using
+	"git <<def_branch,branch>> -r".
 
-pack::
-	A set of objects which have been compressed into one file (to save
-	space or to transmit them efficiently).
+[[def_pack]]pack::
+	A set of objects which have been compressed into one file (to save space
+	or to transmit them efficiently).
 
-pack index::
+[[def_pack_index]]pack index::
 	The list of identifiers, and other information, of the objects in a
-	pack, to assist in efficiently accessing the contents of a pack.
-
-parent::
-	A commit object contains a (possibly empty) list of the logical
-	predecessor(s) in the line of development, i.e. its parents.
-
-pickaxe::
-	The term pickaxe refers to an option to the diffcore routines
-	that help select changes that add or delete a given text string.
-	With the --pickaxe-all option, it can be used to view the
-	full changeset that introduced or removed, say, a particular
-	line of text.  See gitlink:git-diff[1].
-
-plumbing::
-	Cute name for core git.
-
-porcelain::
-	Cute name for programs and program suites depending on core git,
-	presenting a high level access to core git. Porcelains expose
-	more of a SCM interface than the plumbing.
-
-pull::
-	Pulling a branch means to fetch it and merge it.
-
-push::
-	Pushing a branch means to get the branch's head ref from a remote
-	repository, find out if it is an ancestor to the branch's local
-	head ref is a direct, and in that case, putting all objects, which
-	are reachable from the local head ref, and which are missing from
-	the remote repository, into the remote object database, and updating
-	the remote head ref. If the remote head is not an ancestor to the
-	local head, the push fails.
-
-reachable::
-	All of the ancestors of a given commit are said to be reachable from
-	that commit.  More generally, one object is reachable from another if
-	we can reach the one from the other by a chain that follows tags to
-	whatever they tag, commits to their parents or trees, and trees to the
-	trees or blobs that they contain.
-
-rebase::
-	To clean a branch by starting from the head of the main line of
-	development ("master"), and reapply the (possibly cherry-picked)
-	changes from that branch.
-
-ref::
-	A 40-byte hex representation of a SHA1 or a name that denotes
-	a particular object. These may be stored in `$GIT_DIR/refs/`.
-
-refspec::
-	A refspec is used by fetch and push to describe the mapping
-	between remote ref and local ref.  They are combined with
-	a colon in the format <src>:<dst>, preceded by an optional
-	plus sign, +.  For example:
-	`git fetch $URL refs/heads/master:refs/heads/origin`
-	means "grab the master branch head from the $URL and store
-	it as my origin branch head".
-	And `git push $URL refs/heads/master:refs/heads/to-upstream`
-	means "publish my master branch head as to-upstream branch
-	at $URL".   See also gitlink:git-push[1]
-
-repository::
-	A collection of refs together with an object database containing
-	all objects, which are reachable from the refs, possibly accompanied
-	by meta data from one or more porcelains. A repository can
-	share an object database with other repositories.
-
-resolve::
-	The action of fixing up manually what a failed automatic merge
-	left behind.
-
-revision::
-	A particular state of files and directories which was stored in
-	the object database. It is referenced by a commit object.
-
-rewind::
-	To throw away part of the development, i.e. to assign the head to
-	an earlier revision.
-
-SCM::
+	<<def_pack,pack>>, to assist in efficiently accessing the contents of a
+	<<def_pack,pack>>.
+
+[[def_parent]]parent::
+	A <<def_commit_object,commit object>> contains a (possibly empty) list
+	of the logical predecessor(s) in the line of development, i.e. its
+	parents.
+
+[[def_pickaxe]]pickaxe::
+	The term <<def_pickaxe,pickaxe>> refers to an option to the diffcore
+	routines that help select changes that add or delete a given text
+	string. With the --pickaxe-all option, it can be used to view the full
+	<<def_changeset,changeset>> that introduced or removed, say, a
+	particular line of text. See gitlink:git-diff[1].
+
+[[def_plumbing]]plumbing::
+	Cute name for <<def_core_git,core git>>.
+
+[[def_porcelain]]porcelain::
+	Cute name for programs and program suites depending on
+	<<def_core_git,core git>>, presenting a high level access to
+	<<def_core_git,core git>>. Porcelains expose more of a <<def_SCM,SCM>>
+	interface than the <<def_plumbing,plumbing>>.
+
+[[def_pull]]pull::
+	Pulling a <<def_branch,branch>> means to <<def_fetch,fetch>> it and
+	<<def_merge,merge>> it.
+
+[[def_push]]push::
+	Pushing a <<def_branch,branch>> means to get the <<def_branch,branch>>'s
+	<<def_head_ref,head ref>> from a remote <<def_repository,repository>>,
+	find out if it is an ancestor to the <<def_branch,branch>>'s local
+	<<def_head_ref,head ref>> is a direct, and in that case, putting all
+	objects, which are <<def_reachable,reachable>> from the local
+	<<def_head_ref,head ref>>, and which are missing from the remote
+	<<def_repository,repository>>, into the remote
+	<<def_object_database,object database>>, and updating the remote
+	<<def_head_ref,head ref>>. If the remote <<def_head,head>> is not an
+	ancestor to the local <<def_head,head>>, the <<def_push,push>> fails.
+
+[[def_reachable]]reachable::
+	All of the ancestors of a given <<def_commit,commit>> are said to be
+	<<def_reachable,reachable>> from that <<def_commit,commit>>. More
+	generally, one <<def_object,object>> is <<def_reachable,reachable>> from
+	another if we can reach the one from the other by a <<def_chain,chain>>
+	that follows tags to whatever they <<def_tag,tag>>, commits to their
+	parents or trees, and trees to the trees or blobs that they contain.
+
+[[def_rebase]]rebase::
+	To <<def_clean,clean>> a <<def_branch,branch>> by starting from the
+	<<def_head,head>> of the main line of development
+	("<<def_master,master>>"), and reapply the (possibly cherry-picked)
+	changes from that <<def_branch,branch>>.
+
+[[def_ref]]ref::
+	A 40-byte hex representation of a <<def_SHA1,SHA1>> or a name that
+	denotes a particular <<def_object,object>>. These may be stored in
+	`$GIT_DIR/refs/`.
+
+[[def_refspec]]refspec::
+	A <<def_refspec,refspec>> is used by <<def_fetch,fetch>> and
+	<<def_push,push>> to describe the mapping between remote <<def_ref,ref>>
+	and local <<def_ref,ref>>. They are combined with a colon in the format
+	<src>:<dst>, preceded by an optional plus sign, +. For example: `git
+	<<def_fetch,fetch>> $URL
+	refs/heads/<<def_master,master>>:refs/heads/<<def_origin,origin>>` means
+	"grab the <<def_master,master>> <<def_branch,branch>> <<def_head,head>>
+	from the $URL and store it as my <<def_origin,origin>>
+	<<def_branch,branch>> <<def_head,head>>". And `git <<def_push,push>>
+	$URL refs/heads/<<def_master,master>>:refs/heads/to-upstream` means
+	"publish my <<def_master,master>> <<def_branch,branch>>
+	<<def_head,head>> as to-upstream <<def_branch,branch>> at $URL". See
+	also gitlink:git-push[1]
+
+[[def_repository]]repository::
+	A collection of refs together with an <<def_object_database,object
+	database>> containing all objects, which are <<def_reachable,reachable>>
+	from the refs, possibly accompanied by meta data from one or more
+	porcelains. A <<def_repository,repository>> can share an
+	<<def_object_database,object database>> with other repositories.
+
+[[def_resolve]]resolve::
+	The action of fixing up manually what a failed automatic
+	<<def_merge,merge>> left behind.
+
+[[def_revision]]revision::
+	A particular state of files and directories which was stored in the
+	<<def_object_database,object database>>. It is referenced by a
+	<<def_commit_object,commit object>>.
+
+[[def_rewind]]rewind::
+	To throw away part of the development, i.e. to assign the
+	<<def_head,head>> to an earlier <<def_revision,revision>>.
+
+[[def_SCM]]SCM::
 	Source code management (tool).
 
-SHA1::
-	Synonym for object name.
-
-shallow repository::
-	A shallow repository has an incomplete history some of
-	whose commits have parents cauterized away (in other
-	words, git is told to pretend that these commits do not
-	have the parents, even though they are recorded in the
-	commit object).  This is sometimes useful when you are
-	interested only in the recent history of a project even
-	though the real history recorded in the upstream is
-	much larger.  A shallow repository is created by giving
-	`--depth` option to gitlink:git-clone[1], and its
+[[def_SHA1]]SHA1::
+	Synonym for <<def_object_name,object name>>.
+
+[[def_shallow_repository]]shallow repository::
+	A <<def_shallow_repository,shallow repository>> has an incomplete
+	history some of whose commits have parents cauterized away (in other
+	words, git is told to pretend that these commits do not have the
+	parents, even though they are recorded in the <<def_commit_object,commit
+	object>>). This is sometimes useful when you are interested only in the
+	recent history of a project even though the real history recorded in the
+	upstream is much larger. A <<def_shallow_repository,shallow repository>>
+	is created by giving `--depth` option to gitlink:git-clone[1], and its
 	history can be later deepened with gitlink:git-fetch[1].
 
-symref::
-	Symbolic reference: instead of containing the SHA1 id itself, it
-	is of the format 'ref: refs/some/thing' and when referenced, it
-	recursively dereferences to this reference. 'HEAD' is a prime
-	example of a symref. Symbolic references are manipulated with
-	the gitlink:git-symbolic-ref[1] command.
-
-topic branch::
-	A regular git branch that is used by a developer to
-	identify a conceptual line of development.  Since branches
-	are very easy and inexpensive, it is often desirable to
-	have several small branches that each contain very well
-	defined concepts or small incremental yet related changes.
-
-tracking branch::
-	A regular git branch that is used to follow changes from
-	another repository.  A tracking branch should not contain
-	direct modifications or have local commits made to it.
-	A tracking branch can usually be identified as the
-	right-hand-side ref in a Pull: refspec.
-
-tree object::
-	An object containing a list of file names and modes along with refs
-	to the associated blob and/or tree objects. A tree is equivalent
-	to a directory.
-
-tree::
-	Either a working tree, or a tree object together with the
-	dependent blob and tree objects (i.e. a stored representation
-	of a working tree).
-
-tree-ish::
-	A ref pointing to either a commit object, a tree object, or a
-	tag object pointing to a tag or commit or tree object.
-
-tag object::
-	An object containing a ref pointing to another object, which can
-	contain a message just like a commit object. It can also
-	contain a (PGP) signature, in which case it is called a "signed
-	tag object".
-
-tag::
-	A ref pointing to a tag or commit object. In contrast to a head,
-	a tag is not changed by a commit. Tags (not tag objects) are
-	stored in `$GIT_DIR/refs/tags/`. A git tag has nothing to do with
-	a Lisp tag (which is called object type in git's context).
-	A tag is most typically used to mark a particular point in the
-	commit ancestry chain.
-
-unmerged index::
-	An index which contains unmerged index entries.
-
-unreachable object::
-	An object which is not reachable from a branch, tag, or any
-	other reference.
-
-working tree::
-	The set of files and directories currently being worked on,
-	i.e. you can work in your working tree without using git at all.
-
+[[def_symref]]symref::
+	Symbolic reference: instead of containing the <<def_SHA1,SHA1>> id
+	itself, it is of the format '<<def_ref,ref>>: refs/some/thing' and when
+	referenced, it recursively dereferences to this reference. 'HEAD' is a
+	prime example of a <<def_symref,symref>>. Symbolic references are
+	manipulated with the gitlink:git-symbolic-ref[1] command.
+
+[[def_tag]]tag::
+	A <<def_ref,ref>> pointing to a <<def_tag,tag>> or
+	<<def_commit_object,commit object>>. In contrast to a <<def_head,head>>,
+	a <<def_tag,tag>> is not changed by a <<def_commit,commit>>. Tags (not
+	<<def_tag,tag>> objects) are stored in `$GIT_DIR/refs/tags/`. A git
+	<<def_tag,tag>> has nothing to do with a Lisp <<def_tag,tag>> (which is
+	called <<def_object_type,object type>> in git's context). A
+	<<def_tag,tag>> is most typically used to mark a particular point in the
+	<<def_commit,commit>> ancestry <<def_chain,chain>>.
+
+[[def_tag_object]]tag object::
+	An <<def_object,object>> containing a <<def_ref,ref>> pointing to
+	another <<def_object,object>>, which can contain a message just like a
+	<<def_commit_object,commit object>>. It can also contain a (PGP)
+	signature, in which case it is called a "signed <<def_tag_object,tag
+	object>>".
+
+[[def_topic_branch]]topic branch::
+	A regular git <<def_branch,branch>> that is used by a developer to
+	identify a conceptual line of development. Since branches are very easy
+	and inexpensive, it is often desirable to have several small branches
+	that each contain very well defined concepts or small incremental yet
+	related changes.
+
+[[def_tracking_branch]]tracking branch::
+	A regular git <<def_branch,branch>> that is used to follow changes from
+	another <<def_repository,repository>>. A <<def_tracking_branch,tracking
+	branch>> should not contain direct modifications or have local commits
+	made to it. A <<def_tracking_branch,tracking branch>> can usually be
+	identified as the right-hand-side <<def_ref,ref>> in a Pull:
+	<<def_refspec,refspec>>.
+
+[[def_tree]]tree::
+	Either a <<def_working_tree,working tree>>, or a <<def_tree_object,tree
+	object>> together with the dependent blob and <<def_tree,tree>> objects
+	(i.e. a stored representation of a <<def_working_tree,working tree>>).
+
+[[def_tree_object]]tree object::
+	An <<def_object,object>> containing a list of file names and modes along
+	with refs to the associated blob and/or <<def_tree,tree>> objects. A
+	<<def_tree,tree>> is equivalent to a <<def_directory,directory>>.
+
+[[def_tree-ish]]tree-ish::
+	A <<def_ref,ref>> pointing to either a <<def_commit_object,commit
+	object>>, a <<def_tree_object,tree object>>, or a <<def_tag_object,tag
+	object>> pointing to a <<def_tag,tag>> or <<def_commit,commit>> or
+	<<def_tree_object,tree object>>.
+
+[[def_unmerged_index]]unmerged index::
+	An <<def_index,index>> which contains <<def_unmerged_index,unmerged
+	index>> entries.
+
+[[def_unreachable_object]]unreachable object::
+	An <<def_object,object>> which is not <<def_reachable,reachable>> from a
+	<<def_branch,branch>>, <<def_tag,tag>>, or any other reference.
+
+[[def_working_tree]]working tree::
+	The set of files and directories currently being worked on, i.e. you can
+	work in your <<def_working_tree,working tree>> without using git at all.
diff --git a/Documentation/sort_glossary.pl b/Documentation/sort_glossary.pl
deleted file mode 100644
index 4ae6290..0000000
--- a/Documentation/sort_glossary.pl
+++ /dev/null
@@ -1,69 +0,0 @@
-#!/usr/bin/perl
-
-%terms=();
-
-while(<>) {
-	if(/^(\S.*)::$/) {
-		my $term=$1;
-		if(defined($terms{$term})) {
-			die "$1 defined twice\n";
-		}
-		$terms{$term}="";
-		LOOP: while(<>) {
-			if(/^$/) {
-				last LOOP;
-			}
-			if(/^	\S/) {
-				$terms{$term}.=$_;
-			} else {
-				die "Error 1: $_";
-			}
-		}
-	}
-}
-
-sub format_tab_80 ($) {
-	my $text=$_[0];
-	my $result="";
-	$text=~s/\s+/ /g;
-	$text=~s/^\s+//;
-	while($text=~/^(.{1,72})(|\s+(\S.*)?)$/) {
-		$result.="	".$1."\n";
-		$text=$3;
-	}
-	return $result;
-}
-
-sub no_spaces ($) {
-	my $result=$_[0];
-	$result=~tr/ /_/;
-	return $result;
-}
-
-print 'GIT Glossary
-============
-
-This list is sorted alphabetically:
-
-';
-
-@keys=sort {uc($a) cmp uc($b)} keys %terms;
-$pattern='(\b(?<!link:git-)'.join('\b|\b(?<!-)',reverse @keys).'\b)';
-foreach $key (@keys) {
-	$terms{$key}=~s/$pattern/sprintf "<<def_".no_spaces($1).",$1>>";/eg;
-	print '[[def_'.no_spaces($key).']]'.$key."::\n"
-		.format_tab_80($terms{$key})."\n";
-}
-
-print '
-
-Author
-------
-Written by Johannes Schindelin <Johannes.Schindelin@gmx.de> and
-the git-list <git@vger.kernel.org>.
-
-GIT
----
-Part of the link:git.html[git] suite
-';
-
diff --git a/Documentation/user-manual.txt b/Documentation/user-manual.txt
index 773f65e..6df5e61 100644
--- a/Documentation/user-manual.txt
+++ b/Documentation/user-manual.txt
@@ -3013,9 +3013,6 @@ confusing and scary messages, but it won't actually do anything bad. In
 contrast, running "git prune" while somebody is actively changing the 
 repository is a *BAD* idea).
 
-Glossary of git terms
-=====================
-
 include::glossary.txt[]
 
 Notes and todo list for this manual
-- 
1.5.0.3.31.ge47c
