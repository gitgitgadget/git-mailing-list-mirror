From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH 2/3] fast-export: add new --refspec option
Date: Thu, 9 May 2013 17:53:52 -0500
Message-ID: <CAMP44s2yoBFZU+LzHWT30ijbQ2rknmV1ZoB9qDDYvvme2chB7g@mail.gmail.com>
References: <1368063095-22861-1-git-send-email-felipe.contreras@gmail.com>
	<1368063095-22861-3-git-send-email-felipe.contreras@gmail.com>
	<7vvc6r7pii.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Elijah Newren <newren@gmail.com>,
	Sverre Rabbelier <srabbelier@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 10 00:54:05 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UaZit-0006p3-GI
	for gcvg-git-2@plane.gmane.org; Fri, 10 May 2013 00:54:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932400Ab3EIWx4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 May 2013 18:53:56 -0400
Received: from mail-la0-f47.google.com ([209.85.215.47]:54257 "EHLO
	mail-la0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932299Ab3EIWxy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 May 2013 18:53:54 -0400
Received: by mail-la0-f47.google.com with SMTP id fh20so3417996lab.34
        for <git@vger.kernel.org>; Thu, 09 May 2013 15:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=a0FYQzNjdgwS+xLiwSTVWUbq6OHOmI7OaToDwCoZMnw=;
        b=dbkBDHE7jKT8Gs+WCvmAyRREnHt501QGtzS50Q/aU8KYms9yGzROdqaoIpEEv2yeBG
         kX6zUHn8CdjsS/6DK68oiaS7gUmN0Dnle7aPefsBoWM9y8FPUDx0js9XIpntgNESFpNX
         HF9tCuyx3n0gPAtHCIeduJo3egT7y7licGGQ7odBT/QeEsrvrMxhQTEgmYQHkwpkh1vf
         oFiq38kcVv4AQ/zEkvdLNyj/Dtgsyih3kdm+CdKiQogjBeanbWPGYfPVVbQ5kmUPSw4N
         HQ3I/lX1Uw65o5crV+nh1I/a859n9bY4Z3Vku95aJFaqEnNkwH19/GKBmSLjaQC7HxWV
         ltOQ==
X-Received: by 10.112.145.72 with SMTP id ss8mr6492776lbb.12.1368140033045;
 Thu, 09 May 2013 15:53:53 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Thu, 9 May 2013 15:53:52 -0700 (PDT)
In-Reply-To: <7vvc6r7pii.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223793>

On Thu, May 9, 2013 at 5:32 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> +test_expect_success 'use refspec' '
>> +     git fast-export --refspec refs/heads/master:refs/heads/foobar master | \
>> +             grep "^commit " | sort | uniq > actual &&
>
> You do not need backslash after the pipe symbol at the end of line;
> the shell knows you haven't finished speaking at that point.
>
> The usual "pipe hides the error status of upstream commands" applies
> here.  The command may die after writing enough to fill the pipe
> buffer and showing the lines that begin with "commit".
>
> Also it makes it harder to debug the test when something goes wrong.
>
> By the way, don't you find that something does not feel quite right
> with this command line?
>
>     git fast-export --refspec=refs/heads/master:refs/heads/foobar master
>
> Why do we even have to say "master" at the end, when the other
> option makes it clear that we are shipping "master" out?
>
> Without thinking ramifications through, my gut feeling is that it
> would feel more natural if we took:
>
>     git fast-export master:foobar
>
> to mean the same thing (which is what happens to the users of "git
> push").  Is there a case where you have some ref on the left hand
> side of the --refspec but you do not push out the history leading to
> it?
>
> With such an update, this part of the test would of course look
> like:
>
>         git fast-export master:foobar >actual.dump &&
>         grep "^commit " actual.dump |
>         sort -u >actual &&
>         ...
>
> and we do not need a new option.  Just a new extension to express
> what gets pushed out.
>
> But of course I may be missing some cases why there need to be a
> separate option.

Of course, but how do you implement that? That's mixing refspecs and
revlist arguments, which AFAIK don't mix:

% git fast-export ^next:new-next master:new-master --not
refs/tags/*:refs/tags/backup/*

-- 
Felipe Contreras
