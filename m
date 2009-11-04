From: "Andrzej K. Haczewski" <ahaczewski@gmail.com>
Subject: Re: [PATCH] MSVC: port pthread code to native Windows threads
Date: Wed, 4 Nov 2009 14:47:09 +0100
Message-ID: <16cee31f0911040547m69e5b9cbi30e20d2a7790bd6f@mail.gmail.com>
References: <1257283802-29726-1-git-send-email-ahaczewski@gmail.com>
	 <1257331059-26344-1-git-send-email-ahaczewski@gmail.com>
	 <4AF175E8.7020400@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Wed Nov 04 14:47:27 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N5gCl-0007EY-Cw
	for gcvg-git-2@lo.gmane.org; Wed, 04 Nov 2009 14:47:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756096AbZKDNrH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Nov 2009 08:47:07 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755683AbZKDNrG
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Nov 2009 08:47:06 -0500
Received: from gv-out-0910.google.com ([216.239.58.185]:49200 "EHLO
	gv-out-0910.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754125AbZKDNrF (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Nov 2009 08:47:05 -0500
Received: by gv-out-0910.google.com with SMTP id r4so868200gve.37
        for <git@vger.kernel.org>; Wed, 04 Nov 2009 05:47:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=JFSzpiXavPtkCypUiwHKJToNLIiF6zFkmf7wRkJc1Ys=;
        b=FM6RGCq1bJBjThZyNIhprR6S9MDi10B28trl/qHZDJ0krSRNYScRJIKT14KO0cwjEM
         X0wrYbrp5z1POgrEtv8fnzRs2I9l/2aaG5QWCLZ6thWiwkEqTmj5alkTm0BCveSqBr6w
         q/si5K5koPQxvctfSDdQtq1ZxEhNVW1Mml5hg=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=bL7vJmRTw5cn3OZuznxXDUQ+76ZRc81gdO+jCM3Kcu3zXwl/n0AWMgs9F5htV+Dt0A
         Kl92QXZnO9jDgL/JBx2ld2rtrYd3EK4zYpvUmIfQHjng4aW9YgQsxFtCHjIFhLmMStPO
         l5fMylIgbYmL/yhlypvkiABjyLa7GwEGH5XjM=
Received: by 10.239.163.222 with SMTP id q30mr164834hbd.128.1257342429314; 
	Wed, 04 Nov 2009 05:47:09 -0800 (PST)
In-Reply-To: <4AF175E8.7020400@viscovery.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/132084>

2009/11/4 Johannes Sixt <j.sixt@viscovery.net>:
> Please do not cull Cc list when you resend a patch, if possible.

Ok, will do. I was sending patch using git send-email and I just
forgot to copy Cc there. Still trying to BTW is there a way to
"reformat-patch" with new amended commit and then "resend-email"?

> After staring some time on the code, I have convinced myself that the
> pthread_cond_wait and pthread_cond_signal implementation will work *in our
> usage scenario* that has these preconditions:

But it is not impossible with that implementation. I based this
implementation on ACE (Adaptive Communication Environment, large C++
library) implementation of the same concepts. All I removed from their
implementation is cond_broadcast, since it's not used by Git. I'm sure
that ACE does the best job when it comes to threading primitives.

On resubmit I'll give more credit to ACE.

> - pthread_cond_signal is called while the mutex is held.

AFAIK that is a requirement for condition variable to be signaled
while holding the same mutex that other threads cond_wait on. I just
don't check that it is true, because Git is locking mutex.

> - We retest the condition after pthread_cond_wait returns.
>
> These conditions should be attached in BIG BOLD letters to this
> implementation; particularly, the last one.

That's also a known requirement for working with cond vars. Here's
excerpt from pthread_cond_wait man page:
When using condition variables there is always a boolean predicate
involving shared variables associated with each condition wait that is
true if the thread should proceed. Spurious wakeups from the
pthread_cond_wait() or pthread_cond_timedwait() functions may occur.
Since the return from pthread_cond_wait() or pthread_cond_timedwait()
does not imply anything about the value of this predicate, the
predicate should be re-evaluated upon such return.

> The subject is a bit misleading, IMHO. You are not porting the
> (p)threading code, but you are adding pthread_* function wrappers for Windows.
>
> Your patch adds whitespace-at-eol. Please use git show --check to see where.
>
> Please drop words from the commit message that do not make sense once this
> commit is in git's history. Look at existing commit messages to get a
> feeling for the style. Do write about "why" (motivation), "how" (design
> choices) and "how not" (dead ends that you tried).
>

Ok, thanks for pointing that out.

> I think it would be OK to drop '= PTHREAD_{MUTEX,COND}_INITIALIZER' and
> use *_init function calls without the #ifdef. Likewise for *_destroy.

Actually it won't save us many #ifdefs. There's one #ifdef for
initialization that could be saved, but then comes #ifdef for cleanup:
#if defined(THREADED_DELTA_SEARCH) && defined(_WIN32)

What you propose will remove one #ifdef _WIN32 for initialization, but
the cleanup will look almost the same:
#ifdef THREADED_DELTA_SEARCH

>
> -- Hannes
>

Thanks for awesome review, I'll fix all those returns and whitespaces
and resubmit.

--
Andrzej
