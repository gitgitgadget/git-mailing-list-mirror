From: Jeff King <peff@peff.net>
Subject: [PATCH 2/3] add basic lua infrastructure
Date: Mon, 24 Sep 2012 20:25:12 -0400
Message-ID: <20120925002511.GB19605@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 25 02:25:36 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGIxu-0008Ot-G4
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 02:25:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751991Ab2IYAZT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Sep 2012 20:25:19 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57446 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751604Ab2IYAZS (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Sep 2012 20:25:18 -0400
Received: (qmail 7421 invoked by uid 107); 25 Sep 2012 00:25:45 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Sep 2012 20:25:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Sep 2012 20:25:12 -0400
Content-Disposition: inline
In-Reply-To: <20120925002325.GA19560@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206337>

This adds a small module for examining parts of a commit
from inside a lua interpreter. Eventually you'll be able to
do grep-like filtering and --pretty formatting.

The most naive presentation would be to parse the whole
commit and put it in a lua table. However, instead we build
upon the incremental parsing used by the --format parser,
and lazily parse bits of the commit as the lua code requests
them.

Signed-off-by: Jeff King <peff@peff.net>
---
Set "USE_LUA" in your Makefile to turn it on.

 Makefile     |   7 +++
 lua-commit.c | 166 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 lua-commit.h |   9 ++++
 3 files changed, 182 insertions(+)
 create mode 100644 lua-commit.c
 create mode 100644 lua-commit.h

diff --git a/Makefile b/Makefile
index a49d1db..54473e2 100644
--- a/Makefile
+++ b/Makefile
@@ -636,6 +636,7 @@ LIB_H += log-tree.h
 LIB_H += list-objects.h
 LIB_H += ll-merge.h
 LIB_H += log-tree.h
+LIB_H += lua-commit.h
 LIB_H += mailmap.h
 LIB_H += merge-file.h
 LIB_H += merge-recursive.h
@@ -749,6 +750,7 @@ LIB_OBJS += log-tree.o
 LIB_OBJS += ll-merge.o
 LIB_OBJS += lockfile.o
 LIB_OBJS += log-tree.o
+LIB_OBJS += lua-commit.o
 LIB_OBJS += mailmap.o
 LIB_OBJS += match-trees.o
 LIB_OBJS += merge-file.o
@@ -1818,6 +1820,11 @@ endif
        COMPAT_OBJS += compat/nedmalloc/nedmalloc.o
 endif
 
+ifdef USE_LUA
+	BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
+	EXTLIBS += `pkg-config --libs lua5.2`
+endif
+
 ifdef GIT_TEST_CMP_USE_COPIED_CONTEXT
 	export GIT_TEST_CMP_USE_COPIED_CONTEXT
 endif
diff --git a/lua-commit.c b/lua-commit.c
new file mode 100644
index 0000000..ce1eeeb
--- /dev/null
+++ b/lua-commit.c
@@ -0,0 +1,166 @@
+#include "cache.h"
+#include "lua-commit.h"
+#include "commit.h"
+
+#ifndef USE_LUA
+
+static const char msg[] = "git was built without lua support";
+
+void lua_commit_init(const char *)
+{
+	die(msg);
+}
+
+void lua_commit_format(struct strbuf *,
+		       struct format_commit_context *)
+{
+	die(msg);
+}
+
+#else
+
+#include <lua.h>
+#include <lauxlib.h>
+#include <lualib.h>
+
+static lua_State *lua;
+
+/* XXX
+ * We need to access this from functions called from inside lua. Probably it
+ * would be cleaner use a lua "register" to let each function access it, but I
+ * haven't looked into it.
+ */
+static struct format_commit_context *c;
+
+static int lua_fun_hash(lua_State *lua)
+{
+	lua_pushstring(lua, sha1_to_hex(c->commit->object.sha1));
+	return 1;
+}
+
+static int lua_fun_abbrev(lua_State *lua)
+{
+	const char *hex;
+	unsigned char sha1[20];
+
+	hex = lua_tostring(lua, -1);
+	if (!hex || get_sha1_hex(hex, sha1)) {
+		lua_pushstring(lua, "abbrev requires a sha1");
+		lua_error(lua);
+	}
+
+	lua_pushstring(lua, find_unique_abbrev(sha1, c->pretty_ctx->abbrev));
+	return 1;
+}
+
+static int get_ident(lua_State *lua, const char *line, int len)
+{
+	struct ident_split s;
+
+	if (split_ident_line(&s, line, len) < 0) {
+		lua_pushstring(lua, "unable to parse ident line");
+		lua_error(lua);
+	}
+
+	lua_createtable(lua, 0, 2);
+	lua_pushstring(lua, "name");
+	lua_pushlstring(lua, s.name_begin, s.name_end - s.name_begin);
+	lua_settable(lua, -3);
+	lua_pushstring(lua, "email");
+	lua_pushlstring(lua, s.mail_begin, s.mail_end - s.mail_begin);
+	lua_settable(lua, -3);
+
+	/* XXX should also put date in the table */
+
+	return 1;
+}
+
+static int lua_fun_author(lua_State *lua)
+{
+	if (!c->commit_header_parsed)
+		parse_commit_header(c);
+	return get_ident(lua, c->message + c->author.off, c->author.len);
+}
+
+static int lua_fun_committer(lua_State *lua)
+{
+	if (!c->commit_header_parsed)
+		parse_commit_header(c);
+	return get_ident(lua, c->message + c->committer.off, c->committer.len);
+}
+
+static int lua_fun_message(lua_State *lua)
+{
+	lua_pushstring(lua, c->message + c->message_off + 1);
+	return 1;
+}
+
+static int lua_fun_subject(lua_State *lua)
+{
+	struct strbuf tmp = STRBUF_INIT;
+
+	if (!c->commit_header_parsed)
+		parse_commit_header(c);
+	if (!c->commit_message_parsed)
+		parse_commit_message(c);
+
+	format_subject(&tmp, c->message + c->subject_off, " ");
+	lua_pushlstring(lua, tmp.buf, tmp.len);
+	return 1;
+}
+
+static int lua_fun_body(lua_State *lua)
+{
+	if (!c->commit_header_parsed)
+		parse_commit_header(c);
+	if (!c->commit_message_parsed)
+		parse_commit_message(c);
+
+	lua_pushstring(lua, c->message + c->body_off);
+	return 1;
+}
+
+void lua_commit_init(const char *snippet)
+{
+	if (!lua) {
+		lua = luaL_newstate();
+		if (!lua)
+			die("unable to open lua interpreter");
+		luaL_openlibs(lua);
+
+#define REG(name) do { \
+	lua_pushcfunction(lua, lua_fun_##name); \
+	lua_setglobal(lua, #name); \
+} while(0)
+
+		REG(hash);
+		REG(abbrev);
+		REG(author);
+		REG(committer);
+		REG(message);
+		REG(subject);
+		REG(body);
+	}
+
+	if (luaL_loadstring(lua, snippet))
+		die("unable to load lua snippet: %s", snippet);
+}
+
+void lua_commit_format(struct strbuf *out,
+		       struct format_commit_context *context)
+{
+	const char *ret;
+	size_t len;
+
+	c = context;
+
+	lua_pushvalue(lua, -1);
+	if (lua_pcall(lua, 0, 1, 0))
+		die("lua failed: %s", lua_tostring(lua, -1));
+
+	ret = lua_tolstring(lua, -1, &len);
+	strbuf_add(out, ret, len);
+	lua_pop(lua, 1);
+}
+
+#endif /* USE_LUA */
diff --git a/lua-commit.h b/lua-commit.h
new file mode 100644
index 0000000..aaffced
--- /dev/null
+++ b/lua-commit.h
@@ -0,0 +1,9 @@
+#ifndef LUA_COMMIT_H
+#define LUA_COMMIT_H
+
+struct format_commit_context;
+
+void lua_commit_init(const char *snippet);
+void lua_commit_format(struct strbuf *out, struct format_commit_context *context);
+
+#endif
-- 
1.7.12.1.10.g6537447
