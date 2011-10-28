From: Atsushi Nakagawa <atnak@chejz.com>
Subject: Re: [msysGit] Re: [PATCH/RFC] mingw: implement PTHREAD_MUTEX_INITIALIZER
Date: Sat, 29 Oct 2011 03:35:46 +0900
Message-ID: <20111029033542.5C66.B013761@chejz.com>
References: <20111028080033.57FC.B013761@chejz.com> <CAGZ=bqKA7P_FJz447AZA5HjWdghKnZqAWGuKAuvjsGp5bAGC1w@mail.gmail.com>
Reply-To: Atsushi Nakagawa <atnak@chejz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Cc: kusmabite@gmail.com, Johannes Sixt <j6t@kdbg.org>,
	msysgit@googlegroups.com, git@vger.kernel.org,
	johannes.schindelin@gmx.de
To: Kyle Moffett <kyle@moffetthome.net>
X-From: git-owner@vger.kernel.org Fri Oct 28 20:35:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJrHb-0000e5-3r
	for gcvg-git-2@lo.gmane.org; Fri, 28 Oct 2011 20:35:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932091Ab1J1Sfy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Oct 2011 14:35:54 -0400
Received: from mail-qy0-f181.google.com ([209.85.216.181]:60867 "EHLO
	mail-qy0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754077Ab1J1Sfx (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Oct 2011 14:35:53 -0400
Received: by qyk27 with SMTP id 27so4842278qyk.19
        for <git@vger.kernel.org>; Fri, 28 Oct 2011 11:35:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chejz.com; s=google;
        h=date:from:to:subject:cc:reply-to:in-reply-to:references:message-id
         :mime-version:content-type:content-transfer-encoding:x-mailer;
        bh=mM+XpA8Il9IigpNLz/cxA3IUakbvgKQuspXL9lRXSgo=;
        b=k2OvQPGzOH9qyoU7G43uDAoRQBxr8uuBUJLX7zfgcSbGA8Lj5cQ6GrXx3VD10uNTNA
         661lrNh+327beD7B/rOwtxKVxpScSJi2p5LdPWy5KpC3hHvTAYkx7vw7arGnOFWknnbB
         ackfcAQItmylXQRp+wJTTPjCmhsaeeeOl+W0k=
Received: by 10.68.42.39 with SMTP id k7mr5495076pbl.71.1319826952230;
        Fri, 28 Oct 2011 11:35:52 -0700 (PDT)
Received: from [127.0.0.1] (KD113155065059.ppp-bb.dion.ne.jp. [113.155.65.59])
        by mx.google.com with ESMTPS id p5sm25657609pbk.12.2011.10.28.11.35.46
        (version=SSLv3 cipher=OTHER);
        Fri, 28 Oct 2011 11:35:48 -0700 (PDT)
In-Reply-To: <CAGZ=bqKA7P_FJz447AZA5HjWdghKnZqAWGuKAuvjsGp5bAGC1w@mail.gmail.com>
X-Mailer: Becky! ver. 2.57.01 [en]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184424>

Thanks for the explanation. :)

Kyle Moffett <kyle@moffetthome.net> wrote:
> On Thu, Oct 27, 2011 at 19:00, Atsushi Nakagawa <atnak@chejz.com> wrote:
> > Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> On Wed, Oct 26, 2011 at 5:44 AM, Kyle Moffett <kyle@moffetthome.net> wrote:
> >> > On Tue, Oct 25, 2011 at 16:51, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> >> >> [...]
> >> >
> >> > No, I'm afraid that won't solve the issue (at least in GCC, not sure about MSVC)
> >> >
> >> > A write barrier in one thread is only effective if it is paired with a
> >> > read barrier in the other thread.
> >> >
> >> > Since there's no read barrier in the "while(mutex->autoinit != 0)",
> >> > you don't have any guaranteed ordering.
> >
> > Out of curiosity, where could re-ordering be a problem here?  I'm
> > thinking probably at "EnterCriticalSection(&mutex->cs)" and the contents
> > of "mutex->cs" not being propagated to the waiting thread.  However,
> > shouldn't that be a non-problem, as far as compiler reordering goes,
> > because it's an external function call and only the address of mutex->cs
> > is passed?
> >
> > [...]
> 
> Ok, so here's the race condition:
> 
> Thread1				Thread2
> 				/* Speculative prefetch */
> 				prefetch(*mutex);
> 
> if (mutex->autoinit) {
> if (ICE(&mutex->autoinit, -1, 1) != -1) {
> /* Now mutex->autoinit == -1 */
> pthread_mutex_init(mutex, NULL);
> /* This forces writes out to memory */
> ICE(&mutex->autoinit, 0, -1);
> 
> 				if (mutex->autoinit) {} /* false */
> 				/* No read barrier here */
> 				EnterCriticalSection(&mutex->cs);
> 				/* Use cached mutex->cs from earlier */

Ok, so there's no way of skimping on that one memory barrier in every
visit to pthread_mutex_lock().  Interesting.  Makes me wonder how it
trades off to lazy initialization.
> 
> Even though you forced the memory write to be ordered in Thread 1 you
> did not ensure that the read of autoinit occurred before the read of
> mutex->cs in Thread 2.  If the first thing that EnterCriticalSection
> does is follow a pointer or read a mutex key value in mutex->cs then
> won't necessarily get the right answer.
> 
> The rule of memory barriers is the ALWAYS come in pairs.  This simple
> example guarantees that Thread2 will read "tmp_a" == 1 if it
> previously read "tmp_b" == 1, although getting "tmp_a" == 1 and
> "tmp_b" != 1 is still possible.
> 
> Thread1:
> a = 1;
> write_barrier();
> b = 1;
> 
> Thread2:
> tmp_b = b;
> read_barrier();
> tmp_a = a;
> 
> I think there's a Documentation/memory-barriers.txt file in the kernel
> source code with more helpful info.

-- 
Atsushi Nakagawa
<atnak@chejz.com>
Changes are made when there is inconvenience.
