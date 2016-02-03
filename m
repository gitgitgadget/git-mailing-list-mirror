From: Eric Wong <normalperson@yhbt.net>
Subject: [PATCH v2 2/1] support -4 and -6 switches for remote operations
Date: Wed, 3 Feb 2016 04:09:14 +0000
Message-ID: <20160203040914.GA19840@dcvr.yhbt.net>
References: <20160128225123.GA20045@dcvr.yhbt.net>
 <xmqqegd1l13l.fsf@gitster.mtv.corp.google.com>
 <20160130085056.GA20118@dcvr.yhbt.net>
 <20160130131353.GA20429@dcvr.yhbt.net>
 <56AD4887.3070207@web.de>
 <20160131000144.GA10117@dcvr.yhbt.net>
 <20160131011314.GA22855@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Feb 03 05:09:21 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQokq-0001Ko-B4
	for gcvg-git-2@plane.gmane.org; Wed, 03 Feb 2016 05:09:21 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755439AbcBCEJR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Feb 2016 23:09:17 -0500
Received: from dcvr.yhbt.net ([64.71.152.64]:60892 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755282AbcBCEJP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Feb 2016 23:09:15 -0500
Received: from localhost (dcvr.yhbt.net [127.0.0.1])
	by dcvr.yhbt.net (Postfix) with ESMTP id 1AE991F754;
	Wed,  3 Feb 2016 04:09:15 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20160131011314.GA22855@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285327>

Jeff King <peff@peff.net> wrote:
>   OPT_SET_INT('4', "ipv4", &use_net,
>               N_("resolve IPv4 addresses only"), USE_NET_IPV4),
>   OPT_SET_INT('6', "ipv6", &use_net,
>               N_("resolve IPv6 addresses only"), USE_NET_IPV6),

Thanks, I missed OPT_SET_INT before.

> Using --no-ipv4 will set it back to USE_NET_ALL, which is probably OK.
> It will cancel a previous "--ipv4", which is logically consistent,
> though I guess some people might assume that "--no-ipv4" means "do not
> use ipv4 addresses". Supporting that would be more complicated.

Right, not worth the effort to support that and I prefer leaving
the "--no-" variants undocumented as an implementation artifact.

(no rush to review this, unlikely to be around the next few days)

-----------------8<------------------
Subject: [PATCH] support -4 and -6 switches for remote operations

Sometimes it is necessary to force IPv4-only or IPv6-only
operation on networks where name lookups may return a
non-routable address and stall remote operations.

The ssh(1) command has an equivalent switches which we may
pass when we run them.  There may be old ssh(1) implementations
out there which do not support these switches; they should
report the appropriate error in that case.

rsync support is untouched for now since it is deprecated
and scheduled to be removed.

v2:
 - switch from boolean ints to enum
 - shorted CONNECT_* macro names to be consistent with switches
 - remove unneeded TRANS_OPT_* macros and usage
 - remove transport_set_family wrapper, enum is enough validation
 - s/resolve/use/ in documentation
 - document potential (but unconfirmed) problems with some ssh(1)

Signed-off-by: Eric Wong <normalperson@yhbt.net>
---
 Documentation/fetch-options.txt |  8 ++++++++
 Documentation/git-push.txt      |  7 +++++++
 builtin/clone.c                 |  6 ++++++
 builtin/fetch.c                 |  6 ++++++
 builtin/push.c                  |  6 ++++++
 connect.c                       |  8 ++++++++
 connect.h                       |  2 ++
 http.c                          |  9 +++++++++
 http.h                          |  1 +
 remote-curl.c                   | 13 +++++++++++++
 transport-helper.c              | 15 +++++++++++++++
 transport.c                     |  6 ++++++
 transport.h                     |  8 ++++++++
 13 files changed, 95 insertions(+)

diff --git a/Documentation/fetch-options.txt b/Documentation/fetch-options.txt
index 952dfdf..036edfb 100644
--- a/Documentation/fetch-options.txt
+++ b/Documentation/fetch-options.txt
@@ -158,3 +158,11 @@ endif::git-pull[]
 	by default when it is attached to a terminal, unless -q
 	is specified. This flag forces progress status even if the
 	standard error stream is not directed to a terminal.
+
+-4::
+--ipv4::
+	Use IPv4 addresses only, ignoring IPv6 addresses.
+
+-6::
+--ipv6::
+	Use IPv6 addresses only, ignoring IPv4 addresses.
diff --git a/Documentation/git-push.txt b/Documentation/git-push.txt
index 32482ce..669a357 100644
--- a/Documentation/git-push.txt
+++ b/Documentation/git-push.txt
@@ -277,6 +277,13 @@ origin +master` to force a push to the `master` branch). See the
 	default is --verify, giving the hook a chance to prevent the
 	push.  With --no-verify, the hook is bypassed completely.
 
+-4::
+--ipv4::
+	Use IPv4 addresses only, ignoring IPv6 addresses.
+
+-6::
+--ipv6::
+	Use IPv6 addresses only, ignoring IPv4 addresses.
 
 include::urls-remotes.txt[]
 
diff --git a/builtin/clone.c b/builtin/clone.c
index 81e238f..592e6db 100644
--- a/builtin/clone.c
+++ b/builtin/clone.c
@@ -47,6 +47,7 @@ static const char *real_git_dir;
 static char *option_upload_pack = "git-upload-pack";
 static int option_verbosity;
 static int option_progress = -1;
+static enum transport_family family;
 static struct string_list option_config;
 static struct string_list option_reference;
 static int option_dissociate;
@@ -92,6 +93,10 @@ static struct option builtin_clone_options[] = {
 		   N_("separate git dir from working tree")),
 	OPT_STRING_LIST('c', "config", &option_config, N_("key=value"),
 			N_("set config inside the new repository")),
+	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
+			TRANSPORT_FAMILY_IPV4),
+	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
+			TRANSPORT_FAMILY_IPV6),
 	OPT_END()
 };
 
@@ -970,6 +975,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	remote = remote_get(option_origin);
 	transport = transport_get(remote, remote->url[0]);
 	transport_set_verbosity(transport, option_verbosity, option_progress);
+	transport->family = family;
 
 	path = get_repo_path(remote->url[0], &is_bundle);
 	is_local = option_local != 0 && path && !is_bundle;
diff --git a/builtin/fetch.c b/builtin/fetch.c
index 8e74213..03ba709 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -37,6 +37,7 @@ static int prune = -1; /* unspecified */
 static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
+static enum transport_family family;
 static int max_children = 1;
 static const char *depth;
 static const char *upload_pack;
@@ -127,6 +128,10 @@ static struct option builtin_fetch_options[] = {
 		 N_("accept refs that update .git/shallow")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
 	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
+	OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
+			TRANSPORT_FAMILY_IPV4),
+	OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
+			TRANSPORT_FAMILY_IPV6),
 	OPT_END()
 };
 
@@ -864,6 +869,7 @@ static struct transport *prepare_transport(struct remote *remote)
 	struct transport *transport;
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
+	transport->family = family;
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/builtin/push.c b/builtin/push.c
index 960ffc3..6e13b3c 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -23,6 +23,7 @@ static const char *receivepack;
 static int verbosity;
 static int progress = -1;
 static int recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
+static enum transport_family family;
 
 static struct push_cas_option cas;
 
@@ -346,6 +347,7 @@ static int push_with_options(struct transport *transport, int flags)
 	unsigned int reject_reasons;
 
 	transport_set_verbosity(transport, verbosity, progress);
+	transport->family = family;
 
 	if (receivepack)
 		transport_set_option(transport,
@@ -565,6 +567,10 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		  0, "signed", &push_cert, "yes|no|if-asked", N_("GPG sign the push"),
 		  PARSE_OPT_OPTARG, option_parse_push_signed },
 		OPT_BIT(0, "atomic", &flags, N_("request atomic transaction on remote side"), TRANSPORT_PUSH_ATOMIC),
+		OPT_SET_INT('4', "ipv4", &family, N_("use IPv4 addresses only"),
+				TRANSPORT_FAMILY_IPV4),
+		OPT_SET_INT('6', "ipv6", &family, N_("use IPv6 addresses only"),
+				TRANSPORT_FAMILY_IPV6),
 		OPT_END()
 	};
 
diff --git a/connect.c b/connect.c
index fd7ffe1..0478631 100644
--- a/connect.c
+++ b/connect.c
@@ -357,6 +357,10 @@ static int git_tcp_connect_sock(char *host, int flags)
 		port = "<none>";
 
 	memset(&hints, 0, sizeof(hints));
+	if (flags & CONNECT_IPV4)
+		hints.ai_family = AF_INET;
+	else if (flags & CONNECT_IPV6)
+		hints.ai_family = AF_INET6;
 	hints.ai_socktype = SOCK_STREAM;
 	hints.ai_protocol = IPPROTO_TCP;
 
@@ -783,6 +787,10 @@ struct child_process *git_connect(int fd[2], const char *url,
 			}
 
 			argv_array_push(&conn->args, ssh);
+			if (flags & CONNECT_IPV4)
+				argv_array_push(&conn->args, "-4");
+			else if (flags & CONNECT_IPV6)
+				argv_array_push(&conn->args, "-6");
 			if (tortoiseplink)
 				argv_array_push(&conn->args, "-batch");
 			if (port) {
diff --git a/connect.h b/connect.h
index c41a685..01f14cd 100644
--- a/connect.h
+++ b/connect.h
@@ -3,6 +3,8 @@
 
 #define CONNECT_VERBOSE       (1u << 0)
 #define CONNECT_DIAG_URL      (1u << 1)
+#define CONNECT_IPV4          (1u << 2)
+#define CONNECT_IPV6          (1u << 3)
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
index c704857..b33a1e4 100644
--- a/remote-curl.c
+++ b/remote-curl.c
@@ -119,6 +119,19 @@ static int set_option(const char *name, const char *value)
 		else
 			return -1;
 		return 0;
+
+#if LIBCURL_VERSION_NUM >= 0x070a08
+	} else if (!strcmp(name, "family")) {
+		if (!strcmp(value, "ipv4"))
+			git_curl_ipresolve = CURL_IPRESOLVE_V4;
+		else if (!strcmp(value, "ipv6"))
+			git_curl_ipresolve = CURL_IPRESOLVE_V6;
+		else if (!strcmp(value, "all"))
+			git_curl_ipresolve = CURL_IPRESOLVE_WHATEVER;
+		else
+			return -1;
+		return 0;
+#endif /* LIBCURL_VERSION_NUM >= 0x070a08 */
 	} else {
 		return 1 /* unsupported */;
 	}
diff --git a/transport-helper.c b/transport-helper.c
index e45d88f..f6b8e7b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -321,6 +321,21 @@ static void standard_options(struct transport *t)
 	if (n >= sizeof(buf))
 		die("impossibly large verbosity value");
 	set_helper_option(t, "verbosity", buf);
+
+	switch (t->family) {
+	case TRANSPORT_FAMILY_ALL:
+		/*
+		 * this is already the default,
+		 * do not break old remote helpers by setting "all" here
+		 */
+		break;
+	case TRANSPORT_FAMILY_IPV4:
+		set_helper_option(t, "family", "ipv4");
+		break;
+	case TRANSPORT_FAMILY_IPV6:
+		set_helper_option(t, "family", "ipv6");
+		break;
+	}
 }
 
 static int release_helper(struct transport *transport)
diff --git a/transport.c b/transport.c
index 9ae7184..afcec43 100644
--- a/transport.c
+++ b/transport.c
@@ -489,6 +489,12 @@ static int connect_setup(struct transport *transport, int for_push)
 	if (data->conn)
 		return 0;
 
+	switch (transport->family) {
+	case TRANSPORT_FAMILY_ALL: break;
+	case TRANSPORT_FAMILY_IPV4: flags |= CONNECT_IPV4; break;
+	case TRANSPORT_FAMILY_IPV6: flags |= CONNECT_IPV6; break;
+	}
+
 	data->conn = git_connect(data->fd, transport->url,
 				 for_push ? data->options.receivepack :
 				 data->options.uploadpack,
diff --git a/transport.h b/transport.h
index 8ebaaf2..c681408 100644
--- a/transport.h
+++ b/transport.h
@@ -18,6 +18,12 @@ struct git_transport_options {
 	struct push_cas_option *cas;
 };
 
+enum transport_family {
+	TRANSPORT_FAMILY_ALL = 0,
+	TRANSPORT_FAMILY_IPV4,
+	TRANSPORT_FAMILY_IPV6
+};
+
 struct transport {
 	struct remote *remote;
 	const char *url;
@@ -110,6 +116,8 @@ struct transport {
 	 * actually turns out to be smart.
 	 */
 	struct git_transport_options *smart_options;
+
+	enum transport_family family;
 };
 
 #define TRANSPORT_PUSH_ALL 1
-- 
EW
