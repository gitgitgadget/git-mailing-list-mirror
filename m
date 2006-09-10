From: "Franck Bui-Huu" <vagabon.xyz@gmail.com>
Subject: Re: [PATCH 3/3] Add sideband status report to git-archive protocol
Date: Sun, 10 Sep 2006 21:15:49 +0200
Message-ID: <cda58cb80609101215h36b0f7d7m990ed3011cfda9d2@mail.gmail.com>
References: <7vpse4tcyc.fsf@assigned-by-dhcp.cox.net>
	 <7vk64ctctv.fsf@assigned-by-dhcp.cox.net>
	 <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Rene Scharfe" <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Sun Sep 10 21:16:00 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1GMUmY-0002bx-Vw
	for gcvg-git@gmane.org; Sun, 10 Sep 2006 21:15:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932534AbWIJTPw (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 10 Sep 2006 15:15:52 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S932535AbWIJTPw
	(ORCPT <rfc822;git-outgoing>); Sun, 10 Sep 2006 15:15:52 -0400
Received: from wx-out-0506.google.com ([66.249.82.227]:45425 "EHLO
	wx-out-0506.google.com") by vger.kernel.org with ESMTP
	id S932534AbWIJTPv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Sep 2006 15:15:51 -0400
Received: by wx-out-0506.google.com with SMTP id s14so1304495wxc
        for <git@vger.kernel.org>; Sun, 10 Sep 2006 12:15:50 -0700 (PDT)
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
        s=beta; d=gmail.com;
        h=received:message-id:date:from:to:subject:cc:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:references;
        b=V5k/z2JW+bapAsNkeNEmU2gS25FZylRx8FkrUMEKSn5nkAgyGppIwXJXZQm50eSyknb2F9C3YOTzYMId2Cy2Y0a0DgEb/WZyE9Hmg3d9oLHGolfjHftqbC+PJkU6VOlYZifbzTbZIVc5rW+ELDMF6AoXFIWxB4Yw0ulMGyOuSSk=
Received: by 10.70.108.18 with SMTP id g18mr4558789wxc;
        Sun, 10 Sep 2006 12:15:50 -0700 (PDT)
Received: by 10.70.72.5 with HTTP; Sun, 10 Sep 2006 12:15:49 -0700 (PDT)
To: "Junio C Hamano" <junkio@cox.net>
In-Reply-To: <7v1wqkt2v4.fsf_-_@assigned-by-dhcp.cox.net>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/26811>

2006/9/10, Junio C Hamano <junkio@cox.net>:
> Using the refactored sideband code from existing upload-pack protocol,
> this lets the error condition and status output sent from the remote
> process to be shown locally.
>
> Signed-off-by: Junio C Hamano <junkio@cox.net>
> ---
>
>  * This does it in a "stupid" way.  Ideally, write(2) to fd 1
>    and 2 in each archiver backend could be wrapped with
>    something like upload-pack.c::send_client_data() that does
>    straight write(2) to the original destination when it is not
>    driven by upload-pack, or use send_sideband() when it is, and
>    that way we can lose two pipes and the multiplexer process.
>

Well I started that part the same way you do because I liked the fact
that archiver backend implementation needn't to know how to send out
data. It's totaly transparent for it. It just need to write its
payload on stdout.

>
>  builtin-archive.c        |   24 ++++++++++--
>  builtin-upload-archive.c |   92 +++++++++++++++++++++++++++++++++++++++++++++-
>  2 files changed, 108 insertions(+), 8 deletions(-)
>

[snip]

> +int cmd_upload_archive(int argc, const char **argv, const char *prefix)
> +{
> +       pid_t writer;
> +       int fd1[2], fd2[2];
> +       /*
> +        * Set up sideband subprocess.
> +        *
> +        * We (parent) monitor and read from child, sending its fd#1 and fd#2
> +        * multiplexed out to our fd#1.  If the child dies, we tell the other
> +        * end over channel #3.
> +        */
> +       if (pipe(fd1) < 0 || pipe(fd2) < 0) {
> +               int err = errno;
> +               packet_write(1, "NACK pipe failed on the remote side\n");
> +               die("upload-archive: %s", strerror(err));
> +       }
> +       writer = fork();
> +       if (writer < 0) {
> +               int err = errno;
> +               packet_write(1, "NACK fork failed on the remote side\n");
> +               die("upload-archive: %s", strerror(err));
> +       }
> +       if (!writer) {
> +               /* child - connect fd#1 and fd#2 to the pipe */
> +               dup2(fd1[1], 1);
> +               dup2(fd2[1], 2);
> +               close(fd1[1]); close(fd2[1]);
> +               close(fd1[0]); close(fd2[0]); /* we do not read from pipe */
> +
> +               exit(run_upload_archive(argc, argv, prefix));
> +       }
> +
> +       /* parent - read from child, multiplex and send out to fd#1 */
> +       close(fd1[1]); close(fd2[1]); /* we do not write to pipe */
>         packet_write(1, "ACK\n");
>         packet_flush(1);
>
> -       return ar.write_archive(&ar.args);
> -}
> +       while (1) {
> +               struct pollfd pfd[2];
> +               char buf[16384];
> +               ssize_t sz;
> +               pid_t pid;
> +               int status;
> +
> +               pfd[0].fd = fd1[0];
> +               pfd[0].events = POLLIN;
> +               pfd[1].fd = fd2[0];
> +               pfd[1].events = POLLIN;
> +               if (poll(pfd, 2, -1) < 0) {
> +                       if (errno != EINTR) {
> +                               error("poll failed resuming: %s",
> +                                     strerror(errno));
> +                               sleep(1);
> +                       }
> +                       continue;
> +               }
> +               if (pfd[0].revents & (POLLIN|POLLHUP)) {
> +                       /* Data stream ready */
> +                       sz = read(pfd[0].fd, buf, sizeof(buf));
> +                       send_sideband(1, 1, buf, sz, DEFAULT_PACKET_MAX);
> +               }
> +               if (pfd[1].revents & (POLLIN|POLLHUP)) {
> +                       /* Status stream ready */
> +                       sz = read(pfd[1].fd, buf, sizeof(buf));
> +                       send_sideband(1, 2, buf, sz, DEFAULT_PACKET_MAX);
> +               }
>
> +               if (((pfd[0].revents | pfd[1].revents) & POLLHUP) == 0)
> +                       continue;
> +               /* did it die? */
> +               pid = waitpid(writer, &status, WNOHANG);
> +               if (!pid) {
> +                       fprintf(stderr, "Hmph, HUP?\n");
> +                       continue;
> +               }
> +               if (!WIFEXITED(status) || WEXITSTATUS(status) > 0)
> +                       send_sideband(1, 3, deadchild, strlen(deadchild),
> +                                     DEFAULT_PACKET_MAX);
> +               packet_flush(1);
> +               break;
> +       }
> +       return 0;
> +}

Why all of this is part of upload-archive ? Shouldn't we put that code
in daemon.c ?
We could use a new service flag to ask daemon.c to start the service
with the sideband multiplexer process already setup and plugged with
the sercive is going to start ? Hence others future services could use
it.

-- 
               Franck
