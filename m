From: Phil Hord <phil.hord@gmail.com>
Subject: https_proxy and libcurl
Date: Fri, 22 Feb 2013 16:19:10 -0500
Message-ID: <CABURp0qQ6tO0B4Ya6OStX59SJqG-Jx1F4g6MUL7tVwR_6VgDhw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Feb 22 22:20:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U902A-0004yc-Du
	for gcvg-git-2@plane.gmane.org; Fri, 22 Feb 2013 22:19:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757028Ab3BVVTd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Feb 2013 16:19:33 -0500
Received: from mail-vb0-f54.google.com ([209.85.212.54]:47617 "EHLO
	mail-vb0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755691Ab3BVVTc (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Feb 2013 16:19:32 -0500
Received: by mail-vb0-f54.google.com with SMTP id l1so687379vba.27
        for <git@vger.kernel.org>; Fri, 22 Feb 2013 13:19:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=kT4Za5T/GgZbFIr50c6gWR4i7Vuj4f0XfFkkNTu0uMc=;
        b=ELnCJFHFMA/63gmdn3Hs+gASulWMh686A1abJAxDtYTT7h8r6+fG1rYhR6Aiqj0DUH
         KAhidSTezkzkL+rQlN/C9kAbLh6baiQEkFgXUzJkkeSfAsEdIzTthIcYDzl8P3gCZicN
         pzkoEqZi+wBd3jb8eJAul5eyYEOZqPRVmLZZ5oQNqGXMt5EHo+grz5KXSGAxQrCn++b9
         kNXczSM+a2MGcsBb2vz+Nx7yl3k4h03/Ev+olyiAYfGRpQyl0xoedeXwL/ZxGB08ptr9
         FaGMtanFjZv9BR8I6QH3osCVYq96c8h1k6RrupkQG73hQKWRyvk2SpaOAQM4xrxXBMfy
         Es3A==
X-Received: by 10.52.69.232 with SMTP id h8mr4221840vdu.26.1361567970946; Fri,
 22 Feb 2013 13:19:30 -0800 (PST)
Received: by 10.58.201.103 with HTTP; Fri, 22 Feb 2013 13:19:10 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216863>

I have been unable to clone via http proxy because of a wrongly
configured proxy setup in my lab.

I had this env:

    http_proxy=http://proxy.myco.com
    https_proxy=https://proxy.myco.com

The problem is that libcurl ignores the protocol part of the proxy
url, and it defaults to port 1080. wget honors the protocol specifier,
but it defaults to port 80 if none is given.

So, I thought my env was equivalent to this:

    http_proxy=proxy.myco.com:80
    https_proxy=proxy.myco.com:443

So it is with wget.  But with curl, it is equivalent to this:

    http_proxy=proxy.myco.com:1080
    https_proxy=proxy.myco.com:1080

Git clone gave a confusing (but correct) error message:

    $ export https_proxy=https://proxy.myco.com
    $ git clone https://github.com/git/git
    Cloning into 'git'...
    error: The requested URL returned error: 500 while accessing
https://github.com/git/git/info/refs?service=git-upload-pack
    fatal: HTTP request failed


If I didn't have https_proxy set at all, I got a long timeout as it
tried to connect directly and ran into our firewall.

    $ unset https_proxy
    $ git clone https://github.com/git/git
    Cloning into 'git'...
    error: Failed connect to github.com:443; Connection timed out
while accessing
https://github.com/git/git/info/refs?service=git-upload-pack
    fatal: HTTP request failed

This also did not help, of course:
    'git config http.proxy https://proxy.myco.com'

But this did:
    'git config http.proxy https://proxy.myco.com:443'


The fix was to specify the port explicitly, like this:

    http_proxy=proxy.myco.com:80
    https_proxy=proxy.myco.com:443

Phil

[1] An added wrinkle is that there is a proxy server listening on
1080, but it does not support encrypted connections.  A listener on
443 does handle https requests correctly.
