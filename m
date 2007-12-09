From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH] Restore ls-remote reference pattern matching
Date: Sun, 9 Dec 2007 00:16:05 -0500 (EST)
Message-ID: <Pine.LNX.4.64.0712082346310.5349@iabervon.org>
References: <Pine.LNX.4.64.0712082134350.5349@iabervon.org>
 <7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Eyvind Bernhardsen <eyvind-git@orakel.ntnu.no>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Dec 09 06:16:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J1EWn-00080S-Ip
	for gcvg-git-2@gmane.org; Sun, 09 Dec 2007 06:16:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751141AbXLIFQJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Dec 2007 00:16:09 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751109AbXLIFQI
	(ORCPT <rfc822;git-outgoing>); Sun, 9 Dec 2007 00:16:08 -0500
Received: from iabervon.org ([66.92.72.58]:36610 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750794AbXLIFQH (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Dec 2007 00:16:07 -0500
Received: (qmail 25368 invoked by uid 1000); 9 Dec 2007 05:16:05 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 9 Dec 2007 05:16:05 -0000
In-Reply-To: <7vodd0tuuu.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/67594>

On Sat, 8 Dec 2007, Junio C Hamano wrote:

> Daniel Barkalow <barkalow@iabervon.org> writes:
> 
> > How's this? I vaguely tested it, and it doesn't break existing tests, and 
> > it matches my guess at how the old code worked, at least maybe.
> 
> Well, contrib/examples/git-ls-remote.sh is your friend and you do not
> have to "guess".
> 
> It did, for each ref $path it got from peek-remote, this:
> 
> 		for pat
> 		do
> 			case "/$path" in
> 			*/$pat )
> 				match=yes
> 				break ;;
> 			esac
> 		done
> 
> I do not think pathspec_match() matches the string in a way compatible
> with the above loop, and calling get_pathspec(prefix, argv) with
> anything but a real path is a misuse of the interface.

I'd found the same code ("git log -p -- git-ls-remote.sh" also reveals it, 
and I couldn't remember it's contrib/examples that things end up in), but 
I don't really follow that shell syntax.

> I think if you do fnmatch(3) that would be compatible with the shell
> loop.

Maybe:
--- cut here ---
I entirely missed that "git ls-remote <repo> <ref-pattern>..." is
supposed to work. This restores it.

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
This matches git-name-rev --refs=<ref-pattern>, anyway, which is the 
closest example I could find. If this isn't the desired behavior, it's 
probably easier to just edit this instead of trying to explain the right 
thing to me.

 builtin-ls-remote.c |   20 +++++++++++++++++---
 1 files changed, 17 insertions(+), 3 deletions(-)

diff --git a/builtin-ls-remote.c b/builtin-ls-remote.c
index 56f3f88..d936c28 100644
--- a/builtin-ls-remote.c
+++ b/builtin-ls-remote.c
@@ -17,6 +17,7 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 	struct remote *remote;
 	struct transport *transport;
 	const struct ref *ref;
+	const char **refpatterns = NULL;
 
 	setup_git_directory_gently(&nongit);
 
@@ -50,9 +51,12 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		break;
 	}
 
-	if (!dest || i != argc - 1)
+	if (!dest)
 		usage(ls_remote_usage);
 
+	if (argc > i + 1)
+		refpatterns = argv + i;
+
 	remote = nongit ? NULL : remote_get(dest);
 	if (remote && !remote->url_nr)
 		die("remote %s has no configured URL", dest);
@@ -66,8 +70,18 @@ int cmd_ls_remote(int argc, const char **argv, const char *prefix)
 		return 1;
 
 	while (ref) {
-		if (check_ref_type(ref, flags))
-			printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		if (check_ref_type(ref, flags)) {
+			int match = 0;
+			if (refpatterns) {
+				for (i = 0; refpatterns[i]; i++) {
+					if (!fnmatch(refpatterns[i], ref->name, 0))
+						match = 1;
+				}
+			} else
+				match = 1;
+			if (match)
+				printf("%s	%s\n", sha1_to_hex(ref->old_sha1), ref->name);
+		}
 		ref = ref->next;
 	}
 	return 0;
-- 
1.5.3.6.886.gb204
