From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thread-utils: build with NO_PTHREADS fails
Date: Mon, 12 Oct 2015 10:55:21 -0700
Message-ID: <xmqqd1wkm0om.fsf@gitster.mtv.corp.google.com>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8@mail.accesssoftek.com>
	<xmqq7fmsnkp9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"vleschuk\@gmail.com" <vleschuk@gmail.com>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 19:55:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlhJt-0005Wl-F2
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 19:55:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752025AbbJLRz0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 13:55:26 -0400
Received: from mail-pa0-f45.google.com ([209.85.220.45]:34036 "EHLO
	mail-pa0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751822AbbJLRzX (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 13:55:23 -0400
Received: by padhy16 with SMTP id hy16so159558350pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 10:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NRRD5opnxoiTXT1btbB5YdZYv1Z6tp3onk1zPPVWDQU=;
        b=02OeQYphlhXkDCLGBgw2jwMT7kBlX80aWcqqKuMxPCGMqnI29jPST85/7cIEhfh7PI
         h+odmiHAFhi42/H6owEB58C9fE1AAzdcjLodYhhzwxKPsY0EFnK8YezFPmJnlcSWUB0y
         sK+kVbpK+svrBDb6BfDH0v7+fUEZeQSI9FAWasmdsxy+Lo/GuIxRbzOMdMlXndB3T6er
         HutfjtbhEShupaN16TDHBrP05ZbRVrrrzyM6nijagOjqR+cZWmZJhDmL5uVcMxQeFi5d
         oCc42kJCd8s5/brD3eROOfFlDJ1gL/mnm3tXkzH+FMRiJQwAHUXOo1lCKPldV8LoqODG
         cMaQ==
X-Received: by 10.66.184.42 with SMTP id er10mr36348673pac.117.1444672522803;
        Mon, 12 Oct 2015 10:55:22 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id x6sm19565150pbt.3.2015.10.12.10.55.21
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Mon, 12 Oct 2015 10:55:22 -0700 (PDT)
In-Reply-To: <xmqq7fmsnkp9.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Mon, 12 Oct 2015 08:57:38 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279389>

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
