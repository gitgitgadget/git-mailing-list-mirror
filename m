From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Teach git diff about Objective-C syntax
Date: Wed, 17 Sep 2008 13:44:02 -0700
Message-ID: <7vljxq4i5p.fsf@gitster.siamese.dyndns.org>
References: <57518fd10809170526i5c1e7dadgc38bb00e8073ba55@mail.gmail.com>
 <1221658141-75698-1-git-send-email-jon.delStrother@bestbefore.tv>
 <48D11C3C.5070707@op5.se>
 <57518fd10809170831x6d84aeb0m9b0b2c4095a1de70@mail.gmail.com>
 <20080917155505.GH4829@genesis.frugalware.org>
 <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Miklos Vajna" <vmiklos@frugalware.org>,
	"Andreas Ericsson" <ae@op5.se>, git@vger.kernel.org,
	Johannes.Schindelin@gmx.de
To: "Jonathan del Strother" <maillist@steelskies.com>
X-From: git-owner@vger.kernel.org Wed Sep 17 22:50:14 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kg3yU-00023W-8z
	for gcvg-git-2@gmane.org; Wed, 17 Sep 2008 22:50:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752489AbYIQUoP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 17 Sep 2008 16:44:15 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752352AbYIQUoP
	(ORCPT <rfc822;git-outgoing>); Wed, 17 Sep 2008 16:44:15 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:42029 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751823AbYIQUoO (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 17 Sep 2008 16:44:14 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id F350F62968;
	Wed, 17 Sep 2008 16:44:12 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 0D39D62959; Wed, 17 Sep 2008 16:44:05 -0400 (EDT)
In-Reply-To: <57518fd10809171214u3b5b3b96yc432c1c410faf8b4@mail.gmail.com>
 (Jonathan del Strother's message of "Wed, 17 Sep 2008 20:14:02 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 62C52EA6-84F9-11DD-A846-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96135>

"Jonathan del Strother" <maillist@steelskies.com> writes:

> Johannes already convinced me to do it as a separate patch.  Andreas
> seems to think that even if that change were in a separate patch, it
> is pure nonsense.  I think it's pretty subjective - I was just making
> things consistent.

I think the discussion is getting into personal preference, but I do agree
making things consistent is good.

Short and simple ones can stay the same as before, but I'd actually prefer
doing ones on multiple lines like this:

	{ "java",
	  /* Do not match these keywords */
	  "!^[ \t]*\\(catch\\|do\\|for\\|if\\|instanceof\\|"
		"new\\|return\\|switch\\|throw\\|while\\)\n"

	  /* possibly indented "foo bar(..." */
	  "^[ \t]*\\(\\([ \t]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[ \t]*([^;]*\\)$"
	},

	{ "objc",
	  /* Do not match with these C statements */
	  "!^[ \t]*\\(do\\|for\\|if\\|else\\|return\\|switch\\|while\\)\n"

	  /* Objective-C methods "-(fo*&^)%*&%$^" or "+(bar&^)%$#$%" */
	  "^[ \t]*\\([-+][ \t]*([ \t]*[A-Za-z_][A-Za-z_0-9]*.*).*\\)$"

	  "\\|" /* C functions "foo bar(..." */
	  "^[ \t]*\\(\\([ \t]*[A-Za-z_][A-Za-z_0-9]*\\)\\{2,\\}[ \t]*([^;]*\\)$"

	  "\\|" /* Objective-C class/protocol definitions */
	  "^@\\(implementation\\|interface\\|protocol\\).*"
	},

That is:

 - The pattern string indented to align with the pattern name;
 - Indent second and later lines of a single alternatives list that is
   split over multiple physical lines;

Are you sure the regexp you have for Objective-C methods quotes a dot "."
correctly, by the way?  It appears to match almost anything enclosed in a
pair of parentheses, as long as you have two alpha after open paren.

Also I am not sure if you can do the pattern alternates the way you did.
If you have this:

	"...\\(A\\|B\\)$"
        "\\|"
        "...\\(C\\|D\\)$"

A and B will be captured as $1 but wouldn't C or D captured as $2?
