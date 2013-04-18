From: Jeff King <peff@peff.net>
Subject: Re: What's cooking in git.git (Apr 2013, #05; Mon, 15)
Date: Thu, 18 Apr 2013 13:27:14 -0400
Message-ID: <20130418172714.GA24690@sigill.intra.peff.net>
References: <7vhaj7r116.fsf@alter.siamese.dyndns.org>
 <87txn5xzdn.fsf@linux-k42r.v.cablecom.net>
 <7vd2ttgoyr.fsf@alter.siamese.dyndns.org>
 <87wqs1xi9h.fsf@hexa.v.cablecom.net>
 <7vk3o1f5kb.fsf@alter.siamese.dyndns.org>
 <7vwqs1dnxp.fsf@alter.siamese.dyndns.org>
 <20130417201056.GA2914@sigill.intra.peff.net>
 <7va9owd3d1.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Thomas Rast <trast@inf.ethz.ch>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Apr 18 19:27:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1USscM-0007tH-Ar
	for gcvg-git-2@plane.gmane.org; Thu, 18 Apr 2013 19:27:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S966961Ab3DRR1U (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 18 Apr 2013 13:27:20 -0400
Received: from cloud.peff.net ([50.56.180.127]:43400 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S935970Ab3DRR1S (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 18 Apr 2013 13:27:18 -0400
Received: (qmail 6552 invoked by uid 102); 18 Apr 2013 17:27:22 -0000
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (75.15.5.89)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 18 Apr 2013 12:27:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 18 Apr 2013 13:27:14 -0400
Content-Disposition: inline
In-Reply-To: <7va9owd3d1.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/221671>

On Wed, Apr 17, 2013 at 06:39:06PM -0700, Junio C Hamano wrote:

> Subject: [PATCH] git add: rework the logic to warn "git add <pathspec>..." default change
>
> [...]
>
> Rework the logic to detect the case where the behaviour will be
> different in Git 2.0, and issue a warning only when it matters.
> Even with the code before this warning, "git add subdir" will have
> to traverse the directory in order to find _new_ files the index
> does not know about _anyway_, so we can do this check without adding
> an extra pass to find if <pathspec> matches any removed file.

Thanks, I think this is looking much better.

A few minor nits on the message itself:

> +static void warn_add_would_remove(const char *path)
> +{
> +	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
> +		  "index for paths removed from the working tree that match\n"
> +		  "the given pathspec. If you want to 'add' only changed\n"
> +		  "or newly created paths, say 'git add --no-all <pathspec>...'"
> +		  " instead.\n\n"

This wrapping looks funny in the actual output, due to the extra
"warning:" and the lack of newline before "instead":

  warning: In Git 2.0, 'git add <pathspec>...' will also update the
  index for paths removed from the working tree that match
  the given pathspec. If you want to 'add' only changed
  or newly created paths, say 'git add --no-all <pathspec>...' instead.

Wrapping it like this ends up with a much more natural-looking
paragraph:

  warning: In Git 2.0, 'git add <pathspec>...' will also update the
  index for paths removed from the working tree that match the given
  pathspec. If you want to 'add' only changed or newly created paths,
  say 'git add --no-all <pathspec>...' instead.

> +		  "'%s' would be removed from the index without --no-all."),
> +		path);

I think mentioning the filename is a good thing; the original message
left me scratching my head and wondering "so, did you add it or not?".
I still think your "would be" is unnecessarily confusing, though. It is
"would be in Git 2.0 without --no-all, but we did not now". Which makes
sense when you think about it, but it took me a moment to parse.

Perhaps we can be more direct with something like:

  warning: did not stage removal of 'foo'

or perhaps the present tense "not staging removal of..." would be
better.

I also think it makes sense to show every path that is affected, not
just the first one, to be clear about what was done (and what _would_
have been done in Git 2.0).

A patch with all of the suggestions together is below. I still think the
multi-line warning block looks ugly. I kind of like the way advise()
puts "hint:" on each line. I wonder if we should do the same here.

diff --git a/builtin/add.c b/builtin/add.c
index 4242bce..aae550a 100644
--- a/builtin/add.c
+++ b/builtin/add.c
@@ -52,15 +52,19 @@ static void warn_add_would_remove(const char *path)
 		return DIFF_STATUS_MODIFIED;
 }
 
+static const char *add_would_remove_warning = N_(
+/* indent for "warning: " */
+         "In Git 2.0, 'git add <pathspec>...' will also update the\n"
+"index for paths removed from the working tree that match the given\n"
+"pathspec. If you want to 'add' only changed or newly created paths,\n"
+"say 'git add --no-all <pathspec>...' instead.\n");
+
 static void warn_add_would_remove(const char *path)
 {
-	warning(_("In Git 2.0, 'git add <pathspec>...' will also update the\n"
-		  "index for paths removed from the working tree that match\n"
-		  "the given pathspec. If you want to 'add' only changed\n"
-		  "or newly created paths, say 'git add --no-all <pathspec>...'"
-		  " instead.\n\n"
-		  "'%s' would be removed from the index without --no-all."),
-		path);
+	static int warned_once;
+	if (!warned_once++)
+		warning(_(add_would_remove_warning));
+	warning("did not stage removal of '%s'", path);
 }
 
 static void update_callback(struct diff_queue_struct *q,
@@ -84,10 +88,8 @@ static void update_callback(struct diff_queue_struct *q,
 			}
 			break;
 		case DIFF_STATUS_DELETED:
-			if (data->warn_add_would_remove) {
+			if (data->warn_add_would_remove)
 				warn_add_would_remove(path);
-				data->warn_add_would_remove = 0;
-			}
 			if (data->flags & ADD_CACHE_IGNORE_REMOVAL)
 				break;
 			if (!(data->flags & ADD_CACHE_PRETEND))
