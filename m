From: Nicolas Pitre <nico@fluxnic.net>
Subject: [PATCH] make 'git clone' ask the remote only for objects it cares about
Date: Fri, 25 Sep 2009 23:54:42 -0400 (EDT)
Message-ID: <alpine.LFD.2.00.0909252314260.4997@xanadu.home>
References: <m2tz0j154o.fsf@igel.home>
 <alpine.LFD.2.00.0908082246020.440@xanadu.home>
 <m2k51dzb39.fsf@linux-m68k.org> <4ABD0669.7050309@redhat.com>
 <vpqvdj6izt6.fsf@bauges.imag.fr>
 <alpine.LFD.2.00.0909251551290.4997@xanadu.home> <4ABD25FE.2040902@redhat.com>
 <alpine.LFD.2.00.0909251629330.4997@xanadu.home> <4ABD4F7B.4030701@redhat.com>
 <alpine.LFD.2.00.0909252045290.4997@xanadu.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Cc: Jason Merrill <jason@redhat.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Hin-Tak Leung <hintak.leung@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 26 05:55:06 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MrONF-0001Ky-I0
	for gcvg-git-2@lo.gmane.org; Sat, 26 Sep 2009 05:55:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202AbZIZDyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Sep 2009 23:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751197AbZIZDyj
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Sep 2009 23:54:39 -0400
Received: from relais.videotron.ca ([24.201.245.36]:41654 "EHLO
	relais.videotron.ca" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751072AbZIZDyi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Sep 2009 23:54:38 -0400
Received: from xanadu.home ([66.130.28.92]) by VL-MH-MR002.ip.videotron.ca
 (Sun Java(tm) System Messaging Server 6.3-4.01 (built Aug  3 2007; 32bit))
 with ESMTP id <0KQK008238762U90@VL-MH-MR002.ip.videotron.ca> for
 git@vger.kernel.org; Fri, 25 Sep 2009 23:54:42 -0400 (EDT)
X-X-Sender: nico@xanadu.home
In-reply-to: <alpine.LFD.2.00.0909252045290.4997@xanadu.home>
User-Agent: Alpine 2.00 (LFD 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/129142>

Current behavior of 'git clone' when not using --mirror is to fetch 
everything from the peer, and then filter out unwanted refs just before 
writing them out to the cloned repository.  This may become highly 
inefficient if the peer has an unusual ref namespace, or if it simply 
has "remotes" refs of its own, and those locally unwanted refs are 
connecting to a large set of objects which becomes unreferenced as soon 
as they are fetched.

Let's filter out those unwanted refs from the peer _before_ asking it 
what refs we want to fetch instead, which is the most logical thing to 
do anyway.

Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
---

On Fri, 25 Sep 2009, Nicolas Pitre wrote:

> On Fri, 25 Sep 2009, Jason Merrill wrote:
> 
> > On 09/25/2009 04:47 PM, Nicolas Pitre wrote:
> > > Do you have access to the remote machine?  Is it possible to have a
> > > tarball of the gcc.git directory from there?
> > 
> > http://gcc.gnu.org/gcc-git.tar.gz
> > 
> > I'll leave it there for a few days.
> 
> Thanks, I got it now.  And I was able to reproduce the issue locally.
> 
> Cloning the original repository does transfer objects which become 
> unreferenced in the clone.  But cloning that cloned repository (before 
> pruning the unreferenced objects) does not transfer those objects again.  
> 
> Just need to find out why.

And the "why" is described above.  The problem was actually on the 
client side and was affecting clones of any repository containing 
anything outside refs/heads and refs/tags.

The fact that the git repository on gcc.gnu.org has lots of stuff in 
"remote" branches that don't get cloned by default is a separate 
configuration/policy issue on that server which might need (or not) to 
be looked into.  For instance at least, as a bare repository, it should 
have all the git files in gcc.git/ directly instead of gcc.git/.git/.

diff --git a/builtin-clone.c b/builtin-clone.c
index bab2d84..edf7c7f 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -329,24 +329,28 @@ static void remove_junk_on_signal(int signo)
 	raise(signo);
 }
 
-static struct ref *write_remote_refs(const struct ref *refs,
-		struct refspec *refspec, const char *reflog)
+static struct ref *wanted_peer_refs(const struct ref *refs,
+		struct refspec *refspec)
 {
 	struct ref *local_refs = NULL;
 	struct ref **tail = &local_refs;
-	struct ref *r;
 
 	get_fetch_map(refs, refspec, &tail, 0);
 	if (!option_mirror)
 		get_fetch_map(refs, tag_refspec, &tail, 0);
 
+	return local_refs;
+}
+
+static void write_remote_refs(const struct ref *local_refs, const char *reflog)
+{
+	const struct ref *r;
+
 	for (r = local_refs; r; r = r->next)
 		add_extra_ref(r->peer_ref->name, r->old_sha1, 0);
 
 	pack_refs(PACK_REFS_ALL);
 	clear_extra_refs();
-
-	return local_refs;
 }
 
 int cmd_clone(int argc, const char **argv, const char *prefix)
@@ -495,9 +499,10 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 
 	strbuf_reset(&value);
 
-	if (path && !is_bundle)
+	if (path && !is_bundle) {
 		refs = clone_local(path, git_dir);
-	else {
+		mapped_refs = wanted_peer_refs(refs, refspec);
+	} else {
 		struct remote *remote = remote_get(argv[0]);
 		transport = transport_get(remote, remote->url[0]);
 
@@ -520,14 +525,16 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		refs = transport_get_remote_refs(transport);
-		if (refs)
-			transport_fetch_refs(transport, refs);
+		if (refs) {
+			mapped_refs = wanted_peer_refs(refs, refspec);
+			transport_fetch_refs(transport, mapped_refs);
+		}
 	}
 
 	if (refs) {
 		clear_extra_refs();
 
-		mapped_refs = write_remote_refs(refs, refspec, reflog_msg.buf);
+		write_remote_refs(mapped_refs, reflog_msg.buf);
 
 		remote_head = find_ref_by_name(refs, "HEAD");
 		remote_head_points_at =
