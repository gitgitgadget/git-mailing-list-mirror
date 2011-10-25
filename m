From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Tue, 25 Oct 2011 17:42:53 +0200
Message-ID: <CABPQNSZ8wesy-px-n1LYbVwFT3gBNcrHfe+_553sinTferqsog@mail.gmail.com>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com> <4EA6D594.90402@viscovery.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Oct 25 17:43:40 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIjAA-0004p3-Mi
	for gcvg-git-2@lo.gmane.org; Tue, 25 Oct 2011 17:43:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756650Ab1JYPne convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Oct 2011 11:43:34 -0400
Received: from mail-pz0-f42.google.com ([209.85.210.42]:45404 "EHLO
	mail-pz0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752606Ab1JYPnd convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 25 Oct 2011 11:43:33 -0400
Received: by pzk36 with SMTP id 36so1785826pzk.1
        for <git@vger.kernel.org>; Tue, 25 Oct 2011 08:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=ItuKX/U5pFDegnI/lIVolb6tT8aJXS6BcloFI5Zz7jk=;
        b=jjWzG2nJU5hT8okRFai4SgyPOXU8OZPyeUQdi2ysouKQPtydc9Abn/VTUI+lyeT6ud
         ntqdSOyuEmr1pqva/AqUA+qEVsVf4r9qaXtmDicpFGmU73BlhJX9YhP92BQeuvmz39FV
         LU8dtTN994/hoYwDGwlpNQeOhM4WOcLRG2Exg=
Received: by 10.68.28.9 with SMTP id x9mr51851753pbg.8.1319557413042; Tue, 25
 Oct 2011 08:43:33 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Tue, 25 Oct 2011 08:42:53 -0700 (PDT)
In-Reply-To: <4EA6D594.90402@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184213>

On Tue, Oct 25, 2011 at 5:28 PM, Johannes Sixt <j.sixt@viscovery.net> w=
rote:
> Am 10/25/2011 16:55, schrieb Erik Faye-Lund:
>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>> +{
>> + =A0 =A0 if (mutex->autoinit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 if (InterlockedCompareExchange(&mutex->aut=
oinit, -1, 1) !=3D -1) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 pthread_mutex_init(mutex, =
NULL);
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 mutex->autoinit =3D 0;
>> + =A0 =A0 =A0 =A0 =A0 =A0 } else
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 while (mutex->autoinit !=3D=
 0)
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 ; /* wait =
for other thread */
>> + =A0 =A0 }
>
> The double-checked locking idiom. Very suspicious. Can you explain wh=
y it
> works in this case? Why are no Interlocked functions needed for the o=
ther
> accesses of autoinit? ("It is volatile" is the wrong answer to this l=
ast
> question, BTW.)

I agree that it should look a bit suspicious; I'm generally skeptical
whenever I see 'volatile' in threading-code myself. But I think it's
the right answer in this case. "volatile" means that the compiler
cannot optimize away accesses, which is sufficient in this case.

Basically, the thread that gets the original 1 returned from
InterlockedCompareExchange is the only one who writes to
mutex->autoinit. All other threads only read the value, and the
volatile should make sure they actually do. Since all 32-bit reads and
writes are atomic on Windows (see
http://msdn.microsoft.com/en-us/library/windows/desktop/ms684122(v=3Dvs=
=2E85).aspx
"Simple reads and writes to properly-aligned 32-bit variables are
atomic operations.") and mutex->autoinit is a LONG, this should be
safe AFAICT. In fact, Windows specifically does not have any
explicitly atomic writes exactly for this reason.

The only ways mutex->autoinit can be updated is:
- InterlockedCompareExchange compares it to 1, finds it's identical
and inserts -1
- intialization is done
Both these updates happens from the same thread.

Yes, details like this should probably go into the commit message ;)

If there's something I'm missing, please let me know.
