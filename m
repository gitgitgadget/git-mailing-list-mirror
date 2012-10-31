From: Jeff King <peff@peff.net>
Subject: Re: git smart-http do not authent to allow git ls-remote to be
 called anonymously
Date: Wed, 31 Oct 2012 07:53:46 -0400
Message-ID: <20121031115346.GC30879@sigill.intra.peff.net>
References: <CAHtLG6Q+XO=LhnKw4hhwtOe2ROeDN1Kg=JN5GTQqdvYjk-Sv4g@mail.gmail.com>
 <20121001010935.GA18987@sigill.intra.peff.net>
 <CAHtLG6QFu1rOfUeWREwVG540WvXtM1SnH6aHEJ9dKLzwNxbkVg@mail.gmail.com>
 <CAHtLG6T=hFsSy=ScRK2cYBoUcmAG_tsg12FiFMTvzpHGmPTzfg@mail.gmail.com>
 <20121014063022.GA14812@sigill.intra.peff.net>
 <CAHtLG6QR4CtC3RkVE3FQXhrZPJem6SZbrJFyn9K_4yHzhzYt1Q@mail.gmail.com>
 <20121026134907.GK1455@sigill.intra.peff.net>
 <CAHtLG6SsMgwquaD_Rd0YvR9Ues-u1ktEdOXC2MAfEM9Naac=5g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?5LmZ6YW46Yuw?= <ch3cooli@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 31 12:54:06 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TTWs0-0003DX-Vf
	for gcvg-git-2@plane.gmane.org; Wed, 31 Oct 2012 12:54:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S935263Ab2JaLxv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 31 Oct 2012 07:53:51 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:45000 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932627Ab2JaLxu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 31 Oct 2012 07:53:50 -0400
Received: (qmail 13191 invoked by uid 107); 31 Oct 2012 11:54:32 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 31 Oct 2012 07:54:32 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 31 Oct 2012 07:53:46 -0400
Content-Disposition: inline
In-Reply-To: <CAHtLG6SsMgwquaD_Rd0YvR9Ues-u1ktEdOXC2MAfEM9Naac=5g@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/208808>

[+cc git@vger; please keep discussion on the list]

On Sun, Oct 28, 2012 at 01:26:51PM +0800, =E4=B9=99=E9=85=B8=E9=8B=B0 w=
rote:

> > POST /git/Cat1/SubCat1/xsp.git/git-upload-pack HTTP/1.1
> User-Agent: git/1.8.0
> Host: localhost
> Accept-Encoding: gzip
> Content-Type: application/x-git-upload-pack-request
> Accept: application/x-git-upload-pack-result
> Content-Length: 190
>=20
> * The requested URL returned error: 401
> * Closing connection #0
> Username for 'http://localhost': user
> Password for 'http://user@localhost':
> fatal: The remote end hung up unexpectedly

OK, I see what is going on. The code in b81401c to retry POST requests
does not handle gzipped contents, and upload-pack tends to gzip what it
sends.

Your apache configuration is not really something that we ever intended
to support, and I am a little dubious of the security tradeoff being
made. But it is actually pretty easy for us to support, and it
eliminates a special case from the code, so I am tempted to do so.

The following patch series (on top of the current master, as they
require some cleanup that did not make it into 1.8.0) seems to fix it
for me.

  [1/2]: remote-curl: hoist gzip buffer size to top of post_rpc
  [2/2]: remote-curl: retry failed requests for auth even with gzip

-Peff
