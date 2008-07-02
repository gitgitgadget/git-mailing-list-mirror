From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-add--interactive: manual hunk editing mode
Date: Wed, 02 Jul 2008 01:38:25 -0700
Message-ID: <7v1w2cel4u.fsf@gitster.siamese.dyndns.org>
References: <20080701101114.GA6379@sigill.intra.peff.net>
 <1214912674-9443-1-git-send-email-trast@student.ethz.ch>
 <7v7ic4hmj5.fsf@gitster.siamese.dyndns.org>
 <200807020900.28690.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Thomas Rast <trast@student.ethz.ch>
X-From: git-owner@vger.kernel.org Wed Jul 02 10:39:42 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KDxsJ-0003Kh-C0
	for gcvg-git-2@gmane.org; Wed, 02 Jul 2008 10:39:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752657AbYGBIil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 2 Jul 2008 04:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751360AbYGBIil
	(ORCPT <rfc822;git-outgoing>); Wed, 2 Jul 2008 04:38:41 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49773 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752512AbYGBIij (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 2 Jul 2008 04:38:39 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8E47928789;
	Wed,  2 Jul 2008 04:38:38 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AB97C28786; Wed,  2 Jul 2008 04:38:32 -0400 (EDT)
In-Reply-To: <200807020900.28690.trast@student.ethz.ch> (Thomas Rast's
 message of "Wed, 2 Jul 2008 09:00:24 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 446EBCCA-4812-11DD-8D98-CE28B26B55AE-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/87116>

Thomas Rast <trast@student.ethz.ch> writes:

> Junio C Hamano wrote:
> ...
>> > +# To remove '-' lines, make them ' ' lines (context).
>> > +# To remove '+' lines, delete them.
>> > +# Lines starting with # will be removed.
>> 
>> Don't you want to say "Do not touch lines that begin with ' '"?
>
> Why?  You can make them '-' instead if you really want to :-)

If you change '-' to ' ', or remove '+', then you are temporarily
reverting the change you have made since HEAD to your working tree copy.
If you do not change anything, you are taking something that was in your
working tree copy.  Both are simpler and easier to explain operations.

Once you allow changing ' ' to '-' or insert '+' at random places,
however, you are letting the user commit lines that is neither from HEAD
nor from the working tree.

If the goal of "e" action in "add -i" is to support that operation (I am
not saying that it is a bad thing to support), you have to deal with an
issue that your patch so far did not have to deal with, and it would
require a much larger change to the way how "add -i" is structured.

When you give the user a hunk like this to edit:

  @@ -4,9 +4,6 @@ GIT v1.6.0 Release Notes
   User visible changes
   --------------------

  -[[Note that none of these are not merged to 'master' as of this writing
  -but they will be before 1.6.0 happens]]
  -
   With the default Makefile settings, most of the programs are now
   installed outside your $PATH, except for "git", "gitk", "git-gui" and
   some server side programs that need to be accessible for technical

the user may want to change the line before the line that has "User
visible changes", or the lines toward the end of the hunk. The user may
want to edit the line that ends with "for technical" for rewording the
sentence, but the rest of the sentence is outside the context, and these
lines somehow needs to be summoned to the editing session for completing
the updated sentence.  In order to support that, you need to be able to
extend the context on demand in either direction, beyond the original "git
diff" output you captured in $hunk[$i]{TEXT} (sorry, I misspelled this as
$mode->{TEXT} in the previous message).

Once you start to do that, you would need to worry about the case where
the hunk extended to include later lines overlaps with the hunk after the
one we are currently looking at, and run coalesce_overlapping_hunks to
concatenate them into a larger single hunk.  But to be able to do that,
you would need to keep track of the number of lines in a hunk yourself
anyway, which would mean that you cannot rely on --recount anymore.  The
extension recently made to "git apply" becomes redundant and unused code.

In short, declaring that you are supporting the use to change ' ' to '-'
means you are opening a whole can of worms, and I asked the question
because I did not know if you are really prepared to deal with it.
