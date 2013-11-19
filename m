From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Re: [PATCH v4 6/6] for-each-ref: avoid color leakage
Date: Tue, 19 Nov 2013 10:07:33 +0530
Message-ID: <CALkWK0mnYXBVW-agV_v6=mPxA=MoJAfHQaPKarwKU=x2SE+tnQ@mail.gmail.com>
References: <1384796353-18701-1-git-send-email-artagnon@gmail.com>
 <1384796353-18701-7-git-send-email-artagnon@gmail.com> <xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Nov 19 05:38:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vid4s-0005Oa-Mp
	for gcvg-git-2@plane.gmane.org; Tue, 19 Nov 2013 05:38:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751563Ab3KSEiP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Nov 2013 23:38:15 -0500
Received: from mail-ie0-f179.google.com ([209.85.223.179]:55963 "EHLO
	mail-ie0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751386Ab3KSEiO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Nov 2013 23:38:14 -0500
Received: by mail-ie0-f179.google.com with SMTP id u16so10314342iet.38
        for <git@vger.kernel.org>; Mon, 18 Nov 2013 20:38:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=67d4oJ+XHoYE93PfE03cKDs4BiLQAjsDwaM3UEuShw8=;
        b=aPkj+/r6WjPylOFZrRMVSoiYIQtnDdkIsw66huiL2yCXkzmJq/8bPxBiyjO68gvImg
         zFsU3BCz/bi0ZjTIGI6rPNK555DX+3ZG7FdGBs8HYdZhRoLUmkhb/7tY+tVAibmS7yMJ
         AsXxg5PcYZPmW31AiwAh14pQpGEmtdBEhdiMSp3yy8964PhTn00E+0ZXbcFxQ+uJVF4c
         ang2EZNkUguPV8CJk8H4UVv0bdu8OkySDJZo5qrYbHUHfYKa4N6R0w+tbm8+TUmZHW1P
         7i1WO1Zn7jJzDU+u15Ez3xPcKmnHATiq798CkEKC1eCNeXC0LTaC3s8C8jwxMmeETIY9
         a2GQ==
X-Received: by 10.50.61.205 with SMTP id s13mr17890141igr.29.1384835893935;
 Mon, 18 Nov 2013 20:38:13 -0800 (PST)
Received: by 10.64.73.36 with HTTP; Mon, 18 Nov 2013 20:37:33 -0800 (PST)
In-Reply-To: <xmqqwqk59xyz.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238022>

Junio C Hamano wrote:
>> diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
>> index 2ff4e54..04e35ba 100644
>> --- a/builtin/for-each-ref.c
>> +++ b/builtin/for-each-ref.c
>> @@ -23,6 +23,7 @@ typedef enum { FIELD_STR, FIELD_ULONG, FIELD_TIME } cmp_type;
>>  struct atom_value {
>>       const char *s;
>>       unsigned long ul; /* used for sorting when not FIELD_STR */
>> +     int color : 2; /* 1 indicates color, 2 indicates color-reset */
>>  };
>
> Hmph.  It looks wasteful to have this information in atom_value.

I wanted to avoid an ugly global. On the other end of the spectrum,
modifying the various functions to take an extra reset_color_leakage
parameter seems much too intrusive. Do you have any suggestions?

> Isn't a new single bit in "struct refinfo" all you need to keep
> track of, to see the last %(color:something) you ever saw is for a
> color that is not reset?

No; because I can only look at one atom and set v->color, at a time.
