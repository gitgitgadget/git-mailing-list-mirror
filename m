From: Jeff King <peff@peff.net>
Subject: Re: diff --check is stupid about blank lines
Date: Wed, 20 Aug 2008 13:28:25 -0400
Message-ID: <20080820172825.GC27773@sigill.intra.peff.net>
References: <20080820140517.GA1304@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: =?utf-8?B?QmrDtnJu?= Steinbrink <B.Steinbrink@gmx.de>
X-From: git-owner@vger.kernel.org Wed Aug 20 19:29:33 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVrUy-0000l8-HF
	for gcvg-git-2@gmane.org; Wed, 20 Aug 2008 19:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753038AbYHTR22 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Aug 2008 13:28:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753053AbYHTR22
	(ORCPT <rfc822;git-outgoing>); Wed, 20 Aug 2008 13:28:28 -0400
Received: from peff.net ([208.65.91.99]:3646 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753005AbYHTR21 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 Aug 2008 13:28:27 -0400
Received: (qmail 25059 invoked by uid 111); 20 Aug 2008 17:28:26 -0000
Received: from lawn-128-61-25-158.lawn.gatech.edu (HELO sigill.intra.peff.net) (128.61.25.158)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.32) with ESMTP; Wed, 20 Aug 2008 13:28:26 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 20 Aug 2008 13:28:25 -0400
Content-Disposition: inline
In-Reply-To: <20080820140517.GA1304@atjola.homenet>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92998>

On Wed, Aug 20, 2008 at 04:05:17PM +0200, Bj=C3=B6rn Steinbrink wrote:

> diff --check triggers not only for blank lines at the end of the file=
,
> but also at the end of the changes. That seems broken to me, unless y=
ou
> really dislike empty lines.

Hmm, yes, that seems wrong. The problem seems to be the conditional at
diff.c:1622:

        if ((data.ws_rule & WS_TRAILING_SPACE) &&
            data.trailing_blanks_start) {
                fprintf(o->file, "%s:%d: ends with blank lines.\n",
                        data.filename, data.trailing_blanks_start);
                data.status =3D 1; /* report errors */
        }

that should probably be "if we care about trailing space, and the last
thing we saw was a trailing blank, _and_ the last hunk adds to
end-of-file, then...". However, I'm not sure what is the best way to ge=
t
that information out of xdiff. Is there a "this hunk hits eof" signal
anywhere? Is there a definitive line count we could use to calculate
that it is in the chunk of final lines in the file?

-Peff
