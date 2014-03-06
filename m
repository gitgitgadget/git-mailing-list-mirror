From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] disable grafts during fetch/push/bundle
Date: Thu, 6 Mar 2014 10:56:26 -0500
Message-ID: <20140306155626.GB18519@sigill.intra.peff.net>
References: <20140304174806.GA11561@sigill.intra.peff.net>
 <xmqqd2i1k7p9.fsf@gitster.dls.corp.google.com>
 <20140305005649.GB11509@sigill.intra.peff.net>
 <xmqqy50oh45n.fsf@gitster.dls.corp.google.com>
 <20140305185212.GA23907@sigill.intra.peff.net>
 <xmqqppm0h2ti.fsf@gitster.dls.corp.google.com>
 <53183506.5080002@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Thu Mar 06 16:56:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WLaf6-0004nl-2B
	for gcvg-git-2@plane.gmane.org; Thu, 06 Mar 2014 16:56:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752411AbaCFP4f (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2014 10:56:35 -0500
Received: from cloud.peff.net ([50.56.180.127]:34125 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752356AbaCFP42 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2014 10:56:28 -0500
Received: (qmail 15244 invoked by uid 102); 6 Mar 2014 15:56:27 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 06 Mar 2014 09:56:27 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 06 Mar 2014 10:56:26 -0500
Content-Disposition: inline
In-Reply-To: <53183506.5080002@alum.mit.edu>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243520>

On Thu, Mar 06, 2014 at 09:42:46AM +0100, Michael Haggerty wrote:

> Replace objects are better than grafts in *almost* every dimension.  The
> exception is that it is dead simple to create grafts, whereas I always
> have to break open the man pages to remember how to create a replace
> object that does the same thing.
> 
> So I think a helpful step towards deprecating grafts would be to offer a
> couple of convenience features to help people kick the "grafts" habit:

I agree that better tool support would make "git replace" more pleasant
to use.

> * A tool that converts grafts (i.e., the grafts read from
> $GIT_DIR/info/grafts) into the equivalent replacements.

I don't know if this is strictly necessary, if we make your command
below pleasant to use. I.e., it should just be:

  while read sha1 parents; do
    git replace --graft $sha1 $parents
  done <.git/info/grafts

We can wrap that in "git replace --convert-grafts", but I do not think
grafts are so common that there would be a big demand for it.

> * A tool that creates a new replacement object that is the equivalent of
> a graft.  I.e., it should do, using replace references, the equivalent
> of the following command:
> 
>       echo SHA1 [PARENT1...] >>$GIT_DIR/info/grafts
> 
> These features could be added to "git replace" or could be built into a
> new "git grafts" command.

I think it would be nice to have a set of "mode" options for
"git-replace" to do basic editing of a sha1 and install the result
(technically you could split the editing into a separate command, but I
do not see the point in editing a sha1 and then _not_ replacing it).

Perhaps:

  # pretty-print sha1 based on type, start $EDITOR, create a
  # type-appropriate object from the result (e.g., using hash-object,
  # mktree, or mktag), and then set up the object as a replacement for
  # SHA1
  git replace --edit SHA1

  # ditto, but replace the $EDITOR step with the parent list
  git replace --graft SHA1 PARENT1 PARENT2

  # ...or remove entries from a tree
  git replace --remove-entry SHA1 foo bar

-Peff
