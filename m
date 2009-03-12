From: Finn Arne Gangstad <finnag@pvv.org>
Subject: Re: [PATCH v2] New config push.default to decide default behavior
	for push
Date: Thu, 12 Mar 2009 12:54:33 +0100
Message-ID: <20090312115433.GA2848@pvv.org>
References: <20090311220144.GA6782@pvv.org> <7vwsavlg6q.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 12 12:56:35 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LhjWb-0007T7-TZ
	for gcvg-git-2@gmane.org; Thu, 12 Mar 2009 12:56:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755282AbZCLLyj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Mar 2009 07:54:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754571AbZCLLyj
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Mar 2009 07:54:39 -0400
Received: from decibel.pvv.ntnu.no ([129.241.210.179]:58308 "EHLO
	decibel.pvv.ntnu.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752020AbZCLLyi (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Mar 2009 07:54:38 -0400
Received: from finnag by decibel.pvv.ntnu.no with local (Exim 4.69)
	(envelope-from <finnag@pvv.ntnu.no>)
	id 1LhjUf-000747-So; Thu, 12 Mar 2009 12:54:33 +0100
Content-Disposition: inline
In-Reply-To: <7vwsavlg6q.fsf@gitster.siamese.dyndns.org>
User-Agent: Mutt/1.5.17+20080114 (2008-01-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113049>

On Wed, Mar 11, 2009 at 05:48:13PM -0700, Junio C Hamano wrote:

> I thought I fixed asciidoc formatting around this part in the version I
> queued in 'pu'; in any case, the second and subsequent paragraphs need
> dedenting.

I am sorry, it wasn't immediately obvious to me that you had changed
the version i sent. Fixed up this (and other fixes) in my working
branch I think.

> > +static void setup_push_tracking(struct remote *remote)
> > +{
> > +	int n;
> > +	struct branch *branch = branch_get(NULL);
> > +	if (!branch)
> > +		die("You are not currently on a branch.");
> > +	if (!branch->merge_nr)
> > +		die("The current branch %s is not tracking anything.",
> > +		    branch->name);
> > +	if (branch->remote != remote)
> > +		die("The current branch is tracking \"%s\", not \"%s\"!",
> > +		    branch->remote->name, remote->name);
> > +	for (n = 0; n < branch->merge_nr; n++) {
> > +		struct strbuf rs = STRBUF_INIT;
> > +		strbuf_addf(&rs, "%s:%s", branch->name, branch->merge[n]->src);
> > +		add_refspec(rs.buf);
> > +	}
> > +}
> 
> If a branch is configured to merge from multiple places (e.g. testing
> branch similar to the linux-next tree to integrate from multiple staging
> trees), a sane default would be not to push it out to any of the branches
> it pulls from---it is a consumer to the other branches, and it is meant to
> be sent to somewhere else, not back to any of the originators.  Instead,
> this code will push to all of them, which I would not see any sane use
> case for.  It might make a bit sense if you refused unless merge_nr is
> exactly one.

Yes I agree, fixed this up.

> Also I am not sure if the check between the name of the remote makes much
> practical sense.  Many people use two remotes to name the same one for
> pushing over ssh and fetching over git.  Which name comes in which?  I
> think with this logic you are trying to catch a mistake like:
> 
>     $ git push --tracking $there

Yes that was the idea. I was not familiar with the "multiple remotes
to the same thing" common usage, but have no problems supporting that
instead.

Something like this amended into the last commit? I can amend it on top
of the last one and resend if that is better.

--8<--
git push tracking mode fixes

If a branch is tracking multiple branches, refuse to push it.
Some asciidoc format fixes.

Signed-off-by: Finn Arne Gangstad <finnag@pvv.org>
---
To be amended into the previous commit

 Documentation/config.txt |   16 ++++++++--------
 builtin-push.c           |   25 +++++++++++--------------
 2 files changed, 19 insertions(+), 22 deletions(-)

diff --git a/Documentation/config.txt b/Documentation/config.txt
index 6fdf829..986becc 100644
--- a/Documentation/config.txt
+++ b/Documentation/config.txt
@@ -1165,19 +1165,19 @@ push.default::
 	on the command line, no refspec is configured in the remote, and
 	no refspec is implied by any of the options given on the command
 	line.
-
-	The term `current remote` means the remote configured for the current
-	branch, or `origin` if no remote is configured. `origin` is also used
-	if you are not on any branch.
-
-	Possible values are:
++
+The term `current remote` means the remote configured for the current
+branch, or `origin` if no remote is configured. `origin` is also used
+if you are not on any branch. Possible values are:
 +
 * `nothing` do not push anything.
 * `matching` push all matching branches to the current remote.
   All branches having the same name in both ends are considered to be
   matching. This is the current default value.
-* `tracking` push the current branch to whatever it is tracking.
-* `current` push the current branch to a branch of the same name.
+* `tracking` push the current branch to the branch it is tracking.
+* `current` push the current branch to a branch of the same name on the
+  current remote.
+
 
 receive.fsckObjects::
 	If it is set to true, git-receive-pack will check all received
diff --git a/builtin-push.c b/builtin-push.c
index fa5eabb..51f4c4a 100644
--- a/builtin-push.c
+++ b/builtin-push.c
@@ -48,23 +48,20 @@ static void set_refspecs(const char **refs, int nr)
 	}
 }
 
-static void setup_push_tracking(struct remote *remote)
+static void setup_push_tracking(void)
 {
-	int n;
+	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
 	if (!branch)
 		die("You are not currently on a branch.");
 	if (!branch->merge_nr)
 		die("The current branch %s is not tracking anything.",
 		    branch->name);
-	if (branch->remote != remote)
-		die("The current branch is tracking \"%s\", not \"%s\"!",
-		    branch->remote->name, remote->name);
-	for (n = 0; n < branch->merge_nr; n++) {
-		struct strbuf rs = STRBUF_INIT;
-		strbuf_addf(&rs, "%s:%s", branch->name, branch->merge[n]->src);
-		add_refspec(rs.buf);
-	}
+	if (branch->merge_nr != 1)
+		die("The current branch %s is tracking multiple branches, "
+		    "refusing to push.", branch->name);
+	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
+	add_refspec(refspec.buf);
 }
 
 static const char *warn_unconfigured_push_msg[] = {
@@ -83,14 +80,14 @@ static const char *warn_unconfigured_push_msg[] = {
 	""
 };
 
-static void warn_unconfigured_push()
+static void warn_unconfigured_push(void)
 {
 	int i;
 	for (i = 0; i < ARRAY_SIZE(warn_unconfigured_push_msg); i++)
 		warning("%s", warn_unconfigured_push_msg[i]);
 }
 
-static void do_default_push(struct remote *remote)
+static void do_default_push(void)
 {
 	git_config(git_default_config, NULL);
 	switch (push_default) {
@@ -103,7 +100,7 @@ static void do_default_push(struct remote *remote)
 		break;
 
 	case PUSH_DEFAULT_TRACKING:
-		setup_push_tracking(remote);
+		setup_push_tracking();
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
@@ -150,7 +147,7 @@ static int do_push(const char *repo, int flags)
 			refspec = remote->push_refspec;
 			refspec_nr = remote->push_refspec_nr;
 		} else if (!(flags & TRANSPORT_PUSH_MIRROR))
-			do_default_push(remote);
+			do_default_push();
 	}
 	errs = 0;
 	for (i = 0; i < remote->url_nr; i++) {
-- 
1.6.2.81.gc6c21.dirty
