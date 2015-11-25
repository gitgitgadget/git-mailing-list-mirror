From: Jeff King <peff@peff.net>
Subject: Re: 'git log --source' seems to fail to show ref name after the
 first tag comes out.
Date: Wed, 25 Nov 2015 07:59:57 -0500
Message-ID: <20151125125956.GC4504@sigill.intra.peff.net>
References: <CAAe7MbAwWHXxVOu-CU7QpN0K3XTKJ1=xp4-dzSwBQatdAZ1vaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Raymundo <gypark@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 25 14:00:05 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a1Zg3-0002AU-Mc
	for gcvg-git-2@plane.gmane.org; Wed, 25 Nov 2015 14:00:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752844AbbKYNAA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Nov 2015 08:00:00 -0500
Received: from cloud.peff.net ([50.56.180.127]:33873 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752361AbbKYM77 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Nov 2015 07:59:59 -0500
Received: (qmail 10601 invoked by uid 102); 25 Nov 2015 12:59:59 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 06:59:59 -0600
Received: (qmail 26491 invoked by uid 107); 25 Nov 2015 12:59:58 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Wed, 25 Nov 2015 07:59:58 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 25 Nov 2015 07:59:57 -0500
Content-Disposition: inline
In-Reply-To: <CAAe7MbAwWHXxVOu-CU7QpN0K3XTKJ1=xp4-dzSwBQatdAZ1vaQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281710>

On Wed, Nov 25, 2015 at 07:29:02PM +0900, Raymundo wrote:

> At first, I'm sorry I'm not good at English.

No problem. Your report was very clear. :)

> When I execute this command:
> 
> git log --oneline --source --all --decorate
> [...]
> As you can see, ref names in the second column repeats to disappear
> and come back, at every lines that contain tags.

I was able to reproduce this pretty easily with a short test case:

  git init
  git commit --allow-empty -m one
  git commit --allow-empty -m two
  git commit --allow-empty -m three
  git tag -m mytag HEAD^

Starting from one source works:

  $ git log --oneline --source master
  de009a4 master three
  b75220d master two
  62f49bd master one

But starting from the tag as well does not:

  $ git log --oneline --source master mytag
  de009a4 master three
  b75220d  two
  62f49bd  one

Or more simply, starting from the tag never has any sources:

  $ git log --oneline --source mytag
  b75220d  two
  62f49bd  one

It's like the tag paints its commit with an empty "source" field (and
then we propagate that down the graph).

> I tested using Git version 2.6.3
> 
> For reference, Git version 1.7.9.rc0 does not have this problem. It
> shows ref names on all lines well.

Sounds like a good opportunity to use git-bisect. I came up with 2073949
(traverse_commit_list: support pending blobs/trees with paths,
2014-10-15) from git v2.2.0, which unfortunately was written by me. :)

This one-liner seems to fix it:

diff --git a/revision.c b/revision.c
index af2a18e..d434b8b 100644
--- a/revision.c
+++ b/revision.c
@@ -297,7 +297,6 @@ static struct commit *handle_commit(struct rev_info *revs,
 		 * through to the non-tag handlers below. Do not
 		 * propagate data from the tag's pending entry.
 		 */
-		name = "";
 		path = NULL;
 		mode = 0;
 	}

But I'm not sure if it causes other problems. In particular, I see why
we would not propagate a path field, but I do not know why the original
was avoiding propagating the name field.

-Peff
