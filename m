From: Bert Wesarg <bert.wesarg@googlemail.com>
Subject: Re: [TopGit PATCH 1/4] provide fan-in and -out traversal interface
Date: Tue, 5 Oct 2010 09:54:48 +0200
Message-ID: <AANLkTi=wZUc0GnB8p0=3Hkd1xPsvqqdEMHn80GKsHUj6@mail.gmail.com>
References: <1286231300-29268-1-git-send-email-bert.wesarg@googlemail.com>
	<20101005071334.GF11737@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pasky@suse.cz,
	martin f krafft <madduck@madduck.net>
To: =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
	<u.kleine-koenig@pengutronix.de>
X-From: git-owner@vger.kernel.org Tue Oct 05 09:55:12 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P32Me-0004uS-LB
	for gcvg-git-2@lo.gmane.org; Tue, 05 Oct 2010 09:55:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757910Ab0JEHyu convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 5 Oct 2010 03:54:50 -0400
Received: from mail-iw0-f174.google.com ([209.85.214.174]:53507 "EHLO
	mail-iw0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757746Ab0JEHyt convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 5 Oct 2010 03:54:49 -0400
Received: by iwn5 with SMTP id 5so7993832iwn.19
        for <git@vger.kernel.org>; Tue, 05 Oct 2010 00:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=gamma;
        h=domainkey-signature:mime-version:received:received:in-reply-to
         :references:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=KZxhhWOdpOU4dHvqyOKda+UTNqS1O8WkkKwNfFta1oY=;
        b=skibqOhgbXUO6fNVQjZDe4T4Vti0PmED5CfAbYb8SmGba3hCPwvVXEgvq1PQXNIKwo
         sZmGJfKOlkpdR9WkrmvJuSguXZT9teDBDxt8cD/cKy1njBDfd3nxW5uK7N4r59oMZMEP
         nAzGVUnJY81umLviSoUDmdTWKTH4jEERVbW4o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=googlemail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=Jo15y4kkCAFsKur6Dj01NvTvwJDkEzYgCGN7rQRxH99eholnkHNmNN2CiuWTiKzhPB
         0nUbKU4WnN73DkghmXWfZq0n83w5m5ygNcqsktkb1rqJjRV5G4M7tjcAetkhfE7u7cFW
         dV+Fzo6Ays64kZWMqCMwkeuf/zWZOvTSRVdYM=
Received: by 10.231.33.12 with SMTP id f12mr11581184ibd.31.1286265288210; Tue,
 05 Oct 2010 00:54:48 -0700 (PDT)
Received: by 10.231.147.80 with HTTP; Tue, 5 Oct 2010 00:54:48 -0700 (PDT)
In-Reply-To: <20101005071334.GF11737@pengutronix.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158174>

2010/10/5 Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>:
> On Tue, Oct 05, 2010 at 12:28:17AM +0200, Bert Wesarg wrote:
>> This adds general functions to get the list of all offending branche=
s for
> Is offending the right word here? =C2=A0I don't understand that.

I'm unsure about the right wording here too. 'offending' is definitive
the wrong word here. Somethink like this may be better:

This adds general functions to get the list of all branches which
either depends on a given one (fan-in), or all dependencies of a given
one (fan-out).

>
>> a given one. Either which depends on the given branch (fan-in) or al=
l
>> dependencies (fan-out).
>>
>> Two simple users are provided which just lists the names or generate=
s dot
>> input.
> This should then be used for tg summary --graphviz, too, doesn't it?

No. tg summary --graphviz outputs the whole graph. These will generate
only a subgraph based on a given topic. tg summary does not take a
topic as argument.

>
>>
>> Signed-off-by: Bert Wesarg <bert.wesarg@googlemail.com>
>>
>> ---
>> =C2=A0tg.sh | =C2=A0170 ++++++++++++++++++++++++++++++++++++++++++++=
+++++++++++++++++++++
>> =C2=A01 files changed, 170 insertions(+), 0 deletions(-)
>>
>> diff --git a/tg.sh b/tg.sh
>> index 3718702..926b31b 100644 tg.sh
>> --- a/tg.sh
>> +++ b/tg.sh
>> @@ -351,6 +351,176 @@ setup_pager()
>> =C2=A0 =C2=A0 =C2=A0 trap "exec >&-; rm \"$_pager_fifo\"; rmdir \"$_=
pager_fifo_dir\"; wait" EXIT
>> =C2=A0}
>>
>> +# traverse_fan_out(for_each_name, for_each_dep, name, head_deps)
> This uses an unusual format.
>
> please make it
>
> # traverse_fan_out FOR_EACH_NAME FOR_EACH_DEP NAME HEAD_DEPS
>

Yes. this makes it more consistent.

>> +#
>> +# traverse the dependencies of @name in bfs order and call @for_eac=
h_name
>> +# on each dep (i.e. node) and @for_each_dep on all dependencies (i.=
e. edge)
>> +# with source and dest as arguments.
>> +#
>> +# @name' needs to be a TopGit controlled branch
>> +#
>> +# @head_deps specifies where to take the .topdeps from for the HEAD=
 branch
>> +# empty - from the committed tree
>> +# '(i)' - from the index
>> +# '(w)' - from the working dir
>> +#
>> +traverse_fan_out()
>> +{
>> + =C2=A0 =C2=A0 local for_each_name=3D$1
>> + =C2=A0 =C2=A0 local for_each_dep=3D$2
>> + =C2=A0 =C2=A0 local name=3D$3
>> + =C2=A0 =C2=A0 local head_deps=3D$4 || :
>> + =C2=A0 =C2=A0 local deps_src
>> + =C2=A0 =C2=A0 local head=3D"$(git symbolic-ref HEAD | sed 's#^refs=
/\(heads\|top-bases\)/##')" || :
> I don't remember the exact problems, but some shells get using local =
and
> assignment in a single command wrong. =C2=A0Can you please fix that u=
p? =C2=A0(I
> fixed that up for one of your commits.)

Yes, that should be the right thing to do.

Bert
