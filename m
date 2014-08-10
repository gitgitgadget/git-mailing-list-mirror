From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] remote.c: don't leak the base branch name in format_tracking_info
Date: Sun, 10 Aug 2014 16:03:32 -0700
Message-ID: <xmqq7g2g7xrv.fsf@gitster.dls.corp.google.com>
References: <1407679076-20300-1-git-send-email-stefanbeller@gmail.com>
	<53E78C59.2010704@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Stefan Beller <stefanbeller@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 11 01:07:20 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGcCq-0000OS-0v
	for gcvg-git-2@plane.gmane.org; Mon, 11 Aug 2014 01:07:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751541AbaHJXDm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Aug 2014 19:03:42 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54289 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751173AbaHJXDl convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Aug 2014 19:03:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 38807314DC;
	Sun, 10 Aug 2014 19:03:41 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=hZueak1RC6NJ
	J52pXTsERJBzLbw=; b=iSWsU336ADyi+8/pMXDnEpf7sUywI7hLqJZWuymK3aRn
	fG4iwsG/U/QrTZmKf2A7BY8cHugCKE0jKrSxe4MF7mV+V8J+10CA5/1TL54bzGmC
	TgwuqxjWU+G+eHmWz0p4RT5izzJod2J4MG0a7dxz1vkj+JNmuD1OqGKrovHpwrE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=MuQMLW
	GJstDZR0umhf6y1n1tCu78VcOfz11Sca/5qqztGjOAYIpcVdnZtyLZlfny6+QYvO
	FULwsE6kxRwvtiq3OtzjjcpM6wMlutUyohrLN5QlLS4zufixxSk6CwmPKBjs5+RC
	8y5RTAZb0MshqDTHpNOtITTIWS44jFpZ9sYV4=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2FC9E314DA;
	Sun, 10 Aug 2014 19:03:41 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id C2788314CB;
	Sun, 10 Aug 2014 19:03:33 -0400 (EDT)
In-Reply-To: <53E78C59.2010704@gmail.com> (Stefan Beller's message of "Sun, 10
	Aug 2014 17:14:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 8D95E428-20E2-11E4-8083-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255112>

Stefan Beller <stefanbeller@gmail.com> writes:

> On 10.08.2014 15:57, Stefan Beller wrote:
>> Found by scan.coverity.com (Id: 1127809)
>>=20
>> Signed-off-by: Stefan Beller <stefanbeller@gmail.com>
>> ---
>>  remote.c | 1 +
>>  1 file changed, 1 insertion(+)
>>=20
>> diff --git a/remote.c b/remote.c
>> index 3d6c86a..2c1458f 100644
>> --- a/remote.c
>> +++ b/remote.c
>> @@ -1983,6 +1983,7 @@ int format_tracking_info(struct branch *branch=
, struct strbuf *sb)
>>  			strbuf_addf(sb,
>>  				_("  (use \"git pull\" to merge the remote branch into yours)\n=
"));
>>  	}
>> +	free(base);
>>  	return 1;
>>  }
>> =20
>>=20
>
> Upon testing this one again, I get a warning
> remote.c: In function =E2=80=98format_tracking_info=E2=80=99:
> remote.c:1986:2: warning: passing argument 1 of =E2=80=98free=E2=80=99=
 discards =E2=80=98const=E2=80=99 qualifier from pointer target type [e=
nabled by default]
>   free(base);
>   ^
> ...
> Please ignore this patch.

It is perfectly fine to cast it to (char *) in this case, I think.

The real culprit is that the function=C3=83 reuses the same "base" (whi=
ch
is a pointer into a constant region of memory) to receive the new
copy allocated by shorten_unambiguous_ref(); the piece of memory
returned by the callee belongs to this function, and it is perfectly
fine if this function modifies the contents of it (which it doesn't
happen to do).  Storing the returned value to a variable of type
"const char *" does not absolve it from the responsibility to free
it (hence your patch).
