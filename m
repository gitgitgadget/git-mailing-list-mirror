From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] checkout: fix attribute handling in checkout all
Date: Sun, 12 Aug 2007 14:50:21 -0700
Message-ID: <7veji8ifs2.fsf@assigned-by-dhcp.cox.net>
References: <11869508753328-git-send-email-prohaska@zib.de>
	<118695087531-git-send-email-prohaska@zib.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: dmitry.kakurin@gmail.com, git@vger.kernel.org
To: Steffen Prohaska <prohaska@zib.de>
X-From: git-owner@vger.kernel.org Sun Aug 12 23:50:28 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKLKN-0004RQ-Al
	for gcvg-git@gmane.org; Sun, 12 Aug 2007 23:50:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1761673AbXHLVuY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 12 Aug 2007 17:50:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1761587AbXHLVuY
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Aug 2007 17:50:24 -0400
Received: from fed1rmmtao104.cox.net ([68.230.241.42]:60542 "EHLO
	fed1rmmtao104.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761299AbXHLVuX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Aug 2007 17:50:23 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao104.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070812215023.KMPN3478.fed1rmmtao104.cox.net@fed1rmimpo02.cox.net>;
          Sun, 12 Aug 2007 17:50:23 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id b9qN1X0011kojtg0000000; Sun, 12 Aug 2007 17:50:22 -0400
In-Reply-To: <118695087531-git-send-email-prohaska@zib.de> (Steffen Prohaska's
	message of "Sun, 12 Aug 2007 22:34:35 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55728>

Steffen Prohaska <prohaska@zib.de> writes:

> We need to check out .gitattributes files first to have
> them in place when we check out the remaining files. This
> is needed to get the right attributes during checkout,
> for example having the right crlf conversion on the first
> checkout if crlf is controlled by a .gitattribute file.
>
> This works only together with the commit
>
> 'attr: fix attribute handling if .gitattributes is involved'

While I think it is _one_ good approach to make things two-pass,
I do not know if this is enough.  A logic similar to this should
be made available to the codepath that switches branches,
shouldn't it?

It feels somewhat bogus to treat only the files that contain
".gitattributes" as substring.  Don't you want to at least say
"is .gitattributes or ends with /.gitattributes"?

I am not 100% convinced that it is "unexpected" that
these two sequences give different results.

 (1) rm -f .gitattributes other
     git-checkout-index -f .gitattributes
     git-checkout-index -f other

 (2) rm -f .gitattributes other
     git-checkout-index -f other
     git-checkout-index -f .gitattributes

And if this is mostly to work around the chicken-and-egg problem
of the initial checkout, I do not know if we would want to
complicate checkout_all() nor prepare_attr_stack().  Perhaps the
_initial_ checkout can do something like:

 * look at index, checkout .gitattributes and */.gitattributes;
 * checkout -f -a

_at the Porcelain level_, without complicating the plumbing?

Both patches are seriously out of existing coding style, by the
way.  Extra spaces after called function names everywhere, etc.
