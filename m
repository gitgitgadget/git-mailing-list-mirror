From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: add a planning document for the next CLI
 revamp
Date: Tue, 04 Nov 2008 22:40:49 -0800
Message-ID: <7vprlan09a.fsf@gitster.siamese.dyndns.org>
References: <20081030002239.D453B21D14E@mail.utsl.gen.nz>
 <20081031003154.GA5745@sigill.intra.peff.net>
 <7v3ai9226q.fsf@gitster.siamese.dyndns.org>
 <1225691960.20883.41.camel@maia.lan>
 <20081104091800.GB24100@dpotapov.dyndns.org>
 <1225822231.6722.3.camel@maia.lan>
 <7vr65rqnoj.fsf@gitster.siamese.dyndns.org>
 <20081105030525.GC20907@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sam Vilain <sam@vilain.net>, Dmitry Potapov <dpotapov@gmail.com>,
	Sam Vilain <samv@vilain.net>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Scott Chacon <schacon@gmail.com>,
	Tom Preston-Werner <tom@github.com>,
	"J.H." <warthog19@eaglescrag.net>,
	Christian Couder <chriscool@tuxfamily.org>,
	Kai Blin <kai@samba.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Wed Nov 05 07:42:54 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kxc6O-00073B-EK
	for gcvg-git-2@gmane.org; Wed, 05 Nov 2008 07:42:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750858AbYKEGle (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Nov 2008 01:41:34 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750812AbYKEGle
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Nov 2008 01:41:34 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:43638 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750807AbYKEGld (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Nov 2008 01:41:33 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id A121B95122;
	Wed,  5 Nov 2008 01:41:31 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 60E6695119; Wed, 
 5 Nov 2008 01:40:51 -0500 (EST)
In-Reply-To: <20081105030525.GC20907@coredump.intra.peff.net> (Jeff King's
 message of "Tue, 4 Nov 2008 22:05:25 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: C80BE4CC-AB04-11DD-9D8E-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100148>

Jeff King <peff@peff.net> writes:

> So why not take one step back in the behavior change? We can set up the
> "push just this branch" refspec during clone, which will leave existing
> repositories untouched.

That is not good enough.

People who (think) know what an unconfigured "git push" would do would
suddenly see "git push" start misbehaving in their new repositories.

Here is a patch to do what I suggested earlier.  It

 * Adds "--matching" option; if we ever change the default to "current
   branch only", then "git push $there :" forces people to type $there.
   "git push --matching" allows us to honor "branch.<name>.remote".

 * Issues a deprecation warning when "git push" and "git push $there" is
   used to trigger the "matching" behaviour, without configuration or
   explicit command line refspec ":".

Whoever wants to change the default to "current branch only" can change
the part that calls push_deprecation_warning().

I'll leave it up to people who want to change the default to implement the
same for non native transports and document the transition plan, as I am
not very keen on changing the default myself.

---

 builtin-push.c      |   11 +++++++----
 builtin-send-pack.c |    2 ++
 remote.c            |    8 ++++++++
 remote.h            |    1 +
 send-pack.h         |    1 +
 transport.c         |    1 +
 transport.h         |    1 +
 7 files changed, 21 insertions(+), 4 deletions(-)

diff --git c/builtin-push.c w/builtin-push.c
index 122fdcf..21418ab 100644
--- c/builtin-push.c
+++ w/builtin-push.c
@@ -10,7 +10,7 @@
 #include "parse-options.h"
 
 static const char * const push_usage[] = {
-	"git push [--all | --mirror] [--dry-run] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
+	"git push [--all | --mirror] [--dry-run] [--matching] [--tags] [--receive-pack=<git-receive-pack>] [--repo=<repository>] [-f | --force] [-v] [<repository> <refspec>...]",
 	NULL,
 };
 
@@ -71,9 +71,11 @@ static int do_push(const char *repo, int flags)
 		return error("--mirror can't be combined with refspecs");
 	}
 
-	if ((flags & (TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) ==
-				(TRANSPORT_PUSH_ALL|TRANSPORT_PUSH_MIRROR)) {
-		return error("--all and --mirror are incompatible");
+	if (HAS_MULTI_BITS(flags &
+			   (TRANSPORT_PUSH_ALL|
+			    TRANSPORT_PUSH_MIRROR|
+			    TRANSPORT_PUSH_MATCHING))) {
+		return error("--all, --mirror, --matching are incompatible");
 	}
 
 	if (!refspec
@@ -123,6 +125,7 @@ int cmd_push(int argc, const char **argv, const char *prefix)
 		OPT_BOOLEAN( 0 , "tags", &tags, "push tags"),
 		OPT_BIT( 0 , "dry-run", &flags, "dry run", TRANSPORT_PUSH_DRY_RUN),
 		OPT_BIT('f', "force", &flags, "force updates", TRANSPORT_PUSH_FORCE),
+		OPT_BIT( 0 , "matching", &flags, "push matching", TRANSPORT_PUSH_MATCHING),
 		OPT_BOOLEAN( 0 , "thin", &thin, "use thin pack"),
 		OPT_STRING( 0 , "receive-pack", &receivepack, "receive-pack", "receive pack program"),
 		OPT_STRING( 0 , "exec", &receivepack, "receive-pack", "receive pack program"),
diff --git c/builtin-send-pack.c w/builtin-send-pack.c
index d68ce2d..f5dda88 100644
--- c/builtin-send-pack.c
+++ w/builtin-send-pack.c
@@ -402,6 +402,8 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		flags |= MATCH_REFS_ALL;
 	if (args.send_mirror)
 		flags |= MATCH_REFS_MIRROR;
+	if (args.send_matching)
+		flags |= MATCH_REFS_MATCHING;
 
 	/* No funny business with the matcher */
 	remote_tail = get_remote_heads(in, &remote_refs, 0, NULL, REF_NORMAL,
diff --git c/remote.c w/remote.c
index e530a21..ce4f54c 100644
--- c/remote.c
+++ w/remote.c
@@ -1017,6 +1017,12 @@ static const struct refspec *check_pattern_match(const struct refspec *rs,
 		return NULL;
 }
 
+static void push_deprecation_warning(void)
+{
+	warning("'git push [$remote]' will stop pushing 'matching refs' in a future release");
+	warning("please train your fingers to say 'git push --matching' instead.");
+}
+
 /*
  * Note. This is used only by "push"; refspec matching rules for
  * push and fetch are subtly different, so do not try to reuse it
@@ -1031,6 +1037,8 @@ int match_refs(struct ref *src, struct ref *dst, struct ref ***dst_tail,
 	static const char *default_refspec[] = { ":", 0 };
 
 	if (!nr_refspec) {
+		if (!(flags & MATCH_REFS_MATCHING))
+			push_deprecation_warning();
 		nr_refspec = 1;
 		refspec = default_refspec;
 	}
diff --git c/remote.h w/remote.h
index d2e170c..2a702cb 100644
--- c/remote.h
+++ w/remote.h
@@ -124,6 +124,7 @@ enum match_refs_flags {
 	MATCH_REFS_NONE		= 0,
 	MATCH_REFS_ALL 		= (1 << 0),
 	MATCH_REFS_MIRROR	= (1 << 1),
+	MATCH_REFS_MATCHING	= (1 << 2),
 };
 
 /* Reporting of tracking info */
diff --git c/send-pack.h w/send-pack.h
index 8ff1dc3..133cb67 100644
--- c/send-pack.h
+++ w/send-pack.h
@@ -6,6 +6,7 @@ struct send_pack_args {
 	unsigned verbose:1,
 		send_all:1,
 		send_mirror:1,
+		send_matching:1,
 		force_update:1,
 		use_thin_pack:1,
 		dry_run:1;
diff --git c/transport.c w/transport.c
index 56831c5..4057d27 100644
--- c/transport.c
+++ w/transport.c
@@ -680,6 +680,7 @@ static int git_transport_push(struct transport *transport, int refspec_nr, const
 	args.receivepack = data->receivepack;
 	args.send_all = !!(flags & TRANSPORT_PUSH_ALL);
 	args.send_mirror = !!(flags & TRANSPORT_PUSH_MIRROR);
+	args.send_matching = !!(flags & TRANSPORT_PUSH_MATCHING);
 	args.force_update = !!(flags & TRANSPORT_PUSH_FORCE);
 	args.use_thin_pack = data->thin;
 	args.verbose = !!(flags & TRANSPORT_PUSH_VERBOSE);
diff --git c/transport.h w/transport.h
index 6bbc1a8..fb98128 100644
--- c/transport.h
+++ w/transport.h
@@ -34,6 +34,7 @@ struct transport {
 #define TRANSPORT_PUSH_DRY_RUN 4
 #define TRANSPORT_PUSH_MIRROR 8
 #define TRANSPORT_PUSH_VERBOSE 16
+#define TRANSPORT_PUSH_MATCHING 32
 
 /* Returns a transport suitable for the url */
 struct transport *transport_get(struct remote *, const char *);
