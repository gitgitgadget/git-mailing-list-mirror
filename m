From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 5/5] archive-zip: stream large blobs into zip file
Date: Tue, 01 May 2012 00:54:01 +0200
Message-ID: <4F9F1809.1060803@lsrfire.ath.cx>
References: <1335761837-12482-1-git-send-email-pclouds@gmail.com> <1335761837-12482-6-git-send-email-pclouds@gmail.com> <7vipghf2z0.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 01 00:54:10 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SOzTt-0005Xf-Pu
	for gcvg-git-2@plane.gmane.org; Tue, 01 May 2012 00:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757189Ab2D3WyE convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 30 Apr 2012 18:54:04 -0400
Received: from india601.server4you.de ([85.25.151.105]:57811 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757033Ab2D3WyD (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Apr 2012 18:54:03 -0400
Received: from [192.168.2.105] (p4FFDA315.dip.t-dialin.net [79.253.163.21])
	by india601.server4you.de (Postfix) with ESMTPSA id 7E7FE2F805D;
	Tue,  1 May 2012 00:54:01 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120420 Thunderbird/12.0
In-Reply-To: <7vipghf2z0.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/196624>

Am 30.04.2012 21:12, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy<pclouds@gmail.com>  writes:
>
>> A large blob will be read twice. One for calculating crc32, one for
>> actual writing.
>
> Is that because you need the checksum before the payload?  That is
> unfortunate.  It would be nice (read: not a rejection of this patch--=
-it
> is a good first step to do it stupid but correct way before trying to
> optimize it) to avoid it when the output is seekable, especially beca=
use
> we are talking about a *large* payload.

The ZIP format optionally allows writing the CRC and the sizes after th=
e=20
data.  This adds a data descriptor with a size of 16 bytes to each=20
streamed entry.  Seeking back and correcting these values in an output=20
file would avoid that.

>> diff --git a/t/t1050-large.sh b/t/t1050-large.sh
>> index fe47554..458fdde 100755
>> --- a/t/t1050-large.sh
>> +++ b/t/t1050-large.sh
>> @@ -138,4 +138,8 @@ test_expect_success 'tar achiving' '
>>   	git archive --format=3Dtar HEAD>/dev/null
>>   '
>>
>> +test_expect_success 'zip achiving' '
>> +	git archive --format=3Dzip HEAD>/dev/null
>> +'
>
> Can't we do better than "we only check if it finishes without barfing=
; we
> cannot afford to check the correctness of the output"?  The same comm=
ent
> applies to all the tests you added to this file in the past 3 months.

Streaming to tar can be tested by setting core.big_file_threshold big=20
enough, creating a non-streamed version of the archive and comparing it=
=20
to the streamed one.  With the seek trick, this would work for ZIP as=20
well.  For streaming with an added data descriptor we'd need to actuall=
y=20
unpack the ZIP file, though.

Ren=C3=A9
