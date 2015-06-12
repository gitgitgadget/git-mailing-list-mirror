From: Jeff King <peff@peff.net>
Subject: Re: git push keeps writing after server failure
Date: Fri, 12 Jun 2015 14:12:56 -0400
Message-ID: <20150612181256.GB9242@peff.net>
References: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git <git@vger.kernel.org>
To: Shawn Pearce <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Jun 12 20:13:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z3TRw-0003NC-7z
	for gcvg-git-2@plane.gmane.org; Fri, 12 Jun 2015 20:13:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754497AbbFLSM7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 12 Jun 2015 14:12:59 -0400
Received: from cloud.peff.net ([50.56.180.127]:45359 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750898AbbFLSM6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Jun 2015 14:12:58 -0400
Received: (qmail 2073 invoked by uid 102); 12 Jun 2015 18:12:58 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 13:12:58 -0500
Received: (qmail 16667 invoked by uid 107); 12 Jun 2015 18:13:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Fri, 12 Jun 2015 14:13:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 12 Jun 2015 14:12:56 -0400
Content-Disposition: inline
In-Reply-To: <CAJo=hJvzjnLFhF4REBzX=pgFamBfu7hZeZidy_8Rmi_DwwR4Nw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271508>

On Fri, Jun 12, 2015 at 10:31:33AM -0700, Shawn Pearce wrote:

> I did something stupid like trying to push a copy of WebKit[1] into my
> GitHub account. This is ~5.2 GiB of data, which GitHub prefers not to
> accept. Ok ...

Heh, yeah. We cap it at 2G, and if you are going to have a WebKit fork,
we prefer you fork the actual WebKit repo so it shares objects (though
if you have a need to create a new fork network, let me know).

> $ git push --all git@github.com:spearce/wk.git
> Counting objects: 2752427, done.
> Delta compression using up to 12 threads.
> Compressing objects: 100% (442684/442684), done.
> remote: fatal: pack exceeds maximum allowed size
> Writing objects: 100% (2752427/2752427), 5.28 GiB | 8.86 MiB/s, done.
> Total 2752427 (delta 2225007), reused 2752427 (delta 2225007)
> fatal: The remote end hung up unexpectedly
> fatal: The remote end hung up unexpectedly
> 
> Notice GitHub prints "remote: fatal: pack exceeds maximum allowed
> size". That interrupted my "Writing objects" progress meter, and then
> git push just kept going and wrote really really fast (170 MiB/s!)
> until the entire pack was sent.

Sounds like it's writing to a closed fd, then. Which makes sense; I
think we should hang up the socket after writing the "fatal" message
above.

> Shouldn't git push realize its stream is broken and stop writing when
> the peer is all like "uh, no, I'm not going to do that, but thanks for
> trying"?

Hrm. I have this old patch, which was originally written so that "kill
$(pidof git-push)" did not let a rogue pack-objects continue writing.

I'm not sure if that's what is going on here, though. I think we connect
pack-objects directly to the socket. So it sounds more like
"pack-objects --stdout" needs to know to stop writing when writes to the
socket fail.

-- >8 --
Date: Sun, 3 Apr 2011 20:53:08 -0400
Subject: [PATCH] send-pack: kill pack-objects helper on signal or exit

We spawn an external pack-objects process to actually send
objects to the remote side. If we are killed by a signal
during this process, the pack-objects will keep running and
complete the push, which may surprise the user. We should
take it down when we go down.

Signed-off-by: Jeff King <peff@peff.net>
---
 send-pack.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/send-pack.c b/send-pack.c
index 2a64fec..bdf723b 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -67,6 +67,7 @@ static int pack_objects(int fd, struct ref *refs, struct sha1_array *extra, stru
 	po.in = -1;
 	po.out = args->stateless_rpc ? -1 : fd;
 	po.git_cmd = 1;
+	po.clean_on_exit = 1;
 	if (start_command(&po))
 		die_errno("git pack-objects failed");
 
-- 
2.4.2.752.geeb594a
