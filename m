From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 1/4] usage: make error functions a stack
Date: Tue, 15 Jul 2014 17:49:30 -0700
Message-ID: <CAPc5daUhmeucDOakXpR_ViS0cfFDEyXUD_xoeP6qeCg33dW+1A@mail.gmail.com>
References: <1405459754-4220-1-git-send-email-jacob.e.keller@intel.com>
 <1405459754-4220-2-git-send-email-jacob.e.keller@intel.com>
 <xmqq7g3etf1o.fsf@gitster.dls.corp.google.com> <1405466783.2577.15.camel@jekeller-desk1.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: "Keller, Jacob E" <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Wed Jul 16 02:49:59 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X7DPy-0002zk-Gs
	for gcvg-git-2@plane.gmane.org; Wed, 16 Jul 2014 02:49:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757269AbaGPAty (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Jul 2014 20:49:54 -0400
Received: from mail-la0-f49.google.com ([209.85.215.49]:47336 "EHLO
	mail-la0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754124AbaGPAtw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Jul 2014 20:49:52 -0400
Received: by mail-la0-f49.google.com with SMTP id hz20so121170lab.22
        for <git@vger.kernel.org>; Tue, 15 Jul 2014 17:49:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=8x2RAnW2M1eorc6M3zoSsokR5uTmxyYkNeeJbDTYcKE=;
        b=XhTusCi6rDiOoOSCEaj9Dk73sRCuD+63dnnxIKtHhF4qnZeF+5gJdC8goepeVKt+Ja
         uv20rNJqsn8+8HKu6nbpO5T6PflvykoExPxwOQwIfr7FGBFkW7UqeZhwsrk+PlijOAyx
         +oUhMx1qE3oKp5jRDkg2AQqnStFGlCuDRPja3QSFQ/0c59U0kXKdQKE/0gLrfKf233Xw
         UxTSQPyee52t1mzscKvEhdPo/X60apuJzg5CJ6r4rI2BpiLveOwq6sazUEkbnASAfskv
         7QyTtrC3U6ktQbSlQMZ+OXGCdcCam3v3cY8OkCbkn2X4dtakxcAI5nDDfF2t3PjhNgk7
         bNVA==
X-Received: by 10.112.189.170 with SMTP id gj10mr4616590lbc.76.1405471790990;
 Tue, 15 Jul 2014 17:49:50 -0700 (PDT)
Received: by 10.112.26.212 with HTTP; Tue, 15 Jul 2014 17:49:30 -0700 (PDT)
In-Reply-To: <1405466783.2577.15.camel@jekeller-desk1.amr.corp.intel.com>
X-Google-Sender-Auth: i8cpVYkYIDZBNPvhgo85COl5ufU
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253652>

I actually am not a big fan of "stack" for a thing like this, to be honest.
Wouldn't it be sufficient for the callers who want specific behaviour from
its callees to

 - save away the current error/warning routines;
 - set error/warning routines to its own custom versions;
 - call the callees;
 - set error/warning routines back to their original; and
 - return from it

at least in the code paths under discussion?


On Tue, Jul 15, 2014 at 4:26 PM, Keller, Jacob E
<jacob.e.keller@intel.com> wrote:
> On Tue, 2014-07-15 at 15:47 -0700, Junio C Hamano wrote:
>> Jacob Keller <jacob.e.keller@intel.com> writes:
>>
>> >  extern void set_error_routine(void (*routine)(const char *err, va_list params));
>> > +extern void pop_error_routine(void);
>>
>> pop that undoes set smells somewhat weird.  Perhaps we should rename
>> set to push?  That would allow us catch possible topics that add new
>> calls to set_error_routine() as well by forcing the system not to
>> link when they are merged without necessary fixes.
>>
>
> Also curious what your thoughts on making every set_*_routine to be a
> stack? For now I was only planning on error but it maybe makes sense to
> change them all?
>
> Thanks,
> Jake
>
