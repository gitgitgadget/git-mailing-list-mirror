From: Jeff King <peff@peff.net>
Subject: Re: fetch unshallow fails to honor dry-run
Date: Mon, 9 Nov 2015 14:24:00 -0500
Message-ID: <20151109192400.GA31715@sigill.intra.peff.net>
References: <562C9DD0.5040109@gnu.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Tim Janik <timj@gnu.org>
X-From: git-owner@vger.kernel.org Mon Nov 09 20:24:10 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Zvs2z-00032z-1b
	for gcvg-git-2@plane.gmane.org; Mon, 09 Nov 2015 20:24:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751503AbbKITYE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 9 Nov 2015 14:24:04 -0500
Received: from cloud.peff.net ([50.56.180.127]:55136 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1751449AbbKITYD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Nov 2015 14:24:03 -0500
Received: (qmail 18719 invoked by uid 102); 9 Nov 2015 19:24:02 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 13:24:02 -0600
Received: (qmail 19184 invoked by uid 107); 9 Nov 2015 19:24:31 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 09 Nov 2015 14:24:31 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Nov 2015 14:24:00 -0500
Content-Disposition: inline
In-Reply-To: <562C9DD0.5040109@gnu.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281078>

[+cc Duy for shallow expertise]

On Sun, Oct 25, 2015 at 10:16:00AM +0100, Tim Janik wrote:

> git fetch --dry-run modifies the repository if --unshallow is passed:
> 
> $ git --version
> git version 2.1.4
> $ git fetch --dry-run --unshallow
> remote: Counting objects: 30603, done.
> remote: Compressing objects: 100% (6843/6843), done.
> remote: Total 30603 (delta 24564), reused 29164 (delta 23386)
> Receiving objects: 100% (30603/30603), 5.42 MiB | 0 bytes/s, done.
> Resolving deltas: 100% (24564/24564), completed with 317 local objects.
> remote: Counting objects: 7, done.
> remote: Compressing objects: 100% (7/7), done.
> remote: Total 7 (delta 0), reused 6 (delta 0)
> Unpacking objects: 100% (7/7), done.

Hmm. I think that is because --dry-run is effectively "transfer the
objects, but do not update refs". So by fetching the objects, we've
effectively deepened the repository, whether we update the refs or not.

That being said, I suspect nobody has really thought hard about the
interaction of these two flags. And while obviously we update the
object database with a dry-run fetch, I can see the reasoning that we
should not touch the .git/shallow file, even if we have the objects.

Naively, something like this patch might help, but I have no idea if it
causes other problems.

diff --git a/builtin/fetch.c b/builtin/fetch.c
index 4ce4fa0..24aa331 100644
--- a/builtin/fetch.c
+++ b/builtin/fetch.c
@@ -870,7 +870,7 @@ static struct transport *prepare_transport(struct remote *remote)
 		set_option(transport, TRANS_OPT_KEEP, "yes");
 	if (depth)
 		set_option(transport, TRANS_OPT_DEPTH, depth);
-	if (update_shallow)
+	if (update_shallow && !dry_run)
 		set_option(transport, TRANS_OPT_UPDATE_SHALLOW, "yes");
 	return transport;
 }

> I actually tried --dry-run --unshallow in order to find a way to
> detect in a script if the current git repository is shallow or not.
> Better suggestions to find this out are very welcome.

You can look for .git/shallow. I don't know if we've documented that
anywhere as a public interface, but I think it should be safe to rely
on.

-Peff
