From: Shawn Pearce <spearce@spearce.org>
Subject: Re: git smart protocol via WebSockets - feedback wanted
Date: Tue, 5 Jun 2012 14:11:29 -0700
Message-ID: <CAJo=hJtSow1pBQ8d26NBdrmay7aEHP6btdspQ4YsjLtZWQt1TA@mail.gmail.com>
References: <jqlim2$6vt$1@dough.gmane.org> <7vpq9dobjo.fsf@alter.siamese.dyndns.org>
 <jqljtk$h6d$1@dough.gmane.org> <CAJo=hJue20kwo-jo8x8dC7AUVs3oP=ZC9aCq_ncq3+MWr9VmgQ@mail.gmail.com>
 <jqlml0$83h$1@dough.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: git@vger.kernel.org
To: Stephan Peijnik <stephan@peijnik.at>
X-From: git-owner@vger.kernel.org Tue Jun 05 23:12:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sc12h-0004m8-KF
	for gcvg-git-2@plane.gmane.org; Tue, 05 Jun 2012 23:11:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752054Ab2FEVLv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Jun 2012 17:11:51 -0400
Received: from mail-pb0-f46.google.com ([209.85.160.46]:41954 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751189Ab2FEVLt (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Jun 2012 17:11:49 -0400
Received: by pbbrp8 with SMTP id rp8so7976488pbb.19
        for <git@vger.kernel.org>; Tue, 05 Jun 2012 14:11:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=spearce.org; s=google;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=k+E+TF6b7m7WaUtEbCjkmN+qJvGgYmbEnuwRNHTkM2w=;
        b=NPUA6in+8d3ZUZu9T+OLZ8CuVhfcL7P7HyudfrCEDJltNZjvCoeFpEwMI47tTElGBr
         kjBRJrRTFadS29gn27OPnicEfKpLZl8zoF+X6kZRm/LCtM+Cev2M/+sdu6/sI9VBKjGI
         D7ZbM2mTFsv9J12UPIO6AeGhbWj6ebM6iQD0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type:x-gm-message-state;
        bh=k+E+TF6b7m7WaUtEbCjkmN+qJvGgYmbEnuwRNHTkM2w=;
        b=LuCKC2Ih2mqo5s2oAC9U02dK5l/Nste1r3SZdBSU9esLKmUhH6ACdq9FaYSvGHQmoF
         ZAa2jcVDQ4vY8siQTuyV/ZkCm8ixNMBZhnC9DXd3Xva00Y02KIOJ2/Nn1vqPFEIo4b8c
         AqrxzceM8MuCiUWwq1uR1tno4A2YoShcExHCgXHCtlL7VKrgAdWEhuPw2GT0rcUpkH1a
         cS53Q4rM0VWwvHlYk1UyblT/qfvSf+lwyM96ymcDW2zmPfeGS16XDpAlRrLeG/jZCPmC
         gXE17NXvvTvDoI/XXp+F6/eO0sPYUgdbZpzcRR41/idFSdDDWZ9lMRYuKya5eZtUEcki
         c/hQ==
Received: by 10.68.223.138 with SMTP id qu10mr15182923pbc.50.1338930709298;
 Tue, 05 Jun 2012 14:11:49 -0700 (PDT)
Received: by 10.68.52.169 with HTTP; Tue, 5 Jun 2012 14:11:29 -0700 (PDT)
In-Reply-To: <jqlml0$83h$1@dough.gmane.org>
X-Gm-Message-State: ALoCoQkutttU7EEpI2VXqDlLCzCV8vo8ER/qe9HDiLaHAO6yQXd0hq+NtCSD95I6iUMtwfBOFgrm
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199291>

On Tue, Jun 5, 2012 at 12:28 PM, Stephan Peijnik <stephan@peijnik.at> wrote:
> On 06/05/2012 08:54 PM, Shawn Pearce wrote:
>>
>> Its actually only one TCP connection... assuming the servers in
>> between the client and the Git endpoint correctly support HTTP
>> keep-alive semantics.
>
> With keep-alive that is true, but a quick check on the actual data exchange
> tells me that multiple HTTP requests are still needed. But I guess the
> overhead caused by a second HTTP requests can be ignored.

There is extra overhead from the HTTP request headers, this is true.
Fortunately its relatively small and bounded.

There isn't that much additional latency in the smart HTTP protocol.
Where the client is waiting on data from the server is where we end an
HTTP request and start a new one. The mulit_ack capability on normal
TCP or SSH connections does get to interleave a bit more in the native
protocol to try and hide the RTT latency. I don't know that anyone has
done extensive testing to determine how effective that is vs. the
batch sizes we run in the HTTP POST format. With the key part being
how quickly the overall negotiation exchange went for the end-user.

Colby Ranger's recent contribution to contrib/persistent-https
provides a local proxy server for Git over HTTP that tries to reuse
HTTP connections across Git command invocations. This can go further
than even git:// does with TCP connection reuse, cutting latency. Of
course a user can do the same thing with their own local HTTP proxy,
but persistent-https can be easier to install and configure.

>> How does this fair going through crappy proxy servers that perform
>> man-in-the-middle attacks on SSL connections? Just last week I was
>> trying to help someone whose local proxy server was MITM the SSL
>> session behind Git's back, and their IT department forgot to install
>> the proxy server's certificate into the system certificate directory.
>> They only installed it into the browser. That proxy also doesn't
>> correctly grok HTTP 1.1 keep-alive with chunked transfer encodings.
>> Let alone something as new as web sockets.
>
> Proxy servers could be an issue, yes. For proxy servers not acting as MITM
> and which are supporting CONNECT this shouldn't be an issue though.

I am still annoyed by the failure of "Expect: 100-continue". The
original smart HTTP protocol used this during push to try and avoid
sending a 100 MiB POST payload before finding out authentication is
required and failing. It turns out far too many HTTP servers and proxy
servers do not correctly implement 100-continue to rely on it in the
protocol, so we had to back that out and use a special POST body with
4 bytes to "probe" the remote server before sending the full payload.

100-continue is in RFC 2616, dated June 1999. My calendar says June
2012. So 13 years later and we still cannot rely on 100-continue as
specified by RFC 2616 working correctly on the public Internet.

Chunked Transfer-Encoding is described in RFC 2038, dated Jan 1997 and
is the RFC that RFC 2616 made obsolete. This is still not working
reliable everywhere... 15 years after being specified proxy servers
are still converting chunked transfer encoding to "Connection: close"
and destroying any HTTP keep-alive that might have been possible.

Basically I learned a lot in the past 2 years deploying Git on a
rather broad scale with HTTP. The public Internet doesn't resemble the
standards enough, and you really have to code to the lowest common
denominator, because there is some user out there that matters to you
who is stuck behind some HTTP proxy that implements the HTTP standard
as it existed in 1995 and whose managers/suppliers refuse to bring
forward to the current century.

> Also, given the current HTML5 hype things should get better in the future,
> but you are correct about potential current issues with the approach.

WebSockets seems pretty full of fail to me.

The protocol specification is really complex. Its reimplementing TCP
on top of HTTP to work around an artificial browser imposed limitation
on the number of suggested HTTP connections the browser opens to the
server. Meanwhile SPDY goes the other direction and tries to support
multiplexing a larger number of HTTP requests into a single TCP
connection, while reusing a lot of header data across those requests.
I have higher hopes for SPDY adoption than for WebSockets. SPDY solves
a lot of common problems on the Internet that social networking sites
care about, like time to load assets for a game, or that publishers
care about, like time to load all assets for a site on initial visit,
increasing the chances the user doesn't immediately jump away due to
perceived high loading time.

WebSockets is a large amount of wanking to make playing a game written
in JavaScript easier, using a very ugly protocol, and a much more
complex software stack. I think the WebSockets authors saw the problem
of HTTP connections in a browser and solved it the wrong way. They saw
the bidirectional stream problem... and solved it for a very narrow
use case. SPDY also relies on a bidirectional stream, but it lets the
server do more, like suggest pushing assets down ahead of the browser
realizing it needs them.

>>> So in comparison there is possibly a lot less overhead and, in theory,
>>> the
>>> performance should be comparable to running the smart protocol over ssh.
>>> Personally I'd say the WebSocket approach is cleaner than the HTTP-POST
>>> approach.
>>
>> This may be true. But its also a lot more complex to implement. I
>> noticed you reused Python code to help make this work.
>
> The only reason I used Python is that I wanted to quickly come up with a
> prototype. I am also aware of the fact that a proper implementation should
> possibly be done in C.

Any implementation of a new embedding of the Git protocol into e.g.
WebSockets also requires implementing it in Java for JGit, both client
and server, and probably also in Python for Dulwich, again client and
server. Given that WebSockets is all about cramming TCP into HTTP in
SSL in TCP, and doesn't always work on the public Internet given the
current state of proxy servers, I just don't see the value in this.

We have to provide complete support across the major Git
implementations, otherwise users will come to this mailing list and
complain about how implementation $X cannot talk to server running $Y
because server owner $Z only configured the new fangled WebSockets
protocol. And I am simply too lazy to write a procmail script to
direct all such inquiries to your address.

>> Let me know when there is a GPLv2 client library that implements
>> sufficient
>> semantics for WebSockets that Git can bundle it out of the box.
>
> As for the WebSocket client library that is GPLv2 compatible: there is at
> least libwebsockets [0], which is licensed under the terms of the LGPL v2.1,
> and as such GPLv2 only compatible.

OK, yay. Someone actually bothered to implement this?

>> And let me know when most corporate IT proxy servers correctly grok
>> WebSockets. I suspect it will be many more years given that they still
>> can't even grok chunked transfer encoding.
>
> As stated above, this could be a problem, yes.
> The question is whether one only wants to provide an alternative approach
> when it is usable for everyone.

I predict WebSockets will be usable by everyone about... never. Its
too complex of a standard, and too narrow of a corner case. We are
talking about proxy servers that can't do 100-continue correctly,
because async network IO was too hard for them to code. Those authors
and their software will never support WebSockets' bidirectional
requirement. WebSockets isn't critical to browse the web. It never
will be. 100-continue might be useful with form based file uploads,
which are at least 100x more common on the web than a WebSocket
powered thing. Seriously. Call me when WebSockets is actually working.
I'd like to come back and see what the world looks like in 2152.

> My intention never was to have the current http implementation, be it the
> dumb or http-backend one, replaced. The idea here was to provide an
> additional option that makes use of a fairly new technology, with all
> benefits and drawbacks of using something new.

You are free to develop your own remote helper that does this. But I
don't expect any Git distribution or implementation to be supporting
it.
