From: Karsten Blees <karsten.blees@gmail.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 01:02:55 +0200
Message-ID: <53C8561F.5090600@gmail.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com> <xmqqoawnq2vv.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>,
	=?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu40=?= =?UTF-8?B?YyBEdXk=?= 
	<pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 01:03:01 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7uhX-0005kr-CY
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 01:02:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758167AbaGQXCz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 17 Jul 2014 19:02:55 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:49313 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754158AbaGQXCy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 17 Jul 2014 19:02:54 -0400
Received: by mail-wi0-f177.google.com with SMTP id ho1so3632500wib.16
        for <git@vger.kernel.org>; Thu, 17 Jul 2014 16:02:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=kqDhNUitrl//Jw1yTHyjg02aBqHYIDzZbAlniw4B1RE=;
        b=Km9KSy4xvM93N34MLqfCQkrrlSiuJCe2I74SHUbYztIgOs7pqYjcZNnN2BLZ36IeqQ
         CQS3AGmsW/fDtdpS6o+Mt39aYAwie1I+2Uw0y1gm/GaaDP5/qxZMXxO80fvjFnQrlo16
         oVhcd7PR6TkLN1Mwv044252WEbjklvtGWxrRN66NrQNVo8as0wJ0DP7tkqEA2hKM0tgJ
         DJgf3+gapA1paeA141rPjG7eSi6WhtAKBE1VUG52diUV1XiPQLnHlnOWwBU5eag26DPa
         pDR4QPJryEMcV7TpFCv0aZjCJxmODUtP6VU57uRHuFauBBxys9A+6w9/ZAizj28z/04H
         7k9g==
X-Received: by 10.180.84.7 with SMTP id u7mr26038639wiy.27.1405638173681;
        Thu, 17 Jul 2014 16:02:53 -0700 (PDT)
Received: from [10.1.116.52] (ns.dcon.de. [77.244.111.149])
        by mx.google.com with ESMTPSA id bg2sm18178478wib.21.2014.07.17.16.02.52
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Thu, 17 Jul 2014 16:02:52 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <xmqqoawnq2vv.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253785>

Am 17.07.2014 20:03, schrieb Junio C Hamano:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>=20
>> This array 'cwd' is used to store the result from getcwd() and chdir=
()
>> back. PATH_MAX is the right constant for the job. On systems with
>> longer PATH_MAX (eg. 4096 on Linux), hard coding 1024 fails stuff,
>> e.g. "git init". Make it static too to reduce stack usage.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>=20
> Thanks.  It seems that this 1024 has been with us since the
> beginning of this piece of code.  I briefly wondered if there are
> strange platform that will have PATH_MAX shorter than 1024 that will
> be hurt by this change, but the result in cwd[] is used to grow the
> final result bufs[] that is sized based on PATH_MAX anyway, so it
> will not be an issue (besides, the absurdly short one seems to be
> a different macro, MAX_PATH, on Windows).
>=20

Indeed, there's a strange platform where PATH_MAX is only 259. With
Unicode support, the current directory can be that many wide characters=
,
which means up to 3 * PATH_MAX UTF-8 bytes (if all of them are CJK).

I don't think this will be a problem, though, as the return buffer is
PATH_MAX-bounded as well.
