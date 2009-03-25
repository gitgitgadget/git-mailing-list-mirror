From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH 5/5] p4 example of git-vcs API for fetch direction
Date: Tue, 24 Mar 2009 23:04:19 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0903242303500.19665@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Mar 25 04:05:59 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LmJRE-00061j-CI
	for gcvg-git-2@gmane.org; Wed, 25 Mar 2009 04:05:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757198AbZCYDE1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Mar 2009 23:04:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756067AbZCYDE0
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Mar 2009 23:04:26 -0400
Received: from iabervon.org ([66.92.72.58]:43760 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757174AbZCYDEX (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Mar 2009 23:04:23 -0400
Received: (qmail 11100 invoked by uid 1000); 25 Mar 2009 03:04:19 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Mar 2009 03:04:19 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/114547>

---
 Documentation/git-vcs-p4.txt |   33 ++
 Makefile                     |   25 +
 p4-notes                     |   33 ++
 vcs-p4/p4client-api.cc       |  169 ++++++
 vcs-p4/p4client.c            |  137 +++++
 vcs-p4/p4client.h            |   38 ++
 vcs-p4/vcs-p4.c              | 1229 ++++++++++++++++++++++++++++++++++++++++++
 vcs-p4/vcs-p4.h              |  128 +++++
 8 files changed, 1792 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 p4-notes
 create mode 100644 vcs-p4/p4client-api.cc
 create mode 100644 vcs-p4/p4client.c
 create mode 100644 vcs-p4/p4client.h
 create mode 100644 vcs-p4/vcs-p4.c
 create mode 100644 vcs-p4/vcs-p4.h

diff --git a/Documentation/git-vcs-p4.txt b/Documentation/git-vcs-p4.txt
new file mode 100644
index 0000000..4039d24
--- /dev/null
+++ b/Documentation/git-vcs-p4.txt
@@ -0,0 +1,33 @@
+Config
+------
+
+vcs-p4.port::
+	The value to use for P4PORT
+
+vcs-p4.client::
+	The value to use for P4CLIENT
+
+vcs-p4.codelineformat::
+	A regular expression to match valid codelines; a codeline is a
+	directory that contains exactly those files that belong to a
+	version of a project. Importing history with integrations will
+	generally discover codelines not explicitly marked to be
+	imported, found when a file in a known codeline, whose full
+	path is therefore the codeline path plus a relative path, is
+	integrated from a file with a name that ends with that
+	relative path. However, files will sometimes be integrated
+	from non-codelines (that is, from a directory that contains
+	unrelated files whose history should not be tracked), and this
+	option can be used to ignore some directories.
+
+	Note that, properly, the history of the individual files from
+	a non-codeline which got integrated into a codeline should
+	contribute but that this is not presently supported.
+
+remotes.*.url::
+	The perforce location of a codeline to track. Other codelines
+	may be discovered by git-vcs-p4, but it will make no attempt
+	to get versions in these locations more recent than the last
+	versions that contribute at present to the tracked codelines,
+	and it will not make them available for matching in "fetch"
+	patterns.
diff --git a/Makefile b/Makefile
index 43a8364..b148b34 100644
--- a/Makefile
+++ b/Makefile
@@ -320,6 +320,7 @@ PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-vcs-p4$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
@@ -1106,6 +1107,7 @@ endif
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
 	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_CXX      = @echo '   ' CXX $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
@@ -1288,12 +1290,16 @@ git.o git.spec \
 	$(patsubst %.perl,%,$(SCRIPT_PERL)) \
 	: GIT-VERSION-FILE
 
+vcs-p4/%.o: ALL_CFLAGS += -I.
+
 %.o: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
 %.s: %.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -S $(ALL_CFLAGS) $<
 %.o: %.S
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) $<
+%.o: %.cc GIT-CFLAGS
+	$(QUIET_CXX)$(CXX) -o $*.o -c $(ALL_CFLAGS) $<
 
 exec_cmd.o: exec_cmd.c GIT-CFLAGS
 	$(QUIET_CC)$(CC) -o $*.o -c $(ALL_CFLAGS) \
@@ -1329,6 +1335,24 @@ git-http-push$X: revision.o http.o http-push.o $(GITLIBS)
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
+P4API_BASE=/home/barkalow/stuff/p4api-2008.1.158777
+
+ifdef P4API_BASE
+P4_IMPL=p4client-api
+
+vcs-p4/p4client-api.o: ALL_CFLAGS += -I$(P4API_BASE)/include
+P4_LINK=$(CXX)
+P4LIBS=-L$(P4API_BASE)/lib -lclient -lrpc -lsupp
+else
+P4_IMPL=p4client
+P4_LINK=$(CC)
+endif
+
+git-vcs-p4$X: LIBS += $(P4LIBS)
+git-vcs-p4$X: vcs-p4/vcs-p4.o vcs-p4/$(P4_IMPL).o $(GITLIBS)
+	$(QUIET_LINK)$(P4_LINK) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)): $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
@@ -1583,6 +1607,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o xdiff/*.o \
+		vcs-p4/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
diff --git a/p4-notes b/p4-notes
new file mode 100644
index 0000000..bd95903
--- /dev/null
+++ b/p4-notes
@@ -0,0 +1,33 @@
+People using branches in p4 work like svn, except that the branches
+are not rooted at predictable places. Furthermore, there is not a
+uniform tree layout within a depot.
+
+Therefore, in order to generate a git repository from p4, it is
+necessary to specify a root within the depot as the working tree root
+in git. On the other hand, it should be possible to determine from the
+p4 history what portions of the depot outside of the root should be
+considered as branches, as it tracks "integrations".
+
+In theory, anyway, it should even be possible to produce a git
+repository with submodules when a similar thing has been done with
+integrations in p4, by determining that there are integrations into a
+subdirectory of the root.
+
+---
+
+Overview of operation:
+
+ - Allocate codeline
+ - Import codeline
+   - use p4_filelog to find the files and their revisions in the codeline
+   - For each file,
+
+---
+Saving processed state
+
+ - Record for each codeline
+   - What are all the changesets?
+
+ - Record for each codeline/changeset
+   - What's the commit
+
diff --git a/vcs-p4/p4client-api.cc b/vcs-p4/p4client-api.cc
new file mode 100644
index 0000000..df8b606
--- /dev/null
+++ b/vcs-p4/p4client-api.cc
@@ -0,0 +1,169 @@
+extern "C" {
+#include "p4client.h"
+}
+
+#include <p4/clientapi.h>
+
+class VCSClientUser : public ClientUser {
+  virtual void OutputInfo(char level, const char *data);
+  virtual void OutputBinary(const char *data, int length);
+  virtual void OutputText(const char *data, int length);
+public:
+  void *data;
+  void (*info_cb)(void *, int, const char *);
+  void (*form_cb)(void *, const char *, const char *);
+
+  void (*buffer_cb)(void *, const char *buffer, int length);
+
+  void clear() {
+    info_cb = NULL;
+    form_cb = NULL;
+    buffer_cb = NULL;
+  }
+};
+
+static ClientApi client;
+static VCSClientUser ui;
+
+void p4_init(const char *const *env)
+{
+  Error e;
+  StrBuf msg;
+
+  while (*env) {
+    if (!strncmp(*env, "P4PORT=", 7))
+      client.SetPort((*env) + 7);
+    env++;
+  }
+
+  client.Init(&e);
+  if (e.Test()) {
+    e.Fmt(&msg);
+    fprintf(stderr, msg.Text());
+    exit(1);
+  }
+}
+
+void VCSClientUser::OutputBinary(const char *buffer, int length)
+{
+  if (buffer_cb) {
+    buffer_cb(data, buffer, length);
+  } else
+    fprintf(stderr, "Unexpected binary of length %d\n", length);
+}
+
+void VCSClientUser::OutputText(const char *buffer, int length)
+{
+  if (buffer_cb) {
+    buffer_cb(data, buffer, length);
+  } else
+    fprintf(stderr, "Unexpected text of length %d\n", length);
+}
+
+void VCSClientUser::OutputInfo(char level, const char *line)
+{
+  if (info_cb)
+    info_cb(data, level - '0', line);
+  else if (form_cb) {
+    struct strbuf key;
+    struct strbuf value;
+
+    strbuf_init(&key, 0);
+    strbuf_init(&value, 0);
+
+    const char *eol = NULL;
+    for (; *line; line = eol + 1) {
+      const char *eok;
+
+      eol = strchr(line, '\n');
+      if (!eol)
+	break;
+      if (eol == line || line[0] == '#')
+	continue;
+      eok = strchr(line, ':');
+      if (!eok)
+	continue;
+      strbuf_reset(&key);
+      strbuf_reset(&value);
+      strbuf_add(&key, line, eok - line);
+      if (eok[1] == '\t') {
+	strbuf_add(&value, eok + 2, eol - (eok + 2));
+      } else if (eok[1] == '\n') {
+	for (line = eol + 1; *line && line[0] != '\n'; line = eol + 1) {
+	  eol = strchr(line, '\n');
+	  strbuf_add(&value, line + 1, eol - (line + 1) + 1);
+	}
+      }
+      form_cb(data, key.buf, value.buf);
+    }
+    strbuf_release(&key);
+    strbuf_release(&value);
+  } else
+    fprintf(stderr, "Unexpected info: %c ... %s\n", level, line);
+}
+
+int p4_call(int fds[], const char *arg0, int argc, char *const *argv)
+{
+  ui.data = NULL;
+  ui.clear();
+  client.SetArgv(argc, argv);
+  client.Run(arg0, &ui);
+  p4_fini();
+  exit(1);
+  return 0;
+}
+
+int _p4_call_info(const char *arg0, int argc, char *const *argv,
+		  void *data,
+		  void (*cb)(void *data, int level, const char *line))
+{
+  ui.clear();
+  ui.data = data;
+  ui.info_cb = cb;
+  client.SetArgv(argc, argv);
+  client.Run(arg0, &ui);
+  return 0;
+}
+
+int _p4_call_form(const char *arg0, int argc, char *const *argv,
+		  void *data,
+		  void (*cb)(void *data, const char *key, const char *value))
+{
+  ui.clear();
+  ui.data = data;
+  ui.form_cb = cb;
+  client.SetArgv(argc, argv);
+  client.Run(arg0, &ui);
+  return 0;
+}
+
+int _p4_call_buffer(const char *arg0, int argc, char *const *argv,
+		    void *data,
+		    void (*cb)(void *data, const char *buffer, int length))
+{
+  ui.clear();
+  ui.data = data;
+  ui.buffer_cb = cb;
+  client.SetArgv(argc, argv);
+  client.Run(arg0, &ui);
+  return 0;
+}
+
+int p4_complete()
+{
+  return 0;
+}
+
+int p4_fini()
+{
+  Error e;
+  StrBuf msg;
+
+  client.Final(&e);
+  if (e.Test()) {
+    e.Fmt(&msg);
+    fprintf(stderr, msg.Text());
+    exit(1);
+  }
+  return 0;
+}
diff --git a/vcs-p4/p4client.c b/vcs-p4/p4client.c
new file mode 100644
index 0000000..96ccdf9
--- /dev/null
+++ b/vcs-p4/p4client.c
@@ -0,0 +1,137 @@
+#include "p4client.h"
+
+#include "cache.h"
+#include "run-command.h"
+
+static const char *const *envp;
+
+void p4_init(const char *const *env)
+{
+	envp = env;
+}
+
+static struct child_process child;
+
+int p4_call(int fds[], const char *arg0, int argc, char *const *argv)
+{
+	int i;
+	memset(&child, 0, sizeof(child));
+	if (fds) {
+		child.in = -1;
+		child.out = -1;
+	} else {
+		child.no_stdin = 1;
+		child.no_stdout = 1;
+	}
+	child.err = 0;
+	child.argv = xcalloc(argc + 3, sizeof(*argv));
+	child.argv[0] = "p4";
+	child.argv[1] = arg0;
+	child.env = envp;
+	for (i = 0; i < argc; i++)
+		child.argv[i + 2] = argv[i];
+	child.argv[argc + 2] = NULL;
+	start_command(&child);
+	if (fds) {
+		fds[0] = child.in;
+		fds[1] = child.out;
+	}
+	return 0;
+}
+
+int _p4_call_info(const char *arg0, int argc, char *const *argv, void *data,
+		  void (*cb)(void *data, int level, const char *line))
+{
+	int fds[2];
+	struct strbuf line;
+	FILE *input;
+
+	if (p4_call(fds, arg0, argc, argv))
+		return -1;
+
+	strbuf_init(&line, 0);
+	input = fdopen(fds[1], "r");
+	while (!strbuf_getline(&line, input, '\n')) {
+		int level = 0;
+		char *posn = line.buf;
+		while (!prefixcmp(posn, "... ")) {
+			posn += 4;
+			level++;
+		}
+		cb(data, level, posn);
+	}
+	p4_complete();
+	return 0;
+}
+
+int _p4_call_form(const char *arg0, int argc, char *const *argv, void *data,
+		  void (*cb)(void *data, const char *key, const char *value))
+{
+	int fds[2];
+	struct strbuf line;
+	struct strbuf key;
+	struct strbuf value;
+	FILE *input;
+
+	if (p4_call(fds, arg0, argc, argv))
+		return -1;
+
+	strbuf_init(&line, 0);
+	strbuf_init(&key, 0);
+	strbuf_init(&value, 0);
+	input = fdopen(fds[1], "r");
+	for (; !strbuf_getline(&line, input, '\n'); strbuf_reset(&line)) {
+		const char *eok;
+
+		if (!line.buf[0] || line.buf[0] == '#')
+			continue;
+		eok = strchr(line.buf, ':');
+		if (!eok)
+			continue;
+		strbuf_reset(&key);
+		strbuf_reset(&value);
+		strbuf_add(&key, line.buf, eok - line.buf);
+		if (eok[1] == '\t')
+			strbuf_addstr(&value, eok + 2);
+		else {
+			strbuf_reset(&line);
+			while (!strbuf_getline(&line, input, '\n') && line.len) {
+				strbuf_addstr(&value, line.buf + 1);
+				strbuf_addch(&value, '\n');
+				strbuf_reset(&line);
+			}
+		}
+		cb(data, key.buf, value.buf);
+	}
+	p4_complete();
+	return 0;
+}
+
+int _p4_call_buffer(const char *arg0, int argc, char *const *argv, void *data,
+		    void (*cb)(void *data, const char *buffer, int len))
+{
+	int fds[2];
+	struct strbuf block;
+	if (p4_call(fds, arg0, argc, argv))
+		return -1;
+	strbuf_init(&block, 0);
+	strbuf_read(&block, fds[1], 0);
+	cb(data, block.buf, block.len);
+	p4_complete();
+	return 0;
+}
+
+int p4_complete(void)
+{
+	if (!child.no_stdin)
+		close(child.in);
+	if (!child.no_stdout)
+		close(child.out);
+	finish_command(&child);
+	return 0;
+}
+
+int p4_fini(void)
+{
+	return 0;
+}
diff --git a/vcs-p4/p4client.h b/vcs-p4/p4client.h
new file mode 100644
index 0000000..d0e4ccd
--- /dev/null
+++ b/vcs-p4/p4client.h
@@ -0,0 +1,38 @@
+#ifndef P4CLIENT_H
+#define P4CLIENT_H
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include "strbuf.h"
+
+void p4_init(const char *const *env);
+
+int p4_call(int fds[], const char *arg0, int argc, char *const *argv);
+
+#define p4_call_info(arg0, argc, argv, data, cb) \
+	(0 ? ((*(cb))((data), 0, NULL), 1) : \
+	 _p4_call_info(arg0, argc, argv, (void *)data, (void (*)(void *, int, const char *)) cb))
+
+#define p4_call_form(arg0, argc, argv, data, cb) \
+	(0 ? ((*(cb))((data), NULL, NULL), 1) : \
+	 _p4_call_form(arg0, argc, argv, (void *)data, (void (*)(void *, const char *, const char *)) cb))
+
+#define p4_call_buffer(arg0, argc, argv, data, cb) \
+	(0 ?  ((*(cb))((data), NULL, 0), 1) : \
+	 _p4_call_buffer(arg0, argc, argv, (void *)data, (void (*)(void *, const char *, int)) cb))
+
+int p4_complete();
+
+int p4_fini();
+
+int _p4_call_info(const char *arg0, int argc, char *const *argv, void *data,
+		  void (*cb)(void *data, int level, const char *line));
+
+int _p4_call_form(const char *arg0, int argc, char *const *argv, void *data,
+		  void (*cb)(void *data, const char *key, const char *value));
+
+int _p4_call_buffer(const char *arg0, int argc, char *const *argv, void *data,
+		    void (*cb)(void *data, const char *buffer, int len));
+
+#endif
diff --git a/vcs-p4/vcs-p4.c b/vcs-p4/vcs-p4.c
new file mode 100644
index 0000000..36f7d3f
--- /dev/null
+++ b/vcs-p4/vcs-p4.c
@@ -0,0 +1,1229 @@
+#include "cache.h"
+#include "vcs-p4.h"
+#include "strbuf.h"
+#include "remote.h"
+#include "commit.h"
+#include "tree.h"
+#include "tree-walk.h"
+#include "diff.h"
+
+#include "p4client.h"
+
+#include <string.h>
+
+/** Should we try to find codelines that branch off of the relevant
+ * ones, for future reference? This lets us find new things in
+ * ls-remote without making the user tell us.
+ **/
+static int find_new_codelines;
+
+static int ignore_codeline_nr;
+static int ignore_codeline_alloc;
+static char **ignore_codelines;
+
+static int prints_done = 0;
+
+static regex_t *codeline_regex;
+
+#define CODELINE_TAG "Codeline: "
+#define CHANGE_TAG "Changelist: "
+
+#define LIST_P4_OPERATIONS 0
+
+/** List functions **/
+
+static void add_to_revision_list(struct p4_revision_list **list,
+				 struct p4_revision *revision)
+{
+	while (*list)
+		list = &(*list)->next;
+	*list = xcalloc(1, sizeof(**list));
+	(*list)->revision = revision;
+}
+
+static struct p4_revision_list *copy_revision_list(struct p4_revision_list *lst)
+{
+	struct p4_revision_list *ret, **posn = &ret;
+	while (lst) {
+		*posn = xcalloc(1, sizeof(**posn));
+		(*posn)->revision = lst->revision;
+		posn = &((*posn)->next);
+		lst = lst->next;
+	}
+	return ret;
+}
+
+/** Functions to find or create representations **/
+
+static struct p4_depot *get_depot(void)
+{
+	struct p4_depot *depot = xcalloc(1, sizeof(*depot));
+	depot->next_mark = 1;
+	return depot;
+}
+
+static struct p4_changeset *get_changeset(struct p4_codeline *codeline,
+					  long number);
+
+static char *codeline_to_refname(const char *path) {
+	struct strbuf buf;
+	if (prefixcmp(path, "//"))
+		return NULL;
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "refs/p4/%s", path + 2);
+	return strbuf_detach(&buf, NULL);
+}
+
+static char *refname_to_codeline(const char *refname) {
+	struct strbuf buf;
+	if (prefixcmp(refname, "refs/p4/"))
+		return NULL;
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "//%s", refname + strlen("refs/p4/"));
+	return strbuf_detach(&buf, NULL);
+}
+
+static struct p4_codeline *get_codeline(struct p4_depot *depot, const char *path)
+{
+	struct p4_codeline **posn, *codeline;
+	int i;
+	unsigned char sha1[20];
+
+	if (codeline_regex && regexec(codeline_regex, path, 0, NULL, 0))
+		return NULL;
+
+	for (posn = &depot->codelines; *posn; posn = &(*posn)->next)
+		if (!strcmp(path, (*posn)->path))
+			return *posn;
+	codeline = xcalloc(1, sizeof(*codeline));
+	codeline->depot = depot;
+	codeline->path = xstrdup(path);
+
+	for (i = 0; i < ignore_codeline_nr; i++)
+		if (!strcmp(path, ignore_codelines[i]))
+			codeline->ignore = 1;
+
+	codeline->refname = codeline_to_refname(path);
+	if (!get_sha1(codeline->refname, sha1)) {
+		struct commit *commit = lookup_commit(sha1);
+		char *field;
+		parse_commit(commit);
+		field = strstr(commit->buffer, CHANGE_TAG);
+		if (!field) {
+			fprintf(stderr, "Couldn't find changeset line in commit\n");
+		} else {
+			struct p4_changeset *changeset;
+			codeline->finished_changeset =
+				atoi(field + strlen(CHANGE_TAG));
+			changeset = get_changeset(codeline, codeline->finished_changeset);
+			changeset->commit = commit;
+			codeline->history = changeset;
+		}
+	}
+	*posn = codeline;
+	return codeline;
+}
+
+static struct p4_codeline *find_codeline(struct p4_depot *depot, const char *path)
+{
+	struct p4_codeline **posn;
+	for (posn = &depot->codelines; *posn; posn = &(*posn)->next)
+		if (!prefixcmp(path, (*posn)->path))
+			return *posn;
+	return NULL;
+}
+
+/** Inserts the changeset at the right place in order for the codeline **/
+static struct p4_changeset *get_changeset(struct p4_codeline *codeline,
+					  long number)
+{
+	struct p4_changeset **posn = &codeline->changesets;
+	struct p4_changeset *changeset, *prev = NULL;
+	while (*posn && (*posn)->number < number) {
+		prev = *posn;
+		posn = &(*posn)->next;
+	}
+	if (*posn && (*posn)->number == number)
+		return *posn;
+	//printf("# add changeset %lu in %s\n", number, codeline->path);
+	changeset = xcalloc(1, sizeof(*changeset));
+	changeset->codeline = codeline;
+	changeset->next = *posn;
+	changeset->previous = prev;
+	if (changeset->next)
+		changeset->next->previous = changeset;
+	else
+		codeline->head = changeset;
+	*posn = changeset;
+	changeset->number = number;
+	codeline->num_changesets++;
+	return changeset;
+}
+
+static struct p4_changeset *changeset_from_commit(struct p4_depot *depot,
+						  struct commit *commit)
+{
+	unsigned long number = 0;
+	char *codeline = NULL, *field;
+	parse_commit(commit);
+	field = strstr(commit->buffer, CHANGE_TAG);
+	if (field)
+		number = atoi(field + strlen(CHANGE_TAG));
+	field = strstr(commit->buffer, CODELINE_TAG);
+	if (field) {
+		char *end;
+		codeline = field + strlen(CODELINE_TAG);
+		end = strchr(codeline, '\n');
+		if (end)
+			*end = '\0';
+	}
+	if (number && codeline)
+		return get_changeset(get_codeline(depot, codeline), number);
+	return NULL;
+}
+
+static struct p4_file *get_file_by_full(struct p4_codeline *codeline,
+					const char *fullpath)
+{
+	const char *rel = fullpath + strlen(codeline->path);
+	struct p4_file **posn;
+	for (posn = &codeline->files; *posn; posn = &(*posn)->next) {
+		if (!strcmp((*posn)->name, rel))
+			return *posn;
+	}
+	*posn = xcalloc(1, sizeof(**posn));
+	(*posn)->codeline = codeline;
+	(*posn)->name = xstrdup(rel);
+	return *posn;
+}
+
+static struct p4_file *get_related_file(struct p4_file *base, const char *path)
+{
+	int basenamelen = strlen(base->name);
+	int reldirlen = strlen(path) - basenamelen;
+	struct p4_codeline *codeline;
+	if (reldirlen > 0 && !strcmp(path + reldirlen, base->name)) {
+		/* File with the same name in another codeline */
+		char *other = xstrndup(path, reldirlen);
+		//printf("# find %s in %s\n", path, other);
+		codeline = get_codeline(base->codeline->depot, other);
+		free(other);
+		if (codeline)
+			return get_file_by_full(codeline, path);
+		return NULL;
+	}
+	codeline = find_codeline(base->codeline->depot, path);
+	if (codeline) {
+		/* File with a different name in some known codeline */
+		return get_file_by_full(codeline, path);
+	}
+	fprintf(stderr, "Trying to identify %s\n", path);
+	/* Not in any known codeline; need to recheck this after
+	 * discovering codelines completes.
+	 */
+	return NULL;
+}
+
+static struct p4_revision *get_revision(struct p4_file *file, unsigned number)
+{
+	struct p4_revision **posn;
+	struct p4_revision *revision;
+	for (posn = &file->revisions; *posn && (*posn)->number < number;
+	     posn = &(*posn)->next)
+		;
+	if (!*posn || (*posn)->number != number) {
+		revision = xcalloc(1, sizeof(*revision));
+		revision->next = *posn;
+		*posn = revision;
+		revision->number = number;
+		revision->file = file;
+	}
+	return *posn;
+}
+
+static int parse_p4_date(const char *date)
+{
+	struct tm tm;
+	memset(&tm, 0, sizeof(tm));
+	tm.tm_year = strtol(date, NULL, 10) - 1900;
+	tm.tm_mon = strtol(date + 5, NULL, 10) - 1;
+	tm.tm_mday = strtol(date + 8, NULL, 10);
+	tm.tm_hour = strtol(date + 11, NULL, 10);
+	tm.tm_min = strtol(date + 14, NULL, 10);
+	tm.tm_sec = strtol(date + 17, NULL, 10);
+	return mktime(&tm);
+}
+
+static int is_keyword(const char *text, int keywords)
+{
+	if (!prefixcmp(text, "Id: ") ||
+	    !prefixcmp(text, "Header: "))
+		return 1;
+	if (keywords == 1)
+		return 0;
+	return !prefixcmp(text, "Date: ") ||
+		!prefixcmp(text, "DateTime: ") ||
+		!prefixcmp(text, "Change: ") ||
+		!prefixcmp(text, "File: ") ||
+		!prefixcmp(text, "Revision: ") ||
+		!prefixcmp(text, "Author: ");
+}
+
+static void handle_keywords(struct strbuf *buf, int keywords)
+{
+	int posn = 0;
+	char *keyword;
+
+	if (!keywords)
+		return;
+
+	do {
+		keyword = strchr(buf->buf + posn, '$');
+		if (!keyword)
+			break;
+		if (!is_keyword(keyword + 1, keywords)) {
+			posn = keyword - buf->buf + 1;
+			continue;
+		}
+		char *eok = strchr(keyword + 1, ':');
+		size_t kwl = strcspn(eok, "$\n");
+		if (!eok[kwl])
+			break;
+		if (eok[kwl] == '$') {
+			strbuf_remove(buf, eok - buf->buf, kwl);
+		} else {
+			posn = eok - buf->buf + kwl + 1;
+		}
+	} while (1);
+}
+
+static const char *get_file_type(const char *text, size_t len)
+{
+	if (len == 5 && !memcmp(text, "ktext", 5))
+		return "text+k";
+	if (len == 5 && !memcmp(text, "xtext", 5))
+		return "text+x";
+	if (len == 6 && !memcmp(text, "kxtext", 6))
+		return "text+kx";
+	return xstrndup(text, len);
+}
+
+static const char *get_file_mode(const char *type)
+{
+	char *p = strchr(type, '+');
+	if (!strcmp(type, "symlink"))
+		return "120000";
+	if (p && strchr(p, 'x'))
+		return "100755";
+	return "100644";
+}
+
+static int keywords(const char *type)
+{
+	char *p = strchr(type, '+');
+	if (p) {
+		char *k = strchr(p, 'k');
+		if (k) {
+			if (k[1] == 'o')
+				return 1;
+			return 2;
+		}
+	}
+	return 0;
+}
+
+static void output_data(struct strbuf *buf)
+{
+	printf("data %d\n", buf->len);
+	fwrite(buf->buf, 1, buf->len, stdout);
+	printf("\n");
+}
+
+static int write_blob(struct p4_codeline *codeline,
+		      const unsigned char *sha1,
+		      const char *path)
+{
+	struct strbuf buf;
+	void *content;
+	enum object_type type;
+	unsigned long size;
+	int fd;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	content = read_sha1_file(sha1, &type, &size);
+	fd = open(buf.buf, O_WRONLY | O_CREAT, 0666);
+	if (fd < 0) {
+		die("Got err %d", errno);
+	}
+	write_or_die(fd, content, size);
+	return 0;
+}
+
+/** P4 operations **/
+
+static int p4_where(struct p4_codeline *codeline)
+{
+	int fds[2];
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, codeline->path);
+	argv[0] = buf.buf;
+	p4_call(fds, "where", 1, argv);
+	FILE *input = fdopen(fds[1], "r");
+
+	while (!strbuf_getline(&buf, input, '\n')) {
+		char *working = strrchr(buf.buf, ' ');
+		if (working)
+			codeline->working = xstrdup(working + 1);
+	}
+	p4_complete();
+	return codeline->working ? 0 : -1;
+}
+
+static void p4_sync(struct p4_codeline *codeline)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	printf("progress syncing %s/...\n", codeline->working);
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/...@%lu",
+		    codeline->working, codeline->head->number);
+	argv[0] = buf.buf;
+	p4_call(NULL, "sync", 1, argv);
+	p4_complete();
+}
+
+static void p4_edit(struct p4_codeline *codeline, const char *path)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "edit", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_add(struct p4_codeline *codeline, const char *path)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "add", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_delete(struct p4_codeline *codeline, const char *path)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "delete", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static void p4_submit(struct commit *commit)
+{
+	int fds[2];
+	char *argv[1];
+	int skip = 0;
+	argv[0] = "-o";
+	p4_call(fds, "change", 1, argv);
+
+	struct strbuf message;
+	struct strbuf line;
+
+	FILE *input = fdopen(fds[1], "r");
+
+	strbuf_init(&message, 0);
+	strbuf_init(&line, 0);
+
+	while (!strbuf_getline(&line, input, '\n')) {
+		if (!skip) {
+			strbuf_addstr(&message, line.buf);
+			strbuf_addch(&message, '\n');
+		}
+		if (line.buf[0] != '\t')
+			skip = 0;
+		if (!strcmp(line.buf, "Description:")) {
+			char *posn;
+			parse_commit(commit);
+			posn = strstr(commit->buffer, "\n\n");
+			if (posn)
+				posn += 2;
+			while (*posn) {
+				char *eol = strchr(posn, '\n');
+				strbuf_addstr(&message, "\t");
+				if (eol) {
+					eol++;
+					strbuf_add(&message, posn, eol - posn);
+					posn = eol;
+				} else {
+					strbuf_addstr(&message, posn);
+					break;
+				}
+			}
+			strbuf_addstr(&message, "\n");
+			skip = 1;
+		}
+	}
+
+	fclose(input);
+	p4_complete();
+
+	printf("%s\n", message.buf);
+
+	argv[0] = "-i";
+	p4_call(fds, "submit", 1, argv);
+
+	write_or_die(fds[0], message.buf, message.len);
+	close(fds[0]);
+
+	input = fdopen(fds[1], "r");
+	while (!strbuf_getline(&line, input, '\n'))
+		fprintf(stderr, "%s\n", line.buf);
+	p4_complete();
+}
+
+static void p4_print(struct p4_revision *revision)
+{
+	char *argv[2];
+	struct strbuf line;
+	strbuf_init(&line, 0);
+	strbuf_addf(&line, "%s%s#%lu",
+		    revision->file->codeline->path,
+		    revision->file->name, revision->number);
+	argv[1] = strdup(line.buf);
+	argv[0] = "-q";
+
+	if (LIST_P4_OPERATIONS)
+		fprintf(stderr, "p4 print\n");
+
+	strbuf_reset(&line);
+
+	p4_call_buffer("print", 2, argv, &line, strbuf_add);
+
+	free(argv[1]);
+
+	handle_keywords(&line, keywords(revision->type));
+
+	/* Perforce puts a newline at the end when printing symlinks */
+	if (!strcmp(revision->type, "symlink"))
+		line.len--;
+
+	output_data(&line);
+
+	strbuf_release(&line);
+
+	prints_done++;
+}
+
+struct p4_change_data {
+	struct p4_changeset *changeset;
+	int date;
+	char *user;
+	struct strbuf message;
+};
+
+static void p4_change_cb(struct p4_change_data *data, const char *key,
+			 const char *value)
+{
+	if (!strcmp(key, "User"))
+		data->user = xstrdup(value);
+	else if (!strcmp(key, "Date"))
+		data->date = parse_p4_date(value);
+	else if (!strcmp(key, "Description"))
+		strbuf_addstr(&data->message, value);
+}
+
+static void p4_change(struct p4_changeset *changeset)
+{
+	char *argv[2];
+	struct strbuf line;
+
+	struct p4_change_data data = {
+		.changeset = changeset,
+		.date = 0,
+		.user = NULL,
+	};
+
+	if (LIST_P4_OPERATIONS)
+		fprintf(stderr, "p4 change\n");
+
+	strbuf_init(&data.message, 0);
+
+	strbuf_init(&line, 0);
+	strbuf_addf(&line, "%lu", changeset->number);
+	argv[1] = line.buf;
+	argv[0] = "-o";
+	p4_call_form("change", 2, argv, &data, p4_change_cb);
+	strbuf_release(&line);
+
+	printf("committer %s <%s> %d +0000\n",
+	       data.user, data.user, data.date);
+	free(data.user);
+
+	strbuf_addf(&data.message,
+		    "\n" CODELINE_TAG "%s\n" CHANGE_TAG "%lu\n",
+		    changeset->codeline->path, changeset->number);
+	output_data(&data.message);
+	strbuf_release(&data.message);
+}
+
+struct p4_filelog_data {
+	struct p4_codeline *codeline;
+	struct p4_file *file;
+	struct p4_revision *revision;
+};
+
+static void p4_filelog_cb(struct p4_filelog_data *data,
+			  char level, const char *line)
+{
+	if (level == 0) {
+		data->file = get_file_by_full(data->codeline, line);
+	} else if (level == 1) {
+		int rev, change, delete = 0, branch = 0;
+		char *posn;
+		rev = strtoul(line + 1, &posn, 10);  /* skip the '#' */
+		posn += strlen(" change ");
+		change = strtoul(posn, &posn, 10);
+		if (!prefixcmp(posn, " delete"))
+			delete = 1;
+		if (!prefixcmp(posn, " branch"))
+			branch = 1;
+		posn = strchr(posn, '(') + 1;
+		data->revision = get_revision(data->file, rev);
+		data->revision->changeset =
+			get_changeset(data->codeline, change);
+		data->revision->type = get_file_type(posn,
+						     strchr(posn, ')') - posn);
+		data->revision->delete = delete;
+		data->revision->branch = branch;
+		add_to_revision_list(&data->revision->changeset->revisions,
+				     data->revision);
+	} else if (level == 2) {
+		const char *path;
+		int rev, from = 0;
+		char *type = xstrdup(line);
+		char *posn = strrchr(type, ' ') + 1;
+
+		from = (!prefixcmp(type, "ignored") &&
+			posn == type + strlen("ignored") + 1) ||
+			!prefixcmp(strchr(type, ' '), " from");
+
+		path = posn;
+		posn = strchr(posn, '#');
+		*(posn++) = '\0';
+		do {
+			/* ???? What does a list of revisions mean? */
+			rev = strtoul(posn, &posn, 10);
+			if (*posn != ',')
+				break;
+			posn += 2;
+		} while (1);
+		if (from) {
+			struct p4_file *rel_file =
+				get_related_file(data->file, path);
+			if (!rel_file) {
+				/*
+				printf("# Couldn't find %s related to %s %s\n",
+				       path, data->file->codeline->path,
+				       data->file->name);
+				*/
+			}
+			if (rel_file && rel_file->codeline != data->codeline)
+				add_to_revision_list(&data->revision->integrated,
+						     get_revision(rel_file, rev));
+		} else if (find_new_codelines) {
+			/* This is an "<op> into <path>#<rev>" line.
+			 * We just want to try to create a codeline.
+			 */
+			get_related_file(data->file, path);
+		}
+		free(type);
+	}
+}
+
+/** Finds all files in the codeline, and all revisions of those files,
+ * and all of the changesets they are from, and looks up the codelines
+ * and files they integrate or branch.
+ **/
+static void p4_filelog(struct p4_codeline *codeline)
+{
+	struct strbuf line;
+
+	struct p4_filelog_data data = {
+		.codeline = codeline,
+		.file = NULL,
+		.revision = NULL
+	};
+	char *arg;
+
+	if (codeline->filelog_done)
+		return;
+
+	if (LIST_P4_OPERATIONS)
+		fprintf(stderr, "p4 filelog %s\n", codeline->path);
+
+	strbuf_init(&line, 0);
+	strbuf_addstr(&line, codeline->path);
+	strbuf_addstr(&line, "/...");
+	arg = line.buf;
+	p4_call_info("filelog", 1, &arg, &data, p4_filelog_cb);
+	strbuf_release(&line);
+	if (codeline->history)
+		codeline->unreported = codeline->history->next;
+	else
+		codeline->unreported = codeline->changesets;
+	codeline->filelog_done = 1;
+}
+
+/** Functions to import things (i.e., fill out the representations) **/
+
+static struct p4_changeset_list *
+find_codeline_changeset(struct p4_changeset_list **list,
+			struct p4_codeline *codeline)
+{
+	while (*list) {
+		if ((*list)->changeset->codeline == codeline)
+			return *list;
+		list = &(*list)->next;
+	}
+	*list = xcalloc(1, sizeof(**list));
+	return *list;
+}
+
+static void resolve_codeline_contents(struct p4_codeline *codeline)
+{
+	struct p4_revision_list *prevrevs = NULL;
+	struct p4_changeset *changeset = codeline->changesets;
+	while (changeset) {
+		struct p4_revision_list *changes =
+			copy_revision_list(changeset->revisions);
+		changeset->contents = changes;
+		while (prevrevs) {
+			struct p4_revision_list *posn;
+			int found = 0;
+			for (posn = changes; posn; posn = posn->next) {
+				if (prevrevs->revision->file ==
+				    posn->revision->file) {
+					found = 1;
+					break;
+				}
+			}
+			if (!found) {
+				struct p4_revision_list *item =
+					xcalloc(1, sizeof(*item));
+				item->revision = prevrevs->revision;
+				item->next = changeset->contents;
+				changeset->contents = item;
+			}
+			prevrevs = prevrevs->next;
+		}
+
+		prevrevs = changeset->contents;
+		changeset = changeset->next;
+	}
+}
+
+static void resolve_changeset_integrates(struct p4_changeset *changeset)
+{
+	struct p4_revision_list *posn;
+	struct p4_changeset_list *changesets = NULL;
+	/* For each codeline, we want the highest numbered changeset
+	 * that introduced a revision that has been integrated.
+	 */
+	for (posn = changeset->revisions; posn; posn = posn->next) {
+		struct p4_revision_list *rev_ints = posn->revision->integrated;
+		while (rev_ints) {
+			struct p4_changeset_list *item;
+			if (rev_ints->revision->file->codeline == changeset->codeline) {
+				rev_ints = rev_ints->next;
+				continue;
+			}
+			/* The revision doesn't have the changeset
+			 * filled out unless we call this.
+			 */
+			p4_filelog(rev_ints->revision->file->codeline);
+			item = find_codeline_changeset(&changesets,
+						       rev_ints->revision->file->codeline);
+			if (!item->changeset ||
+			    item->changeset->number < rev_ints->revision->changeset->number) {
+				if (0)
+					printf("progress %lu integrates %s#%lu from %lu\n",
+					       changeset->number,
+					       rev_ints->revision->file->name,
+					       rev_ints->revision->number,
+					       rev_ints->revision->changeset->number);
+				item->changeset = rev_ints->revision->changeset;
+			}
+			rev_ints = rev_ints->next;
+		}
+	}
+	/* We could issue a warning if the state of other files didn't
+	 * match and yet didn't get integrated, but that's a lot of
+	 * work and there's no good way to represent the case of a
+	 * commit contributing to but not being completely obsoleted
+	 * by another commit.
+	 */
+	changeset->integrated = changesets;
+	while (changesets) {
+		//printf("# integrate %lu from %lu\n", changeset->number, changesets->changeset->number);
+		changesets = changesets->next;
+	}
+}
+
+static void follow_codeline(struct p4_codeline *target)
+{
+	struct p4_codeline *posn;
+	if (target->filelog_done)
+		return;
+
+	p4_filelog(target);
+
+	if (0)
+		printf("progress resolving integrates\n");
+
+	/* Now resolve all the integrates in changesets */
+	for (posn = target->depot->codelines; posn; posn = posn->next) {
+		struct p4_changeset *changeset;
+		for (changeset = posn->unreported; changeset; changeset = changeset->next) {
+			resolve_changeset_integrates(changeset);
+		}
+		resolve_codeline_contents(posn);
+	}
+}
+
+static struct p4_codeline *import_depot(struct p4_depot *depot, const char *refname)
+{
+	struct p4_codeline *target;
+	char *path = refname_to_codeline(refname);
+	target = get_codeline(depot, path);
+
+	if (!target)
+		die("Invalid codeline: %s", path);
+
+	free(path);
+
+	follow_codeline(target);
+
+	return target;
+}
+
+static void name_changeset(struct p4_changeset *changeset)
+{
+	if (changeset->commit)
+		printf("%s\n", sha1_to_hex(changeset->commit->object.sha1));
+	else
+		printf(":%d\n", changeset->mark);
+}
+
+static void lookup_git_changeset(struct p4_codeline *codeline,
+				 struct p4_changeset *changeset)
+{
+	while (!changeset->commit) {
+		struct commit *parent = codeline->history->commit->parents->item;
+		parse_commit(parent);
+		codeline->history->previous->commit = parent;
+		codeline->history = codeline->history->previous;
+	}
+}
+
+static void report_codeline(struct p4_codeline *codeline,
+			    struct p4_changeset *until);
+
+static void identify_changeset(struct p4_changeset *changeset)
+{
+	if (changeset->mark || changeset->commit)
+		return;
+	if (changeset->codeline->finished_changeset >= changeset->number)
+		lookup_git_changeset(changeset->codeline, changeset);
+	else
+		report_codeline(changeset->codeline, changeset);
+}
+
+static int skip_found(struct p4_revision *revision,
+		      struct p4_revision_list **origin) {
+	struct p4_revision *orev = NULL;
+	struct p4_revision_list *i;
+	while (*origin) {
+		if (!strcmp((*origin)->revision->file->name,
+			    revision->file->name)) {
+			struct p4_revision_list *oitem = *origin;
+			*origin = oitem->next;
+			orev = oitem->revision;
+			free(oitem);
+			break;
+		} else {
+			origin = &((*origin)->next);
+		}
+	}
+	if (!revision->branch) /* It's changed anyway */
+		return 0;
+	for (i = revision->integrated; i; i = i->next) {
+		if (i->revision == orev)
+			return 1;
+	}
+	return 0;
+}
+
+static void report_codeline(struct p4_codeline *codeline, struct p4_changeset *until)
+{
+	struct p4_changeset *changeset;
+	struct p4_revision_list *rev;
+
+	printf("progress import codeline %s (%lu-%lu)\n", codeline->path,
+	       codeline->unreported->number, until->number);
+
+	for (changeset = codeline->unreported; changeset; changeset = changeset->next) {
+		struct p4_changeset_list *integrated = changeset->integrated;
+		struct p4_revision_list *origin = NULL;
+
+		while (integrated) {
+			identify_changeset(integrated->changeset);
+			integrated = integrated->next;
+		}
+		printf("progress import changeset %lu (%s)\n",
+		       changeset->number, changeset->codeline->path);
+		printf("# changeset %lu\n", changeset->number);
+		printf("commit %s\n", codeline->refname);
+		changeset->mark = codeline->depot->next_mark++;
+		printf("mark :%d\n", changeset->mark);
+		p4_change(changeset);
+		integrated = changeset->integrated;
+		if (changeset->previous) {
+			printf("from ");
+			name_changeset(changeset->previous);
+		} else if (integrated) {
+			printf("from ");
+			origin = copy_revision_list(integrated->changeset->contents);
+			name_changeset(integrated->changeset);
+			integrated = integrated->next;
+		}
+
+		while (integrated) {
+			printf("merge ");
+			name_changeset(integrated->changeset);
+			integrated = integrated->next;
+		}
+
+		for (rev = changeset->revisions; rev; rev = rev->next) {
+			if (rev->revision->delete) {
+				printf("D %s\n", rev->revision->file->name + 1);
+			} else if (!skip_found(rev->revision, &origin)) {
+				printf("M %s inline %s\n",
+				       get_file_mode(rev->revision->type),
+				       rev->revision->file->name + 1);
+				p4_print(rev->revision);
+			}
+		}
+		while (origin) {
+			struct p4_revision_list *old;
+			printf("D %s\n", origin->revision->file->name + 1);
+			old = origin;
+			origin = origin->next;
+			free(old);
+		}
+		printf("\n");
+		codeline->unreported = changeset->next;
+		if (changeset == until)
+			break;
+	}
+	printf("checkpoint\n");
+}
+
+static void import_p4(int ref_nr, const char **refs)
+{
+	int i;
+	struct p4_depot *depot = get_depot();
+	struct p4_codeline *target;
+	save_commit_buffer = 1;
+
+	for (i = 0; i < ref_nr; i++) {
+		target = import_depot(depot, refs[i]);
+
+		identify_changeset(target->head);
+	}
+}
+
+static void export_change(struct diff_options *options,
+			  unsigned old_mode, unsigned new_mode,
+			  const unsigned char *old_sha1,
+			  const unsigned char *new_sha1,
+			  const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	p4_edit(codeline, path);
+	write_blob(codeline, new_sha1, path);
+}
+
+static void export_add_remove(struct diff_options *options,
+			      int addremove, unsigned mode,
+			      const unsigned char *sha1,
+			      const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	if (addremove == '+') {
+		write_blob(codeline, sha1, path);
+		p4_add(codeline, path);
+	} else if (addremove == '-') {
+		p4_delete(codeline, path);
+	}
+}
+
+static void export_commit(struct p4_codeline *codeline,
+			  struct commit *git_commit, struct commit *git_parent)
+{
+	struct tree_desc pre, post;
+	struct diff_options opts;
+	memset(&opts, 0, sizeof(opts));
+	parse_tree(git_commit->tree);
+	parse_tree(git_parent->tree);
+	init_tree_desc(&pre, git_parent->tree->buffer, git_parent->tree->size);
+	init_tree_desc(&post, git_commit->tree->buffer, git_commit->tree->size);
+	opts.change = export_change;
+	opts.add_remove = export_add_remove;
+	opts.format_callback_data = codeline;
+	opts.flags = DIFF_OPT_RECURSIVE;
+	diff_tree(&pre, &post, "/", &opts);
+	p4_submit(git_commit);
+}
+
+static void export_p4(struct remote *remote, const char *branch)
+{
+	struct p4_depot *depot = get_depot();
+	const char *codeline = remote->url[0];
+	struct p4_codeline *target;
+	struct strbuf buf;
+
+	// check client
+
+	target = import_depot(depot, codeline);
+
+	strbuf_init(&buf, 0);
+
+	while (!strbuf_getline(&buf, stdin, '\n')) {
+		struct p4_changeset *parent = NULL, *integrate = NULL;
+		unsigned char sha1[20];
+		struct commit *commit, *git_parent = NULL;
+		struct commit_list *parents;
+		get_sha1(buf.buf, sha1);
+		commit = lookup_commit(sha1);
+		parse_commit(commit);
+		for (parents = commit->parents; parents; parents = parents->next) {
+			struct p4_changeset *p4_parent =
+				changeset_from_commit(depot, parents->item);
+			if (p4_parent) {
+				if (p4_parent->codeline == target) {
+					parent = p4_parent;
+					git_parent = parents->item;
+				} else
+					integrate = p4_parent;
+			}
+		}
+		if (target->head != parent) {
+			printf("progress not up-to-date\n");
+			return;
+		}
+		if (p4_where(target))
+			break;
+		p4_sync(target);
+
+		if (!parent) {
+			// Need to start new codeline
+		}
+		export_commit(target, commit, git_parent);
+	}
+}
+
+static const char **env;
+static int env_nr;
+static int env_alloc;
+
+static const char **codelines;
+static int codeline_nr;
+static int codeline_alloc;
+
+static int handle_config(const char *key, const char *value, void *cb)
+{
+	struct remote *remote = cb;
+	struct strbuf buf;
+	const char *subkey = NULL;
+
+	if (!prefixcmp(key, "vcs-p4."))
+		subkey = key + strlen("vcs-p4.");
+
+	if (remote && !prefixcmp(key, "remote.") &&
+	    !prefixcmp(key + strlen("remote."), remote->name))
+	    subkey = key + strlen("remote.") + strlen(remote->name) + 1;
+
+	if (!subkey)
+		return 0;
+
+	if (!strcmp(subkey, "findbranches")) {
+		find_new_codelines = git_config_bool(key, value);
+	}
+	if (!strcmp(subkey, "ignorecodeline")) {
+		ALLOC_GROW(ignore_codelines, ignore_codeline_nr + 1,
+			   ignore_codeline_alloc);
+		ignore_codelines[ignore_codeline_nr++] = xstrdup(value);
+	}
+	if (!strcmp(subkey, "port")) {
+		strbuf_init(&buf, 0);
+		strbuf_addf(&buf, "P4PORT=%s", value);
+
+		ALLOC_GROW(env, env_nr + 1, env_alloc);
+		env[env_nr++] = strbuf_detach(&buf, NULL);
+	}
+	if (!strcmp(subkey, "client")) {
+		strbuf_init(&buf, 0);
+		strbuf_addf(&buf, "P4CLIENT=%s", value);
+
+		ALLOC_GROW(env, env_nr + 1, env_alloc);
+		env[env_nr++] = strbuf_detach(&buf, NULL);
+	}
+	if (!strcmp(subkey, "codelineformat")) {
+		codeline_regex = (regex_t*)xmalloc(sizeof(regex_t));
+		if (regcomp(codeline_regex, value, REG_EXTENDED)) {
+			free(codeline_regex);
+			fprintf(stderr, "Invalid codeline pattern: %s",
+				value);
+		}
+	}
+	if (!strcmp(subkey, "codeline")) {
+		ALLOC_GROW(codelines, codeline_nr + 1, codeline_alloc);
+		codelines[codeline_nr++] = xstrdup(value);
+	}
+	return 0;
+}
+
+int main(int argc, const char **argv)
+{
+	const char *prefix = NULL;
+	struct remote *remote;
+
+	if (argc < 2) {
+		fprintf(stderr, "Command needed");
+		return 1;
+	}
+
+	if (!strcmp(argv[1], "capabilities")) {
+		git_config(handle_config, NULL);
+
+		printf("import\n");
+		printf("find-new-branches\n");
+		printf("export\n");
+		printf("fork\n");
+		printf("merge\n");
+		return 0;
+	}
+
+	if (!strcmp(argv[1], "import")) {
+		prefix = setup_git_directory();
+		remote = remote_get(argv[2]);
+
+		git_config(handle_config, remote);
+
+		find_new_codelines = 0;
+
+		ALLOC_GROW(env, env_nr + 1, env_alloc);
+		env[env_nr++] = NULL;
+
+		p4_init(env);
+
+		import_p4(argc - 3, argv + 3);
+		p4_fini();
+		if (LIST_P4_OPERATIONS)
+			fprintf(stderr, "Prints done: %d\n", prints_done);
+		return 0;
+	}
+	if (!strcmp(argv[1], "list")) {
+		int i;
+
+		prefix = setup_git_directory();
+		remote = remote_get(argv[2]);
+
+		git_config(handle_config, remote);
+
+		ALLOC_GROW(env, env_nr + 1, env_alloc);
+		env[env_nr++] = NULL;
+
+		if (find_new_codelines) {
+			struct p4_depot *depot = get_depot();
+			struct p4_codeline *codeline;
+			save_commit_buffer = 1;
+
+			p4_init(env);
+
+			for (i = 0; i < codeline_nr; i++)
+				import_depot(depot,
+					     codeline_to_refname(codelines[i]));
+
+			for (codeline = depot->codelines; codeline;
+			     codeline = codeline->next) {
+				if (codeline->ignore)
+					continue;
+				follow_codeline(codeline);
+				printf("%s %s\n", codeline->refname,
+				       codeline->head == codeline->history ?
+				       "unchanged" : "changed");
+			}
+
+			p4_fini();
+		} else {
+			for (i = 0; i < codeline_nr; i++)
+				printf("%s\n",
+				       codeline_to_refname(codelines[i]));
+		}
+		return 0;
+	}
+	if (!strcmp(argv[1], "export")) {
+		prefix = setup_git_directory();
+
+		remote = remote_get(argv[2]);
+
+		git_config(handle_config, remote);
+
+		ALLOC_GROW(env, env_nr + 1, env_alloc);
+		env[env_nr++] = NULL;
+
+		p4_init(env);
+
+		export_p4(remote, argv[3]);
+		// 1: check whether the import of the target location
+		//    is up-to-date
+
+		// 2: find the target location in the client view
+
+		// 3: bring the client view up-to-date with the target
+		//    location
+
+		// 4: recheck that this matches the tree
+
+		// 5: open the necessary files in the client
+
+		// 6: replace the necessary files in the filesystem
+
+		// 7: submit
+
+		// 8: reimport
+
+		// 9: go back to (3)
+		p4_fini();
+	}
+	return 1;
+}
diff --git a/vcs-p4/vcs-p4.h b/vcs-p4/vcs-p4.h
new file mode 100644
index 0000000..57ad475
--- /dev/null
+++ b/vcs-p4/vcs-p4.h
@@ -0,0 +1,128 @@
+#ifndef VCS_P4_H
+#define VCS_P4_H
+
+struct p4_depot {
+	struct p4_codeline *codelines;
+
+	int next_mark;
+};
+
+/** Note that multiple codelines can have changesets with the same
+ * number.
+ **/
+struct p4_changeset {
+	struct p4_codeline *codeline;
+
+	unsigned long number;
+
+	/** Used only if a previous import found this changeset **/
+	struct commit *commit;
+
+	/** Used only if this changeset is newly imported in this operation. **/
+	int mark;
+
+	const char *message;
+
+	/** These are the revisions introduced in the changeset **/
+	struct p4_revision_list *revisions;
+
+	/** These are the revisions which are current as of the changeset **/
+	struct p4_revision_list *contents;
+
+	/** Not explicit in p4 **/
+	struct p4_changeset_list *integrated;
+
+	/** Next and previous in codeline **/
+	struct p4_changeset *next;
+	struct p4_changeset *previous;
+};
+
+struct p4_changeset_list {
+	struct p4_changeset *changeset;
+	struct p4_changeset_list *next;
+};
+
+struct p4_revision {
+	unsigned long number;
+
+	unsigned delete : 1;
+	unsigned branch : 1; /* unchanged against something integrated */
+
+	const char *type;
+
+	struct p4_file *file;
+	struct p4_changeset *changeset;
+
+	struct p4_revision_list *integrated;
+
+	/** Next in file **/
+	struct p4_revision *next;
+};
+
+/** Represents a collection of revisions of different files
+ **/
+struct p4_revision_list {
+	struct p4_revision *revision;
+	struct p4_revision_list *next;
+};
+
+struct p4_file {
+	struct p4_codeline *codeline;
+	const char *name;
+
+	unsigned head_number;
+
+	struct p4_revision *revisions;
+
+	/** Next file in codeline **/
+	struct p4_file *next;
+};
+
+/** perforce doesn't record codelines; we have to reverse-engineer
+ * them from how people seem to be branching.
+ **/
+struct p4_codeline {
+	unsigned ignore : 1;
+
+	struct p4_depot *depot;
+
+	/** Base path of codeline **/
+	const char *path;
+
+	/** git refname to import into **/
+	const char *refname;
+
+	struct p4_file *files;
+	struct p4_changeset *changesets;
+
+	int filelog_done;
+
+	/* The incremental state is that we have some changeset that
+	 * we previously imported up to, and we have git history going
+	 * back from that point, of which we've looked up some and
+	 * could look up more as needed. Also, there's p4-only history
+	 * going forward after the common history, and we've imported
+	 * some of that, and could import more as needed. Since
+	 * codelines are sorted by changeset number, we can tell which
+	 * way to go to get a name for a changeset.
+	 */
+	struct p4_changeset *history;
+	struct p4_changeset *unreported;
+
+	struct p4_changeset *head;
+
+	unsigned long finished_changeset;
+
+	/** For reporting **/
+	unsigned long num_changesets;
+
+	/** Next codeline in depot **/
+	struct p4_codeline *next;
+
+	/** Filesystem location of working directory for this codeline
+	 * on the client.
+	 **/
+	char *working;
+};
+
+#endif
-- 
1.6.2.1.476.g9bf04b
