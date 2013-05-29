From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 1/2] sequencer: trivial fix
Date: Tue, 28 May 2013 21:32:59 -0500
Message-ID: <51a568db9c9b8_807b33e18996fa@nysa.mail>
References: <1369673539-28692-1-git-send-email-felipe.contreras@gmail.com>
 <1369673539-28692-2-git-send-email-felipe.contreras@gmail.com>
 <20130528110014.GA1264@hmsreliant.think-freely.org>
 <7vobbv2fze.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: 7bit
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Christian Couder <chriscool@tuxfamily.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Junio C Hamano <gitster@pobox.com>,
	Neil Horman <nhorman@tuxdriver.com>
X-From: git-owner@vger.kernel.org Wed May 29 04:38:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhWHl-0005LH-5H
	for gcvg-git-2@plane.gmane.org; Wed, 29 May 2013 04:38:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759392Ab3E2Cil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 22:38:41 -0400
Received: from mail-ob0-f179.google.com ([209.85.214.179]:50443 "EHLO
	mail-ob0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1759366Ab3E2Cik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 22:38:40 -0400
Received: by mail-ob0-f179.google.com with SMTP id xk17so350839obc.38
        for <git@vger.kernel.org>; Tue, 28 May 2013 19:38:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:message-id:in-reply-to:references:subject
         :mime-version:content-type:content-transfer-encoding;
        bh=Ooo9zWWo7BnQgAvl1E+biukrbH8jSQWEXv6o2/DTUD8=;
        b=ZzkFrJOokf/cLRQtGBMswSM9ZClUGRTgIgwDbw3uTADlsXovULg1vBVIhGcod9HVTK
         15N3SPqOjO+0uVc5uKobqrkOo0st/apevykrj89D63JSLLQOqZXVAdEc9JIgCS+z6QRw
         j6qQuJOnakho0b+Q41h1gpOtle7Oabnx8QGs+xDRmETJZyDYDuVqCAqb+hsanoO2B8kO
         G5OqeYba3yalG3hpDHMlmQcIJhvdbdsJSzuTKRj47LF03kGLeBrRZmQqnrtBvr4pjGHE
         1vWYnenNABpzqheiIX0v7sfwRk2e3iZ+1OvA4IDixpkIHubr2zFdigFbmdb9XOMrqq45
         5f0Q==
X-Received: by 10.60.102.145 with SMTP id fo17mr365508oeb.76.1369795119973;
        Tue, 28 May 2013 19:38:39 -0700 (PDT)
Received: from localhost (187-163-100-70.static.axtel.net. [187.163.100.70])
        by mx.google.com with ESMTPSA id b5sm37969496oby.12.2013.05.28.19.38.38
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 28 May 2013 19:38:39 -0700 (PDT)
In-Reply-To: <7vobbv2fze.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225700>

Junio C Hamano wrote:
> Neil Horman <nhorman@tuxdriver.com> writes:
> 
> > On Mon, May 27, 2013 at 11:52:18AM -0500, Felipe Contreras wrote:
> >> We should free objects before leaving.
> >> 
> >> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
> >> ---
> >>  sequencer.c | 7 +++++--
> >>  1 file changed, 5 insertions(+), 2 deletions(-)
> >> 
> >> diff --git a/sequencer.c b/sequencer.c
> >> index ab6f8a7..7eeae2f 100644
> >> --- a/sequencer.c
> >> +++ b/sequencer.c
> >> @@ -626,12 +626,15 @@ static int do_pick_commit(struct commit *commit, struct replay_opts *opts)
> >>  		rerere(opts->allow_rerere_auto);
> >>  	} else {
> >>  		int allow = allow_empty(opts, commit);
> >> -		if (allow < 0)
> >> -			return allow;
> >> +		if (allow < 0) {
> >> +			res = allow;
> >> +			goto leave;
> >> +		}
> >>  		if (!opts->no_commit)
> >>  			res = run_git_commit(defmsg, opts, allow);
> >>  	}
> >>  
> >> +leave:
> >>  	free_message(&msg);
> >>  	free(defmsg);
> >>  
> >> -- 
> >> 1.8.3.rc3.312.g47657de
> >> 
> >> 
> > Acked-by: Neil Horman <nhorman@tuxdriver.com>
> 
> This is better done without "goto" in general.
> 
> The other patch 2/2/ adds one more "we need to exit from the middle
> of the flow" and makes it look handier to add an exit label here,
> but it would be even better to express the logic of that patch as a
> normal cascade of if/else if/..., which is small enough and we do
> not need the "leave:" label.

Linux kernel developers would disagree. In C 'goto' is quite of then the only
sane option, and you can see 'goto' used in the Linux kernel all over the place
for that reason.

In this particular case it also makes perfect sense.

> It probably is better to fold this patch into the other one when it
> is rerolled to correct the option name gotcha "on the tin".

Why? This patch is standalone and fixes an issue that is independent of the
other patch. Why squash two patches that do *two* different things?

Anyway, I'll happily drop this patch if you want this memory leak to remain.
But then I'll do the same in the other patch.

This mantra of avodiing 'goto' is not helping anybody.

-- 
Felipe Contreras
