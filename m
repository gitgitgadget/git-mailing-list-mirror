From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] pull: handle --log=<n>
Date: Tue, 19 May 2015 22:10:57 -0700
Message-ID: <xmqqzj4zomu6.fsf@gitster.dls.corp.google.com>
References: <1431956396-21788-1-git-send-email-pyokagan@gmail.com>
	<5661061272076a1883cfde1087be4a42@www.dscho.org>
	<xmqq617pda0r.fsf@gitster.dls.corp.google.com>
	<6b905c01c9b57abc05fb49117c28c10e@www.dscho.org>
	<CAPc5daVze4+8aLGPpZgxDnvKSwvQiaR=kRdwfAHXFYA7HChmMg@mail.gmail.com>
	<1432070690.14498.4.camel@kaarsemaker.net>
	<xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Dennis Kaarsemaker <dennis@kaarsemaker.net>,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Paul Tan <pyokagan@gmail.com>,
	Stefan Beller <sbeller@google.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed May 20 07:11:08 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YuwHb-0001Cv-LD
	for gcvg-git-2@plane.gmane.org; Wed, 20 May 2015 07:11:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751851AbbETFLD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 20 May 2015 01:11:03 -0400
Received: from mail-ig0-f178.google.com ([209.85.213.178]:34008 "EHLO
	mail-ig0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751004AbbETFLB (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 20 May 2015 01:11:01 -0400
Received: by igbhj9 with SMTP id hj9so52190770igb.1
        for <git@vger.kernel.org>; Tue, 19 May 2015 22:11:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=Bh/vbpJVwq9Gq/z2DK/ZIH5oRK+AO1/sBUMzXPhWyhQ=;
        b=zu8z39KpkI+uzHz3pDjIsbcfND7mbCMyD2WqvTTJVhbOGDc2wlsuHCKRg7CRFLvqqn
         zM4VTQHb6deHQWhjlw0f+steq9b3736AYSGN5amTn6Jm0XBbAROxWI4c9cCFBThjNWy8
         goSfYwgPndhUYfc6j3sioGURG57DpWC+DQsweEGn5MIAPMNDCuvzg8snyYU7joyEwK6T
         PP8i4FWrCrFbKYMTpP1snnFojO6QSFqC9CHgQkh5N/CAdvUeELSU7APZYkQ0xhlCNM6u
         IapFm/nr4GL4oj3tE8MYL899hn9yQCQvNdI+O2YIqW076cTTe2FQYr+T2YippHwrcNQt
         +9MQ==
X-Received: by 10.50.13.67 with SMTP id f3mr25840926igc.12.1432098660896;
        Tue, 19 May 2015 22:11:00 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:6ddd:2b37:d23b:a593])
        by mx.google.com with ESMTPSA id s5sm873661igh.6.2015.05.19.22.10.58
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 19 May 2015 22:10:58 -0700 (PDT)
In-Reply-To: <xmqqfv6s6ygb.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 19 May 2015 14:37:24 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/269438>

Junio C Hamano <gitster@pobox.com> writes:

> A proper patch series would probably be
>
>  [1/N]   Teach "test_commit --tag" and replace existing "test_commit"
>          with "test_commit --tag"
>
>  [2-N/N] For all the test scripts, analyse and judge if they are
>          better off with the auto-generated tags (i.e. no change wrt
>          the result of 1/N) or tags that are created by the script
>          at strategic places only as needed, and convert those that
>          are better read without "test_commit --tag".
>
> [1/N] would be mechanical and easy, but justifying the change in the
> remainder would be a lot of work and reviewing would be, too, and
> would require a good taste.

Actually even the above is not sufficient, as we have to worry about
topics in-flight (aka "the rest of the world is not standing still
waiting for you").  It must go more like this:

 [1/N]   Introduce a new helper (let's call it "make_commit") that
         by default does not do too much but optionally can do as much
         as the "test_commit" does.  Reimplement "test_commit" in
         terms of "make_commit"

 [2-N/N] Exaine existing uses of "test_commit" and reduce what they
         do by rewriting them with "make_commit" as needed.

So I'd say 1/N may probably be something worth doing, but I am not
convinced that the rest is a good use of reviewer's time.

Speaking of "does not do too much", I think the behaviour of
"test_commit" that always adds new a file outlived its usefulness.

When a test is primarily interested in the topology of the resulting
history (most "log" tests are), we can use "commit --allow-empty"
these days (I think "test_commit" predates it and adding a file may
have been a handy way to ensure that the new commit's tree is
different from parent's).  And when a test is primarily about how
branches with different contents in various paths interact with each
other (e.g. checking out, merging), it does not make a very useful
test vector to work on if you can only build your tests with a set
of branches whose differences can only be creation and deletion but
never in-place modification of paths.

Among various potential uses of the hypothetical "test_commit"
replacement that I would imagine, what is common is only that it
does the "tick" thing and then it creates a commit, and nothing
else.  Everything else is optional and needs customization.  But
then there is not much left, i.e.

    make_commit () {
	test_tick && git commit --allow-empty "$@"
    }

which may be useful to avoid forgetting the tick thing, but does not
help much else.

Even if that were found to be useful, this discussion is only for
step 1/N; let's refrain from rewriting everything for the sake of
rewriting.  I do not think it would be a good use of developer time
or reviewer time.
