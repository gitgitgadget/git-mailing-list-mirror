From: Jim Meyering <jim@meyering.net>
Subject: Re: [PATCH] use xstrdup, not strdup in ll-merge.c
Date: Mon, 15 Jun 2009 11:23:55 +0200
Message-ID: <87vdmxluj8.fsf@meyering.net>
References: <87bpoqoavp.fsf@meyering.net>
	<81b0412b0906141503v14484d9fyea56198910305bfc@mail.gmail.com>
	<87fxe2lybr.fsf@meyering.net>
	<81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git list <git@vger.kernel.org>
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jun 15 11:24:15 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MG8QJ-0005LC-E0
	for gcvg-git-2@gmane.org; Mon, 15 Jun 2009 11:24:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752040AbZFOJYE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jun 2009 05:24:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751521AbZFOJYD
	(ORCPT <rfc822;git-outgoing>); Mon, 15 Jun 2009 05:24:03 -0400
Received: from smtp1-g21.free.fr ([212.27.42.1]:48576 "EHLO smtp1-g21.free.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750977AbZFOJYB convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 15 Jun 2009 05:24:01 -0400
Received: from smtp1-g21.free.fr (localhost [127.0.0.1])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 29F40940123
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 11:23:58 +0200 (CEST)
Received: from mx.meyering.net (mx.meyering.net [82.230.74.64])
	by smtp1-g21.free.fr (Postfix) with ESMTP id 443D8940145
	for <git@vger.kernel.org>; Mon, 15 Jun 2009 11:23:56 +0200 (CEST)
Received: by rho.meyering.net (Acme Bit-Twister, from userid 1000)
	id 1C1C934613; Mon, 15 Jun 2009 11:23:56 +0200 (CEST)
In-Reply-To: <81b0412b0906150145j7c717a6ar33bb4f2ebd6095e1@mail.gmail.com>
	(Alex Riesen's message of "Mon, 15 Jun 2009 10:45:22 +0200")
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121595>

Alex Riesen wrote:
> 2009/6/15 Jim Meyering <jim@meyering.net>:
>> Alex Riesen wrote:
>>> 2009/6/14 Jim Meyering <jim@meyering.net>:
>>>> @@ -231,7 +231,7 @@ static int read_merge_config(const char *var, =
const char *value, void *cb)
>>>>
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0if (!strcmp(var, "merge.default")) {
>>>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0if (value)
>>>> - =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D strdup(value);
>>>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=
=A0 =C2=A0 default_ll_merge =3D xstrdup(value);
>>>
>>> read_merge_config has a failure mode (where it returns -1), why not=
 use it?
>>
>> I didn't even consider it, because it would be inconsistent with
>> the other heap-allocation functions used there (xcalloc, xmemdupz).
>>
>> However, now that I do, it looks like that would mean adding four ti=
mes
>> the same code (including conditionals and code to generate a diagnos=
tic via
>> a call to error -- or a goto). Why bother, when all of that is alrea=
dy
>> encapsulated in xmalloc?
>
> So that a useful error message can be given in the _caller_ (it knows
> more about context)?

So you want to tell the user that we failed
to strdup the "merge.default" value?
Or the "driver" value?

Given the apparently-high cost/benefit ratio, I would not bother.  I.e.=
,
this failure is so unlikely to trigger, and when it does, knowing for w=
hich
config value strdup failed is even less likely to be useful,
that minimal diagnostics should be fine.

Of more general interest, when xstrdup fails, it might be useful to
include in the diagnostic how long the would-be-dup'd string was.  I.e.=
,
rather than saying

    die("Out of memory, strdup failed");
say
    die("Out of memory, failed to strdup a %lu-byte string",
        (unsigned long int) strlen(str));

Then, you have at least a clue as to whether the failure
is due to some ridiculously-long string value, or to some
unrelated-to-config, systemic problem.

> Otherwise the error message ("Out of memory, strdup failed") does not
> have anything about the place nor situation in it. As the situations
> when a modern system really runs out of memory are very rare,
> mostly such reports just point at some inconsistency elsewhere

Exactly.  This is why I think it's not worthwhile to invest in
a more precise diagnostic, here.

> (like bloody stupid memory management in system support libraries
> on an OS-not-to-be-named-again or the usual corruption of heap
> control structures).
>
> Besides, xstrdup does more then just allocation: it tries to free glo=
bal
> list of cached pack chunks. This does not play very well with the eff=
orts
> to make a library out of the modern Git code.

Ahh... librarification.  This is a slightly different topic.
I see existing uses of xcalloc and xmemdupz, not to
mention "error" calls, and conclude that this function is
not library caliber code, so there's no need to invest.

If you want a version of this function that is more library-friendly,
then that will be more work.  However, I think librarification should
be addressed separately from this simple patch to avoid a potential NUL=
L
dereference (and *no* diagnostic).
