From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: [RFC PATCH 3/3] Support fetching from foreign VCSes
Date: Sat, 31 Jan 2009 21:35:42 -0500 (EST)
Message-ID: <alpine.LNX.1.00.0901312122340.19665@iabervon.org>
References: <alpine.LNX.1.00.0901110335520.19665@iabervon.org> <200902010320.28128.johan@herland.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Sun Feb 01 03:37:17 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LTSCy-0006bB-E2
	for gcvg-git-2@gmane.org; Sun, 01 Feb 2009 03:37:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752279AbZBACfp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 31 Jan 2009 21:35:45 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752068AbZBACfo
	(ORCPT <rfc822;git-outgoing>); Sat, 31 Jan 2009 21:35:44 -0500
Received: from iabervon.org ([66.92.72.58]:53830 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751797AbZBACfn (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 31 Jan 2009 21:35:43 -0500
Received: (qmail 23786 invoked by uid 1000); 1 Feb 2009 02:35:42 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 1 Feb 2009 02:35:42 -0000
In-Reply-To: <200902010320.28128.johan@herland.net>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/107972>

On Sun, 1 Feb 2009, Johan Herland wrote:

> On Sunday 11 January 2009, Daniel Barkalow wrote:
> > This supports a useful subset of the usual fetch logic, mostly in the
> > config file.
> 
> Hi,
> 
> I love the idea of this patch series, and have started working on a CVS 
> backend for this. I have a question though...
> 
> > Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>
> > ---
> >  builtin-fetch.c |  135
> > +++++++++++++++++++++++++++++++++++++++++++++++++++++- 1 files changed,
> > 132 insertions(+), 3 deletions(-)
> >
> > diff --git a/builtin-fetch.c b/builtin-fetch.c
> > index 7b46f8f..14e037e 100644
> > --- a/builtin-fetch.c
> > +++ b/builtin-fetch.c
> > @@ -614,6 +614,136 @@ static void set_option(const char *name, const char
> > *value) name, transport->url);
> >  }
> >
> > +static struct ref *list_foreign(struct remote *remote)
> > +{
> 
> [...]
> 
> > +}
> > +
> > +static int import_foreign(struct remote *remote, struct ref *refs)
> > +{
> 
> [...]
> 
> > +}
> > +
> > +static int fetch_foreign(struct remote *remote)
> > +{
> > +	struct ref *remote_refs = list_foreign(remote);
> 
> We retrieve a list of all refs available at the given remote...
> 
> > +	struct ref *ref_map = NULL;
> > +	struct ref *rm;
> > +	struct ref **tail = &ref_map;
> > +	struct branch *branch;
> > +	int i;
> > +
> > +	int exit_code = import_foreign(remote, remote_refs);
> 
> ...and then we start fetching _all_ the refs returned by list_foreign().
> 
> When I call "git fetch <vcs-remote> <ref>", I expect _only_ <ref> to be 
> fetched from the remote, but it seems the above code doesn't even concern 
> itself with the ref(s) specified on the "git fetch" command-line
> 
> I'm not even sure why list_foreign() should be called in this case (except, 
> maybe, to verify the existence of <ref> before attempting to fetch it).
> 
> AFAICS list_foreign() is only needed by "git fetch" if <ref> contains a 
> wildcard (like the default refspec: +refs/heads/*:refs/remotes/<remote>/*).
> 
> ...or have I misunderstood something fundamental about how this is going to 
> work?

Nope, I was just a bit lazy; I just didn't implement looking at the 
command line (I just use "git fetch" when I'm using this), and my goal is 
to use wildcards (although I haven't gotten wildcards implemented that can 
match the branch names than come naturally out of the particular foreign 
system I'm using).

I was also staying as close as possible to the git design, where it always 
fetches the complete list and then looks at what matches. It would 
probably be a good optimization to only ask for the complete list if it's 
needed to determine what specific refs to ask for.

Incidently, you probably want this patch so it doesn't crash if you don't 
have a merge config:

commit 71266fe87dae351c0f77b0ecf8802dab2909db05
Author: Daniel Barkalow <barkalow@iabervon.org>
Date:   Fri Jan 30 20:30:10 2009 -0500

    Fix bug with not having merge config
    
    Signed-off-by: Daniel Barkalow <barkalow@iabervon.org>

diff --git a/builtin-fetch.c b/builtin-fetch.c
index 14e037e..63e0637 100644
--- a/builtin-fetch.c
+++ b/builtin-fetch.c
@@ -710,6 +710,7 @@ static int fetch_foreign(struct remote *remote)
 	struct ref **tail = &ref_map;
 	struct branch *branch;
 	int i;
+	int has_merge;
 
 	int exit_code = import_foreign(remote, remote_refs);
 	if (exit_code)
@@ -729,9 +730,11 @@ static int fetch_foreign(struct remote *remote)
 
 	branch = branch_get(NULL);
 
+	has_merge = branch_has_merge_config(branch);
+
 	for (i = 0; i < remote->fetch_refspec_nr; i++) {
 		get_fetch_map(remote_refs, &remote->fetch[i], &tail, 0);
-		if (!strcmp(branch->remote_name, remote->name))
+		if (has_merge && !strcmp(branch->remote_name, remote->name))
 			add_merge_config(&ref_map, remote_refs, branch, &tail);
 	}
 

	-Daniel
*This .sig left intentionally blank*
