From: Mark Levedahl <mlevedahl@gmail.com>
Subject: Re: [RFC/PATCH v2 1/1] cygwin: Add fast_lstat() and fast_fstat()
 functions
Date: Mon, 15 Jul 2013 23:54:40 -0400
Message-ID: <51E4C400.6000009@gmail.com>
References: <51DDC2AF.9010504@ramsay1.demon.co.uk> <51E2CE97.2040900@gmail.com> <7vppuja9ip.fsf@alter.siamese.dyndns.org> <51E4AABD.9010701@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	Johannes Sixt <j6t@kdbg.org>,
	"Shawn O. Pearce" <spearce@spearce.org>, dpotapov@gmail.com,
	GIT Mailing-list <git@vger.kernel.org>
To: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Tue Jul 16 05:54:49 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UywLg-0006Qc-C8
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jul 2013 05:54:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758633Ab3GPDyo convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 15 Jul 2013 23:54:44 -0400
Received: from mail-qe0-f46.google.com ([209.85.128.46]:41862 "EHLO
	mail-qe0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755170Ab3GPDyo (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Jul 2013 23:54:44 -0400
Received: by mail-qe0-f46.google.com with SMTP id nd7so120576qeb.33
        for <git@vger.kernel.org>; Mon, 15 Jul 2013 20:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=ZDs/EL12RgLt+8tSRfn6hpyZk9uEG9k8CSeqwvTkxfI=;
        b=aEKWS7r9qDz/xK5FFEueWEw3CJR++17tD/44HySHvDqlZRYwXxwY9hflGkxfrUtd9U
         HiJH2hJFCDvONP33YTW1gXaWxexfen8zgPhri5UtYJBZLRGmL75x0XvFqFBPfSLb7pYP
         d7w9GlMpqlP13kODJJweXG2bAm+tkcSF/riQQmNqhnASpRXszk1ZdY4tbyEnaGXvC9wc
         mB6/bl59vCrpLjYNh6Zf+WijDueSUkudJO906eUBRBGjEskKiGn53Cg4J2XkrwRwGXUi
         cFA/w0gNba4Ac2mjtEEF51FmUYuTKPv7MHyEYff6rhnXkQLSQp6nLB6RIJLV6jjQtzjN
         ECaQ==
X-Received: by 10.49.105.97 with SMTP id gl1mr54484415qeb.76.1373946883293;
        Mon, 15 Jul 2013 20:54:43 -0700 (PDT)
Received: from mark-laptop.lan (pool-72-66-83-222.washdc.fios.verizon.net. [72.66.83.222])
        by mx.google.com with ESMTPSA id 11sm60002190qek.1.2013.07.15.20.54.40
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 15 Jul 2013 20:54:42 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130625 Thunderbird/17.0.7
In-Reply-To: <51E4AABD.9010701@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230539>

On 07/15/2013 10:06 PM, Torsten B=F6gershausen wrote:
> On 2013-07-15 21.49, Junio C Hamano wrote:
>> Mark Levedahl <mlevedahl@gmail.com> writes:
>>
>>>> In order to limit the adverse effects caused by this implementatio=
n,
>>>> we provide a new "fast stat" interface, which allows us to use thi=
s
>>>> only for interactions with the index (i.e. the cached stat data).
>>>>
>>>> Signed-off-by: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
>>>> ---
>>> I've tested this on Cygwin 1.7 on WIndows 7 , comparing to the resu=
lts
>>> using your prior patch (removing the Cygwin specific lstat entirely=
)
>>> and get the same results with both, so this seems ok from me.
>>>
>>> My comparison point was created by reverting your current patch fro=
m
>>> pu, then reapplying your earlier patch on top, so the only differen=
ce
>>> was which approach was used to address the stat functions.
>>>
>>> Caveats:
>>> 1) I don't find any speed improvement of the current patch over the
>>> previous one (the tests actually ran faster with the earlier patch,
>>> though the difference was less than 1%).
> Hm, measuring the time for the test suite is one thing,
> did you measure the time of "git status" with and without the patch?
>
> (I don't have my test system at hand, so I can test in a few days/wee=
ks)
Timing for 5 rounds of "git status" in the git project. First, with the=
=20
current fast_lstat patches:
/usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null ; =
done

real    0m0.218s
user    0m0.000s
sys     0m0.218s

real    0m0.187s
user    0m0.077s
sys     0m0.109s

real    0m0.187s
user    0m0.030s
sys     0m0.156s

real    0m0.203s
user    0m0.031s
sys     0m0.171s

real    0m0.187s
user    0m0.062s
sys     0m0.124s

Now, with Ramsay's original patch just removing the non-Posix stat=20
functions:
/usr/local/src/git>for i in {1..5} ; do time git status >& /dev/null ; =
done

real    0m0.218s
user    0m0.046s
sys     0m0.171s

real    0m0.187s
user    0m0.015s
sys     0m0.171s

real    0m0.187s
user    0m0.015s
sys     0m0.171s

real    0m0.187s
user    0m0.047s
sys     0m0.140s

real    0m0.187s
user    0m0.031s
sys     0m0.156s


I see no difference in the above. (Yes, I checked multiple times that I=
=20
was using different executables).
>>> 2) I still question this whole approach, especially having this
>>> non-POSIX compliant mode be the default. Running in this mode break=
s
>>> interoperability with Linux, but providing a Linux environment is t=
he
>>> *primary* goal of Cygwin.
>> Sounds like we are better off without this patch, and instead remove
>> the "schizophrenic stat"?  I do not have a strong opinion either
>> way, except that I tend to agree with your point 2) above.
> My understanding is that we want both:
> Introduction of fast_lstat() as phase 1,
> and the removal of the "schizophrenic stat" in compat/cygwin.c
> as phase 2. (or do I missunderstand something ?)
>
>
> And yes, phase 3:
> The day we have a both reliable and fast
> lstat() in cygwin, we can remove compat/cygwin.[ch]
If you know how to make Cygwin's stat faster while maintaining Posix=20
semantics, please post a patch to the Cygwin list, they would *love* it=
=2E

Mark
