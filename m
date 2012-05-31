From: Jeff King <peff@peff.net>
Subject: Re: git version statistics
Date: Thu, 31 May 2012 08:00:19 -0400
Message-ID: <20120531120018.GA24986@sigill.intra.peff.net>
References: <20120531114801.GA21367@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu May 31 14:00:28 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sa43H-00079c-Ck
	for gcvg-git-2@plane.gmane.org; Thu, 31 May 2012 14:00:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756789Ab2EaMAX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 May 2012 08:00:23 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:37781
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754620Ab2EaMAW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 May 2012 08:00:22 -0400
Received: (qmail 20444 invoked by uid 107); 31 May 2012 12:00:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 31 May 2012 08:00:22 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 31 May 2012 08:00:19 -0400
Content-Disposition: inline
In-Reply-To: <20120531114801.GA21367@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198885>

On Thu, May 31, 2012 at 07:48:01AM -0400, Jeff King wrote:

> Just for fun, I've assembled a few statistics on git client versions
> that hit github.com. These are collected from the http user-agent
> strings provided by smart-http requests (we don't allow dumb http at all
> these days, and the git protocol does not provide any version
> information).

We have capabilities, and I looked into trying to fingerprint client
versions based on the capabilities. Unfortunately, it's extremely
coarse-grained, because we just don't add capabilities very often.

I came up with this list of fetch-pack capabilities, and when they were
introduced:

  - multi_ack v0.99.9
  - thin-pack v1.3.0
  - side-band v1.4.1
  - side-band-64k v1.4.3
  - ofs-delta v1.4.4
  - shallow v1.5.0
  - no-progress v1.5.1
  - include-tag v1.5.5
  - multi_ack_detailed v1.6.6
  - no-done v1.7.5

But note that "shallow" is not requested explicitly by the client; you
can detect it by the client sending "shallow" commands, but then only if
it is a shallow repository. Similarly, "no-progress" is only requested
if the client is run with "--no-progress" or without a tty.

The "no-done" capability is only requested in stateless-rpc mode (i.e.,
over smart-http). So we can use it only for smart-http, in which case we
have more accurate numbers already (because git puts the version in the
http user-agent string).

So realistically you are looking at identifying whether a client version
is >= v1.6.6 (if it has multi_ack_detailed) or >= v1.5.5 (if it has
include-tag). Beyond that it gets uselessly old, and that's really not
very fine-grained at all.

I'm really tempted to do something like the patch below, which adds an
agent field to the capability string. It wouldn't help with identifying
older versions, but eventually all versions of git would send it (and
those that didn't could be stuck in the "wow, that's old" bin).

-Peff

-- >8 --
Subject: include agent identifier in capability string

Instead of having the client advertise a particular version
number in the git protocol, we have managed extensions and
backwards compatibility by having clients and servers
advertise capabilities that they support. This is far more
robust than having each side consult a table of
known versions, and provides sufficient information for the
protocol interaction to complete.

However, it does not allow servers to keep statistics on
which client versions are being used. This information is
not necessary to complete the network request (the
capabilities provide enough information for that), but it
may be helpful to conduct a general survey of client
versions in use.

We already send the client version in the user-agent header
for http requests; adding it here would allow us to gather
similar statistics for non-http requests.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/fetch-pack.c | 1 +
 builtin/send-pack.c  | 6 ++++--
 2 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/builtin/fetch-pack.c b/builtin/fetch-pack.c
index 149db88..f3b8422 100644
--- a/builtin/fetch-pack.c
+++ b/builtin/fetch-pack.c
@@ -327,6 +327,7 @@ static int find_common(int fd[2], unsigned char *result_sha1,
 			if (args.no_progress)   strbuf_addstr(&c, " no-progress");
 			if (args.include_tag)   strbuf_addstr(&c, " include-tag");
 			if (prefer_ofs_delta)   strbuf_addstr(&c, " ofs-delta");
+			strbuf_addf(&c, " agent=git/%s", git_version_string);
 			packet_buf_write(&req_buf, "want %s%s\n", remote_hex, c.buf);
 			strbuf_release(&c);
 		} else
diff --git a/builtin/send-pack.c b/builtin/send-pack.c
index d5d7105..3d87c71 100644
--- a/builtin/send-pack.c
+++ b/builtin/send-pack.c
@@ -306,11 +306,13 @@ int send_pack(struct send_pack_args *args,
 			int quiet = quiet_supported && (args->quiet || !args->progress);
 
 			if (!cmds_sent && (status_report || use_sideband || args->quiet)) {
-				packet_buf_write(&req_buf, "%s %s %s%c%s%s%s",
+				packet_buf_write(&req_buf,
+						 "%s %s %s%c%s%s%s agent=git/%s",
 						 old_hex, new_hex, ref->name, 0,
 						 status_report ? " report-status" : "",
 						 use_sideband ? " side-band-64k" : "",
-						 quiet ? " quiet" : "");
+						 quiet ? " quiet" : "",
+						 git_version_string);
 			}
 			else
 				packet_buf_write(&req_buf, "%s %s %s",
-- 
1.7.11.rc0.35.ga99aee0
