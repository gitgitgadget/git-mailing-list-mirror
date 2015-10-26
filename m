From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCH 1/2] run-command: factor out child_process_clear()
Date: Mon, 26 Oct 2015 12:23:23 -0700
Message-ID: <CAGZ79kYopHL5D_7+bJV2P9GeKDHufPDBTo3a8bRL=4B3OmTGjg@mail.gmail.com>
References: <562B756F.1020305@web.de>
	<xmqqziz5h3n5.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?Q?Ren=C3=A9_Scharfe?= <l.s.r@web.de>,
	Git List <git@vger.kernel.org>, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 26 20:23:29 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZqnMe-0003yB-7l
	for gcvg-git-2@plane.gmane.org; Mon, 26 Oct 2015 20:23:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751684AbbJZTXY convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 26 Oct 2015 15:23:24 -0400
Received: from mail-yk0-f171.google.com ([209.85.160.171]:35984 "EHLO
	mail-yk0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751450AbbJZTXX convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 26 Oct 2015 15:23:23 -0400
Received: by ykba4 with SMTP id a4so188795480ykb.3
        for <git@vger.kernel.org>; Mon, 26 Oct 2015 12:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=QA6qhWDi6tpmQeupr5uUe5C0Ynwt3a6fVZDYQfyJEHY=;
        b=HVkyX70a4XEHjdRwLjz/wZLhFboA5XGDlkwFuHaEfHfm9MyM6/SCH/M+NmAT5rukdJ
         xZEF5MpYtpWTOpV65OtZ+MAkOgY88hXCqWjAgSn51aEvCsLubHI4rJybylgstwdAUpuv
         wJ8W5J7k5mvqPb6KSe1qWcXnytUT/8+tiXYjWNCLKy/ejC7MRAFHPfkMApvdnTHLf8qX
         9D9MhVW5TlGw3e74mLeqMl0eS4b2CsJ7DPP8Q++dPwfTsurT+qXV4vOuPpvzPAu8PfY3
         bWqnyOaUMnf2COoiDOEvQ+Ox0Pix2ciwuZraAi5Tu/VabaOhy4i0HftfjEuexG7IIVS3
         BZ9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=QA6qhWDi6tpmQeupr5uUe5C0Ynwt3a6fVZDYQfyJEHY=;
        b=S8Dd/jMIWCIGRmfydkJZseCwb5oOTu0k85vc1rQXEHOxaDc3ginVs/+ntJIQcYTtgt
         gmWiZ5yCLT/mO9lGUpDTT2wMRkxZRSvNC61DbALB94vld7bd5xQgM143z0nbeNFr2E+t
         Rec5FjzshKkdxSDIWkV50RmZacjs5Nyemv9OTQoQxP82ovMnt8+1Rp9rB06SENiLas9z
         sUe1WAuWTtbXtWUxahQk7hIpjIoQliRxC6UAD6iTVhz2eQbeUNdIK8INjQJt9LxOTaLv
         uCfh6cdV52GnJ/B8bTQBmRu3CzlOcQzj0kIcwhbI1p786mNoms6ZwAsGrjWoFqxBW781
         t76w==
X-Gm-Message-State: ALoCoQl4gEH8LLwvUAuzASKmV3C7W5uqZqoGSq39Lt+xCk7lZZh9D7BAsBtHJ5CY55h7QNk8y4u5
X-Received: by 10.129.75.208 with SMTP id y199mr30030485ywa.48.1445887403112;
 Mon, 26 Oct 2015 12:23:23 -0700 (PDT)
Received: by 10.37.29.213 with HTTP; Mon, 26 Oct 2015 12:23:23 -0700 (PDT)
In-Reply-To: <xmqqziz5h3n5.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/280210>

On Mon, Oct 26, 2015 at 11:43 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Ren=C3=A9 Scharfe <l.s.r@web.de> writes:
>
>> Avoid duplication by moving the code to release allocated memory for
>> arguments and environment to its own function, child_process_clear()=
=2E
>> Export it to provide a counterpart to child_process_init().
>>
>> Signed-off-by: Rene Scharfe <l.s.r@web.de>
>> ---
>
> Hmm, is this _deinit() Stefan added to his series recently?

Yes. Although you (Junio) take credit for actually using it in these
places, too. :)
