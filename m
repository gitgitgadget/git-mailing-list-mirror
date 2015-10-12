From: Junio C Hamano <gitster@pobox.com>
Subject: Re: thread-utils: build with NO_PTHREADS fails
Date: Mon, 12 Oct 2015 08:57:38 -0700
Message-ID: <xmqq7fmsnkp9.fsf@gitster.mtv.corp.google.com>
References: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8@mail.accesssoftek.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	"vleschuk\@gmail.com" <vleschuk@gmail.com>
To: Victor Leschuk <vleschuk@accesssoftek.com>
X-From: git-owner@vger.kernel.org Mon Oct 12 17:57:50 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZlfTv-0007wl-6P
	for gcvg-git-2@plane.gmane.org; Mon, 12 Oct 2015 17:57:47 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752472AbbJLP5m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 12 Oct 2015 11:57:42 -0400
Received: from mail-pa0-f43.google.com ([209.85.220.43]:33803 "EHLO
	mail-pa0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751457AbbJLP5l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 12 Oct 2015 11:57:41 -0400
Received: by padhy16 with SMTP id hy16so157297071pad.1
        for <git@vger.kernel.org>; Mon, 12 Oct 2015 08:57:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=NNLr3dRKlG/pkqRNMU/9e+Es/5BMNiO6gicPQwK06K8=;
        b=UDWKLJ30xt/TAMjPY5JOnpGS7cWmcdYZgre6z6Ir9eleg4xDLr2Y+xeO9Q+tkkBn9V
         Hblr0tOJrxid4AcfbK8Uj2GVoryx9BaCRfZQDkIzQd/qblSPkDG5j+T2G+hRxnHMORjn
         5QuUjWZ+9UuLZDxFAJy+kZs4WjOPRL3JY7JbdXVoAet8YaPXdJXJm/QUf+PWKvAHT8t8
         utzpKWNbsgU4eH+QgX/CWR/lZBZT7WJ59ULl3kJcksXQ1PJD0q554Am37vLQyzHIMfyS
         0dZPCs1mPCwxp4t2jo5IR49nAO6TBJGlGNPaaljbC/nnqAVtZhpbaV4lQt2zihoYYZlV
         8bqg==
X-Received: by 10.66.251.136 with SMTP id zk8mr35691195pac.143.1444665461283;
        Mon, 12 Oct 2015 08:57:41 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:448f:3a3:d25a:82f])
        by smtp.gmail.com with ESMTPSA id j16sm19136956pbq.23.2015.10.12.08.57.39
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 12 Oct 2015 08:57:39 -0700 (PDT)
In-Reply-To: <6AE1604EE3EC5F4296C096518C6B77EE5D0FDAB9E8@mail.accesssoftek.com>
	(Victor Leschuk's message of "Sun, 11 Oct 2015 05:58:30 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279376>

Victor Leschuk <vleschuk@accesssoftek.com> writes:

> I think that no one tried it for a long time but I needed a
> single-threaded git version for debug purpose. I tried to build
> with -DNO_PTHREADS and thread-utils.c failed to compile.
>
> In brief the situation is the following:
>
> in header file we have something like that:
>
>
> #ifndef NO_PTHREAD
> extern int online_cpus(void);
>
> #else
> #define online_cpus() 1
> #endif // NO_PTHREAD
>
> and in *.c file:
>
>
> int online_cpus(void)
> {
>     // ...
> }

Yeah, that is obviously incorrect.

The whole implementation of thread-utils.c should be enabled only
under ifndef NO_PTHREADS and thread-utils.h should also privide a
no-op macro for init_recursive_mutex() just like it already does for
online_cpus(), which would make it unnecessary to have ifndef
NO_PTHREADS sprinkled all over the place inside thread-utils.c, no?
