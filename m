Return-Path: <git-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87FDCCCA481
	for <git@archiver.kernel.org>; Wed, 13 Jul 2022 14:42:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236589AbiGMOmy (ORCPT <rfc822;git@archiver.kernel.org>);
        Wed, 13 Jul 2022 10:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236585AbiGMOmr (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 13 Jul 2022 10:42:47 -0400
Received: from dalaran.tastycake.net (dalaran.tastycake.net [IPv6:2001:ba8:0:1c0::1:1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6868B32ECE
        for <git@vger.kernel.org>; Wed, 13 Jul 2022 07:42:45 -0700 (PDT)
Received: from c.a.1.d.d.f.6.c.f.8.d.f.b.e.b.6.d.a.0.2.5.1.e.d.0.b.8.0.1.0.0.2.ip6.arpa ([2001:8b0:de15:20ad:6beb:fd8f:c6fd:d1ac] helo=lucy.dinwoodie.org)
        by dalaran.tastycake.net with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.90_1)
        (envelope-from <adam@dinwoodie.org>)
        id 1oBdZY-0001dI-6A; Wed, 13 Jul 2022 15:42:40 +0100
Received: from adam by lucy.dinwoodie.org with local (Exim 4.94.2)
        (envelope-from <adam@dinwoodie.org>)
        id 1oBdZW-003rXC-VR; Wed, 13 Jul 2022 15:42:39 +0100
Date:   Wed, 13 Jul 2022 15:42:38 +0100
From:   Adam Dinwoodie <adam@dinwoodie.org>
To:     Ramsay Jones <ramsay@ramsayjones.plus.com>
Cc:     Junio C Hamano <gitster@pobox.com>,
        GIT Mailing-list <git@vger.kernel.org>,
        Johannes Schindelin <Johannes.Schindelin@gmx.de>,
        Jeff King <peff@peff.net>
Subject: Re: t0301-credential-cache test failure on cygwin
Message-ID: <CA+kUOam-_3qR7YguPyUmyC2dWi2M1cy6Hg4Pveak+f40qtYBvA@mail.gmail.com>
References: <9dc3e85f-a532-6cff-de11-1dfb2e4bc6b6@ramsayjones.plus.com>
 <xmqqtu7t30uv.fsf@gitster.g>
 <4529b11a-e514-6676-f427-ffaec484e8f1@ramsayjones.plus.com>
 <CA+kUOakjnOxs_FGojdZXaiaY4+68pvyBHsbue+AQHp7PLXqNJw@mail.gmail.com>
 <CA+kUOak29RkU-ooMgOz8yCg9-q6vb1VfdP8_VLay_V650ttwjA@mail.gmail.com>
 <51972253-c1a1-8be7-39f5-3093ac83ffb1@ramsayjones.plus.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <51972253-c1a1-8be7-39f5-3093ac83ffb1@ramsayjones.plus.com>
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Mon, 11 Jul 2022 at 15:56, Ramsay Jones <ramsay@ramsayjones.plus.com> wrote:
> On 11/07/2022 14:39, Adam Dinwoodie wrote:
> [snip]
>
> >
> > Minor progress update: I've now confirmed the failure was introduced by
> > a change in the Cygwin library between the binaries for Cygwin versions
> > 3.2.0-1 and 3.3.1-1. Specifically, the test passes with Cygwin from the
> > 27 October 2021 package archive[0], and fails with Cygwin from the 28
> > October 2021 archive[1], and the only difference between the two that
> > has any chance of being relevant is that bump in the Cygwin release.
>
> Heh, I was just about to email you with similar news! I had a look at
> my setup.log to see what I actually updated (and from what) and the
> only thing that seemed to make sense was an update of the cygwin .dll
> from v3.2.0-1 to v3.3.2-1 (I will add below an extract from my setup.log
> for that day, in case you see anything else of interest).

Having now spent far more time than I'd like wrangling the Cygwin build
infrastructure, I've found the change in the Cygwin code that introduced
the break. But I'm afraid progressing beyond this -- and in particular
making any sort of judgement about appropriate next steps -- is beyond
what I'm going to have time for in the foreseeable future.

(On the plus side, this has given me the kick to actually work out how
to do this sort of investigation, so if and when I get to investigating
the other test failures that also seem to be caused by changes in the
Cygwin environment, I now have a much better idea what I'm doing!)

Relevant commit is below:

https://cygwin.com/git/?p=newlib-cygwin.git;a=commitdiff;h=ef95c03522f65d5956a8dc82d869c6bc378ef3f9

commit ef95c03522f65d5956a8dc82d869c6bc378ef3f9 (HEAD, refs/bisect/bad)
Author: Corinna Vinschen <corinna@vinschen.de>
Date:   Tue Apr 6 21:35:43 2021 +0200

    Cygwin: select: Fix FD_CLOSE handling
    
    An FD_CLOSE event sets a socket descriptor ready for writing.
    This is incorrect if the FD_CLOSE is a result of shutdown(SHUT_RD).
    Only set the socket descriptor ready for writing if the FD_CLOSE
    is indicating an connection abort or reset error condition.
    
    This requires to tweak fhandler_socket_wsock::evaluate_events.
    FD_CLOSE in conjunction with FD_ACCEPT/FD_CONNECT special cases
    a shutdown condition by setting an error code.  This is correct
    for accept/connect, but not for select.  In this case, make sure
    to return with an error code only if FD_CLOSE indicates a
    connection error.
    
    Signed-off-by: Corinna Vinschen <corinna@vinschen.de>

diff --git a/winsup/cygwin/fhandler_socket_inet.cc b/winsup/cygwin/fhandler_socket_inet.cc
index bc08d3cf1..4ecb31a27 100644
--- a/winsup/cygwin/fhandler_socket_inet.cc
+++ b/winsup/cygwin/fhandler_socket_inet.cc
@@ -361,20 +361,30 @@ fhandler_socket_wsock::evaluate_events (const long event_mask, long &events,
 	  wsock_events->events |= FD_WRITE;
 	  wsock_events->connect_errorcode = 0;
 	}
-      /* This test makes accept/connect behave as on Linux when accept/connect
-         is called on a socket for which shutdown has been called.  The second
-	 half of this code is in the shutdown method. */
       if (events & FD_CLOSE)
 	{
-	  if ((event_mask & FD_ACCEPT) && saw_shutdown_read ())
+	  if (evts.iErrorCode[FD_CLOSE_BIT])
 	    {
-	      WSASetLastError (WSAEINVAL);
+	      WSASetLastError (evts.iErrorCode[FD_CLOSE_BIT]);
 	      ret = SOCKET_ERROR;
 	    }
-	  if (event_mask & FD_CONNECT)
+	  /* This test makes accept/connect behave as on Linux when accept/
+	     connect is called on a socket for which shutdown has been called.
+	     The second half of this code is in the shutdown method.  Note that
+	     we only do this when called from accept/connect, not from select.
+	     In this case erase == false, just as with read (MSG_PEEK). */
+	  if (erase)
 	    {
-	      WSASetLastError (WSAECONNRESET);
-	      ret = SOCKET_ERROR;
+	      if ((event_mask & FD_ACCEPT) && saw_shutdown_read ())
+		{
+		  WSASetLastError (WSAEINVAL);
+		  ret = SOCKET_ERROR;
+		}
+	      if (event_mask & FD_CONNECT)
+		{
+		  WSASetLastError (WSAECONNRESET);
+		  ret = SOCKET_ERROR;
+		}
 	    }
 	}
       if (erase)
diff --git a/winsup/cygwin/select.cc b/winsup/cygwin/select.cc
index 956cd9bc1..b493ccc11 100644
--- a/winsup/cygwin/select.cc
+++ b/winsup/cygwin/select.cc
@@ -1709,15 +1709,18 @@ peek_socket (select_record *me, bool)
   fhandler_socket_wsock *fh = (fhandler_socket_wsock *) me->fh;
   long events;
   /* Don't play with the settings again, unless having taken a deep look into
-     Richard W. Stevens Network Programming book.  Thank you. */
+     Richard W. Stevens Network Programming book and how these flags are
+     defined in Winsock.  Thank you. */
   long evt_mask = (me->read_selected ? (FD_READ | FD_ACCEPT | FD_CLOSE) : 0)
 		| (me->write_selected ? (FD_WRITE | FD_CONNECT | FD_CLOSE) : 0)
 		| (me->except_selected ? FD_OOB : 0);
   int ret = fh->evaluate_events (evt_mask, events, false);
   if (me->read_selected)
     me->read_ready |= ret || !!(events & (FD_READ | FD_ACCEPT | FD_CLOSE));
   if (me->write_selected)
-    me->write_ready |= ret || !!(events & (FD_WRITE | FD_CONNECT | FD_CLOSE));
+    /* Don't check for FD_CLOSE here.  Only an error case (ret == -1)
+       will set ready for writing. */
+    me->write_ready |= ret || !!(events & (FD_WRITE | FD_CONNECT));
   if (me->except_selected)
     me->except_ready |= !!(events & FD_OOB);
 
