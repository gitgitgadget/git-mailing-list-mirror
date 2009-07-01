From: Jeff King <peff@peff.net>
Subject: Re: RFH - git-log variant that _does_ search through diffs
Date: Wed, 1 Jul 2009 03:02:52 -0400
Message-ID: <20090701070252.GA7987@sigio.peff.net>
References: <279b37b20906291708g67da3a75p316ea4893f02666a@mail.gmail.com> <20090630040337.GA23741@sigio.peff.net> <279b37b20906301105tf92f471g6146a083ba2e2882@mail.gmail.com> <20090630193135.GA4460@sigio.peff.net> <279b37b20906301422w2b895afai5edf42fcbfcc7d5a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Eric Raible <raible@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 01 09:03:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MLtow-0004XL-JW
	for gcvg-git-2@gmane.org; Wed, 01 Jul 2009 09:01:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753220AbZGAHA7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jul 2009 03:00:59 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753122AbZGAHA7
	(ORCPT <rfc822;git-outgoing>); Wed, 1 Jul 2009 03:00:59 -0400
Received: from peff.net ([208.65.91.99]:39812 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752582AbZGAHA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jul 2009 03:00:59 -0400
Received: (qmail 8001 invoked by uid 1000); 1 Jul 2009 07:02:52 -0000
Content-Disposition: inline
In-Reply-To: <279b37b20906301422w2b895afai5edf42fcbfcc7d5a@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122567>

On Tue, Jun 30, 2009 at 02:22:43PM -0700, Eric Raible wrote:

> Unfortunately --format seems to turn off -z (at least in msysgit):
> 
> $ git --version
> git version 1.6.3.2.1299.gee46c
> $ git log -p > L1
> $ git log -p -z > L2
> $ diff L1 L2 | wc
>    2415    4347   62889
> $ git log -p --format=%s > L1
> $ git log -p -z --format=%s > L2
> $ diff L1 L2 | wc
>       0       0       0

Ugh. I did some looking into this. It actually does work if you do:

  git log -p -z --pretty=format:%s

rather than

  git log -p -z --pretty=tformat:%s

And --format=%s behaves as if 'tformat' was given. And if you are not up
to date on the difference, "format" implies "separator semantics", where
the NUL is placed _between_ each record. "tformat" implies "terminator
semantics", where the NUL is placed at the end.

Placing the separator correctly is fairly easy; when we start a new
record, if we are not the first, we print the separator. Placing a
terminator is a little trickier because of the way the code is
structured. I'll post my attempt in a minute; see patch 2/2 for more
discussion.

-Peff
