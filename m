From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3] gc: save log from daemonized gc --auto and print it
 next time
Date: Mon, 31 Aug 2015 17:17:59 +0700
Message-ID: <CACsJy8Dd9OCpsytFDDwh8maBfTc1wLs+UKJMPdZngiBaJgr7pA@mail.gmail.com>
References: <CACsJy8AKbXqsuNJL7Usb-haiynDcCDQXk56WYh5PxzGU3NvaAw@mail.gmail.com>
 <1440209546-23442-1-git-send-email-pclouds@gmail.com> <xmqqtwrnz2ar.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	=?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= <avarab@gmail.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Aug 31 12:18:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZWMAc-0006J7-7P
	for gcvg-git-2@plane.gmane.org; Mon, 31 Aug 2015 12:18:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752505AbbHaKSa convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 31 Aug 2015 06:18:30 -0400
Received: from mail-io0-f169.google.com ([209.85.223.169]:34295 "EHLO
	mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751923AbbHaKS3 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 31 Aug 2015 06:18:29 -0400
Received: by ioeu67 with SMTP id u67so10453794ioe.1
        for <git@vger.kernel.org>; Mon, 31 Aug 2015 03:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:content-transfer-encoding;
        bh=mv68oheHRykSudER3n+pbCrs0ZJRyszeKDlosVTClCk=;
        b=j3sstuXwMUvFS8x8hNCvtCBwFgbOGVc0Y3WgW+MbJUVrlub4XYfJgX8S7s1O+lZoPY
         6n6j78aFanXcGRpe33SRi9rmtHVxsoqpbblqGzfcpR8l8LlkwYcy7qtOto1hRtl/vd7l
         kwVDxO72ehrKOihGtyAQgnR2iwh4uln+4pRXXtuKnh9fIWAWJZ8TalaZLOZx/rs2gMl9
         eUaWrWdF5LNHhb7ba9Kmd+nDoeuD/lwlHpvl3INevGusQTKqiysTygA/ElY1saHiaQC2
         UpaiY9KfxXFNMBWAvns21+9iPi/PbNZ8Y4YNawZaC1v3E0mkF5RkB+81eTg5kILksSMh
         ExwA==
X-Received: by 10.107.9.11 with SMTP id j11mr22515409ioi.191.1441016308991;
 Mon, 31 Aug 2015 03:18:28 -0700 (PDT)
Received: by 10.107.191.193 with HTTP; Mon, 31 Aug 2015 03:17:59 -0700 (PDT)
In-Reply-To: <xmqqtwrnz2ar.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276868>

On Wed, Aug 26, 2015 at 12:49 AM, Junio C Hamano <gitster@pobox.com> wr=
ote:
> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> While commit 9f673f9 (gc: config option for running --auto in
>> background - 2014-02-08) helps reduce some complaints about 'gc
>> --auto' hogging the terminal, it creates another set of problems.
>>
>> The latest in this set is, as the result of daemonizing, stderr is
>> closed and all warnings are lost. This warning at the end of cmd_gc(=
)
>> is particularly important because it tells the user how to avoid "gc
>> --auto" running repeatedly. Because stderr is closed, the user does
>> not know, naturally they complain about 'gc --auto' wasting CPU.
>>
>> Daemonized gc now saves stderr to $GIT_DIR/gc.log. Following gc runs
>> will not be daemonized and gc.log printed out until the user removes
>> gc.log.
>>
>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  Let's try again. Compared to v2 [1], this version does not delete
>>  gc.log automatically any more. The user needs to take action, then
>>  delete gc.log to bring it background again.
>
> Sounds a bit more sensible, but I wonder if it is a good idea to
> keep going in the first place.  If the last gc run reported an
> issue, would it make it likely that we would hit the same issue?
>
> An alternative design I have in mind is to exit "gc --auto" with
> success without doing anything, after giving the new warning
> message.  What would be the pros-and-cons between this patch and
> that alternative design?

I think the alt. design is better. If anything, keep runing may
produce more output and probably distract the user from the real
warning. We only want to keep doing something again if it can gain us
something. If we succeed at steps A and B, then fail at C. Doing A and
B again next time might be worth something in general, but given the
context of git-gc I don't think it is.
--=20
Duy
