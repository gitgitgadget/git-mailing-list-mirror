From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v0] sha1_name: grok <revision>:./<relative-path>
Date: Wed, 19 Dec 2007 10:05:11 -0500
Message-ID: <20071219150510.GB13942@coredump.intra.peff.net>
References: <20071218173321.GB2875@steel.home> <m3d4t3q4e5.fsf@roke.D-201> <20071218204623.GC2875@steel.home> <200712182224.28152.jnareb@gmail.com> <20071218222032.GH2875@steel.home> <Pine.LNX.4.64.0712182239500.23902@racer.site> <56b7f5510712181503l1e5dcacds23511d968f98aedb@mail.gmail.com> <alpine.LFD.0.9999.0712181711100.21557@woody.linux-foundation.org> <56b7f5510712181752s7ecebca9m32794c635cba9fd@mail.gmail.com> <Pine.LNX.4.64.0712191334460.23902@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Dana How <danahow@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Alex Riesen <raa.lkml@gmail.com>,
	Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Dec 19 16:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J50Uc-0004PI-I2
	for gcvg-git-2@gmane.org; Wed, 19 Dec 2007 16:05:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754964AbXLSPFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Dec 2007 10:05:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754728AbXLSPFP
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Dec 2007 10:05:15 -0500
Received: from 66-23-211-5.clients.speedfactory.net ([66.23.211.5]:4208 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754964AbXLSPFN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Dec 2007 10:05:13 -0500
Received: (qmail 31823 invoked by uid 111); 19 Dec 2007 15:05:12 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Wed, 19 Dec 2007 10:05:12 -0500
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Wed, 19 Dec 2007 10:05:11 -0500
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.64.0712191334460.23902@racer.site>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68914>

On Wed, Dec 19, 2007 at 01:40:27PM +0000, Johannes Schindelin wrote:

> When you are in a deeply-nested directory structure, and just want
> to reference a blob in a past revision, it can be pretty slow to
> type out "HEAD~29:/bla/blub/.../that-file".
> 
> This patch makes "HEAD~29:./that-file" substitute the current prefix
> for "./".  If there is not working directory, the prefix is empty.
> 
> Note that this patch does not handle "../", and neither do I plan to.

I think this is definitely the right approach. Here's a (possibly
insane) alternative. Revert the change in get_sha1_with_mode and detect
"./" in get_tree_entry:

diff --git a/tree-walk.c b/tree-walk.c
index 8d4b673..fc54354 100644
--- a/tree-walk.c
+++ b/tree-walk.c
@@ -191,6 +191,7 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	unsigned long size;
 	struct tree_desc t;
 	unsigned char root[20];
+	const char *prefix;
 
 	tree = read_object_with_reference(tree_sha1, tree_type, &size, root);
 	if (!tree)
@@ -202,7 +203,11 @@ int get_tree_entry(const unsigned char *tree_sha1, const char *name, unsigned ch
 	}
 
 	init_tree_desc(&t, tree, size);
-	retval = find_tree_entry(&t, name, sha1, mode);
+	if (!prefixcmp(name, "./") && (prefix = get_current_prefix()))
+		retval = find_tree_entry(&t, mkpath("%s%s", prefix, name + 2),
+				sha1, mode);
+	else
+		retval = find_tree_entry(&t, name, sha1, mode);
 	free(tree);
 	return retval;
 }


This means that the directory '.' becomes a token replacement for "my
current path" in tree paths. So if you are in "foo/bar", and you are
looking at a distance commit where the same content was in
"baz/foo/bar", you can do:

  git show distant:baz/./file

This is probably insane because:
  - this is a fairly unlikely use case
  - get_tree_entry gets called in a lot of places, and I have no idea if
    there will be some crazy fallouts.

So it is probably not worth pursuing, but maybe somebody else can think
of a good use.

-Peff
