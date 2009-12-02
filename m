From: =?ISO-8859-15?Q?Martin_Storsj=F6?= <martin@martin.st>
Subject: Re: [PATCH/RFC 01/11] mingw: add network-wrappers for 
	daemon
Date: Wed, 2 Dec 2009 15:21:59 +0200 (EET)
Message-ID: <alpine.DEB.2.00.0912021511310.5582@cone.home.martin.st>
References: <1259196260-3064-1-git-send-email-kusmabite@gmail.com>  <1259196260-3064-2-git-send-email-kusmabite@gmail.com>  <alpine.DEB.2.00.0911261015140.14228@cone.home.martin.st>  <40aa078e0911260246j47fa36d5t421de7c1d07d5cca@mail.gmail.com> 
 <alpine.DEB.2.00.0911261250180.14228@cone.home.martin.st> <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: msysgit@googlegroups.com, git@vger.kernel.org, dotzenlabs@gmail.com, 
    Johannes Sixt <j6t@kdbg.org>
To: kusmabite@gmail.com
X-From: 3A2oWSwYJB846uBD276uBD27.CD6CIC02D08805y0B8E9C.w86@listserv.bounces.google.com Wed Dec 02 14:22:30 2009
Return-path: <3A2oWSwYJB846uBD276uBD27.CD6CIC02D08805y0B8E9C.w86@listserv.bounces.google.com>
Envelope-to: gcvm-msysgit@m.gmane.org
Received: from mail-yw0-f150.google.com ([209.85.211.150])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NFpA5-0001kH-Kw
	for gcvm-msysgit@m.gmane.org; Wed, 02 Dec 2009 14:22:29 +0100
Received: by ywh14 with SMTP id 14sf319832ywh.21
        for <gcvm-msysgit@m.gmane.org>; Wed, 02 Dec 2009 05:22:28 -0800 (PST)
Received: by 10.90.124.10 with SMTP id w10mr19835agc.6.1259760131389;
        Wed, 02 Dec 2009 05:22:11 -0800 (PST)
X-BeenThere: msysgit@googlegroups.com
Received: by 10.213.3.206 with SMTP id 14ls3269034ebo.0.p; Wed, 02 Dec 2009 
	05:22:07 -0800 (PST)
Received: by 10.213.96.196 with SMTP id i4mr11967ebn.28.1259760127031;
        Wed, 02 Dec 2009 05:22:07 -0800 (PST)
Received: by 10.213.96.196 with SMTP id i4mr11966ebn.28.1259760126991;
        Wed, 02 Dec 2009 05:22:06 -0800 (PST)
Received: from jenni2.inet.fi (mta-out.inet.fi [195.156.147.13])
        by gmr-mx.google.com with ESMTP id 17si107390ewy.15.2009.12.02.05.22.06;
        Wed, 02 Dec 2009 05:22:06 -0800 (PST)
Received-SPF: pass (google.com: domain of martin@martin.st designates 195.156.147.13 as permitted sender) client-ip=195.156.147.13;
Received: from [88.193.196.75] (88.193.196.75) by jenni2.inet.fi (8.5.014)
        id 4A777091047C203D; Wed, 2 Dec 2009 15:22:05 +0200
X-X-Sender: martin@cone.home.martin.st
In-Reply-To: <40aa078e0912020501v9378c37l106e1e23b5e7b43d@mail.gmail.com>
User-Agent: Alpine 2.00 (DEB 1167 2008-08-23)
X-Original-Authentication-Results: gmr-mx.google.com; spf=pass (google.com: 
	domain of martin@martin.st designates 195.156.147.13 as permitted sender) 
	smtp.mail=martin@martin.st
Precedence: list
Mailing-list: list msysgit@googlegroups.com; contact msysgit+owners@googlegroups.com
List-ID: <msysgit.googlegroups.com>
List-Post: <http://groups.google.com/group/msysgit/post?hl=>, 
	<mailto:msysgit@googlegroups.com>
List-Help: <http://groups.google.com/support/?hl=>, <mailto:msysgit+help@googlegroups.com>
List-Archive: <http://groups.google.com/group/msysgit?hl=>
X-Thread-Url: http://groups.google.com/group/msysgit/t/15f3dd983aa85143
X-Message-Url: http://groups.google.com/group/msysgit/msg/67f06691540df089
List-Unsubscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+unsubscribe@googlegroups.com>
List-Subscribe: <http://groups.google.com/group/msysgit/subscribe?hl=>, 
	<mailto:msysgit+subscribe@googlegroups.com>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/134333>

On Wed, 2 Dec 2009, Erik Faye-Lund wrote:

> I'm not very familiar with poll(), but if I understand the man-pages
> correctly it's waiting for events on file descriptors, and is in our
> case used to check for incoming connections, right? If so, I see three
> possible ways forward: (1) extending our poll()-emulation to handle
> multiple sockets, (2) change daemon.c to check one socket at the time,
> and (3) using select() instead of poll().
> 
> (1) seems like the "correct" but tricky thing to do, (2) like the
> "easy" but nasty thing to do. However, (3) strikes me as the least
> dangerous thing to do ;)

Generally, poll is a better API than select, since select is limited to fd 
values up to (about) 1000, depending on the implementation. (This is due 
to the fact that fd_set is a fixed size bit set with a bit for each 
possible fd.)

But since we're only doing select on the handful of sockets that were 
opened initially in the process (so these should receive low numbers), 
this should only be a theoretical concern.

> For (1), there's also a WSAPoll() function in Windows, but I'm not
> sure how to figure out if an fd is a socket or a pipe. There's also
> WaitForMultipleObjects.
> 
> Here's a quick stab at (3). It seems to work fine under Windows. Not
> tested on other platforms, though.

A few comments below, just by reading through this, didn't test it yet:

> --->8---
> --- a/daemon.c
> +++ b/daemon.c
> @@ -812,26 +812,22 @@ static int socksetup(char *listen_addr, int listen_port, i
> nt **socklist_p)
> 
>  static int service_loop(int socknum, int *socklist)
>  {
> -       struct pollfd *pfd;
> -       int i;
> -
> -       pfd = xcalloc(socknum, sizeof(struct pollfd));
> -
> -       for (i = 0; i < socknum; i++) {
> -               pfd[i].fd = socklist[i];
> -               pfd[i].events = POLLIN;
> -       }
> -
>         signal(SIGCHLD, child_handler);
> 
>         for (;;) {
>                 int i;
> +               fd_set fds;
> +               struct timeval timeout = { 0, 0 };
> 
>                 check_dead_children();
> 
> -               if (poll(pfd, socknum, -1) < 0) {
> +               FD_ZERO(&fds);
> +               for (i = 0; i < socknum; i++)
> +                       FD_SET(socklist[i], &fds);
> +
> +               if (select(0, &fds, NULL, NULL, &timeout) > 0) {
>                         if (errno != EINTR) {

The first parameter to select should be max(all fds set in the fd_set) + 
1, this should be trivial enough to determine in the loop above where the 
fd:s are added with FD_SET.

You're calling select() with a zero timeout - I'd guess this chews quite a 
bit of cpu just looping around doing nothing? If the last parameter would 
be set to NULL, it would wait indefinitely, just like the previous poll 
loop did.

> @@ -854,6 +850,7 @@ static int service_loop(int socknum, int *socklist)
>                                         }
>                                 }
>                                 handle(incoming, (struct sockaddr *)&ss, sslen);
> 
> +                               break;

What's this good for?

Other than that, this looks quite good to me, at a first glance.

// Martin
