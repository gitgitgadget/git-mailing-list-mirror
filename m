From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH not-for-mainline] Implement git-vcs-p4
Date: Mon, 25 Jan 2010 16:35:57 -0500 (EST)
Message-ID: <alpine.LNX.2.00.1001251628431.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Tor Arvid Lund <torarvid@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jan 25 22:36:16 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZWbX-0007Pv-1q
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 22:36:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753456Ab0AYVgI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 25 Jan 2010 16:36:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750833Ab0AYVgH
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 16:36:07 -0500
Received: from iabervon.org ([66.92.72.58]:35580 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752449Ab0AYVgC (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 25 Jan 2010 16:36:02 -0500
Received: (qmail 5942 invoked by uid 1000); 25 Jan 2010 21:35:57 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 25 Jan 2010 21:35:57 -0000
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137996>

This is probably not particularly appropriate for mainline
application, and is somewhat buggy, not extensively tested, and
incomplete. The push support is also currently based on a transport helper 
export design that isn't upstream and I don't like any more; a better 
design is probably to have the core send an "export" command and then a 
gfi stream, but I haven't worked on this.

It has two implementations of the interaction with the Perforce
server: one that uses the command-line client (and therefore makes a
ton of separate connections to the server) and one that uses the
(closed source, vaguely licensed) C++ API. The former does not support
everything used in push/submit correctly at this point.

It also adds support to the Makefile for building C++ object files and
linking with a C++ linker. It should be easy to omit entirely for
builds that don't use p4, and it's at least somewhat out of the way.

The biggest flaw currently is that it doesn't save its analysis of the 
structure of the history, and doesn't have a way to push it out of memory, 
so a long or complex history will run you out of memory or will take a 
long time to do an incremental fetch.

Fetch features:

 - following integrations (with some guessing)
 - finding other branches of a codeline

Push features (only with the C++ API):

 - works if you don't do anything at all complicated

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
 Documentation/git-vcs-p4.txt |   47 ++
 Makefile                     |   23 +
 vcs-p4/p4client-api.cc       |  455 +++++++++++++++
 vcs-p4/p4client.c            |  158 ++++++
 vcs-p4/p4client.h            |   74 +++
 vcs-p4/vcs-p4.c              | 1250 ++++++++++++++++++++++++++++++++++++++++++
 vcs-p4/vcs-p4.h              |  135 +++++
 7 files changed, 2142 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/git-vcs-p4.txt
 create mode 100644 vcs-p4/p4client-api.cc
 create mode 100644 vcs-p4/p4client.c
 create mode 100644 vcs-p4/p4client.h
 create mode 100644 vcs-p4/vcs-p4.c
 create mode 100644 vcs-p4/vcs-p4.h

diff --git a/Documentation/git-vcs-p4.txt b/Documentation/git-vcs-p4.txt
new file mode 100644
index 0000000..61da8c1
--- /dev/null
+++ b/Documentation/git-vcs-p4.txt
@@ -0,0 +1,47 @@
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
+vcs-p4.findbranches::
+	If true, attempt to find branches of the codeline(s) specified
+	by looking for integrations out of these codelines.
+
+vcs-p4.ignorecodeline::
+	A perforce location which is a codeline, but is not relevant
+	to this project. This only applies to finding branches; a
+	codeline containing ancestors of the current codelines is
+	always imported, although it won't be given as a remote head
+	if it is ignored.
+
+remotes.*.vcs::
+	The string "p4" to use this importer.
+
+remotes.*.codeline::
+	The perforce location of a codeline to track. Other codelines
+	may be discovered by git-vcs-p4, but it will make no attempt
+	to get versions in these locations more recent than the last
+	versions that contribute at present to the tracked codelines,
+	and it will not make them available for matching in "fetch"
+	patterns.
diff --git a/Makefile b/Makefile
index 0ebf9dd..638127a 100644
--- a/Makefile
+++ b/Makefile
@@ -364,6 +364,7 @@ PROGRAMS += git-unpack-file$X
 PROGRAMS += git-update-server-info$X
 PROGRAMS += git-upload-pack$X
 PROGRAMS += git-var$X
+PROGRAMS += git-remote-p4$X
 
 # List built-in command $C whose implementation cmd_$C() is not in
 # builtin-$C.o but is linked in as part of some other command.
@@ -1252,6 +1253,7 @@ endif
 ifneq ($(findstring $(MAKEFLAGS),s),s)
 ifndef V
 	QUIET_CC       = @echo '   ' CC $@;
+	QUIET_CXX      = @echo '   ' CXX $@;
 	QUIET_AR       = @echo '   ' AR $@;
 	QUIET_LINK     = @echo '   ' LINK $@;
 	QUIET_BUILT_IN = @echo '   ' BUILTIN $@;
@@ -1448,12 +1450,16 @@ git.o git.spec \
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
@@ -1498,6 +1504,22 @@ git-remote-http$X git-remote-https$X git-remote-ftp$X: remote-curl.o http.o http
 	$(QUIET_LINK)$(CC) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
 		$(LIBS) $(CURL_LIBCURL) $(EXPAT_LIBEXPAT)
 
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
+git-remote-p4$X: LIBS += $(P4LIBS)
+git-remote-p4$X: vcs-p4/vcs-p4.o vcs-p4/$(P4_IMPL).o $(GITLIBS)
+	$(QUIET_LINK)$(P4_LINK) $(ALL_CFLAGS) -o $@ $(ALL_LDFLAGS) $(filter %.o,$^) \
+		$(LIBS)
+
 $(LIB_OBJS) $(BUILTIN_OBJS): $(LIB_H)
 $(patsubst git-%$X,%.o,$(PROGRAMS)) git.o: $(LIB_H) $(wildcard */*.h)
 builtin-revert.o wt-status.o: wt-status.h
@@ -1759,6 +1781,7 @@ distclean: clean
 
 clean:
 	$(RM) *.o mozilla-sha1/*.o arm/*.o ppc/*.o compat/*.o compat/*/*.o xdiff/*.o \
+		vcs-p4/*.o \
 		$(LIB_FILE) $(XDIFF_LIB)
 	$(RM) $(ALL_PROGRAMS) $(BUILT_INS) git$X
 	$(RM) $(TEST_PROGRAMS)
diff --git a/vcs-p4/p4client-api.cc b/vcs-p4/p4client-api.cc
new file mode 100644
index 0000000..3ff5962
--- /dev/null
+++ b/vcs-p4/p4client-api.cc
@@ -0,0 +1,455 @@
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
+  // Stuff that shouldn't happen
+  virtual void InputData(StrBuf *strbuf, Error *e);
+  virtual void OutputError(const char *errBuf);
+  virtual void OutputStat(StrDict *varList);
+  virtual void Prompt(const StrPtr &msg, StrBuf &rsp, int noEcho, Error *e);
+  virtual void ErrorPause(char *errBuf, Error *e);
+  virtual void Edit(FileSys *f1, Error *e);
+  virtual void Diff(FileSys *f1, FileSys *f2, int doPage,
+		    char *diffFlags, Error *e);
+  virtual void Merge(FileSys *base, FileSys *leg1, FileSys *leg2,
+		     FileSys *result, Error *e);
+  virtual int Resolve(ClientMerge *m, Error *e);
+  virtual void Help(const char *const *help);
+  virtual FileSys *File(FileSysType type);
+
+public:
+  void *data;
+  void (*info_cb)(void *, int, const char *);
+  void (*form_cb)(void *, const char *, const char *);
+  const char *(*form_io_cb)(void *, const char *, const char *);
+
+  void (*buffer_cb)(void *, const char *buffer, int length);
+
+  void clear() {
+    info_cb = NULL;
+    form_cb = NULL;
+    form_io_cb = NULL;
+    buffer_cb = NULL;
+  }
+
+  VCSClientUser() {
+    strbuf_init(&input, 0);
+    tree = NULL;
+  }
+
+  const unsigned char *tree;
+  const char *base;
+
+private:
+  struct strbuf input;
+};
+
+class PhonyFileSys : public FileSys {
+  virtual void Open(FileOpenMode mode, Error *e);
+  virtual void Write(const char *buf, int len, Error *e);
+  virtual int Read(char *buf, int len, Error *e);
+  virtual void Close(Error *e);
+  virtual int Stat();
+  virtual int StatModTime();
+  virtual void Truncate(Error *e);
+  virtual void Unlink(Error *e);
+  virtual void Rename(FileSys *target, Error *e);
+  virtual void Chmod(FilePerm perms, Error *e);
+  virtual void ChmodTime(Error *e);
+public:
+  PhonyFileSys(VCSClientUser *user, FileSysType type) {
+    this->user = user;
+    this->type = type;
+  }
+private:
+  VCSClientUser *user;
+  int mode;
+  const char *buffer;
+  unsigned long posn;
+  unsigned long size;
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
+    if (!strncmp(*env, "P4CLIENT=", 7))
+      client.SetClient((*env) + 9);
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
+  else if (form_cb || form_io_cb) {
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
+      if (form_cb)
+	form_cb(data, key.buf, value.buf);
+      else {
+	const char *new_value = form_io_cb(data, key.buf, value.buf);
+	if (new_value) {
+	  strbuf_addbuf(&input, &key);
+	  strbuf_addch(&input, ':');
+	  if (strchr(new_value, '\n')) {
+	    const char *posn = new_value;
+	    while (posn) {
+	      const char *eol = strchr(posn, '\n');
+	      strbuf_addstr(&input, "\n\t");
+	      if (eol) {
+		strbuf_add(&input, posn, eol - posn);
+		posn = eol + 1;
+	      } else {
+		strbuf_addstr(&input, posn);
+		break;
+	      }
+	    }
+	  } else {
+	    strbuf_addch(&input, ' ');
+	    strbuf_addstr(&input, new_value);
+	  }
+	  strbuf_addch(&input, '\n');
+	}
+      }
+    }
+    strbuf_release(&key);
+    strbuf_release(&value);
+  } else
+    fprintf(stderr, "Unexpected info: %c ... %s\n", level, line);
+}
+
+void VCSClientUser::InputData(StrBuf *strbuf, Error *e)
+{
+  strbuf->Append(input.buf, input.len);
+  strbuf_reset(&input);
+  //fprintf(stderr, "Unexpected input data\n");
+}
+
+void VCSClientUser::OutputError(const char *errBuf)
+{
+  fprintf(stderr, "Error output: %s\n", errBuf);
+}
+
+void VCSClientUser::OutputStat(StrDict *varList)
+{
+  fprintf(stderr, "Unexpected stat\n");
+}
+
+void VCSClientUser::Prompt(const StrPtr &msg, StrBuf &rsp,
+			   int noEcho, Error *e)
+{
+  fprintf(stderr, "Prompt\n");
+}
+
+void VCSClientUser::ErrorPause(char *errBuf, Error *e)
+{
+  fprintf(stderr, "Error pause from p4\n");
+}
+
+void VCSClientUser::Edit(FileSys *f1, Error *e)
+{
+  fprintf(stderr, "Edit request from p4\n");
+}
+
+void VCSClientUser::Diff(FileSys *f1, FileSys *f2, int doPage,
+			 char *diffFlags, Error *e)
+{
+  fprintf(stderr, "Diff from p4\n");
+}
+
+void VCSClientUser::Merge(FileSys *base, FileSys *leg1, FileSys *leg2,
+			  FileSys *result, Error *e)
+{
+  fprintf(stderr, "Merge from p4\n");
+}
+
+int VCSClientUser::Resolve(ClientMerge *m, Error *e)
+{
+  fprintf(stderr, "Resolve from p4\n");
+  m->Select(CMS_MERGED, e);
+  return CMS_MERGED;
+}
+
+void VCSClientUser::Help(const char *const *help)
+{
+  fprintf(stderr, "Help from p4\n");
+}
+
+FileSys *VCSClientUser::File(FileSysType type)
+{
+  FileSys *ret;
+  fprintf(stderr, "File from p4: %d\n", type);
+  ret = new PhonyFileSys(this, type);
+  return ret;
+}
+
+void PhonyFileSys::Open(FileOpenMode mode, Error *e)
+{
+  const char *openpath = path.Text();
+  fprintf(stderr, "Open %s for %d\n", openpath, mode);
+  if (mode == FOM_READ) {
+    if (strncmp(openpath, user->base, strlen(user->base))) {
+      e->Sys("Path outside of working directory", openpath);
+      return;
+    }
+    openpath = openpath + strlen(user->base);
+    if (openpath[0] == '/')
+      openpath++;
+    unsigned filemode;
+    if (!user->tree)
+      e->Sys("Unable to read file", openpath);
+    buffer = get_tree_path(user->tree, openpath, &filemode, &size);
+    if (!buffer)
+      e->Sys("File not found", openpath);
+    posn = 0;
+  }
+}
+
+void PhonyFileSys::Write(const char *buf, int len, Error *e)
+{
+}
+
+int PhonyFileSys::Read(char *buf, int len, Error *e)
+{
+  if (len + posn > size)
+    len = size - posn;
+  memcpy(buf, buffer + posn, len);
+  posn += len;
+  return len;
+}
+
+void PhonyFileSys::Close(Error *e)
+{
+}
+
+int PhonyFileSys::Stat()
+{
+  const char *openpath = path.Text();
+  unsigned filemode;
+  fprintf(stderr, "Stat %s\n", openpath);
+  if (!user->tree)
+    return 0;
+  if (strncmp(openpath, user->base, strlen(user->base))) {
+    return 0;
+  }
+  openpath = openpath + strlen(user->base);
+  if (openpath[0] == '/')
+    openpath++;
+  buffer = get_tree_path(user->tree, openpath, &filemode, &size);
+  if (!buffer)
+    return 0;
+  fprintf(stderr, "Exists\n");
+  return FSF_EXISTS;
+}
+
+int PhonyFileSys::StatModTime()
+{
+  const char *openpath = path.Text();
+  fprintf(stderr, "Stat modtime %s\n", openpath);
+  return 0;
+}
+
+void PhonyFileSys::Truncate(Error *e)
+{
+  fprintf(stderr, "truncate\n");
+}
+
+void PhonyFileSys::Unlink(Error *e)
+{
+  fprintf(stderr, "unlink\n");
+}
+
+void PhonyFileSys::Rename(FileSys *target, Error *e)
+{
+  fprintf(stderr, "rename %s to %s\n", path.Text(), target->Path()->Text());
+}
+
+void PhonyFileSys::Chmod(FilePerm perms, Error *e)
+{
+  fprintf(stderr, "chmod\n");
+}
+
+void PhonyFileSys::ChmodTime(Error *e)
+{
+  fprintf(stderr, "chmodtime\n");
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
+int _p4_call_unknown(const char *arg0, int argc, char *const *argv)
+{
+  ui.clear();
+  ui.data = NULL;
+  client.SetArgv(argc, argv);
+  client.Run(arg0, &ui);
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
+  char **new_argv = (char **)calloc(argc + 2, sizeof(*new_argv));
+  int i;
+  new_argv[0] = "-o";
+  for (i = 0; i < argc; i++)
+    new_argv[i + 1] = argv[i];
+  new_argv[argc + 1] = NULL;
+  ui.clear();
+  ui.data = data;
+  ui.form_cb = cb;
+  client.SetArgv(argc + 1, new_argv);
+  client.Run(arg0, &ui);
+  return 0;
+}
+
+int _p4_call_form_io(const char *arg0, int argc, char *const *argv, void *data,
+		     const char *(*cb)(void *data, const char *key, const char *value))
+{
+  char **new_argv = (char **)calloc(argc + 2, sizeof(*new_argv));
+  int i;
+  new_argv[0] = "-o";
+  for (i = 0; i < argc; i++)
+    new_argv[i + 1] = argv[i];
+  new_argv[argc + 1] = NULL;
+  ui.clear();
+  ui.data = data;
+  ui.form_io_cb = cb;
+  client.SetArgv(argc + 1, new_argv);
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
+void p4_write_blob(const char *base, unsigned mode, const unsigned char *sha1,
+		   const char *path)
+{
+}
+
+void p4_write_tree(const char *base, const unsigned char *sha1)
+{
+  ui.base = base;
+  ui.tree = sha1;
+}
+
+void p4_release_tree(void)
+{
+  ui.base = NULL;
+  ui.tree = NULL;
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
index 0000000..44f21da
--- /dev/null
+++ b/vcs-p4/p4client.c
@@ -0,0 +1,158 @@
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
+
+void p4_write_blob(const char *base, unsigned mode, const unsigned char *sha1,
+		   const char *path)
+{
+	struct strbuf buf;
+	void *content;
+	enum object_type type;
+	unsigned long size;
+	int fd;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/%s", base, path);
+	content = read_sha1_file(sha1, &type, &size);
+	fd = open(buf.buf, O_WRONLY | O_CREAT, (mode & 0100) ? 0666 : 0777);
+	if (fd < 0) {
+		die("Got err %d", errno);
+	}
+	write_or_die(fd, content, size);
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
index 0000000..f0d0ded
--- /dev/null
+++ b/vcs-p4/p4client.h
@@ -0,0 +1,74 @@
+#ifndef P4CLIENT_H
+#define P4CLIENT_H
+
+#include <stdlib.h>
+#include <stdio.h>
+#include <string.h>
+#include "strbuf.h"
+
+/**
+ * buffer: print
+ * form: change
+ * info: filelog, where, sync
+ **/
+
+void p4_init(const char *const *env);
+
+int p4_call(int fds[], const char *arg0, int argc, char *const *argv);
+
+/** Calls back with a bunch of (data, level, line) **/
+#define p4_call_info(arg0, argc, argv, data, cb) \
+	(0 ? ((*(cb))((data), 0, NULL), 1) : \
+	 _p4_call_info(arg0, argc, argv, (void *)data, (void (*)(void *, int, const char *)) cb))
+
+/** Calls back with a bunch of (data, key, value); implies "-o" **/
+#define p4_call_form(arg0, argc, argv, data, cb) \
+	(0 ? ((*(cb))((data), NULL, NULL), 1) : \
+	 _p4_call_form(arg0, argc, argv, (void *)data, (void (*)(void *, const char *, const char *)) cb))
+
+/** Calls back with a bunch of (data, key, value); implies "-o", and
+ * is followed by sending back form data with "-i" automatically.
+ **/
+#define p4_call_form_io(arg0, argc, argv, data, cb)		\
+	(0 ? ({ __attribute__((unused)) const char *r = (*(cb))((data), NULL, NULL); 1;}) : \
+	 _p4_call_form_io(arg0, argc, argv, (void *)data, (const char *(*)(void *, const char *, const char *)) cb))
+
+/** Calls back with a bunch of (data, buffer, len) **/
+#define p4_call_buffer(arg0, argc, argv, data, cb) \
+	(0 ?  ((*(cb))((data), NULL, 0), 1) : \
+	 _p4_call_buffer(arg0, argc, argv, (void *)data, (void (*)(void *, const char *, int)) cb))
+
+#define p4_call_unknown(arg0, argc, argv) _p4_call_unknown(arg0, argc, argv)
+
+/** One or the other of p4_write_tree and p4_write_blob will
+ * actually be effective.
+ **/
+void p4_write_tree(const char *base, const unsigned char *sha1);
+
+const char *get_tree_path(const unsigned char *sha1, const char *path,
+			  unsigned *mode, unsigned long *size);
+
+void p4_write_blob(const char *base, unsigned mode, const unsigned char *sha1,
+		   const char *path);
+
+void p4_release_tree(void);
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
+int _p4_call_form_io(const char *arg0, int argc, char *const *argv, void *data,
+		     const char *(*cb)(void *data, const char *key, const char *value));
+
+int _p4_call_buffer(const char *arg0, int argc, char *const *argv, void *data,
+		    void (*cb)(void *data, const char *buffer, int len));
+
+int _p4_call_unknown(const char *arg0, int argc, char *const *argv);
+
+#endif
diff --git a/vcs-p4/vcs-p4.c b/vcs-p4/vcs-p4.c
new file mode 100644
index 0000000..1b9147c
--- /dev/null
+++ b/vcs-p4/vcs-p4.c
@@ -0,0 +1,1250 @@
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
+static void add_mapped_changeset(struct p4_depot *depot, struct commit *commit,
+				 struct p4_changeset *change)
+{
+	change->original = commit;
+	ALLOC_GROW(depot->added, depot->added_nr + 1, depot->added_alloc);
+	depot->added[depot->added_nr++] = change;
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
+	int i;
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
+	for (i = 0; i < depot->added_nr; i++) {
+		if (depot->added[i]->original == commit)
+			return depot->added[i];
+	}
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
+	fprintf(stderr, "Failed to identify %s\n", path);
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
+/** P4 operations **/
+
+static void set_working(struct p4_codeline *codeline, int level, const char *line)
+{
+	char *working = strrchr(line, ' ');
+	if (working)
+		codeline->working = xstrdup(working + 1);
+}
+
+static int p4_where(struct p4_codeline *codeline)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addstr(&buf, codeline->path);
+	argv[0] = buf.buf;
+	p4_call_info("where", 1, argv, codeline, set_working);
+	return codeline->working ? 0 : -1;
+}
+
+static void sync_cb(void *data, int level, const char *line)
+{
+	//fprintf(stderr, "%s\n", line);
+}
+
+static void p4_sync(struct p4_changeset *changeset)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	printf("progress syncing %s/...\n", changeset->codeline->working);
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/...@%lu",
+		    changeset->codeline->working, changeset->codeline->head->number);
+	argv[0] = buf.buf;
+	p4_call_info("sync", 1, argv, NULL, sync_cb);
+}
+
+static void p4_integrate(struct p4_codeline *codeline,
+			 struct p4_changeset *side)
+{
+	char *argv[3];
+	struct strbuf buf;
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s/...@%lu", side->codeline->path, side->number);
+	argv[0] = "-d";
+	argv[1] = strbuf_detach(&buf, 0);
+	strbuf_addf(&buf, "%s/...", codeline->path);
+	argv[2] = buf.buf;
+	p4_call_unknown("integrate", 3, argv);
+	free(argv[1]);
+	strbuf_release(&buf);
+}
+
+static void p4_resolve(void)
+{
+	p4_call_unknown("resolve", 0, NULL);
+}
+
+static void p4_edit(struct p4_codeline *codeline, const char *path)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call_unknown("edit", 1, argv);
+	strbuf_release(&buf);
+}
+
+static void p4_add(struct p4_codeline *codeline, const char *path)
+{
+	char *argv[1];
+	struct strbuf buf;
+
+	strbuf_init(&buf, 0);
+	strbuf_addf(&buf, "%s%s", codeline->working, path);
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
+	strbuf_addf(&buf, "%s%s", codeline->working, path);
+	argv[0] = buf.buf;
+	p4_call(NULL, "delete", 1, argv);
+	strbuf_release(&buf);
+	p4_complete();
+}
+
+static const char *change_cb(struct commit *commit, const char *key, const char *value)
+{
+	fprintf(stderr, "Form for %s\n", key);
+	if (!strcmp(key, "Description")) {
+		const char *message = strstr(commit->buffer, "\n\n");
+		if (message)
+			message += 2;
+		fprintf(stderr, "Return %s\n", message);
+		return message;
+	}
+	return value;
+}
+
+static void submit_cb(unsigned long *data, int level, const char *line)
+{
+	int len = strlen(line);
+	if (!prefixcmp(line, "Change ") && len > 18 &&
+	    !strncmp(line + len - strlen(" submitted."), " submitted.",
+		     strlen(" submitted.")))
+		*data = atoi(line + 7);
+}
+
+static unsigned long p4_submit(struct commit *commit)
+{
+	unsigned long ret;
+	char *argv[1];
+	p4_call_form_io("change", 0, NULL, commit, change_cb);
+	argv[0] = "-i";
+	p4_call_info("submit", 1, argv, &ret, submit_cb);
+	return ret;
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
+	char *argv[1];
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
+	argv[0] = line.buf;
+	p4_call_form("change", 1, argv, &data, p4_change_cb);
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
+			if (!rev_ints->revision->changeset) {
+				rev_ints = rev_ints->next;
+				continue;
+			}
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
+static void export_change(struct diff_options *options,
+			  unsigned old_mode, unsigned new_mode,
+			  const unsigned char *old_sha1,
+			  const unsigned char *new_sha1,
+			  const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	p4_edit(codeline, path);
+	p4_write_blob(codeline->working, new_mode, new_sha1, path);
+}
+
+static void export_add_remove(struct diff_options *options,
+			      int addremove, unsigned mode,
+			      const unsigned char *sha1,
+			      const char *path)
+{
+	struct p4_codeline *codeline = options->format_callback_data;
+	if (addremove == '+') {
+		p4_write_blob(codeline->working, mode, sha1, path);
+		p4_add(codeline, path);
+	} else if (addremove == '-') {
+		p4_delete(codeline, path);
+	}
+}
+
+static void export_p4(struct p4_depot *depot, unsigned char *sha1, const char *ref)
+{
+	struct p4_codeline *target;
+	struct strbuf buf;
+
+	// check client
+
+	fprintf(stderr, "Exporting %s to %s\n", sha1_to_hex(sha1), ref);
+
+	target = import_depot(depot, ref);
+
+	strbuf_init(&buf, 0);
+
+	struct p4_changeset *parent = NULL, *integrate = NULL;
+	struct commit *commit, *git_parent = NULL;
+	struct commit_list *parents;
+	commit = lookup_commit(sha1);
+	parse_commit(commit);
+	for (parents = commit->parents; parents; parents = parents->next) {
+		struct p4_changeset *p4_parent =
+			changeset_from_commit(depot, parents->item);
+		if (p4_parent) {
+			if (p4_parent->codeline == target) {
+				parent = p4_parent;
+				git_parent = parents->item;
+			} else
+				integrate = p4_parent;
+		} else {
+			fprintf(stderr, "Unknown parent\n");
+			return;
+		}
+	}
+	if (target->head != parent) {
+		if (!parent) {
+			printf("progress Couldn't find parent\n");
+			return;
+		}
+		printf("progress not up-to-date\n");
+		return;
+	}
+	if (p4_where(target))
+		return;
+	p4_sync(parent);
+
+	if (!parent) {
+		// Need to start new codeline
+		return;
+	}
+	p4_write_tree(target->working, commit->tree->object.sha1);
+	if (integrate) {
+		p4_integrate(target, integrate);
+		fprintf(stderr, "Exporting merge\n");
+		// Dunno how to do this
+		p4_resolve();
+		//return;
+	}
+	struct tree_desc pre, post;
+	struct diff_options opts;
+	memset(&opts, 0, sizeof(opts));
+	parse_tree(commit->tree);
+	parse_tree(git_parent->tree);
+	init_tree_desc(&pre, git_parent->tree->buffer, git_parent->tree->size);
+	init_tree_desc(&post, commit->tree->buffer, commit->tree->size);
+	opts.change = export_change;
+	opts.add_remove = export_add_remove;
+	opts.format_callback_data = target;
+	opts.flags = DIFF_OPT_RECURSIVE;
+	diff_tree(&pre, &post, "/", &opts);
+
+	unsigned long change = p4_submit(commit);
+
+	p4_release_tree();
+
+	target->filelog_done = 0;
+	follow_codeline(target);
+	struct p4_changeset *changeset = get_changeset(target, change);
+	add_mapped_changeset(depot, commit, changeset);
+	report_codeline(target, changeset);
+}
+
+static const char **env;
+static int env_nr;
+static int env_alloc;
+
+static int connected;
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
+static void connect_to_p4(void)
+{
+	if (!connected)
+		p4_init(env);
+	connected = 1;
+}
+
+static void disconnect_from_p4(void)
+{
+	if (LIST_P4_OPERATIONS)
+		fprintf(stderr, "Prints done: %d\n", prints_done);
+	if (connected)
+		p4_fini();
+	connected = 0;
+}
+
+const char *get_tree_path(const unsigned char *sha1, const char *path,
+			  unsigned *mode, unsigned long *size)
+{
+	unsigned char blob_sha1[20];
+	enum object_type type;
+	if (get_tree_entry(sha1, path, blob_sha1, mode)) {
+		error("Couldn't find %s in %s", path, sha1_to_hex(sha1));
+		return NULL;
+	}
+	return read_sha1_file(blob_sha1, &type, size);
+}
+
+int main(int argc, const char **argv)
+{
+	struct remote *remote;
+	struct strbuf buf;
+	struct p4_depot *depot = NULL;
+
+	setup_git_directory();
+
+	if (argc < 1) {
+		fprintf(stderr, "Remote needed");
+		return 1;
+	}
+
+	remote = remote_get(argv[1]);
+	git_config(handle_config, remote);
+
+	ALLOC_GROW(env, env_nr + 1, env_alloc);
+	env[env_nr++] = NULL;
+
+	strbuf_init(&buf, 0);
+	do {
+		if (strbuf_getline(&buf, stdin, '\n') == EOF)
+			break;
+		if (!*buf.buf)
+			break;
+		if (!strcmp(buf.buf, "capabilities")) {
+			printf("import\n");
+			printf("export\n");
+			printf("\n");
+			fflush(stdout);
+		} else if (!prefixcmp(buf.buf, "import ")) {
+			save_commit_buffer = 1;
+
+			find_new_codelines = 0;
+
+			connect_to_p4();
+
+			if (!depot)
+				depot = get_depot();
+
+			identify_changeset(import_depot(depot, buf.buf + strlen("import "))->head);
+		} else if (!strcmp(buf.buf, "list")) {
+			int i;
+
+			git_config(handle_config, remote);
+
+			ALLOC_GROW(env, env_nr + 1, env_alloc);
+			env[env_nr++] = NULL;
+
+			if (find_new_codelines) {
+				struct p4_codeline *codeline;
+				save_commit_buffer = 1;
+
+				connect_to_p4();
+
+				if (!depot)
+					depot = get_depot();
+
+				for (i = 0; i < codeline_nr; i++)
+					import_depot(depot,
+						     codeline_to_refname(codelines[i]));
+
+				for (codeline = depot->codelines; codeline;
+				     codeline = codeline->next) {
+					if (codeline->ignore)
+						continue;
+					follow_codeline(codeline);
+					printf("? %s %s\n", codeline->refname,
+					       codeline->head == codeline->history ?
+					       "unchanged" : "");
+				}
+			} else {
+				for (i = 0; i < codeline_nr; i++)
+					printf("? %s\n",
+					       codeline_to_refname(codelines[i]));
+			}
+			printf("\n");
+			fflush(stdout);
+		} else if (!prefixcmp(buf.buf, "export ")) {
+			unsigned char sha1[20];
+			char *hash = buf.buf + strlen("export ");
+			char *ref = strchr(hash, ' ');
+			*(ref++) = '\0';
+			get_sha1(hash, sha1);
+
+			connect_to_p4();
+
+			if (!depot)
+				depot = get_depot();
+
+			export_p4(depot, sha1, ref);
+			// 1: check whether the import of the target location
+			//    is up-to-date
+
+			// 2: find the target location in the client view
+
+			// 3: bring the client view up-to-date with the target
+			//    location
+
+			// 4: recheck that this matches the tree
+
+			// 5: open the necessary files in the client
+
+			// 6: replace the necessary files in the filesystem
+
+			// 7: submit
+
+			// 8: reimport
+
+			// 9: go back to (3)
+		} else {
+			disconnect_from_p4();
+			fprintf(stderr, "Unrecognized command %s\n", buf.buf);
+			return 1;
+		}
+		strbuf_reset(&buf);
+	} while (1);
+	disconnect_from_p4();
+	return 0;
+}
diff --git a/vcs-p4/vcs-p4.h b/vcs-p4/vcs-p4.h
new file mode 100644
index 0000000..104ef90
--- /dev/null
+++ b/vcs-p4/vcs-p4.h
@@ -0,0 +1,135 @@
+#ifndef VCS_P4_H
+#define VCS_P4_H
+
+struct p4_depot {
+	struct p4_codeline *codelines;
+
+	int next_mark;
+
+	struct p4_changeset **added;
+	int added_nr;
+	int added_alloc;
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
+	/** Used for the original git commit this was exported as **/
+	struct commit *original;
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
1.6.4.32.gf5148
