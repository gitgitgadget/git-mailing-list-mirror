From: Jeff King <peff@peff.net>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 17:55:29 -0500
Message-ID: <20130213225529.GA25353@sigill.intra.peff.net>
References: <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
 <511AAA92.4030508@gmail.com>
 <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
 <20130213181851.GA5603@sigill.intra.peff.net>
 <511BF6D7.3030404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: blees@dcon.de
X-From: git-owner@vger.kernel.org Wed Feb 13 23:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5lF6-0005BB-Fj
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 23:55:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965016Ab3BMWzd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 17:55:33 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48356 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751859Ab3BMWzc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 17:55:32 -0500
Received: (qmail 16150 invoked by uid 107); 13 Feb 2013 22:57:01 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Feb 2013 17:57:01 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2013 17:55:29 -0500
Content-Disposition: inline
In-Reply-To: <511BF6D7.3030404@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216290>

On Wed, Feb 13, 2013 at 09:25:59PM +0100, Karsten Blees wrote:

> Am 13.02.2013 19:18, schrieb Jeff King:
> > Moreover, looking at it again, I
> > don't think my patch produces the right behavior: we have a single
> > dir_next pointer, even though the same ce_entry may appear under many
> > directory hashes. So the cache_entries that has to "dir/foo/" and those
> > that hash to "dir/bar/" may get confused, because they will also both be
> > found under "dir/", and both try to create a linked list from the
> > dir_next pointer.
> > 
> 
> Indeed. In the worst case, this causes an endless loop if ce->dir_next == ce
> ---8<---
> mkdir V
> mkdir V/XQANY
> mkdir WURZAUP
> touch V/XQANY/test
> git init
> git config core.ignorecase true
> git add .
> git status
> ---8<---

Great, thanks for the test case. I can trivially replicate the endless
loop. The patch I sent earlier fixes that. So it's at least a step in
the (possible) right direction. I'm slightly concerned that there is
some other case that is expecting the directories in the main hash, but
I think I got them all.

> Note: "V/", "V/XQANY/" and "WURZAUP/" all have the same hash_name.
> Although I found those strange values by brute force, hash collisions
> in 32 bit values are not that uncommon in real life :-)

Cute. :)

> Alternatively, we could simply create normal cache_entries for the
> directories that are linked via ce->next, but have a trailing '/' in
> their name?
>
> Reference counting sounds good to me, at least better than allocating
> directory entries per cache entry * parent dirs.

I think that is more or less what my patch does, but it splits the
ref-counted fake cache_entries out into a separate hash of "struct
dir_hash_entry" rather than storing it in the regular hash. Which IMHO
is a bit cleaner for two reasons:

  1. You do not have to pay the memory price of storing fake
     cache_entries (the name+refcount struct for each directory is much
     smaller than a real cache_entry).

  2. It makes the code a bit simpler, as you do not have to do any
     "check for trailing /" magic on the result of index_name_exists to
     determine if it is a "real" name or just a fake dir entry.

-Peff
