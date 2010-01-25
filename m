From: Fredrik Kuivinen <frekui@gmail.com>
Subject: Re: [PATCH v3] Threaded grep
Date: Mon, 25 Jan 2010 23:47:30 +0100
Message-ID: <4c8ef71001251447m18a0e7c0y71db3972d0ca1152@mail.gmail.com>
References: <20100118103334.GA17361@fredrik-laptop>
	 <7vmy0bhxn1.fsf@alter.siamese.dyndns.org>
	 <4c8ef71001181612l72ec73ecmae709fbb475752b0@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Linus Torvalds <torvalds@linux-foundation.org>,
	Git Mailing List <git@vger.kernel.org>,
	Johannes Sixt <j.sixt@viscovery.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 25 23:47:37 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NZXia-0006kr-Gi
	for gcvg-git-2@lo.gmane.org; Mon, 25 Jan 2010 23:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753399Ab0AYWrd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 25 Jan 2010 17:47:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752596Ab0AYWrc
	(ORCPT <rfc822;git-outgoing>); Mon, 25 Jan 2010 17:47:32 -0500
Received: from fg-out-1718.google.com ([72.14.220.157]:62268 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752095Ab0AYWrc convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 25 Jan 2010 17:47:32 -0500
Received: by fg-out-1718.google.com with SMTP id l26so1283202fgb.1
        for <git@vger.kernel.org>; Mon, 25 Jan 2010 14:47:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=pBMUFwT7iRC0ccwTIVqRZbkaCj9Yrv1DjqjUtSyKMRo=;
        b=h/Wa5BTXxCm/iDE5Xf28PICkcWX4qhiIh7gMUYBWXNRtE1BqAESk2avJMUWQYiQ8yW
         Q9+Tg3Yhx+f9yt9d+ITzApIYU2hJpqA4lmU4psGVKw8iQ//7rpkAzciweEpuARKi6XiO
         PjDVPIGu9RqgEp3NetLA2ERH4wQIfIMVFI8k8=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=TT3qSHPtJWKyhJchkaHVn4ZdK5uvp1pDJNQvQ8+9wVzHhAA5IHFTwiv3zVoaG39qIs
         YDc+QkHkHJjp8p3XiNe/gcJg6In+ap9+4tnhmSG1aTBsKeGz2ImADe9ijUnqcerpTTaF
         GBr2WFtH7iLZzNEi0dSr9nADOoKoGlcNflCWI=
Received: by 10.239.186.19 with SMTP id e19mr374230hbh.212.1264459650762; Mon, 
	25 Jan 2010 14:47:30 -0800 (PST)
In-Reply-To: <4c8ef71001181612l72ec73ecmae709fbb475752b0@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/138003>

On Tue, Jan 19, 2010 at 01:12, Fredrik Kuivinen <frekui@gmail.com> wrot=
e:
> On Mon, Jan 18, 2010 at 23:10, Junio C Hamano <gitster@pobox.com> wro=
te:
>>
>> I am wondering if this can somehow be made into a change with alot
>> smaller inpact, in spirit similar to "preloading". =A0The higher lev=
el
>> loop may walk the input (be it cache, tree, or directory), issuing o=
ne
>> grep_file() or grep_sha1() at a time just like the existing code, bu=
t
>> the thread-aware code adds "priming" phase that (1) populates a "wor=
k
>> queue" with a very small memory footprint, and that (2) starts more
>> than one underlying grep on different files and blobs (up to the
>> number of threads you are allowed, like your "#define THREADS 8"), a=
nd
>> that (3) upon completion of one "work queue" item, the work queue it=
em
>> is marked with its result.
>>
>> Then grep_file() and grep_sha1() _may_ notice that the work queue it=
em
>> hasn't completed, and would wait in such a case, or just emits the
>> output produced earlier (could be much earlier) by the worker bee.
>>
>> The low-memory-footprint work queue could be implemented as a lazy
>> one, and may be very different depending on how the input is created=
=2E
>> If we are grepping in the index, it could be a small array of <array
>> index in active_cache[], done-bit, result-bit, result-strbuf> with a
>> single integer that is a pointer into the index to indicate up to
>> which index entry the work queue has been populated.
>
> I will have to think about this a bit more. It's getting late here.

I will be sending v4 of the patch in a couple of minutes, but I want
to comment on this first.

Sure, it is probably possible to structure the code as you suggest.
However, I am not so sure that it will be a significantly smaller
change. I find the approach taken in the patch to be quite nice as the
threaded and non-threaded cases are fairly similar. There is a block
of code which deals with the threading, but that part is mostly
self-contained. In v4 I have not changed the overall approach to the
problem.

- Fredrik
