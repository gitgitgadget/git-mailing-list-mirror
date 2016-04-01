From: SZEDER =?utf-8?b?R8OhYm9y?= <szeder@ira.uka.de>
Subject: Re: [PATCH v2] clone: respect configured fetch respecs during
 initial fetch
Date: Fri, 01 Apr 2016 06:20:01 +0200
Message-ID: <20160401062001.Horde.ONOWb-Prl7DzJnJKcoFoctm@webmail.informatik.kit.edu>
References: <20160307153304.GA23010@sigill.intra.peff.net>
 <1459349623-16443-1-git-send-email-szeder@ira.uka.de>
 <xmqq1t6qr5c1.fsf@gitster.mtv.corp.google.com>
 <xmqq1t6qo4rd.fsf@gitster.mtv.corp.google.com>
 <20160331225055.Horde.1X4mNM4L4J85rAeMFQzAEH_@webmail.informatik.kit.edu>
 <xmqqbn5ul12t.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed	DelSp=Yes
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Apr 01 06:20:24 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1alqZL-0001GN-Gu
	for gcvg-git-2@plane.gmane.org; Fri, 01 Apr 2016 06:20:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751523AbcDAEUT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 1 Apr 2016 00:20:19 -0400
Received: from iramx2.ira.uni-karlsruhe.de ([141.3.10.81]:51612 "EHLO
	iramx2.ira.uni-karlsruhe.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750932AbcDAEUS convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>); Fri, 1 Apr 2016 00:20:18 -0400
Received: from irawebmail.ira.uni-karlsruhe.de ([141.3.10.230] helo=webmail.ira.uka.de)
	by iramx2.ira.uni-karlsruhe.de with esmtps port 25 
	iface 141.3.10.81 id 1alqZ5-0006B0-Fm; Fri, 01 Apr 2016 06:20:07 +0200
Received: from apache by webmail.ira.uka.de with local (Exim 4.72)
	(envelope-from <szeder@ira.uka.de>)
	id 1alqYz-0008GF-1Z; Fri, 01 Apr 2016 06:20:01 +0200
Received: from x590daaf8.dyn.telefonica.de (x590daaf8.dyn.telefonica.de
 [89.13.170.248]) by webmail.informatik.kit.edu (Horde Framework) with HTTP;
 Fri, 01 Apr 2016 06:20:01 +0200
In-Reply-To: <xmqqbn5ul12t.fsf@gitster.mtv.corp.google.com>
User-Agent: Horde Application Framework 5
Content-Disposition: inline
X-ATIS-AV: ClamAV (iramx2.ira.uni-karlsruhe.de)
X-ATIS-Timestamp: iramx2.ira.uni-karlsruhe.de 1459484407.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290505>


Quoting Junio C Hamano <gitster@pobox.com>:

> SZEDER G=C3=A1bor <szeder@ira.uka.de> writes:
>
>> Quoting Junio C Hamano <gitster@pobox.com>:
>>
>>> IOW, special casing -c remote.origin.fetch=3Dspec
>>> is a bad idea.
>>
>> I completely agree :)
>> But it's the other way around.
>>
>> 'remote.origin.fetch=3Dspec' during clone is special _now_, because =
the
>> initial fetch ignores it, no matter where it is set.
>>
>> My patch makes it non-special, so that the initial fetch respects it=
,
>> the same way it already respects 'fetch.fsckObjects' and
>> 'fsck.unpackLimit', or the way the initial checkout respects e.g.
>> 'core.eol'.
>
> ... but does "git -c core.eol clone" leave that configuration in the
> resulting repository's .git/config?  "git -c user.name=3Dfoo" for tha=
t
> matter.

No, and it shouldn't.

'git clone -c core.eol', however, should and indeed does.

> They may affect the one-shot operation but are not left in the
> resulting .git/config, which was what I was driving at.  To make
> clone behave as if it is truly a short-hand of
>
> 	git init
> 	git config ;# with default and necessary tweaks to adjust
> 		   ;# for things like -b, -o, --single-branch
>        git fetch
>        git checkout
>
> which by the way I think everybody agrees is a worth goal, then
> shouldn't the update to the current code be more like "prepare the
> default config, tweak with whatever configuration necessary, and
> re-read the config before driving the equivalent of 'git fetch'?"
>
> And the conclusion my rhetorical questions led to was that "adjust
> for things like..." should not include what comes from "-c var=3Dval"
> because there is no sensible way to incorporate them in general.
>
> The most important point is that "-c var=3Dval" is the wrong source o=
f
> information to blindly propagete to the resulting .git/config.

In case of 'git -c var=3Dval clone', I agree, but then again, 'git clon=
e
-c var=3Dval' was specifically designed to write that 'var=3Dval' to th=
e
new repository's config file.

Config variables set in the global or system-wide config files are not
written to the new repository's config file either.

> And
> the point of "--branches" option is not that it would be short and
> tidy, but it is more targetted.  With such an approach, nobody would
> imagine "git -c random.var=3Dvalue clone" would be propagated into th=
e
> resulting .git/config in a random and unspecified way.
>
> Once you learn what custom set of refs the user wants to fetch, you
> would need futzing of the refspecs like you did in your patch. That
> part of your patch is salvageable.  The part that special cased the
> information that came from "-c remote.origin.fetch" while ignoring
> others like user.name that came from exactly the same mechanism via
> "-c user.name" is not.

My patch did not special case anything and it did not change anything
with respect to what config settings are written under what
circumstances to the new repository's config file.
All that already works properly and almost all those config settings
are already taken into account when they should be by the commands in
our conceptual model of 'git clone'.  It doesn't matter at all where
and how they were specified or whether they are written to the new
repository's config file or not, almost all of them are taken into
account.

Almost all, because there is that one exception: additional fetch
refspecs are ignored during the initial fetch.

And all my patch did was to make the initial fetch aware of any
additional fetch refspecs which are configured when the initial
fetch is executed.  (and again: no matter where those refspecs were
specified and no matter whether they were written to the new config
file)


Eh, I guess I should have went for a refined version of the RFC's
commit message, rewriting it based on that conceptual modell caused
way too much confusion.
