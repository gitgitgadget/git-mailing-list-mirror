From: Erik Faye-Lund <kusmabite@gmail.com>
Subject: [PATCH v3 12/14] mingw: import poll-emulation from gnulib
Date: Sun, 10 Oct 2010 15:20:52 +0200
Message-ID: <1286716854-5744-13-git-send-email-kusmabite@gmail.com>
References: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Cc: msysgit@googlegroups.com, j6t@kdbg.org
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sun Oct 10 15:23:24 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P4vs2-0005GO-3I
	for gcvg-git-2@lo.gmane.org; Sun, 10 Oct 2010 15:23:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757742Ab0JJNXM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Oct 2010 09:23:12 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:54307 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752770Ab0JJNXK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Oct 2010 09:23:10 -0400
Received: by mail-ew0-f46.google.com with SMTP id 20so255794ewy.19
        for <git@vger.kernel.org>; Sun, 10 Oct 2010 06:23:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:cc:subject:date
         :message-id:x-mailer:in-reply-to:references;
        bh=Vd8WQ2jsv7+hTk1cha4R7Ck+YRMmyCDVP2Guy7OoMso=;
        b=Ia+OSyJ8evcCqKTI2iszqOBAklM7HlVv0LkXCB2evDkH0cf81CL6kHsajts4gOR77t
         tivzRMxBS/Sf9AJHLbqOpRBof7div0wHSrNLaVVw26kBtXeICeyZW8x13UXY1WH3UCCW
         Ot+6IVPprX+j7f+cj/HmEEvgOZzc7kFfwEcko=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:in-reply-to:references;
        b=rB9Ml2Ro+RHlfJhqz1acXWvPwGVbYK0AHvPZF7FB2yZSvEQzTLiGSKeCsIkfFp2Mhp
         M9rRjMbNw0jKDQgcpy8+KX5g03Z+pg0nadCigyf+XKlJxHJydjmpgNcAzXIio/pO6Cnd
         pzj9oyDJcKZX+fmnTIdNMlI98PKhrUYZTO5XI=
Received: by 10.213.7.148 with SMTP id d20mr1190738ebd.50.1286716989279;
        Sun, 10 Oct 2010 06:23:09 -0700 (PDT)
Received: from localhost (cm-84.215.188.225.getinternet.no [84.215.188.225])
        by mx.google.com with ESMTPS id u9sm9037179eeh.5.2010.10.10.06.23.07
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Sun, 10 Oct 2010 06:23:08 -0700 (PDT)
X-Mailer: git-send-email 1.7.3.165.gdfe39.dirty
In-Reply-To: <1286716854-5744-1-git-send-email-kusmabite@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/158672>

lib/poll.c and lib/poll.in.h imported from 0a05120 in
git://git.savannah.gnu.org/gnulib.git
---
 compat/win32/poll.c |  597 +++++++++++++++++++++++++++++++++++++++++++++++++++
 compat/win32/poll.h |   53 +++++
 2 files changed, 650 insertions(+), 0 deletions(-)
 create mode 100644 compat/win32/poll.c
 create mode 100644 compat/win32/poll.h

diff --git a/compat/win32/poll.c b/compat/win32/poll.c
new file mode 100644
index 0000000..7c52cb6
--- /dev/null
+++ b/compat/win32/poll.c
@@ -0,0 +1,597 @@
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
+#include <config.h>
+#include <alloca.h>
+
+#include <sys/types.h>
+#include "poll.h"
+#include <errno.h>
+#include <limits.h>
+#include <assert.h>
+
+#if (defined _WIN32 || defined __WIN32__) && ! defined __CYGWIN__
+# define WIN32_NATIVE
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
+         (HANDLE, IO_STATUS_BLOCK *, VOID *, ULONG, FILE_INFORMATION_CLASS);
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
+        {
+          NtQueryInformationFile = (PNtQueryInformationFile)
+            GetProcAddress (GetModuleHandle ("ntdll.dll"),
+                            "NtQueryInformationFile");
+          once_only = TRUE;
+        }
+
+      happened = 0;
+      if (PeekNamedPipe (h, NULL, 0, NULL, &avail, NULL) != 0)
+        {
+          if (avail)
+            happened |= *p_sought & (POLLIN | POLLRDNORM);
+        }
+      else if (GetLastError () == ERROR_BROKEN_PIPE)
+        happened |= POLLHUP;
+
+      else
+        {
+          /* It was the write-end of the pipe.  Check if it is writable.
+             If NtQueryInformationFile fails, optimistically assume the pipe is
+             writable.  This could happen on Win9x, where NtQueryInformationFile
+             is not available, or if we inherit a pipe that doesn't permit
+             FILE_READ_ATTRIBUTES access on the write end (I think this should
+             not happen since WinXP SP2; WINE seems fine too).  Otherwise,
+             ensure that enough space is available for atomic writes.  */
+          memset (&iosb, 0, sizeof (iosb));
+          memset (&fpli, 0, sizeof (fpli));
+
+          if (!NtQueryInformationFile
+              || NtQueryInformationFile (h, &iosb, &fpli, sizeof (fpli),
+                                         FilePipeLocalInformation)
+              || fpli.WriteQuotaAvailable >= PIPE_BUF
+              || (fpli.OutboundQuota < PIPE_BUF &&
+                  fpli.WriteQuotaAvailable == fpli.OutboundQuota))
+            happened |= *p_sought & (POLLOUT | POLLWRNORM | POLLWRBAND);
+        }
+      return happened;
+
+    case FILE_TYPE_CHAR:
+      ret = WaitForSingleObject (h, 0);
+      if (!IsConsoleHandle (h))
+        return ret == WAIT_OBJECT_0 ? *p_sought & ~(POLLPRI | POLLRDBAND) : 0;
+
+      nbuffer = avail = 0;
+      bRet = GetNumberOfConsoleInputEvents (h, &nbuffer);
+      if (bRet)
+        {
+          /* Input buffer.  */
+          *p_sought &= POLLIN | POLLRDNORM;
+          if (nbuffer == 0)
+            return POLLHUP;
+          if (!*p_sought)
+            return 0;
+
+          irbuffer = (INPUT_RECORD *) alloca (nbuffer * sizeof (INPUT_RECORD));
+          bRet = PeekConsoleInput (h, irbuffer, nbuffer, &avail);
+          if (!bRet || avail == 0)
+            return POLLHUP;
+
+          for (i = 0; i < avail; i++)
+            if (irbuffer[i].EventType == KEY_EVENT)
+              return *p_sought;
+          return 0;
+        }
+      else
+        {
+          /* Screen buffer.  */
+          *p_sought &= POLLOUT | POLLWRNORM | POLLWRBAND;
+          return *p_sought;
+        }
+
+    default:
+      ret = WaitForSingleObject (h, 0);
+      if (ret == WAIT_OBJECT_0)
+        return *p_sought & ~(POLLPRI | POLLRDBAND);
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
+        happened |= (POLLIN | POLLRDNORM) & sought;
+
+      /* Distinguish hung-up sockets from other errors.  */
+      else if (r == 0 || error == WSAESHUTDOWN || error == WSAECONNRESET
+               || error == WSAECONNABORTED || error == WSAENETRESET)
+        happened |= POLLHUP;
+
+      else
+        happened |= POLLERR;
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
+         for some kinds of descriptors.  Detect if this descriptor is a
+         connected socket, a server socket, or something else using a
+         0-byte recv, and use ioctl(2) to detect POLLHUP.  */
+      r = recv (fd, NULL, 0, MSG_PEEK);
+      socket_errno = (r < 0) ? errno : 0;
+      if (r == 0 || socket_errno == ENOTSOCK)
+        ioctl (fd, FIONREAD, &r);
+# else
+      char data[64];
+      r = recv (fd, data, sizeof (data), MSG_PEEK);
+      socket_errno = (r < 0) ? errno : 0;
+# endif
+      if (r == 0)
+        happened |= POLLHUP;
+
+      /* If the event happened on an unconnected server socket,
+         that's fine. */
+      else if (r > 0 || ( /* (r == -1) && */ socket_errno == ENOTCONN))
+        happened |= (POLLIN | POLLRDNORM) & sought;
+
+      /* Distinguish hung-up sockets from other errors.  */
+      else if (socket_errno == ESHUTDOWN || socket_errno == ECONNRESET
+               || socket_errno == ECONNABORTED || socket_errno == ENETRESET)
+        happened |= POLLHUP;
+
+      else
+        happened |= POLLERR;
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
+          && (sc_open_max != -1
+              || nfd > (sc_open_max = sysconf (_SC_OPEN_MAX)))))
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
+        continue;
+
+      if (pfd[i].events & (POLLIN | POLLRDNORM))
+        FD_SET (pfd[i].fd, &rfds);
+
+      /* see select(2): "the only exceptional condition detectable
+         is out-of-band data received on a socket", hence we push
+         POLLWRBAND events onto wfds instead of efds. */
+      if (pfd[i].events & (POLLOUT | POLLWRNORM | POLLWRBAND))
+        FD_SET (pfd[i].fd, &wfds);
+      if (pfd[i].events & (POLLPRI | POLLRDBAND))
+        FD_SET (pfd[i].fd, &efds);
+      if (pfd[i].fd >= maxfd
+          && (pfd[i].events & (POLLIN | POLLOUT | POLLPRI
+                               | POLLRDNORM | POLLRDBAND
+                               | POLLWRNORM | POLLWRBAND)))
+        {
+          maxfd = pfd[i].fd;
+          if (maxfd > FD_SETSIZE)
+            {
+              errno = EOVERFLOW;
+              return -1;
+            }
+        }
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
+        int happened = compute_revents (pfd[i].fd, pfd[i].events,
+                                        &rfds, &wfds, &efds);
+        if (happened)
+          {
+            pfd[i].revents = happened;
+            rc++;
+          }
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
+        continue;
+      if (!(sought & (POLLIN | POLLRDNORM | POLLOUT | POLLWRNORM | POLLWRBAND
+                      | POLLPRI | POLLRDBAND)))
+        continue;
+
+      h = (HANDLE) _get_osfhandle (pfd[i].fd);
+      assert (h != NULL);
+      if (IsSocketHandle (h))
+        {
+          int requested = FD_CLOSE;
+
+          /* see above; socket handles are mapped onto select.  */
+          if (sought & (POLLIN | POLLRDNORM))
+            {
+              requested |= FD_READ | FD_ACCEPT;
+              FD_SET ((SOCKET) h, &rfds);
+            }
+          if (sought & (POLLOUT | POLLWRNORM | POLLWRBAND))
+            {
+              requested |= FD_WRITE | FD_CONNECT;
+              FD_SET ((SOCKET) h, &wfds);
+            }
+          if (sought & (POLLPRI | POLLRDBAND))
+            {
+              requested |= FD_OOB;
+              FD_SET ((SOCKET) h, &xfds);
+            }
+
+          if (requested)
+            WSAEventSelect ((SOCKET) h, hEvent, requested);
+        }
+      else
+        {
+          /* Poll now.  If we get an event, do not poll again.  Also,
+             screen buffer handles are waitable, and they'll block until
+             a character is available.  win32_compute_revents eliminates
+             bits for the "wrong" direction. */
+          pfd[i].revents = win32_compute_revents (h, &sought);
+          if (sought)
+            handle_array[nhandles++] = h;
+          if (pfd[i].revents)
+            timeout = 0;
+        }
+    }
+
+  if (select (0, &rfds, &wfds, &xfds, &tv0) > 0)
+    {
+      /* Do MsgWaitForMultipleObjects anyway to dispatch messages, but
+         no need to call select again.  */
+      poll_again = FALSE;
+      wait_timeout = 0;
+    }
+  else
+    {
+      poll_again = TRUE;
+      if (timeout == INFTIM)
+        wait_timeout = INFINITE;
+      else
+        wait_timeout = timeout;
+    }
+
+  for (;;)
+    {
+      ret = MsgWaitForMultipleObjects (nhandles, handle_array, FALSE,
+                                       wait_timeout, QS_ALLINPUT);
+
+      if (ret == WAIT_OBJECT_0 + nhandles)
+        {
+          /* new input of some other kind */
+          BOOL bRet;
+          while ((bRet = PeekMessage (&msg, NULL, 0, 0, PM_REMOVE)) != 0)
+            {
+              TranslateMessage (&msg);
+              DispatchMessage (&msg);
+            }
+        }
+      else
+        break;
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
+        continue;
+      if (!(pfd[i].events & (POLLIN | POLLRDNORM |
+                             POLLOUT | POLLWRNORM | POLLWRBAND)))
+        continue;
+
+      h = (HANDLE) _get_osfhandle (pfd[i].fd);
+      if (h != handle_array[nhandles])
+        {
+          /* It's a socket.  */
+          WSAEnumNetworkEvents ((SOCKET) h, NULL, &ev);
+          WSAEventSelect ((SOCKET) h, 0, 0);
+
+          /* If we're lucky, WSAEnumNetworkEvents already provided a way
+             to distinguish FD_READ and FD_ACCEPT; this saves a recv later.  */
+          if (FD_ISSET ((SOCKET) h, &rfds)
+              && !(ev.lNetworkEvents & (FD_READ | FD_ACCEPT)))
+            ev.lNetworkEvents |= FD_READ | FD_ACCEPT;
+          if (FD_ISSET ((SOCKET) h, &wfds))
+            ev.lNetworkEvents |= FD_WRITE | FD_CONNECT;
+          if (FD_ISSET ((SOCKET) h, &xfds))
+            ev.lNetworkEvents |= FD_OOB;
+
+          happened = win32_compute_revents_socket ((SOCKET) h, pfd[i].events,
+                                                   ev.lNetworkEvents);
+        }
+      else
+        {
+          /* Not a socket.  */
+          int sought = pfd[i].events;
+          happened = win32_compute_revents (h, &sought);
+          nhandles++;
+        }
+
+       if ((pfd[i].revents |= happened) != 0)
+        rc++;
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
-- 
1.7.3.1.51.ge462f.dirty
