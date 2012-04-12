From: Jeff King <peff@peff.net>
Subject: Re: push.default: current vs upstream
Date: Thu, 12 Apr 2012 03:55:35 -0400
Message-ID: <20120412075535.GC31122@sigill.intra.peff.net>
References: <vpqty12h995.fsf@bauges.imag.fr>
 <20120405131301.GB10293@sigill.intra.peff.net>
 <vpqwr5uceis.fsf@bauges.imag.fr>
 <20120406071520.GD25301@sigill.intra.peff.net>
 <vpqr4w12tjj.fsf@bauges.imag.fr>
 <20120406080004.GA27940@sigill.intra.peff.net>
 <4F7FF19B.1060407@alum.mit.edu>
 <20120407075150.GA18168@sigill.intra.peff.net>
 <7viphaygsg.fsf@alter.siamese.dyndns.org>
 <vpq62d6dyzr.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>, git@vger.kernel.org
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Thu Apr 12 09:55:45 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SIEsZ-0005AO-16
	for gcvg-git-2@plane.gmane.org; Thu, 12 Apr 2012 09:55:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175Ab2DLHzi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Apr 2012 03:55:38 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58412
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751193Ab2DLHzh (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2012 03:55:37 -0400
Received: (qmail 24368 invoked by uid 107); 12 Apr 2012 07:55:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 12 Apr 2012 03:55:43 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 12 Apr 2012 03:55:35 -0400
Content-Disposition: inline
In-Reply-To: <vpq62d6dyzr.fsf@bauges.imag.fr>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195310>

On Wed, Apr 11, 2012 at 06:17:28PM +0200, Matthieu Moy wrote:

> > This makes the first priority for 1.7.10 cycle to come up with a solid
> > implementation of the "beginner" mode, I guess.
> 
> I guess so. I found the idea relevant the first time it came in the
> discussion, and I'm starting to get really convinced that this is the
> way to go. And if we're wrong, it will be much easier to migrate to
> either "current" or "upstream" later.
> 
> No time to code this right now, but I may come up with a patch in a few
> days. Any idea on the real name? I'd call it "safeUpstream" or
> "safeCurrent", but that's probably by lack of a better name.

I think it is as simple as applying the usual upstream rules, then
checking the remote name against the local name. Like this:

diff --git a/builtin/push.c b/builtin/push.c
index b6c0fee..6077ecc 100644
--- a/builtin/push.c
+++ b/builtin/push.c
@@ -75,7 +75,7 @@ static int push_url_of_remote(struct remote *remote, const char ***url_p)
 	return remote->url_nr;
 }
 
-static void setup_push_upstream(struct remote *remote)
+static void setup_push_upstream(struct remote *remote, int simple)
 {
 	struct strbuf refspec = STRBUF_INIT;
 	struct branch *branch = branch_get(NULL);
@@ -103,6 +103,29 @@ static void setup_push_upstream(struct remote *remote)
 		      "to update which remote branch."),
 		    remote->name, branch->name);
 
+	if (simple && strcmp(branch->refname, branch->merge[0]->src)) {
+		/*
+		 * There's no point in using shorten_unambiguous_ref here,
+		 * as the ambiguity would be on the remote side, not what
+		 * we have locally. Plus, this is supposed to be the simple
+		 * mode. If the user is doing something crazy like setting
+		 * upstream to a non-branch, we should probably be showing
+		 * them the big ugly fully qualified ref.
+		 */
+		const char *short_up = skip_prefix(branch->merge[0]->src, "refs/heads/");
+		die(_("The upstream branch of your current branch does not match\n"
+		      "the name of your current branch.  To push to the upstream branch\n"
+		      "on the remote, use\n"
+		      "\n"
+		      "    git push %s HEAD:%s\n"
+		      "\n"
+		      "To push to the branch of the same name on the remote, use\n"
+		      "\n"
+		      "    git push %s %s\n"),
+		    remote->name, short_up ? short_up : branch->merge[0]->src,
+		    remote->name, branch->name);
+	}
+
 	strbuf_addf(&refspec, "%s:%s", branch->name, branch->merge[0]->src);
 	add_refspec(refspec.buf);
 }
@@ -115,8 +138,12 @@ static void setup_default_push_refspecs(struct remote *remote)
 		add_refspec(":");
 		break;
 
+	case PUSH_DEFAULT_SIMPLE:
+		setup_push_upstream(remote, 1);
+		break;
+
 	case PUSH_DEFAULT_UPSTREAM:
-		setup_push_upstream(remote);
+		setup_push_upstream(remote, 0);
 		break;
 
 	case PUSH_DEFAULT_CURRENT:
diff --git a/cache.h b/cache.h
index e12b15f..0f862dd 100644
--- a/cache.h
+++ b/cache.h
@@ -624,6 +624,7 @@ enum rebase_setup_type {
 enum push_default_type {
 	PUSH_DEFAULT_NOTHING = 0,
 	PUSH_DEFAULT_MATCHING,
+	PUSH_DEFAULT_SIMPLE,
 	PUSH_DEFAULT_UPSTREAM,
 	PUSH_DEFAULT_CURRENT
 };
diff --git a/config.c b/config.c
index ad03908..0ca0a6f 100644
--- a/config.c
+++ b/config.c
@@ -824,6 +824,8 @@ static int git_default_push_config(const char *var, const char *value)
 			push_default = PUSH_DEFAULT_NOTHING;
 		else if (!strcmp(value, "matching"))
 			push_default = PUSH_DEFAULT_MATCHING;
+		else if (!strcmp(value, "simple"))
+			push_default = PUSH_DEFAULT_SIMPLE;
 		else if (!strcmp(value, "upstream"))
 			push_default = PUSH_DEFAULT_UPSTREAM;
 		else if (!strcmp(value, "tracking")) /* deprecated */
diff --git a/environment.c b/environment.c
index c93b8f4..1defcd4 100644
--- a/environment.c
+++ b/environment.c
@@ -52,7 +52,7 @@ enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;
 enum branch_track git_branch_track = BRANCH_TRACK_REMOTE;
 enum rebase_setup_type autorebase = AUTOREBASE_NEVER;
-enum push_default_type push_default = PUSH_DEFAULT_MATCHING;
+enum push_default_type push_default = PUSH_DEFAULT_SIMPLE;
 #ifndef OBJECT_CREATION_MODE
 #define OBJECT_CREATION_MODE OBJECT_CREATION_USES_HARDLINKS
 #endif
