From: Jeff King <peff@peff.net>
Subject: Re: git fetch origin hanging in 1.7.0
Date: Tue, 16 Feb 2010 01:39:59 -0500
Message-ID: <20100216063959.GC2169@coredump.intra.peff.net>
References: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>, git@vger.kernel.org
To: Kevin Menard <nirvdrum@gmail.com>
X-From: git-owner@vger.kernel.org Tue Feb 16 07:40:17 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NhH6W-0008I3-Q2
	for gcvg-git-2@lo.gmane.org; Tue, 16 Feb 2010 07:40:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753916Ab0BPGkJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Feb 2010 01:40:09 -0500
Received: from peff.net ([208.65.91.99]:42779 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753738Ab0BPGkI (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Feb 2010 01:40:08 -0500
Received: (qmail 29989 invoked by uid 107); 16 Feb 2010 06:40:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Tue, 16 Feb 2010 01:40:14 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Tue, 16 Feb 2010 01:39:59 -0500
Content-Disposition: inline
In-Reply-To: <7e3605161002151608t44bd320cgcd589796a9ec902b@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/140072>

On Mon, Feb 15, 2010 at 07:08:25PM -0500, Kevin Menard wrote:

> I've run into an issue that doing a "git fetch origin" is hanging for
> me in git 1.7.0.  The setup here may be wrong, so I don't want to call
> it a bug.  But basically I have an empty repo created on the server
> that a client then clones.  There's a job that fetches new updates to
> the server periodically.  If nothing has been pushed to the server
> yet, the client fetch hangs.
> 
> This worked fine in 1.6.6, so I'll just roll back my version for now.
> But any help on how to do this different would be much appreciated.

No, what you're doing should work OK (though it does actually produce
ugly "the remote end hung up unexpectedly" messages in v1.6.6).

I can reproduce the bug with:

  $ mkdir foo && (cd foo && git init)
  $ git clone foo bar
  Initialized empty Git repository in /home/peff/bar/.git/
  warning: You appear to have cloned an empty repository.
  $ cd bar && git fetch

which hangs on a pipe read(). It bisects to 61b075b (Support taking over
transports, 2009-12-09) from Ilari (cc'd). It looks like we get the
empty ref list once in get_remote_heads, and then try to get it again
and hang. Maybe we need this?

diff --git a/transport.c b/transport.c
index ad25b98..e6f9464 100644
--- a/transport.c
+++ b/transport.c
@@ -1010,7 +1010,8 @@ int transport_push(struct transport *transport,
 
 const struct ref *transport_get_remote_refs(struct transport *transport)
 {
-	if (!transport->remote_refs)
+	struct git_transport_data *data = transport->data;
+	if (!data->got_remote_heads)
 		transport->remote_refs = transport->get_refs_list(transport, 0);
 
 	return transport->remote_refs;

That fixes the problem for me, but I am totally clueless about this
code. Do all transports have a git_transport_data (if so, then why is it
a void pointer?).

-Peff
