From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: tracking submodules out of main directory.
Date: Wed, 03 Aug 2011 21:07:14 +0200
Message-ID: <4E399C62.30604@web.de>
References: <4E0A08AE.8090407@web.de> <1311792580.2413.82.camel@Naugrim.eriador.com> <1311843465.3734.40.camel@Naugrim.eriador.com> <4E3192D4.5000504@web.de> <1311932377.3734.182.camel@Naugrim.eriador.com> <4E34122B.5020509@web.de> <1312062927.3261.334.camel@Naugrim.eriador.com> <4E370107.3050002@web.de> <1312287584.3261.798.camel@Naugrim.eriador.com> <4E384510.1070803@web.de> <20110803062536.GB33203@book.hvoigt.net> <1312374382.3261.913.camel@Naugrim.eriador.com> <7v8vractdw.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: henri GEIST <henri.geist@flying-robots.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	Alexei Sholik <alcosholik@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Aug 03 21:08:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Qogo6-00011B-Vq
	for gcvg-git-2@lo.gmane.org; Wed, 03 Aug 2011 21:08:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755366Ab1HCTIi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Aug 2011 15:08:38 -0400
Received: from fmmailgate01.web.de ([217.72.192.221]:41538 "EHLO
	fmmailgate01.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754568Ab1HCTIg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Aug 2011 15:08:36 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate01.web.de (Postfix) with ESMTP id 52230194EE49C;
	Wed,  3 Aug 2011 21:07:19 +0200 (CEST)
Received: from [79.247.252.57] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Qogml-0006GN-00; Wed, 03 Aug 2011 21:07:19 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:5.0) Gecko/20110624 Thunderbird/5.0
In-Reply-To: <7v8vractdw.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+IwKOuG5Z3WC9wy+4pdP4W3EhKsB5rs+62HVAx
	5oGqd4I/x6lJKppky3dsJCsGy7ca7uDfLKALiaHbAdiSnO4fPV
	wkO3eEJ5mhfgG5G2Sjsw==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/178609>

Am 03.08.2011 19:11, schrieb Junio C Hamano:
> henri GEIST <henri.geist@flying-robots.com> writes:
> 
>> I plan to use a config file containing lines like
>>
>> "path_to_poited_repo   SHA1_of_intended_commit   URL_of_origin"
>>
>> the URL part will not be required.
>>
>> this file will be a list of pointer to other project.
> 
> I wasn't paying attention to this thread, but I have to ask "why" here.
> 
> The first two are what gitlink was designed to do in the superproject that
> ties multiple submodules together, and the last one is also supplied by
> the .gitmodules in that superproject. This seems to be adding the same
> information in a redundant way by saying "this version A0 of submodule A
> wants version B0 of submodule B and version C0 of submodule C" when the
> supermodule can say "the consistent view I record is to have version A0,
> B0 and C0 of submodules A, B and C, respectively".

During the discussion this evolved from a simple "I need that submodule
with exactly this version" to something I believe is more generic and
very useful for others. As I see it now a submodule should be able to say:

1) To use me, you need another submodule "foo"

   This is very helpful when you want to add the Gimp submodule and it
   can tell you you'll need the libpng submodule too in your superproject
   (but I'd vote to use the submodule name here, not the path as that
   should be the superproject's decision).

In addition to that, it can (but mustn't) specify any of the following:

a) Of this submodule "foo" I need at least that version because I won't
   compile/work with older versions of that. (this can be tightened to
   "exactly that version" to give henri the behavior he wants, but that
   should be policy, not mandatory)

   Gimp could say it needs at least libpng 012345 because in that version
   the function foobar() was added it now depends on. Normally this won't
   be updated very often, but if people like henri use that to say "I'll
   only promise to work well with that exact version, as that went through
   extensive QA" they might change that on virtually every commit.

b) And if you don't know where to get it, use this url

   That can give the superproject a hint where it can clone that
   repository from. That could be helpful for distributions to sort out
   the dependencies of the packages they pull in.

That is all stuff the submodule knows better than the superproject. And
that information can be used to *inform* the user about the submodule's
needs, maybe using "git status --submodule-dependencies" will print:

# submodule "Gimp" requests a libpng 567890 or newer
# submodule "foo" has missing dependency "bar"

But the user can choose to ignore that (because he knows he has the png
support disabled and he doesn't need the fancy help files from bar).

And maybe "git submodule add" learns an option to automatically add all
the other submodules the new one depends on too (for that we would need
the url).

But the superproject is still the place to say: I know these versions of
all submodules work together, so I commit their gitlinks here. But this
scheme enables submodules to give hints to help the superproject's user.

> I also suspect that allowing each submodule to know and demand specific
> versions of other submodules will lead to inconsistencies. Which version
> of submodule C would you demand to have when submodule A wants version C0
> and submodule B wants version C1 of it?

Right, in the discussion so far it seemed like henri seems to be the only
user who is wanting an exact match, and he says he needs to see these
inconsistencies. But I think he can modify the "version xxx or newer" to
his needs without imposing these inconsistencies on users (like me) who
don't want to see them.
