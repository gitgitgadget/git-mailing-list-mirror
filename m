From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Bug in fetch-pack causing ever-growing http requests. (Was: git
 fetch (http) hanging/failing on one specific repository, http only)
Date: Tue, 21 Oct 2014 11:48:28 +0200
Message-ID: <1413884908.4175.49.camel@seahawk>
References: <1413815355.4175.26.camel@seahawk>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Oct 21 11:48:41 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XgW3R-0001GI-JC
	for gcvg-git-2@plane.gmane.org; Tue, 21 Oct 2014 11:48:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932191AbaJUJsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Oct 2014 05:48:33 -0400
Received: from mail-lb0-f181.google.com ([209.85.217.181]:52970 "EHLO
	mail-lb0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932125AbaJUJsc (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Oct 2014 05:48:32 -0400
Received: by mail-lb0-f181.google.com with SMTP id l4so658852lbv.40
        for <git@vger.kernel.org>; Tue, 21 Oct 2014 02:48:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=Tu62oI3gkE2yY5ULAEY8uH38Kx9gGuTlHyrWZIjXulI=;
        b=RISkP5GORen3YKQmetUdGgFfDxs6k4nROqkIqNturwJ4nf3s4q5SqSiBGmjo7dmrYJ
         RE1uEq1tHUVC6SdkjDZySWiztzWj0kJ//LlkgGlyiL7KnvokhCEQAHOWGwWrU/9sn2iU
         d4VTZcJ+hWP1WjD8yvX9ZPLz+9oLT7U3VDAOhiPEVqh0SsYUYkeepWvuk6eBY3IqEf65
         XLUa1+IZHNYb4inKZR4y3//diF3eJ96nGcGEPqolGAu9w3lJgEcBuQ7rft1C3ofhn4IT
         zTc+/mCswQMcERbQZZZos017ghJOeOpcnhJk1FCVsuDVOGgq4If+Q3CkoL7XMq2TB+XM
         4NqA==
X-Gm-Message-State: ALoCoQmll1v26qHzv12rR5s/9VIajmTiB+oyle67U1sC6oys1YydBXFmbcH/ASh1R71YOJiNOVyc
X-Received: by 10.112.150.68 with SMTP id ug4mr15035057lbb.82.1413884910475;
        Tue, 21 Oct 2014 02:48:30 -0700 (PDT)
Received: from [10.155.73.62] (proxy-gw-l.booking.com. [5.57.20.8])
        by mx.google.com with ESMTPSA id l3sm4320696laa.37.2014.10.21.02.48.28
        for <git@vger.kernel.org>
        (version=SSLv3 cipher=RC4-SHA bits=128/128);
        Tue, 21 Oct 2014 02:48:29 -0700 (PDT)
In-Reply-To: <1413815355.4175.26.camel@seahawk>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On ma, 2014-10-20 at 16:29 +0200, Dennis Kaarsemaker wrote:
> Since a few days, one of our repos is causing problems during git fetch,
> basically git fetch over http hangs during find_common. When using ssh,
> this does not happen. 

<snip things that may not be relevant>.

> And for the hanging git-upload-pack:
> #0  0x00007f7c8034b4d0 in __write_nocancel () from /lib64/libpthread.so.0
> #1  0x000000000043c9dc in xwrite (fd=1, buf=0x6c70e0, len=56) at wrapper.c:170
> #2  0x000000000043ca5b in write_in_full (fd=1, buf=<value optimized out>, count=56) at wrapper.c:220
> #3  0x000000000043d019 in write_or_die (fd=<value optimized out>, buf=<value optimized out>, 
>     count=<value optimized out>) at write_or_die.c:61
> #4  0x00000000004131fa in packet_write (fd=1, fmt=<value optimized out>) at pkt-line.c:93
> #5  0x000000000040538c in get_common_commits (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:420
> #6  upload_pack (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:778
> #7  main (argc=<value optimized out>, argv=0x7fff00000001) at upload-pack.c:846
> 
> And the hanging git-http-backend:
> #0  0x00007f4c9553d4d0 in __write_nocancel () from /lib64/libpthread.so.0
> #1  0x000000000042d31c in xwrite (fd=4, buf=0x7fff394ea570, len=8192) at wrapper.c:170
> #2  0x000000000042d39b in write_in_full (fd=4, buf=<value optimized out>, count=8192) at wrapper.c:220
> #3  0x0000000000403e5d in inflate_request (prog_name=0x490d98 "upload-pack", out=4) at http-backend.c:305
> #4  0x000000000040405d in run_service (argv=0x7fff394ee6d0) at http-backend.c:355
> #5  0x00000000004041d2 in service_rpc (service_name=<value optimized out>) at http-backend.c:508
> #6  0x0000000000404b35 in main (argc=<value optimized out>, argv=<value optimized out>) at http-backend.c:631
> 
> Both git-http-backend and git-upload-pack are trying to write at the
> same time. I'm *guessing* I've hit some buffer limit here, given that
> the have/ack exchanges are increasing in size and suddenly this one is
> misbehaving. However I have no idea where to look next and would really
> appreciate some help.

I think the reasoning in 44d8dc54e73e8010c4bdf57a422fc8d5ce709029 is
incomplete: there's still a pipe involved in the case of gzip'ed request
bodies, and it's here that it hangs. However, I now do think that this
is merely a symptom, because after inspecting the output a bit further I
noticed that all reponses start with the same lines:

got ack 3 a669f13aab3a2c192c15574ead70f92b303e8aee
got ack 3 360530ff695a4deb01575e85976060a083e17245
got ack 3 bab20d62a5a4c34885cf2acbf83aca91908f9af8

In fact, response N, is the same as response N-1 plus acks for the
commits in the 'have' lines of the debug output for the next request. So
it looks like every request sends all common commits again, which seems
wrong but does explain the ever-growing request size. After commenting
out line 413 in fetch-pack.c (state_len = req_buf.len) the requests and
responses don't increase in size, and fetch completes, though the
received pack seems too large (http response is 400MB), which makes me
think it's not actually ack'ing. Subsequent HTTP fetches don't get a big
pack in response though, so maybe the pack is the right size. THis is a
*very* busy repo with thousands of commits between the last succesful
fetch 5 days ago and the first succesfil fetch after my hack.

In any case, I think there's a bug here, but I don't know nearly enough
about the protocol to judge if my "fix" is even close to correct. I've
also not tested my "fix" with any other protocol yet.

-- 
Dennis Kaarsemaker
http://www.kaarsemaker.net
