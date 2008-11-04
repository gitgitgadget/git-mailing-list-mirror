From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] push: fix local refs update if already up-to-date
Date: Mon, 3 Nov 2008 23:26:44 -0500
Message-ID: <20081104042643.GA31276@coredump.intra.peff.net>
References: <20081104000745.GA28480@localhost>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Clemens Buchacher <drizzd@aon.at>
X-From: git-owner@vger.kernel.org Tue Nov 04 05:28:02 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KxDWK-0002Yl-V8
	for gcvg-git-2@gmane.org; Tue, 04 Nov 2008 05:28:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753158AbYKDE0r (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 3 Nov 2008 23:26:47 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752924AbYKDE0r
	(ORCPT <rfc822;git-outgoing>); Mon, 3 Nov 2008 23:26:47 -0500
Received: from peff.net ([208.65.91.99]:3442 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752755AbYKDE0q (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 3 Nov 2008 23:26:46 -0500
Received: (qmail 5053 invoked by uid 111); 4 Nov 2008 04:26:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Mon, 03 Nov 2008 23:26:45 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Mon, 03 Nov 2008 23:26:44 -0500
Content-Disposition: inline
In-Reply-To: <20081104000745.GA28480@localhost>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/100032>

On Tue, Nov 04, 2008 at 01:07:45AM +0100, Clemens Buchacher wrote:

> git push normally updates local refs only after a successful push. If
> the remote already has the updates -- pushed indirectly through
> another repository, for example -- we forget to update local tracking
> refs.

I think this goal is a good enhancement.

> The hashcpy for new_ref is now executed more often than absolutely
> necessary. But this is not a critical path, right? So I decided to keep
> things simple.

No, I don't think the loop is tight enough to care about an extra
hashcpy. The minimally invasive change would be to just set
ref->new_sha1 in the UPTODATE code path. IOW, just:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 298bd71..b8788f2 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -454,6 +454,7 @@ static int do_send_pack(int in, int out, struct remote *remote, const char *dest
 		if (!ref->deletion &&
 		    !hashcmp(ref->old_sha1, new_sha1)) {
 			ref->status = REF_STATUS_UPTODATE;
+			hashcpy(ref->new_sha1, new_sha1);
 			continue;
 		}
 

Your patch makes ref->new_sha1 "valid" for every status case. Ordinarily
I would be in favor of that, since it reduces coupling with other parts
of the code (which have to know _which_ status flags provide a useful
value in ->new_sha1). But in this case, I think the value we would be
sticking in is not necessarily useful for every status flag we end up
setting; so any consumers of the ref structure still need to know which
flags set it. So even though it has a defined value, it is not really
"valid" in all cases.

> @@ -224,7 +224,7 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
>  {
>  	struct refspec rs;
>  
> -	if (ref->status != REF_STATUS_OK)
> +	if (ref->status != REF_STATUS_OK && ref->status != REF_STATUS_UPTODATE)
>  		return;
>  
>  	rs.src = ref->name;

Hmm. I was hoping to see more in update_tracking_ref. With your patch,
we end up calling update_ref for _every_ uptodate ref, which results in
writing a new unpacked ref file for each one. And that _is_ a
performance problem for people with large numbers of refs.

So I think we need a check to make sure we aren't just updating with the
same value. Something like:

diff --git a/builtin-send-pack.c b/builtin-send-pack.c
index 4c17f48..0e66e8f 100644
--- a/builtin-send-pack.c
+++ b/builtin-send-pack.c
@@ -237,8 +237,17 @@ static void update_tracking_ref(struct remote *remote, struct ref *ref)
 	rs.dst = NULL;
 
 	if (!remote_find_tracking(remote, &rs)) {
+		unsigned char old_tracking_sha1[20];
+
 		if (args.verbose)
 			fprintf(stderr, "updating local tracking ref '%s'\n", rs.dst);
+
+		if (!resolve_ref(rs.dst, old_tracking_sha1, 0, NULL) ||
+		    !hashcmp(old_tracking_sha1, ref->new_sha1)) {
+			free(rs.dst);
+			return;
+		}
+
 		if (ref->deletion) {
 			delete_ref(rs.dst, NULL, 0);
 		} else

Though I am not happy that we have to look up the tracking ref for every
uptodate ref. I think it shouldn't be a big performance problem with
packed refs, though, since they are cached (i.e., we pay only to compare
the hashes, not touch the filesystem for each ref).

> +test_expect_success 'push updates local refs (2)' '

Nit: Just reading the test, it is hard to see what is interesting about
it (though obviously I can blame it back to your commit :) ). Maybe a
more descriptive title like 'push updates uptodate local refs' would
make sense.

-Peff
