From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 2/3] add basic lua infrastructure
Date: Tue, 25 Sep 2012 00:53:45 -0400
Message-ID: <20120925045345.GA5708@sigill.intra.peff.net>
References: <20120925002325.GA19560@sigill.intra.peff.net>
 <20120925002511.GB19605@sigill.intra.peff.net>
 <CACsJy8ArwPq=YRAddVtC+m8X0+=tndb2-=tmiMS=m2VX3TWGYg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 25 06:53:57 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TGN9h-0001fl-7h
	for gcvg-git-2@plane.gmane.org; Tue, 25 Sep 2012 06:53:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752118Ab2IYExs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 25 Sep 2012 00:53:48 -0400
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:57629 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751327Ab2IYExr (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Sep 2012 00:53:47 -0400
Received: (qmail 11139 invoked by uid 107); 25 Sep 2012 04:54:14 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 25 Sep 2012 00:54:14 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 25 Sep 2012 00:53:45 -0400
Content-Disposition: inline
In-Reply-To: <CACsJy8ArwPq=YRAddVtC+m8X0+=tndb2-=tmiMS=m2VX3TWGYg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/206346>

On Tue, Sep 25, 2012 at 08:55:23AM +0700, Nguyen Thai Ngoc Duy wrote:

> On Tue, Sep 25, 2012 at 7:25 AM, Jeff King <peff@peff.net> wrote:
> > +ifdef USE_LUA
> > +       BASIC_CFLAGS += -DUSE_LUA `pkg-config --cflags lua5.2`
> > +       EXTLIBS += `pkg-config --libs lua5.2`
> > +endif
> > +
> 
> I remember we paid noticeable penalty when linking with libcurl to
> main git binary and Linus removed libcurl from main git, moving it to
> git-http-*. Do we pay similar penalty linking to liblua?

I don't think so. The real problem with libcurl is that it brings in a
ton of other libraries:

  $ ldd /usr/lib/x86_64-linux-gnu/libcurl.so | awk '{print $1}'
  linux-vdso.so.1
  libidn.so.11
  libssh2.so.1
  liblber-2.4.so.2
  libldap_r-2.4.so.2
  librt.so.1
  libgssapi_krb5.so.2
  libssl.so.1.0.0
  libcrypto.so.1.0.0
  librtmp.so.0
  libz.so.1
  libc.so.6
  libgcrypt.so.11
  libresolv.so.2
  libsasl2.so.2
  libgnutls.so.26
  libpthread.so.0
  /lib64/ld-linux-x86-64.so.2
  libkrb5.so.3
  libk5crypto.so.3
  libcom_err.so.2
  libkrb5support.so.0
  libdl.so.2
  libkeyutils.so.1
  libgpg-error.so.0
  libtasn1.so.3
  libp11-kit.so.0

Compare with lua:

  $ ldd /usr/lib/x86_64-linux-gnu/liblua5.2.so | awk '{print $1}'
  linux-vdso.so.1
  libm.so.6
  libdl.so.2
  libc.so.6
  /lib64/ld-linux-x86-64.so.2

The original timings from Linus are here:

  http://article.gmane.org/gmane.comp.version-control.git/123946

The main issue is really hitting all those libraries on a cold cache.
Here are before-and-after timings of:

  echo 3 >/proc/sys/vm/drop_caches && git

which should basically just measure startup time. All times are
best-of-five.

  [before]
  real    0m0.065s
  user    0m0.000s
  sys     0m0.004s

  [after]
  real    0m0.063s
  user    0m0.000s
  sys     0m0.004s

So we actually did better, though the difference is well within the
run-to-run noise. I don't think it's a big deal.

-Peff
