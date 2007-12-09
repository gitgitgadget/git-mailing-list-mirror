From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sat, 08 Dec 2007 22:51:05 -0800
Message-ID: <7v8x44tl7q.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
	<7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
	<Pine.LNX.4.64.0712082346310.5349@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Sun Dec 09 07:51:46 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1G0t-0005Yk-P9
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 07:51:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751426AbXLIGvX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 01:51:23 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750779AbXLIGvX
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 01:51:23 -0500
Received: from a-sasl-quonix.pobox.com ([208.72.237.25]:44005 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbXLIGvW (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 01:51:22 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id EBBA45E74;
	Sun,  9 Dec 2007 01:51:16 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 1E3045E73;
	Sun,  9 Dec 2007 01:51:11 -0500 (EST)
In-Reply-To: <Pine.LNX.4.64.0712082346310.5349@iabervon.org> (Daniel
	Barkalow's message of "Sun, 9 Dec 2007 00:16:05 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67598>

Daniel Barkalow <barkalow@iabervon.org> writes:

> I'd found the same code ("git log -p -- git-ls-remote.sh" also reveals it, 
> and I couldn't remember it's contrib/examples that things end up in), but 
> I don't really follow that shell syntax.

Sorry, I should have been more explicit.

At this point in the scripted version:

	for pat
	do
		case "/$path" in
		*/$pat )
			match=yes
			break ;;
		esac
	done

 - $path is what we read from peek-remote (or the equivalent from curl
   for http), e.g. "refs/heads/master", or "HEAD".

 - we iterate over remainder of arguments to the script, assigning each
   to $pat;

 - we check if the pattern "*/$pat" matches "/$path".  "case" matching
   rule is an entire string match with globbing, so it is asking if
   /$path ends with /$pat.  IOW, $pat="master" matches:

	$path=refs/heads/master
        $path=refs/remotes/origin/master

   but it does not match $path="refs/heads/omaster".

---

 builtin-ls-remote.c |   44 ++++++++++++++++++++++++++++++++++++++------
 1 files changed, 38 insertions(+), 6 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 56f3f88..bae7c48 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -6,6 +6,35 @@
 static const char ls_remote_usage[] =
 "git-ls-remote [--upload-pack=<git-upload-pack>] [<host>:]<directory>";
 
+/*
+ * pattern is a list of tail-part of accepted refnames.  Is there one
+ * among then that is a suffix of the path?  Directory boundary must
+ * be honored when doing this match.  IOW, patterns "master" and
+ * "sa/master" both match path "refs/hold/sa/master".  On the other
+ * hand, path "refs/hold/foosa/master" is matched by "master" but not
+ * by "sa/master".
+ */
+
+static int tail_match(const char **pattern, const char *path)
+{
+	int pathlen;
+	const char *p;
+
+	if (!*pattern)
+		return 1; /* no restriction */
+
+	for (pathlen = strlen(path); (p = *pattern); pattern++) {
+		int pfxlen = pathlen - strlen(p);
+		if (pfxlen < 0)
+			continue; /* pattern is longer, will never match */
+		if (strcmp(path + pfxlen, p))
+			continue; /* no tail match */
+		if (!pfxlen || path[pfxlen - 1] == '/')
+			return 1; /* fully match at directory boundary */
+	}
+	return 0;
+}
+
 int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 {
 	int i;
@@ -13,6 +42,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	int nongit = 0;
 	unsigned flags = 0;
 	const char *uploadpack = NULL;
+	const char **pattern = NULL;
 
 	struct remote *remote;
 	struct transport *transport;
@@ -50,9 +80,9 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!dest || i != argc - 1)
+	if (!dest)
 		usage(ls_remote_usage);
-
+	pattern = argv + i + 1;
 	remote = nongit ? NULL : remote_get(dest);
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
@@ -65,10 +95,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	if (!ref)
 		return 1;
 
-	while (ref) {
-		if (check_ref_type(ref, flags))
-			printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
-		ref = ref->next;
+	for ( ; ref; ref = ref->next) {
+		if (!check_ref_type(ref, flags))
+			continue;
+		if (!tail_match(pattern, ref->name))
+			continue;
+		printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
 	}
 	return 0;
 }
