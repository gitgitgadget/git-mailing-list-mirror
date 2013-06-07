From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: Re: [PATCH] t0005: skip signal death exit code test on Windows
Date: Fri, 7 Jun 2013 12:12:52 +0200
Message-ID: <CABPQNSYLmFWkdgph6W7MwaSTe+zrU0AaJpj_v9z=cmvWu64HNA@mail.gmail.com>
References: <7vtxld30f2.fsf@alter.siamese.dyndns.org> <51AEE1C3.9020507@viscovery.net>
 <20130605071206.GC14427@sigill.intra.peff.net> <51B02D81.3000700@viscovery.net>
 <20130606063754.GA20050@sigill.intra.peff.net> <CAMP44s2L4EOG7aEOR8gqXeaHm7SeuPg=GQAWX3PByKKbtTHnwQ@mail.gmail.com>
 <20130606064409.GA20334@sigill.intra.peff.net> <7vy5anyx1w.fsf@alter.siamese.dyndns.org>
 <20130606174032.GB32174@sigill.intra.peff.net>
Reply-To: kusmabite@gmail.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Junio C Hamano <gitster@pobox.com>,
	Felipe Contreras <felipe.contreras@gmail.com>,
	Johannes Sixt <j.sixt@viscovery.net>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jun 07 12:13:38 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uktfu-0003jT-3k
	for gcvg-git-2@plane.gmane.org; Fri, 07 Jun 2013 12:13:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752395Ab3FGKNe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jun 2013 06:13:34 -0400
Received: from mail-ie0-f172.google.com ([209.85.223.172]:59468 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752047Ab3FGKNd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jun 2013 06:13:33 -0400
Received: by mail-ie0-f172.google.com with SMTP id 17so9965707iea.17
        for <git@vger.kernel.org>; Fri, 07 Jun 2013 03:13:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:reply-to:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=9esIU12uKO+2j7i8nxve/goFMOpli1Ia2a5TihSbgGI=;
        b=ExsNYh4OP1lTeBsFqEKm4LMFmYAkMy8vALWQZBTnXwc4yALoR0ZQBsJZmsOvQPPxUQ
         BqXA4BAQqN63tdAXXP83FMCh+DH7bCFaJ2ctFwsOzBrxB4Rr3+J2Qh7ofIPZjPmY0POx
         N0nusutbZMDcIlrMPAOue1gDqPLjriRHArA5WoMopOJgzCyCc3ho3wL1+3HyaGMz+96K
         Adw2n1a2FhCg3EoO32oQ1KvqQxAR1X89Zm7AAeDRxxxF8heeufWlL51FmA772cE7pW1V
         JNGa4gHCYElzQWSfRTORqQEFWNYjHyKvMF/8RFkRG9qvj22Aw3pzzOGAA2BDOStNRIiw
         zJRw==
X-Received: by 10.50.33.115 with SMTP id q19mr986047igi.108.1370600013029;
 Fri, 07 Jun 2013 03:13:33 -0700 (PDT)
Received: by 10.64.23.199 with HTTP; Fri, 7 Jun 2013 03:12:52 -0700 (PDT)
In-Reply-To: <20130606174032.GB32174@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/226617>

On Thu, Jun 6, 2013 at 7:40 PM, Jeff King <peff@peff.net> wrote:
> On Thu, Jun 06, 2013 at 10:21:47AM -0700, Junio C Hamano wrote:
>
>> > The particular deficiency is that when a signal is raise()d whose SIG_DFL
>> > action will cause process death (SIGTERM in this case), the
>> > implementation of raise() just calls exit(3).
>>
>> After a bit of web searching, it seems to me that this behaviour of
>> raise() is in msvcrt, and compat/mingw.c::mingw_raise() just calls
>> that.  In other words, "the implementation of raise()" is at an even
>> lower level than mingw/msys, and I would agree that it is a platform
>> issue.
>
> Yeah, if it were mingw_raise responsible for this, I would suggest using
> the POSIX shell "128+sig" instead. We could potentially check for
> SIG_DFL[1] mingw_raise and intercept and exit there. I don't know if
> that would create headaches or confusion for other msys programs,
> though. I'd leave that up to the msysgit people to decide whether it is
> worth the trouble.
>

...and here's the code to do just that:

diff --git a/compat/mingw.c b/compat/mingw.c
index b295e2f..8b3c1b4 100644
--- a/compat/mingw.c
+++ b/compat/mingw.c
@@ -1573,7 +1573,8 @@ static HANDLE timer_event;
 static HANDLE timer_thread;
 static int timer_interval;
 static int one_shot;
-static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL;
+static sig_handler_t timer_fn = SIG_DFL, sigint_fn = SIG_DFL,
+    sigterm_fn = SIG_DFL;

 /* The timer works like this:
  * The thread, ticktack(), is a trivial routine that most of the time
@@ -1688,6 +1689,10 @@ sig_handler_t mingw_signal(int sig,
sig_handler_t handler)
 		sigint_fn = handler;
 		break;

+	case SIGTERM:
+		sigterm_fn = handler;
+		break;
+
 	default:
 		return signal(sig, handler);
 	}
@@ -1715,6 +1720,13 @@ int mingw_raise(int sig)
 			sigint_fn(SIGINT);
 		return 0;

+	case SIGTERM:
+		if (sigterm_fn == SIG_DFL)
+			exit(128 + SIGTERM);
+		else if (sigterm_fn != SIG_IGN)
+			sigterm_fn(SIGTERM);
+		return 0;
+
 	default:
 		return raise(sig);
 	}
