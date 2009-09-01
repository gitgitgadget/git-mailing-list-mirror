From: Jeff King <peff@peff.net>
Subject: Re: clong an empty repo over ssh causes (harmless) fatal
Date: Mon, 31 Aug 2009 21:08:33 -0400
Message-ID: <20090901010833.GA4033@sigill.intra.peff.net>
References: <slrnh9nc4e.6bn.sitaramc@sitaramc.homelinux.net>
 <vpqskf8z0rj.fsf@bauges.imag.fr>
 <2e24e5b90908310730u53ee27d3nd2b66c1f58202e7@mail.gmail.com>
 <20090831164146.GA23245@coredump.intra.peff.net>
 <vpqocpvevzx.fsf@bauges.imag.fr>
 <20090831191032.GB4876@sigill.intra.peff.net>
 <20090831201911.GA24989@atjola.homenet>
 <20090831224749.GA24190@sigill.intra.peff.net>
 <fabb9a1e0908311550r1b549eb2k2df65c188a0ea6a0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Sitaram Chamarty <sitaramc@gmail.com>, git@vger.kernel.org
To: Sverre Rabbelier <srabbelier@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 01 03:08:48 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MiHrc-0005OP-0o
	for gcvg-git-2@lo.gmane.org; Tue, 01 Sep 2009 03:08:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752583AbZIABIe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 31 Aug 2009 21:08:34 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751482AbZIABIe
	(ORCPT <rfc822;git-outgoing>); Mon, 31 Aug 2009 21:08:34 -0400
Received: from peff.net ([208.65.91.99]:60102 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751442AbZIABId (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 31 Aug 2009 21:08:33 -0400
Received: (qmail 29498 invoked by uid 107); 1 Sep 2009 01:08:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Mon, 31 Aug 2009 21:08:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 31 Aug 2009 21:08:33 -0400
Content-Disposition: inline
In-Reply-To: <fabb9a1e0908311550r1b549eb2k2df65c188a0ea6a0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127512>

On Tue, Sep 01, 2009 at 12:50:25AM +0200, Sverre Rabbelier wrote:

> 2009/9/1 Jeff King <peff@peff.net>:
> > AFAICT, this problem goes back to v1.6.2, the first version which
> > handled empty clones. So I blame Sverre. ;)
> 
> Eep :(. Any idea what is going on?

Yeah. We call upload-pack on the remote side, realize there are no refs,
and then we just stop talking. Meanwhile upload-pack is waiting for a
packet to say "these are the refs that I want". So the client really
needs to send an extra packet saying "list of refs is finished".

The patch below seems to work for me, but I'm a little concerned how it
might impact other transports. It actually calls the transport's
fetch method when we have no refs that we want. So each transport must
recognize that we want zero refs and do the appropriate thing. In this
case, for the git protocol, we want to:

  - do a packet_flush to signal "no more refs" to the remote side

  - be aware that we might have zero refs and avoid establishing a new
    connection in that case

Other transports might need to be tweaked similarly, but I don't have
time to test at the moment.

diff --git a/builtin-clone.c b/builtin-clone.c
index 0d2b4a8..f198c01 100644
--- a/builtin-clone.c
+++ b/builtin-clone.c
@@ -515,8 +515,7 @@ int cmd_clone(int argc, const char **argv, const char *prefix)
 					     option_upload_pack);
 
 		refs = transport_get_remote_refs(transport);
-		if(refs)
-			transport_fetch_refs(transport, refs);
+		transport_fetch_refs(transport, refs);
 	}
 
 	if (refs) {
diff --git a/builtin-fetch-pack.c b/builtin-fetch-pack.c
index 629735f..04a3776 100644
--- a/builtin-fetch-pack.c
+++ b/builtin-fetch-pack.c
@@ -803,6 +803,8 @@ struct ref *fetch_pack(struct fetch_pack_args *my_args,
 		nr_heads = remove_duplicates(nr_heads, heads);
 	if (!ref) {
 		packet_flush(fd[1]);
+		if (!nr_heads)
+			return NULL;
 		die("no matching remote head");
 	}
 	ref_cpy = do_fetch_pack(fd, ref, nr_heads, heads, pack_lockfile);
diff --git a/transport.c b/transport.c
index f2bd998..25e8946 100644
--- a/transport.c
+++ b/transport.c
@@ -512,6 +512,8 @@ static int fetch_refs_via_pack(struct transport *transport,
 		origh[i] = heads[i] = xstrdup(to_fetch[i]->name);
 
 	if (!data->conn) {
+		if (!nr_heads)
+			return 0;
 		connect_setup(transport, 0, 0);
 		get_remote_heads(data->fd[0], &refs_tmp, 0, NULL, 0, NULL);
 	}
