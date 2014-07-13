From: "Yi, EungJun" <semtlenori@gmail.com>
Subject: Re: [PATCH v3] http: Add Accept-Language header if possible
Date: Sun, 13 Jul 2014 18:51:57 +0900
Message-ID: <CAFT+Tg8pJrdoD4M1uy6A=PPJaSrq_QcRUQdxdrA-T5sJiZ7j1Q@mail.gmail.com>
References: <1405097573-19239-1-git-send-email-eungjun.yi@navercorp.com>
	<CAPig+cRwJhyZ=R_HGs9JKUFLuJxoS=abrD9+HuoWDiA5oJrtjw@mail.gmail.com>
Reply-To: semtlenori@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>,
	Yi EungJun <eungjun.yi@navercorp.com>,
	Jeff King <peff@peff.net>,
	Peter Krefting <peter@softwolves.pp.se>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Sun Jul 13 11:52:04 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6GRu-0008E6-Re
	for gcvg-git-2@plane.gmane.org; Sun, 13 Jul 2014 11:52:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753197AbaGMJv7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 13 Jul 2014 05:51:59 -0400
Received: from mail-ie0-f180.google.com ([209.85.223.180]:35120 "EHLO
	mail-ie0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753184AbaGMJv6 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 13 Jul 2014 05:51:58 -0400
Received: by mail-ie0-f180.google.com with SMTP id at20so2376332iec.11
        for <git@vger.kernel.org>; Sun, 13 Jul 2014 02:51:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=K12bcToxOVtnZE6b1zzuLCWlHJxwB6hG9k92Td7UhRE=;
        b=WJ7UO0iATMw0fpAC/iz14T3eBkS4zjoymTpxflPj5rRdAfX7VW+zBTPXXtdTXj9e9V
         X70nJUNIYk3AMI/u63etQVGA1ooY4FOX/rKzu3BLdBIjob4jzqogbCN1tejHtiJfjbNZ
         9oGS+J5CrcyUOK/54u3bU+w770QADRSJscL7cjG4Zfa5UEYzcVVSSFNS6Rm8Za20Oo1E
         2yzglZ0ROuKtpfrW/e/mPODEIDgKOmEjy5w/LbtkD3g0LUd1CzRqs/y7SxbSr8xIydL1
         xpnj+x6FXlwvlvf8xQAONN42Cumd3Py7/0M0XZWnhTNmgm7Fdjr83wW1eRhNmWZuAZLU
         leAA==
X-Received: by 10.43.154.12 with SMTP id lc12mr217169icc.90.1405245117396;
 Sun, 13 Jul 2014 02:51:57 -0700 (PDT)
Received: by 10.50.153.110 with HTTP; Sun, 13 Jul 2014 02:51:57 -0700 (PDT)
In-Reply-To: <CAPig+cRwJhyZ=R_HGs9JKUFLuJxoS=abrD9+HuoWDiA5oJrtjw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253445>

2014-07-13 13:26 GMT+09:00 Eric Sunshine <sunshine@sunshineco.com>:
>> +       /* Decide the precision for q-factor on number of preferred languages. */
>> +       if (num_langs + 1 > 100) { /* +1 is for '*' */
>> +               q_precision = 0.001;
>> +               q_format = "; q=%.3f";
>> +       } else if (num_langs + 1 > 10) { /* +1 is for '*' */
>> +               q_precision = 0.01;
>> +               q_format = "; q=%.2f";
>> +       }
>
> It might make sense to have a final 'else' here which sets these
> variables for the 0.1 case so that the reader of the code doesn't have
> to refer back to the top of the function to figure out what is going
> on.
>
>     } else {
>         q_precision = 0.1;
>         q_format = "; q=%.1f";
>     }
>
> Better yet, would it be possible to compute these values rather than
> having to set them manually via a cascading if-chain?

I think it is possible like this:

    num_langs += 1; /* for '*' */
    decimal_places = 1 + (num_langs > 10) + (num_langs > 100);
    snprintf(q_format, sizeof(q_format), "; q=%%.%df", decimal_places);
    for (q_precision = 1.0; decimal_places-- > 0;) q_precision /= 10;

Does this one look better than before? I'm not sure which one is better.

ps. The last line can be simpler by using pow() but I'm not sure it is
okay to include math.h.
