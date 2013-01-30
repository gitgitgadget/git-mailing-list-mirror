From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/6] introduce pack metadata cache files
Date: Wed, 30 Jan 2013 01:47:45 -0500
Message-ID: <20130130064744.GA11147@sigill.intra.peff.net>
References: <20130129091434.GA6975@sigill.intra.peff.net>
 <20130129091555.GC9999@sigill.intra.peff.net>
 <7v622friy7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, Duy Nguyen <pclouds@gmail.com>,
	"Shawn O. Pearce" <spearce@spearce.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 30 07:50:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U0RVS-0004Vt-4K
	for gcvg-git-2@plane.gmane.org; Wed, 30 Jan 2013 07:50:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752510Ab3A3Grt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Jan 2013 01:47:49 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:53795 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751408Ab3A3Grs (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Jan 2013 01:47:48 -0500
Received: (qmail 27336 invoked by uid 107); 30 Jan 2013 06:49:11 -0000
Received: from c-71-206-173-132.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.206.173.132)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 30 Jan 2013 01:49:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 30 Jan 2013 01:47:45 -0500
Content-Disposition: inline
In-Reply-To: <7v622friy7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214995>

On Tue, Jan 29, 2013 at 09:35:12AM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > +static void write_meta_header(struct metapack_writer *mw, const char *id,
> > +			      uint32_t version)
> > +{
> > +	version = htonl(version);
> > +
> > +	sha1write(mw->out, "META", 4);
> > +	sha1write(mw->out, "\0\0\0\1", 4);
> > +	sha1write(mw->out, mw->pack->sha1, 20);
> > +	sha1write(mw->out, id, 4);
> > +	sha1write(mw->out, &version, 4);
> > +}
> 
> It seems that you are very close to actually having a plumbing that
> could also do the pack .idx files.  Until/unless that can be done, I
> am not sure how much benefit we would be getting from a file format
> that records a subtype "id" and a generic "META" type, instead of
> just a single "id" as the type ehader.  But it is OK to use 8 extra
> bytes if we can potentially gain something later.

Yeah, I considered going that route. I had initially envisioned having a
generic META file type that provided some services (like fixed-size
records), and then having individual subtypes below that. But as I
simplified the design, the META format became pretty much pointless. I
left it in as the 8 bytes are not really a big problem, and it means we
can treat metapacks generically in some cases without necessarily
knowing what is in them. But I don't have a specific use case in mind,
so perhaps it is just useless and confusing. I don't mind simplifying.

> Shouldn't id be validated with at least something like
> 
> 	if (strlen(id) < 3)
> 		die("Bad id: %s", id);
> 
> to catch a call
> 
> 	write_meta_header(&mw, "me", 47);
> 
> that will stuff 'm', 'e', NUL and the garbage the compiler/linker
> combo has placed after that constant string in the 4-byte id field?

Yes, the id does need to be at least 4 bytes. Since the id is intended
to be a static string, I had planned to just document the requirement in
the API documentation. I don't mind putting in a run-time check. I had
originally had a separate "id" parameter that could be "char id[4]", but
found that it was just redundant with the "name" parameter: you ended up
passing ("commit", "CMIT") or similar.

> > +	strbuf_addstr(&path, pack_idx);
> > +	strbuf_chompstr(&path, ".idx");
> > +	strbuf_addch(&path, '.');
> > +	strbuf_addstr(&path, name);
> 
> Your chompstr() does not even validate if the given name ends with
> ".idx",

Yeah, my intent was that it would be liberal in its input (i.e., take
just "pack-*"). E.g., you can run "git metapack pack/pack-XXXX".

> so this sounds like a glorified way to say
> 
> 	strbuf_splice(&path, path->len - strlen("idx"), strlen("idx"),
> 			 name, strlen(name));
> 
> to me.

Yup, though my version handles edge cases by not chomping (e.g., what
does splice do when path->len is less than 3?).

> > +void metapack_writer_finish(struct metapack_writer *mw)
> > +{
> > +	const char *tmp = mw->out->name;
> > +
> > +	sha1close(mw->out, NULL, CSUM_FSYNC);
> > +	if (rename(tmp, mw->path))
> > +		die_errno("unable to rename temporary metapack file");
> 
> Who is responsible for running adjust_shared_perm()?  The caller, or
> this function?

I didn't think about it at all, but it seems pretty obvious to me that
this function should do so. Thanks for pointing it out.

-Peff
