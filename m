From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] parse_object: try internal cache before reading object db
Date: Thu, 5 Jan 2012 17:18:50 -0500
Message-ID: <20120105221849.GA5459@sigill.intra.peff.net>
References: <20120105210001.GA30549@sigill.intra.peff.net>
 <7vipkpn87d.fsf@alter.siamese.dyndns.org>
 <20120105214941.GA31836@sigill.intra.peff.net>
 <7vehvdn7at.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, git-dev@github.com
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 05 23:18:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RiveE-0007ej-Iq
	for gcvg-git-2@lo.gmane.org; Thu, 05 Jan 2012 23:18:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932924Ab2AEWSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Jan 2012 17:18:53 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:58475
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932863Ab2AEWSw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Jan 2012 17:18:52 -0500
Received: (qmail 31109 invoked by uid 107); 5 Jan 2012 22:25:43 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 05 Jan 2012 17:25:43 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Jan 2012 17:18:50 -0500
Content-Disposition: inline
In-Reply-To: <7vehvdn7at.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188000>

On Thu, Jan 05, 2012 at 01:55:22PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > The worst potential problem I could come up with is if you somehow had
> > an object whose "parsed" flag was set, but somehow didn't have its other
> > fields set (like type).
> > ...
> > So I think it is safe short of somebody doing some horrible manual
> > munging of a "struct object".
> 
> Yeah, I was worried about codepaths like commit-pretty-printing might be
> mucking with the contents of commit->buffer, perhaps reencoding the text
> and then calling parse_object() to get the unmodified original back, or
> something silly like that. But the lookup_object() call at the beginning
> of the parse_object() already prevents us from doing such a thing, so we
> should be OK, I would think.

Er, without my patch there is no such lookup_object, is there?

What saves you is that the parse_*_buffer functions all do nothing when
the object.parsed flag is set, and the code I added makes sure that
object.parsed is set in the object that lookup_object returns.

So yeah, anytime you tweak the contents of commit->buffer but don't
unset the "parsed" flag, you are asking for trouble.

Here's another possible code path where the behavior is changed:

  1. You set the global save_commit_buffer to 0.

  2. You call parse_commit(commit) on an unparsed commit object, which
     does not save the commit buffer, but does set
     commit->object.parsed.

  3. You call parse_object(commit->object.sha1).

     a. Without my patch, we read the file contents again, do _not_
        re-parse them (because we look up the existing object and notice
        that its "parsed" flag is set), but we _do_ assign the buffer to
        commit->buffer.

     b. With my patch, we see that there is an existing object that is
        already parsed, and return early. commit->buffer remains NULL.

I would argue that this doesn't matter, since "parse_commit" uses the
exact same optimization (it returns early without setting commit->buffer
if the parsed flag is set). So any program turning off
save_commit_buffer has to be ready to deal with a NULL commit->buffer in
the first place. The only exception would be a program that then tries
to fill in the commit->buffer field by manually running parse_object on
an already-parsed, buffer-less commit object. I don't think we do that.

You can verify that commit->buffer is the only place where these issues
can happen by following the logic in parse_object_buffer.

Sorry to belabor the discussion, but this is such a core piece of code,
I want to make sure the optimization isn't hurting anybody (I don't
think it is, and certainly the tests are all happy, but I think talking
through the cases is a good thing).

-Peff
