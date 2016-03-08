From: Jeff King <peff@peff.net>
Subject: Re: [BUG?] fetch into shallow sends a large number of objects
Date: Tue, 8 Mar 2016 08:25:24 -0500
Message-ID: <20160308132524.GA22866@sigill.intra.peff.net>
References: <20160307221539.GA24034@sigill.intra.peff.net>
 <xmqqio0xn93q.fsf@gitster.mtv.corp.google.com>
 <20160308121444.GA18535@sigill.intra.peff.net>
 <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 14:25:34 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adHdk-00084e-7c
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 14:25:32 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751251AbcCHNZ3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 08:25:29 -0500
Received: from cloud.peff.net ([50.56.180.127]:56227 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750843AbcCHNZ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 08:25:27 -0500
Received: (qmail 8461 invoked by uid 102); 8 Mar 2016 13:25:26 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 08:25:26 -0500
Received: (qmail 2033 invoked by uid 107); 8 Mar 2016 13:25:40 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 08 Mar 2016 08:25:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 08 Mar 2016 08:25:24 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8Dk_g1O98UsDaeVS3VXmE2Mn5aR+w1OiFir+QwyJYLVZQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288432>

On Tue, Mar 08, 2016 at 07:33:43PM +0700, Duy Nguyen wrote:

> On Tue, Mar 8, 2016 at 7:14 PM, Jeff King <peff@peff.net> wrote:
> > ...
> >
> > So I think the solution to both is that we need to do a _separate_
> > traversal with all of the positive tips we're going to send, and the
> > parents of any shallow commits the client has, to find their fork points
> > (i.e., merge bases). And then we add those fork points to the shallow
> > list (grafting out their parents), and communicate them to the client to
> > add to its shallow setup.
> 
> Good news. We have the mechanism in place, I think.
> get_shallow_commits_by_rev_list() (from 'pu') will produce the right
> shallow points for sending back to the client if you pass "--not
> <current shallow points>" to it. It's meant to be used for
> --shallow-exclude and --shallow-since, but if neither is given (nor
> --depth) I guess we can run it with current shallow points. I wonder
> if we can detect some common cases and avoid commit traversing this
> way though.

I tried that, but I couldn't quite get it to work. I don't think we need
any special rev-list, though; we can just find the boundary points of
that traversal and mark them as new shallows.

I think this patch does roughly the right thing:

diff --git a/upload-pack.c b/upload-pack.c
index 4859535..da76f70 100644
--- a/upload-pack.c
+++ b/upload-pack.c
@@ -833,12 +833,41 @@ static void receive_needs(void)
 		deepen_by_rev_list(av.argc, av.argv, &shallows);
 		argv_array_clear(&av);
 	}
-	else
-		if (shallows.nr > 0) {
-			int i;
-			for (i = 0; i < shallows.nr; i++)
-				register_shallow(shallows.objects[i].item->oid.hash);
+	else if (shallows.nr > 0) {
+		struct rev_info revs;
+		struct argv_array av = ARGV_ARRAY_INIT;
+		struct commit *c;
+		int i;
+
+		argv_array_push(&av, "rev-list");
+		argv_array_push(&av, "--boundary");
+		for (i = 0; i < want_obj.nr; i++) {
+			struct object *o = want_obj.objects[i].item;
+			argv_array_push(&av, oid_to_hex(&o->oid));
 		}
+		for (i = 0; i < shallows.nr; i++) {
+			struct object *o = shallows.objects[i].item;
+			argv_array_pushf(&av, "^%s", oid_to_hex(&o->oid));
+		}
+
+		init_revisions(&revs, NULL);
+		setup_revisions(av.argc, av.argv, &revs, NULL);
+		if (prepare_revision_walk(&revs))
+			die("revision walk setup failed");
+
+		while ((c = get_revision(&revs))) {
+			if (!(c->object.flags & BOUNDARY))
+				continue;
+			register_shallow(c->object.oid.hash);
+			packet_write(1, "shallow %s",
+				     oid_to_hex(&c->object.oid));
+		}
+		packet_flush(1);
+		argv_array_clear(&av);
+
+		for (i = 0; i < shallows.nr; i++)
+			register_shallow(shallows.objects[i].item->oid.hash);
+	}
 
 	shallow_nr += shallows.nr;
 	free(shallows.objects);

Though I think perhaps we should also be adding those BOUNDARY commits
to the "shallows" object array? This works because the "--shallow" we
pass to pack-objects comes by reading the commit-graft list manipulated
by register_shallow(), so I'm not sure if it matters.

_But_, the client is not prepared to handle this. We send "shallow"
lines that it is not expecting, since it did not ask for any depth. So I
think this logic would have to kick in only when the client tells us to
do so.

I hacked around it with:

diff --git a/fetch-pack.c b/fetch-pack.c
index e8ae6d1..988c808 100644
--- a/fetch-pack.c
+++ b/fetch-pack.c
@@ -830,6 +830,7 @@ static struct ref *do_fetch_pack(struct fetch_pack_args *args,
 
 	sort_ref_list(&ref, ref_compare_name);
 	qsort(sought, nr_sought, sizeof(*sought), cmp_ref_by_name);
+	args->deepen = 1;
 
 	if ((args->depth > 0 || is_repository_shallow()) && !server_supports("shallow"))
 		die("Server does not support shallow clients");

and confirmed that the resulting "git fetch origin new" from my earlier
example does a sane thing.

So what next? I think there's some protocol work here, and I think the
overall design of that needs to be considered alongside the other
"deepen" options your topic in pu adds (and of which I'm largely
ignorant). Does this sufficiently interest you to pick up and roll into
your other shallow work?

-Peff
