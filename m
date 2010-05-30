From: Jonathan Nieder <jrnieder@gmail.com>
Subject: [PATCH v2] compat: Add another rudimentary poll() emulation
Date: Sat, 29 May 2010 19:37:18 -0500
Message-ID: <20100530003718.GA27024@progeny.tock>
References: <1274948384-167-1-git-send-email-abcd@gentoo.org>
 <1274948384-167-2-git-send-email-abcd@gentoo.org>
 <20100527101043.GA4390@progeny.tock>
 <AANLkTikYa2vq4PrKrO2QIkHVxYqbhUZRw42kQq875FNT@mail.gmail.com>
 <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Callen <abcd@gentoo.org>, git@vger.kernel.org,
	mduft@gentoo.org, Sverre Rabbelier <srabbelier@gmail.com>,
	Michael J Gruber <git@drmicha.warpmail.net>,
	Johannes Sixt <j6t@kdbg.org>,
	msysGit <msysgit@googlegroups.com>,
	Marko Kreen <markokr@gmail.com>,
	Albert Dvornik <dvornik+git@gmail.com>
To: kusmabite@gmail.com
X-From: git-owner@vger.kernel.org Sun May 30 02:38:31 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OIWXt-00006m-2N
	for gcvg-git-2@lo.gmane.org; Sun, 30 May 2010 02:38:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757085Ab0E3Agv convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 29 May 2010 20:36:51 -0400
Received: from mail-gy0-f174.google.com ([209.85.160.174]:59619 "EHLO
	mail-gy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756835Ab0E3Agu (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 May 2010 20:36:50 -0400
Received: by gyg13 with SMTP id 13so1923915gyg.19
        for <git@vger.kernel.org>; Sat, 29 May 2010 17:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :content-transfer-encoding:in-reply-to:user-agent;
        bh=HCiiYT4a8KMaFJ5aa4B7JCLy7hWTSbe2w04fdSdxIrE=;
        b=ZhYq4GKxLCiwrqOkxZV8DvrzonmAUtBnNUhv78jhb40xxumkPqobtOvKJrTl3yqyTV
         XqoZYKgVv3/cwEc04dJ2k2Z9m8PLTkMyAdv0aucGcuhP4LU8bm0JyBghWHC+NqSgqZJz
         29Prl+teCuQUA6gFRCkHFXjIN7o2mzl5aErPc=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        b=WqZHxhsx2KaxZFrXwcl0LajSb/VZVvxibKjl7GnEVZJ9BpwDPk8IfY5pwYvRvpzpQK
         ohABmzPPWKen5oXIfLHlH6J7Ed15BsM48ia3HdnJHoMbzj7+4k2NopzdYHYjCQ/VAdVP
         43ixTdmDKcFiWDXY9z6A1zLUo3vyV+u+ot+vM=
Received: by 10.231.155.3 with SMTP id q3mr3154732ibw.20.1275179807544;
        Sat, 29 May 2010 17:36:47 -0700 (PDT)
Received: from progeny.tock (c-98-212-3-231.hsd1.il.comcast.net [98.212.3.231])
        by mx.google.com with ESMTPS id t28sm18442473ibg.6.2010.05.29.17.36.44
        (version=SSLv3 cipher=RC4-MD5);
        Sat, 29 May 2010 17:36:45 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <AANLkTikezlVaX8ARkRw8kEk9wL9RL_5I6X3vK83nzFUl@mail.gmail.com>
User-Agent: Mutt/1.5.20 (2009-06-14)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147979>

Implement the subset of poll() semantics needed by git in terms of
select(), for use by the Interix port.  Inspired by commit 6ed807f
(Windows: A rudimentary poll() emulation, 2007-12-01).

This will only poll on descriptors with value <=3D the maximum fd that
select() can portably handle, FD_SETSIZE - 1.  On Windows (and not on
Unix), in principle git could permit higher fds as long as the number
of descriptors used in a single select() call was limited to
=46D_SETSIZE; but such a facility would be rarely used, since the numbe=
r
of sockets the =E2=80=98git daemon=E2=80=99 parent process keeps open t=
ends to be very
small.

Helped-by: Erik Faye-Lund <kusmabite@googlemail.com>
Cc: Johannes Sixt <j6t@kdbg.org>
Cc: Jonathan Callen <abcd@gentoo.org>
Signed-off-by: Jonathan Nieder <jrnieder@gmail.com>
---
Erik Faye-Lund wrote:

> But perhaps you should include a check along the lines of this:
>=20
> if (nfds > FD_SETSIZE)
> 	return errno =3D EINVAL, error("poll: nfds must be below %d", FD_SET=
SIZE);
>=20
> Just so we can know when the code fails :)

Good catch, thanks.  I opted to check each fd instead so the NO_POLL
code can be safely used on Unix for debugging.

Other changes from v1:

 . use COMPAT_CFLAGS instead of BASIC_CFLAGS
 . timeout is a number of milliseconds, not seconds
 . lightly tested on Linux

I would be interested to hear whether this works on msysgit and Interix=
=2E
Thanks again for the help.

 Makefile          |    8 +++++++
 compat/poll.c     |   56 +++++++++++++++++++++++++++++++++++++++++++++=
++++++++
 compat/poll.h     |   13 ++++++++++++
 git-compat-util.h |    6 ++++-
 4 files changed, 82 insertions(+), 1 deletions(-)
 create mode 100644 compat/poll.c
 create mode 100644 compat/poll.h

diff --git a/Makefile b/Makefile
index 2f5d631..ed9f03b 100644
--- a/Makefile
+++ b/Makefile
@@ -111,6 +111,9 @@ all::
 #
 # Define NO_PTHREADS if you do not have or do not want to use Pthreads=
=2E
 #
+# Define NO_POLL if you have a problem with the poll() system call (e.=
g.
+# Interix).
+#
 # Define NO_PREAD if you have a problem with pread() system call (e.g.
 # cygwin1.dll before v1.5.22).
 #
@@ -470,6 +473,7 @@ LIB_H +=3D commit.h
 LIB_H +=3D compat/bswap.h
 LIB_H +=3D compat/cygwin.h
 LIB_H +=3D compat/mingw.h
+LIB_H +=3D compat/poll.h
 LIB_H +=3D compat/win32/pthread.h
 LIB_H +=3D csum-file.h
 LIB_H +=3D decorate.h
@@ -1284,6 +1288,10 @@ endif
 ifdef OBJECT_CREATION_USES_RENAMES
 	COMPAT_CFLAGS +=3D -DOBJECT_CREATION_MODE=3D1
 endif
+ifdef NO_POLL
+	COMPAT_CFLAGS +=3D -DNO_POLL
+	COMPAT_OBJS +=3D compat/poll.o
+endif
 ifdef NO_PREAD
 	COMPAT_CFLAGS +=3D -DNO_PREAD
 	COMPAT_OBJS +=3D compat/pread.o
diff --git a/compat/poll.c b/compat/poll.c
new file mode 100644
index 0000000..0b3c2ae
--- /dev/null
+++ b/compat/poll.c
@@ -0,0 +1,56 @@
+#include "../git-compat-util.h"
+
+static int msleep(int timeout)
+{
+	struct timeval tv;
+	tv.tv_sec =3D 0;
+	tv.tv_usec =3D 1000 * timeout;
+	return select(0, NULL, NULL, NULL, &tv);
+}
+
+static int validate_fd(const struct git_pollfd *ufd)
+{
+	const int fd =3D ufd->fd;
+	if (ufd->events !=3D POLLIN) {
+		errno =3D EINVAL;
+		return error("poll: unsupported events");
+	}
+	if (fd >=3D FD_SETSIZE) {
+		errno =3D EINVAL;
+		return error("poll: fd must be below %d", FD_SETSIZE);
+	}
+	return fd;
+}
+
+int git_poll(struct git_pollfd *ufds, int nfds, int timeout)
+{
+	int i, maxfd, result;
+	fd_set fds;
+
+	if (timeout >=3D 0) {
+		if (nfds !=3D 0) {
+			errno =3D EINVAL;
+			return error("poll timeout not supported");
+		}
+		return msleep(timeout);
+	}
+
+	FD_ZERO(&fds);
+	maxfd =3D -1;
+	for (i =3D 0; i < nfds; i++) {
+		const int fd =3D validate_fd(&ufds[i]);
+		if (fd < 0)
+			return fd;
+		maxfd =3D (fd > maxfd) ? fd : maxfd;
+		FD_SET(fd, &fds);
+	}
+
+	result =3D select(maxfd + 1, &fds, NULL, NULL, NULL);
+	if (result < 0)
+		return result;
+	for (i =3D 0; i < nfds; i++) {
+		if (FD_ISSET(ufds[i].fd, &fds))
+			ufds[i].revents |=3D POLLIN;
+	}
+	return result;
+}
diff --git a/compat/poll.h b/compat/poll.h
new file mode 100644
index 0000000..65775ab
--- /dev/null
+++ b/compat/poll.h
@@ -0,0 +1,13 @@
+#ifndef POLLIN
+#define POLLIN 1
+#define POLLHUP 2
+#endif
+
+#define pollfd git_pollfd
+#define poll git_poll
+struct git_pollfd {
+	int fd;		/* file descriptor */
+	short events;	/* requested events */
+	short revents;	/* returned events */
+};
+extern int git_poll(struct git_pollfd *fds, int nfds, int timeout);
diff --git a/git-compat-util.h b/git-compat-util.h
index 824c175..2494378 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -94,13 +94,17 @@
 #include <utime.h>
 #ifndef __MINGW32__
 #include <sys/wait.h>
-#include <sys/poll.h>
 #include <sys/socket.h>
 #include <sys/ioctl.h>
 #include <termios.h>
 #ifndef NO_SYS_SELECT_H
 #include <sys/select.h>
 #endif
+#ifdef NO_POLL
+#include "compat/poll.h"
+#else
+#include <sys/poll.h>
+#endif
 #include <netinet/in.h>
 #include <netinet/tcp.h>
 #include <arpa/inet.h>
--=20
1.7.1
