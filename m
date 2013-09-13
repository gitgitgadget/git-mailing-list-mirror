From: Eugene Sajine <euguess@gmail.com>
Subject: Re: Fwd: Fwd: git-daemon access-hook race condition
Date: Fri, 13 Sep 2013 13:17:52 -0400
Message-ID: <CAPZPVFY_AD+dg2C3TSDQW3fKXW9qiSMX70MuMtMsMxmnKBoVWA@mail.gmail.com>
References: <CAPZPVFa=gqJ26iA6eQ1B6pcbTcQmmnXHYz6OQLtMORnAa5ec2w@mail.gmail.com>
	<CAPZPVFbJqbRGQZ+m3-EfahcYegPvVcS-jNTsCXxBqWUsLqyHkg@mail.gmail.com>
	<xmqq4n9pq2av.fsf@gitster.dls.corp.google.com>
	<CAPZPVFZLPV=JVR+SSqfX-=aLyFWZBkof+yCkivcLoKNnv6f__Q@mail.gmail.com>
	<CAPZPVFZpYJnQY4BpjaPxU8NnBmPZ9Fp6UpovoQEvkKzRnLa=KA@mail.gmail.com>
	<xmqqioy5oiif.fsf@gitster.dls.corp.google.com>
	<CAPZPVFYtVsPrFEMcx9UBQzJffi9tRduDqLfUF1vGR=WSKL95aQ@mail.gmail.com>
	<CAPZPVFZHyzPZnyg5gjhL0tP6Kgd=XFLc6o8ZKsmPXLUSdcc5mA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Sep 13 19:18:00 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VKX0I-0003Qz-T4
	for gcvg-git-2@plane.gmane.org; Fri, 13 Sep 2013 19:17:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752021Ab3IMRRy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Sep 2013 13:17:54 -0400
Received: from mail-wi0-f182.google.com ([209.85.212.182]:33958 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751775Ab3IMRRy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Sep 2013 13:17:54 -0400
Received: by mail-wi0-f182.google.com with SMTP id ez12so1125151wid.15
        for <git@vger.kernel.org>; Fri, 13 Sep 2013 10:17:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=LdEhd3lEt7kgiANeiXgS6RTJfgnXFop27Ivd4rBQIEc=;
        b=LNnEHlHvcyzTswAqyj5KPfIP//qhoWYgCTRl6P8hu1Qg0mJJJSmby5BMgz50Yc/PDl
         TE5cuv/dk9u3+E+Kz55hnP5Nxhvq8c+ShVKQCInOR1IZP/CxPVnn5e+thu0ySDVVaqab
         yKfEjNPNadPKaLXhoBeP7Gwc8xDyS1fonBQ3qAe6dDX4dk0rigxKvX0BLWJKCADSFNCz
         fEyF1WJ9DQAOMp8tjmbYcbQMQzlCm4TpblToh1vJTNOCtSxXotlLPBOL+pHuE0NdvR9I
         8Ia/H1IHtupbzaTXlIQW+ajBJZkSawNLoB4PFtDzB/u7M+DKnwiPXrkOxRDgytMP5D5o
         qArQ==
X-Received: by 10.180.91.16 with SMTP id ca16mr3324877wib.57.1379092672929;
 Fri, 13 Sep 2013 10:17:52 -0700 (PDT)
Received: by 10.216.218.197 with HTTP; Fri, 13 Sep 2013 10:17:52 -0700 (PDT)
In-Reply-To: <CAPZPVFZHyzPZnyg5gjhL0tP6Kgd=XFLc6o8ZKsmPXLUSdcc5mA@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234758>

>
> For now I'm trying to do the following:
>
> access-hook.bash has:
>
> delayed-notify.bash $@ &
>
> delayed-notify.bash has:
>
> sleep 10
> ...
> curl ...
>
> I'm expecting access-hook to spawn new process and return without
> waiting for it to finish to let the service to do its job. But when i
> do push - it sleeps for 10 seconds anyway. Am i missing something
> obvious here?
>
> Any help is much appreciated!
>
> Thanks,
> Eugene


I found a following solution to make it happen while waiting for
somebody to be generous enough to take on the --post-service-hook
(unfortunately i'm not a C guy):

It is using 'at' command. The access-hook script has:

echo "delayed-notify.bash $@" | at now

while delayed-notify.bash has:

sleep 10
curl ...

This is not perfect and in certain situations can still fail because
the delay is not long enough but this will at least resolve 90% of
issues.

I hope that might be helpful for someone.

Thanks,
Eugene
