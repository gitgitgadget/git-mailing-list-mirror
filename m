Return-Path: <SRS0=w3fS=3B=vger.kernel.org=git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
	URI_HEX,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BB067C33CA2
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:45:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 996CB21744
	for <git@archiver.kernel.org>; Sun, 12 Jan 2020 19:45:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733217AbgALTpJ (ORCPT <rfc822;git@archiver.kernel.org>);
        Sun, 12 Jan 2020 14:45:09 -0500
Received: from belmont79srvr.owm.bell.net ([184.150.200.79]:35251 "EHLO
        mtlfep01.bell.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732957AbgALTpJ (ORCPT <rfc822;git@vger.kernel.org>);
        Sun, 12 Jan 2020 14:45:09 -0500
X-Greylist: delayed 981 seconds by postgrey-1.27 at vger.kernel.org; Sun, 12 Jan 2020 14:45:08 EST
Received: from bell.net mtlfep02 184.150.200.30 by mtlfep02.bell.net
          with ESMTP
          id <20200112192846.XDFC115221.mtlfep02.bell.net@mtlspm01.bell.net>
          for <git@vger.kernel.org>; Sun, 12 Jan 2020 14:28:46 -0500
Received: from [192.168.2.49] (really [70.53.53.104]) by mtlspm01.bell.net
          with ESMTP
          id <20200112192846.KBBR130487.mtlspm01.bell.net@[192.168.2.49]>;
          Sun, 12 Jan 2020 14:28:46 -0500
To:     git@vger.kernel.org
From:   John David Anglin <dave.anglin@bell.net>
Subject: Porting git version 2.25.0.rc2 to hppa2.0w-hp-hpux11.11 using
 gcc-8.3.1
Openpgp: preference=signencrypt
Message-ID: <c9aa5047-7438-8f2f-985c-1c8771354211@bell.net>
Date:   Sun, 12 Jan 2020 14:28:47 -0500
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.1
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CM-Analysis: v=2.3 cv=I5Mbu+og c=1 sm=1 tr=0 a=htCe9XT+XAlGhzqgweArVg==:117 a=htCe9XT+XAlGhzqgweArVg==:17 a=IkcTkHD0fZMA:10 a=Jdjhy38mL1oA:10 a=9I5xiGouAAAA:8 a=FBHGMhGWAAAA:8 a=jWkETUwYWubrse574Y8A:9 a=QEXdDO2ut3YA:10 a=JLDirTIzZPoA:10 a=ARFN2YZ7Uv8kHtb7LS-q:22 a=9gvnlMMaQFpL9xblJ6ne:22 a=Z5ABNNGmrOfJ6cZ5bIyy:22 a=UDnyf2zBuKT2w-IlGP_r:22
X-CM-Envelope: MS4wfCA4pba58+EFc4+frsVPo6IDv4M+Ww5bVlrATyk/ev+naeYO8vyJTo0XshmVuWkHXdetktpp4ARQOqQ+S/f9UDIb9FAtRwpBo9J1+24Trs3ZjfCkg9+j 7XyJjSi7rZFIekcGHEeJs1cSB113Q0KnYRJWPzng5BWxDqcI267ra7iT
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Since the GCC project is switching to a git archive, there was a need to port git to hpux11.11.
In particular, we need git to continue support for the hppa64 target as linux doesn't yet have a 64-bit
runtime.  This mail documents the changes that I needed to build git on hppa2.0w-hp-hpux11.11.

1) SCNuMAX is missing from inttypes.h

I needed to add back a define in git-compat-util.h.  I will probably fix this in gcc in the near future.

2) strtoll() and strtoull() are not supported

This causes a problem in t/helper/test-progress.c.  Regardless of what configure thinks, the target
supports strtoimax() and strtoumax().  So, I changed t/helper/test-progress.c to use uintmax_t and
strtoumax().  strtoimax() and strtoumax() are used in other places, so this makes test-progress.c
consistent with the other usage.

Internally, strtoumax() is implemented is __strtoull().  So, the strtoumax() version has the same range
as the strtoull() version. It would be possible to implement strtoull() and strtoll() with an include hack
in gcc but most packages use the versions in libiberty and gnulib.

3) Bus error in recv_sideband

See:
http://git.661346.n2.nabble.com/git-failure-on-HP-UX-td6335104.html

This error occurs when one tries to clone an archive:

Dump of assembler code for function recv_sideband:
   0x0017fe30 <+0>:     stw rp,-14(sp)
   0x0017fe34 <+4>:     addil L%10000,sp,r1
   0x0017fe38 <+8>:     ldo 80(r1),sp
=> 0x0017fe3c <+12>:    stw r14,-70(sp)

(gdb) bt
#0  0x0017fe3c in recv_sideband () from /opt/gnu/libexec/git-core/git
#1  0x0012e874 in sideband_demux () from /opt/gnu/libexec/git-core/git
#2  0x001b5e80 in run_thread () from /opt/gnu/libexec/git-core/git
#3  0xc005b290 in __pthread_body () from /opt/langtools/lib/libpthread.1

int recv_sideband(const char *me, int in_stream, int out)
{
        char buf[LARGE_PACKET_MAX + 1];
        ...

The bus error occurs because the frame size needed for buf and the other locals exceeds the
default thread stack size.  This can be changed using the PTHREAD_DEFAULT_STACK_SIZE environment
variable.  For example,

export PTHREAD_DEFAULT_STACK_SIZE=131072

It also could be adjusted using pthread_default_stacksize_np().  However, it seemed better to me to
allocate buf using malloc and avoid the issue entirely.

4) NO_PREAD is required

Without NO_PREAD, we get the following error:

fatal: premature end of pack file, 106 bytes missing
fatal: index-pack failed

This occurs on the first pread() call.  There is some kind of sequencing issue as doing a fprintf
to stderr changes the behavior.  However, it doesn't fix the error.

5) -pthread is required

The libc library contains pthread stub routines.  -pthread is needed to cause gcc to correctly link
with thread support.

The following summarizes the code changes:

diff --git a/git-compat-util.h b/git-compat-util.h
index aed0b5d4f9..bcc0d925bf 100644
--- a/git-compat-util.h
+++ b/git-compat-util.h
@@ -1335,4 +1335,8 @@ static inline void *container_of_or_null_offset(void *ptr, size_t offset)
 	((uintptr_t)&(ptr)->member - (uintptr_t)(ptr))
 #endif /* !__GNUC__ */

+#ifndef SCNuMAX
+#define SCNuMAX PRIuMAX
+#endif
+
 #endif
diff --git a/pkt-line.c b/pkt-line.c
index a0e87b1e81..5024325c81 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -444,7 +444,7 @@ ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)

 int recv_sideband(const char *me, int in_stream, int out)
 {
-	char buf[LARGE_PACKET_MAX + 1];
+	char *buf = xmalloc(LARGE_PACKET_MAX + 1);
 	int len;
 	struct strbuf scratch = STRBUF_INIT;
 	enum sideband_type sideband_type;
@@ -460,6 +460,7 @@ int recv_sideband(const char *me, int in_stream, int out)
 			write_or_die(out, buf + 1, len - 1);
 			break;
 		default: /* errors: message already written */
+			free(buf);
 			return sideband_type;
 		}
 	}
diff --git a/t/helper/test-progress.c b/t/helper/test-progress.c
index 42b96cb103..b96a20237a 100644
--- a/t/helper/test-progress.c
+++ b/t/helper/test-progress.c
@@ -54,18 +54,18 @@ int cmd__progress(int argc, const char **argv)
 		char *end;

 		if (skip_prefix(line.buf, "progress ", (const char **) &end)) {
-			uint64_t item_count = strtoull(end, &end, 10);
+			uintmax_t item_count = strtoumax(end, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
 			display_progress(progress, item_count);
 		} else if (skip_prefix(line.buf, "throughput ",
 				       (const char **) &end)) {
-			uint64_t byte_count, test_ms;
+			uintmax_t byte_count, test_ms;

-			byte_count = strtoull(end, &end, 10);
+			byte_count = strtoumax(end, &end, 10);
 			if (*end != ' ')
 				die("invalid input: '%s'\n", line.buf);
-			test_ms = strtoull(end + 1, &end, 10);
+			test_ms = strtoumax(end + 1, &end, 10);
 			if (*end != '\0')
 				die("invalid input: '%s'\n", line.buf);
 			progress_test_ns = test_ms * 1000 * 1000;

The following summarizes the changes to config.mak.autogen after running configure:

--- config.mak.autogen.save	2020-01-12 13:17:09 +0000
+++ config.mak.autogen	2020-01-12 13:14:54 +0000
@@ -75,13 +75,15 @@
 NO_MEMMEM=YesPlease
 NO_STRLCPY=YesPlease
 NO_UINTMAX_T=
-NO_STRTOUMAX=YesPlease
+NO_STRTOULL=YesPlease
+NO_STRTOUMAX=
 NO_SETENV=YesPlease
 NO_UNSETENV=YesPlease
 NO_MKDTEMP=YesPlease
 NO_INITGROUPS=
 HAVE_GETDELIM=
 HAVE_BSD_SYSCTL=
-PTHREAD_CFLAGS=
+PTHREAD_CFLAGS=-pthread
 PTHREAD_LIBS=
 NO_PTHREADS=
+NO_PREAD=YesPlease

Regards,
Dave
-- 
John David Anglin  dave.anglin@bell.net
