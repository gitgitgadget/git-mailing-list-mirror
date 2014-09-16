From: Jeff King <peff@peff.net>
Subject: Re: [RFC/PATCH] mailinfo: do not treat ">From" lines as in-body
 headers
Date: Mon, 15 Sep 2014 20:12:42 -0400
Message-ID: <20140916001242.GB5019@peff.net>
References: <20140913204745.GA12291@msilap.einon.net>
 <20140913205751.GA17875@mwanda>
 <20140913210908.GG6549@mwanda>
 <20140913212504.GA25190@peff.net>
 <20140913225713.GB189120@vauxhall.crustytoothpaste.net>
 <20140914004725.GA28010@peff.net>
 <CAPc5daWxZdi+JTTsznefPk2U+Q8uWWYuBUa-rJA4knDZzwU38w@mail.gmail.com>
 <20140914010120.GA28498@peff.net>
 <20140914013038.GA5974@peff.net>
 <xmqqha087lwv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Mark Einon <mark.einon@gmail.com>,
	Greg KH <gregkh@linuxfoundation.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 16 02:12:51 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XTgO1-0000hC-LJ
	for gcvg-git-2@plane.gmane.org; Tue, 16 Sep 2014 02:12:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754293AbaIPAMp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Sep 2014 20:12:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:48635 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754228AbaIPAMo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Sep 2014 20:12:44 -0400
Received: (qmail 12519 invoked by uid 102); 16 Sep 2014 00:12:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 19:12:44 -0500
Received: (qmail 26258 invoked by uid 107); 16 Sep 2014 00:13:06 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 15 Sep 2014 20:13:06 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 15 Sep 2014 20:12:42 -0400
Content-Disposition: inline
In-Reply-To: <xmqqha087lwv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/257118>

On Mon, Sep 15, 2014 at 11:56:16AM -0700, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > It looks like we have a reasonably sane is_from_line() function. So at
> > least _we_ will not generally break on reading our own output, except in
> > some extreme circumstances (you'd have to come up with something
> > contrived like "From me, at 10:30 30 minutes before 11!").
> >
> > We can pretty easily reuse this to make the from-line check in mailinfo
> > more robust. Here's a replacement for the patch I sent earlier that
> > keeps the "magically ignore extra >From headers" behavior but fixes the
> > case that started this discussion.
> 
> Why cache.h when this is still only between mail{info,split}.c both
> of which do not really deal with any "Git" data?

My thought process was basically:

  1. It should go into libgit.a, so we don't end up with an accidental
     libgit->builtin dependency.

  2. It is only one function, and we seem to stuff everything into
     cache.h, so it is probably not a big deal to do it there.

I'd be happy with mbox.h, too.

> For mailsplit, we are trying to detect mbox boundary various MUAs
> would use in their output, and is_from_line() may be appropriate,
> but I am not sure if the same logic is appropriate for mailinfo.
> What are we trying to protect us against?  Those who paste a single
> e-mail output from format-patch in full?  Do people paste a single
> e-mail received to their mailbox from somebody else and do we need
> to protect against that, skipping the ">From " thing, while risking
> to skip "From me at 10:30 30 minutes..."?
> 
> If we only want to skip ">?From" in pasted format-patch output, we
> would want a rule in mailinfo that is tighter than is_from_line() in
> mailsplit.

Yes, the current is_from_line is much looser than we need here. It must
parse lines from an arbitrary writer, and you are right that here we are
specifically interested in git header-lines (at least that is the
rationale given by your 81c5cf7, and what I was trying to preserve).

I mostly just didn't think it mattered much. Despite coming up with a
silly false positive, I doubt it would happen in practice (remember that
in addition to matching, it must _also_ be in an in-body header block at
the start of the body).

> By the way, I see ">From " in is_rfc2822_header(), too.  Do we have
> to worry about this comparison as well?

I don't think so. We call that from read_one_header_line, which is used
when running through the _real_ rfc2822 header. Such a ">From" line
there would not make any sense (we skip "From" at arbitrary points in
the header, too, which is kind of weird; our real goal is to skip the
initial one, which we could do separately). But it does not hurt to be
overly aggressive in eating them there, as they cannot possibly be body
lines.

We do the same thing after a multipart boundary, so if you had:

  <regular rfc2822 email headers>
  Content-Type: multipart/mixed; boundary=foo

  --foo
  Content-Type: text/plain

  your message

  --foo
  Content-Type: message/rfc822

  From blah blah blah
  <commit's rfc2822 email headers>

  --foo--

then I guess it would help. I am not sure that doing so is actually
valid (you do not need the mbox splitter inside the multipart, and it is
actively wrong and a potential danger to mbox readers to put it there).
But if you did put it there, _and_ an mbox writer quoted that line to
">From", I guess we would want to ignore it.

So from my reading (and I am not 100% sure that I am not missing
something), I think we could be much stricter in our parsing there. But
given that it is not causing any problems, and has been that way for
quite a while, I am quite hesitant to change it.

-Peff
