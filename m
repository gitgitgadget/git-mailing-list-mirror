From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v4 1/3] mingw: move poll out of sys-folder
Date: Mon, 24 Oct 2011 18:02:09 +0200
Message-ID: <1319472131-3968-2-git-send-email-kusmabite@gmail.com>
References: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
Cc: gitster@pobox.com, j6t@kdbg.org, peff@peff.net,
	rene.scharfe@lsrfire.ath.cx
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 24 18:02:27 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RIMyj-0008WM-RC
	for gcvg-git-2@lo.gmane.org; Mon, 24 Oct 2011 18:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932929Ab1JXQCO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Oct 2011 12:02:14 -0400
Received: from mail-bw0-f46.google.com ([209.85.214.46]:38696 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932826Ab1JXQCM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Oct 2011 12:02:12 -0400
Received: by mail-bw0-f46.google.com with SMTP id zt19so8365950bkb.19
        for <git@vger.kernel.org>; Mon, 24 Oct 2011 09:02:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        bh=Mkqa6u2D7rI0lyhKBgd434NbyFqCyJaQXmay0KE0b70=;
        b=wQBBNuo502Sya2qiHRDly7YtVAs6k7PxADYZYQXig3XvRK2KabSRFG+ZK4E7auWu7W
         YGdwGaj2PZhafqFjPLcPXc7R5TL27YvudqWU34Ug2RjhLqW2eJfv5pHlflgCSI4qg68q
         VVzVpwYRR0dmWD8VJgNeuC3CsvkvPdJfXEvO0=
Received: by 10.204.7.198 with SMTP id e6mr17707685bke.80.1319472131680;
        Mon, 24 Oct 2011 09:02:11 -0700 (PDT)
Received: from localhost ([77.40.159.131])
        by mx.google.com with ESMTPS id f7sm7915646bkv.4.2011.10.24.09.02.08
        (version=TLSv1/SSLv3 cipher=OTHER);
        Mon, 24 Oct 2011 09:02:09 -0700 (PDT)
X-Mailer: git-send-email 1.7.7.msysgit.1.1.g7b316
In-Reply-To: <1319472131-3968-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184180>

Both XSI and upstream Gnulib versions expects to find poll.h at
the root of some include path, not inside the sys-folder.

This helps us when upgrading Gnulib.

Signed-off-by: Erik Faye-Lund <kusmabite@gmail.com>
---
 Makefile                |    6 +-
 compat/win32/poll.c     |  599 +++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/poll.h     |   53 +++++
 compat/win32/sys/poll.c |  599 -----------------------------------------------
 compat/win32/sys/poll.h |   53 -----
 5 files changed, 656 insertions(+), 654 deletions(-)
 create mode 100644 compat/win32/poll.c
 create mode 100644 compat/win32/poll.h
 delete mode 100644 compat/win32/sys/poll.c
 delete mode 100644 compat/win32/sys/poll.h

diff --git a/Makefile b/Makefile
index 3139c19..4c09b35 100644
--- a/Makefile
+++ b/Makefile
@@ -1088,6 +1088,7 @@ ifeq ($(uname_S),Windows)
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
+	NO_SYS_POLL_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_IPV6 = YesPlease
 	NO_SETENV = YesPlease
@@ -1126,7 +1127,7 @@ ifeq ($(uname_S),Windows)
 	BASIC_CFLAGS = -nologo -I. -I../zlib -Icompat/vcbuild -Icompat/vcbuild/include -DWIN32 -D_CONSOLE -DHAVE_STRING_H -D_CRT_SECURE_NO_WARNINGS -D_CRT_NONSTDC_NO_DEPRECATE
 	COMPAT_OBJS = compat/msvc.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o compat/win32/dirent.o
+		compat/win32/poll.o compat/win32/dirent.o
 	COMPAT_CFLAGS = -D__USE_MINGW_ACCESS -DNOGDI -DHAVE_STRING_H -DHAVE_ALLOCA_H -Icompat -Icompat/regex -Icompat/win32 -DSTRIP_EXTENSION=\".exe\"
 	BASIC_LDFLAGS = -IGNORE:4217 -IGNORE:4049 -NOLOGO -SUBSYSTEM:CONSOLE -NODEFAULTLIB:MSVCRT.lib
 	EXTLIBS = user32.lib advapi32.lib shell32.lib wininet.lib ws2_32.lib
@@ -1181,6 +1182,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	NO_PREAD = YesPlease
 	NEEDS_CRYPTO_WITH_SSL = YesPlease
 	NO_LIBGEN_H = YesPlease
+	NO_SYS_POLL_H = YesPlease
 	NO_SYMLINK_HEAD = YesPlease
 	NO_SETENV = YesPlease
 	NO_UNSETENV = YesPlease
@@ -1214,7 +1216,7 @@ ifneq (,$(findstring MINGW,$(uname_S)))
 	COMPAT_CFLAGS += -DSTRIP_EXTENSION=\".exe\"
 	COMPAT_OBJS += compat/mingw.o compat/winansi.o \
 		compat/win32/pthread.o compat/win32/syslog.o \
-		compat/win32/sys/poll.o compat/win32/dirent.o
+		compat/win32/poll.o compat/win32/dirent.o
 	EXTLIBS += -lws2_32
 	PTHREAD_LIBS =
 	X = .exe
diff --git a/compat/win32/poll.c b/compat/win32/poll.c
new file mode 100644
index 0000000..708a6c9
--- /dev/null
+++ b/compat/win32/poll.c
@@ -0,0 +1,599 @@
+/* Emulation for poll(2)
+   Contributed by Paolo Bonzini.
+
+   Copyright 2001-2003, 2006-2010 Free Software Foundation, Inc.
+
+   This file is part of gnulib.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+/* Tell gcc not to warn about the (nfd < 0) tests, below.  */
+#if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
+# pragma GCC diagnostic ignored "-Wtype-limits"
+#endif
+
+#include <malloc.h>
+
+#include <sys/types.h>
+#include "poll.h"
+#include <errno.h>
+#include <limits.h>
+#include <assert.h>
+
+#if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
+# define WIN32_NATIVE
+# if defined (_MSC_VER)
+#  define _WIN32_WINNT 0x0502
+# endif
+# include <winsock2.h>
+# include <windows.h>
+# include <io.h>
+# include <stdio.h>
+# include <conio.h>
+#else
+# include <sys/time.h>
+# include <sys/socket.h>
+# include <sys/select.h>
+# include <unistd.h>
+#endif
+
+#ifdef HAVE_SYS_IOCTL_H
+# include <sys/ioctl.h>
+#endif
+#ifdef HAVE_SYS_FILIO_H
+# include <sys/filio.h>
+#endif
+
+#include <time.h>
+
+#ifndef INFTIM
+# define INFTIM (-1)
+#endif
+
+/* BeOS does not have MSG_PEEK.  */
+#ifndef MSG_PEEK
+# define MSG_PEEK 0
+#endif
+
+#ifdef WIN32_NATIVE
+
+#define IsConsoleHandle(h) (((long) (h) & 3) == 3)
+
+static BOOL
+IsSocketHandle (HANDLE h)
+{
+  WSANETWORKEVENTS ev;
+
+  if (IsConsoleHandle (h))
+    return FALSE;
+
+  /* Under Wine, it seems that getsockopt returns 0 for pipes too.
+     WSAEnumNetworkEvents instead distinguishes the two correctly.  */
+  ev.lNetworkEvents = 0xDEADBEEF;
+  WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
+  return ev.lNetworkEvents != 0xDEADBEEF;
+}
+
+/* Declare data structures for ntdll functions.  */
+typedef struct _FILE_PIPE_LOCAL_INFORMATION {
+  ULONG NamedPipeType;
+  ULONG NamedPipeConfiguration;
+  ULONG MaximumInstances;
+  ULONG CurrentInstances;
+  ULONG InboundQuota;
+  ULONG ReadDataAvailable;
+  ULONG OutboundQuota;
+  ULONG WriteQuotaAvailable;
+  ULONG NamedPipeState;
+  ULONG NamedPipeEnd;
+} FILE_PIPE_LOCAL_INFORMATION, *PFILE_PIPE_LOCAL_INFORMATION;
+
+typedef struct _IO_STATUS_BLOCK
+{
+  union {
+    DWORD Status;
+    PVOID Pointer;
+  } u;
+  ULONG_PTR Information;
+} IO_STATUS_BLOCK, *PIO_STATUS_BLOCK;
+
+typedef enum _FILE_INFORMATION_CLASS {
+  FilePipeLocalInformation = 24
+} FILE_INFORMATION_CLASS, *PFILE_INFORMATION_CLASS;
+
+typedef DWORD (WINAPI *PNtQueryInformationFile)
+	 (HANDLE, IO_STATUS_BLOCK *, VOID *, ULONG, FILE_INFORMATION_CLASS);
+
+# ifndef PIPE_BUF
+#  define PIPE_BUF      512
+# endif
+
+/* Compute revents values for file handle H.  If some events cannot happen
+   for the handle, eliminate them from *P_SOUGHT.  */
+
+static int
+win32_compute_revents (HANDLE h, int *p_sought)
+{
+  int i, ret, happened;
+  INPUT_RECORD *irbuffer;
+  DWORD avail, nbuffer;
+  BOOL bRet;
+  IO_STATUS_BLOCK iosb;
+  FILE_PIPE_LOCAL_INFORMATION fpli;
+  static PNtQueryInformationFile NtQueryInformationFile;
+  static BOOL once_only;
+
+  switch (GetFileType (h))
+    {
+    case FILE_TYPE_PIPE:
+      if (!once_only)
+	{
+	  NtQueryInformationFile = (PNtQueryInformationFile)
+	    GetProcAddress (GetModuleHandle ("ntdll.dll"),
+			    "NtQueryInformationFile");
+	  once_only = TRUE;
+	}
+
+      happened = 0;
+      if (PeekNamedPipe (h, NULL, 0, NULL, &avail, NULL) != 0)
+	{
+	  if (avail)
+	    happened |= *p_sought & (POLLIN | POLLRDNORM);
+	}
+      else if (GetLastError () == ERROR_BROKEN_PIPE)
+	happened |= POLLHUP;
+
+      else
+	{
+	  /* It was the write-end of the pipe.  Check if it is writable.
+	     If NtQueryInformationFile fails, optimistically assume the pipe is
+	     writable.  This could happen on Win9x, where NtQueryInformationFile
+	     is not available, or if we inherit a pipe that doesn't permit
+	     FILE_READ_ATTRIBUTES access on the write end (I think this should
+	     not happen since WinXP SP2; WINE seems fine too).  Otherwise,
+	     ensure that enough space is available for atomic writes.  */
+	  memset (&iosb, 0, sizeof (iosb));
+	  memset (&fpli, 0, sizeof (fpli));
+
+	  if (!NtQueryInformationFile
+	      || NtQueryInformationFile (h, &iosb, &fpli, sizeof (fpli),
+					 FilePipeLocalInformation)
+	      || fpli.WriteQuotaAvailable >= PIPE_BUF
+	      || (fpli.OutboundQuota < PIPE_BUF &&
+		  fpli.WriteQuotaAvailable == fpli.OutboundQuota))
+	    happened |= *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
+	}
+      return happened;
+
+    case FILE_TYPE_CHAR:
+      ret = WaitForSingleObject (h, 0);
+      if (!IsConsoleHandle (h))
+	return ret == WAIT_OBJECT_0 ? *p_sought & ~(POLLPRI | POLLRDBAND) : 0;
+
+      nbuffer = avail = 0;
+      bRet = GetNumberOfConsoleInputEvents (h, &nbuffer);
+      if (bRet)
+	{
+	  /* Input buffer.  */
+	  *p_sought &= POLLIN | POLLRDNORM;
+	  if (nbuffer == 0)
+	    return POLLHUP;
+	  if (!*p_sought)
+	    return 0;
+
+	  irbuffer = (INPUT_RECORD *) alloca (nbuffer * sizeof (INPUT_RECORD));
+	  bRet = PeekConsoleInput (h, irbuffer, nbuffer, &avail);
+	  if (!bRet || avail == 0)
+	    return POLLHUP;
+
+	  for (i = 0; i < avail; i++)
+	    if (irbuffer[i].EventType == KEY_EVENT)
+	      return *p_sought;
+	  return 0;
+	}
+      else
+	{
+	  /* Screen buffer.  */
+	  *p_sought &= POLLOUT | POLLWRNORM | POLLWRBAND;
+	  return *p_sought;
+	}
+
+    default:
+      ret = WaitForSingleObject (h, 0);
+      if (ret == WAIT_OBJECT_0)
+	return *p_sought & ~(POLLPRI | POLLRDBAND);
+
+      return *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
+    }
+}
+
+/* Convert fd_sets returned by select into revents values.  */
+
+static int
+win32_compute_revents_socket (SOCKET h, int sought, long lNetworkEvents)
+{
+  int happened = 0;
+
+  if ((lNetworkEvents & (FD_READ | FD_ACCEPT | FD_CLOSE)) == FD_ACCEPT)
+    happened |= (POLLIN | POLLRDNORM) & sought;
+
+  else if (lNetworkEvents & (FD_READ | FD_ACCEPT | FD_CLOSE))
+    {
+      int r, error;
+
+      char data[64];
+      WSASetLastError (0);
+      r = recv (h, data, sizeof (data), MSG_PEEK);
+      error = WSAGetLastError ();
+      WSASetLastError (0);
+
+      if (r > 0 || error == WSAENOTCONN)
+	happened |= (POLLIN | POLLRDNORM) & sought;
+
+      /* Distinguish hung-up sockets from other errors.  */
+      else if (r == 0 || error == WSAESHUTDOWN || error == WSAECONNRESET
+	       || error == WSAECONNABORTED || error == WSAENETRESET)
+	happened |= POLLHUP;
+
+      else
+	happened |= POLLERR;
+    }
+
+  if (lNetworkEvents & (FD_WRITE | FD_CONNECT))
+    happened |= (POLLOUT | POLLWRNORM | POLLWRBAND) & sought;
+
+  if (lNetworkEvents & FD_OOB)
+    happened |= (POLLPRI | POLLRDBAND) & sought;
+
+  return happened;
+}
+
+#else /* !MinGW */
+
+/* Convert select(2) returned fd_sets into poll(2) revents values.  */
+static int
+compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
+{
+  int happened = 0;
+  if (FD_ISSET (fd, rfds))
+    {
+      int r;
+      int socket_errno;
+
+# if defined __MACH__ && defined __APPLE__
+      /* There is a bug in Mac OS X that causes it to ignore MSG_PEEK
+	 for some kinds of descriptors.  Detect if this descriptor is a
+	 connected socket, a server socket, or something else using a
+	 0-byte recv, and use ioctl(2) to detect POLLHUP.  */
+      r = recv (fd, NULL, 0, MSG_PEEK);
+      socket_errno = (r < 0) ? errno : 0;
+      if (r == 0 || socket_errno == ENOTSOCK)
+	ioctl (fd, FIONREAD, &r);
+# else
+      char data[64];
+      r = recv (fd, data, sizeof (data), MSG_PEEK);
+      socket_errno = (r < 0) ? errno : 0;
+# endif
+      if (r == 0)
+	happened |= POLLHUP;
+
+      /* If the event happened on an unconnected server socket,
+	 that's fine. */
+      else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
+	happened |= (POLLIN | POLLRDNORM) & sought;
+
+      /* Distinguish hung-up sockets from other errors.  */
+      else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
+	       || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
+	happened |= POLLHUP;
+
+      else
+	happened |= POLLERR;
+    }
+
+  if (FD_ISSET (fd, wfds))
+    happened |= (POLLOUT | POLLWRNORM | POLLWRBAND) & sought;
+
+  if (FD_ISSET (fd, efds))
+    happened |= (POLLPRI | POLLRDBAND) & sought;
+
+  return happened;
+}
+#endif /* !MinGW */
+
+int
+poll (pfd, nfd, timeout)
+     struct pollfd *pfd;
+     nfds_t nfd;
+     int timeout;
+{
+#ifndef WIN32_NATIVE
+  fd_set rfds, wfds, efds;
+  struct timeval tv;
+  struct timeval *ptv;
+  int maxfd, rc;
+  nfds_t i;
+
+# ifdef _SC_OPEN_MAX
+  static int sc_open_max = -1;
+
+  if (nfd < 0
+      || (nfd > sc_open_max
+	  && (sc_open_max != -1
+	      || nfd > (sc_open_max = sysconf (_SC_OPEN_MAX)))))
+    {
+      errno = EINVAL;
+      return -1;
+    }
+# else /* !_SC_OPEN_MAX */
+#  ifdef OPEN_MAX
+  if (nfd < 0 || nfd > OPEN_MAX)
+    {
+      errno = EINVAL;
+      return -1;
+    }
+#  endif /* OPEN_MAX -- else, no check is needed */
+# endif /* !_SC_OPEN_MAX */
+
+  /* EFAULT is not necessary to implement, but let's do it in the
+     simplest case. */
+  if (!pfd)
+    {
+      errno = EFAULT;
+      return -1;
+    }
+
+  /* convert timeout number into a timeval structure */
+  if (timeout == 0)
+    {
+      ptv = &tv;
+      ptv->tv_sec = 0;
+      ptv->tv_usec = 0;
+    }
+  else if (timeout > 0)
+    {
+      ptv = &tv;
+      ptv->tv_sec = timeout / 1000;
+      ptv->tv_usec = (timeout % 1000) * 1000;
+    }
+  else if (timeout == INFTIM)
+    /* wait forever */
+    ptv = NULL;
+  else
+    {
+      errno = EINVAL;
+      return -1;
+    }
+
+  /* create fd sets and determine max fd */
+  maxfd = -1;
+  FD_ZERO (&rfds);
+  FD_ZERO (&wfds);
+  FD_ZERO (&efds);
+  for (i = 0; i < nfd; i++)
+    {
+      if (pfd[i].fd < 0)
+	continue;
+
+      if (pfd[i].events & (POLLIN | POLLRDNORM))
+	FD_SET (pfd[i].fd, &rfds);
+
+      /* see select(2): "the only exceptional condition detectable
+	 is out-of-band data received on a socket", hence we push
+	 POLLWRBAND events onto wfds instead of efds. */
+      if (pfd[i].events & (POLLOUT | POLLWRNORM | POLLWRBAND))
+	FD_SET (pfd[i].fd, &wfds);
+      if (pfd[i].events & (POLLPRI | POLLRDBAND))
+	FD_SET (pfd[i].fd, &efds);
+      if (pfd[i].fd >= maxfd
+	  && (pfd[i].events & (POLLIN | POLLOUT | POLLPRI
+			       | POLLRDNORM | POLLRDBAND
+			       | POLLWRNORM | POLLWRBAND)))
+	{
+	  maxfd = pfd[i].fd;
+	  if (maxfd > FD_SETSIZE)
+	    {
+	      errno = EOVERFLOW;
+	      return -1;
+	    }
+	}
+    }
+
+  /* examine fd sets */
+  rc = select (maxfd + 1, &rfds, &wfds, &efds, ptv);
+  if (rc < 0)
+    return rc;
+
+  /* establish results */
+  rc = 0;
+  for (i = 0; i < nfd; i++)
+    if (pfd[i].fd < 0)
+      pfd[i].revents = 0;
+    else
+      {
+	int happened = compute_revents (pfd[i].fd, pfd[i].events,
+					&rfds, &wfds, &efds);
+	if (happened)
+	  {
+	    pfd[i].revents = happened;
+	    rc++;
+	  }
+      }
+
+  return rc;
+#else
+  static struct timeval tv0;
+  static HANDLE hEvent;
+  WSANETWORKEVENTS ev;
+  HANDLE h, handle_array[FD_SETSIZE + 2];
+  DWORD ret, wait_timeout, nhandles;
+  fd_set rfds, wfds, xfds;
+  BOOL poll_again;
+  MSG msg;
+  int rc = 0;
+  nfds_t i;
+
+  if (nfd < 0 || timeout < -1)
+    {
+      errno = EINVAL;
+      return -1;
+    }
+
+  if (!hEvent)
+    hEvent = CreateEvent (NULL, FALSE, FALSE, NULL);
+
+  handle_array[0] = hEvent;
+  nhandles = 1;
+  FD_ZERO (&rfds);
+  FD_ZERO (&wfds);
+  FD_ZERO (&xfds);
+
+  /* Classify socket handles and create fd sets. */
+  for (i = 0; i < nfd; i++)
+    {
+      int sought = pfd[i].events;
+      pfd[i].revents = 0;
+      if (pfd[i].fd < 0)
+	continue;
+      if (!(sought & (POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM | POLLWRBAND
+		      | POLLPRI | POLLRDBAND)))
+	continue;
+
+      h = (HANDLE) _get_osfhandle (pfd[i].fd);
+      assert (h != NULL);
+      if (IsSocketHandle (h))
+	{
+	  int requested = FD_CLOSE;
+
+	  /* see above; socket handles are mapped onto select.  */
+	  if (sought & (POLLIN | POLLRDNORM))
+	    {
+	      requested |= FD_READ | FD_ACCEPT;
+	      FD_SET ((SOCKET) h, &rfds);
+	    }
+	  if (sought & (POLLOUT | POLLWRNORM | POLLWRBAND))
+	    {
+	      requested |= FD_WRITE | FD_CONNECT;
+	      FD_SET ((SOCKET) h, &wfds);
+	    }
+	  if (sought & (POLLPRI | POLLRDBAND))
+	    {
+	      requested |= FD_OOB;
+	      FD_SET ((SOCKET) h, &xfds);
+	    }
+
+	  if (requested)
+	    WSAEventSelect ((SOCKET) h, hEvent, requested);
+	}
+      else
+	{
+	  /* Poll now.  If we get an event, do not poll again.  Also,
+	     screen buffer handles are waitable, and they'll block until
+	     a character is available.  win32_compute_revents eliminates
+	     bits for the "wrong" direction. */
+	  pfd[i].revents = win32_compute_revents (h, &sought);
+	  if (sought)
+	    handle_array[nhandles++] = h;
+	  if (pfd[i].revents)
+	    timeout = 0;
+	}
+    }
+
+  if (select (0, &rfds, &wfds, &xfds, &tv0) > 0)
+    {
+      /* Do MsgWaitForMultipleObjects anyway to dispatch messages, but
+	 no need to call select again.  */
+      poll_again = FALSE;
+      wait_timeout = 0;
+    }
+  else
+    {
+      poll_again = TRUE;
+      if (timeout == INFTIM)
+	wait_timeout = INFINITE;
+      else
+	wait_timeout = timeout;
+    }
+
+  for (;;)
+    {
+      ret = MsgWaitForMultipleObjects (nhandles, handle_array, FALSE,
+				       wait_timeout, QS_ALLINPUT);
+
+      if (ret == WAIT_OBJECT_0 + nhandles)
+	{
+	  /* new input of some other kind */
+	  BOOL bRet;
+	  while ((bRet = PeekMessage (&msg, NULL, 0, 0, PM_REMOVE)) != 0)
+	    {
+	      TranslateMessage (&msg);
+	      DispatchMessage (&msg);
+	    }
+	}
+      else
+	break;
+    }
+
+  if (poll_again)
+    select (0, &rfds, &wfds, &xfds, &tv0);
+
+  /* Place a sentinel at the end of the array.  */
+  handle_array[nhandles] = NULL;
+  nhandles = 1;
+  for (i = 0; i < nfd; i++)
+    {
+      int happened;
+
+      if (pfd[i].fd < 0)
+	continue;
+      if (!(pfd[i].events & (POLLIN | POLLRDNORM |
+			     POLLOUT | POLLWRNORM | POLLWRBAND)))
+	continue;
+
+      h = (HANDLE) _get_osfhandle (pfd[i].fd);
+      if (h != handle_array[nhandles])
+	{
+	  /* It's a socket.  */
+	  WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
+	  WSAEventSelect ((SOCKET) h, 0, 0);
+
+	  /* If we're lucky, WSAEnumNetworkEvents already provided a way
+	     to distinguish FD_READ and FD_ACCEPT; this saves a recv later.  */
+	  if (FD_ISSET ((SOCKET) h, &rfds)
+	      && !(ev.lNetworkEvents & (FD_READ | FD_ACCEPT)))
+	    ev.lNetworkEvents |= FD_READ | FD_ACCEPT;
+	  if (FD_ISSET ((SOCKET) h, &wfds))
+	    ev.lNetworkEvents |= FD_WRITE | FD_CONNECT;
+	  if (FD_ISSET ((SOCKET) h, &xfds))
+	    ev.lNetworkEvents |= FD_OOB;
+
+	  happened = win32_compute_revents_socket ((SOCKET) h, pfd[i].events,
+						   ev.lNetworkEvents);
+	}
+      else
+	{
+	  /* Not a socket.  */
+	  int sought = pfd[i].events;
+	  happened = win32_compute_revents (h, &sought);
+	  nhandles++;
+	}
+
+       if ((pfd[i].revents |= happened) != 0)
+	rc++;
+    }
+
+  return rc;
+#endif
+}
diff --git a/compat/win32/poll.h b/compat/win32/poll.h
new file mode 100644
index 0000000..b7aa59d
--- /dev/null
+++ b/compat/win32/poll.h
@@ -0,0 +1,53 @@
+/* Header for poll(2) emulation
+   Contributed by Paolo Bonzini.
+
+   Copyright 2001, 2002, 2003, 2007, 2009, 2010 Free Software Foundation, Inc.
+
+   This file is part of gnulib.
+
+   This program is free software; you can redistribute it and/or modify
+   it under the terms of the GNU General Public License as published by
+   the Free Software Foundation; either version 2, or (at your option)
+   any later version.
+
+   This program is distributed in the hope that it will be useful,
+   but WITHOUT ANY WARRANTY; without even the implied warranty of
+   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+   GNU General Public License for more details.
+
+   You should have received a copy of the GNU General Public License along
+   with this program; if not, write to the Free Software Foundation,
+   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
+
+#ifndef _GL_POLL_H
+#define _GL_POLL_H
+
+/* fake a poll(2) environment */
+#define POLLIN      0x0001      /* any readable data available   */
+#define POLLPRI     0x0002      /* OOB/Urgent readable data      */
+#define POLLOUT     0x0004      /* file descriptor is writeable  */
+#define POLLERR     0x0008      /* some poll error occurred      */
+#define POLLHUP     0x0010      /* file descriptor was "hung up" */
+#define POLLNVAL    0x0020      /* requested events "invalid"    */
+#define POLLRDNORM  0x0040
+#define POLLRDBAND  0x0080
+#define POLLWRNORM  0x0100
+#define POLLWRBAND  0x0200
+
+struct pollfd
+{
+  int fd;                       /* which file descriptor to poll */
+  short events;                 /* events we are interested in   */
+  short revents;                /* events found on return        */
+};
+
+typedef unsigned long nfds_t;
+
+extern int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
+
+/* Define INFTIM only if doing so conforms to POSIX.  */
+#if !defined (_POSIX_C_SOURCE) && !defined (_XOPEN_SOURCE)
+#define INFTIM (-1)
+#endif
+
+#endif /* _GL_POLL_H */
diff --git a/compat/win32/sys/poll.c b/compat/win32/sys/poll.c
deleted file mode 100644
index 708a6c9..0000000
--- a/compat/win32/sys/poll.c
+++ /dev/null
@@ -1,599 +0,0 @@
-/* Emulation for poll(2)
-   Contributed by Paolo Bonzini.
-
-   Copyright 2001-2003, 2006-2010 Free Software Foundation, Inc.
-
-   This file is part of gnulib.
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2, or (at your option)
-   any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License along
-   with this program; if not, write to the Free Software Foundation,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
-
-/* Tell gcc not to warn about the (nfd < 0) tests, below.  */
-#if (__GNUC__ == 4 && 3 <= __GNUC_MINOR__) || 4 < __GNUC__
-# pragma GCC diagnostic ignored "-Wtype-limits"
-#endif
-
-#include <malloc.h>
-
-#include <sys/types.h>
-#include "poll.h"
-#include <errno.h>
-#include <limits.h>
-#include <assert.h>
-
-#if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
-# define WIN32_NATIVE
-# if defined (_MSC_VER)
-#  define _WIN32_WINNT 0x0502
-# endif
-# include <winsock2.h>
-# include <windows.h>
-# include <io.h>
-# include <stdio.h>
-# include <conio.h>
-#else
-# include <sys/time.h>
-# include <sys/socket.h>
-# include <sys/select.h>
-# include <unistd.h>
-#endif
-
-#ifdef HAVE_SYS_IOCTL_H
-# include <sys/ioctl.h>
-#endif
-#ifdef HAVE_SYS_FILIO_H
-# include <sys/filio.h>
-#endif
-
-#include <time.h>
-
-#ifndef INFTIM
-# define INFTIM (-1)
-#endif
-
-/* BeOS does not have MSG_PEEK.  */
-#ifndef MSG_PEEK
-# define MSG_PEEK 0
-#endif
-
-#ifdef WIN32_NATIVE
-
-#define IsConsoleHandle(h) (((long) (h) & 3) == 3)
-
-static BOOL
-IsSocketHandle (HANDLE h)
-{
-  WSANETWORKEVENTS ev;
-
-  if (IsConsoleHandle (h))
-    return FALSE;
-
-  /* Under Wine, it seems that getsockopt returns 0 for pipes too.
-     WSAEnumNetworkEvents instead distinguishes the two correctly.  */
-  ev.lNetworkEvents = 0xDEADBEEF;
-  WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
-  return ev.lNetworkEvents != 0xDEADBEEF;
-}
-
-/* Declare data structures for ntdll functions.  */
-typedef struct _FILE_PIPE_LOCAL_INFORMATION {
-  ULONG NamedPipeType;
-  ULONG NamedPipeConfiguration;
-  ULONG MaximumInstances;
-  ULONG CurrentInstances;
-  ULONG InboundQuota;
-  ULONG ReadDataAvailable;
-  ULONG OutboundQuota;
-  ULONG WriteQuotaAvailable;
-  ULONG NamedPipeState;
-  ULONG NamedPipeEnd;
-} FILE_PIPE_LOCAL_INFORMATION, *PFILE_PIPE_LOCAL_INFORMATION;
-
-typedef struct _IO_STATUS_BLOCK
-{
-  union {
-    DWORD Status;
-    PVOID Pointer;
-  } u;
-  ULONG_PTR Information;
-} IO_STATUS_BLOCK, *PIO_STATUS_BLOCK;
-
-typedef enum _FILE_INFORMATION_CLASS {
-  FilePipeLocalInformation = 24
-} FILE_INFORMATION_CLASS, *PFILE_INFORMATION_CLASS;
-
-typedef DWORD (WINAPI *PNtQueryInformationFile)
-	 (HANDLE, IO_STATUS_BLOCK *, VOID *, ULONG, FILE_INFORMATION_CLASS);
-
-# ifndef PIPE_BUF
-#  define PIPE_BUF      512
-# endif
-
-/* Compute revents values for file handle H.  If some events cannot happen
-   for the handle, eliminate them from *P_SOUGHT.  */
-
-static int
-win32_compute_revents (HANDLE h, int *p_sought)
-{
-  int i, ret, happened;
-  INPUT_RECORD *irbuffer;
-  DWORD avail, nbuffer;
-  BOOL bRet;
-  IO_STATUS_BLOCK iosb;
-  FILE_PIPE_LOCAL_INFORMATION fpli;
-  static PNtQueryInformationFile NtQueryInformationFile;
-  static BOOL once_only;
-
-  switch (GetFileType (h))
-    {
-    case FILE_TYPE_PIPE:
-      if (!once_only)
-	{
-	  NtQueryInformationFile = (PNtQueryInformationFile)
-	    GetProcAddress (GetModuleHandle ("ntdll.dll"),
-			    "NtQueryInformationFile");
-	  once_only = TRUE;
-	}
-
-      happened = 0;
-      if (PeekNamedPipe (h, NULL, 0, NULL, &avail, NULL) != 0)
-	{
-	  if (avail)
-	    happened |= *p_sought & (POLLIN | POLLRDNORM);
-	}
-      else if (GetLastError () == ERROR_BROKEN_PIPE)
-	happened |= POLLHUP;
-
-      else
-	{
-	  /* It was the write-end of the pipe.  Check if it is writable.
-	     If NtQueryInformationFile fails, optimistically assume the pipe is
-	     writable.  This could happen on Win9x, where NtQueryInformationFile
-	     is not available, or if we inherit a pipe that doesn't permit
-	     FILE_READ_ATTRIBUTES access on the write end (I think this should
-	     not happen since WinXP SP2; WINE seems fine too).  Otherwise,
-	     ensure that enough space is available for atomic writes.  */
-	  memset (&iosb, 0, sizeof (iosb));
-	  memset (&fpli, 0, sizeof (fpli));
-
-	  if (!NtQueryInformationFile
-	      || NtQueryInformationFile (h, &iosb, &fpli, sizeof (fpli),
-					 FilePipeLocalInformation)
-	      || fpli.WriteQuotaAvailable >= PIPE_BUF
-	      || (fpli.OutboundQuota < PIPE_BUF &&
-		  fpli.WriteQuotaAvailable == fpli.OutboundQuota))
-	    happened |= *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
-	}
-      return happened;
-
-    case FILE_TYPE_CHAR:
-      ret = WaitForSingleObject (h, 0);
-      if (!IsConsoleHandle (h))
-	return ret == WAIT_OBJECT_0 ? *p_sought & ~(POLLPRI | POLLRDBAND) : 0;
-
-      nbuffer = avail = 0;
-      bRet = GetNumberOfConsoleInputEvents (h, &nbuffer);
-      if (bRet)
-	{
-	  /* Input buffer.  */
-	  *p_sought &= POLLIN | POLLRDNORM;
-	  if (nbuffer == 0)
-	    return POLLHUP;
-	  if (!*p_sought)
-	    return 0;
-
-	  irbuffer = (INPUT_RECORD *) alloca (nbuffer * sizeof (INPUT_RECORD));
-	  bRet = PeekConsoleInput (h, irbuffer, nbuffer, &avail);
-	  if (!bRet || avail == 0)
-	    return POLLHUP;
-
-	  for (i = 0; i < avail; i++)
-	    if (irbuffer[i].EventType == KEY_EVENT)
-	      return *p_sought;
-	  return 0;
-	}
-      else
-	{
-	  /* Screen buffer.  */
-	  *p_sought &= POLLOUT | POLLWRNORM | POLLWRBAND;
-	  return *p_sought;
-	}
-
-    default:
-      ret = WaitForSingleObject (h, 0);
-      if (ret == WAIT_OBJECT_0)
-	return *p_sought & ~(POLLPRI | POLLRDBAND);
-
-      return *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
-    }
-}
-
-/* Convert fd_sets returned by select into revents values.  */
-
-static int
-win32_compute_revents_socket (SOCKET h, int sought, long lNetworkEvents)
-{
-  int happened = 0;
-
-  if ((lNetworkEvents & (FD_READ | FD_ACCEPT | FD_CLOSE)) == FD_ACCEPT)
-    happened |= (POLLIN | POLLRDNORM) & sought;
-
-  else if (lNetworkEvents & (FD_READ | FD_ACCEPT | FD_CLOSE))
-    {
-      int r, error;
-
-      char data[64];
-      WSASetLastError (0);
-      r = recv (h, data, sizeof (data), MSG_PEEK);
-      error = WSAGetLastError ();
-      WSASetLastError (0);
-
-      if (r > 0 || error == WSAENOTCONN)
-	happened |= (POLLIN | POLLRDNORM) & sought;
-
-      /* Distinguish hung-up sockets from other errors.  */
-      else if (r == 0 || error == WSAESHUTDOWN || error == WSAECONNRESET
-	       || error == WSAECONNABORTED || error == WSAENETRESET)
-	happened |= POLLHUP;
-
-      else
-	happened |= POLLERR;
-    }
-
-  if (lNetworkEvents & (FD_WRITE | FD_CONNECT))
-    happened |= (POLLOUT | POLLWRNORM | POLLWRBAND) & sought;
-
-  if (lNetworkEvents & FD_OOB)
-    happened |= (POLLPRI | POLLRDBAND) & sought;
-
-  return happened;
-}
-
-#else /* !MinGW */
-
-/* Convert select(2) returned fd_sets into poll(2) revents values.  */
-static int
-compute_revents (int fd, int sought, fd_set *rfds, fd_set *wfds, fd_set *efds)
-{
-  int happened = 0;
-  if (FD_ISSET (fd, rfds))
-    {
-      int r;
-      int socket_errno;
-
-# if defined __MACH__ && defined __APPLE__
-      /* There is a bug in Mac OS X that causes it to ignore MSG_PEEK
-	 for some kinds of descriptors.  Detect if this descriptor is a
-	 connected socket, a server socket, or something else using a
-	 0-byte recv, and use ioctl(2) to detect POLLHUP.  */
-      r = recv (fd, NULL, 0, MSG_PEEK);
-      socket_errno = (r < 0) ? errno : 0;
-      if (r == 0 || socket_errno == ENOTSOCK)
-	ioctl (fd, FIONREAD, &r);
-# else
-      char data[64];
-      r = recv (fd, data, sizeof (data), MSG_PEEK);
-      socket_errno = (r < 0) ? errno : 0;
-# endif
-      if (r == 0)
-	happened |= POLLHUP;
-
-      /* If the event happened on an unconnected server socket,
-	 that's fine. */
-      else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
-	happened |= (POLLIN | POLLRDNORM) & sought;
-
-      /* Distinguish hung-up sockets from other errors.  */
-      else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
-	       || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
-	happened |= POLLHUP;
-
-      else
-	happened |= POLLERR;
-    }
-
-  if (FD_ISSET (fd, wfds))
-    happened |= (POLLOUT | POLLWRNORM | POLLWRBAND) & sought;
-
-  if (FD_ISSET (fd, efds))
-    happened |= (POLLPRI | POLLRDBAND) & sought;
-
-  return happened;
-}
-#endif /* !MinGW */
-
-int
-poll (pfd, nfd, timeout)
-     struct pollfd *pfd;
-     nfds_t nfd;
-     int timeout;
-{
-#ifndef WIN32_NATIVE
-  fd_set rfds, wfds, efds;
-  struct timeval tv;
-  struct timeval *ptv;
-  int maxfd, rc;
-  nfds_t i;
-
-# ifdef _SC_OPEN_MAX
-  static int sc_open_max = -1;
-
-  if (nfd < 0
-      || (nfd > sc_open_max
-	  && (sc_open_max != -1
-	      || nfd > (sc_open_max = sysconf (_SC_OPEN_MAX)))))
-    {
-      errno = EINVAL;
-      return -1;
-    }
-# else /* !_SC_OPEN_MAX */
-#  ifdef OPEN_MAX
-  if (nfd < 0 || nfd > OPEN_MAX)
-    {
-      errno = EINVAL;
-      return -1;
-    }
-#  endif /* OPEN_MAX -- else, no check is needed */
-# endif /* !_SC_OPEN_MAX */
-
-  /* EFAULT is not necessary to implement, but let's do it in the
-     simplest case. */
-  if (!pfd)
-    {
-      errno = EFAULT;
-      return -1;
-    }
-
-  /* convert timeout number into a timeval structure */
-  if (timeout == 0)
-    {
-      ptv = &tv;
-      ptv->tv_sec = 0;
-      ptv->tv_usec = 0;
-    }
-  else if (timeout > 0)
-    {
-      ptv = &tv;
-      ptv->tv_sec = timeout / 1000;
-      ptv->tv_usec = (timeout % 1000) * 1000;
-    }
-  else if (timeout == INFTIM)
-    /* wait forever */
-    ptv = NULL;
-  else
-    {
-      errno = EINVAL;
-      return -1;
-    }
-
-  /* create fd sets and determine max fd */
-  maxfd = -1;
-  FD_ZERO (&rfds);
-  FD_ZERO (&wfds);
-  FD_ZERO (&efds);
-  for (i = 0; i < nfd; i++)
-    {
-      if (pfd[i].fd < 0)
-	continue;
-
-      if (pfd[i].events & (POLLIN | POLLRDNORM))
-	FD_SET (pfd[i].fd, &rfds);
-
-      /* see select(2): "the only exceptional condition detectable
-	 is out-of-band data received on a socket", hence we push
-	 POLLWRBAND events onto wfds instead of efds. */
-      if (pfd[i].events & (POLLOUT | POLLWRNORM | POLLWRBAND))
-	FD_SET (pfd[i].fd, &wfds);
-      if (pfd[i].events & (POLLPRI | POLLRDBAND))
-	FD_SET (pfd[i].fd, &efds);
-      if (pfd[i].fd >= maxfd
-	  && (pfd[i].events & (POLLIN | POLLOUT | POLLPRI
-			       | POLLRDNORM | POLLRDBAND
-			       | POLLWRNORM | POLLWRBAND)))
-	{
-	  maxfd = pfd[i].fd;
-	  if (maxfd > FD_SETSIZE)
-	    {
-	      errno = EOVERFLOW;
-	      return -1;
-	    }
-	}
-    }
-
-  /* examine fd sets */
-  rc = select (maxfd + 1, &rfds, &wfds, &efds, ptv);
-  if (rc < 0)
-    return rc;
-
-  /* establish results */
-  rc = 0;
-  for (i = 0; i < nfd; i++)
-    if (pfd[i].fd < 0)
-      pfd[i].revents = 0;
-    else
-      {
-	int happened = compute_revents (pfd[i].fd, pfd[i].events,
-					&rfds, &wfds, &efds);
-	if (happened)
-	  {
-	    pfd[i].revents = happened;
-	    rc++;
-	  }
-      }
-
-  return rc;
-#else
-  static struct timeval tv0;
-  static HANDLE hEvent;
-  WSANETWORKEVENTS ev;
-  HANDLE h, handle_array[FD_SETSIZE + 2];
-  DWORD ret, wait_timeout, nhandles;
-  fd_set rfds, wfds, xfds;
-  BOOL poll_again;
-  MSG msg;
-  int rc = 0;
-  nfds_t i;
-
-  if (nfd < 0 || timeout < -1)
-    {
-      errno = EINVAL;
-      return -1;
-    }
-
-  if (!hEvent)
-    hEvent = CreateEvent (NULL, FALSE, FALSE, NULL);
-
-  handle_array[0] = hEvent;
-  nhandles = 1;
-  FD_ZERO (&rfds);
-  FD_ZERO (&wfds);
-  FD_ZERO (&xfds);
-
-  /* Classify socket handles and create fd sets. */
-  for (i = 0; i < nfd; i++)
-    {
-      int sought = pfd[i].events;
-      pfd[i].revents = 0;
-      if (pfd[i].fd < 0)
-	continue;
-      if (!(sought & (POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM | POLLWRBAND
-		      | POLLPRI | POLLRDBAND)))
-	continue;
-
-      h = (HANDLE) _get_osfhandle (pfd[i].fd);
-      assert (h != NULL);
-      if (IsSocketHandle (h))
-	{
-	  int requested = FD_CLOSE;
-
-	  /* see above; socket handles are mapped onto select.  */
-	  if (sought & (POLLIN | POLLRDNORM))
-	    {
-	      requested |= FD_READ | FD_ACCEPT;
-	      FD_SET ((SOCKET) h, &rfds);
-	    }
-	  if (sought & (POLLOUT | POLLWRNORM | POLLWRBAND))
-	    {
-	      requested |= FD_WRITE | FD_CONNECT;
-	      FD_SET ((SOCKET) h, &wfds);
-	    }
-	  if (sought & (POLLPRI | POLLRDBAND))
-	    {
-	      requested |= FD_OOB;
-	      FD_SET ((SOCKET) h, &xfds);
-	    }
-
-	  if (requested)
-	    WSAEventSelect ((SOCKET) h, hEvent, requested);
-	}
-      else
-	{
-	  /* Poll now.  If we get an event, do not poll again.  Also,
-	     screen buffer handles are waitable, and they'll block until
-	     a character is available.  win32_compute_revents eliminates
-	     bits for the "wrong" direction. */
-	  pfd[i].revents = win32_compute_revents (h, &sought);
-	  if (sought)
-	    handle_array[nhandles++] = h;
-	  if (pfd[i].revents)
-	    timeout = 0;
-	}
-    }
-
-  if (select (0, &rfds, &wfds, &xfds, &tv0) > 0)
-    {
-      /* Do MsgWaitForMultipleObjects anyway to dispatch messages, but
-	 no need to call select again.  */
-      poll_again = FALSE;
-      wait_timeout = 0;
-    }
-  else
-    {
-      poll_again = TRUE;
-      if (timeout == INFTIM)
-	wait_timeout = INFINITE;
-      else
-	wait_timeout = timeout;
-    }
-
-  for (;;)
-    {
-      ret = MsgWaitForMultipleObjects (nhandles, handle_array, FALSE,
-				       wait_timeout, QS_ALLINPUT);
-
-      if (ret == WAIT_OBJECT_0 + nhandles)
-	{
-	  /* new input of some other kind */
-	  BOOL bRet;
-	  while ((bRet = PeekMessage (&msg, NULL, 0, 0, PM_REMOVE)) != 0)
-	    {
-	      TranslateMessage (&msg);
-	      DispatchMessage (&msg);
-	    }
-	}
-      else
-	break;
-    }
-
-  if (poll_again)
-    select (0, &rfds, &wfds, &xfds, &tv0);
-
-  /* Place a sentinel at the end of the array.  */
-  handle_array[nhandles] = NULL;
-  nhandles = 1;
-  for (i = 0; i < nfd; i++)
-    {
-      int happened;
-
-      if (pfd[i].fd < 0)
-	continue;
-      if (!(pfd[i].events & (POLLIN | POLLRDNORM |
-			     POLLOUT | POLLWRNORM | POLLWRBAND)))
-	continue;
-
-      h = (HANDLE) _get_osfhandle (pfd[i].fd);
-      if (h != handle_array[nhandles])
-	{
-	  /* It's a socket.  */
-	  WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
-	  WSAEventSelect ((SOCKET) h, 0, 0);
-
-	  /* If we're lucky, WSAEnumNetworkEvents already provided a way
-	     to distinguish FD_READ and FD_ACCEPT; this saves a recv later.  */
-	  if (FD_ISSET ((SOCKET) h, &rfds)
-	      && !(ev.lNetworkEvents & (FD_READ | FD_ACCEPT)))
-	    ev.lNetworkEvents |= FD_READ | FD_ACCEPT;
-	  if (FD_ISSET ((SOCKET) h, &wfds))
-	    ev.lNetworkEvents |= FD_WRITE | FD_CONNECT;
-	  if (FD_ISSET ((SOCKET) h, &xfds))
-	    ev.lNetworkEvents |= FD_OOB;
-
-	  happened = win32_compute_revents_socket ((SOCKET) h, pfd[i].events,
-						   ev.lNetworkEvents);
-	}
-      else
-	{
-	  /* Not a socket.  */
-	  int sought = pfd[i].events;
-	  happened = win32_compute_revents (h, &sought);
-	  nhandles++;
-	}
-
-       if ((pfd[i].revents |= happened) != 0)
-	rc++;
-    }
-
-  return rc;
-#endif
-}
diff --git a/compat/win32/sys/poll.h b/compat/win32/sys/poll.h
deleted file mode 100644
index b7aa59d..0000000
--- a/compat/win32/sys/poll.h
+++ /dev/null
@@ -1,53 +0,0 @@
-/* Header for poll(2) emulation
-   Contributed by Paolo Bonzini.
-
-   Copyright 2001, 2002, 2003, 2007, 2009, 2010 Free Software Foundation, Inc.
-
-   This file is part of gnulib.
-
-   This program is free software; you can redistribute it and/or modify
-   it under the terms of the GNU General Public License as published by
-   the Free Software Foundation; either version 2, or (at your option)
-   any later version.
-
-   This program is distributed in the hope that it will be useful,
-   but WITHOUT ANY WARRANTY; without even the implied warranty of
-   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-   GNU General Public License for more details.
-
-   You should have received a copy of the GNU General Public License along
-   with this program; if not, write to the Free Software Foundation,
-   Inc., 51 Franklin Street, Fifth Floor, Boston, MA 02110-1301, USA.  */
-
-#ifndef _GL_POLL_H
-#define _GL_POLL_H
-
-/* fake a poll(2) environment */
-#define POLLIN      0x0001      /* any readable data available   */
-#define POLLPRI     0x0002      /* OOB/Urgent readable data      */
-#define POLLOUT     0x0004      /* file descriptor is writeable  */
-#define POLLERR     0x0008      /* some poll error occurred      */
-#define POLLHUP     0x0010      /* file descriptor was "hung up" */
-#define POLLNVAL    0x0020      /* requested events "invalid"    */
-#define POLLRDNORM  0x0040
-#define POLLRDBAND  0x0080
-#define POLLWRNORM  0x0100
-#define POLLWRBAND  0x0200
-
-struct pollfd
-{
-  int fd;                       /* which file descriptor to poll */
-  short events;                 /* events we are interested in   */
-  short revents;                /* events found on return        */
-};
-
-typedef unsigned long nfds_t;
-
-extern int poll (struct pollfd *pfd, nfds_t nfd, int timeout);
-
-/* Define INFTIM only if doing so conforms to POSIX.  */
-#if !defined (_POSIX_C_SOURCE) && !defined (_XOPEN_SOURCE)
-#define INFTIM (-1)
-#endif
-
-#endif /* _GL_POLL_H */
-- 
1.7.7.msysgit.1.1.g7b316
