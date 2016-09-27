Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-6.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,RP_MATCHES_RCVD
	shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id DDE9B1F4F8
	for <e@80x24.org>; Tue, 27 Sep 2016 10:26:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S933685AbcI0K04 (ORCPT <rfc822;e@80x24.org>);
        Tue, 27 Sep 2016 06:26:56 -0400
Received: from mail.pdinc.us ([67.90.184.27]:52537 "EHLO mail.pdinc.us"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932674AbcI0K0y (ORCPT <rfc822;git@vger.kernel.org>);
        Tue, 27 Sep 2016 06:26:54 -0400
Received: from black7 (nomaddigitalinc-1.border10.wdc002.pnap.net [64.94.31.206] (may be forged))
        (authenticated bits=0)
        by mail.pdinc.us (8.14.4/8.14.4) with ESMTP id u8RAQpVJ030457
        for <git@vger.kernel.org>; Tue, 27 Sep 2016 06:26:52 -0400
Reply-To: <git@vger.kernel.org>
From:   "Jason Pyeron" <jpyeron@pdinc.us>
To:     <git@vger.kernel.org>
References: <66A60DA77398CD439FA676CEF593977D692508@exchange.1.internal.pdinc.us> <62E3FC352BE4428A90D7E4E9B137A9FB@black7> <50DEA1C222E449F59BC8488C921D6F95@black7> <CAPc5daVdnuEfgNaeaGCymd3QWX7kfO3JQutVWmPOv1iMMzqCcA@mail.gmail.com>
In-Reply-To: <CAPc5daVdnuEfgNaeaGCymd3QWX7kfO3JQutVWmPOv1iMMzqCcA@mail.gmail.com>
Subject: RE: git-upload-pack hangs
Date:   Tue, 27 Sep 2016 06:27:00 -0400
Organization: PD Inc
Message-ID: <2AD8B9C4EF28416FB43A0B0B717EF2BE@black7>
MIME-Version: 1.0
Content-Type: text/plain;
        charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: Microsoft Office Outlook 11
Thread-Index: AdIYdj1AEYlvUCLiS2+L6hsWhbxjLgALomNg
X-MimeOLE: Produced By Microsoft MimeOLE V6.1.7601.17609
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Thanks, I wrote this while on a train to get the site up 1st, I did not even review it yet! 

I think I am going to spend the time this weekend to clean it up, and submit a patch for master and the version cygwin uses.

-Jason

> -----Original Message-----
> From: jch2355@gmail.com [mailto:jch2355@gmail.com] On Behalf 
> Of Junio C Hamano
> Sent: Tuesday, September 27, 2016 00:18
> To: Jason Pyeron
> Subject: Re: git-upload-pack hangs
> 
> Not a review, but size_t is an unsigned type, so specifying -1 as a
> fallback value,
> or comparing it with -1, does not make much sense.  Perhaps 
> use ssize_t?
> 
> On Mon, Sep 26, 2016 at 8:45 PM, Jason Pyeron 
> <jpyeron@pdinc.us> wrote:
> > This is a very, very first draft.
> >
> > It is allowing IIS to work right now.
> >
> > I still need to address chunked issues, where there is no 
> content length (see 
> http://www.gossamer-threads.com/lists/apache/users/373042)
> >
> > Any comments, sugestions?
> >
> > -Jason
> >
> > --- ./origsrc/git-v2.8.3/http-backend.c 2016-05-18 
> 18:32:41.000000000 -0400
> > +++ ./src/git-v2.8.3/http-backend.c     2016-09-26 
> 22:52:02.636135000 -0400
> > @@ -279,14 +279,17 @@
> >  {
> >         size_t len = 0, alloc = 8192;
> >         unsigned char *buf = xmalloc(alloc);
> > +       /* get request size */
> > +       size_t req_len = git_env_ulong("CONTENT_LENGTH", -1);
> >
> >         if (max_request_buffer < alloc)
> >                 max_request_buffer = alloc;
> >
> > -       while (1) {
> > +       while (req_len>0 || req_len==-1 ) {
> > +               ssize_t maxread=alloc>req_len && 
> req_len!=-1?req_len:alloc;
> >                 ssize_t cnt;
> >
> > -               cnt = read_in_full(fd, buf + len, alloc - len);
> > +               cnt = read_in_full(fd, buf + len, maxread - len);
> >                 if (cnt < 0) {
> >                         free(buf);
> >                         return -1;
> > @@ -294,13 +297,19 @@
> >
> >                 /* partial read from read_in_full means we 
> hit EOF */
> >                 len += cnt;
> > -               if (len < alloc) {
> > +               if (len < maxread) {
> >                         *out = buf;
> >                         return len;
> >                 }
> >
> > +               if (req_len>0) {
> > +                       req_len -= cnt;
> > +                       if (req_len<0)
> > +                               req_len=0;
> > +               }
> > +
> >                 /* otherwise, grow and try again (if we can) */
> > -               if (alloc == max_request_buffer)
> > +               if (alloc == max_request_buffer && maxread == alloc)
> >                         die("request was larger than our 
> maximum size (%lu);"
> >                             " try setting 
> GIT_HTTP_MAX_REQUEST_BUFFER",
> >                             max_request_buffer);
> > @@ -310,6 +319,10 @@
> >                         alloc = max_request_buffer;
> >                 REALLOC_ARRAY(buf, alloc);
> >         }
> > +
> > +       free(buf);
> > +
> > +       return len;
> >  }
> >
> >  static void inflate_request(const char *prog_name, int 
> out, int buffer_input)
> >
> >
> >> -----Original Message-----
> >> From: git-owner@vger.kernel.org
> >> [mailto:git-owner@vger.kernel.org] On Behalf Of Jason Pyeron
> >> Sent: Monday, September 26, 2016 09:26
> >> To: git@vger.kernel.org
> >> Subject: RE: git-upload-pack hangs
> >>
> >> > -----Original Message-----
> >> > From: Jason Pyeron
> >> > Sent: Monday, September 26, 2016 01:51
> >> >
> >> > git is hanging on clone. I am runnig (cygwin) git 2.8.3 on
> >> > IIS7 (windows server 2012 R2).
> >> >
> >> > Where can I start to perform additional debugging?
> >> >
> >>
> >> Reading this thread, it seems plausible as a cause since it
> >> aligns with my testing.
> >>
> >> http://www.spinics.net/lists/git/msg279437.html [ and
> >> http://www.spinics.net/lists/git/attachments/binQFGHirNLw3.bin ]
> >>
> >> I will start to trudge into the code to see if this (or
> >> similar) has been applied and if not, does it fix it.
> >>
> >> > Selected items I have read, but they did not help:
> >> >
> >> > http://unix.stackexchange.com/questions/98959/git-upload-pack-
> >> > hangs-indefinitely
> >> >
> >> > https://sparethought.wordpress.com/2012/12/06/setting-git-to-w
> >> ork-behind-ntlm-authenticated-proxy-cntlm-to-the-rescue/
> >> >
> >> > https://sourceforge.net/p/cntlm/bugs/24/
> >> >
> >> > invocation of the clone:
> >> >
> >> > jpyeron.adm@SERVER /tmp
> >> > $ GIT_TRACE=1  GIT_CURL_VERBOSE=true git clone
> >> > http://SERVER.domain.com/git/test.git
> >> > 01:23:37.020476 git.c:350               trace: built-in: git
> >> > 'clone' 'http://SERVER.domain.com/git/test.git'
> >> > Cloning into 'test'...
> >> > 01:23:37.206046 run-command.c:336       trace: run_command:
> >> > 'git-remote-http' 'origin' 
> 'http://SERVER.domain.com/git/test.git'
> >> > * STATE: INIT => CONNECT handle 0x60009a140; line 1397
> >> > (connection #-5000)
> >> > * Couldn't find host SERVER.domain.com in the .netrc file;
> >> > using defaults
> >> > * Added connection 0. The cache now contains 1 members
> >> > *   Trying ::1...
> >> > * TCP_NODELAY set
> >> > * STATE: CONNECT => WAITCONNECT handle 0x60009a140; line 1450
> >> > (connection #0)
> >> > * Connected to SERVER.domain.com (::1) port 80 (#0)
> >> > * STATE: WAITCONNECT => SENDPROTOCONNECT handle 0x60009a140;
> >> > line 1557 (connection #0)
> >> > * Marked for [keep alive]: HTTP default
> >> > * STATE: SENDPROTOCONNECT => DO handle 0x60009a140; line 1575
> >> > (connection #0)
> >> > > GET /git/test.git/info/refs?service=git-upload-pack HTTP/1.1
> >> > Host: SERVER.domain.com
> >> > User-Agent: git/2.8.3
> >> > Accept: */*
> >> > Accept-Encoding: gzip
> >> > Accept-Language: en-US, *;q=0.9
> >> > Pragma: no-cache
> >> >
> >> > * STATE: DO => DO_DONE handle 0x60009a140; line 1654 
> (connection #0)
> >> > * STATE: DO_DONE => WAITPERFORM handle 0x60009a140; line 1781
> >> > (connection #0)
> >> > * STATE: WAITPERFORM => PERFORM handle 0x60009a140; line 1791
> >> > (connection #0)
> >> > * HTTP 1.1 or later with persistent connection, 
> pipelining supported
> >> > < HTTP/1.1 200 OK
> >> > < Cache-Control: no-cache, max-age=0, must-revalidate
> >> > < Pragma: no-cache
> >> > < Content-Type: application/x-git-upload-pack-advertisement
> >> > < Expires: Fri, 01 Jan 1980 00:00:00 GMT
> >> > * Server Microsoft-IIS/8.5 is not blacklisted
> >> > < Server: Microsoft-IIS/8.5
> >> > < X-Powered-By: ASP.NET
> >> > < Date: Mon, 26 Sep 2016 05:23:37 GMT
> >> > * Marked for [closure]: Connection: close used
> >> > < Connection: close
> >> > < Content-Length: 310
> >> > <
> >> > * STATE: PERFORM => DONE handle 0x60009a140; line 1955
> >> (connection #0)
> >> > * multi_done
> >> > * Curl_http_done: called premature == 0
> >> > * Closing connection 0
> >> > * The cache now contains 0 members
> >> > 01:23:37.688252 run-command.c:336       trace: run_command:
> >> > 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack'
> >> > '--thin' '--check-self-contained-and-connected' '--cloning'
> >> > 'http://SERVER.domain.com/git/test.git/'
> >> > 01:23:37.717168 exec_cmd.c:120          trace: exec: 'git'
> >> > 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack'
> >> > '--thin' '--check-self-contained-and-connected' '--cloning'
> >> > 'http://SERVER.domain.com/git/test.git/'
> >> > 01:23:37.749820 git.c:350               trace: built-in: git
> >> > 'fetch-pack' '--stateless-rpc' '--stdin' '--lock-pack'
> >> > '--thin' '--check-self-contained-and-connected' '--cloning'
> >> > 'http://SERVER.domain.com/git/test.git/'
> >> > * STATE: INIT => CONNECT handle 0x60009a140; line 1397
> >> > (connection #-5000)
> >> > * Couldn't find host SERVER.domain.com in the .netrc file;
> >> > using defaults
> >> > * Added connection 1. The cache now contains 1 members
> >> > * Hostname SERVER.domain.com was found in DNS cache
> >> > *   Trying ::1...
> >> > * TCP_NODELAY set
> >> > * STATE: CONNECT => WAITCONNECT handle 0x60009a140; line 1450
> >> > (connection #1)
> >> > * Connected to SERVER.domain.com (::1) port 80 (#1)
> >> > * STATE: WAITCONNECT => SENDPROTOCONNECT handle 0x60009a140;
> >> > line 1557 (connection #1)
> >> > * Marked for [keep alive]: HTTP default
> >> > * STATE: SENDPROTOCONNECT => DO handle 0x60009a140; line 1575
> >> > (connection #1)
> >> > > POST /git/test.git/git-upload-pack HTTP/1.1
> >> > Host: SERVER.domain.com
> >> > User-Agent: git/2.8.3
> >> > Accept-Encoding: gzip
> >> > Content-Type: application/x-git-upload-pack-request
> >> > Accept: application/x-git-upload-pack-result
> >> > Content-Length: 140
> >> >
> >> > * upload completely sent off: 140 out of 140 bytes
> >> > * STATE: DO => DO_DONE handle 0x60009a140; line 1654 
> (connection #1)
> >> > * STATE: DO_DONE => WAITPERFORM handle 0x60009a140; line 1781
> >> > (connection #1)
> >> > * STATE: WAITPERFORM => PERFORM handle 0x60009a140; line 1791
> >> > (connection #1)
> >>
> >> --
> >> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >> -                                                               -
> >> - Jason Pyeron                      PD Inc. http://www.pdinc.us -
> >> - Principal Consultant              10 West 24th Street #100    -
> >> - +1 (443) 269-1555 x333            Baltimore, Maryland 21218   -
> >> -                                                               -
> >> -=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-=-
> >>
> >>
> >>
> >
> 

