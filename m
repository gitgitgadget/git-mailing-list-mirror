From: David Borowitz <dave@bwitz.com>
Subject: HTTP push not respecting .netrc
Date: Wed, 29 Dec 2010 22:56:28 -0800
Message-ID: <AANLkTik84-zRwi+0dGGFoTUrj6Zr3bxO=fE9P_3MuZdZ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Dec 30 07:58:25 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PYCSu-0002Kp-9v
	for gcvg-git-2@lo.gmane.org; Thu, 30 Dec 2010 07:58:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751206Ab0L3G4u (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Dec 2010 01:56:50 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:46604 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751452Ab0L3G4t (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Dec 2010 01:56:49 -0500
Received: by wyb28 with SMTP id 28so10737491wyb.19
        for <git@vger.kernel.org>; Wed, 29 Dec 2010 22:56:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:mime-version:sender:received:from:date
         :x-google-sender-auth:message-id:subject:to:content-type;
        bh=0RUWvV/SvtAj6PZqUHdEaoaqdJXeIqcsnF9TD28FMGk=;
        b=L6qtNc179UGAc4ah6sni1OpjDxdQK9iFjCaFpytnRsmuvW0E5K+hTS4/XSUpAOxR3N
         dARP0ALe3BAdZpaNCvpHVcDok8l0KlULR/H3/WOsF4ftPwnrqktt3HReI4ZPZmL8Wzug
         xJm7vsePJfCH186hu2Vq9GTEkYZL7nSUzVIWI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:sender:from:date:x-google-sender-auth:message-id
         :subject:to:content-type;
        b=uQPB3mNZ0/tVl39FfkTrsci8MUX5TCFJg95DIKdSX+ssr5N8IWctRi7f7Aj+R0mtI2
         GaGc2Spoqsp9zHiRRM2KpLNStl+5JjffFGAB1UPoSbud3ePEhPxdjOr+D3qIMCG97gQ1
         WeqsxcN7KpKtKxKICm30SXeJaFn5jDdlzYP1Y=
Received: by 10.216.18.204 with SMTP id l54mr5975094wel.99.1293692208576; Wed,
 29 Dec 2010 22:56:48 -0800 (PST)
Received: by 10.216.189.31 with HTTP; Wed, 29 Dec 2010 22:56:28 -0800 (PST)
X-Google-Sender-Auth: pEgZwzBqrr3B2R0fUkd7IV7nCto
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164352>

Hi all,

I'm trying to push to a smart HTTP remote using the following command line:
http_proxy=localhost:4242 git push -v http://xxxxx:25989/git/foo
+refs/heads/*:refs/heads/*
(The weird proxy and port are not under my control.)

The webserver should return 401 for unauthorized access, and indeed it does:
error: RPC failed; result=65, HTTP code = 401
(The rest of the error text from git push is not particularly useful,
but I'm not worried about that at the moment.)

Making a request manually with curl --netrc shows that the auth header
is being sent[1]. But sniffing the HTTP traffic from git shows that
the auth header is not sent[2].

I also tried various other things like aliasing xxxxx to 127.0.0.1 and
removing the proxy and port number, and specifying user@xxxxx in the
URL, and nothing I've done makes git send the necessary auth header.
(In the last case it does prompt for a password.)

Anyone have any other ideas? I could swear this was working a few
weeks ago, so I must be missing something simple.

[1]
$ http_proxy=localhost:4242 curl -vvn
http://xxxxx:25989/git/foo/info/refs?service=git-receive-pack
* About to connect() to proxy localhost port 4242 (#0)
*   Trying ::1... Connection refused
*   Trying 127.0.0.1... connected
* Connected to localhost (127.0.0.1) port 4242 (#0)
* Server auth using Basic with user 'yyyyy'         <----
> GET http://xxxxx:25989/git/foo/info/refs?service=git-receive-pack HTTP/1.1
> Authorization: Basic zzzzzzzz          <----
> User-Agent: curl/7.19.7 (x86_64-pc-linux-gnu) libcurl/7.19.7 OpenSSL/0.9.8k zlib/1.2.3.3 libidn/1.15
> Host: xxxxx:25989
> Accept: */*
> Proxy-Connection: Keep-Alive
>
< HTTP/1.1 200 OK
...


[2]
GET http://xxxxx:25989/git/foo/info/refs?service=git-receive-pack HTTP/1.1
User-Agent: git/1.7.4.rc0
Host: xxxxx:25989
Accept: */*
Proxy-Connection: Keep-Alive
Pragma: no-cache
