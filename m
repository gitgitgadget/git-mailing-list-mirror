From: Junio C Hamano <gitster@pobox.com>
Subject: Re* [PATCH] Improvements to git-archive tests and add_submodule_odb()
Date: Tue, 03 Dec 2013 10:39:36 -0800
Message-ID: <xmqqpppdok2f.fsf_-_@gitster.dls.corp.google.com>
References: <C74C17E7-0780-4FE1-B916-D1A444F3B592@mac.com>
	<6D370472-81BB-4249-9ADA-1C906C26D88F@mac.com>
	<20131203181807.GA4629@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Nick Townsend <nick.townsend@mac.com>, git@vger.kernel.org,
	=?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Dec 03 19:39:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vnusq-0007Xx-NA
	for gcvg-git-2@plane.gmane.org; Tue, 03 Dec 2013 19:39:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754384Ab3LCSjk convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 3 Dec 2013 13:39:40 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:45248 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753856Ab3LCSjj convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 3 Dec 2013 13:39:39 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3BF4055B3E;
	Tue,  3 Dec 2013 13:39:39 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=CuHTOn5bPcER
	18Tb1+SIvNnUnoU=; b=wnro/O1NkJmTv1/mYftoFuaorRflGATDVN966Gqkp6hC
	YlJO4rxerTbHbWSWcJISFO39Izvwmiq7QILDWGBFeWLSIrbpS1Gih2IJJul5WLOm
	CC5oPKfo2SrBRzM2F5mjFfI0ByZV670DBzEtEYvJAbGDD4wNdhjdaMtfmyX4QlY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=e2i8mI
	hZw3IBzw0UBbXCsXv+llzMmj4LjRgpbTW8GPi7dUBRqpj+RxkXYACSfY0zhVFIwq
	Klp/bfkE9jjYlst64vO2IRAye4L4pAnGo1k2gCj6PegoeNIpveqbc1NpDvHKoft5
	Y7PJAZUJg8QLX49CuTPgd2qBccSjVYON268bo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2D52055B3D;
	Tue,  3 Dec 2013 13:39:39 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6D8E655B3C;
	Tue,  3 Dec 2013 13:39:38 -0500 (EST)
In-Reply-To: <20131203181807.GA4629@sandbox-ub> (Heiko Voigt's message of
	"Tue, 3 Dec 2013 19:18:07 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 43B5EF90-5C4A-11E3-A432-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238711>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> On Mon, Dec 02, 2013 at 04:14:37PM -0800, Nick Townsend wrote:
>> diff --git a/submodule.c b/submodule.c
>> index 1905d75..1ea46be 100644
>> --- a/submodule.c
>> +++ b/submodule.c
>> @@ -143,7 +143,7 @@ void stage_updated_gitmodules(void)
>>  		die(_("staging updated .gitmodules failed"));
>>  }
>> =20
>> -static int add_submodule_odb(const char *path)
>> +int add_submodule_odb(const char *path)
>
> I am not against making add_submodule_odb() usable from outside
> submodule.c but I would prefer if this change goes along with some co=
de
> actually using it. The reason being that when refactoring or extendin=
g
> you immediately know that a function is file local only with the stat=
ic
> keyword. Without anyone using this function from outside submodule.c
> this fact is still true and so the code should say, IMO.
>
> Its not a big deal to postpone removing this keyword in a later commi=
t
> so I would like to drop this change from the patch. The documentation
> fix is fine with me.

OK, thanks, then let's do this.

-- >8 --
=46rom: Nick Townsend <nick.townsend@mac.com>
Date: Mon, 25 Nov 2013 15:31:09 -0800
Subject: [PATCH] ref-iteration doc: add_submodule_odb() returns 0 for s=
uccess

The usage sample of add_submodule_odb() function in the Submodules
section expects non-zero return value for success, but the function
actually reports success with zero.

Helped-by: Ren=C3=A9 Scharfe <l.s.r@web.de>
Reviewed-by: Heiko Voigt <hvoigt@hvoigt.net>
Signed-off-by: Nick Townsend <nick.townsend@mac.com>
---
 Documentation/technical/api-ref-iteration.txt | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/technical/api-ref-iteration.txt b/Documentat=
ion/technical/api-ref-iteration.txt
index aa1c50f..02adfd4 100644
--- a/Documentation/technical/api-ref-iteration.txt
+++ b/Documentation/technical/api-ref-iteration.txt
@@ -50,10 +50,10 @@ submodules object database. You can do this by a co=
de-snippet like
 this:
=20
 	const char *path =3D "path/to/submodule"
-	if (!add_submodule_odb(path))
+	if (add_submodule_odb(path))
 		die("Error submodule '%s' not populated.", path);
=20
-`add_submodule_odb()` will return an non-zero value on success. If you
+`add_submodule_odb()` will return zero on success. If you
 do not do this you will get an error for each ref that it does not poi=
nt
 to a valid object.
=20
--=20
1.8.5-262-g1a2486c
