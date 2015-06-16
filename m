From: Augie Fackler <augie@google.com>
Subject: Re: [PATCH 3/3] pkt-line: support tracing verbatim pack contents
Date: Tue, 16 Jun 2015 11:38:41 -0400
Message-ID: <CAHcr6HYvVR4uTmtegWHK0h+v_aVs4JVLsSwvjthGY3pb=-Q0yQ@mail.gmail.com>
References: <20150612212526.GA25447@peff.net>
	<20150612212827.GC25757@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Junio C Hamano <gitster@pobox.com>, Johannes Sixt <j6t@kdbg.org>,
	git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Jun 16 17:38:54 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4swv-0004W1-KI
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 17:38:54 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756738AbbFPPis (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Jun 2015 11:38:48 -0400
Received: from mail-wi0-f177.google.com ([209.85.212.177]:34727 "EHLO
	mail-wi0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756427AbbFPPin (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 11:38:43 -0400
Received: by wicnd19 with SMTP id nd19so56852128wic.1
        for <git@vger.kernel.org>; Tue, 16 Jun 2015 08:38:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=1wtMAEgqVOLpvuEyft4vfj5aim4jshzFB8gDcjrcIJc=;
        b=J6cuSWJ9RX2IfhDo8x6E6j1LY1Q34fDhTTsl6Fa8n+O+AfNTbNglIGr8OOOlq2WGoV
         DddDtg1y/y2uvhXzIRn6bMdbWgbDnmMzpD8PIfMb685sZOEehx37RwU+yYGD93zogbAj
         sYKSnMs/SDISbNO4VToNYdApC/brPfYmshrK150gQVT5EXczj8iUjWANUwsNYHgHd/IW
         ATKE8pqD6duvX1DGdcGQvL969EOEvz2s6XdYF26nnRawz/kQnq8Cv1Wj6iJbT8GzjOhp
         l7Fo+VIZwlv/Lvp03nZGY22fp8yU+OjPEgF68fojHmJWPpN/44FBul3hhPMs7z2wOJi1
         dzkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:in-reply-to:references:date
         :message-id:subject:from:to:cc:content-type;
        bh=1wtMAEgqVOLpvuEyft4vfj5aim4jshzFB8gDcjrcIJc=;
        b=Ir81A2BuS477Tz9Idwj82izk633QPdwMB4o/xGjgUSHCs0CfsGVFvvWF7Zw0Ae7vc7
         nmnVoAYNbY6RfESti/6U5hW1VlMSvZSD5K5ea3dzSNhCZ1cTDBAYnFUEd9aztrvra0N6
         abKklU9v/Z+7fK+pbMg+Sr+2tUcAmUTOUWz5Dffz/li0dxk+VVWavVR4AxAJiMofi8bR
         m4N0Estk1k2QJGw7TitNKgeX2+XE8VY5OJEqsdQvbywwvqGwVp8Sp6UIIPgzfLT53FQY
         ZJgn7ZPWggjP9qwkgzdftK5KkYC4SyWdwAaFGAhJq/ye2p3Ajx9kgnPrBv9YUgViyfVG
         rCrA==
X-Gm-Message-State: ALoCoQnUpePfzkc925ryMM4Jzgty08FqYV0brrXytwJRgtUA2XJwFXN9DfY7gMmBBmcqdu/31cK9
X-Received: by 10.180.89.231 with SMTP id br7mr44392694wib.60.1434469121429;
 Tue, 16 Jun 2015 08:38:41 -0700 (PDT)
Received: by 10.28.146.143 with HTTP; Tue, 16 Jun 2015 08:38:41 -0700 (PDT)
In-Reply-To: <20150612212827.GC25757@peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271770>

On Fri, Jun 12, 2015 at 5:28 PM, Jeff King <peff@peff.net> wrote:
> When debugging the pack protocol, it is sometimes useful to
> store the verbatim pack that we sent or received on the
> wire. Looking at the on-disk result is often not helpful for
> a few reasons:
>
>   1. If the operation is a clone, we destroy the repo on
>      failure, leaving nothing on disk.
>
>   2. If the pack is small, we unpack it immediately, and the
>      full pack never hits the disk.
>
>   3. If we feed the pack to "index-pack --fix-thin", the
>      resulting pack has the extra delta bases added to it.
>
> We already have a GIT_TRACE_PACKET mechanism for tracing
> packets. Let's extend it with GIT_TRACE_PACK to dump the
> verbatim packfile.

FWIW, this also works for me - I have no preference between my patches
and Jeff's. I suspect yours are much better given that you have a clue
about git internals ;).

One bit of feedback is that it might be worth mentioning (though I
don't feel strongly) that GIT_TRACE_PACK works with or without
GIT_TRACE_PACKET - that wasn't immediately obvious to me, but it makes
sense once I read the code.

Thanks!

>
> There are a few other positive fallouts that come from
> rearranging this code:
>
>  - We currently disable the packet trace after seeing the
>    PACK header, even though we may get human-readable lines
>    on other sidebands; now we include them in the trace.
>
>  - We currently try to print "PACK ..." in the trace to
>    indicate that the packfile has started. But because we
>    disable packet tracing, we never printed this line. We
>    will now do so.
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  Documentation/git.txt | 13 +++++++++++-
>  pkt-line.c            | 59 ++++++++++++++++++++++++++++++++++++++-------------
>  t/t5601-clone.sh      |  7 ++++++
>  trace.c               |  7 ++++++
>  trace.h               |  1 +
>  5 files changed, 71 insertions(+), 16 deletions(-)
>
> diff --git a/Documentation/git.txt b/Documentation/git.txt
> index 45b64a7..8c44d14 100644
> --- a/Documentation/git.txt
> +++ b/Documentation/git.txt
> @@ -1000,9 +1000,20 @@ Unsetting the variable, or setting it to empty, "0" or
>         Enables trace messages for all packets coming in or out of a
>         given program. This can help with debugging object negotiation
>         or other protocol issues. Tracing is turned off at a packet
> -       starting with "PACK".
> +       starting with "PACK" (but see 'GIT_TRACE_PACK' below).
>         See 'GIT_TRACE' for available trace output options.
>
> +'GIT_TRACE_PACK'::
> +       Enables tracing of packfiles sent or received by a
> +       given program. Unlike other trace output, this trace is
> +       verbatim: no headers, and no quoting of binary data. You almost
> +       certainly want to direct into a file (e.g.,
> +       `GIT_TRACE_PACK=/tmp/my.pack`) rather than displaying it on the
> +       terminal or mixing it with other trace output.
> ++
> +Note that this is currently only implemented for the client side
> +of clones and fetches.
> +
>  'GIT_TRACE_PERFORMANCE'::
>         Enables performance related trace messages, e.g. total execution
>         time of each Git command.
> diff --git a/pkt-line.c b/pkt-line.c
> index e75af02..2e122c0 100644
> --- a/pkt-line.c
> +++ b/pkt-line.c
> @@ -4,16 +4,51 @@
>  char packet_buffer[LARGE_PACKET_MAX];
>  static const char *packet_trace_prefix = "git";
>  static struct trace_key trace_packet = TRACE_KEY_INIT(PACKET);
> +static struct trace_key trace_pack = TRACE_KEY_INIT(PACK);
>
>  void packet_trace_identity(const char *prog)
>  {
>         packet_trace_prefix = xstrdup(prog);
>  }
>
> +static int packet_trace_pack(const char *buf, unsigned int len, int sideband)
> +{
> +       if (!sideband) {
> +               trace_verbatim(&trace_pack, buf, len);
> +               return 1;
> +       } else if (len && *buf == '\1') {
> +               trace_verbatim(&trace_pack, buf + 1, len - 1);
> +               return 1;
> +       } else {
> +               /* it's another non-pack sideband */
> +               return 0;
> +       }
> +}
> +
>  static void packet_trace(const char *buf, unsigned int len, int write)
>  {
>         int i;
>         struct strbuf out;
> +       static int in_pack, sideband;
> +
> +       if (!trace_want(&trace_packet) && !trace_want(&trace_pack))
> +               return;
> +
> +       if (in_pack) {
> +               if (packet_trace_pack(buf, len, sideband))
> +                       return;
> +       } else if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
> +               in_pack = 1;
> +               sideband = *buf == '\1';
> +               packet_trace_pack(buf, len, sideband);
> +
> +               /*
> +                * Make a note in the human-readable trace that the pack data
> +                * started.
> +                */
> +               buf = "PACK ...";
> +               len = strlen(buf);
> +       }
>
>         if (!trace_want(&trace_packet))
>                 return;
> @@ -24,21 +59,15 @@ static void packet_trace(const char *buf, unsigned int len, int write)
>         strbuf_addf(&out, "packet: %12s%c ",
>                     packet_trace_prefix, write ? '>' : '<');
>
> -       if (starts_with(buf, "PACK") || starts_with(buf, "\1PACK")) {
> -               strbuf_addstr(&out, "PACK ...");
> -               trace_disable(&trace_packet);
> -       }
> -       else {
> -               /* XXX we should really handle printable utf8 */
> -               for (i = 0; i < len; i++) {
> -                       /* suppress newlines */
> -                       if (buf[i] == '\n')
> -                               continue;
> -                       if (buf[i] >= 0x20 && buf[i] <= 0x7e)
> -                               strbuf_addch(&out, buf[i]);
> -                       else
> -                               strbuf_addf(&out, "\\%o", buf[i]);
> -               }
> +       /* XXX we should really handle printable utf8 */
> +       for (i = 0; i < len; i++) {
> +               /* suppress newlines */
> +               if (buf[i] == '\n')
> +                       continue;
> +               if (buf[i] >= 0x20 && buf[i] <= 0x7e)
> +                       strbuf_addch(&out, buf[i]);
> +               else
> +                       strbuf_addf(&out, "\\%o", buf[i]);
>         }
>
>         strbuf_addch(&out, '\n');
> diff --git a/t/t5601-clone.sh b/t/t5601-clone.sh
> index bfdaf75..795ece0 100755
> --- a/t/t5601-clone.sh
> +++ b/t/t5601-clone.sh
> @@ -496,4 +496,11 @@ test_expect_success 'shallow clone locally' '
>         ( cd ddsstt && git fsck )
>  '
>
> +test_expect_success 'GIT_TRACE_PACK produces a usable pack' '
> +       rm -rf dst.git &&
> +       GIT_TRACE_PACK=$PWD/tmp.pack git clone --no-local --bare src dst.git &&
> +       git init --bare replay.git &&
> +       git -C replay.git index-pack -v --stdin <tmp.pack
> +'
> +
>  test_done
> diff --git a/trace.c b/trace.c
> index 3c3bd8f..7393926 100644
> --- a/trace.c
> +++ b/trace.c
> @@ -120,6 +120,13 @@ static int prepare_trace_line(const char *file, int line,
>         return 1;
>  }
>
> +void trace_verbatim(struct trace_key *key, const void *buf, unsigned len)
> +{
> +       if (!trace_want(key))
> +               return;
> +       write_or_whine_pipe(get_trace_fd(key), buf, len, err_msg);
> +}
> +
>  static void print_trace_line(struct trace_key *key, struct strbuf *buf)
>  {
>         strbuf_complete_line(buf);
> diff --git a/trace.h b/trace.h
> index ae6a332..179b249 100644
> --- a/trace.h
> +++ b/trace.h
> @@ -18,6 +18,7 @@ extern int trace_want(struct trace_key *key);
>  extern void trace_disable(struct trace_key *key);
>  extern uint64_t getnanotime(void);
>  extern void trace_command_performance(const char **argv);
> +extern void trace_verbatim(struct trace_key *key, const void *buf, unsigned len);
>
>  #ifndef HAVE_VARIADIC_MACROS
>
> --
> 2.4.2.752.geeb594a
