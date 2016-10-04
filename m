Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-5.0 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RCVD_IN_SORBS_SPAM,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2764F20987
	for <e@80x24.org>; Tue,  4 Oct 2016 13:00:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1754000AbcJDM74 (ORCPT <rfc822;e@80x24.org>);
        Tue, 4 Oct 2016 08:59:56 -0400
Received: from mail-wm0-f65.google.com ([74.125.82.65]:35589 "EHLO
        mail-wm0-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753861AbcJDM7x (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 4 Oct 2016 08:59:53 -0400
Received: by mail-wm0-f65.google.com with SMTP id f193so14972292wmg.2
        for <git@vger.kernel.org>; Tue, 04 Oct 2016 05:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=zL0ZcdJZ85HMUU5rPqkb0tD/R/Lm43c/BMGda6wqACE=;
        b=WM5pXnPQuRwjZHFPbA37+ESRLT+J2r8C0GO9qz1a5WUA9Wodpo+gQp0MMPfzR8TG6c
         EZMzvH5z2d9wCZTcoTGV0+Yh1cPN9jK3ZGoNkhkrFjPvbi4SIj20FqvMgpKQhKfY8Nyj
         NIExqcy4Bhg38C6lXBENvm/sDWuHcxuc9xNslC0ugndndnuKCRE75KiEr23WYP1PAngn
         onDXdtB9E7aWYDnbYlukp4Ej9IjOESZ3jGDLldzu4x2QL2Pju3FVxY6rxGvvzE0vB7yr
         cuTF7xfFifW034VQXHig9WH1ehPBlY0xmOcNA3RL+UVakejcnL+fcRT6cmNqrL1M0ltB
         cuvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=zL0ZcdJZ85HMUU5rPqkb0tD/R/Lm43c/BMGda6wqACE=;
        b=CdlycYCRk3BcgE5ILKZZnz9ahVa1LW3BiNJr5m+e+H0wxiDVUWg+NuY7QC6SRezPFI
         w3AsSgC9+CTB0txnFJCZd6h/m9q7fZ9G+YCK9nha2TsaMb4cJztr2YKUBbrV38C+rBtl
         uQXafs7qHCSNS8zA9abWVVna7LWVRTMTfh4bjnWzIO6HNVXaMJA3ViJc+T0FpL5hzmlt
         xyYDVMKTBY44RF1fwqyBGrrUaKbA4dOF08DrIqYb5+WsIAQBLQOSkDW6W0TbhI/z2Pod
         FQxCrCKasp3ombFzNYeatkx5q/i60cndvMVQ9aq325Q49jPUddnqs2AkTfGTZDwJIH4r
         a28g==
X-Gm-Message-State: AA6/9RmguY0QN/zqtfV8aa8ADBUONZE6AxRzBIg4+KM++kmEV/eahDDU1K5HtMsnqAHasA==
X-Received: by 10.28.111.201 with SMTP id c70mr3596282wmi.126.1475585991651;
        Tue, 04 Oct 2016 05:59:51 -0700 (PDT)
Received: from slxbook4.ads.autodesk.com ([62.159.156.210])
        by smtp.gmail.com with ESMTPSA id qo8sm3426934wjc.46.2016.10.04.05.59.48
        (version=TLS1 cipher=AES128-SHA bits=128/128);
        Tue, 04 Oct 2016 05:59:50 -0700 (PDT)
From:   larsxschneider@gmail.com
To:     git@vger.kernel.org
Cc:     ramsay@ramsayjones.plus.com, jnareb@gmail.com, gitster@pobox.com,
        j6t@kdbg.org, tboegi@web.de, peff@peff.net, mlbright@gmail.com,
        Lars Schneider <larsxschneider@gmail.com>
Subject: [PATCH v9 00/14] Git filter protocol
Date:   Tue,  4 Oct 2016 14:59:33 +0200
Message-Id: <20161004125947.67104-1-larsxschneider@gmail.com>
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
https://github.com/larsxschneider/git/pull/13

Patches 1 and 2 are cleanups and not strictly necessary for the series.
Patches 3 to 12 are required preparation. Patch 13 is the main patch.
Patch 14 adds an example how to use the Git filter protocol in contrib.

Thanks a lot to
  Ramsay, Jakub, Junio, Johannes, Torsten, and Peff
for very helpful reviews,
Lars



## Major changes since v8

  * refactor test cases to make them more robust and more readable
  * split main "convert: add filter" patch into three:
      1. preparation patch
      2. main patch
      3. contrib patch
  * add run-command "wait_on_exit" flag to fix flaky t0021, see discussion:
      http://public-inbox.org/git/xmqq8tubitjs.fsf@gitster.mtv.corp.google.com/



## All changes since v8

### Ramsay
  * make async_exit()
      http://public-inbox.org/git/78f2bdd0-f6ad-db5c-f9f2-f90528bc4f77@ramsayjones.plus.com/

### Jacub
  * improve commit message for:
      pkt-line: rename packet_write() to packet_write_fmt
      pkt-line: extract set_packet_header()
  * remove unnecessary brackets in packet_write_gently
  * introduce variable 'packet_size' to make packet_write_gently()
    more readable
  * replace 'PKTLINE_DATA_MAXLEN' with 'LARGE_PACKET_DATA_MAX'
  * rename 'read_packetized_to_buf' to 'read_packetized_to_strbuf'
  * use 'ssize_t' as proper return value for write_in_full()
  * rename 'paket_len' to 'packet_len'
  * remove unnecessary options variable in read_packetized_to_strbuf()
  * rename variables in read_packetized_to_strbuf()
  * fix +1 in read_packetized_to_strbuf()
  * fix length comparison in packet_read()
  * replace spaces with tabs in Perl scripts
  * ... many smaller changes. See interdiff below.



## Interdiff (v8..v9)

```diff
diff --git a/Documentation/gitattributes.txt b/Documentation/gitattributes.txt
index 946dcad..a182ef2 100644
--- a/Documentation/gitattributes.txt
+++ b/Documentation/gitattributes.txt
@@ -387,9 +387,9 @@ If the filter command (a string value) is defined via
 single filter invocation for the entire life of a single Git
 command. This is achieved by using a packet format (pkt-line,
 see technical/protocol-common.txt) based protocol over standard
-input and standard output as follows. All packets are considered
-text and therefore are terminated by an LF. Exceptions are the
-"*CONTENT" packets and the flush packet.
+input and standard output as follows. All packets, except for the
+"*CONTENT" packets and the "0000" flush packet, are considered
+text and therefore are terminated by a LF.

 Git starts the filter when it encounters the first file
 that needs to be cleaned or smudged. After the filter started
@@ -403,10 +403,10 @@ protocol description below documents "version=2". Please note that
 to illustrate how the protocol would look like with more than one
 version.

-After the version negotiation Git sends a list of supported capabilities
-and a flush packet. Git expects to read a list of desired capabilities,
-which must be a subset of the supported capabilities list, and a flush
-packet as response:
+After the version negotiation Git sends a list of all capabilities that
+it supports and a flush packet. Git expects to read a list of desired
+capabilities, which must be a subset of the supported capabilities list,
+and a flush packet as response:
 ------------------------
 packet:          git> git-filter-client
 packet:          git> version=2
@@ -430,7 +430,9 @@ a flush packet. The list will contain at least the filter command
 (based on the supported capabilities) and the pathname of the file
 to filter relative to the repository root. Right after these packets
 Git sends the content split in zero or more pkt-line packets and a
-flush packet to terminate content.
+flush packet to terminate content. Please note, that the filter
+must not send any response before it received the content and the
+final flush packet.
 ------------------------
 packet:          git> command=smudge
 packet:          git> pathname=path/testfile.dat
@@ -451,16 +453,16 @@ packet:          git< status=success
 packet:          git< 0000
 packet:          git< SMUDGED_CONTENT
 packet:          git< 0000
-packet:          git< 0000  # empty list!
+packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

 If the result content is empty then the filter is expected to respond
-with a success status and an empty list.
+with a "success" status and an empty list.
 ------------------------
 packet:          git< status=success
 packet:          git< 0000
 packet:          git< 0000  # empty content!
-packet:          git< 0000  # empty list!
+packet:          git< 0000  # empty list, keep "status=success" unchanged!
 ------------------------

 In case the filter cannot or does not want to process the content,
@@ -497,10 +499,11 @@ handling.

 In case the filter cannot or does not want to process the content
 as well as any future content for the lifetime of the Git process,
-it is expected to respond with an "abort" status. Depending on
-the `filter.<driver>.required` flag Git will interpret that as error
-for the content as well as any future content for the lifetime of the
-Git process but it will not stop or restart the filter process.
+it is expected to respond with an "abort" status at any point in
+the protocol. Depending on the `filter.<driver>.required` flag Git
+will interpret that as error for the content as well as any future
+content for the lifetime of the Git process but it will not stop or
+restart the filter process.
 ------------------------
 packet:          git< status=abort
 packet:          git< 0000
diff --git a/contrib/long-running-filter/example.pl b/contrib/long-running-filter/example.pl
index c13a631..f4102d2 100755
--- a/contrib/long-running-filter/example.pl
+++ b/contrib/long-running-filter/example.pl
@@ -3,6 +3,9 @@
 # Example implementation for the Git filter protocol version 2
 # See Documentation/gitattributes.txt, section "Filter Protocol"
 #
+# Please note, this pass-thru filter is a minimal skeleton. No proper
+# error handling was implemented.
+#

 use strict;
 use warnings;
@@ -18,7 +21,7 @@ sub packet_bin_read {
    exit();
  }
  elsif ( $bytes_read != 4 ) {
-        die "invalid packet size '$bytes_read' field";
+   die "invalid packet: '$buffer'";
  }
  my $pkt_size = hex($buffer);
  if ( $pkt_size == 0 ) {
@@ -28,27 +31,27 @@ sub packet_bin_read {
    my $content_size = $pkt_size - 4;
    $bytes_read = read STDIN, $buffer, $content_size;
    if ( $bytes_read != $content_size ) {
-            die "invalid packet ($content_size expected; $bytes_read read)";
+     die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
    }
    return ( 0, $buffer );
  }
  else {
-        die "invalid packet size";
+   die "invalid packet size: $pkt_size";
  }
 }

 sub packet_txt_read {
  my ( $res, $buf ) = packet_bin_read();
-    unless ( $buf =~ /\n$/ ) {
-        die "A non-binary line SHOULD BE terminated by an LF.";
+ unless ( $buf =~ s/\n$// ) {
+   die "A non-binary line MUST be terminated by an LF.";
  }
-    return ( $res, substr( $buf, 0, -1 ) );
+ return ( $res, $buf );
 }

 sub packet_bin_write {
-    my ($packet) = @_;
-    print STDOUT sprintf( "%04x", length($packet) + 4 );
-    print STDOUT $packet;
+ my $buf = shift;
+ print STDOUT sprintf( "%04x", length($buf) + 4 );
+ print STDOUT $buf;
  STDOUT->flush();
 }

@@ -119,5 +122,6 @@ while (1) {
    }
  }
  packet_flush();    # flush content!
-    packet_flush();    # empty list!
+ packet_flush();    # empty list, keep "status=success" unchanged!
+
 }
diff --git a/convert.c b/convert.c
index bd66257..88581d6 100644
--- a/convert.c
+++ b/convert.c
@@ -541,7 +541,7 @@ static int packet_write_list(int fd, const char *line, ...)
  for (;;) {
    if (!line)
      break;
-   if (strlen(line) > PKTLINE_DATA_MAXLEN)
+   if (strlen(line) > LARGE_PACKET_DATA_MAX)
      return -1;
    err = packet_write_fmt_gently(fd, "%s\n", line);
    if (err)
@@ -573,6 +573,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
  process->use_shell = 1;
  process->in = -1;
  process->out = -1;
+ process->wait_on_exit = 1;

  if (start_command(process)) {
    error("cannot fork to run external filter '%s'", cmd);
@@ -588,7 +589,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons

  err = strcmp(packet_read_line(process->out, NULL), "git-filter-server");
  if (err) {
-   error("external filter '%s' does not support long running filter protocol", cmd);
+   error("external filter '%s' does not support filter protocol version 2", cmd);
    goto done;
  }
  err = strcmp(packet_read_line(process->out, NULL), "version=2");
@@ -634,7 +635,7 @@ static struct cmd2process *start_multi_file_filter(struct hashmap *hashmap, cons
  return entry;
 }

-static void read_multi_file_filter_values(int fd, struct strbuf *status) {
+static void read_multi_file_filter_status(int fd, struct strbuf *status) {
  struct strbuf **pair;
  char *line;
  for (;;) {
@@ -648,6 +649,7 @@ static void read_multi_file_filter_values(int fd, struct strbuf *status) {
        strbuf_addbuf(status, pair[1]);
      }
    }
+   strbuf_list_free(pair);
  }
 }

@@ -698,17 +700,16 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len

  sigchain_push(SIGPIPE, SIG_IGN);

- err = strlen(filter_type) > PKTLINE_DATA_MAXLEN;
- if (err)
-   goto done;
-
+ assert(strlen(filter_type) < LARGE_PACKET_DATA_MAX - strlen("command=\n"));
  err = packet_write_fmt_gently(process->in, "command=%s\n", filter_type);
  if (err)
    goto done;

- err = strlen(path) > PKTLINE_DATA_MAXLEN;
- if (err)
+ err = strlen(path) > LARGE_PACKET_DATA_MAX - strlen("pathname=\n");
+ if (err) {
+   error("path name too long for external filter");
    goto done;
+ }

  err = packet_write_fmt_gently(process->in, "pathname=%s\n", path);
  if (err)
@@ -725,16 +726,16 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
  if (err)
    goto done;

- read_multi_file_filter_values(process->out, &filter_status);
+ read_multi_file_filter_status(process->out, &filter_status);
  err = strcmp(filter_status.buf, "success");
  if (err)
    goto done;

- err = read_packetized_to_buf(process->out, &nbuf) < 0;
+ err = read_packetized_to_strbuf(process->out, &nbuf) < 0;
  if (err)
    goto done;

- read_multi_file_filter_values(process->out, &filter_status);
+ read_multi_file_filter_status(process->out, &filter_status);
  err = strcmp(filter_status.buf, "success");

 done:
@@ -753,7 +754,7 @@ static int apply_multi_file_filter(const char *path, const char *src, size_t len
    } else {
      /*
       * Something went wrong with the protocol filter.
-      * Force shutdown and restart if another blob requires filtering!
+      * Force shutdown and restart if another blob requires filtering.
       */
      error("external filter '%s' failed", cmd);
      kill_multi_file_filter(&cmd_process_map, entry);
@@ -786,9 +787,9 @@ static int apply_filter(const char *path, const char *src, size_t len,
  if (!dst)
    return 1;

- if (!drv->process && (CAP_CLEAN & wanted_capability) && drv->clean)
+ if ((CAP_CLEAN & wanted_capability) && !drv->process && drv->clean)
    cmd = drv->clean;
- else if (!drv->process && (CAP_SMUDGE & wanted_capability) && drv->smudge)
+ else if ((CAP_SMUDGE & wanted_capability) && !drv->process && drv->smudge)
    cmd = drv->smudge;

  if (cmd && *cmd)
diff --git a/pkt-line.c b/pkt-line.c
index a0a8543..b82aaca 100644
--- a/pkt-line.c
+++ b/pkt-line.c
@@ -137,7 +137,7 @@ static int packet_write_fmt_1(int fd, int gently,
            const char *fmt, va_list args)
 {
  struct strbuf buf = STRBUF_INIT;
- size_t count;
+ ssize_t count;

  format_packet(&buf, fmt, args);
  count = write_in_full(fd, buf.buf, buf.len);
@@ -174,15 +174,15 @@ int packet_write_fmt_gently(int fd, const char *fmt, ...)
 static int packet_write_gently(const int fd_out, const char *buf, size_t size)
 {
  static char packet_write_buffer[LARGE_PACKET_MAX];
+ const size_t packet_size = size + 4;

- if (size > sizeof(packet_write_buffer) - 4) {
+ if (packet_size > sizeof(packet_write_buffer))
    return error("packet write failed - data exceeds max packet size");
- }
+
  packet_trace(buf, size, 1);
- size += 4;
- set_packet_header(packet_write_buffer, size);
- memcpy(packet_write_buffer + 4, buf, size - 4);
- if (write_in_full(fd_out, packet_write_buffer, size) == size)
+ set_packet_header(packet_write_buffer, packet_size);
+ memcpy(packet_write_buffer + 4, buf, size);
+ if (write_in_full(fd_out, packet_write_buffer, packet_size) == packet_size)
    return 0;
  return error("packet write failed");
 }
@@ -198,7 +198,7 @@ void packet_buf_write(struct strbuf *buf, const char *fmt, ...)

 int write_packetized_from_fd(int fd_in, int fd_out)
 {
- static char buf[PKTLINE_DATA_MAXLEN];
+ static char buf[LARGE_PACKET_DATA_MAX];
  int err = 0;
  ssize_t bytes_to_write;

@@ -217,7 +217,7 @@ int write_packetized_from_fd(int fd_in, int fd_out)

 int write_packetized_from_buf(const char *src_in, size_t len, int fd_out)
 {
- static char buf[PKTLINE_DATA_MAXLEN];
+ static char buf[LARGE_PACKET_DATA_MAX];
  int err = 0;
  size_t bytes_written = 0;
  size_t bytes_to_write;
@@ -347,29 +347,34 @@ char *packet_read_line_buf(char **src, size_t *src_len, int *dst_len)
  return packet_read_line_generic(-1, src, src_len, dst_len);
 }

-ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out)
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out)
 {
- int paket_len;
- int options = PACKET_READ_GENTLE_ON_EOF;
+ int packet_len;

- size_t oldlen = sb_out->len;
- size_t oldalloc = sb_out->alloc;
+ size_t orig_len = sb_out->len;
+ size_t orig_alloc = sb_out->alloc;

  for (;;) {
-   strbuf_grow(sb_out, PKTLINE_DATA_MAXLEN+1);
-   paket_len = packet_read(fd_in, NULL, NULL,
-     sb_out->buf + sb_out->len, PKTLINE_DATA_MAXLEN+1, options);
-   if (paket_len <= 0)
+   strbuf_grow(sb_out, LARGE_PACKET_DATA_MAX);
+   packet_len = packet_read(fd_in, NULL, NULL,
+     /* strbuf_grow() above always allocates one extra byte to
+      * store a '\0' at the end of the string. packet_read()
+      * writes a '\0' extra byte at the end, too. Let it know
+      * that there is already room for the extra byte.
+      */
+     sb_out->buf + sb_out->len, LARGE_PACKET_DATA_MAX+1,
+     PACKET_READ_GENTLE_ON_EOF);
+   if (packet_len <= 0)
      break;
-   sb_out->len += paket_len;
+   sb_out->len += packet_len;
  }

- if (paket_len < 0) {
-   if (oldalloc == 0)
+ if (packet_len < 0) {
+   if (orig_alloc == 0)
      strbuf_release(sb_out);
    else
-     strbuf_setlen(sb_out, oldlen);
-   return paket_len;
+     strbuf_setlen(sb_out, orig_len);
+   return packet_len;
  }
- return sb_out->len - oldlen;
+ return sb_out->len - orig_len;
 }
diff --git a/pkt-line.h b/pkt-line.h
index 3d873f3..18eac64 100644
--- a/pkt-line.h
+++ b/pkt-line.h
@@ -82,11 +82,11 @@ char *packet_read_line_buf(char **src_buf, size_t *src_len, int *size);
 /*
  * Reads a stream of variable sized packets until a flush packet is detected.
  */
-ssize_t read_packetized_to_buf(int fd_in, struct strbuf *sb_out);
+ssize_t read_packetized_to_strbuf(int fd_in, struct strbuf *sb_out);

 #define DEFAULT_PACKET_MAX 1000
 #define LARGE_PACKET_MAX 65520
-#define PKTLINE_DATA_MAXLEN (LARGE_PACKET_MAX - 4)
+#define LARGE_PACKET_DATA_MAX (LARGE_PACKET_MAX - 4)
 extern char packet_buffer[LARGE_PACKET_MAX];

 #endif
diff --git a/run-command.c b/run-command.c
index b72f6d1..96c54fe 100644
--- a/run-command.c
+++ b/run-command.c
@@ -6,19 +6,6 @@
 #include "thread-utils.h"
 #include "strbuf.h"

-void check_pipe(int err)
-{
- if (err == EPIPE) {
-   if (in_async())
-     async_exit(141);
-
-   signal(SIGPIPE, SIG_DFL);
-   raise(SIGPIPE);
-   /* Should never happen, but just in case... */
-   exit(141);
- }
-}
-
 void child_process_init(struct child_process *child)
 {
  memset(child, 0, sizeof(*child));
@@ -34,6 +21,9 @@ void child_process_clear(struct child_process *child)

 struct child_to_clean {
  pid_t pid;
+ char *name;
+ int stdin;
+ int wait;
  struct child_to_clean *next;
 };
 static struct child_to_clean *children_to_clean;
@@ -41,14 +31,35 @@ static int installed_child_cleanup_handler;

 static void cleanup_children(int sig, int in_signal)
 {
- while (children_to_clean) {
+ int status;
  struct child_to_clean *p = children_to_clean;
+
+ /* Close the the child's stdin as indicator that Git will exit soon */
+ while (p) {
+   if (p->wait)
+     if (p->stdin > 0)
+       close(p->stdin);
+   p = p->next;
+ }
+
+ while (children_to_clean) {
+   p = children_to_clean;
    children_to_clean = p->next;
+
+   if (p->wait) {
+     fprintf(stderr, _("Waiting for '%s' to finish..."), p->name);
+     while ((waitpid(p->pid, &status, 0)) < 0 && errno == EINTR)
+       ; /* nothing */
+     fprintf(stderr, _("done!\n"));
+   }
+
    kill(p->pid, sig);
-   if (!in_signal)
+   if (!in_signal) {
+     free(p->name);
      free(p);
    }
  }
+}

 static void cleanup_children_on_signal(int sig)
 {
@@ -62,10 +73,16 @@ static void cleanup_children_on_exit(void)
  cleanup_children(SIGTERM, 0);
 }

-static void mark_child_for_cleanup(pid_t pid)
+static void mark_child_for_cleanup(pid_t pid, const char *name, int stdin, int wait)
 {
  struct child_to_clean *p = xmalloc(sizeof(*p));
  p->pid = pid;
+ p->wait = wait;
+ p->stdin = stdin;
+ if (name)
+   p->name = xstrdup(name);
+ else
+   p->name = "process";
  p->next = children_to_clean;
  children_to_clean = p;

@@ -76,6 +93,13 @@ static void mark_child_for_cleanup(pid_t pid)
  }
 }

+#ifdef NO_PTHREADS
+static void mark_child_for_cleanup_no_wait(pid_t pid, const char *name, int timeout, int stdin)
+{
+ mark_child_for_cleanup(pid, NULL, 0, 0);
+}
+#endif
+
 static void clear_child_for_cleanup(pid_t pid)
 {
  struct child_to_clean **pp;
@@ -434,8 +458,9 @@ int start_command(struct child_process *cmd)
  }
  if (cmd->pid < 0)
    error_errno("cannot fork() for %s", cmd->argv[0]);
- else if (cmd->clean_on_exit)
-   mark_child_for_cleanup(cmd->pid);
+ else if (cmd->clean_on_exit || cmd->wait_on_exit)
+   mark_child_for_cleanup(
+     cmd->pid, cmd->argv[0], cmd->in, cmd->wait_on_exit);

  /*
   * Wait for child's execvp. If the execvp succeeds (or if fork()
@@ -495,8 +520,9 @@ int start_command(struct child_process *cmd)
  failed_errno = errno;
  if (cmd->pid < 0 && (!cmd->silent_exec_failure || errno != ENOENT))
    error_errno("cannot spawn %s", cmd->argv[0]);
- if (cmd->clean_on_exit && cmd->pid >= 0)
-   mark_child_for_cleanup(cmd->pid);
+ if ((cmd->clean_on_exit || cmd->wait_on_exit) && cmd->pid >= 0)
+   mark_child_for_cleanup(
+     cmd->pid, cmd->argv[0], cmd->in, cmd->clean_on_exit_timeout);

  argv_array_clear(&nargv);
  cmd->argv = sargv;
@@ -647,7 +673,7 @@ int in_async(void)
  return !pthread_equal(main_thread, pthread_self());
 }

-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
  pthread_exit((void *)(intptr_t)code);
 }
@@ -697,13 +723,26 @@ int in_async(void)
  return process_is_async;
 }

-void NORETURN async_exit(int code)
+static void NORETURN async_exit(int code)
 {
  exit(code);
 }

 #endif

+void check_pipe(int err)
+{
+ if (err == EPIPE) {
+   if (in_async())
+     async_exit(141);
+
+   signal(SIGPIPE, SIG_DFL);
+   raise(SIGPIPE);
+   /* Should never happen, but just in case... */
+   exit(141);
+ }
+}
+
 int start_async(struct async *async)
 {
  int need_in, need_out;
@@ -765,7 +804,7 @@ int start_async(struct async *async)
    exit(!!async->proc(proc_in, proc_out, async->data));
  }

- mark_child_for_cleanup(async->pid);
+ mark_child_for_cleanup_no_wait(async->pid);

  if (need_in)
    close(fdin[0]);
diff --git a/run-command.h b/run-command.h
index e7c5f71..f7b9907 100644
--- a/run-command.h
+++ b/run-command.h
@@ -42,7 +42,10 @@ struct child_process {
  unsigned silent_exec_failure:1;
  unsigned stdout_to_stderr:1;
  unsigned use_shell:1;
+  /* kill the child on Git exit */
  unsigned clean_on_exit:1;
+ /* close the child's stdin on Git exit and wait until it terminates */
+ unsigned wait_on_exit:1;
 };

 #define CHILD_PROCESS_INIT { NULL, ARGV_ARRAY_INIT, ARGV_ARRAY_INIT }
@@ -54,8 +57,6 @@ int finish_command(struct child_process *);
 int finish_command_in_signal(struct child_process *);
 int run_command(struct child_process *);

-void check_pipe(int err);
-
 /*
  * Returns the path to the hook file, or NULL if the hook is missing
  * or disabled. Note that this points to static storage that will be
@@ -141,7 +142,7 @@ struct async {
 int start_async(struct async *async);
 int finish_async(struct async *async);
 int in_async(void);
-void NORETURN async_exit(int code);
+void check_pipe(int err);

 /**
  * This callback should initialize the child process and preload the
diff --git a/t/t0021-conversion.sh b/t/t0021-conversion.sh
index 210c4f6..52b7fe9 100755
--- a/t/t0021-conversion.sh
+++ b/t/t0021-conversion.sh
@@ -4,13 +4,77 @@ test_description='blob conversion via gitattributes'

 . ./test-lib.sh

-cat <<EOF >rot13.sh
+TEST_ROOT="$(pwd)"
+
+cat <<EOF >"$TEST_ROOT/rot13.sh"
 #!$SHELL_PATH
 tr \
   'abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ' \
   'nopqrstuvwxyzabcdefghijklmNOPQRSTUVWXYZABCDEFGHIJKLM'
 EOF
-chmod +x rot13.sh
+chmod +x "$TEST_ROOT/rot13.sh"
+
+generate_random_characters () {
+ LEN=$1
+ NAME=$2
+ test-genrandom some-seed $LEN |
+   perl -pe "s/./chr((ord($&) % 26) + ord('a'))/sge" >"$TEST_ROOT/$NAME"
+}
+
+file_size () {
+ cat "$1" | wc -c | sed "s/^[ ]*//"
+}
+
+filter_git () {
+ rm -f rot13-filter.log &&
+ git "$@" 2>git-stderr.log &&
+ sed '/Waiting for/d' git-stderr.log >git-stderr-clean.log &&
+ test_must_be_empty git-stderr-clean.log &&
+ rm -f git-stderr.log git-stderr-clean.log
+}
+
+# Count unique lines in two files and compare them.
+test_cmp_count () {
+ for FILE in $@
+ do
+   sort $FILE | uniq -c | sed "s/^[ ]*//" >$FILE.tmp
+   cat $FILE.tmp >$FILE
+ done &&
+ test_cmp $@
+}
+
+# Count unique lines except clean invocations in two files and compare
+# them. Clean invocations are not counted because their number can vary.
+# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+test_cmp_count_except_clean () {
+ for FILE in $@
+ do
+   sort $FILE | uniq -c | sed "s/^[ ]*//" |
+     sed "s/^\([0-9]\) IN: clean/x IN: clean/" >$FILE.tmp
+   cat $FILE.tmp >$FILE
+ done &&
+ test_cmp $@
+}
+
+# Compare two files but exclude clean invocations because they can vary.
+# c.f. http://public-inbox.org/git/xmqqshv18i8i.fsf@gitster.mtv.corp.google.com/
+test_cmp_exclude_clean () {
+ for FILE in $@
+ do
+   grep -v "IN: clean" $FILE >$FILE.tmp
+   cat $FILE.tmp >$FILE
+ done &&
+ test_cmp $@
+}
+
+# Check that the contents of two files are equal and that their rot13 version
+# is equal to the committed content.
+test_cmp_committed_rot13 () {
+ test_cmp "$1" "$2" &&
+ "$TEST_ROOT/rot13.sh" <"$1" >expected &&
+ git cat-file blob :"$2" >actual &&
+ test_cmp expected actual
+}

 test_expect_success setup '
  git config filter.rot13.smudge ./rot13.sh &&
@@ -34,7 +98,7 @@ test_expect_success setup '
  git checkout -- test test.t test.i &&

  echo "content-test2" >test2.o &&
- echo "content-test3 - subdir" >"test3 - subdir.o"
+ echo "content-test3 - filename with special characters" >"test3 '\''sq'\'',\$x.o"
 '

 script='s/^\$Id: \([0-9a-f]*\) \$/\1/p'
@@ -282,47 +346,6 @@ test_expect_success 'diff does not reuse worktree files that need cleaning' '
  test_line_count = 0 count
 '

-check_filter () {
- rm -f rot13-filter.log actual.log &&
- "$@" 2> git_stderr.log &&
- test_must_be_empty git_stderr.log &&
- cat >expected.log &&
- sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" >actual.log &&
- test_cmp expected.log actual.log
-}
-
-check_filter_count_clean () {
- rm -f rot13-filter.log actual.log &&
- "$@" 2> git_stderr.log &&
- test_must_be_empty git_stderr.log &&
- cat >expected.log &&
- sort rot13-filter.log | uniq -c | sed "s/^[ ]*//" |
-   sed "s/^\([0-9]\) IN: clean/x IN: clean/" >actual.log &&
- test_cmp expected.log actual.log
-}
-
-check_filter_ignore_clean () {
- rm -f rot13-filter.log actual.log &&
- "$@" &&
- cat >expected.log &&
- grep -v "IN: clean" rot13-filter.log >actual.log &&
- test_cmp expected.log actual.log
-}
-
-check_filter_no_call () {
- rm -f rot13-filter.log &&
- "$@" 2> git_stderr.log &&
- test_must_be_empty git_stderr.log &&
- test_must_be_empty rot13-filter.log
-}
-
-check_rot13 () {
- test_cmp "$1" "$2" &&
- ./../rot13.sh <"$1" >expected &&
- git cat-file blob :"$2" >actual &&
- test_cmp expected actual
-}
-
 test_expect_success PERL 'required process filter should filter data' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
  test_config_global filter.protocol.required true &&
@@ -332,81 +355,91 @@ test_expect_success PERL 'required process filter should filter data' '
    cd repo &&
    git init &&

+   echo "git-stderr.log" >.gitignore &&
    echo "*.r filter=protocol" >.gitattributes &&
    git add . &&
-   git commit . -m "test commit" &&
-   git branch empty &&
+   git commit . -m "test commit 1" &&
+   git branch empty-branch &&

-   cp ../test.o test.r &&
-   cp ../test2.o test2.r &&
+   cp "$TEST_ROOT/test.o" test.r &&
+   cp "$TEST_ROOT/test2.o" test2.r &&
    mkdir testsubdir &&
-   cp "../test3 - subdir.o" "testsubdir/test3 - subdir.r" &&
+   cp "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r" &&
    >test4-empty.r &&

-   check_filter \
-     git add . \
-       <<-\EOF &&
-         1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-         1 IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
-         1 IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         1 IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
-         1 START
-         1 STOP
-         1 wrote filter header
+   S=$(file_size test.r) &&
+   S2=$(file_size test2.r) &&
+   S3=$(file_size "testsubdir/test3 '\''sq'\'',\$x.r") &&
+
+   filter_git add . &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
+     IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+     IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+     IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+     STOP
    EOF
+   test_cmp_count expected.log rot13-filter.log &&

-   check_filter_count_clean \
-     git commit . -m "test commit" \
-       <<-\EOF &&
-         x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-         x IN: clean test2.r 14 [OK] -- OUT: 14 . [OK]
-         x IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         x IN: clean testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
-         1 START
-         1 STOP
-         1 wrote filter header
+   filter_git commit . -m "test commit 2" &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
+     IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+     IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+     IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
+     IN: clean test2.r $S2 [OK] -- OUT: $S2 . [OK]
+     IN: clean test4-empty.r 0 [OK] -- OUT: 0  [OK]
+     IN: clean testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
+     STOP
    EOF
+   test_cmp_count_except_clean expected.log rot13-filter.log &&

-   rm -f test?.r "testsubdir/test3 - subdir.r" &&
+   rm -f test2.r "testsubdir/test3 '\''sq'\'',\$x.r" &&

-   check_filter_ignore_clean \
-     git checkout . \
-       <<-\EOF &&
+   filter_git checkout --quiet --no-progress . &&
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
-         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
-         IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+     init handshake complete
+     IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
+     IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   check_filter_ignore_clean \
-     git checkout empty \
-       <<-\EOF &&
+   filter_git checkout --quiet --no-progress empty-branch &&
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
+     init handshake complete
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   check_filter_ignore_clean \
-     git checkout master \
-       <<-\EOF &&
+   filter_git checkout --quiet --no-progress master &&
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
-         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+     init handshake complete
+     IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+     IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
      IN: smudge test4-empty.r 0 [OK] -- OUT: 0  [OK]
-         IN: smudge testsubdir/test3 - subdir.r 23 [OK] -- OUT: 23 . [OK]
+     IN: smudge testsubdir/test3 '\''sq'\'',\$x.r $S3 [OK] -- OUT: $S3 . [OK]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   check_rot13 ../test.o test.r &&
-   check_rot13 ../test2.o test2.r &&
-   check_rot13 "../test3 - subdir.o" "testsubdir/test3 - subdir.r"
+   test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test3 '\''sq'\'',\$x.o" "testsubdir/test3 '\''sq'\'',\$x.r"
  )
 '

-test_expect_success PERL 'required process filter should clean only and take precedence' '
- test_config_global filter.protocol.clean ./../rot13.sh &&
+test_expect_success PERL 'required process filter takes precedence' '
+ test_config_global filter.protocol.clean false &&
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
  test_config_global filter.protocol.required true &&
  rm -rf repo &&
@@ -416,40 +449,55 @@ test_expect_success PERL 'required process filter should clean only and take pre
    git init &&

    echo "*.r filter=protocol" >.gitattributes &&
-   git add . &&
-   git commit . -m "test commit" &&
-   git branch empty &&
-
-   cp ../test.o test.r &&
-
-   check_filter \
-     git add . \
-       <<-\EOF &&
-         1 IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-         1 START
-         1 STOP
-         1 wrote filter header
-       EOF
+   cp "$TEST_ROOT/test.o" test.r &&
+   S=$(file_size test.r) &&

-   check_filter_count_clean \
-     git commit . -m "test commit" \
-       <<-\EOF
-         x IN: clean test.r 57 [OK] -- OUT: 57 . [OK]
-         1 START
-         1 STOP
-         1 wrote filter header
+   # Check that the process filter is invoked here
+   filter_git add . &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
+     STOP
    EOF
+   test_cmp_count expected.log rot13-filter.log
  )
 '

-generate_test_data () {
- LEN=$1
- NAME=$2
- test-genrandom end $LEN |
-   perl -pe "s/./chr((ord($&) % 26) + 97)/sge" >../$NAME.file &&
- cp ../$NAME.file . &&
- ./../rot13.sh <../$NAME.file >../$NAME.file.rot13
-}
+test_expect_success PERL 'required process filter should be used only for "clean" operation only' '
+ test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean" &&
+ rm -rf repo &&
+ mkdir repo &&
+ (
+   cd repo &&
+   git init &&
+
+   echo "*.r filter=protocol" >.gitattributes &&
+   cp "$TEST_ROOT/test.o" test.r &&
+   S=$(file_size test.r) &&
+
+   filter_git add . &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: clean test.r $S [OK] -- OUT: $S . [OK]
+     STOP
+   EOF
+   test_cmp_count expected.log rot13-filter.log &&
+
+   rm test.r &&
+
+   filter_git checkout --quiet --no-progress . &&
+   # If the filter would be used for "smudge", too, we would see
+   # "IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]" here
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     STOP
+   EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log
+ )
+'

 test_expect_success PERL 'required process filter should process multiple packets' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
@@ -461,42 +509,57 @@ test_expect_success PERL 'required process filter should process multiple packet
    cd repo &&
    git init &&

-   # Generate data that requires 3 packets
-   PKTLINE_DATA_MAXLEN=65516 &&
+   # Generate data requiring 1, 2, 3 packets
+   S=65516 && # PKTLINE_DATA_MAXLEN -> Maximal size of a packet
+   generate_random_characters $(($S    )) 1pkt_1__.file &&
+   generate_random_characters $(($S  +1)) 2pkt_1+1.file &&
+   generate_random_characters $(($S*2-1)) 2pkt_2-1.file &&
+   generate_random_characters $(($S*2  )) 2pkt_2__.file &&
+   generate_random_characters $(($S*2+1)) 3pkt_2+1.file &&

-   generate_test_data $(($PKTLINE_DATA_MAXLEN        )) 1pkt_1__ &&
-   generate_test_data $(($PKTLINE_DATA_MAXLEN     + 1)) 2pkt_1+1 &&
-   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 - 1)) 2pkt_2-1 &&
-   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2    )) 2pkt_2__ &&
-   generate_test_data $(($PKTLINE_DATA_MAXLEN * 2 + 1)) 3pkt_2+1 &&
+   for FILE in "$TEST_ROOT"/*.file
+   do
+     cp "$FILE" . &&
+     "$TEST_ROOT/rot13.sh" <"$FILE" >"$FILE.rot13"
+   done &&

    echo "*.file filter=protocol" >.gitattributes &&
-   check_filter \
-     git add *.file .gitattributes \
-       <<-\EOF &&
-         1 IN: clean 1pkt_1__.file 65516 [OK] -- OUT: 65516 . [OK]
-         1 IN: clean 2pkt_1+1.file 65517 [OK] -- OUT: 65517 .. [OK]
-         1 IN: clean 2pkt_2-1.file 131031 [OK] -- OUT: 131031 .. [OK]
-         1 IN: clean 2pkt_2__.file 131032 [OK] -- OUT: 131032 .. [OK]
-         1 IN: clean 3pkt_2+1.file 131033 [OK] -- OUT: 131033 ... [OK]
-         1 START
-         1 STOP
-         1 wrote filter header
+   filter_git add *.file .gitattributes &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: clean 1pkt_1__.file $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
+     IN: clean 2pkt_1+1.file $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
+     IN: clean 2pkt_2-1.file $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
+     IN: clean 2pkt_2__.file $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
+     IN: clean 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
+     STOP
    EOF
-   git commit . -m "test commit" &&
+   test_cmp_count expected.log rot13-filter.log &&

    rm -f *.file &&
-   git checkout -- *.file &&

-   for f in *.file
+   filter_git checkout --quiet --no-progress -- *.file &&
+   cat >expected.log <<-EOF &&
+     START
+     init handshake complete
+     IN: smudge 1pkt_1__.file $(($S    )) [OK] -- OUT: $(($S    )) . [OK]
+     IN: smudge 2pkt_1+1.file $(($S  +1)) [OK] -- OUT: $(($S  +1)) .. [OK]
+     IN: smudge 2pkt_2-1.file $(($S*2-1)) [OK] -- OUT: $(($S*2-1)) .. [OK]
+     IN: smudge 2pkt_2__.file $(($S*2  )) [OK] -- OUT: $(($S*2  )) .. [OK]
+     IN: smudge 3pkt_2+1.file $(($S*2+1)) [OK] -- OUT: $(($S*2+1)) ... [OK]
+     STOP
+   EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&
+
+   for FILE in *.file
    do
-     git cat-file blob :$f >actual &&
-     test_cmp ../$f.rot13 actual
+     test_cmp_committed_rot13 "$TEST_ROOT/$FILE" $FILE
    done
  )
 '

-test_expect_success PERL 'required process filter should with clean error should fail' '
+test_expect_success PERL 'required process filter with clean error should fail' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
  test_config_global filter.protocol.required true &&
  rm -rf repo &&
@@ -507,11 +570,10 @@ test_expect_success PERL 'required process filter should with clean error should

    echo "*.r filter=protocol" >.gitattributes &&

-   cp ../test.o test.r &&
+   cp "$TEST_ROOT/test.o" test.r &&
    echo "this is going to fail" >clean-write-fail.r &&
    echo "content-test3-subdir" >test3.r &&

-   # Note: There are three clean paths in convert.c we just test one here.
    test_must_fail git add .
  )
 '
@@ -526,38 +588,48 @@ test_expect_success PERL 'process filter should restart after unexpected write f

    echo "*.r filter=protocol" >.gitattributes &&

-   cp ../test.o test.r &&
-   cp ../test2.o test2.r &&
+   cp "$TEST_ROOT/test.o" test.r &&
+   cp "$TEST_ROOT/test2.o" test2.r &&
    echo "this is going to fail" >smudge-write-fail.o &&
-   cat smudge-write-fail.o >smudge-write-fail.r &&
+   cp smudge-write-fail.o smudge-write-fail.r &&
+
+   S=$(file_size test.r) &&
+   S2=$(file_size test2.r) &&
+   SF=$(file_size smudge-write-fail.r) &&
+
    git add . &&
-   git commit . -m "test commit" &&
    rm -f *.r &&

-   check_filter_ignore_clean \
-     git checkout . \
-       <<-\EOF &&
+   rm -f rot13-filter.log &&
+   git checkout --quiet --no-progress . 2>git-stderr.log &&
+
+   grep "smudge write error at" git-stderr.log &&
+   grep "error: external filter" git-stderr.log &&
+
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
-         IN: smudge smudge-write-fail.r 22 [OK] -- OUT: 22 [WRITE FAIL]
+     init handshake complete
+     IN: smudge smudge-write-fail.r $SF [OK] -- OUT: $SF [WRITE FAIL]
      START
-         wrote filter header
-         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+     init handshake complete
+     IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+     IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   check_rot13 ../test.o test.r &&
-   check_rot13 ../test2.o test2.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&

-   ! test_cmp smudge-write-fail.o smudge-write-fail.r && # Smudge failed!
-   ./../rot13.sh <smudge-write-fail.o >expected &&
+   # Smudge failed
+   ! test_cmp smudge-write-fail.o smudge-write-fail.r &&
+   "$TEST_ROOT/rot13.sh" <smudge-write-fail.o >expected &&
    git cat-file blob :smudge-write-fail.r >actual &&
-   test_cmp expected actual                # Clean worked!
+   test_cmp expected actual
  )
 '

-test_expect_success PERL 'process filter should not restart in case of an error' '
+test_expect_success PERL 'process filter should not be restarted if it signals an error' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
  rm -rf repo &&
  mkdir repo &&
@@ -567,32 +639,36 @@ test_expect_success PERL 'process filter should not restart in case of an error'

    echo "*.r filter=protocol" >.gitattributes &&

-   cp ../test.o test.r &&
-   cp ../test2.o test2.r &&
+   cp "$TEST_ROOT/test.o" test.r &&
+   cp "$TEST_ROOT/test2.o" test2.r &&
    echo "this will cause an error" >error.o &&
    cp error.o error.r &&
+
+   S=$(file_size test.r) &&
+   S2=$(file_size test2.r) &&
+   SE=$(file_size error.r) &&
+
    git add . &&
-   git commit . -m "test commit" &&
    rm -f *.r &&

-   check_filter_ignore_clean \
-     git checkout . \
-       <<-\EOF &&
+   filter_git checkout --quiet --no-progress . &&
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
-         IN: smudge error.r 25 [OK] -- OUT: 0 [ERROR]
-         IN: smudge test.r 57 [OK] -- OUT: 57 . [OK]
-         IN: smudge test2.r 14 [OK] -- OUT: 14 . [OK]
+     init handshake complete
+     IN: smudge error.r $SE [OK] -- OUT: 0 [ERROR]
+     IN: smudge test.r $S [OK] -- OUT: $S . [OK]
+     IN: smudge test2.r $S2 [OK] -- OUT: $S2 . [OK]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   check_rot13 ../test.o test.r &&
-   check_rot13 ../test2.o test2.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test.o" test.r &&
+   test_cmp_committed_rot13 "$TEST_ROOT/test2.o" test2.r &&
    test_cmp error.o error.r
  )
 '

-test_expect_success PERL 'process filter should be able to signal an error for all future files' '
+test_expect_success PERL 'process filter signals abort once to abort processing of all future files' '
  test_config_global filter.protocol.process "$TEST_DIRECTORY/t0021/rot13-filter.pl clean smudge" &&
  rm -rf repo &&
  mkdir repo &&
@@ -602,25 +678,27 @@ test_expect_success PERL 'process filter should be able to signal an error for a

    echo "*.r filter=protocol" >.gitattributes &&

-   cp ../test.o test.r &&
-   cp ../test2.o test2.r &&
+   cp "$TEST_ROOT/test.o" test.r &&
+   cp "$TEST_ROOT/test2.o" test2.r &&
    echo "error this blob and all future blobs" >abort.o &&
    cp abort.o abort.r &&
+
+   SA=$(file_size abort.r) &&
+
    git add . &&
-   git commit . -m "test commit" &&
    rm -f *.r &&

-   check_filter_ignore_clean \
-     git checkout . \
-       <<-\EOF &&
+   filter_git checkout --quiet --no-progress . &&
+   cat >expected.log <<-EOF &&
      START
-         wrote filter header
-         IN: smudge abort.r 37 [OK] -- OUT: 0 [ABORT]
+     init handshake complete
+     IN: smudge abort.r $SA [OK] -- OUT: 0 [ABORT]
      STOP
    EOF
+   test_cmp_exclude_clean expected.log rot13-filter.log &&

-   test_cmp ../test.o test.r &&
-   test_cmp ../test2.o test2.r &&
+   test_cmp "$TEST_ROOT/test.o" test.r &&
+   test_cmp "$TEST_ROOT/test2.o" test2.r &&
    test_cmp abort.o abort.r
  )
 '
@@ -636,9 +714,9 @@ test_expect_success PERL 'invalid process filter must fail (and not hang!)' '

    echo "*.r filter=protocol" >.gitattributes &&

-   cp ../test.o test.r &&
-   test_must_fail git add . 2> git_stderr.log &&
-   grep "not support long running filter protocol" git_stderr.log
+   cp "$TEST_ROOT/test.o" test.r &&
+   test_must_fail git add . 2>git-stderr.log &&
+   grep "does not support filter protocol version" git-stderr.log
  )
 '

diff --git a/t/t0021/rot13-filter.pl b/t/t0021/rot13-filter.pl
index 8958f71..1a6959c 100755
--- a/t/t0021/rot13-filter.pl
+++ b/t/t0021/rot13-filter.pl
@@ -26,10 +26,10 @@ use warnings;
 my $MAX_PACKET_CONTENT_SIZE = 65516;
 my @capabilities            = @ARGV;

-open my $debug, ">>", "rot13-filter.log";
+open my $debug, ">>", "rot13-filter.log" or die "cannot open log file: $!";

 sub rot13 {
-    my ($str) = @_;
+ my $str = shift;
  $str =~ y/A-Za-z/N-ZA-Mn-za-m/;
  return $str;
 }
@@ -38,13 +38,12 @@ sub packet_bin_read {
  my $buffer;
  my $bytes_read = read STDIN, $buffer, 4;
  if ( $bytes_read == 0 ) {
-
    # EOF - Git stopped talking to us!
    print $debug "STOP\n";
    exit();
  }
  elsif ( $bytes_read != 4 ) {
-        die "invalid packet size '$bytes_read' field";
+   die "invalid packet: '$buffer'";
  }
  my $pkt_size = hex($buffer);
  if ( $pkt_size == 0 ) {
@@ -54,27 +53,27 @@ sub packet_bin_read {
    my $content_size = $pkt_size - 4;
    $bytes_read = read STDIN, $buffer, $content_size;
    if ( $bytes_read != $content_size ) {
-            die "invalid packet ($content_size expected; $bytes_read read)";
+     die "invalid packet ($content_size bytes expected; $bytes_read bytes read)";
    }
    return ( 0, $buffer );
  }
  else {
-        die "invalid packet size";
+   die "invalid packet size: $pkt_size";
  }
 }

 sub packet_txt_read {
  my ( $res, $buf ) = packet_bin_read();
-    unless ( $buf =~ /\n$/ ) {
-        die "A non-binary line SHOULD BE terminated by an LF.";
+ unless ( $buf =~ s/\n$// ) {
+   die "A non-binary line MUST be terminated by an LF.";
  }
-    return ( $res, substr( $buf, 0, -1 ) );
+ return ( $res, $buf );
 }

 sub packet_bin_write {
-    my ($packet) = @_;
-    print STDOUT sprintf( "%04x", length($packet) + 4 );
-    print STDOUT $packet;
+ my $buf = shift;
+ print STDOUT sprintf( "%04x", length($buf) + 4 );
+ print STDOUT $buf;
  STDOUT->flush();
 }

@@ -105,7 +104,7 @@ foreach (@capabilities) {
  packet_txt_write( $_ . "=true" );
 }
 packet_flush();
-print $debug "wrote filter header\n";
+print $debug "init handshake complete\n";
 $debug->flush();

 while (1) {
@@ -175,6 +174,7 @@ while (1) {
    while ( length($output) > 0 ) {
      my $packet = substr( $output, 0, $MAX_PACKET_CONTENT_SIZE );
      packet_bin_write($packet);
+     # dots represent the number of packets
      print $debug ".";
      if ( length($output) > $MAX_PACKET_CONTENT_SIZE ) {
        $output = substr( $output, $MAX_PACKET_CONTENT_SIZE );


Lars Schneider (14):
  convert: quote filter names in error messages
  convert: modernize tests
  run-command: move check_pipe() from write_or_die to run_command
  run-command: add wait_on_exit
  pkt-line: rename packet_write() to packet_write_fmt()
  pkt-line: extract set_packet_header()
  pkt-line: add packet_write_fmt_gently()
  pkt-line: add packet_flush_gently()
  pkt-line: add packet_write_gently()
  pkt-line: add functions to read/write flush terminated packet streams
  convert: make apply_filter() adhere to standard Git error handling
  convert: prepare filter.<driver>.process option
  convert: add filter.<driver>.process option
  contrib/long-running-filter: add long running filter example

 Documentation/gitattributes.txt        | 159 ++++++++++-
 builtin/archive.c                      |   4 +-
 builtin/receive-pack.c                 |   4 +-
 builtin/remote-ext.c                   |   4 +-
 builtin/upload-archive.c               |   4 +-
 connect.c                              |   2 +-
 contrib/long-running-filter/example.pl | 127 +++++++++
 convert.c                              | 370 +++++++++++++++++++++---
 daemon.c                               |   2 +-
 http-backend.c                         |   2 +-
 pkt-line.c                             | 148 +++++++++-
 pkt-line.h                             |  12 +-
 run-command.c                          |  72 ++++-
 run-command.h                          |   5 +-
 shallow.c                              |   2 +-
 t/t0021-conversion.sh                  | 505 ++++++++++++++++++++++++++++++---
 t/t0021/rot13-filter.pl                | 191 +++++++++++++
 upload-pack.c                          |  30 +-
 write_or_die.c                         |  13 -
 19 files changed, 1519 insertions(+), 137 deletions(-)
 create mode 100755 contrib/long-running-filter/example.pl
 create mode 100755 t/t0021/rot13-filter.pl

--
2.10.0

