From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Add rm to submodule command.
Date: Sun, 04 Nov 2012 15:29:02 +0100
Message-ID: <50967BAE.4030102@web.de>
References: <1351877171-3176-1-git-send-email-lindenle@gmail.com> <20121104134324.GA31623@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Alex Linden Levy <lindenle@gmail.com>, gitster@pobox.com,
	git@vger.kernel.org, Heiko Voigt <hvoigt@hvoigt.net>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sun Nov 04 15:30:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TV1D5-0003vD-Q1
	for gcvg-git-2@plane.gmane.org; Sun, 04 Nov 2012 15:30:00 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754274Ab2KDO3V (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 4 Nov 2012 09:29:21 -0500
Received: from mout.web.de ([212.227.15.4]:59149 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754092Ab2KDO3V (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 4 Nov 2012 09:29:21 -0500
Received: from [192.168.178.41] ([91.3.190.38]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0Lw0uH-1TJCni1RVN-018FWC; Sun, 04 Nov 2012 15:29:03 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:16.0) Gecko/20121026 Thunderbird/16.0.2
In-Reply-To: <20121104134324.GA31623@sigill.intra.peff.net>
X-Enigmail-Version: 1.4.5
X-Provags-ID: V02:K0:BJ9KjR4Eq4oIqSe3hX3KPKvAhRdGoZCiVnU3Vm8lBeP
 AV+wGSS2SX00vdJ/gwXnzOG3LbOZVmm9KcKigpuxZk3cahn3KK
 Ed/Jg0J5jkzMQlUYOuB6rYG8YYRvb9T5Vo7/I1RCyA2WjEdWGB
 ryYn4CMWHjpiLeF0OC2UnjqLSbuBkL5wVNBj1hlSeIXOgoT+iQ
 L6IFC7WQr5OonJYMlJPOQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209030>

Am 04.11.2012 14:43, schrieb Jeff King:
> On Fri, Nov 02, 2012 at 10:26:11AM -0700, Alex Linden Levy wrote:
> 
>> This change removes the config entries in .gitmodules and adds it.
>> ---
> 
> Signoff?
> 
>>  git-submodule.sh | 62 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
>>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> No documentation or tests?
> 
>> diff --git a/git-submodule.sh b/git-submodule.sh
>> index ab6b110..29d950f 100755
>> --- a/git-submodule.sh
>> +++ b/git-submodule.sh
> 
> I'd defer to submodule experts on whether the steps to 'rm' the
> submodule make sense. Jens?

Hmm, this change adds the --quiet and --branch options to rm
which aren't used (and at least --branch makes no sense to me
here). Remainders of copy & paste? It also only affects the
.gitmodules setting and leaves the submodules work tree alone,
while I think it should - at least optionally - remove the work
tree just like "git rm" removes files too (of course only if
there is no .git directory found in it and no modifications are
present, as that would possibly lose data).

Me also thinks such a command should use my recent rm submodule
work to remove the work tree (found in your current master and
Junio's next branch), which does all necessary checks before it
removes the work tree together with the index entry. This could
be tweaked via a --cached option or such if the user wants to
keep the work tree.

But apart from those issues I'm not convinced that adding a
"git submodule rm" command is the best option. While working on
teaching "git mv" to move submodules I came to the conclusion
that it might be a better solution to let "git rm" remove the
submodule entry from the .gitmodules file itself (but of course
only if that file is found and contains such an entry, if not
it will silently do nothing to not disturb submodule users who
don't have a .gitmodules file and are using plain gitlinks).

The reason is that git core commands like status, diff and
fetch already use the path -> name mapping found in .gitmodules
and will behave strange when this is out of sync with the work
tree. So I strongly believe that doing a "git mv" should change
the path -> name mapping in .gitmodules too while moving the
submodule's work tree and updating the index (of course again
only if .gitmodules is found and contains such an entry, if not
it'll just move the work tree and update the index). Then we
won't need a new "git submodule mv" command as everything is
done inside the mv command. And for consistency I think "git rm"
should also remove the path -> name mapping (even though that is
not required for a rm to do its job, as no one will use that
setting later when the submodule is gone from the index). Then
we won't need a new "git submodule rm" at all.

Does that make sense?
