From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 12/15] use get_commit_buffer everywhere
Date: Mon, 9 Jun 2014 20:22:03 -0400
Message-ID: <20140610002202.GB20644@sigill.intra.peff.net>
References: <20140609180236.GA24644@sigill.intra.peff.net>
 <20140609181323.GL20315@sigill.intra.peff.net>
 <xmqqbnu1emfa.fsf@gitster.dls.corp.google.com>
 <20140610000223.GA20644@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>,
	Jakub Narebski <jnareb@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Jun 10 02:41:50 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuA8E-0004oW-78
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 02:41:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934731AbaFJAlY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Jun 2014 20:41:24 -0400
Received: from cloud.peff.net ([50.56.180.127]:40635 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933943AbaFJAWE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 9 Jun 2014 20:22:04 -0400
Received: (qmail 19603 invoked by uid 102); 10 Jun 2014 00:22:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 09 Jun 2014 19:22:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 09 Jun 2014 20:22:03 -0400
Content-Disposition: inline
In-Reply-To: <20140610000223.GA20644@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251150>

On Mon, Jun 09, 2014 at 08:02:24PM -0400, Jeff King wrote:

> I'm still confused and disturbed that my gcc is not noticing this
> obvious const violation. Hmm, shutting off ccache seems to make it wo=
rk.
> Doubly disturbing.

Ah, mystery solved. It's a gcc bug:

  https://gcc.gnu.org/bugzilla/show_bug.cgi?id=3D60014

I get:

  $ gcc -c -Wall -Werror -DSHA1_HEADER=3D'"block-sha1/sha1.h"' notes-me=
rge.c
  notes-merge.c: In function =E2=80=98notes_merge_commit=E2=80=99:
  notes-merge.c:723:2: error: passing argument 2 of =E2=80=98strbuf_att=
ach=E2=80=99
    discards =E2=80=98const=E2=80=99 qualifier from pointer target type=
 [-Werror]
  ...etc...

  $ gcc -E -Wall -Werror -DSHA1_HEADER=3D'"block-sha1/sha1.h"' notes-me=
rge.c >foo.c
  $ gcc -c -Wall -Werror -DSHA1_HEADER=3D'"block-sha1/sha1.h"' foo.c
  [no warnings from either]

ccache uses the latter technique.

-Peff
