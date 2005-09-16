From: Matthias Urlichs <smurf@smurf.noris.de>
Subject: [PATCH/RFC] Build a shared / renamed / "stable" version of the library?
Date: Fri, 16 Sep 2005 14:37:17 +0200
Organization: {M:U} IT Consulting
Message-ID: <pan.2005.09.16.12.37.14.736570@smurf.noris.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-From: git-owner@vger.kernel.org Fri Sep 16 14:43:46 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1EGFWf-0004dP-LF
	for gcvg-git@gmane.org; Fri, 16 Sep 2005 14:41:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161049AbVIPMkv (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 16 Sep 2005 08:40:51 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161067AbVIPMkv
	(ORCPT <rfc822;git-outgoing>); Fri, 16 Sep 2005 08:40:51 -0400
Received: from main.gmane.org ([80.91.229.2]:44439 "EHLO ciao.gmane.org")
	by vger.kernel.org with ESMTP id S1161049AbVIPMku (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 16 Sep 2005 08:40:50 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1EGFUW-00042K-0l
	for git@vger.kernel.org; Fri, 16 Sep 2005 14:38:56 +0200
Received: from run.smurf.noris.de ([192.109.102.41])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 14:38:55 +0200
Received: from smurf by run.smurf.noris.de with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Fri, 16 Sep 2005 14:38:55 +0200
X-Injected-Via-Gmane: http://gmane.org/
To: git@vger.kernel.org
X-Complaints-To: usenet@sea.gmane.org
X-Gmane-NNTP-Posting-Host: run.smurf.noris.de
User-Agent: Pan/0.14.2.91 (As She Crawled Across the Table)
X-Face: '&-&kxR\8+Pqalw@VzN\p?]]eIYwRDxvrwEM<aSTmd'\`f#k`zKY&P_QuRa4EG?;#/TJ](:XL6B!-=9nyC9o<xEx;trRsW8nSda=-b|;BKZ=W4:TO$~j8RmGVMm-}8w.1cEY$X<B2+(x\yW1]Cn}b:1b<$;_?1%QKcvOFonK.7l[cos~O]<Abu4f8nbL15$"1W}y"5\)tQ1{HRR?t015QK&v4j`WaOue^'I)0d,{v*N1O
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/8680>

Build (and use) libgit.so instead of libgit.a.

--- 

I have written this nice Python extension that gives me fast access to
git objects. Python extensions are built as shared libraries. Linking
shared and non-shared objects into one library results in a couple of
linker warnings on i386; other architectures are far less forgiving.

So the best choice I seem to have is to build a shared libgit.so.

Unfortunately, libgit doesn't have nice symbol names. I dunno how you
all would feel about a big patch which renames absoutely every foo()
function in libgit to be git_foo() instead (or one that #ifdef's them)...
so I'm taking the easy way out, and use versioned symbols. That should
prevent symbol name conflicts with other libraries.

I've had to redefine usage(), error() and die() to git_*(), because
they're just too conflict-ish. "error" is even a weak symbol in libc. :-/

To summarize, the choices seem to be:
- don't do anything => no script language extensions, need to fork off
  a git program for absolutely everything. Bah.
- build libgit.a with -fpic'd objects => doesn't work on all
  architectures.
- build libgit.shared.a and use that for building script language
  extensions => works now, but may cause name conflicts down the road.
- build a "normal" libgit.so => ditto on the name conflicts.
- build a libgit.so with symbol versions => no name conflicts expected,
  but works only with the GNU linker.
- rename all library functions and globals => quite a bit of work,
  and more typing down the road.
- add "#define foo git_foo" to all library functions => ugly.

Opinions?

diff --git a/Makefile b/Makefile
--- a/Makefile
+++ b/Makefile
@@ -47,6 +47,8 @@ ALL_CFLAGS = $(CFLAGS) $(PLATFORM_DEFINE
 
 prefix = $(HOME)
 bindir = $(prefix)/bin
+libdir = $(prefix)/lib
+incdir = $(prefix)/include
 template_dir = $(prefix)/share/git-core/templates/
 GIT_PYTHON_DIR = $(prefix)/share/git-core/python
 # DESTDIR=
@@ -142,7 +144,18 @@ LIB_OBJS = \
 	server-info.o setup.o sha1_file.o sha1_name.o strbuf.o \
 	tag.o tree.o usage.o $(DIFF_OBJS)
 
-LIBS = $(LIB_FILE)
+ifdef SHARED_LIBOBJ
+
+LIB_FILE=libgit.so
+GITLIB = -L. -lgit
+
+else
+
+LIB_FILE=libgit.a
+GITLIB = $(LIB_FILE)
+
+endif
+
 LIBS += -lz
 
 ifeq ($(shell uname -s),Darwin)
@@ -167,6 +180,7 @@ endif
 ifndef NO_OPENSSL
 	LIB_OBJS += epoch.o
 	OPENSSL_LIBSSL = -lssl
+	LIBS += -lssl
 else
 	DEFINES += '-DNO_OPENSSL'
 	MOZILLA_SHA1 = 1
@@ -242,7 +256,7 @@ $(patsubst %.py,%,$(SCRIPT_PYTHON)) : % 
 	$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 
 git-%: %.o $(LIB_FILE)
-	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(LIBS)
+	$(CC) $(ALL_CFLAGS) -o $@ $(filter %.o,$^) $(GITLIB) $(LIBS)
 
 git-mailinfo : SIMPLE_LIB += $(LIB_4_ICONV)
 $(SIMPLE_PROGRAMS) : $(LIB_FILE)
@@ -267,9 +281,33 @@ $(LIB_OBJS): $(LIB_H)
 $(patsubst git-%,%.o,$(PROGRAMS)): $(LIB_H)
 $(DIFF_OBJS): diffcore.h
 
+# Use -fPIC for the library files so they may be linked into a shared
+# library if necessary
+#
+ifdef SHARED_LIBOBJ
+
+PIC=-fpic
+
+$(LIB_FILE): $(LIB_OBJS) libgit.vers
+	$(CC) -shared -Wl,-soname,$(SHARED_LIBOBJ) -Wl,--version-script=libgit.vers -o $@ $(LIB_OBJS) $(LIBS)
+	rm -f $(SHARED_LIBOBJ) && ln -s $(LIB_FILE) $(SHARED_LIBOBJ)
+
+else # "normal" library
+
+PIC=
+
 $(LIB_FILE): $(LIB_OBJS)
 	$(AR) rcs $@ $(LIB_OBJS)
 
+endif
+
+# Declare rules for building library files.
+define lib_rule
+$1.o: $1.c
+	$(CC) $(ALL_CFLAGS) $(PIC) -c -o $1.o $1.c
+endef
+$(foreach obj,$(basename $(LIB_OBJS)),$(eval $(call lib_rule, $(obj))))
+
 doc:
 	$(MAKE) -C Documentation all
 
@@ -300,6 +338,14 @@ install: $(PROGRAMS) $(SCRIPTS)
 	$(MAKE) -C templates install
 	$(INSTALL) -d -m755 $(DESTDIR)$(GIT_PYTHON_DIR)
 	$(INSTALL) $(PYMODULES) $(DESTDIR)$(GIT_PYTHON_DIR)
+ifdef SHARED_LIBOBJ
+	$(INSTALL) -m755 -d $(DESTDIR)$(libdir)
+	$(INSTALL) -m755 $(LIB_FILE) $(DESTDIR)$(libdir)/$(SHARED_LIBOBJ)
+	cd $(DESTDIR)$(libdir) && ln -sf $(SHARED_LIBOBJ) $(LIB_FILE)
+	$(INSTALL) -m755 -d $(DESTDIR)$(incdir)
+	$(INSTALL) -m755 -d $(DESTDIR)$(incdir)/git
+	$(INSTALL) -m644 $(LIB_H) $(DESTDIR)$(incdir)/git
+endif
 
 install-doc:
 	$(MAKE) -C Documentation install
@@ -333,7 +379,7 @@ deb: dist
 ### Cleaning rules
 
 clean:
-	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROGRAMS) $(LIB_FILE)
+	rm -f *.o mozilla-sha1/*.o ppc/*.o $(PROGRAMS) *.a *.so *.so.*
 	rm -f $(filter-out gitk,$(SCRIPTS))
 	rm -f git-core.spec
 	rm -rf $(GIT_TARNAME)
diff --git a/cache.h b/cache.h
--- a/cache.h
+++ b/cache.h
@@ -228,6 +228,9 @@ extern int get_sha1_hex(const char *hex,
 extern char *sha1_to_hex(const unsigned char *sha1);	/* static buffer result! */
 
 /* General helper functions */
+#define usage git_usage
+#define error git_error
+#define die git_die
 extern void usage(const char *err) NORETURN;
 extern void die(const char *err, ...) NORETURN __attribute__((format (printf, 1, 2)));
 extern int error(const char *err, ...) __attribute__((format (printf, 1, 2)));
diff --git a/debian/changelog b/debian/changelog
--- a/debian/changelog
+++ b/debian/changelog
@@ -1,3 +1,10 @@
+git-core (0.99.6-2) unstable; urgency=low
+
+  * Install a shared libgit.so
+  * Install development files (git-dev package)
+
+ -- Matthias Urlichs <smurf@debian.org>  Wed, 14 Sep 2005 09:04:57 +0200
+
 git-core (0.99.6-0) unstable; urgency=low
 
   * GIT 0.99.6
diff --git a/debian/control b/debian/control
--- a/debian/control
+++ b/debian/control
@@ -18,9 +18,22 @@ Description: The git content addressable
  enables human beings to work with the database in a manner to a degree
  similar to other SCM tools.
 
+Package: libgit1
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}
+Description: The git content addressable filesystem, shared library
+ This package contains the shared library for git.
+
 Package: git-tk
 Architecture: all
 Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, tk8.4
 Description: The git content addressable filesystem, GUI add-on
  This package contains 'gitk', the git revision tree visualizer.
 
+Package: git-dev
+Architecture: any
+Depends: ${shlibs:Depends}, ${misc:Depends}, git-core, tk8.4
+Description: The git content addressable filesystem, development files
+ This package contains the files needed to build programs which access
+ the git library.
+
diff --git a/debian/git-core.files b/debian/git-core.files
--- a/debian/git-core.files
+++ b/debian/git-core.files
@@ -1 +1,3 @@
-/usr
+/usr/bin
+/usr/share
+/usr/lib/*.so.*
diff --git a/debian/git-dev.files b/debian/git-dev.files
new file mode 100644
--- /dev/null
+++ b/debian/git-dev.files
@@ -0,0 +1,2 @@
+/usr/include/git
+/usr/lib/*.so
diff --git a/debian/libgit1.files b/debian/libgit1.files
new file mode 100644
--- /dev/null
+++ b/debian/libgit1.files
@@ -0,0 +1 @@
+/usr/lib/libgit.so.1
diff --git a/debian/rules b/debian/rules
--- a/debian/rules
+++ b/debian/rules
@@ -25,6 +25,9 @@ else
 	export MOZILLA_SHA1=YesPlease
 endif
 
+# build libgit.a with shared objects
+export SHARED_LIBOBJ=libgit.so.1
+
 # We do have the requisite perl modules in the mainline, and
 # have no reason to shy away from this script.
 export WITH_SEND_EMAIL=YesPlease
@@ -60,11 +63,13 @@ install: build
 	dh_installdirs 
 
 	make DESTDIR=$(DESTDIR) prefix=$(PREFIX) mandir=$(MANDIR) \
-		install install-doc
+		install # install-doc
 
 	mkdir -p $(DOC_DESTDIR)
 	find $(DOC) '(' -name '*.txt' -o -name '*.html' ')' -exec install {} $(DOC_DESTDIR) ';'
 
+	dh_movefiles -p libgit1
+	dh_movefiles -p git-dev
 	dh_movefiles -p git-tk
 	dh_movefiles -p git-core
 	find debian/tmp -type d -o -print | sed -e 's/^/? /'
diff --git a/libgit.vers b/libgit.vers
new file mode 100644
--- /dev/null
+++ b/libgit.vers
@@ -0,0 +1,195 @@
+GIT_1 {
+	global:
+		add_cache_entry ;
+		add_packed_git ;
+		add_ref ;
+		alloc_filespec ;
+		base_name_compare ;
+		blob_type ;
+		cache_name_compare ;
+		cache_name_pos ;
+		ce_match_stat ;
+		ce_path_match ;
+		ce_same_name ;
+		checkout_entry ;
+		check_ref_format ;
+		check_sha1_signature ;
+		commit_index_file ;
+		commit_list_insert ;
+		commit_type ;
+		count_delta ;
+		count_parents ;
+		created_object ;
+		deref_tag ;
+		diff_addremove ;
+		diff_change ;
+		diffcore_break ;
+		diffcore_merge_broken ;
+		diffcore_order ;
+		diffcore_pathspec ;
+		diffcore_pickaxe ;
+		diffcore_rename ;
+		diffcore_std ;
+		diffcore_std_no_resolve ;
+		diff_delta ;
+		diff_flush ;
+		diff_free_filepair ;
+		diff_free_filespec ;
+		diff_helper_input ;
+		diff_populate_filespec ;
+		diff_q ;
+		diff_queue ;
+		diff_queue_is_empty ;
+		diff_scoreopt_parse ;
+		diff_setup ;
+		diff_unmerge ;
+		diff_unmodified_pair ;
+		fill_filespec ;
+		fill_stat_cache_info ;
+		find_pack_entry_one ;
+		find_rev_cache ;
+		find_sha1_pack ;
+		finish_connect ;
+		for_each_ref ;
+		free_commit_list ;
+		get_ack ;
+		get_commit_format ;
+		get_graft_file ;
+		get_ident ;
+		get_index_file ;
+		get_object_directory ;
+		get_pathspec ;
+		get_refs_directory ;
+		get_ref_sha1 ;
+		get_remote_heads ;
+		get_sha1 ;
+		get_sha1_hex ;
+		git_author_info ;
+		git_committer_info ;
+		git_connect ;
+		git_mkstemp ;
+		git_path ;
+		has_pack_file ;
+		has_pack_index ;
+		has_sha1_file ;
+		has_sha1_pack ;
+		head_ref ;
+		hold_index_file_for_update ;
+		index_fd ;
+		insert_by_date ;
+		install_packed_git ;
+		lock_ref_sha1 ;
+		lookup_blob ;
+		lookup_commit ;
+		lookup_commit_reference ;
+		lookup_commit_reference_gently ;
+		lookup_object ;
+		lookup_object_type ;
+		lookup_tag ;
+		lookup_tree ;
+		lookup_unknown_object ;
+		mark_reachable ;
+		match_refs ;
+		mkpath ;
+		nth_packed_object_sha1 ;
+		num_packed_objects ;
+		object_list_append ;
+		object_list_contains ;
+		object_list_insert ;
+		object_list_length ;
+		packed_object_info_detail ;
+		packet_flush ;
+		packet_read_line ;
+		packet_write ;
+		parse_blob ;
+		parse_blob_buffer ;
+		parse_commit ;
+		parse_commit_buffer ;
+		parse_date ;
+		parse_object ;
+		parse_pack_index ;
+		parse_pack_index_file ;
+		parse_sha1_header ;
+		parse_tag ;
+		parse_tag_buffer ;
+		parse_tree ;
+		parse_tree_buffer ;
+		parse_tree_indirect ;
+		patch_delta ;
+		path_match ;
+		pop_commit ;
+		pop_most_recent_commit ;
+		prefix_path ;
+		prepare_alt_odb ;
+		prepare_packed_git ;
+		pretty_print_commit ;
+		read_cache ;
+		read_line ;
+		read_object_with_reference ;
+		read_rev_cache ;
+		read_sha1_file ;
+		read_tree ;
+		record_rev_cache ;
+		remove_cache_entry_at ;
+		remove_file_from_cache ;
+		rollback_index_file ;
+		run_command ;
+		run_command_v ;
+		safe_create_leading_directories ;
+		safe_strncpy ;
+		setup_git_directory ;
+		setup_ident ;
+		sha1close ;
+		sha1create ;
+		sha1fd ;
+		sha1_file_name ;
+		SHA1_Final ;
+		SHA1_Init ;
+		sha1_object_info ;
+		sha1_pack_index_name ;
+		sha1_pack_name ;
+		sha1_to_hex ;
+		SHA1_Update ;
+		sha1write ;
+		sha1write_compressed ;
+		show_date ;
+		sort_by_date ;
+		sort_in_topological_order ;
+		sort_list_in_merge_order ;
+		sq_quote ;
+		strbuf_init ;
+		tag_type ;
+		tree_type ;
+		unpack_entry_gently ;
+		unpack_sha1_file ;
+		unpack_sha1_header ;
+		unuse_packed_git ;
+		update_server_info ;
+		use_packed_git ;
+		verify_pack ;
+		write_cache ;
+		write_ref_sha1 ;
+		write_ref_sha1_unlocked ;
+		write_rev_cache ;
+		write_sha1_file ;
+		write_sha1_file_prepare ;
+		write_sha1_from_fd ;
+		write_sha1_to_fd ;
+		active_alloc ;
+		active_cache ;
+		active_cache_changed ;
+		active_nr ;
+		nr_objs ;
+		objs ;
+		alloc_revs ;
+		nr_revs ;
+		rev_cache ;
+		alt_odb_list ;
+		packed_git ;
+		diff_queued_diff ;
+		git_die ;
+		git_usage ;
+		git_error ;
+	local:
+		*;
+};
diff --git a/t/Makefile b/t/Makefile
--- a/t/Makefile
+++ b/t/Makefile
@@ -8,7 +8,9 @@
 T = $(wildcard t[0-9][0-9][0-9][0-9]-*.sh)
 
 all:
-	@$(foreach t,$T,echo "*** $t ***"; sh $t $(GIT_TEST_OPTS) || exit; )
+	@$(foreach t,$T,echo "*** $t ***"; \
+	env LD_LIBRARY_PATH=$$(pwd)/..:$$LD_LIBRARY_PATH \
+	sh $t $(GIT_TEST_OPTS) || exit; )
 	@rm -fr trash
 
 clean:
-- 
Matthias Urlichs   |   {M:U} IT Design @ m-u-it.de   |  smurf@smurf.noris.de
Disclaimer: The quote was selected randomly. Really. | http://smurf.noris.de
 - -
Don't send my boy to Harvard, the dying mother said. Don't send my boy to
Harvard, I'd rather see him dead.
