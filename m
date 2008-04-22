From: Jeff King <peff@peff.net>
Subject: Re: git remote update -> rejected
Date: Tue, 22 Apr 2008 07:11:13 -0400
Message-ID: <20080422111113.GB11238@sigill.intra.peff.net>
References: <1208857733.4695.37.camel@marge.simson.net> <20080422103458.GA14751@sigio.intra.peff.net> <1208861703.18689.2.camel@marge.simson.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Junio C Hamano <gitster@pobox.com>, git <git@vger.kernel.org>
To: Mike Galbraith <efault@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 22 13:12:31 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JoGQI-0001P5-7U
	for gcvg-git-2@gmane.org; Tue, 22 Apr 2008 13:12:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762985AbYDVLLV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 22 Apr 2008 07:11:21 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762853AbYDVLLR
	(ORCPT <rfc822;git-outgoing>); Tue, 22 Apr 2008 07:11:17 -0400
Received: from peff.net ([208.65.91.99]:1062 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1762691AbYDVLLP (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 Apr 2008 07:11:15 -0400
Received: (qmail 12867 invoked by uid 111); 22 Apr 2008 11:11:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Tue, 22 Apr 2008 07:11:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 22 Apr 2008 07:11:13 -0400
Content-Disposition: inline
In-Reply-To: <1208861703.18689.2.camel@marge.simson.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80102>

On Tue, Apr 22, 2008 at 12:55:03PM +0200, Mike Galbraith wrote:

> >   [remote "x86"]
> >     url = ...
> >     fetch = +refs/heads/*:refs/remotes/x86/*
> > 
> > See 'git help fetch' for details.
> 
> Thanks a bunch.  I'll try it.  I notice that origin and linux-next
> already had + prefix.  Presumably that came from the home repo.

Cloning creates an origin with '+' in the fetch line, but "git remote
add" doesn't seem to. Hrm, it looks like this is a regression from the
recent rewrite in C.

Dscho, is this a bug, or was there a conscious decision that I missed?

If a bug, the fix is below.

-- >8 --
remote: create fetch config lines with '+'

Since git-remote always uses remote tracking branches, it
should be safe to always force updates of those branches.
I.e., we should generate

  fetch = +refs/heads/*:refs/remotes/$remote/*

instead of

  fetch = refs/heads/*:refs/remotes/$remote/*

This was the behavior of the perl version, which seems to
have been lost in the C rewrite.

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin-remote.c  |    1 +
 t/t5505-remote.sh |   10 ++++++++++
 2 files changed, 11 insertions(+), 0 deletions(-)

diff --git a/builtin-remote.c b/builtin-remote.c
index 9d4432b..8b63619 100644
--- a/builtin-remote.c
+++ b/builtin-remote.c
@@ -107,6 +107,7 @@ static int add(int argc, const char **argv)
 		struct path_list_item *item = track.items + i;
 
 		strbuf_reset(&buf2);
+		strbuf_addch(&buf2, '+');
 		if (mirror)
 			strbuf_addf(&buf2, "refs/%s:refs/%s",
 					item->path, item->path);
diff --git a/t/t5505-remote.sh b/t/t5505-remote.sh
index af2d077..48ff2d4 100755
--- a/t/t5505-remote.sh
+++ b/t/t5505-remote.sh
@@ -77,6 +77,16 @@ test_expect_success 'add another remote' '
 )
 '
 
+test_expect_success 'remote forces tracking branches' '
+(
+	cd test &&
+	case `git config remote.second.fetch` in
+	+*) true ;;
+	 *) false ;;
+	esac
+)
+'
+
 test_expect_success 'remove remote' '
 (
 	cd test &&
-- 
1.5.5.1.116.g0023.dirty
