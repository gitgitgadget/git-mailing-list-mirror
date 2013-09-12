From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 17:16:26 -0400
Message-ID: <CAPZPVFYtVsPrFEMcx9UBQzJffi9tRduDqLfUF1vGR=WSKL95aQ@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Sep 12 23:16:33 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKEFb-00081h-Lx
	for gcvg-git-2@plane.gmane.org; Thu, 12 Sep 2013 23:16:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756485Ab3ILVQ1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 17:16:27 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:64640 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755466Ab3ILVQ1 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 17:16:27 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so366559wes.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 14:16:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=XIuwhUL6h9BrqWjae6HRYQKh8j4gvwp6nrd2s6XWaEs=;
        b=VU5fpF/lIhMQXOYz+qKK04LECkzSAbXkefwcy6koXezJ57EpuwI6xgZ0XKakdfk99e
         7FHb5crqSbYJn8t0AJhZuJq2l7dKLexMYBvkEj13hOMH2UCXupR6okKBy0zpXp3WAjK2
         vwpIUZRfdebDzW0gf/cysVmdfpJPnoon1Ey8pGrSIZW23kXCVodWlCz5oxJZ9K6s/z3e
         YxuHqgjazf86lcW7hpCMBvfEcGsde9TdWs205J3baixxIadOWBwJheOwwYo72CCHgG1/
         OW0B+IXuzFYmaVr+sHAbwfLnx+UvGZhFhHQcflQh8kjpLB6jpE8hU+VX4CTzzFX1yMDa
         NDuA==
X-Received: by 10.180.13.83 with SMTP id f19mr7591247wic.54.1379020586235;
 Thu, 12 Sep 2013 14:16:26 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Thu, 12 Sep 2013 14:16:26 -0700 (PDT)
In-Reply-To: <xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234699>

Junio,

Thanks for the clarification! Your solution does look better.

For now though i think i will have to delay the notification somehow
and let the service finish first then notify the server.

Thanks again!

Eugene


On Thu, Sep 12, 2013 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Eugene Sajine <euguess@gmail.com> writes:
>
>> So are you really sure that it is a non-starter to have
>> --before-service/--after-service options for access-hook?
>
> Given the definition of "--access-hook" in "git help daemon":
>
>     --access-hook=<path>::
>             Every time a client connects, first run an external command
>             specified by the <path> ... The external command can decide
>             to decline the service by exiting with a non-zero status (or
>             to allow it by exiting with a zero status)....
>
> There is *NO* way in anywhere --after-service makes any sense (and
> by definition --before-service is redundant).
>
> What you _could_ propose is to define a *new* hook that is run when
> the spawned service has returned, with the same information that is
> fed to the access hook (possibly with its exit status).
>
> I do not offhand know if we retain the original service information
> that long after the main daemon process has spawned the service
> process, though.  With the current system, the only thing it needs
> to know is the PID of the service processes that are to be culled by
> calls to waitpid().  So you may have to extend existing bookkeeping
> data structures a bit to keep those pieces of information around if
> you wanted to add such a new hook.
>
>
