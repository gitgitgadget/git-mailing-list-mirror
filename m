From: Hitoshi Mitake <mitake@dcl.info.waseda.ac.jp>
Subject: Re: [PATCH v2 2/2] git-imap-send: Convert LF to CRLF before storing
 patch to draft box
Date: Fri, 12 Feb 2010 20:24:59 +0900
Message-ID: <4B753A8B.1090802@dcl.info.waseda.ac.jp>
References: <1265717345-2118-1-git-send-email-mitake@dcl.info.waseda.ac.jp> <1265899135-11488-2-git-send-email-mitake@dcl.info.waseda.ac.jp> <7viqa31otz.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Erik Faye-Lund <kusmabite@googlemail.com>,
	Jakub Narebski <jnareb@gmail.com>,
	Linus Torvalds <torvalds@linux-foundation.org>,
	Jeff King <peff@peff.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 12 12:26:28 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NftfH-0001P6-EK
	for gcvg-git-2@lo.gmane.org; Fri, 12 Feb 2010 12:26:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755083Ab0BLL0X convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 12 Feb 2010 06:26:23 -0500
Received: from ns.dcl.info.waseda.ac.jp ([133.9.216.194]:58057 "EHLO
	ns.dcl.info.waseda.ac.jp" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754757Ab0BLL0W (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 12 Feb 2010 06:26:22 -0500
Received: from localhost (localhost [127.0.0.1])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 665F8EBB473;
	Fri, 12 Feb 2010 20:26:21 +0900 (JST)
X-Virus-Scanned: amavisd-new at dcl.info.waseda.ac.jp
Received: from ns.dcl.info.waseda.ac.jp ([127.0.0.1])
	by localhost (ns.dcl.info.waseda.ac.jp [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id wNdL0bm6cNWh; Fri, 12 Feb 2010 20:26:21 +0900 (JST)
Received: from [192.168.10.21] (fw-cisco.dcl.info.waseda.ac.jp [133.9.216.204])
	by ns.dcl.info.waseda.ac.jp (Postfix) with ESMTP id 0F66CEBB470;
	Fri, 12 Feb 2010 20:26:21 +0900 (JST)
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.5) Gecko/20091211 Shredder/3.0
In-Reply-To: <7viqa31otz.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/139685>

On 2010=E5=B9=B402=E6=9C=8812=E6=97=A5 05:48, Junio C Hamano wrote:
> Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>  writes:
>
>> According to RFC of IMAP, all messages must not have "bare newlines =
('\n')".
>> '\n' should be converted to "\r\n" before storing messages to IMAP's=
 mailbox.
>> This patch implements the converting function to git-imap-send.
>>
>> Cc: Erik Faye-Lund<kusmabite@googlemail.com>
>> Cc: Jakub Narebski<jnareb@gmail.com>
>> Cc: Linus Torvalds<torvalds@linux-foundation.org>
>> Cc: Jeff King<peff@peff.org>
>> Signed-off-by: Hitoshi Mitake<mitake@dcl.info.waseda.ac.jp>
>> ---
>>   imap-send.c |   25 +++++++++++++++++++++++++
>>   1 files changed, 25 insertions(+), 0 deletions(-)
>>
>> diff --git a/imap-send.c b/imap-send.c
>> index dcd8a2a..dbc72ca 100644
>> --- a/imap-send.c
>> +++ b/imap-send.c
>> @@ -1279,6 +1279,30 @@ static int imap_make_flags(int flags, char *b=
uf)
>>   	return d;
>>   }
>>
>> +static void lf_to_crlf(struct msg_data *msg)
>> +{
>> +	char *new;
>> +	int i, j, lfnum =3D 0;
>> +
>> +	for (i =3D 0; i<  msg->len; i++) {
>> +		if (msg->data[i] =3D=3D '\n')
>> +			lfnum++;
>> +	}
>> +	new =3D xcalloc(msg->len + lfnum, sizeof(char));
>> +	for (i =3D 0, j =3D 0; i<  msg->len; i++) {
>> +		if (msg->data[i] !=3D '\n') {
>> +			new[j++] =3D msg->data[i];
>> +			continue;
>> +		}
>> +		new[j++] =3D '\r';
>> +		new[j++] =3D '\n';
>> +	}
>> +	msg->len +=3D lfnum;
>> +	free(msg->data);
>> +	msg->data =3D new;
>> +	msg->crlf =3D 1;
>> +}
>
> Thanks.
>
> Two questions:
>
>   - "msg->crlf" -- what is it used for?  Do we need to maintain it?

This is old legacy from isync, and has no meaning now.
I removed it, thanks.

>
>   - Can the incoming payload already be CRLF terminated?  If so, do w=
e want
>     to convert it into CRCRLF?
>

I didn't thought about the case.
I rewrote lf_to_crlf() for such case.

Thanks for your review.
