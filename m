From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 18:01:03 -0400
Message-ID: <CAPZPVFZHyzPZnyg5gjhL0tP6Kgd=XFLc6o8ZKsmPXLUSdcc5mA@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYtVsPrFEMcx9UBQzJffi9tRduDqLfUF1vGR=WSKL95aQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 00:01:12 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKEwn-0002mF-Nb
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 00:01:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755687Ab3ILWBG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 18:01:06 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:47351 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753793Ab3ILWBE (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 18:01:04 -0400
Received: by mail-wi0-f172.google.com with SMTP id c10so3785wiw.17
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 15:01:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=qnLIsAA6zNDLHpzoZkQ6qVnFb29FBkUR38klK6dAUPk=;
        b=ttrRTeH6QKk5Lu5EjE1cnh0RQh7cQTWYfNXXdAAyCbHAVbrGHTImLZuxjjuf0YDniV
         6oauy9Ct1cSpXEpx7CdwToVZtxwv37T+KqHE2az22XztE8D85Gub+bAeRNF9ZDICYfwv
         F0bNlYRgRsevdUsCEj+c5VaDUvvzOdzxjgcEaUVInRuTYkl6sX8krNEfR+szNoHgN9oO
         MeaRV7YWkv+Ur7raZcKdiIDlH5SECAJbj90GkkcDsgka8qtdA9YY+afyb9tKsgDTNM9C
         8k9TTOttp9vSwefbh54QxzwQRMvguOpt6K6jA5vmB9c3lgPkZW0L97pVHqDhrep3lAZl
         b3AQ==
X-Received: by 10.194.123.227 with SMTP id md3mr8110314wjb.17.1379023263816;
 Thu, 12 Sep 2013 15:01:03 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Thu, 12 Sep 2013 15:01:03 -0700 (PDT)
In-Reply-To: <CAPZPVFYtVsPrFEMcx9UBQzJffi9tRduDqLfUF1vGR=WSKL95aQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234702>

On Thu, Sep 12, 2013 at 5:16 PM, Eugene Sajine <euguess@gmail.com> wrote:
> Junio,
>
> Thanks for the clarification! Your solution does look better.
>
> For now though i think i will have to delay the notification somehow
> and let the service finish first then notify the server.
>
> Thanks again!
>
> Eugene
>
>
> On Thu, Sep 12, 2013 at 5:08 PM, Junio C Hamano <gitster@pobox.com> wrote:
>> Eugene Sajine <euguess@gmail.com> writes:
>>
>>> So are you really sure that it is a non-starter to have
>>> --before-service/--after-service options for access-hook?
>>
>> Given the definition of "--access-hook" in "git help daemon":
>>
>>     --access-hook=<path>::
>>             Every time a client connects, first run an external command
>>             specified by the <path> ... The external command can decide
>>             to decline the service by exiting with a non-zero status (or
>>             to allow it by exiting with a zero status)....
>>
>> There is *NO* way in anywhere --after-service makes any sense (and
>> by definition --before-service is redundant).
>>
>> What you _could_ propose is to define a *new* hook that is run when
>> the spawned service has returned, with the same information that is
>> fed to the access hook (possibly with its exit status).
>>
>> I do not offhand know if we retain the original service information
>> that long after the main daemon process has spawned the service
>> process, though.  With the current system, the only thing it needs
>> to know is the PID of the service processes that are to be culled by
>> calls to waitpid().  So you may have to extend existing bookkeeping
>> data structures a bit to keep those pieces of information around if
>> you wanted to add such a new hook.
>>
>>

For now I'm trying to do the following:

access-hook.bash has:

delayed-notify.bash $@ &

delayed-notify.bash has:

sleep 10
...
curl ...

I'm expecting access-hook to spawn new process and return without
waiting for it to finish to let the service to do its job. But when i
do push - it sleeps for 10 seconds anyway. Am i missing something
obvious here?

Any help is much appreciated!

Thanks,
Eugene
