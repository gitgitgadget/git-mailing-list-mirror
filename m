From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH 2/1] support -4 and -6 switches for remote operations
Date: Sat, 30 Jan 2016 13:13:53 +0000
Message-ID: <20160130131353.GA20429@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 30 14:14:08 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aPVLj-0003N2-V2
	for gcvg-git-2@plane.gmane.org; Sat, 30 Jan 2016 14:14:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754128AbcA3NNz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 30 Jan 2016 08:13:55 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:53628 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752786AbcA3NNy (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jan 2016 08:13:54 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id F2B501F736;
	Sat, 30 Jan 2016 13:13:53 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160130085056.GA20118@dcvr.yhbt.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285110>

Sometimes, it is necessary to force IPv4-only or IPv6-only
operation on networks where name lookups may return a
non-routable address and stall remote operations.

The ssh(1) command has an equivalent switches which we may
pass when we run them.

rsync support is untouched for now since it is deprecated
and scheduled to be removed.

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/fetch-options.txt |  8 ++++++++
 Documentation/git-push.txt      |  7 +++++++
 builtin/clone.c                 |  4 ++++
 builtin/fetch.c                 |  4 ++++
 builtin/push.c                  |  4 ++++
 connect.c                       |  8 ++++++++
 connect.h                       |  2 ++
 http.c                          |  9 +++++++++
 http.h                          |  1 +
 remote-curl.c                   | 19 +++++++++++++++++++
 transport-helper.c              |  7 +++++++
 transport.c                     | 18 ++++++++++++++++++
 transport.h                     | 11 +++++++++++
 13 files changed, 102 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 952dfdf..6ec7dde 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -158,3 +158,11 @@ endif::git-pull[]
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
+
+-4::
+--ipv4::
+	Resolve IPv4 addresses only, ignoring IPv6 addresses.
+
+-6::
+--ipv6::
+	Resolve IPv6 addresses only, ignoring IPv4 addresses.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 32482ce..559c166 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -277,6 +277,13 @@ origin +master` to force a push to the `master` branch). See the
 	default is --verify, giving the hook a chance to prevent the
 	push.  With --no-verify, the hook is bypassed completely.
 
+-4::
+--ipv4::
+	Resolve IPv4 addresses only, ignoring IPv6 addresses.
+
+-6::
+--ipv6::
+	Resolve IPv6 addresses only, ignoring IPv4 addresses.
 
 include::urls-remotes.txt[]
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 81e238f..3feae64 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -47,6 +47,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static int ipv4, ipv6;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
@@ -92,6 +93,8 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_BOOL('4', "ipv4", &ipv4, N_("resolve IPv4 addresses only")),
+	OPT_BOOL('6', "ipv6", &ipv6, N_("resolve IPv6 addresses only")),
 	OPT_END()
 };
 
@@ -970,6 +973,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
+	transport_set_family(transport, ipv4, ipv6);
 
 	path = get_repo_path(remote->url[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..c77af86 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static int ipv4, ipv6;
 static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
@@ -127,6 +128,8 @@ static struct option builtin_fetch_options[] = {
 		 N_("accept refs that update .git/shallow")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
 	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
+	OPT_BOOL('4', "ipv4", &ipv4, N_("resolve IPv4 addresses only")),
+	OPT_BOOL('6', "ipv6", &ipv6, N_("resolve IPv6 addresses only")),
 	OPT_END()
 };
 
@@ -864,6 +867,7 @@ static struct transport *prepare_transport(struct remote *remote)
 	struct transport *transport;
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
+	transport_set_family(transport, ipv4, ipv6);
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/builtin/push.c b/builtin/push.c
index 960ffc3..e0e8b40 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -23,6 +23,7 @@ static const char *receivepack;
 static int verbosity;
 static int progress = -1;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static int ipv4, ipv6;
 
 static struct push_cas_option cas;
 
@@ -346,6 +347,7 @@ static int push_with_options(struct transport *transport, int flags)
 	unsigned int reject_reasons;
 
 	transport_set_verbosity(transport, verbosity, progress);
+	transport_set_family(transport, ipv4, ipv6);
 
 	if (receivepack)
 		transport_set_option(transport,
@@ -565,6 +567,8 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
+		OPT_BOOL('4', "ipv4", &ipv4, N_("resolve IPv4 addresses only")),
+		OPT_BOOL('6', "ipv6", &ipv6, N_("resolve IPv6 addresses only")),
 		OPT_END()
 	};
 
diff --git a/connect.c b/connect.c
index fd7ffe1..99178d0 100644
--- a/connect.c
+++ b/connect.c
@@ -357,6 +357,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 		port = "<none>";
 
 	memset(&hints, 0, sizeof(hints));
+	if (flags & CONNECT_IPV4ONLY)
+		hints.ai_family = AF_INET;
+	else if (flags & CONNECT_IPV6ONLY)
+		hints.ai_family = AF_INET6;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 
@@ -783,6 +787,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			argv_array_push(&conn->args, ssh);
+			if (flags & CONNECT_IPV4ONLY)
+				argv_array_push(&conn->args, "-4");
+			else if (flags & CONNECT_IPV6ONLY)
+				argv_array_push(&conn->args, "-6");
 			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
diff --git a/connect.h b/connect.h
index c41a685..1cf2412 100644
--- a/connect.h
+++ b/connect.h
@@ -3,6 +3,8 @@
 
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
+#define CONNECT_IPV4ONLY      (1u << 2)
+#define CONNECT_IPV6ONLY      (1u << 3)
 extern struct child_process *git_connect(int fd[2], const char *url, const char *prog, int flags);
 extern int finish_connect(struct child_process *conn);
 extern int git_connection_is_socket(struct child_process *conn);
diff --git a/http.c b/http.c
index 0da9e66..67e7bc2 100644
--- a/http.c
+++ b/http.c
@@ -11,6 +11,11 @@
 #include "gettext.h"
 #include "transport.h"
 
+#if LIBCURL_VERSION_NUM >= 0x070a08
+long int git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
+#else
+long int git_curl_ipresolve;
+#endif
 int active_requests;
 int http_is_verbose;
 size_t http_post_buffer = 16 * LARGE_PACKET_MAX;
@@ -692,6 +697,10 @@ struct active_request_slot *get_active_slot(void)
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPGET, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_FAILONERROR, 1);
 	curl_easy_setopt(slot->curl, CURLOPT_RANGE, NULL);
+
+#if LIBCURL_VERSION_NUM >= 0x070a08
+	curl_easy_setopt(slot->curl, CURLOPT_IPRESOLVE, git_curl_ipresolve);
+#endif
 #ifdef LIBCURL_CAN_HANDLE_AUTH_ANY
 	curl_easy_setopt(slot->curl, CURLOPT_HTTPAUTH, http_auth_methods);
 #endif
diff --git a/http.h b/http.h
index 4f97b60..fa45c2b 100644
--- a/http.h
+++ b/http.h
@@ -106,6 +106,7 @@ extern void http_init(struct remote *remote, const char *url,
 		      int proactive_auth);
 extern void http_cleanup(void);
 
+extern long int git_curl_ipresolve;
 extern int active_requests;
 extern int http_is_verbose;
 extern size_t http_post_buffer;
diff --git a/remote-curl.c b/remote-curl.c
index c704857..2297fa1 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -119,6 +119,25 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+
+#if LIBCURL_VERSION_NUM >= 0x070a08
+	} else if (!strcmp(name, "ipv4")) {
+		if (!strcmp(value, "true"))
+			git_curl_ipresolve = CURL_IPRESOLVE_V4;
+		else if (!strcmp(value, "false"))
+			git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
+		else
+			return -1;
+		return 0;
+	} else if (!strcmp(name, "ipv6")) {
+		if (!strcmp(value, "true"))
+			git_curl_ipresolve = CURL_IPRESOLVE_V6;
+		else if (!strcmp(value, "false"))
+			git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
+		else
+			return -1;
+		return 0;
+#endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
 	} else {
 		return 1 /* unsupported */;
 	}
diff --git a/transport-helper.c b/transport-helper.c
index e45d88f..e6ffb9a 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -258,6 +258,8 @@ static const char *boolean_options[] = {
 	TRANS_OPT_THIN,
 	TRANS_OPT_KEEP,
 	TRANS_OPT_FOLLOWTAGS,
+	TRANS_OPT_IPV4,
+	TRANS_OPT_IPV6,
 	};
 
 static int set_helper_option(struct transport *transport,
@@ -321,6 +323,11 @@ static void standard_options(struct transport *t)
 	if (n >= sizeof(buf))
 		die("impossibly large verbosity value");
 	set_helper_option(t, "verbosity", buf);
+
+	if (t->ipv4)
+		set_helper_option(t, "ipv4", "true");
+	if (t->ipv6)
+		set_helper_option(t, "ipv6", "true");
 }
 
 static int release_helper(struct transport *transport)
diff --git a/transport.c b/transport.c
index 9ae7184..8fd31d3 100644
--- a/transport.c
+++ b/transport.c
@@ -489,6 +489,10 @@ static int connect_setup(struct transport *transport, int for_push)
 	if (data->conn)
 		return 0;
 
+	if (transport->ipv4)
+		flags |= CONNECT_IPV4ONLY;
+	if (transport->ipv6)
+		flags |= CONNECT_IPV6ONLY;
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
@@ -1086,6 +1090,20 @@ void transport_set_verbosity(struct transport *transport, int verbosity,
 		transport->progress = verbosity >= 0 && isatty(2);
 }
 
+void transport_set_family(struct transport *transport, int ipv4, int ipv6)
+{
+	if (ipv4 && ipv6)
+		die("-4/--ipv4 and -6/--ipv6 are incompatible");
+	if (ipv4) {
+		transport->ipv4 = 1;
+		transport_set_option(transport, TRANS_OPT_IPV4, "true");
+	}
+	if (ipv6) {
+		transport->ipv6 = 1;
+		transport_set_option(transport, TRANS_OPT_IPV6, "true");
+	}
+}
+
 static void die_with_unpushed_submodules(struct string_list *needs_pushing)
 {
 	int i;
diff --git a/transport.h b/transport.h
index 8ebaaf2..f9f3c00 100644
--- a/transport.h
+++ b/transport.h
@@ -104,6 +104,10 @@ struct transport {
 	 * in transport_set_verbosity().
 	 **/
 	unsigned progress : 1;
+
+	/* mutually exclusive, set by transport_set_family */
+	unsigned ipv4 : 1;
+	unsigned ipv6 : 1;
 	/*
 	 * If transport is at least potentially smart, this points to
 	 * git_transport_options structure to use in case transport
@@ -180,6 +184,12 @@ int transport_restrict_protocols(void);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Limit to IPv4 only */
+#define TRANS_OPT_IPV4 "ipv4"
+
+/* Limit to IPv6 only */
+#define TRANS_OPT_IPV6 "ipv6"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
@@ -188,6 +198,7 @@ int transport_set_option(struct transport *transport, const char *name,
 			 const char *value);
 void transport_set_verbosity(struct transport *transport, int verbosity,
 	int force_progress);
+void transport_set_family(struct transport *transport, int ipv4, int ipv6);
 
 #define REJECT_NON_FF_HEAD     0x01
 #define REJECT_NON_FF_OTHER    0x02
-- 
EW
