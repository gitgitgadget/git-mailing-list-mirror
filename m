From: Jeff King <peff@peff.net>
Subject: Re: Minor annoyance with git push
Date: Fri, 8 Feb 2008 21:54:31 -0500
Message-ID: <20080209025431.GF2572@coredump.intra.peff.net>
References: <46a038f90802072044u3329fd33w575c689cba2917ee@mail.gmail.com> <alpine.LSU.1.00.0802081142060.11591@racer.site> <46a038f90802081427k6ee94cfagbc02533538e75b49@mail.gmail.com> <20080209024636.GE2572@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Git Mailing List <git@vger.kernel.org>
To: Martin Langhoff <martin.langhoff@gmail.com>
X-From: git-owner@vger.kernel.org Sat Feb 09 03:55:13 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JNfrz-0002Ho-1Q
	for gcvg-git-2@gmane.org; Sat, 09 Feb 2008 03:55:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752319AbYBICyf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 Feb 2008 21:54:35 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752728AbYBICyf
	(ORCPT <rfc822;git-outgoing>); Fri, 8 Feb 2008 21:54:35 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:3803 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752292AbYBICye (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 Feb 2008 21:54:34 -0500
Received: (qmail 7126 invoked by uid 111); 9 Feb 2008 02:54:32 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Fri, 08 Feb 2008 21:54:32 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Fri, 08 Feb 2008 21:54:31 -0500
Content-Disposition: inline
In-Reply-To: <20080209024636.GE2572@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73186>

On Fri, Feb 08, 2008 at 09:46:36PM -0500, Jeff King wrote:

> > The local side has the remote refs if the client has fetched recently,
> > so it might be able to tell in some cases. Not with authority (things
> > may have changed on the server side...) but the client might be able
> > to say something less alarming.
> 
> This is actually not that hard to do in the case that we can. Patch will
> follow in a second, though I am not sure it is a good idea (because it
> silently ignores pushing rewinds).

And here it is. Again, I don't think this is the right default behavior.
I'm not even sure it is a good idea as configurable behavior. But it's
here for comment and for playing with, nonetheless.

-- >8 --
send-pack: treat strict rewinds specially

If you try to push an out-of-date version of a branch, it will generally
be rejected as a non-fastforward. This can clutter up the status output
of git-push if you have many such branches.

Instead, let's check explicitly whether what we are pushing is a strict
subset of what the remote already has. We treat this as a non-error, and
don't even print any status unless "verbose" is given. If the push is
"forced", then we will push as usual.

Note that we cannot always perform this check accurately; it relies on
us having the commit object that the remote claims to have. In the case
that we don't, we treat it like an ordinary non-fastforward and reject.

---
diff --git a/cache.h b/cache.h
index 920e731..78fee0b 100644
--- a/cache.h
+++ b/cache.h
@@ -596,6 +596,7 @@ struct ref {
 		REF_STATUS_UPTODATE,
 		REF_STATUS_REMOTE_REJECT,
 		REF_STATUS_EXPECTING_REPORT,
+		REF_STATUS_REJECT_REWIND,
 	} status;
 	char *remote_status;
 	struct ref *peer_ref; /* when renaming */
diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 454ad8f..9f82b83 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -315,6 +315,7 @@ static int print_one_push_status(struct ref *ref, const char *dest, int count)
 				ref->peer_ref, NULL);
 		break;
 	case REF_STATUS_REJECT_NONFASTFORWARD:
+	case REF_STATUS_REJECT_REWIND:
 		print_ref_status('!', "[rejected]", ref, ref->peer_ref,
 				"non-fast forward");
 		break;
@@ -343,7 +344,8 @@ static void print_push_status(const char *dest, struct ref *refs)
 
 	if (args.verbose) {
 		for (ref = refs; ref; ref = ref->next)
-			if (ref->status == REF_STATUS_UPTODATE)
+			if (ref->status == REF_STATUS_UPTODATE ||
+			    ref->status == REF_STATUS_REJECT_REWIND)
 				n += print_one_push_status(ref, dest, n);
 	}
 
@@ -354,7 +356,8 @@ static void print_push_status(const char *dest, struct ref *refs)
 	for (ref = refs; ref; ref = ref->next) {
 		if (ref->status != REF_STATUS_NONE &&
 		    ref->status != REF_STATUS_UPTODATE &&
-		    ref->status != REF_STATUS_OK)
+		    ref->status != REF_STATUS_OK &&
+		    ref->status != REF_STATUS_REJECT_REWIND)
 			n += print_one_push_status(ref, dest, n);
 	}
 }
@@ -365,6 +368,7 @@ static int refs_pushed(struct ref *ref)
 		switch(ref->status) {
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
+		case REF_STATUS_REJECT_REWIND:
 			break;
 		default:
 			return 1;
@@ -463,8 +467,12 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		    (!has_sha1_file(ref->old_sha1)
 		      || !ref_newer(new_sha1, ref->old_sha1));
 
+
 		if (ref->nonfastforward && !ref->force && !args.force_update) {
-			ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
+			if (ref_newer(ref->old_sha1, new_sha1))
+				ref->status = REF_STATUS_REJECT_REWIND;
+			else
+				ref->status = REF_STATUS_REJECT_NONFASTFORWARD;
 			continue;
 		}
 
@@ -522,6 +530,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		case REF_STATUS_NONE:
 		case REF_STATUS_UPTODATE:
 		case REF_STATUS_OK:
+		case REF_STATUS_REJECT_REWIND:
 			break;
 		default:
 			return -1;
