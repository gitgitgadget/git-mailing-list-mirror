From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gitweb: Better chopping in commit search results
Date: Fri, 22 Feb 2008 09:14:36 -0800
Message-ID: <7voda8ap6r.fsf@gitster.siamese.dyndns.org>
References: <7vbq6kprql.fsf@gitster.siamese.dyndns.org>
 <20080222163035.5942.93410.stgit@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jean-Baptiste Quenot <jbq@caraldi.com>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 22 18:15:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JSbUd-0002Qd-Bq
	for gcvg-git-2@gmane.org; Fri, 22 Feb 2008 18:15:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755150AbYBVROv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2008 12:14:51 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752447AbYBVROv
	(ORCPT <rfc822;git-outgoing>); Fri, 22 Feb 2008 12:14:51 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58283 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754011AbYBVROu (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2008 12:14:50 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 7484C463D;
	Fri, 22 Feb 2008 12:14:48 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 68839463C; Fri, 22 Feb 2008 12:14:43 -0500 (EST)
In-Reply-To: <20080222163035.5942.93410.stgit@localhost.localdomain> (Jakub
 Narebski's message of "Fri, 22 Feb 2008 17:33:47 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/74736>

Jakub Narebski <jnareb@gmail.com> writes:

> From: Junio C Hamano <gitster@pobox.com>
> Subject: [PATCH] gitweb: Better chopping in commit search results
>
> When searching commit messages (commit search), if matched string is
> too long, the generated HTML was munged leading to an ill-formed XHTML
> document.
>
> Now gitweb chop leading, trailing and matched parts, HTML escapes
> those parts, then composes and marks up match info.  HTML output is
> never chopped.  Limiting matched info to 80 columns (with slop) is now
> done by dividing remaining characters after chopping match equally to
> leading and trailing part, not by chopping composed and HTML marked
> output.

Could somebody test this with very long search string, as that
was how the issue initially came up, to see (1) if it really
fixes the "mark-up chopped in the middle" issue, (2) and how the
actual output looks like?

Regarding the latter, I have a slight suspicion that chopping
the tail of the middle part and showing very little context may
not produce a very useful output.

For example, if you are looking for "very long ... and how"
in the first paragraph of message (if it were all on a single
line), wouldn't you want to see:

    ...st this with <<very long ... and how>> the actual out...

rather than:

    Could som... <<very long search stri...>> the actual out...

in the result?

That is, it any chopping ever needs to happen, I suspect a more
useful way to shorten the output would be to:

 - divide the available space to give enough space to give
   context for head and tail part.

 - chop head from the left, if needed, with leading ellipsis;

 - chop tail from the right, if needed, with trailing ellipsis;

 - chop search string from both ends, if needed, with leading
   and trailing ellipses.

Hmm?
