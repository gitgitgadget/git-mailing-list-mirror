Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-3.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 50F6F20958
	for <e@80x24.org>; Wed, 22 Mar 2017 09:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1758949AbdCVJsE (ORCPT <rfc822;e@80x24.org>);
        Wed, 22 Mar 2017 05:48:04 -0400
Received: from smtp.ctxuk.citrix.com ([185.25.65.24]:25883 "EHLO
        SMTP.EU.CITRIX.COM" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1758632AbdCVJrn (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 22 Mar 2017 05:47:43 -0400
X-IronPort-AV: E=Sophos;i="5.36,204,1486425600"; 
   d="scan'208";a="42899076"
Date:   Wed, 22 Mar 2017 09:47:11 +0000
From:   Roger Pau =?iso-8859-1?Q?Monn=E9?= <roger.pau@citrix.com>
To:     <git@vger.kernel.org>
Subject: Re: Issues with git send-email and msmtp
Message-ID: <20170322094711.g53e2ok72cxg27ab@dhcp-3-128.uk.xensource.com>
References: <20170321154921.3jgn4ktcop4shct2@dhcp-3-128.uk.xensource.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20170321154921.3jgn4ktcop4shct2@dhcp-3-128.uk.xensource.com>
User-Agent: NeoMutt/20170306 (1.8.0)
X-ClientProxiedBy: AMSPEX02CAS02.citrite.net (10.69.22.113) To
 AMSPEX02CL02.citrite.net (10.69.22.126)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On Tue, Mar 21, 2017 at 03:49:21PM +0000, Roger Pau Monné wrote:
> Hello,
> 
> I'm trying to use git send-email with msmtp, and I have added the following to
> my .gitconfig:
> 
> [sendemail]
> 	smtpserver = "/usr/local/bin/msmtp"
> 
> This seems to work fine, except that sometimes git dies unexpectedly after
> queuing a patch to msmtp:
> 
> Died at /usr/local/Cellar/git/2.12.0/libexec/git-core/git-send-email line 1350, <FIN> line 3.
> 
> I'm guessing there's some kind of race, because this is not 100% reproducible,
> sometimes succeeds while others simply dies with the above message. As you can
> imagine, this is specially annoying when sending patch series.
> 
> Has someone seen similar issues when using send-email and msmtp? Am I missing
> something in my .gitconfig?

(switched to my @citrix.com address to prevent further bounces)

Hello,

Thanks for the help, and sorry to reply here (as some of you noted the
forwarding from address with SPF was broken and messages bounced). It seems
like this is a msmtp issue, more exactly msmtp doesn't handle SIGPIPE, and
AFAICT this leads to crashes when the server closes the connection before msmtp
does:

* thread #1: [...] stop reason = signal SIGPIPE
    frame #0: 0x00007fffd5c4d00a libsystem_kernel.dylib`__sendmsg + 10
libsystem_kernel.dylib`__sendmsg:
[...]
(lldb) bt
* thread #1: tid = 0x87c0f4, 0x00007fffd5c4d00a libsystem_kernel.dylib`__sendmsg + 10, queue = 'com.apple.main-thread', stop reason = signal SIGPIPE
  * frame #0: 0x00007fffd5c4d00a libsystem_kernel.dylib`__sendmsg + 10
    frame #1: 0x0000000101e5c69c libgnutls.30.dylib`system_writev + 41
    frame #2: 0x0000000101e3d1ba libgnutls.30.dylib`_gnutls_io_write_flush + 428
    frame #3: 0x0000000101e37689 libgnutls.30.dylib`_gnutls_send_tlen_int + 1222
    frame #4: 0x0000000101e5b78a libgnutls.30.dylib`gnutls_alert_send + 124
    frame #5: 0x0000000101e36f4f libgnutls.30.dylib`gnutls_bye + 86
    frame #6: 0x0000000101e1e8bc msmtp`tls_close([...]) + 28 at tls.c:1736 [opt]
    frame #7: 0x0000000101e1c382 msmtp`smtp_close([...]) + 34 at smtp.c:1905 [opt]
    frame #8: 0x0000000101e136ab msmtp`msmtp_sendmail [inlined] msmtp_endsession([...]) + 53 at msmtp.c:555 [opt]
    frame #9: 0x0000000101e13676 msmtp`msmtp_sendmail([...]) + 1558 at msmtp.c:1913 [opt]
    frame #10: 0x0000000101e183e6 msmtp`main([...]) + 5094 at msmtp.c:4157 [opt]
    frame #11: 0x00007fffd5b1e255 libdyld.dylib`start + 1
(lldb) c
Process 70391 resuming
Process 70391 exited with status = 0 (0x00000000) Terminated due to signal 13

This has nothing to do with git, I probably didn't realize before because I
guess mutt ignores this completely. I already sent a patch upstream.

Roger.
