From: Jeff King <peff@peff.net>
Subject: Re: Fsck configurations and cloning.
Date: Sun, 6 Mar 2016 06:58:50 -0500
Message-ID: <20160306115850.GA985@sigill.intra.peff.net>
References: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ryne Everett <ryneeverett@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 06 12:59:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1acXL6-0007Ch-DJ
	for gcvg-git-2@plane.gmane.org; Sun, 06 Mar 2016 12:59:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751780AbcCFL67 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Mar 2016 06:58:59 -0500
Received: from cloud.peff.net ([50.56.180.127]:55390 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751750AbcCFL6y (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Mar 2016 06:58:54 -0500
Received: (qmail 19509 invoked by uid 102); 6 Mar 2016 11:58:53 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Mar 2016 06:58:53 -0500
Received: (qmail 14484 invoked by uid 107); 6 Mar 2016 11:59:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sun, 06 Mar 2016 06:59:06 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sun, 06 Mar 2016 06:58:50 -0500
Content-Disposition: inline
In-Reply-To: <CAGbFckZNpy=2P8kpSsEpCeTFmgzE5MEK7fnS8xJzDSPJs3iJdQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288341>

On Sat, Mar 05, 2016 at 08:44:38PM -0500, Ryne Everett wrote:

> I'm assuming fsck configurations are supposed to apply to clones but
> I'm having no luck:
> 
>     $ git --version
>     git version 2.7.2
>     $ git config --get transfer.fsckobjects
>     true
>     $ git config --get fsck.badTimezone
>     ignore
>     $ cat $(git config --get fsck.skiplist)
>     5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8
>     $ git clone https://github.com/kennethreitz/requests.git
>     Cloning into 'requests'...
>     remote: Counting objects: 16904, done.
>     error: object 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8:
> badTimezone: invalid author/committer line - bad time zone
>     fatal: Error in object
>     fatal: index-pack failed
> 
> Am I doing something obviously wrong here?

I think there are two problems here.

The first is that fsck.skiplist takes a filename that contains a list of
sha1s, not the sha1s themselves. So it would be more like:

  echo 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8 >skiplist
  git -c fsck.skiplist="$(pwd)/skiplist" clone ...

The second is is that only "fsck" and "receive-pack" seem to have
learned about skiplist and other per-error config. There is no matching
fetch.fsck.* config to cover fetches.

With the patch below (which I don't think is suitable for inclusion;
it's a copy-paste from receive-pack, and should be re-factored to share
code; doing so might be a nice low-hanging-fruit project for somebody),
I can do:

   echo 5e6ecdad9f69b1ff789a17733b8edc6fd7091bd8 >skiplist
   git -c transfer.fsckobjects=true \
       -c fetch.fsck.skiplist="$(pwd)/skiplist" \
       clone https://github.com/kennethreitz/requests.git

---
diff --git a/fetch-pack.c b/fetch-pack.c
index f96f6df..19c83fa 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -16,6 +16,7 @@
 #include "prio-queue.h"
 #include "sha1-array.h"
 #include "sigchain.h"
+#include "fsck.h"
 
 static int transfer_unpack_limit = -1;
 static int fetch_unpack_limit = -1;
@@ -24,6 +25,7 @@ static int prefer_ofs_delta = 1;
 static int no_done;
 static int fetch_fsck_objects = -1;
 static int transfer_fsck_objects = -1;
+static struct strbuf fsck_msg_types = STRBUF_INIT;
 static int agent_supported;
 static struct lock_file shallow_lock;
 static const char *alternate_shallow_file;
@@ -762,7 +764,7 @@ static int get_pack(struct fetch_pack_args *args,
 	    : transfer_fsck_objects >= 0
 	    ? transfer_fsck_objects
 	    : 0)
-		argv_array_push(&cmd.args, "--strict");
+		argv_array_pushf(&cmd.args, "--strict%s", fsck_msg_types.buf);
 
 	cmd.in = demux.out;
 	cmd.git_cmd = 1;
@@ -895,6 +897,32 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 	return ref;
 }
 
+static int fetch_config_cb(const char *var, const char *value, void *data)
+{
+
+	if (strcmp(var, "fetch.fsck.skiplist") == 0) {
+		const char *path;
+
+		if (git_config_pathname(&path, var, value))
+			return 1;
+		strbuf_addf(&fsck_msg_types, "%cskiplist=%s",
+			    fsck_msg_types.len ? ',' : '=', path);
+		free((char *)path);
+		return 0;
+	}
+
+	if (skip_prefix(var, "fetch.fsck.", &var)) {
+		if (is_valid_msg_type(var, value))
+			strbuf_addf(&fsck_msg_types, "%c%s=%s",
+				    fsck_msg_types.len ? ',' : '=', var, value);
+		else
+			warning("Skipping unknown msg id '%s'", var);
+		return 0;
+	}
+
+	return 0;
+}
+
 static void fetch_pack_config(void)
 {
 	git_config_get_int("fetch.unpacklimit", &fetch_unpack_limit);
@@ -903,7 +931,7 @@ static void fetch_pack_config(void)
 	git_config_get_bool("fetch.fsckobjects", &fetch_fsck_objects);
 	git_config_get_bool("transfer.fsckobjects", &transfer_fsck_objects);
 
-	git_config(git_default_config, NULL);
+	git_config(fetch_config_cb, NULL);
 }
 
 static void fetch_pack_setup(void)
