From: "Shawn O. Pearce" <spearce@spearce.org>
Subject: Re: Cloning marks pack for .keep
Date: Tue, 8 Jul 2008 04:46:06 +0000
Message-ID: <20080708044606.GC2542@spearce.org>
References: <48728A52.8080107@gmx.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Daniel Barkalow <barkalow@iabervon.org>
To: Jean-Luc Herren <jlh@gmx.ch>, Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jul 08 06:47:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KG56Z-0007hb-AG
	for gcvg-git-2@gmane.org; Tue, 08 Jul 2008 06:47:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751080AbYGHEqK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jul 2008 00:46:10 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751168AbYGHEqJ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jul 2008 00:46:09 -0400
Received: from george.spearce.org ([209.20.77.23]:44628 "EHLO
	george.spearce.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751076AbYGHEqI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jul 2008 00:46:08 -0400
Received: by george.spearce.org (Postfix, from userid 1001)
	id A25933821F; Tue,  8 Jul 2008 04:46:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <48728A52.8080107@gmx.ch>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87710>

Jean-Luc Herren <jlh@gmx.ch> wrote:
> After cloning a local repository with "git clone file://...", the
> resulting repo had one big pack file, as expected, but also a
> matching ".keep" file.  Certainly this is a bug, isn't it?  The
> same happens if I clone git.git.  I used git 1.5.6.1 but observed
> the same with the current master.  I bisected this behavior to
> commit fa740529 by Shawn O. Pearce (CC'ing him).  Since this dates
> back to 2007, I wonder if maybe only I am seeing this, but I
> cannot think of any reason for it.

This is a known issue to me; I have been seeing this behavior
myself since probably fa74 hit next.  I just don't clone often
so I've never thought about it much.  ;-)

I'm willing to bet its the hard-coded:

+       args.lock_pack = 1;

inside of fetch_refs_via_pack() that is causing the .keep file to
stay around after the clone.  When this gets set the caller must
delete the transport->pack_lockfile (if non-null) once the refs
have all been updated to reference the objects downloaded into the
pack file.  Under git-clone all refs are new and there is little to
no chance that someone issues "git gc" at the same time as the fetch
is running, so git-clone never cleaned up the pack_lockfile.

I think this would fix it.

--8<--
Remove unnecessary pack-*.keep file after successful git-clone

Once a clone is successful we no longer need to hold onto the
.keep file created by the transport.  Delete the file so we
can later repack the complete repository.

Signed-off-by: Shawn O. Pearce <spearce@spearce.org>
---
 builtin-clone.c |    7 +++++--
 1 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin-clone.c b/builtin-clone.c
index 7bcc664..7ee8275 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -337,6 +337,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 	const struct ref *refs, *head_points_at, *remote_head, *mapped_refs;
 	char branch_top[256], key[256], value[256];
 	struct strbuf reflog_msg;
+	struct transport *transport = NULL;
 
 	struct refspec refspec;
 
@@ -458,8 +459,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		refs = clone_local(path, git_dir);
 	else {
 		struct remote *remote = remote_get(argv[0]);
-		struct transport *transport =
-			transport_get(remote, remote->url[0]);
+		transport = transport_get(remote, remote->url[0]);
 
 		if (!transport->get_refs_list || !transport->fetch)
 			die("Don't know how to clone %s", transport->url);
@@ -529,6 +529,9 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 		option_no_checkout = 1;
 	}
 
+	if (transport)
+		transport_unlock_pack(transport);
+
 	if (!option_no_checkout) {
 		struct lock_file *lock_file = xcalloc(1, sizeof(struct lock_file));
 		struct unpack_trees_options opts;
-- 
1.5.6.74.g8a5e


-- 
Shawn.
