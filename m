From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Simplify the code and avoid an attribution.
Date: Thu, 22 Nov 2007 12:29:11 -0800
Message-ID: <7vk5oa3tyg.fsf@gitster.siamese.dyndns.org>
References: <b8bf37780711211700m1aa32006t6302f134f9c3fb7e@mail.gmail.com>
	<20071122200157.GC19675@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Andr=C3=A9?= Goddard Rosa <andre.goddard@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Thu Nov 22 21:29:38 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IvIg4-0004ti-R6
	for gcvg-git-2@gmane.org; Thu, 22 Nov 2007 21:29:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752161AbXKVU3S convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 22 Nov 2007 15:29:18 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752135AbXKVU3S
	(ORCPT <rfc822;git-outgoing>); Thu, 22 Nov 2007 15:29:18 -0500
Received: from sceptre.pobox.com ([207.106.133.20]:42674 "EHLO
	sceptre.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752113AbXKVU3R convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 22 Nov 2007 15:29:17 -0500
Received: from sceptre (localhost.localdomain [127.0.0.1])
	by sceptre.pobox.com (Postfix) with ESMTP id 2F5F22EF;
	Thu, 22 Nov 2007 15:29:39 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by sceptre.sasl.smtp.pobox.com (Postfix) with ESMTP id 8D5EB989B2;
	Thu, 22 Nov 2007 15:29:35 -0500 (EST)
In-Reply-To: <20071122200157.GC19675@glandium.org> (Mike Hommey's message of
	"Thu, 22 Nov 2007 21:01:57 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/65844>

Mike Hommey <mh@glandium.org> writes:

> On Wed, Nov 21, 2007 at 11:00:02PM -0200, Andr=C3=A9 Goddard Rosa wro=
te:
>> --- a/config.c
>> +++ b/config.c
>> @@ -447,15 +447,16 @@ int git_config_from_file(config_fn_t fn, const
>> char *filename)
>>  	int ret;
>>  	FILE *f =3D fopen(filename, "r");
>>=20
>> -	ret =3D -1;
>> -	if (f) {
>> -		config_file =3D f;
>> -		config_file_name =3D filename;
>> -		config_linenr =3D 1;
>> -		ret =3D git_parse_file(fn);
>> -		fclose(f);
>> -		config_file_name =3D NULL;
>> -	}
>> +	if (!f)
>> +		return -1;
>> +
>> +	config_file =3D f;
>> +	config_file_name =3D filename;
>> +	config_linenr =3D 1;
>> +	ret =3D git_parse_file(fn);
>> +	fclose(f);
>> +	config_file_name =3D NULL;
>> +
>>  	return ret;
>>  }
>
> Actually, since it is more likely that the file has been opened, the
> original code is more optimal because it doesn't generate a jump in m=
ost
> cases. And if you're worried about the ret variable, don't worry, it'=
s
> most likely stripped out by the compiler optimizations.

I did not comment on this patch partly because I did not know
what "attribution" meant.  I think it is a good change from
readability, not micro-optimization, point of view.

If you structure your code this way,

	do this
        if (there is an error)
        	return error code;
	do that
	do the rest

it is much easier to read than

	do this
        set error code pessimistically
        if (it was successful) {
        	do that
                update error code
                do the rest
	}
        return error code

especially the more likely part that runs the real processing
("do that...do the rest") tends to grow over time, and even
acquire other error checks.
