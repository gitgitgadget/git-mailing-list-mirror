From: Eric Wong <normalperson@yhbt.net>
Subject: git+http:// proof-of-concept (not using CONNECT)
Date: Thu, 2 Jul 2009 01:54:40 -0700
Message-ID: <20090702085440.GC11119@dcvr.yhbt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 02 10:54:52 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MMI4B-0003qR-Sg
	for gcvg-git-2@gmane.org; Thu, 02 Jul 2009 10:54:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751090AbZGBIyl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 2 Jul 2009 04:54:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750770AbZGBIyk
	(ORCPT <rfc822;git-outgoing>); Thu, 2 Jul 2009 04:54:40 -0400
Received: from dcvr.yhbt.net ([64.71.152.64]:34573 "EHLO dcvr.yhbt.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750702AbZGBIyj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 2 Jul 2009 04:54:39 -0400
Received: from localhost (user-118bg3p.cable.mindspring.com [66.133.192.121])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by dcvr.yhbt.net (Postfix) with ESMTPSA id 19EF41F78F;
	Thu,  2 Jul 2009 08:54:42 +0000 (UTC)
Content-Disposition: inline
User-Agent: Mutt/1.5.18 (2008-05-17)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/122630>

I've been toying around with an HTTP server for various things over the
past few months and a few weeks ago I came up with the idea of tunneling
arbitrary stream protocols over HTTP with "Transfer-Encoding: chunked"
bodies on both ends.  This allowed me to tunnel the git:// protocol
among other things over something that may conform to RFC 2616.

To facilitate this, curl needed only one minor modification (now in
their CVS repository) to make stdin with "-T-" non-blocking:

  http://cool.haxx.se/cvs.cgi/curl/src/main.c.diff?r1=1.520&r2=1.521

Since git clone already supports proxy commands via GIT_PROXY_COMMAND, I
just created a one line shell script to use as GIT_PROXY_COMMAND.  No
modifications were needed to git itself on either end:

cat > /path/to/script <<\EOF
#!/bin/sh
exec curl --no-buffer -sSfT- http://$1:$2/
EOF

chmod +x /path/to/script
GIT_PROXY_COMMAND=/path/to/script
export GIT_PROXY_COMMAND

# Then, to test it on a small project on my server:
git clone git://git.bogomips.org:8080/pcu

# Of course, a larger project like git should work, too:
git clone git://git.bogomips.org:8080/mirrors/git

Hopefully it doesn't blow up or die on you, this is only lightly
tested.  Let me know if you manage to break it permanently.


The origin server I'm running for this is the latest release of
Unicorn[2], which supports sending a chunked HTTP response as it is
receiving a chunked request.  Unicorn just dechunks the request and
pipes it to git-daemon.  When git-daemon writes to stdout, Unicorn just
grabs the output and chunks it (via Rack[3] middleware) for the client.


This doesn't work in the face of most HTTP-aware proxies[1], so it
probably doesn't help those who have trouble accessing git:// servers in
the first place...  However, this could potentially be useful in places
where a proxy providing CONNECT is not available.


[1] - I run nginx on port 80 on bogomips.org and nginx (attempts to)
fully buffer all requests before proxying it to the backend, so it
definitely won't fly here.  HTTP proxies are perfectly alright with
taking chunked requests/responses and remove chunking on them (or
vice versa).

[2] - http://unicorn.bogomips.org/
[3] - http://rack.rubyforge.org/

-- 
Eric Wong
