From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Thu, 12 Sep 2013 19:17:08 -0400
Message-ID: <CAPZPVFYY6Q=zZ62mY6uGi6O7KaOO8NhUEH0YUgcQE3NBvHQEpg@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
	<xmqqa9jhof6k.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 01:17:24 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKG8Q-0000dQ-N3
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 01:17:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756459Ab3ILXRL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 Sep 2013 19:17:11 -0400
Received: from mail-we0-f170.google.com ([74.125.82.170]:39146 "EHLO
	mail-we0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753413Ab3ILXRJ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Sep 2013 19:17:09 -0400
Received: by mail-we0-f170.google.com with SMTP id w62so458536wes.1
        for <git@vger.kernel.org>; Thu, 12 Sep 2013 16:17:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=HWtuCt8o2UwIgdwZgRiN7pc5Ft+6jJsuyLOLbNMSv+c=;
        b=E9uH26U0jdHkzzXfGpwt5gODZq3IYIz24km7L2B4BPPuTrFb3aAJMg2M4btFL52RR0
         aFkedVBOjG/H4hd8CcOZcIRN767Wn3RTVdcucEUoEmqyzjWXmavoGo9KjSQZbrfXTFqD
         rx1T6k4HxAhYYc3uoxzz1NU8ozw/0VhHhzTNBOlmgd1NT0wO1OCjHq7LSbUKYZZZRbYu
         e8L9zjQWEFYac8T9fSoAvDwtop96aXnDZoTYxrsGMg/kb2cPPsm7QUj8o/CoUF2WuINu
         T0BKMhP14CenC5AP9L5vWpsnEvqNvhaFwwMVxOSv7sWMpuRSVIesoaclhRPGGid4sngi
         M7AQ==
X-Received: by 10.180.75.239 with SMTP id f15mr91860wiw.43.1379027828181; Thu,
 12 Sep 2013 16:17:08 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Thu, 12 Sep 2013 16:17:08 -0700 (PDT)
In-Reply-To: <xmqqa9jhof6k.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234711>

On Thu, Sep 12, 2013 at 6:20 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Junio C Hamano <gitster@pobox.com> writes:
>
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
>
> Scratch that "exit status" part, as I do not think it is useful.
>
> To a receive-pack and a send-pack that is talking to it, if a push
> results in a failure, it is a failure.  Likewise for upload-pack and
> fetch-pack for a transfer in the reverse direction.
>
> And the way that failure is communicated from the receive-pack to
> the end-user via the send-pack is for the receive-pack to send a
> protocol message that tells the send-pack about the failure, and the
> send-pack showing the error message and signalling the failure with
> its exit status.  Likewise for upload-pack and fetch-pack (hence
> "fetch", which is conceptually a thin wrapper around it).
>
> Between the deamon and the receive-pack (or the fetch-pack) process,
> however, such a failed push (or fetch) is still a success.  "I
> correctly diagnosed and successfully sent a rejection notice to the
> other end" is signalled by receive-pack to the daemon by exiting
> with success (i.e. 0) exit status.
>
> So even if we feed the exit status of the service process to the
> hook script specified by the --post-service-hook, it does not tell
> the script if the service "succeeded" in that sense.


I see what you're saying.
In my particular use case I can work around that service status
because even if it failed it will just trigger Jenkins to poll and in
case of failure to transfer data there will be no new changes for
Jenkins to work with. If we would want the --post-service-hook to know
that data transfer succeeded or failed, then may be there should be
some difference between "service status" and "service process status"?
In this case the existing logic works with "service process status"
while the --post-service-hook is fed with the "service status" (or
name it "data transfer status")

Do i make any sense?
