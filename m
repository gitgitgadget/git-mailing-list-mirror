From: Jeff King <peff@peff.net>
Subject: Re: segmentation fault (nullpointer) with git log --submodule -p
Date: Thu, 24 Jan 2013 19:55:28 -0500
Message-ID: <20130125005528.GA27325@sigill.intra.peff.net>
References: <20130123143816.GA579@krypton.darkbyte.org>
 <20130123200222.GB19832@sigill.intra.peff.net>
 <510124F5.9090505@atlas-elektronik.com>
 <CACsJy8B9O=A26_=sv1JEYdtazsWa4khZkqpTgFSSTs_RGGPZqQ@mail.gmail.com>
 <51013FDD.5030004@atlas-elektronik.com>
 <CACsJy8CEofqi9S8-SDx_O+Ko0i56aRZ4KEJrVnbFum6zzsJrJg@mail.gmail.com>
 <20130124232721.GA16036@sigill.intra.peff.net>
 <7va9ry87a0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Duy Nguyen <pclouds@gmail.com>,
	Stefan =?utf-8?B?TsOkd2U=?= <stefan.naewe@atlas-elektronik.com>,
	Armin <netzverweigerer@gmail.com>, Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 25 01:55:58 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TyXaC-0005hO-IP
	for gcvg-git-2@plane.gmane.org; Fri, 25 Jan 2013 01:55:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756457Ab3AYAzc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Jan 2013 19:55:32 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48704 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755907Ab3AYAzb (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Jan 2013 19:55:31 -0500
Received: (qmail 29168 invoked by uid 107); 25 Jan 2013 00:56:51 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Jan 2013 19:56:51 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Jan 2013 19:55:28 -0500
Content-Disposition: inline
In-Reply-To: <7va9ry87a0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214474>

On Thu, Jan 24, 2013 at 03:56:23PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > ... (e.g., how should "log" know that a submodule diff might later want
> > to see the same entry? Should we optimistically free and then make it
> > easier for the later user to reliably ensure the buffer is primed? Or
> > should we err on the side of keeping it in place?).
> 
> My knee-jerk reaction is that we should consider that commit->buffer
> belongs to the revision traversal machinery.  Any other uses bolted
> on later can borrow it if buffer still exists (I do not think pretty
> code rewrites the buffer contents in place in any way), or they can
> ask read_sha1_file() to read it themselves and free when they are
> done.

Yeah, that is probably the sanest way forward. It at least leaves
ownership in one place, and everybody else is an opportunistic consumer.
We do need to annotate each user site though with something like the
"ensure" function I mentioned.

If they are not owners, then the better pattern is probably something
like:

  /*
   * Get the commit buffer, either opportunistically using
   * the cached version attached to the commit object, or loading it
   * from disk if necessary.
   */
  const char *use_commit_buffer(struct commit *c)
  {
          enum object_type type;
          unsigned long size;

          if (c->buffer)
                  return c->buffer;
          /*
           * XXX check type == OBJ_COMMIT?
           * XXX die() on NULL as a convenience to callers?
           */
          return read_sha1_file(c->object.sha1, &type, &size);
  }

  void unuse_commit_buffer(const char *buf, struct commit *c)
  {
          /*
           * If we used the cached copy attached to the commit,
           * we don't want to free it; it's not our responsibility.
           */
          if (buf == c->buffer)
                  return;

          free((char *)buf);
  }

I suspect that putting a use/unuse pair inside format_commit_message
would handle most cases.

-Peff
