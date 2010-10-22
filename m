From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] docs: give more hints about how "add -e" works
Date: Fri, 22 Oct 2010 15:25:29 -0400
Message-ID: <20101022192529.GA13059@sigill.intra.peff.net>
References: <20101021143034.GA16083@sigill.intra.peff.net>
 <7v4ocftbww.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Miklos Vajna <vmiklos@frugalware.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Oct 22 21:25:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P9NEm-00006y-69
	for gcvg-git-2@lo.gmane.org; Fri, 22 Oct 2010 21:25:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758984Ab0JVTYt (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Oct 2010 15:24:49 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:47619 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759039Ab0JVTYp (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Oct 2010 15:24:45 -0400
Received: (qmail 22538 invoked by uid 111); 22 Oct 2010 19:24:44 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Fri, 22 Oct 2010 19:24:44 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 22 Oct 2010 15:25:29 -0400
Content-Disposition: inline
In-Reply-To: <7v4ocftbww.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159738>

On Thu, Oct 21, 2010 at 03:32:15PM -0700, Junio C Hamano wrote:

> > +The intent of this option is to pick and choose lines of the patch to
> > +apply, or even to modify the contents of lines to be staged. There are
> > +three line types in a patch: addition lines (beginning with a plus),
> > +removal lines (beginning with a minus), and context lines (beginning
> > +with a space). In general, it should be safe to:
> > ++
> > +--
> > +* remove addition lines (don't stage the line)
> 
> I am not sure if the use of the word "stage" here is correct, even when
> read from the "git stage" lovers' viewpoint.
> 
> If the "+" line is a pure addition without any corresponding line in the
> preimage (which is removed by "-"), then this is "Don't add that line".
> If it has a corresponding "-" line somewhere, that is rather "Remove
> the corresponding line in the preimage".
> 
> "Don't add the updated line" might be a good compromise.

I'm not sure that using the word "add" here is really any different than
"stage". Because we are really talking about adding _to_ the index,
which to me is the same as staging. IOW, I could say "Don't stage the
updated line" and it would mean the exact same thing.

It is a separate issue that adding/staging that line may not be a true
addition, but rather "don't add the updated line". That was what I was
trying to address in the final paragraph.

Perhaps the list should be structured not as "what you can do to each
line" but rather "here are some _concepts_ you might see, here's how
they are represented, and how you might want to edit them". So
basically:

  - added lines; represented by "+" lines. You can prevent staging any
    addition lines by deleting them.

  - removed lines; represented by "-" lines. You can prevent staging any
    removal lines by converting "-" to " ".

  - modified lines; represented by "-" followed by "+". You can prevent
    staging the modification by converting the "-" to a " ", and
    removing the "+" lines. And this would be a good place to warn that
    just deleting half of the pair is going to cause problems.

  - existing lines; represented by " " lines. You can:

      - remove them, by converting " " to "-".

      - modify them, by converting " " to "-", and adding a new "+" line
        with the new content.

  - adding new lines; do not yet exist in the patch. You can add new
    lines by inserting "+" lines with the new content.

which is perhaps better, as it directs the user according to what they
actually want to accomplish.

I shied away from that intially because there are some more complex
cases (e.g., added lines next to modified lines in the same hunk). But I
expect anybody with half a clue can probably figure out how to handle
that using the primitives outlined above.

> > +Similarly, your patch will likely not apply if you:
> > ++
> > +--
> > +* add context or removal lines
> > +* delete removal or context lines
> > +* modify the contents of context or removal lines
> > +--
> > ++
> > +NOTE: In the first list above, the results given for each action are
> > +with respect to that patch line only. Conceptual changes like
> > +modification of a line in the original file are actually represented by
> > +removal of the old line followed by addition of the new line. Deleting
> > +only the addition line of this pair but leaving the removal line would
> > +therefore convert the modification into a deletion. In other words, use
> > +this feature with caution, as it is easy to stage unintended changes.
> 
> Is there a way to move this note way upwards?  Once the reader understands
> what this paragraph teaches, it becomes much easier to understand the
> implication of "remove addition".

I agree it would be better at the top, but I think formatting it as I
just wrote above would mean we can actually explain the issue in a more
appropriate place. And then this bottom warning can just go away. I
think I may still put a few words of caution at the top.

-Peff
