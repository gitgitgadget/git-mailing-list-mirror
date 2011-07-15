From: Geert Bosch <bosch@adacore.com>
Subject: Re: Git commit generation numbers
Date: Thu, 14 Jul 2011 22:41:57 -0400
Message-ID: <186BDF84-7AE3-4E0F-8F6D-AA89A60C972C@adacore.com>
References: <CA+55aFxZq1e8u7kXu1rNDy2UPgP3uOyC5y2j7idKSZ_4eL=bWw@mail.gmail.com> <20110714183710.GA26820@sigill.intra.peff.net> <CA+55aFwuK+krTA4OcnYhLXtKM5HQ1yuPK+J_vC-5R7AthrHWbg@mail.gmail.com> <20110714190844.GA26918@sigill.intra.peff.net> <CA+55aFx=ACnVBGU8_9wa=9xTbxVoOWKnsqfmBvzq7qzOeMGSNA@mail.gmail.com> <20110714200144.GE26918@sigill.intra.peff.net> <69e0ad24-32b7-4e14-9492-6d0c3d653adf@email.android.com> <20110714203141.GA28548@sigill.intra.peff.net> <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
Mime-Version: 1.0 (Apple Message framework v1084)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Jeff King <peff@peff.net>, Git Mailing List <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
X-From: git-owner@vger.kernel.org Fri Jul 15 04:51:31 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QhYV0-0002yP-Aq
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jul 2011 04:51:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932639Ab1GOCvY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jul 2011 22:51:24 -0400
Received: from rock.gnat.com ([205.232.38.15]:34996 "EHLO rock.gnat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932472Ab1GOCvY (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jul 2011 22:51:24 -0400
X-Greylist: delayed 563 seconds by postgrey-1.27 at vger.kernel.org; Thu, 14 Jul 2011 22:51:23 EDT
Received: from localhost (localhost.localdomain [127.0.0.1])
	by filtered-rock.gnat.com (Postfix) with ESMTP id 07A542BAED1;
	Thu, 14 Jul 2011 22:42:00 -0400 (EDT)
X-Virus-Scanned: Debian amavisd-new at gnat.com
Received: from rock.gnat.com ([127.0.0.1])
	by localhost (rock.gnat.com [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id FthQs1jf6vud; Thu, 14 Jul 2011 22:41:59 -0400 (EDT)
Received: from [10.0.1.3] (sdsl-216-220-103-155.dsl.bway.net [216.220.103.155])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rock.gnat.com (Postfix) with ESMTPSA id 87EA02BAEA3;
	Thu, 14 Jul 2011 22:41:59 -0400 (EDT)
In-Reply-To: <CA+55aFyDzr+SfgSzWMr9pQuQUXTw9mcjZ-00NZof74PKZzbGPA@mail.gmail.com>
X-Mailer: Apple Mail (2.1084)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/177187>


On Jul 14, 2011, at 21:19, Linus Torvalds wrote:
> But dammit, if you start using generation numbers, then they *are*
> required information. The fact that you then hide them in some
> unarchitected random file doesn't change anything! It just makes it
> ugly and random, for chrissake!

Generation numbers never will be required information, because we
can always compute them. These numbers are really much more similar 
to other pack index information than anything else.

<aside>
Sometimes I wish we'd have general "depth" information for each
SHA1, which would be the maximum number of steps in the DAG to reach
a leaf. This way, if we want to do something like "git log
drivers/net/slip.c", we don't have to bother reading the majority
of trees that have a depth less than two. The depth can also be used
as a limiter for "contains" operations, where we want to see if
commit X contains commit Y: depth (X) has to be at least depth (Y).

However, any such notion, wether generation or depth or whatever
else we'll think of tomorrow, is something particular to a certain
implementation of git. It does not add anything to the information
we stored.
</aside>

I don't think my commit should have a different SHA1 from yours,
because your tree has a more generation numbers than mine.

The beauty and genius of GIT is that it just takes the minimum
amount of data needed to uniquely identify the information to be
stored, and stores that in a UNIQUE format. By allowing generation
numbers to either be present or absent, that's all broken.

It's like computing the SHA1 of compressed data: it doesn't depend
on the data we store, just about the particular representation we
choose. Fortunately we have done away with the first mistake.

So, if you're going to add generation numbers, there has to be a
flag day, after which generation numbers are required everywhere. 
Of course it would be possible to recognize "old style" commits 
and convert them on the fly, but that is true for pretty much 
any format change. However, adding redundant information seems 
like a poor excuse for having a flag day.

Storing generation data in pack indices on the other hand makes
perfect sense: when we generate these indices, we do complete
traversals and have all required information trivially at hand.  We
can never have that many loose objects, so lack of generation
information there isn't a big deal. By storing generation information
in the index, we can be sure it is consistent with the data contained
in the pack, so there are no cache invalidation issues.

I know I must have missed some stupid and obvious reason why
this is all wrong, I just don't quite see it yet.

  -Geert
