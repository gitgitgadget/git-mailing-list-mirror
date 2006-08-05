From: Junio C Hamano <junkio@cox.net>
Subject: Re: [RFC/PATCH] Fix "grep -w"
Date: Sat, 05 Aug 2006 14:08:28 -0700
Message-ID: <7vlkq2dh6b.fsf@assigned-by-dhcp.cox.net>
References: <7vwt9ng3t1.fsf@assigned-by-dhcp.cox.net>
	<118833cc0608051219q7e19800alc05870058973c2e@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Aug 05 23:08:36 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1G9TNr-0008UD-9f
	for gcvg-git@gmane.org; Sat, 05 Aug 2006 23:08:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161304AbWHEVIb (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 5 Aug 2006 17:08:31 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161328AbWHEVIa
	(ORCPT <rfc822;git-outgoing>); Sat, 5 Aug 2006 17:08:30 -0400
Received: from fed1rmmtao04.cox.net ([68.230.241.35]:16538 "EHLO
	fed1rmmtao04.cox.net") by vger.kernel.org with ESMTP
	id S1161304AbWHEVIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Aug 2006 17:08:30 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.5.203])
          by fed1rmmtao04.cox.net
          (InterMail vM.6.01.06.01 201-2131-130-101-20060113) with ESMTP
          id <20060805210829.ZEA6711.fed1rmmtao04.cox.net@assigned-by-dhcp.cox.net>;
          Sat, 5 Aug 2006 17:08:29 -0400
To: "Morten Welinder" <mwelinder@gmail.com>
In-Reply-To: <118833cc0608051219q7e19800alc05870058973c2e@mail.gmail.com>
	(Morten Welinder's message of "Sat, 5 Aug 2006 15:19:02 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/24936>

"Morten Welinder" <mwelinder@gmail.com> writes:

> 1. Are you sure that going to the end of the first match is correct?
> It seems to me that this will skip matches.  Say you search
> for ".*" on a line that reads
>   " xxx".

It is fine for your example, I think.  .* matches the entire
line the first time, and BOL and EOL are defined to be word
boundaries.  But you are right.  If the pattern is "x xx* x" and
the line is "x x xx x", the first round would match the first 5
bytes, we find that 6th byte 'x' makes it not a word boundary,
and redoing the match starting at 6th is a wrong thing to do.
We should find "x xx x" starting at the 3rd byte.

> 2. What about "^"?

The pattern would not match the second time anyway, so I do not
think it is such a big deal.

But there is another bug I just spotted.  git grep -w -e '^x'
matches line "xxx" (when not cheating with external grep).

> 3. What about empty matches?  That could take a while...

True.  So we would need to make sure we advance at least one.
