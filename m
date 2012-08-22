From: Brandon Casey <drafnel@gmail.com>
Subject: Re: Porting git to HP NonStop
Date: Wed, 22 Aug 2012 11:09:56 -0700
Message-ID: <CA+sFfMedWVAgqvHS67V6L=ROjdN6M3p3pYTUDk98xgozX4djEw@mail.gmail.com>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de>
	<CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
	<004701cd771e$21b7cbb0$65276310$@schmitz-digital.de>
	<CAJo=hJsz3ooDAV-0S-BDknnbQPK9ASEYw8b7t7PyKEtJ5jgxQA@mail.gmail.com>
	<01a801cd7de8$b4c311a0$1e4934e0$@schmitz-digital.de>
	<7v628epzia.fsf@alter.siamese.dyndns.org>
	<000601cd7ebd$a4ef5740$eece05c0$@schmitz-digital.de>
	<7vy5l9lj6m.fsf@alter.siamese.dyndns.org>
	<001801cd7eee$24f95a50$6eec0ef0$@schmitz-digital.de>
	<7v4nnxld24.fsf@alter.siamese.dyndns.org>
	<002a01cd8083$69fb9960$3df2cc20$@schmitz-digital.de>
	<CA+sFfMdnixrUekh40Sde05tkap7Oj19=5D6J6aYVVD1krqPZkw@mail.gmail.com>
	<503519B3.1020403@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Joachim Schmitz <jojo@schmitz-digital.de>,
	Junio C Hamano <gitster@pobox.com>,
	Shawn Pearce <spearce@spearce.org>, git@vger.kernel.org,
	rsbecker@nexbridge.com
To: Johannes Sixt <j6t@kdbg.org>
X-From: git-owner@vger.kernel.org Wed Aug 22 20:10:05 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T4FNU-0007nb-Q4
	for gcvg-git-2@plane.gmane.org; Wed, 22 Aug 2012 20:10:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933021Ab2HVSJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 22 Aug 2012 14:09:59 -0400
Received: from mail-vc0-f174.google.com ([209.85.220.174]:48922 "EHLO
	mail-vc0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758435Ab2HVSJ5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 22 Aug 2012 14:09:57 -0400
Received: by vcbfk26 with SMTP id fk26so1346947vcb.19
        for <git@vger.kernel.org>; Wed, 22 Aug 2012 11:09:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=sa9mxM5z1pE/+yC/AivkjAbI8FXx8zz9AM5oxsBA35k=;
        b=flbE3iZ1aux28bA5PzWR/m90hjqqzndarIxucqwEeJ25DwU4N8qLDsnhCs6fC84ROz
         b4zxu3ohHmam/Ax+yEvt+MREVrBmupDq+hBS6p8f1yUNj+bRx2HR6gyNIiaNbnso7Z0F
         4zhhuMxnNufBeNgi3L0f362Ye0A84eQ28yA1aFQ6DDM0mAs/7njd+KkrAtDn9JHAZFIx
         yzWJRffHrqJZGzjvjPDTu5YMXiEaZL9qNPAO76NCa9hn+wpMc3B0GfRxWqTuFnGneRNp
         BOc2C9cskclzNiZ4/wwBjFn+Y1zqYQpSs5Q/mP9MNhJxY+5O/JR8fJ3Kb1s+cC0GL0mA
         4LIQ==
Received: by 10.52.31.230 with SMTP id d6mr6011498vdi.87.1345658996589; Wed,
 22 Aug 2012 11:09:56 -0700 (PDT)
Received: by 10.58.29.233 with HTTP; Wed, 22 Aug 2012 11:09:56 -0700 (PDT)
In-Reply-To: <503519B3.1020403@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204057>

On Wed, Aug 22, 2012 at 10:41 AM, Johannes Sixt <j6t@kdbg.org> wrote:
> Am 22.08.2012 19:00, schrieb Brandon Casey:
>>  So I think the body of [compat_mkdir] can become
>> something like:
>>
>>    if (len && dir[len-1] == '/')
>>        dir = tmp_dir = xstrndup(dir, len-1);
>
> Don't use x* wrappers in the compat layer, at least not those that
> allocate memory: They behave unpredictably due to try_to_free_routine
> and may lead to recursive invocations.

I thought that rule only applied to die handlers.  i.e. don't use the
x* wrappers to allocate memory in a die handler like
compat/win32/syslog.c.  At least that's what I wrote in 040a6551 when
you pointed out this issue back then.

Admittedly, it could get pretty sticky trying to trace the die
handlers to ensure they don't invoke your new compat/ function.  So,
yeah, adopting this rule of not using x* wrappers that allocate memory
in compat/ generally seems like a good idea.

Should we also try to detect recursive invocation of die and friends?
In theory recursion could be triggered by any die handler that makes
use of a code path that calls an x* wrapper that allocates memory,
couldn't it?

-Brandon
