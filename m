From: Stefan Beller <sbeller@google.com>
Subject: [RFC/WIP PATCH 05/11] transport: add infrastructure to support a protocol version number
Date: Tue, 26 May 2015 15:01:09 -0700
Message-ID: <1432677675-5118-6-git-send-email-sbeller@google.com>
References: <1432677675-5118-1-git-send-email-sbeller@google.com>
Cc: pclouds@gmail.com, peff@peff.net, gitster@pobox.com,
	Stefan Beller <sbeller@google.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 27 00:01:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YxMux-000208-Ao
	for gcvg-git-2@plane.gmane.org; Wed, 27 May 2015 00:01:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752309AbbEZWBk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 26 May 2015 18:01:40 -0400
Received: from mail-ie0-f173.google.com ([209.85.223.173]:35273 "EHLO
	mail-ie0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751918AbbEZWBf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 26 May 2015 18:01:35 -0400
Received: by iesa3 with SMTP id a3so29208ies.2
        for <git@vger.kernel.org>; Tue, 26 May 2015 15:01:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=DUngTBuVOzXGyogb5cT1KNwmO5HYpXdKvAqhD9OJI9c=;
        b=ZXSqP973Cdt3aV/y+Jp2GyAUYBJhBL6O3XkHIP/rx/rVZrBNBVzDQTAbWmLbFHN4v2
         LaqmUZwZNZRXmAaeJ6p7FRZ8y07j2/ByBf/dhmcjB0D9WMWO/lLUlkw+BaDEud7ZgU9c
         X84R+da/Zwmw3O2S6AaN13iUStkofGLONSgeCJECqi3yon2dA/gdmUKvsfrvMCEKll4x
         J7QJMgJVhpCXRFn6j5nxg2Ki5ojCUVW4SYlVEFGL6lORbb09h3D550+a0EEOQwM0kty9
         BSSxwOXPoDeP3OOBAKW0eYwAwv2geweSdqKRF7R7Q/qprxXac4zCIag9yPDOU3ghiyda
         1Q/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=DUngTBuVOzXGyogb5cT1KNwmO5HYpXdKvAqhD9OJI9c=;
        b=Uqx62TK5rWszoP2O/mFcekXbzdThPD/azacD3Gy98mwpb+JS7HHBBFSu5SOG01S/bY
         EBdXt7r4Dp1VCU9M4+EM/AnkR1UO2cFwe/HpPOgXQsjr/wVhGXXEYbCU4iDZ0IvXG2f1
         n9ko8XGrFqnKQ9T04GjhbjJCqp5ulBDlDMq/2yK7Ldl61u1jodC+xcqChIAhBKSZC2Se
         l9r6oliRNMMsZNln/OCysEz1T4No8ykfnRZKeGHt2Z4L/EpomW9n715z3ChXMjqAGogT
         hrw/cHKbgJmyuP0DWYKu2j0xGHdpobmpDDdEsKE5QX9Z7fizcC8x8b+F7j4Pl3ctprH/
         S3Iw==
X-Gm-Message-State: ALoCoQkmGFgQ4up7oyLyuH06KTPPbEMONB7f/Nm0jkOkwzo4jcfJAM4qIdmXycRwFVbRM8eWVjp4
X-Received: by 10.107.29.148 with SMTP id d142mr39071204iod.9.1432677694231;
        Tue, 26 May 2015 15:01:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:6430:9229:a464:d5f6])
        by mx.google.com with ESMTPSA id j3sm300289igx.21.2015.05.26.15.01.33
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 26 May 2015 15:01:33 -0700 (PDT)
X-Mailer: git-send-email 2.4.1.345.gab207b6.dirty
In-Reply-To: <1432677675-5118-1-git-send-email-sbeller@google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269990>

The transport version set via command line argument in
git fetch takes precedence over the configured version.

Signed-off-by: Stefan Beller <sbeller@google.com>
---
 builtin/fetch.c    |  6 ++++++
 remote.c           |  2 ++
 remote.h           |  2 ++
 transport-helper.c |  1 +
 transport.c        | 13 +++++++++++++
 transport.h        |  4 ++++
 6 files changed, 28 insertions(+)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 7910419..d2e1828 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -46,6 +46,7 @@ static const char *recurse_submodules_default;
 static int shown_url = 0;
 static int refmap_alloc, refmap_nr;
 static const char **refmap_array;
+static const char *transport_version;
 
 static int option_parse_recurse_submodules(const struct option *opt,
 				   const char *arg, int unset)
@@ -121,6 +122,9 @@ static struct option builtin_fetch_options[] = {
 		   N_("default mode for recursion"), PARSE_OPT_HIDDEN },
 	OPT_BOOL(0, "update-shallow", &update_shallow,
 		 N_("accept refs that update .git/shallow")),
+	OPT_STRING('y', "transport-version", &transport_version,
+		   N_("transport-version"),
+		   N_("specify transport version to be used")),
 	{ OPTION_CALLBACK, 0, "refmap", NULL, N_("refmap"),
 	  N_("specify fetch refmap"), PARSE_OPT_NONEG, parse_refmap_arg },
 	OPT_END()
@@ -848,6 +852,8 @@ static struct transport *prepare_transport(struct remote *remote)
 	struct transport *transport;
 	transport = transport_get(remote, NULL);
 	transport_set_verbosity(transport, verbosity, progress);
+	if (transport_version)
+		set_option(transport, TRANS_OPT_TRANSPORTVERSION, transport_version);
 	if (upload_pack)
 		set_option(transport, TRANS_OPT_UPLOADPACK, upload_pack);
 	if (keep)
diff --git a/remote.c b/remote.c
index 68901b0..2914d9d 100644
--- a/remote.c
+++ b/remote.c
@@ -476,6 +476,8 @@ static int handle_config(const char *key, const char *value, void *cb)
 					 key, value);
 	} else if (!strcmp(subkey, ".vcs")) {
 		return git_config_string(&remote->foreign_vcs, key, value);
+	} else if (!strcmp(subkey, ".transportversion")) {
+		remote->transport_version = git_config_int(key, value);
 	}
 	return 0;
 }
diff --git a/remote.h b/remote.h
index 02d66ce..04e2310 100644
--- a/remote.h
+++ b/remote.h
@@ -50,6 +50,8 @@ struct remote {
 	const char *receivepack;
 	const char *uploadpack;
 
+	int transport_version;
+
 	/*
 	 * for curl remotes only
 	 */
diff --git a/transport-helper.c b/transport-helper.c
index 5d99a6b..ab3cd5b 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -247,6 +247,7 @@ static int disconnect_helper(struct transport *transport)
 }
 
 static const char *unsupported_options[] = {
+	TRANS_OPT_TRANSPORTVERSION,
 	TRANS_OPT_UPLOADPACK,
 	TRANS_OPT_RECEIVEPACK,
 	TRANS_OPT_THIN,
diff --git a/transport.c b/transport.c
index f080e93..3ef15f6 100644
--- a/transport.c
+++ b/transport.c
@@ -479,6 +479,16 @@ static int set_git_option(struct git_transport_options *opts,
 	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
 		opts->push_cert = !!value;
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_TRANSPORTVERSION)) {
+		if (!value)
+			opts->transport_version = 0;
+		else {
+			char *end;
+			opts->transport_version = strtol(value, &end, 0);
+			if (*end)
+				die("transport: invalid transport version option '%s'", value);
+		}
+		return 0;
 	}
 	return 1;
 }
@@ -988,6 +998,9 @@ struct transport *transport_get(struct remote *remote, const char *url)
 		ret->smart_options->receivepack = "git-receive-pack";
 		if (remote->receivepack)
 			ret->smart_options->receivepack = remote->receivepack;
+		if (remote->transport_version)
+			ret->smart_options->transport_version =
+				remote->transport_version;
 	}
 
 	return ret;
diff --git a/transport.h b/transport.h
index 18d2cf8..e07d356 100644
--- a/transport.h
+++ b/transport.h
@@ -14,6 +14,7 @@ struct git_transport_options {
 	unsigned update_shallow : 1;
 	unsigned push_cert : 1;
 	int depth;
+	int transport_version;
 	const char *uploadpack;
 	const char *receivepack;
 	struct push_cas_option *cas;
@@ -162,6 +163,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Send push certificates */
 #define TRANS_OPT_PUSH_CERT "pushcert"
 
+/* Use a new version of the git protocol */
+#define TRANS_OPT_TRANSPORTVERSION "transportversion"
+
 /**
  * Returns 0 if the option was used, non-zero otherwise. Prints a
  * message to stderr if the option is not used.
-- 
2.4.1.345.gab207b6.dirty
