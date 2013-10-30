From: Thomas Rast <tr@thomasrast.ch>
Subject: Re: [PATCH v2 6/7] Documentation: put blame/log -L in sticked form
Date: Wed, 30 Oct 2013 19:59:50 +0100
Message-ID: <874n7ywpnd.fsf@thomasrast.ch>
References: <21f40508f83a9407986d29f002adf5ad366c8b88.1382287779.git.trast@inf.ethz.ch>
	<c41aef218951f8b0ec6a20e1dbc39712ad13afce.1383031141.git.tr@thomasrast.ch>
	<xmqqvc0fd0la.fsf@gitster.dls.corp.google.com>
	<87bo27i85i.fsf@linux-k42r.v.cablecom.net>
	<xmqqiowed6t3.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	Paul Mackerras <paulus@samba.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 30 20:00:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vbb05-0006gl-9V
	for gcvg-git-2@plane.gmane.org; Wed, 30 Oct 2013 20:00:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752014Ab3J3TAK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 30 Oct 2013 15:00:10 -0400
Received: from psi.thgersdorf.net ([176.9.98.78]:60109 "EHLO mail.psioc.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751508Ab3J3TAJ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 30 Oct 2013 15:00:09 -0400
Received: from localhost (localhost [127.0.0.1])
	by localhost.psioc.net (Postfix) with ESMTP id 061464D64C4;
	Wed, 30 Oct 2013 20:00:07 +0100 (CET)
X-Virus-Scanned: amavisd-new at psioc.net
Received: from mail.psioc.net ([127.0.0.1])
	by localhost (mail.psioc.net [127.0.0.1]) (amavisd-new, port 10024)
	with LMTP id OZ-Fko5ZULAU; Wed, 30 Oct 2013 19:59:52 +0100 (CET)
Received: from hexa.thomasrast.ch (46-126-8-85.dynamic.hispeed.ch [46.126.8.85])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(Client did not present a certificate)
	by mail.psioc.net (Postfix) with ESMTPSA id 336014D6414;
	Wed, 30 Oct 2013 19:59:51 +0100 (CET)
In-Reply-To: <xmqqiowed6t3.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 30 Oct 2013 10:09:28 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.2 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237054>

Junio C Hamano <gitster@pobox.com> writes:

> Thomas Rast <tr@thomasrast.ch> writes:
>
>> Junio C Hamano <gitster@pobox.com> writes:
>>
>>> I agree that this patch may reduce confusion locally, but if we were
>>> to go in this direction, we should be consistent and enforce "stuck"
>>> form everywhere,
>>
>> Hmm.  Do you want to go there?
>
> Absolutely not ;-)
>
> But that unpleasant place would be the logical conclusion where this
> patch leads us to, I would have to say. I was hoping that there is
> an alternative solution to avoid that.
>
> For example, gitk's parseviewargs is very well aware of the options
> it supports, and it goes through the argument list one by one,
> acting on what option it is looking at. Couldn't it be extended to
> handle options with stuck and unstuck form?  After all, it has to
> know that "-L" and "-S" are supported options; it wouldn't be too
> much to ask for the parser to also know that "-L" eats the next
> token (i.e. pass the pair <"-L", next token> intact as two separate
> args to the underlying "log") while it can pass "-L?*" as is, no?

It's not quite that easy because gitk does two-stage processing, and the
big switch you are discussing here is only the second one.  The first
one is git-rev-parse, and while it happens to know about '-n 1', it does
not recognize any other unstuck option arguments.  (I haven't stared too
long, but I think git-rev-parse is important to distinguish revisions
from paths.)

I actually burned some train time today looking into this, and the
situation is much worse than I thought.  There is absolutely no
consistency in any dimension:

a) many commands use parse_options internally, where mandatory args can
   be stuck or unstuck, but optional args must be stuck

   a1) git branch --{contains,merged,no-merged} take a mandatory arg,
       except if they are last on the command line, in which case the
       option reverts to the default (HEAD).  Effectively this means the
       argument is half-optional but the spelling seen in the wild is
       usually unstuck.

   a2) git-rev-parse (at least) still handrolls its parsing, so no
       --default=HEAD

   a3) git-commit-tree does not understand any of its short options in
       stuck form (!)

b) the perl scripts mostly seem to be using Getopt::Long which handles
   things similarly, though I can't quote chapter&verse

   b1) just to prove a point: git-add--interactive.  I'm sure there's a
       user-facing exception somewhere too...

c) shell scripts mostly go through git-sh-setup, using parseopt
   internally

   c1) git-filter-branch

d) gitk doesn't do *un*stuck as explained above

On top of that, documentation is a wild mash of styles, sometimes even
in the same manpage.  For example, git-describe(1) tells the poor user
about --candidates=<n> and four paragraphs further down about --match
<pattern>.

So my short-term plan just became: document instead of fix; clean up
manpages towards the stuck form for long options; have gitk only parse
-Lstuck.

Medium term we can move gitk to a different option parser, resolving at
least that inconsistency.

Longer term we can see about moving some more of the remaining craziness
towards parseopt, getting consistency for free.

-- 
Thomas Rast
tr@thomasrast.ch
