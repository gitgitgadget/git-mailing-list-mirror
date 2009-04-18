From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] builtin-apply: keep information about files to be
 deleted
Date: Sat, 18 Apr 2009 15:05:38 -0700
Message-ID: <7viql1ty6l.fsf@gitster.siamese.dyndns.org>
References: <1239478260-7420-1-git-send-email-michal.kiedrowicz@gmail.com>
 <7v4owsfktw.fsf@gitster.siamese.dyndns.org>
 <20090413230351.7cbb01f5@gmail.com>
 <7v1vrwdyxx.fsf@gitster.siamese.dyndns.org>
 <20090417192324.3a888abf@gmail.com>
 <7vskk6y2tl.fsf@gitster.siamese.dyndns.org>
 <20090418225847.54862bdf@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?Q?Micha=C5=82?= Kiedrowicz <michal.kiedrowicz@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 19 00:08:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LvIhf-0006kv-Dr
	for gcvg-git-2@gmane.org; Sun, 19 Apr 2009 00:08:04 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753427AbZDRWFq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Apr 2009 18:05:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752470AbZDRWFp
	(ORCPT <rfc822;git-outgoing>); Sat, 18 Apr 2009 18:05:45 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:46384 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752006AbZDRWFp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Apr 2009 18:05:45 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 544D7F0C3;
	Sat, 18 Apr 2009 18:05:43 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 39080F0C2; Sat,
 18 Apr 2009 18:05:40 -0400 (EDT)
In-Reply-To: <20090418225847.54862bdf@gmail.com> (=?utf-8?Q?Micha=C5=82?=
 Kiedrowicz's message of "Sat, 18 Apr 2009 22:58:47 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0F9FC8DA-2C65-11DE-8057-DC76898A30C1-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116870>

Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>
>> Micha=C5=82 Kiedrowicz <michal.kiedrowicz@gmail.com> writes:
>>  =20
>>> ... However, there are some cases when these two
>>> rules may cause problems:
>>>
>>> patch #1: rename A to B
>>> patch #2: rename C to A
>>> patch #3: modify A
>>>
>>> Should patch #3 modify B (which was A) or A (which was C)?
>>>
>>> patch #1: rename A to B
>>> patch #2: rename B to A
>>> patch #3: modify A
>>> patch #4: modify B
>>>
>>> Which files should be patched by #3 and #4?
>>>
>>> In my opinion both #3 and #4 should fail (or both should succeed) -=
-
>>> with my patch only #3 will work and #4 will be rejected, because in
>>> #2 B was marked as deleted. =20
>>=20
>> Both of the examples above cannot be emitted as a single commit by
>> format-patch; the user is feeding a combined patch.  Perhaps renames
>> in each example sequence were came from one git commit but
>> modifications are from separate commit or handcrafted "follow-up"
>> patch.
>
> Yes, that's true. In "normal" case, renames and modifications should =
be
> handled properly and (generally) aren't subject of this discussion.
>
>>
>> There are two stances we can take:
>>=20
>>  (1) The user knows what he is doing.
>>=20
>>      In the first example, if he wanted the change in #3 to end up i=
n
>> B, he would have arranged the patches in a different order, namely, =
3
>> 1 2, but he didn't.  We should modify A (that came from C).
>>=20
>>  (2) In situations like these when it is unusual and there is no
>> clear and unambiguous answer, the rule has always been "fail and ask
>> the user to clean up", because silently doing a wrong thing in an
>> unusual situation that happens only once in a while is far worse tha=
n
>>      interrupting the user and forcing a manual intervention.
>>=20
>>      In the first example, there is no clear answer.  Perhaps all
>> three patches were independent patches (the first two obviously came
>> from git because only we can do renames, but they may have been
>> separate commits), and the user may have reordered them (or just
>> picked a random order because he was linearizing a history with a
>> merge).
>>=20
>> The second one is even iffier.  If we _know_ that originally patch #=
1
>> and #2 came from the same commit, then they represent swapping
>> between A and B, but if they came from different git commits, and if
>> the user picked patches in a random order, it may mean something
>> completely different.
>
> The problem here is that there are at least two patches which touch t=
he
> same file(s) and it is impossible to say which patches should be hand=
led
> atomically. However, there is no easy way to specify renames as a
> single patch. A diff containing swapping of three files looks like th=
is:
>
> 	diff --git a/file2 b/file1
> 	similarity index 100%
> 	rename from file2
> 	rename to file1
> 	diff --git a/file3 b/file2
> 	similarity index 100%
> 	rename from file3
> 	rename to file2
> 	diff --git a/file1 b/file3
> 	similarity index 100%
> 	rename from file1
> 	rename to file3
>
> BTW: it applies correctly :).
>
>>=20
>> I am somewhat tempted to say that we should fail all of them,
>> including the original "single patch swapping files" brought up by
>> Linus.
>
> I may agree that difficult scenarios should be rejected, but I will
> also say that git-apply should always accept git-diff output.
>
>>=20
>> BUT
>>=20
>> Can we make use simple rule to detect problematic cases?
>>=20
>>  - An input to git-apply can contain more than one patch that affect=
s
>> a path; however
>>=20
>>    - you cannot create a path that still exists, except for a path
>> that _will_ be renamed away or removed (your patch fixes this by
>> adding this "except for..." part to loosen the existing rule);
>>=20
>>    - you cannot modify a path in a separate patch if it is involved
>> in an either side of a rename (this will catch the ambiguity of patc=
h
>> #3 in your first example and #3 and #4 in your second example);
>
> What should happen in following situation:
>
> patch #1: modify A
> patch #2: rename A to B
>
> #2 should fail? Now it creates new B which is a copy of A before
> applying any patches and modifies A according to #1.

Yes.  It is obviously a handcrafted sequence, and it could even have be=
en
mechanically created.

Imagine a merge of two branches like this:

               2----HEAD
              /    /
	common----1

and somebody fed "common..HEAD" to his script that internally runs
format-patch and squashes the patch output into one, perhaps:

	#!/bin/sh
	# Create a single patch e-mail, squashed.
        tmp=3D/var/tmp/my-squash$$
	rm -rf "$tmp" && mkdir -p "$tmp/out" || exit
        trap 'rm -rf "$tmp"' 0 1 2 3 15
	git format-patch -o "$tmp/out" "$@"
	>"$tmp/all.messages"
        >"$tmp/all.patches"
        for mail in "$tmp"/out/0*
        do
        	git mailinfo "$tmp/msg" "$tmp/patch" >"$tmp/info" <"$mail"
                echo "$mail" >>.messages
                cat "$tmp/msg" >>"$tmp/all.messages"
                cat "$tmp/patch" >>"$tmp/all.patches"
	done
	(
	        cat "$tmp/info"; echo
                cat "$tmp/all.messages"; echo
	        cat "$tmp/all.patches"
	)

Depending on the sort order between #1 and #2, you cannot tell "modify =
A
and then rename it to B" is the order we will see such a patch at all. =
 I
think it is safer to reject such a patch with the "when in doubt, do no=
t
act too clever and risk making a silent mistake" principle.

In this particular case, the reverse order of "renaming A to B" and the=
n
"modifing A" would fail anyway, but if you have another patch that rena=
mes
C to A in the mix of patches whose order cannot be determined, I think =
you
can come up with a sequence that results in an "applicable in order but=
 is
the order really what the author intended?" situation.

> Do you mean that patches which break above rules should be
> skipped when "--reject" is set, as other failures? Or that
> whole git-apply should fail regardless of "--reject"?

I meant the latter.
