From: Jeff King <peff@peff.net>
Subject: Re: push race
Date: Mon, 15 Oct 2012 14:56:08 -0400
Message-ID: <20121015185608.GC31658@sigill.intra.peff.net>
References: <CAB9Jk9Be4gGaBXixWN7Xju7N6RGKH+FonhaTbZFJ6uYsJDk8dg@mail.gmail.com>
 <CACBZZX5keWVDZ-rvQfHFChKRC1YwXcUvfiqzgeMjVTydnQCdmg@mail.gmail.com>
 <507C1DB4.2010000@xiplink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	Angelo Borsotti <angelo.borsotti@gmail.com>,
	git <git@vger.kernel.org>
To: marcnarc@xiplink.com
X-From: git-owner@vger.kernel.org Mon Oct 15 20:56:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNppu-00026n-KO
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 20:56:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754369Ab2JOS4M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 14:56:12 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53117 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752483Ab2JOS4L (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 14:56:11 -0400
Received: (qmail 5076 invoked by uid 107); 15 Oct 2012 18:56:46 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 15 Oct 2012 14:56:46 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Oct 2012 14:56:08 -0400
Content-Disposition: inline
In-Reply-To: <507C1DB4.2010000@xiplink.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207772>

On Mon, Oct 15, 2012 at 10:29:08AM -0400, Marc Branchaud wrote:

> Here's a previous discussion of a race in concurrent updates to the same ref,
> even when the updates are all identical:
> 
> http://news.gmane.org/find-root.php?group=gmane.comp.version-control.git&article=164636
> 
> In that thread, Peff outlines the lock procedure for refs:
> 
>         1. get the lock
>         2. check and remember the sha1
>         3. release the lock
>         4. do some long-running work (like the actual push)
>         5. get the lock
>         6. check that the sha1 is the same as the remembered one
>         7. update the sha1
>         8. release the lock

A minor nit, but I was wrong on steps 1-3. We don't have to take a lock
on reading, because our write mechanism uses atomic replacement. So it
is really:

  1. read and remember the original sha1
  2. do some long-running work (like the actual push)
  3. get the write lock
  4. read the sha1 and check that it's the same as our original
  5. write the new sha1 to the lockfile
  6. simultaneously release the lock and update the ref by atomically
     renaming the lockfile to the actual ref

Any simultaneous push may see the "old" sha1 before step 6, and when it
gets to its own step 4, will fail (and two processes cannot be in steps
3-6 simultaneously).

> Angelo, in your case I think one of your concurrent updates would fail in
> step 6.  As you say, this is after the changes have been uploaded.  However,
> there's none of the file-overwriting that you fear, because the changes are
> stored in git's object database under their SHA hashes.  So there'll only be
> an object-level collision if two parties upload the exact same object, in
> which case it doesn't matter.

Right. The only thing that needs locking is the refs, because the object
database is add-only for normal operations, and by definition collisions
mean you have the same content (or are astronomically unlucky, but your
consolation prize is that you can write a paper on how you found a sha1
collision).

-Peff
