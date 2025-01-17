Received: from vuizook.err.no (vuizook.err.no [178.255.151.162])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53E4A1F6687
	for <git@vger.kernel.org>; Fri, 17 Jan 2025 08:22:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=178.255.151.162
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1737102160; cv=none; b=Z7ncTSv5minmB1EgU+vHHpwDQQebeujg1Du4FisgPKUvrRyk9bQsR4cwppwnJ6OTEzFfEvpzZDgFkkuoqUAXEEmAC2xfT6AcF6QHmBAIUbanVnGGLPp8ay//loNBDWc24+wHlgypHsFy9cr4NYMVTVJKRoEIif05pQnLcBJ2E/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1737102160; c=relaxed/simple;
	bh=NSFnQgawqcwAx1HKo/9MkIoHs1wzvyc9IkmXLOx8pN0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=GZ/gEexeeFXEf5I8S5BLmUi0Tj18zfPltEfpP7xefphq3TsQjbNMRMiSnT7hasg+PkIYT+jAaklLmsTR1xrtSw0B6N4KBsbm1zhsAteKa5xNspkMO9SodIxu8u+dxr3nve6BSlcUktfPpChkSvKQ5oh7gCdrzu+htBinOME34kc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org; spf=pass smtp.mailfrom=glandium.org; arc=none smtp.client-ip=178.255.151.162
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=glandium.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=glandium.org
Received: from p3976092-ipxg00k01tokaisakaetozai.aichi.ocn.ne.jp ([221.188.33.92] helo=glandium.org)
	by vuizook.err.no with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <glandium@glandium.org>)
	id 1tYh6W-00E05N-2l;
	Fri, 17 Jan 2025 07:49:20 +0000
Received: from glandium by goemon.lan with local (Exim 4.96)
	(envelope-from <glandium@goemon>)
	id 1tYh6Q-0060OR-39;
	Fri, 17 Jan 2025 16:49:14 +0900
From: Mike Hommey <mh@glandium.org>
To: git@vger.kernel.org
Cc: gitster@pobox.com,
	Mike Hommey <mh@glandium.org>
Subject: [PATCH] connect: address -Wsign-compare warnings
Date: Fri, 17 Jan 2025 16:49:09 +0900
Message-ID: <20250117074909.1430067-1-mh@glandium.org>
X-Mailer: git-send-email 2.48.1.2.g265affcb1f.dirty
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Most of the warnings were about loop variables being declared as ints
with a condition using a size_t, whereby switching the variable to
size_t fixes the warning.

One other case was comparing the result of strlen to an int passed
as an argument, which turns out could just as well be passed as a
size_t, albeit trickling to other functions.

Signed-off-by: Mike Hommey <mh@glandium.org>
---
 connect.c | 23 +++++++++++------------
 1 file changed, 11 insertions(+), 12 deletions(-)

diff --git a/connect.c b/connect.c
index 10fad43e98..91f3990014 100644
--- a/connect.c
+++ b/connect.c
@@ -1,5 +1,4 @@
 #define USE_THE_REPOSITORY_VARIABLE
-#define DISABLE_SIGN_COMPARE_WARNINGS
 
 #include "git-compat-util.h"
 #include "config.h"
@@ -77,7 +76,7 @@ static NORETURN void die_initial_contact(int unexpected)
 /* Checks if the server supports the capability 'c' */
 int server_supports_v2(const char *c)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -96,7 +95,7 @@ void ensure_server_supports_v2(const char *c)
 
 int server_feature_v2(const char *c, const char **v)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -112,7 +111,7 @@ int server_feature_v2(const char *c, const char **v)
 int server_supports_feature(const char *c, const char *feature,
 			    int die_on_error)
 {
-	int i;
+	size_t i;
 
 	for (i = 0; i < server_capabilities_v2.nr; i++) {
 		const char *out;
@@ -232,12 +231,12 @@ static void annotate_refs_with_symref_info(struct ref *ref)
 	string_list_clear(&symref, 0);
 }
 
-static void process_capabilities(struct packet_reader *reader, int *linelen)
+static void process_capabilities(struct packet_reader *reader, size_t *linelen)
 {
 	const char *feat_val;
 	size_t feat_len;
 	const char *line = reader->line;
-	int nul_location = strlen(line);
+	size_t nul_location = strlen(line);
 	if (nul_location == *linelen)
 		return;
 	server_capabilities_v1 = xstrdup(line + nul_location + 1);
@@ -271,14 +270,14 @@ static int process_dummy_ref(const struct packet_reader *reader)
 		!strcmp(name, "capabilities^{}");
 }
 
-static void check_no_capabilities(const char *line, int len)
+static void check_no_capabilities(const char *line, size_t len)
 {
 	if (strlen(line) != len)
 		warning(_("ignoring capabilities after first line '%s'"),
 			line + strlen(line));
 }
 
-static int process_ref(const struct packet_reader *reader, int len,
+static int process_ref(const struct packet_reader *reader, size_t len,
 		       struct ref ***list, unsigned int flags,
 		       struct oid_array *extra_have)
 {
@@ -306,7 +305,7 @@ static int process_ref(const struct packet_reader *reader, int len,
 	return 1;
 }
 
-static int process_shallow(const struct packet_reader *reader, int len,
+static int process_shallow(const struct packet_reader *reader, size_t len,
 			   struct oid_array *shallow_points)
 {
 	const char *line = reader->line;
@@ -341,7 +340,7 @@ struct ref **get_remote_heads(struct packet_reader *reader,
 			      struct oid_array *shallow_points)
 {
 	struct ref **orig_list = list;
-	int len = 0;
+	size_t len = 0;
 	enum get_remote_heads_state state = EXPECTING_FIRST_REF;
 
 	*list = NULL;
@@ -394,7 +393,7 @@ static int process_ref_v2(struct packet_reader *reader, struct ref ***list,
 			  const char **unborn_head_target)
 {
 	int ret = 1;
-	int i = 0;
+	size_t i = 0;
 	struct object_id old_oid;
 	struct ref *ref;
 	struct string_list line_sections = STRING_LIST_INIT_DUP;
@@ -552,7 +551,7 @@ struct ref **get_remote_refs(int fd_out, struct packet_reader *reader,
 			     const struct string_list *server_options,
 			     int stateless_rpc)
 {
-	int i;
+	size_t i;
 	struct strvec *ref_prefixes = transport_options ?
 		&transport_options->ref_prefixes : NULL;
 	const char **unborn_head_target = transport_options ?
-- 
2.48.1.1.g7a79e56076.dirty

