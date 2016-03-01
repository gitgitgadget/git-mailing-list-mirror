From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2] fetch-pack: fix object_id of exact sha1
Date: Mon, 29 Feb 2016 23:40:33 -0500
Message-ID: <20160301044033.GA19272@sigill.intra.peff.net>
References: <xmqqh9gseiqk.fsf@gitster.mtv.corp.google.com>
 <1456698144-11519-1-git-send-email-gabrielfrancosouza@gmail.com>
 <20160229100030.GB2950@sigill.intra.peff.net>
 <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>
To: Gabriel Souza Franco <gabrielfrancosouza@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 01 05:40:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aac6z-00047V-JW
	for gcvg-git-2@plane.gmane.org; Tue, 01 Mar 2016 05:40:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448AbcCAEkh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 29 Feb 2016 23:40:37 -0500
Received: from cloud.peff.net ([50.56.180.127]:52204 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750798AbcCAEkg (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 29 Feb 2016 23:40:36 -0500
Received: (qmail 736 invoked by uid 102); 1 Mar 2016 04:40:36 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 23:40:36 -0500
Received: (qmail 4380 invoked by uid 107); 1 Mar 2016 04:40:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 29 Feb 2016 23:40:46 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 29 Feb 2016 23:40:33 -0500
Content-Disposition: inline
In-Reply-To: <CABaesJK+zuuYAJ6YaEugLMFywMqE8V0W1=_4mJPGDAnfT9yXJg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/287996>

On Mon, Feb 29, 2016 at 11:08:07PM -0300, Gabriel Souza Franco wrote:

> On Mon, Feb 29, 2016 at 5:30 AM, Johannes Schindelin
> <Johannes.Schindelin@gmx.de> wrote:
> > Having said that, this *might* be a good opportunity to imitate the
> > skip_prefix() function. If there are enough similar code constructs, we
> > could simplify all of them by introducing the function
> >
> >         skip_oid_hex(const char *str, struct object_id *oid, const char **out)
> >
> > that returns 1 if and only if an oid was parsed, and stores the pointer
> > after the oid in "out" (skipping an additional space if there is one)?
> 
> I don't think there's any other place that accepts all of "<sha1>",
> "<sha1> <ref>" and "<ref>"
> based on a quick grep for get_oid_hex.

Yes, but there are places where we get_oid_hex and then skip past that,
which could use the skip_oid_hex function, like:

diff --git a/connect.c b/connect.c
index 0478631..ba22ee6 100644
--- a/connect.c
+++ b/connect.c
@@ -149,10 +149,9 @@ struct ref **get_remote_heads(int in, char *src_buf, size_t src_len,
 			continue;
 		}
 
-		if (len < GIT_SHA1_HEXSZ + 2 || get_oid_hex(buffer, &old_oid) ||
-			buffer[GIT_SHA1_HEXSZ] != ' ')
+		if (!skip_oid_hex(buffer, &old_oid, &name) ||
+		    !skip_prefix(name, " ", &name))
 			die("protocol error: expected sha/ref, got '%s'", buffer);
-		name = buffer + GIT_SHA1_HEXSZ + 1;
 
 		name_len = strlen(name);
 		if (len != name_len + GIT_SHA1_HEXSZ + 1) {

_But_, if you look at the context just below, we make another implicit
assumption about GIT_SHA1_HEXSZ. So it's really not buying us that much
(unless we switch around the whole function to keep reading to the final
pointer, and compare "end - start" to the original "len" here).

So I'm not sure it's worth the trouble. I am really happy with the
skip_prefix() function for parsing like this, but I think it's just not
nearly as big a deal with oid-parsing, because we already have a nice
constant of GIT_SHA1_HEXSZ to match it (whereas skipping "foo" requires
us writing the magical "3" somewhere).

Anyway. Whether we want to pursue that or not, I don't think it needs to
be part of your series. Let's focus on the original goal.

-Peff
