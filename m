From: "Joachim Schmitz" <jojo@schmitz-digital.de>
Subject: RE: Porting git to HP NonStop
Date: Fri, 10 Aug 2012 22:08:49 +0200
Message-ID: <004d01cd7733$f55d43e0$e017cba0$@schmitz-digital.de>
References: <003a01cd7709$63725260$2a56f720$@schmitz-digital.de> <CAJo=hJvwih+aOMg6SKP94_1q-az1XV-1Pcf=_fGbvdDcDpC23A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>, <rsbecker@nexbridge.com>
To: "'Shawn Pearce'" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Fri Aug 10 22:09:35 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SzvWU-0008H3-Np
	for gcvg-git-2@plane.gmane.org; Fri, 10 Aug 2012 22:09:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758145Ab2HJUJE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Aug 2012 16:09:04 -0400
Received: from moutng.kundenserver.de ([212.227.126.171]:51347 "EHLO
	moutng.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754992Ab2HJUJD (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Aug 2012 16:09:03 -0400
Received: from DualCore (dsdf-4db5242c.pool.mediaWays.net [77.181.36.44])
	by mrelayeu.kundenserver.de (node=mreu4) with ESMTP (Nemesis)
	id 0Lowim-1TcaFM3V92-00eqfY; Fri, 10 Aug 2012 22:09:01 +0200
In-Reply-To: 
X-Mailer: Microsoft Outlook 14.0
Thread-Index: AQJtb+yK82c1fE/4VXt1krEuodTb9QKmN7Eflf4hv7CAADBEQA==
Content-Language: de
X-Provags-ID: V02:K0:O8zwzAE6jtRoB0sisU4DFIBnK7jju7w5Pt65r/XPRYb
 GnFtPZVlpcUHOBHAvBiGDYsgnij+Hn+r+fLhRcCuWMTZiDIMqa
 qaNhO4GcdHDcQc9/u/dUXn4o6c/zK2sDiww+EiNmr1oRiD2ai0
 6deA/0upJp9i0ut6rpEc3YCszFa0QpPinEC/qO9MpM3tiHsTYJ
 KsU7/yRXo+BJBafqkT/GjoYlawgFhm2/hJDiIbpijtw7fxtTSd
 3Q1DKiqs89nkah1AT2iM4lLq1sZVJFBeu9xlsBQbHr/O12B/Oj
 LknklDJI4XmPGS8yOkoAbQj8AArwyPY5K/PbpMS4r/Qx0ldYgZ
 8oaRIFwgCGx4XhGxBGDxzH+ycSqp16EUsjjEFcup5DxEz+8dB5
 8queFNIUbuuEQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/203255>

> From: Joachim Schmitz [mailto:jojo@schmitz-digital.de]
> Sent: Friday, August 10, 2012 7:33 PM
> To: 'Shawn Pearce'
> Cc: 'git@vger.kernel.org'; 'rsbecker@nexbridge.com'
> Subject: RE: Porting git to HP NonStop
> 
> > From: Shawn Pearce [mailto:spearce@spearce.org]
> > Sent: Friday, August 10, 2012 6:28 PM
> > To: Joachim Schmitz
> > Cc: git@vger.kernel.org; rsbecker@nexbridge.com
> > Subject: Re: Porting git to HP NonStop
> >
> > On Fri, Aug 10, 2012 at 8:04 AM, Joachim Schmitz
> > <jojo@schmitz-digital.de>
> > wrote:
<snip>
> > >> - HP NonStop doesn't have stat.st_blocks, this is used in
> > > builtin/count-objects.c
> > >> around line 45, not sure yet how to fix that.
> >
> > IIRC the block count is only used to give the user some notion of how
> > much disk was wasted by the repository. You could hack a macro that
> > redefines this as st_size.
> 
> OK, thanks, will try that.

Setting "NO_ST_BLOCKS_IN_STRUCT_STAT = YesPlease" in Makefile helps, no need
for further hacking ;-).

> > >> - HP NonStop doesn't have stat.st_?time.nsec, there are several
> > >> places
> > > what an
> > >> "#ifdef USE_NSEC" is missing, I can provide a diff if needed
> > >> (offending
> > >> files: builtin/fetch-pack.c and read-cache.c).
> >
> > I think this would be appreciated by anyone else that has a similar
> > problem where the platform lacks nsec.
> 
> Will do.

OK, here we go:

/usr/local/bin/diff -EBbu ./builtin/fetch-pack.c.orig ./builtin/fetch-pack.c
--- ./builtin/fetch-pack.c.orig 2012-07-30 15:50:38 -0500
+++ ./builtin/fetch-pack.c      2012-08-10 01:50:28 -0500
@@ -1096,7 +1096,9 @@
                int fd;

                mtime.sec = st.st_mtime;
+#ifdef USE_NSEC
                mtime.nsec = ST_MTIME_NSEC(st);
+#endif
                if (stat(shallow, &st)) {
                        if (mtime.sec)
                                die("shallow file was removed during
fetch");
/usr/local/bin/diff -EBbu ./read-cache.c.orig ./read-cache.c
--- ./read-cache.c.orig 2012-07-30 15:50:38 -0500
+++ ./read-cache.c      2012-08-09 10:57:57 -0500
@@ -72,8 +72,10 @@
 {
        ce->ce_ctime.sec = (unsigned int)st->st_ctime;
        ce->ce_mtime.sec = (unsigned int)st->st_mtime;
+#ifdef USE_NSEC
        ce->ce_ctime.nsec = ST_CTIME_NSEC(*st);
        ce->ce_mtime.nsec = ST_MTIME_NSEC(*st);
+#endif
        ce->ce_dev = st->st_dev;
        ce->ce_ino = st->st_ino;
        ce->ce_uid = st->st_uid;
@@ -1465,7 +1467,9 @@
        }
        strbuf_release(&previous_name_buf);
        istate->timestamp.sec = st.st_mtime;
+#ifdef USE_NSEC
        istate->timestamp.nsec = ST_MTIME_NSEC(st);
+#endif

        while (src_offset <= mmap_size - 20 - 8) {
                /* After an array of active_nr index entries,
@@ -1821,7 +1825,9 @@
        if (ce_flush(&c, newfd) || fstat(newfd, &st))
                return -1;
        istate->timestamp.sec = (unsigned int)st.st_mtime;
+#ifdef USE_NSEC
        istate->timestamp.nsec = ST_MTIME_NSEC(st);
+#endif
        return 0;
 }

Hope this helps?

Could you also consider adding the following:

/usr/local/bin/diff -EBbu ./git-compat-util.h.orig ./git-compat-util.h
--- ./git-compat-util.h.orig    2012-07-30 15:50:38 -0500
+++ ./git-compat-util.h 2012-08-10 09:59:56 -0500
@@ -74,7 +74,8 @@
 # define _XOPEN_SOURCE 500
 # endif
 #elif !defined(__APPLE__) && !defined(__FreeBSD__) && !defined(__USLC__) &&
\
-      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__)
+      !defined(_M_UNIX) && !defined(__sgi) && !defined(__DragonFly__) && \
+      !defined(__TANDEM)
 #define _XOPEN_SOURCE 600 /* glibc2 and AIX 5.3L need 500, OpenBSD needs
600 for S_ISLNK() */
 #define _XOPEN_SOURCE_EXTENDED 1 /* AIX 5.3L needs this */
 #endif
@@ -98,6 +99,11 @@
 #include <stdlib.h>
 #include <stdarg.h>
 #include <string.h>
+#ifdef __TANDEM
+# include <strings.h> /* for strcasecmp() */
+  typedef long int intptr_t;
+  typedef unsigned long int uintptr_t;
+#endif
 #include <errno.h>
 #include <limits.h>
 #include <sys/param.h>

Bye, Jojo
