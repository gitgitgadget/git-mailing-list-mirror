From: Dongcan Jiang <dongcan.jiang@gmail.com>
Subject: [PATCH v2/GSoC/RFC] fetch: git fetch --deepen
Date: Sun, 22 Mar 2015 23:24:35 +0800
Message-ID: <39ef84113d77ee6fa371ac2f23bbb0ef321323ba.1427031746.git.dongcan.jiang@gmail.com>
References: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Cc: pclouds@gmail.com, gitster@pobox.com, sunshine@sunshineco.com,
	Dongcan Jiang <dongcan.jiang@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Mar 22 17:02:22 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YZiKL-0005EU-1T
	for gcvg-git-2@plane.gmane.org; Sun, 22 Mar 2015 17:02:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754AbbCVQCI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 22 Mar 2015 12:02:08 -0400
Received: from mail-pd0-f174.google.com ([209.85.192.174]:35770 "EHLO
	mail-pd0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751557AbbCVQCF (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 22 Mar 2015 12:02:05 -0400
Received: by pdbop1 with SMTP id op1so161229939pdb.2
        for <git@vger.kernel.org>; Sun, 22 Mar 2015 09:02:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=f7fKZEPRtkaFdWtcpaWTAzB0iwIhhyBB/UwtIcN0G4Y=;
        b=Sf4VUQ/nDLh/54RUlEJ4CSaYZupGAkED0staarFrSfgzPi7b8nVn1LJRGr5b8qOexT
         2xvQTEuOkEX8RkNQzWe43ArPLhE+UsZpCrGDy7GXqumhBUz0nVCwPJe4KmObYRaswndR
         tuCE4DKFwcJdq6CodxuvOcah9FEe7f62CYqfBnJfd9ctsF0y0bLquE8YPRqPI+z7u2tx
         eYKegkifSu/Jwszs+U9a/UkI5/StSevweXcbP6sFvzlXN2UixFG5oPnwvtdmVgDIoeIS
         qYCU1H0gtitqD4ig7h05wknvjFsr1B9XExPvhRHEYIxFvMrQCz1mUO+o0twC3WtCK6Yh
         WL0Q==
X-Received: by 10.70.48.239 with SMTP id p15mr145472202pdn.123.1427040124558;
        Sun, 22 Mar 2015 09:02:04 -0700 (PDT)
Received: from localhost.localdomain ([162.105.205.253])
        by mx.google.com with ESMTPSA id fi8sm14330618pdb.43.2015.03.22.09.02.01
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Sun, 22 Mar 2015 09:02:03 -0700 (PDT)
X-Mailer: git-send-email 2.3.3.221.g72ad08d.dirty
In-Reply-To: <1426251846-1604-1-git-send-email-dongcan.jiang@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266072>

This patch is just for discusstion. An option --deepen is added to
'git fetch'. When it comes to '--deepen', git should fetch N more
commits ahead the local shallow commit, where N is indicated by
'--depth=N'. [1]

e.g.

>  (upstream)
>   ---o---o---o---A---B
>
>  (you)
>                  A---B

After excuting "git fetch --depth=1 --deepen", (you) get one more
tip and it becomes

>  (you)
>              o---A---B

'--deepen' is designed to be a boolean option in this patch, which
is a little different from [1]. It's designed in this way, because
it can reuse '--depth' in the program, and just costs one more bit
in some data structure, such as fetch_pack_args,
git_transport_options.

Of course, as a patch for discussion, it remains a long way to go
before being complete.

	1) Documents should be completed.
	2) More test cases, expecially corner cases, should be added.
	3) No need to get remote refs when it comes to '--deepen' option.
	4) Validity on options combination should be checked.
	5) smart-http protocol remains to be supported. [2]

[1] http://article.gmane.org/gmane.comp.version-control.git/212950
[2] http://article.gmane.org/gmane.comp.version-control.git/265050

Helped-by: Duy Nguyen <pclouds@gmail.com>
Helped-By: Eric Sunshine <sunshine@sunshineco.com>
Helped-By: Junio C Hamano <gitster@pobox.com>
Signed-off-by: Dongcan Jiang <dongcan.jiang@gmail.com>
---

-Background-

At present the command "git-fetch" has one option "depth" which deepens or shortens the history of a shallow repository created by git clone with --depth=<depth> option (see git-clone[1]) to the specified number of commits from the tip of each remote branch history [2].

The drawback is that the starting point for deepening history is limited to the tip of each remote branch history. However, it's not able to satisfy the needs of users in some cases:
1) If the user wants to know the process of how a function was created and developed. What he expects is that he goes to the point of latest modification about the function and deepens the history further back from this current cut-off point by N commit directly, rather than having to guess what the depth is from tip of remote branch.
2) What's more, if the user only cares about the revisions of this function, the other commits after the latest modification are redundant for him, but he has to fetch them concomitantly, which wastes unnecessary time and space.


For the convenience of users, a new option should be added as "deepen" to allow users to just get history commits deepened by N commits from current cut-off point, irrespective of location where the tips are [3].


-Goals-

1) Supports for command "git fetch --deepen";
2) Conflict Detection for this option to guarantee robustness;
3) Sufficient tests;
4) Guarantee for compatibility;
5) Sufficient documents;

More Details are shown in next section.


-Details-

--1. Current Workflow of git-fetch--

         +-+-+-+-+-+-+-+-+-+                      +-+-+-+-+-+-+-+-+-+-+-+
         | git-upload-pack |                      | git-unpack-objects  |
         +-+-+-+-+-+-+-+-+-+                      +-+-+-+-+-+-+-+-+-+-+-+
                |   ^                                      |   ^
                v   |                                      v   |
 fetch   +-+-+-+-+-+-+-+-+-+      +-+-+-+-+-+-+-+      +-+-+-+-+-+-+
-------> | get remote refs | ---> | fetch refs  | ---> | get_pack  | -+
         +-+-+-+-+-+-+-+-+-+      +-+-+-+-+-+-+-+      +-+-+-+-+-+-+  |
                                       |     ^                        |
                                       v     |                        v
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+  +-+-+-+-+-+-+-+
| git-upload-pack                                       |  |   update    |
+  +-+-+-+-+-+-+-+-+-+-+-+-+      +-+-+-+-+-+-+-+-+-+-+ +  | local refs  |
|  | generate wanted objs  | ---> | create_pack_file  | |  +-+-+-+-+-+-+-+
+  |    update shallows    |      +-+-+-+-+-+-+-+-+-+-+ +
|  +-+-+-+-+-+-+-+-+-+-+-+-+            |     ^         |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                                        |     |
                                        v     |
                                  +-+-+-+-+-+-+-+-+-+-+
                                  | git-pack-objects  |
                                  +-+-+-+-+-+-+-+-+-+-+
  Figure 1. Workflow of git-fetch (Please view it in fixed-width fonts)

Figure 1 illustrates the workflow of git-fetch. When it comes to git-fetch, a series of operations are performed in cooperation with the server side via `transport` module.

At first, it gets remote refs from git-upload-pack, and then it fetches refs, i.e. generating wanted objs, updating shallows and creating pack file. Finally, it unpacks objects from the pack file and updates the local refs.

Actually, there are several protocols running the workflow above, which is showed in Table 1. It is determined in transport.c/transport_get().

Table 1. Protocols supporting `fetch` (Please view it in fixed-width fonts)
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| *protocol*  |   *get remote refs*   | *fetch refs / get_pack* |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|   rsync     |  get_refs_via_rsync   |  fetch_objs_via_rsync   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|   bundle    | get_refs_from_bundle  | fetch_refs_from_bundle  |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|   normal    | get_refs_via_connect  |  fetch_refs_via_pack    |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
| foreign_vsc |     get_refs_list     |          fetch          |
| and others  |  in transport-helper  |   in transport-helper   |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+

In this project, "normal" and "foreign_vsc and others" protocols will be mainly concerned, because they can support fetching with "--depth".

More details will be discussed in following parts.


--2. How to Support "fetch --deepen" for Normal Protocol--

Normal protocol will be used when the remote address is not a url or when it starts with "files://", "git://", "ssh://", "git+ssh://" or "ssh+git://".

An intuitive way to implement this feature is as follows,
1) Add "--deepen" option throughout the workflow shown in Figure 1;
2) Generate wanted objs and update shallows according to local shallows and "--deepen" value, but not the newest tips;
3) Make git not to update local refs when it's processing with "--deepen".

Actually, my current patch on this issue is implemented in this intuitive way. However, it has several drawbacks:
1) It gets remote refs, which are useless in its workflow;
2) For each ref, it interacts with git-upload-pack, while only one interaction is needed;
2) It's not able to fetch refs, when the useless "get remote refs" step is forced to skip.

Therefore, several stuffs have to be improved:
1) Not to get remote refs when processing with "--deepen";
2) Just send shallows to git-upload-pack without "want" objects;
3) Make git-upload-pack able to process "--deepen" without "want" objects;


--3. How to Support "fetch --deepen" for foreign_vsc And Others Protocol--

This protocol is just a bit different from above. Actually it shares most logics with the normal one.

The biggest difference is that it does the whole process through git-remote-curl and git-fetch-pack [4], which is illustrated in Figure 2.

                                   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
                                   | git-fetch-pack            |
 fetch   +-+-+-+-+-+-+-+-+-+       +           ...             +
-------> | git-remote-curl | <---> |  +-+-+-+-+-+-+-+-+-+      |
         +-+-+-+-+-+-+-+-+-+       +  | get remote refs | ...  +
                                   |  +-+-+-+-+-+-+-+-+-+      |
                                   +-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Figure 2. fetch through git-remote-curl (Please view it in fixed-width fonts)

The key to make it work with "--deepen" is to add the option throughout remote-curl.c and builtin/fetch-pack.c.


--4. Tests--

As git is a product demanding high robustness. Sufficient tests have to be done to make sure the new feature's correctness.

Cases needed to be tested are listed in Table 2.

Table 2. Cases needed to be tested (Please view it in fixed-width fonts)
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|  *module*   |                       *cases*                             |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             | should fail when used with some options like --unshallow  |
|   fetch,    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             |   work correctly when deepen exceeds the remote shallow   |
|    pull,    +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             |         the updated shallows by deepen are correct        |
| fetch-pack  +-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
|             |          local remote refs should not be updated          |
+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+-+
Every module on the left needs to test all cases on the right side.


--5. Compatibility--

It's impossible to request users to install the software again for new changes, so all changes shouldn't go against the existing installations. For this case, neither existing options nor their behaviors in code should be changed to guarantee compatibility [5,6].


[1] http://git-scm.com/docs/git-clone
[2] http://git-scm.com/docs/git-fetch
[3] http://article.gmane.org/gmane.comp.version-control.git/212950
[4] http://marc.info/?l=git&m=142580732110033&w=2
[5] http://marc.info/?l=git&m=142631134424268&w=2
[6] http://marc.info/?l=git&m=142658909625290&w=2

Above is my draft proposal for "git fetch --deepen".

However, I'm still not quite following when would it go through the git-remote-curl workflow shown in Figure 2. Are there any examples I could follow in the test set?

Have I missed anything else in my draft? Look forward to your comments and suggestions.


 builtin/fetch.c  |  7 +++++--
 fetch-pack.c     |  1 +
 fetch-pack.h     |  1 +
 t/t5510-fetch.sh | 12 ++++++++++++
 transport.c      |  4 ++++
 transport.h      |  4 ++++
 upload-pack.c    | 27 ++++++++++++++++++---------
 7 files changed, 45 insertions(+), 11 deletions(-)

diff --git a/builtin/fetch.c b/builtin/fetch.c
index f951265..d8b6504 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -33,7 +33,7 @@ static int fetch_prune_config = -1; /* unspecified */
 static int prune = -1; /* unspecified */
 #define PRUNE_BY_DEFAULT 0 /* do we prune by default? */

-static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity;
+static int all, append, dry_run, force, keep, multiple, update_head_ok, verbosity, deepen;
 static int progress = -1, recurse_submodules = RECURSE_SUBMODULES_DEFAULT;
 static int tags = TAGS_DEFAULT, unshallow, update_shallow;
 static const char *depth;
@@ -111,6 +111,7 @@ static struct option builtin_fetch_options[] = {
 	OPT_BOOL(0, "progress", &progress, N_("force progress reporting")),
 	OPT_STRING(0, "depth", &depth, N_("depth"),
 		   N_("deepen history of shallow clone")),
+	OPT_BOOL(0, "deepen", &deepen, N_("deepen")),
 	{ OPTION_SET_INT, 0, "unshallow", &unshallow, NULL,
 		   N_("convert to a complete repository"),
 		   PARSE_OPT_NONEG | PARSE_OPT_NOARG, NULL, 1 },
@@ -756,7 +757,7 @@ static int fetch_refs(struct transport *transport, struct ref *ref_map)
 	int ret = quickfetch(ref_map);
 	if (ret)
 		ret = transport_fetch_refs(transport, ref_map);
-	if (!ret)
+	if (!ret && !deepen)
 		ret |= store_updated_refs(transport->url,
 				transport->remote->name,
 				ref_map);
@@ -853,6 +854,8 @@ static struct transport *prepare_transport(struct remote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
+	if (deepen)
+		set_option(transport, TRANS_OPT_DEEPEN, "yes");
 	if (update_shallow)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
diff --git a/fetch-pack.c b/fetch-pack.c
index 655ee64..3c6f17a 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -295,6 +295,7 @@ static int find_common(struct fetch_pack_args *args,
 			if (no_done)            strbuf_addstr(&c, " no-done");
 			if (use_sideband == 2)  strbuf_addstr(&c, " side-band-64k");
 			if (use_sideband == 1)  strbuf_addstr(&c, " side-band");
+			if (args->deepen_mode)  strbuf_addstr(&c, " deepen-mode");
 			if (args->use_thin_pack) strbuf_addstr(&c, " thin-pack");
 			if (args->no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args->include_tag)   strbuf_addstr(&c, " include-tag");
diff --git a/fetch-pack.h b/fetch-pack.h
index bb7fd76..f575c8b 100644
--- a/fetch-pack.h
+++ b/fetch-pack.h
@@ -10,6 +10,7 @@ struct fetch_pack_args {
 	const char *uploadpack;
 	int unpacklimit;
 	int depth;
+	unsigned deepen_mode:1;
 	unsigned quiet:1;
 	unsigned keep_pack:1;
 	unsigned lock_pack:1;
diff --git a/t/t5510-fetch.sh b/t/t5510-fetch.sh
index d78f320..3b960c8 100755
--- a/t/t5510-fetch.sh
+++ b/t/t5510-fetch.sh
@@ -708,4 +708,16 @@ test_expect_success 'fetching a one-level ref works' '
 	)
 '

+test_expect_success 'fetching deepen' '
+	git clone . deepen --depth=1 && (
+		cd deepen &&
+		git fetch .. foo --depth=1
+		git show foo
+		test_must_fail git show foo~
+		git fetch .. foo --depth=1 --deepen
+		git show foo~
+		test_must_fail git show foo~2
+	)
+'
+
 test_done
diff --git a/transport.c b/transport.c
index 0694a7c..0a43474 100644
--- a/transport.c
+++ b/transport.c
@@ -478,6 +478,9 @@ static int set_git_option(struct git_transport_options *opts,
 				die("transport: invalid depth option '%s'", value);
 		}
 		return 0;
+	} else if (!strcmp(name, TRANS_OPT_DEEPEN)) {
+		opts->deepen_mode = !!value;
+		return 0;
 	} else if (!strcmp(name, TRANS_OPT_PUSH_CERT)) {
 		opts->push_cert = !!value;
 		return 0;
@@ -534,6 +537,7 @@ static int fetch_refs_via_pack(struct transport *transport,
 	args.quiet = (transport->verbose < 0);
 	args.no_progress = !transport->progress;
 	args.depth = data->options.depth;
+	args.deepen_mode = data->options.deepen_mode;
 	args.check_self_contained_and_connected =
 		data->options.check_self_contained_and_connected;
 	args.cloning = transport->cloning;
diff --git a/transport.h b/transport.h
index 18d2cf8..357a57b 100644
--- a/transport.h
+++ b/transport.h
@@ -13,6 +13,7 @@ struct git_transport_options {
 	unsigned self_contained_and_connected : 1;
 	unsigned update_shallow : 1;
 	unsigned push_cert : 1;
+	unsigned deepen_mode : 1;
 	int depth;
 	const char *uploadpack;
 	const char *receivepack;
@@ -153,6 +154,9 @@ struct transport *transport_get(struct remote *, const char *);
 /* Limit the depth of the fetch if not null */
 #define TRANS_OPT_DEPTH "depth"

+/* Limit the deepen of the fetch if not null */
+#define TRANS_OPT_DEEPEN "deepen"
+
 /* Aggressively fetch annotated tags if possible */
 #define TRANS_OPT_FOLLOWTAGS "followtags"

diff --git a/upload-pack.c b/upload-pack.c
index b531a32..fbe095a 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -31,6 +31,7 @@ static const char upload_pack_usage[] = "git upload-pack [--strict] [--timeout=<

 static unsigned long oldest_have;

+static int deepen_mode;
 static int multi_ack;
 static int no_done;
 static int use_thin_pack, use_ofs_delta, use_include_tag;
@@ -577,6 +578,8 @@ static void receive_needs(void)

 		features = line + 45;

+		if (parse_feature_request(features, "deepen-mode"))
+			deepen_mode = 1;
 		if (parse_feature_request(features, "multi_ack_detailed"))
 			multi_ack = 2;
 		else if (parse_feature_request(features, "multi_ack"))
@@ -596,15 +599,17 @@ static void receive_needs(void)
 		if (parse_feature_request(features, "include-tag"))
 			use_include_tag = 1;

-		o = parse_object(sha1_buf);
-		if (!o)
-			die("git upload-pack: not our ref %s",
-			    sha1_to_hex(sha1_buf));
-		if (!(o->flags & WANTED)) {
-			o->flags |= WANTED;
-			if (!is_our_ref(o))
-				has_non_tip = 1;
-			add_object_array(o, NULL, &want_obj);
+		if (!deepen_mode) {
+			o = parse_object(sha1_buf);
+			if (!o)
+				die("git upload-pack: not our ref %s",
+						sha1_to_hex(sha1_buf));
+			if (!(o->flags & WANTED)) {
+				o->flags |= WANTED;
+				if (!is_our_ref(o))
+					has_non_tip = 1;
+				add_object_array(o, NULL, &want_obj);
+			}
 		}
 	}

@@ -631,6 +636,10 @@ static void receive_needs(void)
 				struct object *object = shallows.objects[i].item;
 				object->flags |= NOT_SHALLOW;
 			}
+		else if (deepen_mode)
+			backup = result =
+				get_shallow_commits(&shallows, depth + 1,
+						    SHALLOW, NOT_SHALLOW);
 		else
 			backup = result =
 				get_shallow_commits(&want_obj, depth,
--
2.3.3.221.g72ad08d.dirty
