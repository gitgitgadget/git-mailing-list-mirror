From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/3] read-cache: plug a few leaks
Date: Fri, 31 May 2013 03:22:33 -0500
Message-ID: <CAMP44s1PYK1efXjk8WhCpXM9g_tBf-vXbXRY4eC2tiVym+_07g@mail.gmail.com>
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
X-From: git-owner@vger.kernel.org Fri May 31 10:22:50 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UiKbo-0006nD-Th
	for gcvg-git-2@plane.gmane.org; Fri, 31 May 2013 10:22:49 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754053Ab3EaIWn convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 31 May 2013 04:22:43 -0400
Received: from mail-la0-f50.google.com ([209.85.215.50]:35037 "EHLO
	mail-la0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754048Ab3EaIWh convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 31 May 2013 04:22:37 -0400
Received: by mail-la0-f50.google.com with SMTP id ed20so1089072lab.23
        for <git@vger.kernel.org>; Fri, 31 May 2013 01:22:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QQg550nM5WK/wlyhnk5hwaCx2ZVqte6wh+VwY/nTyqc=;
        b=KoszE/Z+RUeMapmrcsZsUYlN3hZUMjYuud+swMrdJmPMSEYI6/XCLMjy3Lumzld0xp
         i002s5V5Gt6SSHGU7DQfXqXvh+eSG+GpTjH1Bxi1VWD1Y1uiRJg/Xj+rFHAmrw8BsSzU
         NTBJKDZUErx9ddD1eI7RgNbUnll6iCJaTZIKmSQtwDyAYEQUmhHNhO9pTKwQysRCFM3v
         w/MCQwTDpWJ6xf9GGy7j7veSf+VRkyCXgcYBkuWJRk1rK1HtzMpx5VOJpqtTNgvN33zz
         m4S5rYADxk/Ee25Uk/SGdBk20z8aM/n66Actc2nA1yxlY0+sn8alb3AxGw5GFBnT9BfX
         9d7w==
X-Received: by 10.112.138.131 with SMTP id qq3mr5482902lbb.46.1369988553516;
 Fri, 31 May 2013 01:22:33 -0700 (PDT)
Received: by 10.114.177.164 with HTTP; Fri, 31 May 2013 01:22:33 -0700 (PDT)
In-Reply-To: <51A76C8E.1080009@lsrfire.ath.cx>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226077>

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

It would be enough if every discard_cache() is not followed by a
read_cache() after adding entries.

I was adding a init_index() helper, but it turns out only very few
places initialize the index, and all of them zero the structure (or
declare it so it's zeroed on load), so I think this change is safe
like that. Also, I don't see any place manually doing initialize=3D0.

--=20
=46elipe Contreras
