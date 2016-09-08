Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-2.9 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD,URIBL_RED shortcircuit=no autolearn=no autolearn_force=no
	version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 9527C20705
	for <e@80x24.org>; Thu,  8 Sep 2016 18:21:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758363AbcIHSVm (ORCPT <rfc822;e@80x24.org>);
        Thu, 8 Sep 2016 14:21:42 -0400
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33930 "EHLO
        mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753935AbcIHSVj (ORCPT <rfc822;git@vger.kernel.org>);
        Thu, 8 Sep 2016 14:21:39 -0400
Received: by mail-wm0-f68.google.com with SMTP id w12so9035952wmf.1
        for <git@vger.kernel.org>; Thu, 08 Sep 2016 11:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=Z9kG1cssthoibAhBuano3ZMdehF5+mmw2FOU+1pw7lk=;
        b=I5voS52lXmGTPeHzC+PZkIrQydLKYJX0jG8W+oBYwDk0EDRGTQHD76iJDjqoMRJCvg
         BMiqpjN48+QP9HowDOJUBHdP6FP11ZecgDbWfKQrvhx1IqfyCw7BjHHGSqlWauZCVRqV
         zXAesARhImmtfNYFom4QHD0ABXSsUJ/GElrvGN+VPsvUe2L73/QRLrdeEAVpCIYMNkUJ
         eszfCezYDpH8Aoj0UIQOPNLb6HBee3r1ryl+6FsD0dA4XKITitwcgH9fd4IKTYXF1Ggu
         aGJbh3+nNJj5eSJVIbnVPvRWOYz6OSeTMqINwjC3/1fDsql4VcXPnkDQkBRH+NFyjwEv
         T5eQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=Z9kG1cssthoibAhBuano3ZMdehF5+mmw2FOU+1pw7lk=;
        b=LW9C8zo94jfH2LdhDCTDTZZsTeWNtklYeCHlRbUgMYw/UAj0a+qel4ZeK3vsm+irOR
         QikFUQ+q1poo+4gk91MMXXWLK0vWSl/MpofMd8EmObVjZ5bJb7yVArWiTPrFC/G0eZ4N
         x/qok9U7QJilYSc0rwtpmbOJdv+y9RWqlE/tfMdrnFBCxvG1FXDttffl70sBmoadSdly
         rpQy5BoV6Zaggq9Cv3hgNFmzhy1ZHEsxb2FBqMXgxhcijVNzQGfb741FdsgUNWNZRdhw
         +NaQhh1gZIs1KEtNDaoVgSaDDtFpNRx7w4tivJJgwblqYiSLxIpRUqnz7SfuJzuyHmZo
         z0PQ==
X-Gm-Message-State: AE9vXwPvjVvd1pyyN+tcsXPXBbL//tJKYlNp2XJIbBlj8JdKXAVsUI1LqFcsX45dqvm71g==
X-Received: by 10.28.147.76 with SMTP id v73mr1573080wmd.56.1473358896831;
        Thu, 08 Sep 2016 11:21:36 -0700 (PDT)
Received: from slxBook4.local.com (adsknateur.autodesk.com. [132.188.32.100])
        by smtp.gmail.com with ESMTPSA id b128sm10967467wmb.21.2016.09.08.11.21.34
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Thu, 08 Sep 2016 11:21:36 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     peff@peff.net, gitster@pobox.com, sbeller@google.com,
        Johannes.Schindelin@gmx.de, jnareb@gmail.com, mlbright@gmail.com,
        tboegi@web.de, jacob.keller@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v7 00/10] Git filter protocol
Date:   Thu,  8 Sep 2016 20:21:22 +0200
Message-Id: <20160908182132.50788-1-larsxschneider@gmail.com>
X-Mailer: git-send-email 2.10.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

From: Lars Schneider <larsxschneider@gmail.com>

The goal of this series is to avoid launching a new clean/smudge filter
process for each file that is filtered.

A short summary about v1 to v5 can be found here:
https://git.github.io/rev_news/2016/08/17/edition-18/

This series is also published on web:
https://github.com/larsxschneider/git/pull/11

Thanks a lot to
  Stefan, Junio, Jakub (Narebski and Keller), Peff, and Torsten
for very helpful reviews,
Lars



## Major changes since v6

* series rebased to Git v2.10.0
* simplified and improved multi-packet test
* v2 filter takes precedence over v1 filter
* rename "error-all" to "abort"
* patch 07/13 "pack-protocol: fix maximum pkt-line size" submitted separately:
  http://public-inbox.org/git/20160829175509.69050-1-larsxschneider@gmail.com/
* removed "10/13 convert: generate large test files only once"
* patch 13/13 "read-cache: make sure file handles are not inherited by child
  processes" moved to an own series:
  http://public-inbox.org/git/20160905211111.72956-1-larsxschneider@gmail.com/



## All changes since v6

### Stefan

* http://public-inbox.org/git/CAGZ79kaJn-yf28+Ls2JyqSs6Jt-Oj2JW-sAXQn-Oe5xaxSyjMQ@mail.gmail.com/
    * submit patch "pack-protocol: fix maximum pkt-line size" separately:
      http://public-inbox.org/git/20160829175509.69050-1-larsxschneider@gmail.com/

* http://public-inbox.org/git/CAGZ79kbEoYVM_+MWkajT2pHN1OKZXATe5d+Dv_uSJ7dyPGxUeg@mail.gmail.com/
    * trace failures in new *_gently() pkt-line functions


### Junio

* http://public-inbox.org/git/xmqq8tvkle6o.fsf@gitster.mtv.corp.google.com/
    * share code between packet_write_fmt() and packet_write_fmt_gently()

* http://public-inbox.org/git/xmqq4m68ldrg.fsf@gitster.mtv.corp.google.com/
    * remove "Second, it will..." from "pkt-line: add packet_write_gently()"
      commit message
    * use separate buffer in write_packetized_from_fd()
    * fix write order in packet_write_gently()

* http://public-inbox.org/git/xmqqzio0jxh7.fsf@gitster.mtv.corp.google.com/
    * rename read/write flush terminated packet streams functions
    * remove meaningless "bytes_to_write > ..." check
    * reuse packet_read() function in read_packetized_to_buf()

* http://public-inbox.org/git/xmqqk2f3fgbd.fsf@gitster.mtv.corp.google.com/
    * revert test_config replacement in test setup

* http://public-inbox.org/git/xmqq37lncvj6.fsf@gitster.mtv.corp.google.com/
    * improve multi-packet test

* http://public-inbox.org/git/xmqqzinv6wtg.fsf@gitster.mtv.corp.google.com/
    * give v2 filter precedence over v1 filter

* http://public-inbox.org/git/xmqqmvjt3nht.fsf@gitster.mtv.corp.google.com/
    * explain that "error" behavior mimics v1 filter
    * explain that Git closes the pipe on exit to allow the filter a graceful
      exit


### Jakub

* http://public-inbox.org/git/7fbd02a1-ad62-7391-df2a-835aae8a62a7@gmail.com/
    * rename "error-all" to "abort"
    * add a simple Perl v2 filter example in contrib



## Interdiff (v6..v7)

diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index df059e9..ac000ea 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -470,20 +470,11 @@ packet:          git< status=error\n
 packet:          git< 0000
 ------------------------

-In case the filter cannot or does not want to process the content
-as well as any future content for the lifetime of the Git process,
-it is expected to respond with an "error-all" status. Depending on
-the `filter.<driver>.required` flag Git will interpret that as error
-but it will not stop or restart the filter process.
-------------------------
-packet:          git< status=error-all\n
-packet:          git< 0000
-------------------------
-
 If the filter experiences an error during processing, then it can
-send the status "error". Depending on the `filter.<driver>.required`
-flag Git will interpret that as error but it will not stop or restart
-the filter process.
+send the status "error" after the content was (partially or
+completely) sent. Depending on the `filter.<driver>.required` flag
+Git will interpret that as error but it will not stop or restart the
+filter process.
 ------------------------
 packet:          git< status=success\n
 packet:          git< 0000
@@ -495,21 +486,38 @@ packet:          git< 0000

 If the filter dies during the communication or does not adhere to
 the protocol then Git will stop the filter process and restart it
-with the next file that needs to be processed.
+with the next file that needs to be processed. Depending on the
+`filter.<driver>.required` flag Git will interpret that as error.
+
+The error handling for all cases above mimic the behavior of
+the `filter.<driver>.clean` / `filter.<driver>.smudge` error
+handling.
+
+In case the filter cannot or does not want to process the content
+as well as any future content for the lifetime of the Git process,
+it is expected to respond with an "abort" status. Depending on
+the `filter.<driver>.required` flag Git will interpret that as error
+for the content as well as any future content for the lifetime of the
+Git process but it will not stop or restart the filter process.
+------------------------
+packet:          git< status=abort\n
+packet:          git< 0000
+------------------------

 After the filter has processed a blob it is expected to wait for
-the next "key=value" list containing a command. When the Git process
-terminates, it will send a kill signal to the filter in that stage.
+the next "key=value" list containing a command. Git will close
+the command pipe on exit. The filter is expected to detect EOF
+and exit gracefully on its own.

 A long running filter demo implementation can be found in
-`t/t0021/rot13-filter.pl` located in the Git core repository.
-If you develop your own long running filter process then the
-`GIT_TRACE_PACKET` environment variables can be very helpful
-for debugging (see linkgit:git[1]).
-
-If a `filter.<driver>.clean` or `filter.<driver>.smudge` command
-is configured then these commands always take precedence over
-a configured `filter.<driver>.process` command.
+`contrib/long-running-filter/example.pl` located in the Git
+core repository. If you develop your own long running filter
+process then the `GIT_TRACE_PACKET` environment variables can be
+very helpful for debugging (see linkgit:git[1]).
+
+If a `filter.<driver>.process` command is configured then it
+always takes precedence over a configured `filter.<driver>.clean`
+or `filter.<driver>.smudge` command.

 Please note that you cannot use an existing `filter.<driver>.clean`
 or `filter.<driver>.smudge` command with `filter.<driver>.process`
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
new file mode 100755
index 0000000..279fbfb
--- /dev/null
+++ b/contrib/long-running-filter/example.pl
@@ -0,0 +1,111 @@
+#!/usr/bin/perl
+#
+# Example implementation for the Git filter protocol version 2
+# See Documentation/gitattributes.txt, section "Filter Protocol"
+#
+
+use strict;
+use warnings;
+
+my $MAX_PACKET_CONTENT_SIZE = 65516;
+
+sub packet_read {
+    my $buffer;
+    my $bytes_read = read STDIN, $buffer, 4;
+    if ( $bytes_read == 0 ) {
+
+        # EOF - Git stopped talking to us!
+        exit();
+    }
+    elsif ( $bytes_read != 4 ) {
+        die "invalid packet size '$bytes_read' field";
+    }
+    my $pkt_size = hex($buffer);
+    if ( $pkt_size == 0 ) {
+        return ( 1, "" );
+    }
+    elsif ( $pkt_size > 4 ) {
+        my $content_size = $pkt_size - 4;
+        $bytes_read = read STDIN, $buffer, $content_size;
+        if ( $bytes_read != $content_size ) {
+            die "invalid packet ($content_size expected; $bytes_read read)";
+        }
+        return ( 0, $buffer );
+    }
+    else {
+        die "invalid packet size";
+    }
+}
+
+sub packet_write {
+    my ($packet) = @_;
+    print STDOUT sprintf( "%04x", length($packet) + 4 );
+    print STDOUT $packet;
+    STDOUT->flush();
+}
+
+sub packet_flush {
+    print STDOUT sprintf( "%04x", 0 );
+    STDOUT->flush();
+}
+
+( packet_read() eq ( 0, "git-filter-client" ) ) || die "bad initialization";
+( packet_read() eq ( 0, "version=2" ) )         || die "bad version";
+( packet_read() eq ( 1, "" ) )                  || die "bad version end";
+
+packet_write("git-filter-server\n");
+packet_write("version=2\n");
+
+( packet_read() eq ( 0, "clean=true" ) )  || die "bad capability";
+( packet_read() eq ( 0, "smudge=true" ) ) || die "bad capability";
+( packet_read() eq ( 1, "" ) )            || die "bad capability end";
+
+packet_write( "clean=true\n" );
+packet_write( "smudge=true\n" );
+packet_flush();
+
+while (1) {
+    my ($command) = packet_read() =~ /^command=([^=]+)\n$/;
+    my ($pathname) = packet_read() =~ /^pathname=([^=]+)\n$/;
+
+    packet_read();
+
+    my $input = "";
+    {
+        binmode(STDIN);
+        my $buffer;
+        my $done = 0;
+        while ( !$done ) {
+            ( $done, $buffer ) = packet_read();
+            $input .= $buffer;
+        }
+    }
+
+    my $output;
+    if ( $command eq "clean" ) {
+        ### Perform clean here ###
+        $output = $input;
+    }
+    elsif ( $command eq "smudge" ) {
+        ### Perform smudge here ###
+        $output = $input;
+    }
+    else {
+        die "bad command '$command'";
+    }
+
+    packet_write("status=success\n");
+    packet_flush();
+    while ( length($output) > 0 ) {
+        my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
+        packet_write($packet);
+        if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
+            $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
+        }
+        else {
+            $output = "";
+        }
+    }
+    packet_flush(); # flush content!
+    packet_flush(); # empty list!
+}
diff --git a/convert.c b/convert.c
index 0269a49..0ed48ed 100644
--- a/convert.c
+++ b/convert.c
@@ -723,9 +723,9 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
    goto done;

  if (fd >= 0)
-   err = packet_write_stream_with_flush_from_fd(fd, process->in);
+   err = write_packetized_from_fd(fd, process->in);
  else
-   err = packet_write_stream_with_flush_from_buf(src, len, process->in);
+   err = write_packetized_from_buf(src, len, process->in);
  if (err)
    goto done;

@@ -734,7 +734,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
  if (err)
    goto done;

- err = packet_read_till_flush(process->out, &nbuf) < 0;
+ err = read_packetized_to_buf(process->out, &nbuf) < 0;
  if (err)
    goto done;

@@ -747,7 +747,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
  if (err || errno == EPIPE) {
    if (!strcmp(filter_status.buf, "error")) {
      /* The filter signaled a problem with the file. */
-   } else if (!strcmp(filter_status.buf, "error-all")) {
+   } else if (!strcmp(filter_status.buf, "abort")) {
      /*
       * The filter signaled a permanent problem. Don't try to filter
       * files with the same command for the lifetime of the current
@@ -790,9 +790,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
  if (!dst)
    return 1;

- if ((CAP_CLEAN & wanted_capability) && drv->clean)
+ if (!drv->process && (CAP_CLEAN & wanted_capability) && drv->clean)
    cmd = drv->clean;
- else if ((CAP_SMUDGE & wanted_capability) && drv->smudge)
+ else if (!drv->process && (CAP_SMUDGE & wanted_capability) && drv->smudge)
    cmd = drv->smudge;

  if (cmd && *cmd)
diff --git a/pkt-line.c b/pkt-line.c
index 3033aa3..5001a07 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -3,7 +3,6 @@
 #include "run-command.h"

 char packet_buffer[LARGE_PACKET_MAX];
-static char packet_write_buffer[LARGE_PACKET_MAX];
 static const char *packet_trace_prefix = "git";
 static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
 static struct trace_key trace_pack = TRACE_KEY_INIT(PACKFILE);
@@ -95,7 +94,10 @@ void packet_flush(int fd)
 int packet_flush_gently(int fd)
 {
  packet_trace("0000", 4, 1);
- return (write_in_full(fd, "0000", 4) == 4 ? 0 : -1);
+ if (write_in_full(fd, "0000", 4) == 4)
+   return 0;
+ error("flush packet write failed");
+ return -1;
 }

 void packet_buf_flush(struct strbuf *buf)
@@ -132,39 +134,70 @@ static void format_packet(struct strbuf *out, const char *fmt, va_list args)
  packet_trace(out->buf + orig_len + 4, n - 4, 1);
 }

+static int packet_write_fmt_1(int fd, int gently,
+                              const char *fmt, va_list args)
+{
+ struct strbuf buf = STRBUF_INIT;
+ size_t count;
+
+ format_packet(&buf, fmt, args);
+ count = write_in_full(fd, buf.buf, buf.len);
+ if (count == buf.len)
+   return 0;
+
+ if (!gently) {
+   if (errno == EPIPE) {
+     if (in_async())
+       async_exit(141);
+
+     signal(SIGPIPE, SIG_DFL);
+     raise(SIGPIPE);
+     /* Should never happen, but just in case... */
+     exit(141);
+   }
+   die_errno("packet write error");
+ }
+ error("packet write failed");
+ return -1;
+}
+
 void packet_write_fmt(int fd, const char *fmt, ...)
 {
- static struct strbuf buf = STRBUF_INIT;
  va_list args;

- strbuf_reset(&buf);
  va_start(args, fmt);
- format_packet(&buf, fmt, args);
+ packet_write_fmt_1(fd, 0, fmt, args);
  va_end(args);
- write_or_die(fd, buf.buf, buf.len);
 }

 int packet_write_fmt_gently(int fd, const char *fmt, ...)
 {
- static struct strbuf buf = STRBUF_INIT;
+ int status;
  va_list args;

- strbuf_reset(&buf);
  va_start(args, fmt);
- format_packet(&buf, fmt, args);
+ status = packet_write_fmt_1(fd, 1, fmt, args);
  va_end(args);
- return (write_in_full(fd, buf.buf, buf.len) == buf.len ? 0 : -1);
+ return status;
 }

 int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
- if (size > sizeof(packet_write_buffer) - 4)
+ static char packet_write_buffer[LARGE_PACKET_MAX];
+
+ if (size > sizeof(packet_write_buffer) - 4) {
+   error("packet write failed");
    return -1;
+ }
  packet_trace(buf, size, 1);
- memmove(packet_write_buffer + 4, buf, size);
  size += 4;
  set_packet_header(packet_write_buffer, size);
- return (write_in_full(fd_out, packet_write_buffer, size) == size ? 0 : -1);
+ memcpy(packet_write_buffer + 4, buf, size - 4);
+ if (write_in_full(fd_out, packet_write_buffer, size) == size)
+   return 0;
+
+ error("packet write failed");
+ return -1;
 }

 void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
@@ -176,35 +209,35 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)
  va_end(args);
 }

-int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out)
+int write_packetized_from_fd(int fd_in, int fd_out)
 {
+ static char buf[PKTLINE_DATA_MAXLEN];
  int err = 0;
  ssize_t bytes_to_write;

  while (!err) {
-   bytes_to_write = xread(fd_in, packet_write_buffer, sizeof(packet_write_buffer) - 4);
+   bytes_to_write = xread(fd_in, buf, sizeof(buf));
    if (bytes_to_write < 0)
      return COPY_READ_ERROR;
    if (bytes_to_write == 0)
      break;
-   if (bytes_to_write > sizeof(packet_write_buffer) - 4)
-     return COPY_WRITE_ERROR;
-   err = packet_write_gently(fd_out, packet_write_buffer, bytes_to_write);
+   err = packet_write_gently(fd_out, buf, bytes_to_write);
  }
  if (!err)
    err = packet_flush_gently(fd_out);
  return err;
 }

-int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out)
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 {
+ static char buf[PKTLINE_DATA_MAXLEN];
  int err = 0;
  size_t bytes_written = 0;
  size_t bytes_to_write;

  while (!err) {
-   if ((len - bytes_written) > sizeof(packet_write_buffer) - 4)
-     bytes_to_write = sizeof(packet_write_buffer) - 4;
+   if ((len - bytes_written) > sizeof(buf))
+     bytes_to_write = sizeof(buf);
    else
      bytes_to_write = len - bytes_written;
    if (bytes_to_write == 0)
@@ -327,52 +360,29 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
  return packet_read_line_generic(-1, src, src_len, dst_len);
 }

-ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out)
 {
- int len, ret;
+ int paket_len;
  int options = PACKET_READ_GENTLE_ON_EOF;
- char linelen[4];

  size_t oldlen = sb_out->len;
  size_t oldalloc = sb_out->alloc;

  for (;;) {
-   /* Read packet header */
-   ret = get_packet_data(fd_in, NULL, NULL, linelen, 4, options);
-   if (ret < 0)
-     goto done;
-   len = packet_length(linelen);
-   if (len < 0)
-     die("protocol error: bad line length character: %.4s", linelen);
-   if (!len) {
-     /* Found a flush packet - Done! */
-     packet_trace("0000", 4, 0);
+   strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
+   paket_len = packet_read(fd_in, NULL, NULL,
+     sb_out->buf + sb_out->len, PKTLINE_DATA_MAXLEN+1, options);
+   if (paket_len <= 0)
      break;
-   }
-   len -= 4;
-
-   /* Read packet content */
-   strbuf_grow(sb_out, len);
-   ret = get_packet_data(fd_in, NULL, NULL, sb_out->buf + sb_out->len, len, options);
-   if (ret < 0)
-     goto done;
-
-   if (ret != len) {
-     error("protocol error: incomplete read (expected %d, got %d)", len, ret);
-     goto done;
-   }
-
-   packet_trace(sb_out->buf + sb_out->len, len, 0);
-   sb_out->len += len;
+   sb_out->len += paket_len;
  }

-done:
- if (ret < 0) {
+ if (paket_len < 0) {
    if (oldalloc == 0)
      strbuf_release(sb_out);
    else
      strbuf_setlen(sb_out, oldlen);
-   return ret;  /* unexpected EOF */
+   return paket_len;
  }
  return sb_out->len - oldlen;
 }
diff --git a/pkt-line.h b/pkt-line.h
index 6a3b7cf..3d873f3 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -25,8 +25,8 @@ void packet_buf_flush(struct strbuf *buf);
 void packet_buf_write(struct strbuf *buf, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
 int packet_flush_gently(int fd);
 int packet_write_fmt_gently(int fd, const char *fmt, ...) __attribute__((format (printf, 2, 3)));
-int packet_write_stream_with_flush_from_fd(int fd_in, int fd_out);
-int packet_write_stream_with_flush_from_buf(const char *src_in, size_t len, int fd_out);
+int write_packetized_from_fd(int fd_in, int fd_out);
+int write_packetized_from_buf(const char *src_in, size_t len, int fd_out);

 /*
  * Read a packetized line into the buffer, which must be at least size bytes
@@ -82,7 +82,7 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
  */
-ssize_t packet_read_till_flush(int fd_in, struct strbuf *sb_out);
+ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);

 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
diff --git a/read-cache.c b/read-cache.c
index 02f74d3..491e52d 100644
--- a/read-cache.c
+++ b/read-cache.c
@@ -156,7 +156,7 @@ void fill_stat_cache_info(struct cache_entry *ce, struct stat *st)
 static int ce_compare_data(const struct cache_entry *ce, struct stat *st)
 {
  int match = -1;
- int fd = open(ce->name, O_RDONLY | O_CLOEXEC);
+ int fd = open(ce->name, O_RDONLY);

  if (fd >= 0) {
    unsigned char sha1[20];
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 94b0bf3..1c98ac3 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,15 +4,6 @@ test_description='blob conversion via gitattributes'

 . ./test-lib.sh

-if test_have_prereq EXPENSIVE
-then
- T0021_LARGE_FILE_SIZE=2048
- T0021_LARGISH_FILE_SIZE=100
-else
- T0021_LARGE_FILE_SIZE=30
- T0021_LARGISH_FILE_SIZE=2
-fi
-
 cat <<EOF >rot13.sh
 #!$SHELL_PATH
 tr \
@@ -22,8 +13,8 @@ EOF
 chmod +x rot13.sh

 test_expect_success setup '
- test_config filter.rot13.smudge ./rot13.sh &&
- test_config filter.rot13.clean ./rot13.sh &&
+ git config filter.rot13.smudge ./rot13.sh &&
+ git config filter.rot13.clean ./rot13.sh &&

  {
      echo "*.t filter=rot13"
@@ -43,26 +34,7 @@ test_expect_success setup '
  git checkout -- test test.t test.i &&

  echo "content-test2" >test2.o &&
- echo "content-test3-subdir" >test3-subdir.o &&
-
- mkdir generated-test-data &&
- for i in $(test_seq 1 $T0021_LARGE_FILE_SIZE)
- do
-   RANDOM_STRING="$(test-genrandom end $i | tr -dc "A-Za-z0-9" )"
-   ROT_RANDOM_STRING="$(echo $RANDOM_STRING | ./rot13.sh )"
-   # Generate 1MB of empty data and 100 bytes of random characters
-   # printf "$(test-genrandom start $i)"
-   printf "%1048576d" 1 >>generated-test-data/large.file &&
-   printf "$RANDOM_STRING" >>generated-test-data/large.file &&
-   printf "%1048576d" 1 >>generated-test-data/large.file.rot13 &&
-   printf "$ROT_RANDOM_STRING" >>generated-test-data/large.file.rot13 &&
-
-   if test $i = $T0021_LARGISH_FILE_SIZE
-   then
-     cat generated-test-data/large.file >generated-test-data/largish.file &&
-     cat generated-test-data/large.file.rot13 >generated-test-data/largish.file.rot13
-   fi
- done
+ echo "content-test3-subdir" >test3-subdir.o
 '

 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -230,9 +202,9 @@ test_expect_success 'required filter clean failure' '
 test_expect_success 'filtering large input to small output should use little memory' '
  test_config filter.devnull.clean "cat >/dev/null" &&
  test_config filter.devnull.required true &&
- cp generated-test-data/large.file large.file &&
- echo "large.file filter=devnull" >.gitattributes &&
- GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add large.file
+ for i in $(test_seq 1 30); do printf "%1048576d" 1; done >30MB &&
+ echo "30MB filter=devnull" >.gitattributes &&
+ GIT_MMAP_LIMIT=1m GIT_ALLOC_LIMIT=1m git add 30MB
 '

 test_expect_success 'filter that does not read is fine' '
@@ -245,15 +217,15 @@ test_expect_success 'filter that does not read is fine' '
  test_cmp expect actual
 '

-test_expect_success 'filter large file' '
+test_expect_success EXPENSIVE 'filter large file' '
  test_config filter.largefile.smudge cat &&
  test_config filter.largefile.clean cat &&
- echo "large.file filter=largefile" >.gitattributes &&
- cp generated-test-data/large.file large.file &&
- git add large.file 2>err &&
+ for i in $(test_seq 1 2048); do printf "%1048576d" 1; done >2GB &&
+ echo "2GB filter=largefile" >.gitattributes &&
+ git add 2GB 2>err &&
  test_must_be_empty err &&
- rm -f large.file &&
- git checkout -- large.file 2>err &&
+ rm -f 2GB &&
+ git checkout -- 2GB 2>err &&
  test_must_be_empty err
 '

@@ -374,22 +346,24 @@ test_expect_success PERL 'required process filter should filter data' '
    check_filter \
      git add . \
        <<-\EOF &&
-         1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
-         1 IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
-         1 IN: clean test4-empty.r 0 [OK] -- OUT: 0 [OK]
-         1 IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
-         1 start
+         1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+         1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
+         1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+         1 IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         1 START
+         1 STOP
          1 wrote filter header
        EOF

    check_filter_count_clean \
      git commit . -m "test commit" \
        <<-\EOF &&
-         x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
-         x IN: clean test2.r 14 [OK] -- OUT: 14 [OK]
-         x IN: clean test4-empty.r 0 [OK] -- OUT: 0 [OK]
-         x IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
-         1 start
+         x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+         x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
+         x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+         x IN: clean testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         1 START
+         1 STOP
          1 wrote filter header
        EOF

@@ -398,28 +372,31 @@ test_expect_success PERL 'required process filter should filter data' '
    check_filter_ignore_clean \
      git checkout . \
        <<-\EOF &&
-         start
+         START
          wrote filter header
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
-         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         STOP
        EOF

    check_filter_ignore_clean \
      git checkout empty \
        <<-\EOF &&
-         start
+         START
          wrote filter header
+         STOP
        EOF

    check_filter_ignore_clean \
      git checkout master \
        <<-\EOF &&
-         start
+         START
          wrote filter header
-         IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
-         IN: smudge test4-empty.r 0 [OK] -- OUT: 0 [OK]
-         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 [OK]
+         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+         IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
+         IN: smudge testsubdir/test3-subdir.r 21 [OK] -- OUT: 21 . [OK]
+         STOP
        EOF

    check_rot13 ../test.o test.r &&
@@ -428,57 +405,8 @@ test_expect_success PERL 'required process filter should filter data' '
  )
 '

-test_expect_success PERL 'required process filter should filter smudge data and one-shot filter should clean' '
+test_expect_success PERL 'required process filter should clean only and take precedence' '
  test_config_global filter.protocol.clean ./../rot13.sh &&
- test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl smudge" &&
- test_config_global filter.protocol.required true &&
- rm -rf repo &&
- mkdir repo &&
- (
-   cd repo &&
-   git init &&
-
-   echo "*.r filter=protocol" >.gitattributes &&
-   git add . &&
-   git commit . -m "test commit" &&
-   git branch empty &&
-
-   cp ../test.o test.r &&
-   cp ../test2.o test2.r &&
-
-   check_filter_no_call \
-     git add . &&
-
-   check_filter_no_call \
-     git commit . -m "test commit" &&
-
-   rm -f test?.r testsubdir/test3-subdir.r &&
-
-   check_filter_ignore_clean \
-     git checkout . \
-       <<-\EOF &&
-         start
-         wrote filter header
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
-       EOF
-
-   git checkout empty &&
-
-   check_filter_ignore_clean \
-     git checkout master\
-       <<-\EOF &&
-         start
-         wrote filter header
-         IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
-       EOF
-
-   check_rot13 ../test.o test.r &&
-   check_rot13 ../test2.o test2.r
- )
-'
-
-test_expect_success PERL 'required process filter should clean only' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
  test_config_global filter.protocol.required true &&
  rm -rf repo &&
@@ -497,42 +425,74 @@ test_expect_success PERL 'required process filter should clean only' '
    check_filter \
      git add . \
        <<-\EOF &&
-         1 IN: clean test.r 57 [OK] -- OUT: 57 [OK]
-         1 start
+         1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+         1 START
+         1 STOP
          1 wrote filter header
        EOF

    check_filter_count_clean \
      git commit . -m "test commit" \
        <<-\EOF
-         x IN: clean test.r 57 [OK] -- OUT: 57 [OK]
-         1 start
+         x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
+         1 START
+         1 STOP
          1 wrote filter header
        EOF
  )
 '

-test_expect_success PERL 'required process filter should process binary files larger LARGE_PACKET_MAX' '
+generate_test_data () {
+ LEN=$1
+ NAME=$2
+ test-genrandom end $LEN |
+   perl -pe "s/./chr((ord($&) % 26) + 97)/sge" >../$NAME.file &&
+ cp ../$NAME.file . &&
+ ./../rot13.sh <../$NAME.file >../$NAME.file.rot13
+}
+
+test_expect_success PERL 'required process filter should process multiple packets' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
  test_config_global filter.protocol.required true &&
+
  rm -rf repo &&
  mkdir repo &&
  (
    cd repo &&
    git init &&

-   echo "*.file filter=protocol" >.gitattributes &&
-   cat ../generated-test-data/largish.file.rot13 >large.rot13 &&
-   cat ../generated-test-data/largish.file >large.file &&
-   cat large.file >large.original &&
+   # Generate data that requires 3 packets
+   PKTLINE_DATA_MAXLEN=65516 &&
+
+   generate_test_data $(($PKTLINE_DATA_MAXLEN        )) 1pkt_1__ &&
+   generate_test_data $(($PKTLINE_DATA_MAXLEN     + 1)) 2pkt_1+1 &&
+   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 - 1)) 2pkt_2-1 &&
+   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2    )) 2pkt_2__ &&
+   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 + 1)) 3pkt_2+1 &&

-   git add large.file .gitattributes &&
+   echo "*.file filter=protocol" >.gitattributes &&
+   check_filter \
+     git add *.file .gitattributes \
+       <<-\EOF &&
+         1 IN: clean 1pkt_1__.file 65516 [OK] -- OUT: 65516 . [OK]
+         1 IN: clean 2pkt_1+1.file 65517 [OK] -- OUT: 65517 .. [OK]
+         1 IN: clean 2pkt_2-1.file 131031 [OK] -- OUT: 131031 .. [OK]
+         1 IN: clean 2pkt_2__.file 131032 [OK] -- OUT: 131032 .. [OK]
+         1 IN: clean 3pkt_2+1.file 131033 [OK] -- OUT: 131033 ... [OK]
+         1 START
+         1 STOP
+         1 wrote filter header
+       EOF
    git commit . -m "test commit" &&

-   rm -f large.file &&
-   git checkout -- large.file &&
-   git cat-file blob :large.file >actual &&
-   test_cmp large.rot13 actual
+   rm -f *.file &&
+   git checkout -- *.file &&
+
+   for f in *.file
+   do
+     git cat-file blob :$f >actual &&
+     test_cmp ../$f.rot13 actual
+   done
  )
 '

@@ -577,13 +537,14 @@ test_expect_success PERL 'process filter should restart after unexpected write f
    check_filter_ignore_clean \
      git checkout . \
        <<-\EOF &&
-         start
+         START
          wrote filter header
          IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
-         start
+         START
          wrote filter header
-         IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+         STOP
        EOF

    check_rot13 ../test.o test.r &&
@@ -617,11 +578,12 @@ test_expect_success PERL 'process filter should not restart in case of an error'
    check_filter_ignore_clean \
      git checkout . \
        <<-\EOF &&
-         start
+         START
          wrote filter header
          IN: smudge error.r 25 [OK] -- OUT: 0 [ERROR]
-         IN: smudge test.r 57 [OK] -- OUT: 57 [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 [OK]
+         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
+         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+         STOP
        EOF

    check_rot13 ../test.o test.r &&
@@ -642,8 +604,8 @@ test_expect_success PERL 'process filter should be able to signal an error for a

    cp ../test.o test.r &&
    cp ../test2.o test2.r &&
-   echo "error this blob and all future blobs" >error-all.o &&
-   cp error-all.o error-all.r &&
+   echo "error this blob and all future blobs" >abort.o &&
+   cp abort.o abort.r &&
    git add . &&
    git commit . -m "test commit" &&
    rm -f *.r &&
@@ -651,14 +613,15 @@ test_expect_success PERL 'process filter should be able to signal an error for a
    check_filter_ignore_clean \
      git checkout . \
        <<-\EOF &&
-         start
+         START
          wrote filter header
-         IN: smudge error-all.r 37 [OK] -- OUT: 0 [ERROR-ALL]
+         IN: smudge abort.r 37 [OK] -- OUT: 0 [ABORT]
+         STOP
        EOF

    test_cmp ../test.o test.r &&
    test_cmp ../test2.o test2.r &&
-   test_cmp error-all.o error-all.r
+   test_cmp abort.o abort.r
  )
 '

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 0e1181d..8e27877 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -14,7 +14,7 @@
 # (3) If data with the pathname "error.r" is processed with any
 #     operation then the filter signals that it cannot or does not want
 #     to process the file.
-# (4) If data with the pathname "error-all.r" is processed with any
+# (4) If data with the pathname "abort.r" is processed with any
 #     operation then the filter signals that it cannot or does not want
 #     to process the file and any file after that is processed with the
 #     same command.
@@ -26,6 +26,8 @@ use warnings;
 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my @capabilities            = @ARGV;

+open my $debug, ">>", "rot13-filter.log";
+
 sub rot13 {
     my ($str) = @_;
     $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
@@ -38,6 +40,7 @@ sub packet_read {
     if ( $bytes_read == 0 ) {

         # EOF - Git stopped talking to us!
+        print $debug "STOP\n";
         exit();
     }
     elsif ( $bytes_read != 4 ) {
@@ -72,8 +75,7 @@ sub packet_flush {
     STDOUT->flush();
 }

-open my $debug, ">>", "rot13-filter.log";
-print $debug "start\n";
+print $debug "START\n";
 $debug->flush();

 ( packet_read() eq ( 0, "git-filter-client" ) ) || die "bad initialization";
@@ -120,7 +122,7 @@ while (1) {
     }

     my $output;
-    if ( $pathname eq "error.r" or $pathname eq "error-all.r" ) {
+    if ( $pathname eq "error.r" or $pathname eq "abort.r" ) {
         $output = "";
     }
     elsif ( $command eq "clean" and grep( /^clean$/, @capabilities ) ) {
@@ -142,10 +144,10 @@ while (1) {
         packet_write("status=error\n");
         packet_flush();
     }
-    elsif ( $pathname eq "error-all.r" ) {
-        print $debug "[ERROR-ALL]\n";
+    elsif ( $pathname eq "abort.r" ) {
+        print $debug "[ABORT]\n";
         $debug->flush();
-        packet_write("status=error-all\n");
+        packet_write("status=abort\n");
         packet_flush();
     }
     else {
@@ -161,6 +163,7 @@ while (1) {
         while ( length($output) > 0 ) {
             my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
             packet_write($packet);
+            print $debug ".";
             if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
                 $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );
             }
@@ -169,7 +172,7 @@ while (1) {
             }
         }
         packet_flush();
-        print $debug "[OK]\n";
+        print $debug " [OK]\n";
         $debug->flush();
         packet_flush();
     }




Lars Schneider (10):
  pkt-line: rename packet_write() to packet_write_fmt()
  pkt-line: extract set_packet_header()
  pkt-line: add packet_write_fmt_gently()
  pkt-line: add packet_flush_gently()
  pkt-line: add packet_write_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  convert: quote filter names in error messages
  convert: modernize tests
  convert: make apply_filter() adhere to standard Git error handling
  convert: add filter.<driver>.process option

 Documentation/gitattributes.txt        | 154 +++++++++++-
 builtin/archive.c                      |   4 +-
 builtin/receive-pack.c                 |   4 +-
 builtin/remote-ext.c                   |   4 +-
 builtin/upload-archive.c               |   4 +-
 connect.c                              |   2 +-
 contrib/long-running-filter/example.pl | 111 +++++++++
 convert.c                              | 373 +++++++++++++++++++++++++----
 daemon.c                               |   2 +-
 http-backend.c                         |   2 +-
 pkt-line.c                             | 160 ++++++++++++-
 pkt-line.h                             |  12 +-
 shallow.c                              |   2 +-
 t/t0021-conversion.sh                  | 423 ++++++++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                | 179 ++++++++++++++
 unpack-trees.c                         |   1 +
 upload-pack.c                          |  30 +--
 17 files changed, 1356 insertions(+), 111 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl

--
2.10.0

