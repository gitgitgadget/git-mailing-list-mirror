From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 4/5] archive-tar: stream large blobs to tar file
Date: Tue, 01 May 2012 00:12:00 +0200
Message-ID: <4F9F0E30.70403@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-5-git-send-email-pclouds@gmail.com> <4F9EFF39.4010804@lsrfire.ath.cx> <7vhaw0ewb8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:12:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOypF-0006EP-9b
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:12:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756991Ab2D3WMD convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 18:12:03 -0400
Received: from india601.server4you.de ([85.25.151.105]:57796 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756924Ab2D3WMD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:12:03 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id E04E82F805D;
	Tue,  1 May 2012 00:12:00 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <7vhaw0ewb8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196617>

Am 30.04.2012 23:36, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>
>>> +static int stream_blob_to_file(const unsigned char *sha1)
>>> +{
>>> +	struct git_istream *st;
>>> +	enum object_type type;
>>> +	unsigned long sz;
>>> +
>>> +	st =3D open_istream(sha1,&type,&sz, NULL);
>>> +	if (!st)
>>> +		return error("cannot stream blob %s", sha1_to_hex(sha1));
>>> +	for (;;) {
>>> +		char buf[BLOCKSIZE];
>>> +		ssize_t readlen;
>>> +
>>> +		readlen =3D read_istream(st, buf, sizeof(buf));
>>> +
>>> +		if (readlen<=3D 0)
>>> +			return readlen;
>>> +		write_blocked(buf, readlen);
>>> +	}
>>> +	close_istream(st);
>>> +	return 0;
>>> +}
>>
>> The stream is never closed.  Perhaps squash this in?
>>
>> diff --git a/archive-tar.c b/archive-tar.c
>> index 506c8cb..6109fd3 100644
>> --- a/archive-tar.c
>> +++ b/archive-tar.c
>> @@ -66,6 +66,7 @@ static void write_blocked(const void *data, unsign=
ed long size)
>>   static int stream_blob_to_file(const unsigned char *sha1)
>>   {
>>   	struct git_istream *st;
>> +	ssize_t readlen;
>>   	enum object_type type;
>>   	unsigned long sz;
>>
>> @@ -74,16 +75,15 @@ static int stream_blob_to_file(const unsigned ch=
ar *sha1)
>>   		return error("cannot stream blob %s", sha1_to_hex(sha1));
>>   	for (;;) {
>>   		char buf[BLOCKSIZE];
>> -		ssize_t readlen;
>>
>>   		readlen =3D read_istream(st, buf, sizeof(buf));
>>
>>   		if (readlen<=3D 0)
>> -			return readlen;
>> +			break;
>>   		write_blocked(buf, readlen);
>>   	}
>>   	close_istream(st);
>> -	return 0;
>> +	return readlen;
>>   }
>
> Your patch on top obviouly is the right thing to do, but reading the =
code
> again, I am not sure if the original is correct.  read_istream() itse=
lf
> does not promise that it will always fill the buffer before returning=
 (it
> could return with a short read).  It seems incorrect that the caller =
does
> not loop to avoid padding a short read with padding by calling
> write_blocked().

Yes, indeed, good catch.  It could also write to block directly and=20
avoid copying the buffer again.  The tail clearing part of=20
write_blocked() can certainly be reused, but the rest will probably hav=
e=20
to be reimplemented around read_istream().

Ren=C3=A9
