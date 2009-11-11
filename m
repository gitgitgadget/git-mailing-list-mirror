From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: excerpts from tomorrow's "What's cooking" draft
Date: Wed, 11 Nov 2009 13:45:50 -0500 (EST)
Message-ID: <alpine.LNX.2.00.0911111259520.14365@iabervon.org>
References: <7vbpj9s8vk.fsf@alter.siamese.dyndns.org> <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="1547844168-343454484-1257962972=:14365"
Cc: Junio C Hamano <junio@pobox.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 11 19:46:12 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N8ICk-0002UL-CO
	for gcvg-git-2@lo.gmane.org; Wed, 11 Nov 2009 19:46:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758477AbZKKSpq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Nov 2009 13:45:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758470AbZKKSpq
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Nov 2009 13:45:46 -0500
Received: from iabervon.org ([66.92.72.58]:55874 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758375AbZKKSpp (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Nov 2009 13:45:45 -0500
Received: (qmail 370 invoked by uid 1000); 11 Nov 2009 18:45:50 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 11 Nov 2009 18:45:50 -0000
In-Reply-To: <fabb9a1e0911110957k599ac3dfmd1a44a0499c72b2d@mail.gmail.com>
User-Agent: Alpine 2.00 (LNX 1167 2008-08-23)
Content-ID: <alpine.LNX.2.00.0911111340540.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132686>

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

--1547844168-343454484-1257962972=:14365
Content-Type: TEXT/PLAIN; CHARSET=ISO-8859-15
Content-Transfer-Encoding: 8BIT
Content-ID: <alpine.LNX.2.00.0911111340541.14365@iabervon.org>

On Wed, 11 Nov 2009, Sverre Rabbelier wrote:

> Heya,
> 
> On Wed, Nov 11, 2009 at 10:34, Junio C Hamano <junio@pobox.com> wrote:
> > * sr/gfi-options (2009-09-06) 6 commits.
> >  - fast-import: test the new option command
> >  - ...
> >  - fast-import: put option parsing code in separate functions
> >
> > It seemed to be moving again soon, but nothing has happened yet...
> 
> I ran out of git time due to the start of my uni's next quarter, this
> is next on my to-do list though, as my remote helper depends on it.
> 
> > * sr/vcs-helper (2009-11-06) 12 commits
> >  - Add Python support library for remote helpers
> >  - ...
> >  - Fix memory leak in helper method for disconnect
> >
> > Re-rolled series that contains Daniel's and Johan's.
> > Any comments?  Is everybody happy?
> 
> Daniel, are you going to send a follow-up to the memory-leaking patch?
> If not, this needs to stay out of next until I have time to do so. My
> gitdir patch might need to be evicted as it is connected to
> sr/gfi-options which is not yet done. Also, we need to update the
> documentation, but I think we can at least start cooking it in next
> without these documentation updates?

Okay, finally got to it just now. This is entirely untested (because I 
don't have anything that uses it), but it compiles and should be correct. 
It would be nice to get a clean bill of health on it from valgrind.

If it works, please squash it into my other patch, keep that commit 
message, and add my sign-off.

commit 5fdebd88a8e5c2714470c86a2c13ee2c795210cb
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Wed Nov 11 13:36:36 2009 -0500

    Free memory used by remote helper importing refspecs, document
    
    "Allow helper to map private ref names into normal names" was just an
    RFD which turned out to be surprisingly correct. This adds the necessary
    memory-management and documentation, and generally makes it a suitable
    patch.
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/Documentation/git-remote-helpers.txt b/Documentation/git-remote-helpers.txt
index 2c5130f..f4b6a5a 100644
--- a/Documentation/git-remote-helpers.txt
+++ b/Documentation/git-remote-helpers.txt
@@ -46,7 +46,11 @@ Supported if the helper has the "fetch" capability.
 'import' <name>::
 	Produces a fast-import stream which imports the current value
 	of the named ref. It may additionally import other refs as
-	needed to construct the history efficiently.
+	needed to construct the history efficiently. The script writes
+	to a helper-specific private namespace. The value of the named
+	ref should be written to a location in this namespace derived
+	by applying the refspecs from the "refspec" capability to the
+	name of the ref.
 +
 Supported if the helper has the "import" capability.
 
@@ -67,6 +71,16 @@ CAPABILITIES
 'import'::
 	This helper supports the 'import' command.
 
+'refspec' 'spec'::
+	When using the import command, expect the source ref to have
+	been written to the destination ref. The earliest applicable
+	refspec takes precedence. For example
+	"refs/heads/*:refs/svn/origin/branches/*" means that, after an
+	"import refs/heads/name", the script has written to
+	refs/svn/origin/branches/name. If this capability is used at
+	all, it must cover all refs reported by the list command; if
+	it is not used, it is effectively "*:*"
+
 REF LIST ATTRIBUTES
 -------------------
 
diff --git a/remote.c b/remote.c
index 09e14a8..1f7870d 100644
--- a/remote.c
+++ b/remote.c
@@ -673,6 +673,16 @@ static struct refspec *parse_push_refspec(int nr_refspec, const char **refspec)
 	return parse_refspec_internal(nr_refspec, refspec, 0, 0);
 }
 
+void free_refspec(int nr_refspec, struct refspec *refspec)
+{
+	int i;
+	for (i = 0; i < nr_refspec; i++) {
+		free(refspec[i].src);
+		free(refspec[i].dst);
+	}
+	free(refspec);
+}
+
 static int valid_remote_nick(const char *name)
 {
 	if (!name[0] || is_dot_or_dotdot(name))
diff --git a/remote.h b/remote.h
index c2f920b..f89cb0e 100644
--- a/remote.h
+++ b/remote.h
@@ -91,6 +91,8 @@ void ref_remove_duplicates(struct ref *ref_map);
 int valid_fetch_refspec(const char *refspec);
 struct refspec *parse_fetch_refspec(int nr_refspec, const char **refspec);
 
+void free_refspec(int nr_refspec, struct refspec *refspecs);
+
 char *apply_refspecs(struct refspec *refspecs, int nr_refspec,
 		     const char *name);
 
diff --git a/transport-helper.c b/transport-helper.c
index 7ea76fd..cea646c 100644
--- a/transport-helper.c
+++ b/transport-helper.c
@@ -72,8 +72,13 @@ static struct child_process *get_helper(struct transport *transport)
 		}
 	}
 	if (refspecs) {
+		int i;
 		data->refspec_nr = refspec_nr;
 		data->refspecs = parse_fetch_refspec(refspec_nr, refspecs);
+		for (i = 0; i < refspec_nr; i++) {
+			free((char *)refspecs[i]);
+		}
+		free(refspecs);
 	}
 	return data->helper;
 }
@@ -90,6 +95,8 @@ static int disconnect_helper(struct transport *transport)
 		free(data->helper);
 		data->helper = NULL;
 	}
+	free_refspec(data->refspec_nr, data->refspecs);
+	data->refspecs = NULL;
 	return 0;
 }
 
--1547844168-343454484-1257962972=:14365--
