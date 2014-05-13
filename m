From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH 2/3] Add read-cache--daemon
Date: Tue, 13 May 2014 20:49:56 +0700
Message-ID: <CACsJy8Du+tvQ=EhZ0rdumeQwfcenhg6R9pbGcYV9bCMqSfHzfw@mail.gmail.com>
References: <CAJo=hJtgijOOMPbFjvTUaENw=hr0YixYmy1UkdqEd=CpLZ5L2A@mail.gmail.com>
 <1399979737-8577-1-git-send-email-pclouds@gmail.com> <1399979737-8577-3-git-send-email-pclouds@gmail.com>
 <CABPQNSaSDRhuQYey0ad6J0cXrCzrK1CYZQar5GgUM8g3JVmRSA@mail.gmail.com>
 <CACsJy8BFEtXQc7mO1pvdeQ9GMofcW0H2uJF=E6yfN4SwQWgRbw@mail.gmail.com> <CABPQNSbu9uVh_LZqQupG9TJe0_ggA1EmAWnk8H7+xOBvcsrcOg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: GIT Mailing-list <git@vger.kernel.org>
To: Erik Faye-Lund <kusmabite@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 13 15:50:37 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WkD6K-0006xx-9p
	for gcvg-git-2@plane.gmane.org; Tue, 13 May 2014 15:50:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933487AbaEMNu3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 13 May 2014 09:50:29 -0400
Received: from mail-qg0-f49.google.com ([209.85.192.49]:43767 "EHLO
	mail-qg0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933263AbaEMNu1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 13 May 2014 09:50:27 -0400
Received: by mail-qg0-f49.google.com with SMTP id a108so404481qge.8
        for <git@vger.kernel.org>; Tue, 13 May 2014 06:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=cZ7SnxNCQ/kfudqRtRKRhsnU50AJnxTi05xrDckqrVM=;
        b=DHWjZOPpEnCqb1rQc4uZCTEldISsEUe71jJMgmfDj8sfwVaJSr3i/QX6EjaiTLPMtw
         IS1P8jA/H3aREik8FcCvOGHPxiw13e5WCrXhzsq33jrqRE90SSKfvSb5MadAMwEzFafD
         XDI0KpiRrUdhBUxXH1T0BF5JU6OeAqLvf+XtWSvyVbVE0OjEZi33h4dmF9sKgt91ckDd
         4sQHZz3rRb5ptoSJ2ajWVD2B+w850MImdLpibAeO6NRM1tmWYaeVqPKVlQUjMFBpzC5N
         kVa2Lt8z9Pbng0c75eOKSaLDREPIyaoV5MHWKTdI7xbYp76Vo2ET8Y1jkSHF0tOhDP60
         j7Ug==
X-Received: by 10.224.87.132 with SMTP id w4mr30273925qal.89.1399989026381;
 Tue, 13 May 2014 06:50:26 -0700 (PDT)
Received: by 10.96.138.9 with HTTP; Tue, 13 May 2014 06:49:56 -0700 (PDT)
In-Reply-To: <CABPQNSbu9uVh_LZqQupG9TJe0_ggA1EmAWnk8H7+xOBvcsrcOg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248783>

On Tue, May 13, 2014 at 8:37 PM, Erik Faye-Lund <kusmabite@gmail.com> wrote:
> On Tue, May 13, 2014 at 3:01 PM, Duy Nguyen <pclouds@gmail.com> wrote:
>> What do you think is a good replacement for unix socket on Windows?
>> It's only used to refresh the cache in the daemon, no sensitive data
>> sent over, so security is not a problem. I'm thinking maybe just
>> TCP/IP server, but that's going to be a system-wide daemon.. Perhaps
>> the windows daemon could just monitor $GIT_DIR/index and refresh it?
>
> Windows has support for Named Pipes, which seems like the right kind
> of communication channel. However, the programming model differs quite
> a bit from unix-sockets:
>
> http://msdn.microsoft.com/en-us/library/windows/desktop/aa365594%28v=vs.85%29.aspx

Yeah that was my first option, but if code cannot be shared to
differences then we probably should go another way. The old
FindWindow/PostMessage still works with modern Windows, right? Maybe
we could create a window with a name derived from the daemon's pid and
save the name in the index, then PostMessage can signal the daemon. On
the UNIX front, we store pid and send SIGUSR1 instead..The good thing
here is the Git side will be very simple (PostMessage vs kill).
-- 
Duy
