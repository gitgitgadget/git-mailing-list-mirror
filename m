From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Wed, 26 Oct 2011 15:08:19 +0200
Message-ID: <CABPQNSbuKuZ1yY1+ex3Y=ZY=7cjLwvo3Chbwi7ApoEjUOAErbA@mail.gmail.com>
References: <1319554509-6532-1-git-send-email-kusmabite@gmail.com> <16520370.401.1319598319120.JavaMail.geo-discussion-forums@prms22>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, johannes.schindelin@gmx.de,
	j.sixt@viscovery.net
To: msysgit@googlegroups.com
X-From: git-owner@vger.kernel.org Wed Oct 26 15:09:08 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJ3EC-0000sW-9R
	for gcvg-git-2@lo.gmane.org; Wed, 26 Oct 2011 15:09:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754674Ab1JZNJA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 26 Oct 2011 09:09:00 -0400
Received: from mail-qw0-f46.google.com ([209.85.216.46]:57049 "EHLO
	mail-qw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751447Ab1JZNJA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 26 Oct 2011 09:09:00 -0400
Received: by qabj40 with SMTP id j40so1413116qab.19
        for <git@vger.kernel.org>; Wed, 26 Oct 2011 06:08:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type:content-transfer-encoding;
        bh=f8SuRp2ykt1Cg5BfcNJvfz78ypu+tXb5j1fMr3rObdo=;
        b=WGTfbgPhC532d+7L2S4zStMISURdQXUagI3wNssQs11r70cVELBRw18rmCx/pJxXhQ
         Vy97+7sUmfok8YmRKCLZGsB7YmhxQcNgn/3Ee/cQ1VmiYNeAIWaMnJ4VYcBGilrggcZi
         1IYTb984QwioW3Il5m0RE9xNIzW1DTxJaJuRU=
Received: by 10.68.28.9 with SMTP id x9mr59911919pbg.8.1319634539274; Wed, 26
 Oct 2011 06:08:59 -0700 (PDT)
Received: by 10.68.71.135 with HTTP; Wed, 26 Oct 2011 06:08:19 -0700 (PDT)
In-Reply-To: <16520370.401.1319598319120.JavaMail.geo-discussion-forums@prms22>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184260>

On Wed, Oct 26, 2011 at 5:05 AM, Atsushi Nakagawa <atnak@chejz.com> wro=
te:
> On Oct 25, 11:55 pm, Erik Faye-Lund <kusmab...@gmail.com> wrote:
>> [...]
>> +int pthread_mutex_init(pthread_mutex_t *mutex, const pthread_mutexa=
ttr_t
>> *attr)
>> +{
>> + =A0 =A0 =A0 InitializeCriticalSection(&mutex->cs);
>> + =A0 =A0 =A0 mutex->autoinit =3D 0;
>> + =A0 =A0 =A0 return 0;
>> +}
>> +
>> +int pthread_mutex_lock(pthread_mutex_t *mutex)
>> +{
>> + =A0 =A0 =A0 if (mutex->autoinit) {
>> + =A0 =A0 =A0 =A0 =A0 =A0 =A0 if (InterlockedCompareExchange(&mutex-=
>autoinit, -1, 1) !=3D
>> -1) {
> I'm making the assumption that mutex->autoinit starts off as 1 before=
 things
> get multi-threaded..
> I've only looked at what's in the patch so I could be missing vital
> context.. =A0Anyways, is there a reason why you made this
> "InterlockedCompareExchange(..., -1, 1) !=3D -1" and not
> "InterlockedCompareExchange(..., -1, 1) =3D=3D 1"?

No, not really.

> It looks to me the former adds a race condition after "if (mutex->aut=
oinit)
> {". =A0e.g. A second thread could reinitialize mutex->cs after the fi=
rst
> thread has already entered EnterCriticalSection(...).

You are indeed correct, thanks for spotting :)
