From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] has_sha1_file: re-check pack directory before giving up
Date: Fri, 30 Aug 2013 00:25:34 -0400
Message-ID: <20130830042533.GA23608@sigill.intra.peff.net>
References: <20130830011052.GA21895@sigill.intra.peff.net>
 <xmqqioyn24ne.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Michael Haggerty <mhagger@alum.mit.edu>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Aug 30 06:25:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VFGHN-0003Kq-RU
	for gcvg-git-2@plane.gmane.org; Fri, 30 Aug 2013 06:25:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752963Ab3H3EZi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Aug 2013 00:25:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42951 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752353Ab3H3EZh (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Aug 2013 00:25:37 -0400
Received: (qmail 1929 invoked by uid 102); 30 Aug 2013 04:25:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 29 Aug 2013 23:25:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 30 Aug 2013 00:25:34 -0400
Content-Disposition: inline
In-Reply-To: <xmqqioyn24ne.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233390>

On Thu, Aug 29, 2013 at 09:17:57PM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > When we read a sha1 file, we first look for a packed
> > version, then a loose version, and then re-check the pack
> > directory again before concluding that we cannot find it.
> > This lets us handle a process that is writing to the
> > repository simultaneously (e.g., receive-pack writing a new
> > pack followed by a ref update, or git-repack packing
> > existing loose objects into a new pack).
> >
> > However, we do not do the same trick with has_sha1_file; we
> > only check the packed objects once, followed by loose
> > objects. This means that we might incorrectly report that we
> > do not have an object, even though we could find it if we
> > simply re-checked the pack directory.
> 
> Hmm, would the same reasoning apply to sha1_object_info(), or do
> existing critical code happen not to have a problematic calling
> sequence like you noticed for repack?

I think the same reasoning would apply; however, we seem to already do
the pack-loose-pack lookup there:

int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
{
[...]
        if (!find_pack_entry(sha1, &e)) {
                /* Most likely it's a loose object. */
                if (!sha1_loose_object_info(sha1, oi)) {
                        oi->whence = OI_LOOSE;
                        return 0;
                }

                /* Not a loose object; someone else may have just packed it. */
                reprepare_packed_git();
                if (!find_pack_entry(sha1, &e))
                        return -1;
        }

-Peff
