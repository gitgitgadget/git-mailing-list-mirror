From: Victor Leschuk <vleschuk@accesssoftek.com>
Subject: RE: thread-utils: build with NO_PTHREADS fails
Date: Wed, 14 Oct 2015 04:24:03 -0700
Message-ID: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9ED@mail.accesssoftek.com>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8@mail.accesssoftek.com>
	<xmqq7fmsnkp9.fsf@gitster.mtv.corp.google.com>,<xmqqd1wkm0om.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>,
	"vleschuk@gmail.com" <vleschuk@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Oct 14 13:25:24 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZmKBI-0007pJ-JJ
	for gcvg-git-2@plane.gmane.org; Wed, 14 Oct 2015 13:25:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753373AbbJNLZL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Oct 2015 07:25:11 -0400
Received: from mail.accesssoftek.com ([12.202.173.171]:25682 "EHLO
	mail.accesssoftek.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751731AbbJNLZJ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Oct 2015 07:25:09 -0400
Received: from mail.accesssoftek.com ([172.16.0.71]) by mail.accesssoftek.com
 ([172.16.0.71]) with mapi; Wed, 14 Oct 2015 04:25:06 -0700
Thread-Topic: thread-utils: build with NO_PTHREADS fails
Thread-Index: AdEFF00LRbFGOTw+S1Wz7k2RrvcusABW4fRx
In-Reply-To: <xmqqd1wkm0om.fsf@gitster.mtv.corp.google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
acceptlanguage: en-US
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279569>

Hello Junio, 

sorry that was my fault, I was building it wrong way (defined NO_PTHREADS in CFLAGS variable, not as separate make variable). Sorry for the false alarm.

--
Best Regards,
Victor
________________________________________
From: Junio C Hamano [jch2355@gmail.com] On Behalf Of Junio C Hamano [gitster@pobox.com]
Sent: Monday, October 12, 2015 10:55 AM
To: Victor Leschuk
Cc: git@vger.kernel.org; vleschuk@gmail.com
Subject: Re: thread-utils: build with NO_PTHREADS fails

Junio C Hamano <gitster@pobox.com> writes:

> Victor Leschuk <vleschuk@accesssoftek.com> writes:
>
>> I think that no one tried it for a long time but I needed a
>> single-threaded git version for debug purpose. I tried to build
>> with -DNO_PTHREADS and thread-utils.c failed to compile.
>>
>> In brief the situation is the following:
>>
>> in header file we have something like that:
>>
>>
>> #ifndef NO_PTHREAD
>> extern int online_cpus(void);
>>
>> #else
>> #define online_cpus() 1
>> #endif // NO_PTHREAD
>>
>> and in *.c file:
>>
>>
>> int online_cpus(void)
>> {
>>     // ...
>> }
>
> Yeah, that is obviously incorrect.
> ...

Well, no, I spoke too early.  I do not see there is much wrong here.

There is this bit in the Makefile:

        ifdef NO_PTHREADS
                BASIC_CFLAGS += -DNO_PTHREADS
        else
                BASIC_CFLAGS += $(PTHREAD_CFLAGS)
                EXTLIBS += $(PTHREAD_LIBS)
                LIB_OBJS += thread-utils.o
        endif

The source file thread-utils.c is not compiled to thread-utils.o if
you say NO_PTHREADS, and the resulting libgit.a does not of course
have it.
