From: Jeff King <peff@peff.net>
Subject: Re: error: git-remote-https died of signal 13
Date: Wed, 23 Apr 2014 02:59:38 -0400
Message-ID: <20140423065938.GB20675@sigill.intra.peff.net>
References: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Greg M <morenzg@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 23 08:59:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wcr9k-0006oO-Uy
	for gcvg-git-2@plane.gmane.org; Wed, 23 Apr 2014 08:59:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754031AbaDWG7k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Apr 2014 02:59:40 -0400
Received: from cloud.peff.net ([50.56.180.127]:36620 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753858AbaDWG7k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Apr 2014 02:59:40 -0400
Received: (qmail 19842 invoked by uid 102); 23 Apr 2014 06:59:40 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 23 Apr 2014 01:59:40 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 23 Apr 2014 02:59:38 -0400
Content-Disposition: inline
In-Reply-To: <CAEHyFQLmu4GWHcd+Xd6MOikf_LJgK0dGM7VXk6h6OLsud+-Wgw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/246811>

On Sun, Apr 20, 2014 at 08:42:15PM -0400, Greg M wrote:

> Using git version 1.9.2 I am getting this error:
> 
> [normal@laptop tmp]$ git clone https://github.com/mozilla/rust.git
> Cloning into 'rust'...
> remote: Reusing existing pack: 296648, done.
> remote: Counting objects: 80, done.
> remote: Compressing objects: 100% (77/77), done.
> remote: Total 296728 (delta 22), reused 9 (delta 3)
> Receiving objects: 100% (296728/296728), 110.68 MiB | 190.00 KiB/s, done.
> Resolving deltas: 100% (238828/238828), done.
> Checking connectivity... done.
> error: git-remote-https died of signal 13

Thanks for a thorough bug report. I looked through your strace output,
and this really does look like another case of OpenSSL getting SIGPIPE
while closing the connection.

It's odd, though, as your curl version has my patches, along with
similar extra fixes in 854aca5 (multi: ignore sigpipe internally,
2014-02-17). But I guess there may be a code path that needs similar
treatment.

The easiest way to find it is probably to attach a debugger to the
running git-remote-https, and get a backtrace when it dies from SIGPIPE.
You'll probably want to install your system's debug packages for curl,
too.

> I have curl version 7.36 though, in case some of the other output matters:
> 
> [normal@laptop tmp]$ curl --version
> curl 7.36.0 (x86_64-unknown-linux-gnu) libcurl/7.36.0 OpenSSL/1.0.1g
> zlib/1.2.8 libssh2/1.4.3

Another possibility is that your curl binary is up-to-date, but you are
linking against an older version of libcurl that does not have the
SIGPIPE workarounds.

I'm not sure of the best way to check that, but a hacky way under Linux
is:

  $ ldd $(git --exec-path)/git-remote-https | grep libcurl
          libcurl.so.4 => /usr/lib/x86_64-linux-gnu/libcurl.so.4
  $ strings  /usr/lib/x86_64-linux-gnu/libcurl.so.4 | grep '7\.'
  CLIENT libcurl 7.36.0

-Peff
