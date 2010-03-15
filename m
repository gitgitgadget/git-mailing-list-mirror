From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH] daemon.c: avoid accessing ss_family member of struct
 sockaddr_storage
Date: Mon, 15 Mar 2010 23:41:44 +0200 (EET)
Message-ID: <alpine.DEB.2.00.1003152338120.29993@cone.home.martin.st>
References: <alpine.DEB.2.00.1003120922040.29993@cone.home.martin.st> <XI3O9HirgFwPkEqC3RdYR4j56mg_uuJQZk1YFST6ukqbKXjgxaqJdNDHwlLXg5R_FVXWmWQSGmg@cipher.nrlssc.navy.mil> <20100315212915.GB25342@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Brandon Casey <casey@nrlssc.navy.mil>, git@vger.kernel.org,
	git@mlists.thewrittenword.com, kusmabite@gmail.com,
	Brandon Casey <drafnel@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Mar 15 22:42:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NrI2x-0007wE-2o
	for gcvg-git-2@lo.gmane.org; Mon, 15 Mar 2010 22:41:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S936887Ab0COVlu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Mar 2010 17:41:50 -0400
Received: from mta-out.inet.fi ([195.156.147.13]:39302 "EHLO kirsi1.inet.fi"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932222Ab0COVlt (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Mar 2010 17:41:49 -0400
Received: from dsl-tkubrasgw1-ffc4c100-75.dhcp.inet.fi (88.193.196.75) by kirsi1.inet.fi (8.5.014)
        id 4B1D0B4D03FE8D7D; Mon, 15 Mar 2010 23:41:45 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <20100315212915.GB25342@coredump.intra.peff.net>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142259>

On Mon, 15 Mar 2010, Jeff King wrote:

> On Mon, Mar 15, 2010 at 04:03:00PM -0500, Brandon Casey wrote:
> 
> > When NO_SOCKADDR_STORAGE is set for a platform, either sockaddr_in or
> > sockaddr_in6 is used intead.  Neither of which has an ss_family member.
> > They have an sin_family and sin6_family member respectively.  Since the
> > addrcmp() function accesses the ss_family member of a sockaddr_storage
> > struct, compilation fails on platforms which define NO_SOCKADDR_STORGAGE.
> > 
> > Since any sockaddr_* structure can be cast to a struct sockaddr and
> > have its sa_family member read, do so here to workaround this issue.
> 
> Didn't Gary say that AIX 5.2 sticks sa_len at the front of their
> sockaddr?

Yes, but if they have it in sockaddr, they have it in sockaddr_in (and 
should have it in sockaddr_storage, if it defines such fields at all). 
Those structs should always be defined so that their 
sa_family/ss_family/sin_family/sin6_family fields match.

> We know that whatever we actually have (an actual sockaddr_storage, or a
> sockaddr_in, or a sockaddr_in6) will have the family at the front, so
> can you just cast it to sa_family_t?
> 
> Or am I wrong in assuming that, and on AIX sockaddr_in actually has
> sa_len at the front, so casting to sockaddr does the right thing (and my
> recommendation above would actually be broken)? The AIX boxen I have
> access to are all down at the moment.

Generally, I don't think one can assume much about the layout of these 
structs, there may be this sa_len field on some implementations.

But you should always be able to cast a sockaddr_in or sockaddr_in6 or 
sockaddr_storage to a sockaddr, to examine its sa_family field, in order 
to know what to cast it to.

// Martin
