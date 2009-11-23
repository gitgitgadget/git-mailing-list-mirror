From: Jeff King <peff@peff.net>
Subject: Re: how to suppress progress percentage in git-push
Date: Mon, 23 Nov 2009 10:00:00 -0500
Message-ID: <20091123145959.GA13138@sigill.intra.peff.net>
References: <20091122145352.GA3941@debian.b2j>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Nicolas Pitre <nico@fluxnic.net>, git <git@vger.kernel.org>
To: bill lam <cbill.lam@gmail.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 16:00:21 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCaOl-0001Rz-Fj
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 16:00:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754782AbZKWO76 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 09:59:58 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753752AbZKWO75
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 09:59:57 -0500
Received: from peff.net ([208.65.91.99]:54388 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753381AbZKWO75 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 09:59:57 -0500
Received: (qmail 2953 invoked by uid 107); 23 Nov 2009 15:04:25 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 23 Nov 2009 10:04:25 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 23 Nov 2009 10:00:00 -0500
Content-Disposition: inline
In-Reply-To: <20091122145352.GA3941@debian.b2j>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133504>

On Sun, Nov 22, 2009 at 10:53:53PM +0800, bill lam wrote:

> I set crontab to push to another computer for backup. It sent
> confirmation email after finished.  It looked like
> 
> Counting objects: 1
> Counting objects: 9, done.
> Delta compression using up to 2 threads.
> Compressing objects:  20% (1/5)
> Compressing objects:  40% (2/5)
> Compressing objects:  60% (3/5)
> Compressing objects:  80% (4/5)
> Compressing objects: 100% (5/5)
> Compressing objects: 100% (5/5), done.
> Writing objects:  20% (1/5)
> Writing objects:  40% (2/5)
> Writing objects:  60% (3/5)
> Writing objects:  80% (4/5)
> Writing objects: 100% (5/5)
> Writing objects: 100% (5/5), 549 bytes, done.
> Total 5 (delta 3), reused 0 (delta 0)
> 
> Often the list of progress % can be a page long.  I want output but
> not those percentage progress status.  Will that be possible?

Hmm. There seems to be a bug. pack-objects is supposed to see that
stderr is not a tty and suppress the progress messages. But it doesn't,
because send-pack gives it the --all-progress flag, which
unconditionally tells it to display progress, when the desired impact is
actually to just make the progress more verbose.

We need to do one of:

  1. make --all-progress imply "if we are using progress, then make it
     more verbose. Otherwise, ignore."

  2. fix all callers to check isatty(2) before unconditionally passing
     the option

The patch for (1) would look something like what's below.  It's simpler,
but it does change the semantics; anyone who was relying on
--all-progress to turn on progress unconditionally would need to now
also use --progress. However, turning on progress unconditionally is
usually an error (the except is if you are piping output in real-time to
the user and need to overcome the isatty check).

Nicolas, this is your code. Which do you prefer?

-Peff

---
diff --git a/builtin-pack-objects.c b/builtin-pack-objects.c
index 4c91e94..50dd429 100644
--- a/builtin-pack-objects.c
+++ b/builtin-pack-objects.c
@@ -75,6 +75,7 @@ static int ignore_packed_keep;
 static int allow_ofs_delta;
 static const char *base_name;
 static int progress = 1;
+static int all_progress;
 static int window = 10;
 static uint32_t pack_size_limit, pack_size_limit_cfg;
 static int depth = 50;
@@ -2220,7 +2221,7 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 			continue;
 		}
 		if (!strcmp("--all-progress", arg)) {
-			progress = 2;
+			all_progress = 1;
 			continue;
 		}
 		if (!strcmp("-q", arg)) {
@@ -2295,6 +2296,9 @@ int cmd_pack_objects(int argc, const char **argv, const char *prefix)
 		usage(pack_usage);
 	}
 
+	if (progress && all_progress)
+		progress = 2;
+
 	/* Traditionally "pack-objects [options] base extra" failed;
 	 * we would however want to take refs parameter that would
 	 * have been given to upstream rev-list ourselves, which means
