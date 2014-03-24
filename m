From: Jeff King <peff@peff.net>
Subject: Re: Git push race condition?
Date: Mon, 24 Mar 2014 18:51:36 -0400
Message-ID: <20140324225136.GA17080@sigill.intra.peff.net>
References: <CAAyEjTN53+5B9Od9wW698wODNL3hR6Upot8-ZLwEksn3ir_zjA@mail.gmail.com>
 <CACBZZX4ZEPA3sBp4-3QF6de0EWXzPkcOiqSxH3_CXV27Z=gxtw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Scott Sandler <scott.m.sandler@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 24 23:51:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSDiY-0004vG-J5
	for gcvg-git-2@plane.gmane.org; Mon, 24 Mar 2014 23:51:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751305AbaCXWvi convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 24 Mar 2014 18:51:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:46225 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750816AbaCXWvi (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Mar 2014 18:51:38 -0400
Received: (qmail 13173 invoked by uid 102); 24 Mar 2014 22:51:38 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Mar 2014 17:51:38 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Mar 2014 18:51:36 -0400
Content-Disposition: inline
In-Reply-To: <CACBZZX4ZEPA3sBp4-3QF6de0EWXzPkcOiqSxH3_CXV27Z=gxtw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/244894>

On Mon, Mar 24, 2014 at 10:16:52PM +0100, =C3=86var Arnfj=C3=B6r=C3=B0 =
Bjarmason wrote:

> > error: Ref refs/heads/master is at
> > 4584c1f34e07cea2df6abc8e0d407fe016017130 but expected
> > 61b79b6d35b066d054fb3deab550f1c51598cf5f
> > remote: error: failed to lock refs/heads/master
>=20
> I also see this error once in a while. I read the code a while back
> and it's basically because there's two levels of locks that
> receive-pack tries to get, and it's possible for two pushers to get
> the first lock due to a race condition.
>=20
> I've never seen data loss due to this though, because the inner lock =
is atomic.

The reason is that there are not 2 locks. Each side remembers the "old"
value when it started the operation, and only takes a lock when it come=
s
time to write the ref (and then checks that the old value is still
current). Two pushes happening simultaneously do not have any idea that
the other is occurring.

-Peff
