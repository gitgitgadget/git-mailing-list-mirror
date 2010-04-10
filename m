From: Jeff King <peff@peff.net>
Subject: Re: Why not show ORIG_HEAD in git-log --decorate?
Date: Fri, 9 Apr 2010 21:29:03 -0400
Message-ID: <20100410012903.GA32428@coredump.intra.peff.net>
References: <s2zea182b21004090907i9af49416za4fdb4650af5ae29@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Yury Polyanskiy <polyanskiy@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 10 03:29:38 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0PVs-0003TB-Uv
	for gcvg-git-2@lo.gmane.org; Sat, 10 Apr 2010 03:29:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753839Ab0DJB31 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Apr 2010 21:29:27 -0400
Received: from peff.net ([208.65.91.99]:55173 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753111Ab0DJB31 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Apr 2010 21:29:27 -0400
Received: (qmail 12754 invoked by uid 107); 10 Apr 2010 01:29:27 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Fri, 09 Apr 2010 21:29:27 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 09 Apr 2010 21:29:03 -0400
Content-Disposition: inline
In-Reply-To: <s2zea182b21004090907i9af49416za4fdb4650af5ae29@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144495>

On Fri, Apr 09, 2010 at 12:07:00PM -0400, Yury Polyanskiy wrote:

> It would be very convenient if after git-pull I could see the new
> merged-in commits in the git-log. The simplest solution for this is to
> simply mark ORIG_HEAD in the output of git-log --decorate (and ideally
> also in gitk).

I think most people do something like:

  gitk HEAD^..ORIG_HEAD

To see everything in ORIG_HEAD that isn't in HEAD^ (the first parent of
HEAD, or what you had just before the pull).

> Just thought to throw in this idea to developers. Perhaps it is not
> that hard to implement.

Marking ORIG_HEAD in git-log is pretty straightforward. If we wanted to
do that, probably MERGE_HEAD and FETCH_HEAD should be marked, too.
I don't really have an opinion, as I don't generally use "git log
--decorate", but the patch for git-log would look something like what is
below (I am not planning on taking it further, but if somebody wants to
think more about the issues, they are welcome to pick it up and work on
it).

gitk would need a separate patch, as it uses a separate mechanism.

diff --git a/log-tree.c b/log-tree.c
index d3ae969..e2034c4 100644
--- a/log-tree.c
+++ b/log-tree.c
@@ -43,7 +43,7 @@ void load_ref_decorations(int flags)
 	if (!loaded) {
 		loaded = 1;
 		for_each_ref(add_ref_decoration, &flags);
-		head_ref(add_ref_decoration, &flags);
+		for_each_metaref(add_ref_decoration, &flags);
 	}
 }
 
diff --git a/refs.c b/refs.c
index d3db15a..eef7e13 100644
--- a/refs.c
+++ b/refs.c
@@ -663,6 +663,28 @@ int head_ref(each_ref_fn fn, void *cb_data)
 	return 0;
 }
 
+int for_each_metaref(each_ref_fn fn, void *cb_data)
+{
+	static const char *meta_refs[] = {
+		"HEAD",
+		"ORIG_HEAD",
+		"FETCH_HEAD",
+		"MERGE_HEAD",
+	};
+	int i;
+
+	for (i = 0; i < ARRAY_SIZE(meta_refs); i++) {
+		unsigned char sha1[20];
+		int flag;
+		if (resolve_ref(meta_refs[i], sha1, 1, &flag)) {
+			int ret = fn(meta_refs[i], sha1, flag, cb_data);
+			if (ret)
+				return ret;
+		}
+	}
+	return 0;
+}
+
 int for_each_ref(each_ref_fn fn, void *cb_data)
 {
 	return do_for_each_ref("refs/", fn, 0, 0, cb_data);
diff --git a/refs.h b/refs.h
index 4a18b08..7e72c4d 100644
--- a/refs.h
+++ b/refs.h
@@ -19,6 +19,7 @@ struct ref_lock {
  */
 typedef int each_ref_fn(const char *refname, const unsigned char *sha1, int flags, void *cb_data);
 extern int head_ref(each_ref_fn, void *);
+extern int for_each_metaref(each_ref_fn, void *);
 extern int for_each_ref(each_ref_fn, void *);
 extern int for_each_ref_in(const char *, each_ref_fn, void *);
 extern int for_each_tag_ref(each_ref_fn, void *);
