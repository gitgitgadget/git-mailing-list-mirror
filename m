From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [PATCH v2 09/13] Honour the refspec when updating refs after 
 import
Date: Thu, 5 Nov 2009 01:53:37 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911050145010.14365@iabervon.org>
References: <1257364098-1685-1-git-send-email-srabbelier@gmail.com>  <1257364098-1685-10-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0911041601170.14365@iabervon.org>  <fabb9a1e0911041321i1ccec898r53ddafb9405c6331@mail.gmail.com> 
 <alpine.LNX.2.00.0911041624401.14365@iabervon.org> <fabb9a1e0911041745x577f7e4rc678da4d7d559193@mail.gmail.com> <alpine.LNX.2.00.0911050016360.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 05 07:54:18 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5wEb-0005AB-QP
	for gcvg-git-2@lo.gmane.org; Thu, 05 Nov 2009 07:54:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756057AbZKEGxe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Nov 2009 01:53:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756025AbZKEGxd
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Nov 2009 01:53:33 -0500
Received: from iabervon.org ([66.92.72.58]:52879 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754949AbZKEGxd (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Nov 2009 01:53:33 -0500
Received: (qmail 17199 invoked by uid 1000); 5 Nov 2009 06:53:37 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 5 Nov 2009 06:53:37 -0000
In-Reply-To: <alpine.LNX.2.00.0911050016360.14365@iabervon.org>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132203>

On Thu, 5 Nov 2009, Daniel Barkalow wrote:

> On Thu, 5 Nov 2009, Sverre Rabbelier wrote:
> 
> > Heya,
> > 
> > On Wed, Nov 4, 2009 at 22:30, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > > On Wed, 4 Nov 2009, Sverre Rabbelier wrote:
> > >> On Wed, Nov 4, 2009 at 22:20, Daniel Barkalow <barkalow@iabervon.org> wrote:
> > >> > That's not true for "git pull <url> <branch>"; we do want the remote ref,
> > >> > but it doesn't have a local peer.
> > 
> > No, I don't think that's right, when doing a fetch we want to store
> > the refs somewhere, sure, but not under 'refs/heads/<branch>', perhaps
> > 'refs/hg/fetch/<branch>', either way, the current code does not work.
> 
> I think you've still got things backwards. From the point of view of 
> transport.c, refs/<vcs> is entirely opaque, and we never look at it. Those 
> aren't local peers. They're a way for the helper to communicate to 
> transport-helper.c. The user says: pull refs/heads/master of this hg 
> repo. Transport.c tries to fetch refs/heads/master and get the sha1 to 
> write into FETCH_HEAD or wherever. Transport-helper.c says "import 
> refs/heads/master", and git-fast-import reads the resulting script and 
> writes some ref that the helper tells it to write. Then transport-helper.c 
> figures out where the ref was written, reads it, and updates the struct 
> ref representing the remote info. Then builtin-fetch looks at the struct 
> ref and writes it to the local repositories ref namespace or FETCH_HEAD.
> 
> > >> >I think going straight to the refspec
> > >> > command is the right answer.
> > >>
> > >> Can you clarity what you mean with "the refspec command"?
> > >
> > > Whatever it is that lets the helper tell the transport code where in the
> > > helper's private namespace to look for refs. I'd been thinking the helper
> > > would advertize the "refspec" capability, and the transport code would
> > > call the "refspec" command in order to get the helper to report that; but
> > > then I actually only said that the helper reports refspec, and not
> > > proposed a name for the command.
> > 
> > Currently I'm implementing so that it would work like this for the svn helper:
> > 
> > $ echo capabilities | git remote-svn origin /path/to/hg/repo
> > import
> > refspec +refs/trunk:refs/svn/origin/trunk
> > refspec +refs/branches/*:refs/svn/origin/*
> > 
> > That way we can put the refspec in the config file at clone time.
> > 
> > Now I've been browsing through the builtin-fetch code, and it looks
> > like the main problem is going to be to apply this refspec at all.
> > I'll have a more extensive look tomorrow.
> 
> This is entirely not what I think we should have. The config file should 
> say refs/heads/*:refs/remotes/origin/* like it always does, because the 
> transport will list the refs like refs/heads/* and refs/tags/* and return 
> them like that.
> 
> I'll see if I can write up an untested patch that does what I'm thinking 
> of.

Here's a patch (on my original series, which doesn't seem to be in pu any 
more, but should be floating around somewhere). Completely untested, 
except that it compiles. The idea is that the helper will say something 
like:

refspec refs/heads/master:refs/svn/origin/trunk
refspec refs/heads/*:refs/svn/origin/branches/*
refspec refs/tags/*:refs/svn/origin/tags/*

and transport-helper will use these patterns to figure out where to find 
the correct value from the helper's private namespace when asked to fetch 
refs/heads/topic.

	-Daniel

commit 483836f6411d2317f24c7594c557fb01133508b6
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Thu Nov 5 01:39:02 2009 -0500

    Allow helper to map private ref names into normal names
    
    This allows a helper to say that, when it handles "import
    refs/heads/topic", the script it outputs will actually write to
    refs/svn/origin/branches/topic; therefore, transport-helper should
    read it from the latter location after git-fast-import completes.

diff --git a/remote.c b/remote.c
index f0441c4..58d1a61 100644
--- a/remote.c
+++ b/remote.c
@@ -790,6 +790,24 @@ static int match_name_with_pattern(const char *key, const char *name,
 	return ret;
 }
 
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name)
+{
+	int i;
+	char *ret = NULL;
+	for (i = 0; i < nr_refspec; i++) {
+		struct refspec *refspec = refspecs + i;
+		if (refspec->pattern) {
+			if (match_name_with_pattern(refspec->src, name,
+						    refspec->dst, &ret))
+				return ret;
+		} else if (!strcmp(refspec->src, name))
+			return strdup(refspec->dst);
+	}
+	return NULL;
+	
+}
+
 int remote_find_tracking(struct remote *remote, struct refspec *refspec)
 {
 	int find_src = refspec->src == NULL;
diff --git a/remote.h b/remote.h
index ac0ce2f..c2f920b 100644
--- a/remote.h
+++ b/remote.h
@@ -91,6 +91,9 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
+char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
+		     const char *name);
+
 int match_refs(struct ref *src, struct ref **dst,
 	       int nr_refspec, const char **refspec, int all);
 
diff --git a/transport-helper.c b/transport-helper.c
index aa5ad3c..88573e7 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -5,6 +5,7 @@
 #include "commit.h"
 #include "diff.h"
 #include "revision.h"
+#include "remote.h"
 
 struct helper_data
 {
@@ -12,6 +13,9 @@ struct helper_data
 	struct child_process *helper;
 	unsigned fetch : 1;
 	unsigned import : 1;
+	/* These go from remote name (as in "list") to private name */
+	struct refspec *refspecs;
+	int refspec_nr;
 };
 
 static struct child_process *get_helper(struct transport *transport)
@@ -20,6 +24,9 @@ static struct child_process *get_helper(struct transport *transport)
 	struct strbuf buf = STRBUF_INIT;
 	struct child_process *helper;
 	FILE *file;
+	const char **refspecs = NULL;
+	int refspec_nr = 0;
+	int refspec_alloc = 0;
 
 	if (data->helper)
 		return data->helper;
@@ -53,6 +60,16 @@ static struct child_process *get_helper(struct transport *transport)
 			data->fetch = 1;
 		if (!strcmp(buf.buf, "import"))
 			data->import = 1;
+		if (!prefixcmp(buf.buf, "refspec ")) {
+			ALLOC_GROW(refspecs,
+				   refspec_nr + 1,
+				   refspec_alloc);
+			refspecs[refspec_nr++] = strdup(buf.buf + strlen("refspec "));
+		}
+	}
+	if (refspecs) {
+		data->refspec_nr = refspec_nr;
+		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
 	}
 	return data->helper;
 }
@@ -121,6 +138,7 @@ static int fetch_with_import(struct transport *transport,
 {
 	struct child_process fastimport;
 	struct child_process *helper = get_helper(transport);
+	struct helper_data *data = transport->data;
 	int i;
 	struct ref *posn;
 	struct strbuf buf = STRBUF_INIT;
@@ -141,10 +159,16 @@ static int fetch_with_import(struct transport *transport,
 	finish_command(&fastimport);
 
 	for (i = 0; i < nr_heads; i++) {
+		char *private;
 		posn = to_fetch[i];
 		if (posn->status & REF_STATUS_UPTODATE)
 			continue;
-		read_ref(posn->name, posn->old_sha1);
+		if (data->refspecs)
+			private = apply_refspecs(data->refspecs, data->refspec_nr, posn->name);
+		else
+			private = strdup(posn->name);
+		read_ref(private, posn->old_sha1);
+		free(private);
 	}
 	return 0;
 }
