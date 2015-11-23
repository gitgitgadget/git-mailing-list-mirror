From: Stefan Beller <sbeller@google.com>
Subject: Re: [PATCHv2] run-command: detect finished children by closed pipe
 rather than waitpid
Date: Mon, 23 Nov 2015 10:44:51 -0800
Message-ID: <CAGZ79kYs9+UTx__yccy6qZY+Xn4onWx3zpH51pzHPn8Hz_FMww@mail.gmail.com>
References: <1448053719-28340-1-git-send-email-sbeller@google.com>
	<5650161E.9060305@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jeff King <peff@peff.net>,
	"git@vger.kernel.org" <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmail.com>,
	Johannes Sixt <j6t@kdbg.org>
To: =?UTF-8?Q?Torsten_B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:44:58 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1a0w6h-0006lz-VL
	for gcvg-git-2@plane.gmane.org; Mon, 23 Nov 2015 19:44:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752608AbbKWSox convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Nov 2015 13:44:53 -0500
Received: from mail-yk0-f169.google.com ([209.85.160.169]:35098 "EHLO
	mail-yk0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751916AbbKWSov convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 23 Nov 2015 13:44:51 -0500
Received: by ykba77 with SMTP id a77so247367410ykb.2
        for <git@vger.kernel.org>; Mon, 23 Nov 2015 10:44:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        bh=VMummEjLqSuk3bE1W+BDIysavUCAl1C+62hk41LtwKQ=;
        b=KDpGw/+JeipT2CxHmBwSbOTGS2qBdz62L7X1MR9+q6TcKb0ZaEmwxZTVTG4o7v6Lya
         WT0UVioQ+r0lQxjYCI/Z5oQgUOWTXY1lRhy8ipxtyGEpMEvu/SrxnH/7p1FidMuEyOc0
         x21+kMzxpP/yK6eQKpS/Qx/juv8Gy+BRKd8oVAPSt4mqt0H5MfO+M2ONcMMikVWtaTaU
         QNPUgTT/kxS+eqH6zSsbKVn8lcLnPlWomXa/EcxydjLODYPlC2/WphSLgCaB9aCG8VBI
         08/YPUfW5VtCmbtSPGJaqN49TTWoOjmk/25EGQt89U1nh4a6cIIp5qWhrd9TIlOhe9rw
         5tpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=VMummEjLqSuk3bE1W+BDIysavUCAl1C+62hk41LtwKQ=;
        b=eBfQFChKR/kO+SwobcMHRBNsjonxpVpoN4LWmsCfLm/5dhLIfgbyd5aL9gVsqJQ5KY
         WgPB+X9vWsmp8Zalgtd+xuM/zwP8mWY0QNJF/7u+qCQzcfaaRZj6/i6dsw8/GyCCCLHd
         ykm6xtIorqhI5kjIxXDWl8ZqS4hHCVyXTRNVq26z03xBNdaP4xOKfU4IPXNi2Mmv+ZVk
         vFiDFWiz/2lL6rI8IssA2gFiHlvxEHA6ItLy02L0l8CSpd1dZ596SGGkNUptKi2H7Mng
         ZscXBvJhlqGa+AUFW/viju0yNbO4dHi2C2GzDQ4eymU1HJ+DWhef7NGO34fJ4WF6t2/j
         mEhw==
X-Gm-Message-State: ALoCoQmtDqLiMRHkJkYJSlwWYRTiBMhY+5Z0itMxgQbsnW3bvFspx9/Po20eEnQcl/Qw8t2E4QoS
X-Received: by 10.129.104.2 with SMTP id d2mr14706177ywc.199.1448304291165;
 Mon, 23 Nov 2015 10:44:51 -0800 (PST)
Received: by 10.37.196.70 with HTTP; Mon, 23 Nov 2015 10:44:51 -0800 (PST)
In-Reply-To: <5650161E.9060305@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/281589>

On Fri, Nov 20, 2015 at 10:58 PM, Torsten B=C3=B6gershausen <tboegi@web=
=2Ede> wrote:
> On 2015-11-20 22.08, Stefan Beller wrote:
> The patch looks good at first glance, one minor remark below:
>>
>> diff --git a/run-command.c b/run-command.c
>
>> @@ -1071,70 +1089,31 @@ static void pp_output(struct parallel_proces=
ses *pp)
>>
>>  static int pp_collect_finished(struct parallel_processes *pp)
>>  {
>> -     int i =3D 0;
>> -     pid_t pid;
>> -     int wait_status, code;
>> +     int i, code;
>
> code is probably "return code"?
> woud "ret_value", "res" or "rc" make that more clear ?
>

The return value of invoked process, yes.
"ret_value", "res" sound too much like our own future return value
(by convention of naming its own return value ret_value or similar).

Instead of return code, I may settle with `exit_status`?
