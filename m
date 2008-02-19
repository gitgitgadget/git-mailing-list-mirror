From: Daniel Barkalow <barkalow@iabervon.org>
Subject: [PATCH] API documentation for remote.h
Date: Tue, 19 Feb 2008 02:52:11 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0802190250170.5816@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 19 08:53:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JRNHk-0000eA-AC
	for gcvg-git-2@gmane.org; Tue, 19 Feb 2008 08:53:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750975AbYBSHwO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 Feb 2008 02:52:14 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750980AbYBSHwO
	(ORCPT <rfc822;git-outgoing>); Tue, 19 Feb 2008 02:52:14 -0500
Received: from iabervon.org ([66.92.72.58]:58002 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750896AbYBSHwN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 Feb 2008 02:52:13 -0500
Received: (qmail 16640 invoked by uid 1000); 19 Feb 2008 07:52:11 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 19 Feb 2008 07:52:11 -0000
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74388>

Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
---
So people will find more of remote.h, primarily.

 Documentation/technical/api-remote.txt |  123 ++++++++++++++++++++++++++++++++
 1 files changed, 123 insertions(+), 0 deletions(-)
 create mode 100644 Documentation/technical/api-remote.txt

diff --git a/Documentation/technical/api-remote.txt b/Documentation/technical/api-remote.txt
new file mode 100644
index 0000000..ec4790b
--- /dev/null
+++ b/Documentation/technical/api-remote.txt
@@ -0,0 +1,123 @@
+Remotes configuration API
+=========================
+
+The API in remote.h gives access to the configuration related to
+remotes. It handles all three configuration mechanisms historically
+and currently used by git, and presents the information in a uniform
+fashion. Note that the code also handles plain URLs without any
+configuration, giving them just the default information.
+
+struct remote
+-------------
+
+`name`::
+
+	The user's nickname for the remote
+
+`url`::
+
+	An array of all of the url_nr URLs configured for the remote
+
+`push`:: 
+
+	 An array of refspecs configured for pushing, with
+	 push_refspec being the literal strings, and push_refspec_nr
+	 being the quantity.
+
+`fetch`::
+
+	An array of refspecs configured for fetching, with
+	fetch_refspec being the literal strings, and fetch_refspec_nr
+	being the quantity.
+
+`fetch_tags`::
+
+	The setting for whether to fetch tags (as a separate rule from
+	the configured refspecs); -1 means never to fetch tags, 0
+	means to auto-follow tags based on the default heuristic, 1
+	means to always auto-follow tags, and 2 means to fetch all
+	tags.
+
+`receivepack`, `uploadpack`::
+
+	The configured helper programs to run on the remote side, for
+	git-native protocols.
+
+`http_proxy`::
+
+	The proxy to use for curl (http, https, ftp, etc.) URLs.
+
+struct remotes can be found by name with remote_get(), and iterated
+through with for_each_remote(). remote_get(NULL) will return the
+default remote, given the current branch and configuration.
+
+struct refspec
+--------------
+
+A struct refspec holds the parsed interpretation of a refspec. If it
+will force updates (starts with a '+'), force is true. If it is a
+pattern (sides end with '*') pattern is true. src and dest are the two
+sides (if a pattern, only the part outside of the wildcards); if there
+is only one side, it is src, and dst is NULL; if sides exist but are
+empty (i.e., the refspec either starts or ends with ':'), the
+corresponding side is "".
+
+This parsing can be done to an array of strings to give an array of
+struct refpsecs with parse_ref_spec().
+
+remote_find_tracking(), given a remote and a struct refspec with
+either src or dst filled out, will fill out the other such that the
+result is in the "fetch" specification for the remote (note that this
+evaluates patterns and returns a single result).
+
+struct branch
+-------------
+
+Note that this may end up moving to branch.h
+
+struct branch holds the configuration for a branch. It can be looked
+up with branch_get(name) for "refs/heads/{name}", or with
+branch_get(NULL) for HEAD.
+
+It contains:
+
+`name`::
+
+	The short name of the branch.
+
+`refname`::
+
+	The full path for the branch ref.
+
+`remote_name`::
+
+	The name of the remote listed in the configuration.
+
+`remote`::
+
+	The struct remote for that remote.
+
+`merge_name`::
+
+	An array of the "merge" lines in the configuration.
+
+`merge`::
+
+	An array of the struct refspecs used for the merge lines. That
+	is, merge[i]->dst is a local tracking ref which should be
+	merged into this branch by default.
+
+`merge_nr`::
+
+	The number of merge configurations
+
+branch_has_merge_config() returns true if the given branch has merge
+configuration given.
+
+Other stuff
+-----------
+
+There is other stuff in remote.h that is related, in general, to the
+process of interacting with remotes.
+
+(Daniel Barkalow)
-- 
1.5.4.1.1350.g2b9ee
