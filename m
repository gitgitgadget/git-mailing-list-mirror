From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/3] read-cache: plug a few leaks
Date: Thu, 30 May 2013 22:40:43 -0500
Message-ID: <CAMP44s06DCaR2GF9yV5h9-d4tF43kjgbk2WyCqB8ZYCDYkETfQ@mail.gmail.com>
References: <1369920861-30030-1-git-send-email-felipe.contreras@gmail.com>
	<1369920861-30030-2-git-send-email-felipe.contreras@gmail.com>
	<51A76C8E.1080009@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, Adam Spiers <git@adamspiers.org>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Stephen Boyd <sboyd@codeaurora.org>
To: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Fri May 31 05:41:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiGD9-0002Uj-6l
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 05:41:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752520Ab3EaDkr convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 30 May 2013 23:40:47 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:48596 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751800Ab3EaDkp convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 30 May 2013 23:40:45 -0400
Received: by mail-la0-f45.google.com with SMTP id fr10so966338lab.18
        for <git@vger.kernel.org>; Thu, 30 May 2013 20:40:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=9Atn2T1O072TUaemxnrnCnX7xxjykIQxWtT+9IxcD3E=;
        b=OqRacRy8YYI3yovKwpBMqJ9AoE6XokUQOChykYG9KvnKTNgALrXlA9Z7NCk89R+NSn
         jwYtbNxsraSXs63jwZv+SzzNUDhlb6mijF+QMyE//xtQbOWZPltB1KN0LQnUNVp+/BGY
         fX1bBCjPx5LwNktjuDHPIWrvuMdy3Nqj4/Mnr6tbEuBA6Yz0Icud3n7O8luJs/YFmCfj
         qdZ0mq8UgUXy6uHNj5IL+JyCSFvXp0ZYebJI4b5zRVUel1RMv4NxGVb88zNNCU6dPwgD
         q08OBfCWFOenmNDFzTWRs5va5658j6XQTEfpdFcNPVZlOtaGD3Aircnc9MdJnbSbdMAR
         DLiQ==
X-Received: by 10.112.88.166 with SMTP id bh6mr5151089lbb.47.1369971643563;
 Thu, 30 May 2013 20:40:43 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Thu, 30 May 2013 20:40:43 -0700 (PDT)
In-Reply-To: <51A76C8E.1080009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226045>

On Thu, May 30, 2013 at 10:13 AM, Ren=C3=A9 Scharfe
<rene.scharfe@lsrfire.ath.cx> wrote:
> Am 30.05.2013 15:34, schrieb Felipe Contreras:
>> We don't free 'istate->cache' properly.
>>
>> Apparently 'initialized' doesn't really mean initialized, but loaded=
, or
>> rather 'not-empty', and the cache can be used even if it's not
>> 'initialized', so we can't rely on this variable to keep track of th=
e
>> 'istate->cache'.
>>
>> So assume it always has data, and free it before overwriting it.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>>   read-cache.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/read-cache.c b/read-cache.c
>> index 04ed561..e5dc96f 100644
>> --- a/read-cache.c
>> +++ b/read-cache.c
>> @@ -1449,6 +1449,7 @@ int read_index_from(struct index_state *istate=
, const char *path)
>>       istate->version =3D ntohl(hdr->hdr_version);
>>       istate->cache_nr =3D ntohl(hdr->hdr_entries);
>>       istate->cache_alloc =3D alloc_nr(istate->cache_nr);
>> +     free(istate->cache);
>
> With that change, callers of read_index_from need to set ->cache to
> NULL for uninitialized (on-stack) index_state variables.  They only h=
ad
> to set ->initialized to 0 before in that situation.  It this chunk sa=
fe
> for all existing callers?  Shouldn't the same free in discard_index
> (added below) be enough?

We can remove that line, but then if some code does this:

discard_cache();
# add entries
read_cache();

There will be a memory leak.

--=20
=46elipe Contreras
