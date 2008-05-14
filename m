From: Daniel Barkalow <barkalow@iabervon.org>
Subject: Re: mergetool feature request - select remote or local
Date: Wed, 14 May 2008 14:40:47 -0400 (EDT)
Message-ID: <alpine.LNX.1.00.0805141351540.19665@iabervon.org>
References: <200805140721.13719.xenoterracide@gmail.com> <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Caleb Cushing <xenoterracide@gmail.com>, git@vger.kernel.org,
	Theodore Ts'o <tytso@mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 14 20:42:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JwLvV-0003mj-H9
	for gcvg-git-2@gmane.org; Wed, 14 May 2008 20:42:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761774AbYENSkz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 May 2008 14:40:55 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758647AbYENSkz
	(ORCPT <rfc822;git-outgoing>); Wed, 14 May 2008 14:40:55 -0400
Received: from iabervon.org ([66.92.72.58]:34344 "EHLO iabervon.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1761632AbYENSky (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 May 2008 14:40:54 -0400
Received: (qmail 20625 invoked by uid 1000); 14 May 2008 18:40:47 -0000
Received: from localhost (sendmail-bs@127.0.0.1)
  by localhost with SMTP; 14 May 2008 18:40:47 -0000
In-Reply-To: <7vzlqsok0y.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 1.00 (LNX 882 2007-12-20)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/82131>

On Wed, 14 May 2008, Junio C Hamano wrote:

> This makes me wonder if you are better off not using mergetool in such a
> situation.  Instead, perhaps
> 
> 	$ git ls-files -u --no-stage | xargs git checkout MERGE_HEAD
> 
> might be a better option?  The attached is a completely untested
> weather-baloon patch.
> 
> If this turns out to be a better approach, perhaps we would further want
> to tweak things to make:
> 
> 	$ git checkout --unmerged MERGE_HEAD [--] [<pathspec>...]
> 
> to work (if you want "local", you would use "HEAD" instead of
> "MERGE_HEAD").

This is "for all (or some, by pathspecs) files currently unmerged in the 
index, resolve them to the version in MERGE_HEAD", right?

> I would have done so here if "git checkout" were still a scripted version,
> but now it is in C, it would take significantly more effort than it is
> worth just to raise a weatherbaloon.

Like this (also untested)? (This is missing defaulting to a pathspec of 
'.' if --unmerged is used without any pathspecs)

diff --git a/builtin-checkout.c b/builtin-checkout.c
index 10ec137..0bae1d4 100644
--- a/builtin-checkout.c
+++ b/builtin-checkout.c
@@ -42,6 +42,8 @@ static int post_checkout_hook(struct commit *old, struct commit *new,
 	return run_command(&proc);
 }
 
+static int unmerged;
+
 static int update_some(const unsigned char *sha1, const char *base, int baselen,
 		       const char *pathname, unsigned mode, int stage)
 {
@@ -59,6 +61,13 @@ static int update_some(const unsigned char *sha1, const char *base, int baselen,
 	hashcpy(ce->sha1, sha1);
 	memcpy(ce->name, base, baselen);
 	memcpy(ce->name + baselen, pathname, len - baselen);
+	if (unmerged) {
+		int pos = cache_name_pos(ce->name, len);
+		if (!(pos && pos < active_nr && ce_same_name(active_cache[pos], active_cache[pos + 1]))) {
+			free(ce);
+			return 0;
+		}
+	}
 	ce->ce_flags = create_ce_flags(len, 0);
 	ce->ce_mode = create_ce_mode(mode);
 	add_cache_entry(ce, ADD_CACHE_OK_TO_ADD | ADD_CACHE_OK_TO_REPLACE);
@@ -508,6 +517,7 @@ int cmd_checkout(int argc, const char **argv, const char *prefix)
 			BRANCH_TRACK_EXPLICIT),
 		OPT_BOOLEAN('f', NULL, &opts.force, "force"),
 		OPT_BOOLEAN('m', NULL, &opts.merge, "merge"),
+		OPT_BOOLEAN( 0 , "unmerged", &unmerged, "check out unmerged paths"),
 		OPT_END(),
 	};
 
