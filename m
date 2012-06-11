From: Jeff King <peff@peff.net>
Subject: Re: Help understanding git checkout behavior
Date: Mon, 11 Jun 2012 17:47:05 -0400
Message-ID: <20120611214705.GC32061@sigill.intra.peff.net>
References: <CAMUXYmUFbixgA1bVMA46Zzjed1Dwmjv54kWWXyjsuyu904GpTA@mail.gmail.com>
 <20120611202132.Horde.dPo1XHwdC4BP1jcsTvSBaFA@webmail.minatec.grenoble-inp.fr>
 <CAA3EhH+iD-sS-3Sg4HJDHgs4Deg2=qbCuJD4UwZWtGQsKbV5aA@mail.gmail.com>
 <7vaa097k3q.fsf@alter.siamese.dyndns.org>
 <CAMUXYmUg12z8LUcFKwjH0Utrvxx0fa5Sne0u9adgoZ=oooBbig@mail.gmail.com>
 <7vobop5zmp.fsf@alter.siamese.dyndns.org>
 <7vk3zd5y8d.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?Q2zDoXVkaW8gTG91cmVuw6dv?= <pt.smooke@gmail.com>,
	Leila <muhtasib@gmail.com>, konglu@minatec.inpg.fr,
	git@vger.kernel.org, Renato Neves <nevrenato@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jun 11 23:47:20 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SeCSA-0000qx-2Z
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jun 2012 23:47:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752104Ab2FKVrK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jun 2012 17:47:10 -0400
Received: from 99-108-225-23.lightspeed.iplsin.sbcglobal.net ([99.108.225.23]:50428
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751515Ab2FKVrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jun 2012 17:47:09 -0400
Received: (qmail 10468 invoked by uid 107); 11 Jun 2012 21:47:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Jun 2012 17:47:09 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jun 2012 17:47:05 -0400
Content-Disposition: inline
In-Reply-To: <7vk3zd5y8d.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199738>

On Mon, Jun 11, 2012 at 02:34:42PM -0700, Junio C Hamano wrote:

> So there are two paths involved in this two-way merge.
> 
> The master branch (HEAD) has "something", but not "something/f1".
> The index does not have "something", but has "something/f1".
> The "b" branch does not have either.
> 
> For path "something", the rule 2 in the "Two Tree Merge" section of
> Documentation/git-read-tree.txt applies.  It does not exist in the
> index, it does exist in HEAD, and it does not exist in the other
> branch we are checking out.  The result should be to remove it.
> 
> For path "something/f1", the rule 4 ought to apply.  The index entry
> for it is up to date with respect to the working tree file
> (i.e. clean), the HEAD does not have it, and the other branch does
> not have it either.  We should be keeping it intact across the
> checkout.  For whatever reason, this is not happening and I suspect
> that is because we have to remove "something" due to rule 2.

I think the problem is in verify_clean_subdirectory, which checks that
we do not have untracked files in the subdirectory, nor modifications
between the index and working tree. But I do not see it checking whether
we have modifications from the HEAD.

> I just checked the history of unpack-trees code (which is the
> underlying machinery of read-tree, which in turn is the machinery
> used to check out another branch by "git checkout"), and I suspect
> that this particular case has never worked.

Yeah, I verified it back to v1.6.x, but didn't bother going further
back.

-Peff
