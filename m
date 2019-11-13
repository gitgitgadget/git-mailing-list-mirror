Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.9 required=3.0 tests=AWL,BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,RCVD_IN_DNSWL_HI,
	SPF_HELO_NONE,SPF_NONE shortcircuit=no autolearn=ham
	autolearn_force=no version=3.4.2
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id E33E61F4B5
	for <e@80x24.org>; Wed, 13 Nov 2019 01:03:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727124AbfKMBDj (ORCPT <rfc822;e@80x24.org>);
        Tue, 12 Nov 2019 20:03:39 -0500
Received: from cloud.peff.net ([104.130.231.41]:46006 "HELO cloud.peff.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
        id S1727002AbfKMBDi (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 12 Nov 2019 20:03:38 -0500
Received: (qmail 10437 invoked by uid 109); 13 Nov 2019 01:03:38 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with SMTP; Wed, 13 Nov 2019 01:03:38 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 21027 invoked by uid 111); 13 Nov 2019 01:07:10 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Tue, 12 Nov 2019 20:07:10 -0500
Authentication-Results: peff.net; auth=none
Date:   Tue, 12 Nov 2019 20:03:37 -0500
From:   Jeff King <peff@peff.net>
To:     SZEDER =?utf-8?B?R8OhYm9y?= <szeder.dev@gmail.com>
Cc:     Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>
Subject: Re: do people find t5504.8 flaky?
Message-ID: <20191113010337.GA20023@sigill.intra.peff.net>
References: <xmqqmukh5tj6.fsf@gitster-ct.c.googlers.com>
 <20190423030254.GA19604@sigill.intra.peff.net>
 <20191113000747.GQ4348@szeder.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20191113000747.GQ4348@szeder.dev>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Wed, Nov 13, 2019 at 01:07:47AM +0100, SZEDER Gábor wrote:

> > No, I haven't seen it fail, nor does running with --stress turn up
> > anything.
> 
> I can reproduce the failure fairly quickly with '-r 1,8 --stress' (and
> nr of jobs = 4x cores).

I was able to reproduce with that, too (I wonder why I had so much
trouble before? Maybe "-r 1,8" simply gives many more opportunities per
second).

Running with "-x", I don't see any sign of a premature SIGPIPE death,
which is good:

  + git push --porcelain dst master:refs/heads/test
  remote: fatal: object of unexpected type        
  error: remote unpack failed: unpack-objects abnormal exit
  error: failed to push some refs to 'dst'
  + exit_code=1

The "exit_code" assignment there is from test_must_fail. And looking at
the code, I think we handle a remote hangup well, because the writer is
actually a pack-objects sub-process. So we hit this code in send-pack.c:

          rc = finish_command(&po);
          if (rc) {
                  /*
                   * For a normal non-zero exit, we assume pack-objects wrote
                   * something useful to stderr. For death by signal, though,
                   * we should mention it to the user. The exception is SIGPIPE
                   * (141), because that's a normal occurrence if the remote end
                   * hangs up (and we'll report that by trying to read the unpack
                   * status).
                   */
                  if (rc > 128 && rc != 141)
                          error("pack-objects died of signal %d", rc - 128);
                  return -1;
          }

But that error return might explain things.

The difference in your traces seems to be that in the failing case we
exit immediately after seeing the unpack error:

>   packet:     sideband< \2fatal: object of unexpected type
>   packet: receive-pack> unpack unpack-objects abnormal exit
>   packet: receive-pack> ng refs/heads/test unpacker error
>   packet: receive-pack> 0000
>   packet:     sideband< \10028unpack unpack-objects abnormal exit0026ng refs/heads/test unpacker error0000
>   packet: receive-pack> 0000
>   packet:     sideband< 0000
>   packet:         push< unpack unpack-objects abnormal exit
>   + test_cmp exp act
>   --- exp 2019-11-12 23:40:33.131679990 +0000
>   +++ act 2019-11-12 23:40:33.203680114 +0000
>   @@ -1,2 +0,0 @@
>   -To dst
>   -!      refs/heads/master:refs/heads/test       [remote rejected] (unpacker error)
>   error: last command exited with $?=1
>   not ok 8 - push with receive.fsckobjects

Note that "receive-pack" sent us the "ng refs/heads/test" line. And our
sideband demuxer even saw it! But it never made it to push.

Whereas in the successful case:

>   packet:     sideband< \2fatal: object of unexpected type
>   packet: receive-pack> unpack unpack-objects abnormal exit
>   packet: receive-pack> ng refs/heads/test unpacker error
>   packet: receive-pack> 0000
>   packet:     sideband< \10028unpack unpack-objects abnormal exit0026ng refs/heads/test unpacker error0000
>   packet:         push< unpack unpack-objects abnormal exit
>   packet:         push< ng refs/heads/test unpacker error
>   packet:         push< 0000
>   packet: receive-pack> 0000
>   packet:     sideband< 0000

We do see "push" getting it.

So for some reason we're deciding not to read the status from out
sideband demuxer. And that is probably because of this code in
send_pack():

                  if (pack_objects(out, remote_refs, extra_have, args) < 0) {
                          for (ref = remote_refs; ref; ref = ref->next)
                                  ref->status = REF_STATUS_NONE;
                          if (args->stateless_rpc)
                                  close(out);
                          if (git_connection_is_socket(conn))
                                  shutdown(fd[0], SHUT_WR);
  
                          /*
                           * Do not even bother with the return value; we know we
                           * are failing, and just want the error() side effects.
                           */
                          if (status_report)
                                  receive_unpack_status(&reader);
  
                          if (use_sideband) {
                                  close(demux.out);
                                  finish_async(&demux);
                          }
                          fd[1] = -1;
                          return -1;
                  }

If we saw a pack-objects error, then we do bother to receive the unpack
status, but we don't stick around to get the individual ref status, and
everything stays as REF_STATUS_NONE.

And looking in transport_print_push_status(), NONE is skipped when
printing. We probably ought to be seeding it with a different status
there, but there's not really one for "hey, _we_ failed". Let's hack it
to use REMOTE_REJECT, put put in our own message, like so:

diff --git a/send-pack.c b/send-pack.c
index 34c77cbb1a..f6d609a244 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -565,8 +565,10 @@ int send_pack(struct send_pack_args *args,
 
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref = remote_refs; ref; ref = ref->next)
-				ref->status = REF_STATUS_NONE;
+			for (ref = remote_refs; ref; ref = ref->next) {
+				ref->status = REF_STATUS_REMOTE_REJECT;
+				ref->remote_status = xstrdup("pack-objects error");
+			}
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))

Now when the stress-test fails, I get:

  --- exp	2019-11-13 00:48:53.269943875 +0000
  +++ act	2019-11-13 00:48:53.317943957 +0000
  @@ -1,2 +1,2 @@
   To dst
  -!	refs/heads/master:refs/heads/test	[remote rejected] (unpacker error)
  +!	refs/heads/master:refs/heads/test	[remote rejected] (pack-objects error)

So we're definitely on the right track! Of course we could say "unpacker
error" and the test failure would go away. But it feels a bit like
lying, since the remote didn't tell us that.

So really, what we want for this case is to just get the remote status,
like so:

diff --git a/send-pack.c b/send-pack.c
index 34c77cbb1a..d4db965b96 100644
--- a/send-pack.c
+++ b/send-pack.c
@@ -565,19 +565,19 @@ int send_pack(struct send_pack_args *args,
 
 	if (need_pack_data && cmds_sent) {
 		if (pack_objects(out, remote_refs, extra_have, args) < 0) {
-			for (ref = remote_refs; ref; ref = ref->next)
-				ref->status = REF_STATUS_NONE;
 			if (args->stateless_rpc)
 				close(out);
 			if (git_connection_is_socket(conn))
 				shutdown(fd[0], SHUT_WR);
 
 			/*
 			 * Do not even bother with the return value; we know we
-			 * are failing, and just want the error() side effects.
+			 * are failing, and just want the error() side effects,
+			 * as well as marking refs with the remote status (if
+			 * we get one).
 			 */
 			if (status_report)
-				receive_unpack_status(&reader);
+				receive_status(&reader, remote_refs);
 
 			if (use_sideband) {
 				close(demux.out);

I was worried at first that we might make things worse for the case that
the network has hung up completely (which would cause pack-objects to
fail, but also cause us to not get anything from the remote). But this
is really no worse. Even in the existing code, we'd complain to stderr
about trying to read the unpack status. And then when we read the remote
ref status, as soon as we see a bad packet we just quietly stop reading
(thus leaving any unmentioned refs as EXPECTING_REPORT).

So with that second patch above, the test failure goes away for me.

-Peff
