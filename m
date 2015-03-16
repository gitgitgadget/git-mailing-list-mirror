From: Jeff King <peff@peff.net>
Subject: Re: Slow git pushes: sitting 1 minute in pack-objects
Date: Mon, 16 Mar 2015 18:15:33 -0400
Message-ID: <20150316221532.GA16679@peff.net>
References: <CAH8BJxH1uVv9J7yLx1D4GRPKfWYqDw8SRFZKGR_yhjcoTCCT2g@mail.gmail.com>
 <20150309075302.GB31866@peff.net>
 <CAH8BJxHQnMkXq1J_wMi2KktTH5uHjj+vd69ihXuYGRfq9cOt=g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Stephen Morton <stephen.c.morton@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 16 23:15:43 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXdIT-0002ay-Au
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 23:15:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932414AbbCPWPg (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 18:15:36 -0400
Received: from cloud.peff.net ([50.56.180.127]:33792 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754207AbbCPWPf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 18:15:35 -0400
Received: (qmail 466 invoked by uid 102); 16 Mar 2015 22:15:35 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Mar 2015 17:15:35 -0500
Received: (qmail 20287 invoked by uid 107); 16 Mar 2015 22:15:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 16 Mar 2015 18:15:45 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 16 Mar 2015 18:15:33 -0400
Content-Disposition: inline
In-Reply-To: <CAH8BJxHQnMkXq1J_wMi2KktTH5uHjj+vd69ihXuYGRfq9cOt=g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265598>

On Mon, Mar 09, 2015 at 09:37:25PM -0400, Stephen Morton wrote:

> 3. Not sure how long this part takes. It takes 1/3 - 1/2 of the time
> when straced, but I think it's much less, as little as 10s when not
> straced.
> It then reads a bunch of what look like objects from filehandle 0
> (presumably stdin, read from the remote end?)
> It then tries to lstat() these filenames in .git/<sha1>
> ./git/refs/<sha1>, .git/heads/<sha>, etc. It always fails ENOENT.
> It fails some 120,000 times. This could be a problem. Though I haven't
> checked to see if this happens on a fast push on another machine.

Hmm. The "push" process must feed the set of object boundaries to
"pack-objects" so it knows what to pack (i.e., what we want to send, and
what the other side has).

120,000 is an awfully large number of objects to be pass there, though.
Does the repo you are pushing to by any chance have an extremely large
number of refs (e.g., on the order of 120K tags)?

Can you try building git with this patch which would tell us more about
where those objects are coming from?

diff --git a/send-pack.c b/send-pack.c
index 9d2b0c5..17ace1f 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -74,10 +74,19 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	 * We feed the pack-objects we just spawned with revision
 	 * parameters by writing to the pipe.
 	 */
+	warning("feeding %d .have objects", extra->nr);
 	for (i = 0; i < extra->nr; i++)
 		if (!feed_object(extra->sha1[i], po.in, 1))
 			break;
 
+	{
+		struct ref *p;
+		int count = 0;
+		for (p = refs; p; p = p->next)
+			count++;
+		warning("feeding %d refs", count);
+	}
+
 	while (refs) {
 		if (!is_null_sha1(refs->old_sha1) &&
 		    !feed_object(refs->old_sha1, po.in, 1))

> 4. Then it just sits there for almost 1 minute. It uses up almost 100%
> of a single core during this period. It spends a lot of time running
> lots of brk() (memory allocation) commands and then getting (polled
> by?) a SIGALRM every 1s.
> About 5.5+ GB (about the repo size) of VIRT memory is allocated. Only
> about 400M is ever RES.

The SIGALRM is normal. That's the progress code checking in every 2
seconds to see if there's anything to print. My guess is that the
allocation is probably coming as part of the "preferred base" code. This
is a fancy term for "stuff we are not going to send, but which we could
use as delta bases for objects we are sending".

Does the patch below speed things up (it is not a good thing to do in
general, but would let us know if that is the problematic area):

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d816587..c90a352 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2307,7 +2307,6 @@ static void show_object(struct object *obj,
 
 static void show_edge(struct commit *commit)
 {
-	add_preferred_base(commit->object.sha1);
 }
 
 struct in_pack_object {

If not, then the slowdown may come before we even get there, and
possibly this patch would help:

diff --git a/builtin/pack-objects.c b/builtin/pack-objects.c
index d816587..473c0a3 100644
--- a/builtin/pack-objects.c
+++ b/builtin/pack-objects.c
@@ -2531,6 +2531,8 @@ static void get_object_list(int ac, const char **av)
 			}
 			die("not a rev '%s'", line);
 		}
+		if (*line == '^')
+			continue;
 		if (handle_revision_arg(line, &revs, flags, REVARG_CANNOT_BE_FILENAME))
 			die("bad revision '%s'", line);
 	}

Those are all rather blunt debugging methods, but hopefully it can get
us a sense of where the time is going.

-Peff
