From: Mike Hommey <mh@glandium.org>
Subject: Re: [PATCH] Makefile: do not compile git with debugging symbols by
 default
Date: Fri, 23 Jan 2015 00:09:14 +0900
Message-ID: <20150122150914.GA20135@glandium.org>
References: <1421931037-21368-1-git-send-email-kuleshovmail@gmail.com>
 <20150122130036.GC19681@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Alexander Kuleshov <kuleshovmail@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 22 16:09:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YEJOL-0004la-Jy
	for gcvg-git-2@plane.gmane.org; Thu, 22 Jan 2015 16:09:53 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751996AbbAVPJu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 22 Jan 2015 10:09:50 -0500
Received: from ks3293202.kimsufi.com ([5.135.186.141]:33308 "EHLO glandium.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750754AbbAVPJs (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 22 Jan 2015 10:09:48 -0500
Received: from glandium by zenigata with local (Exim 4.84)
	(envelope-from <glandium@glandium.org>)
	id 1YEJNi-0007cS-9t; Fri, 23 Jan 2015 00:09:14 +0900
Content-Disposition: inline
In-Reply-To: <20150122130036.GC19681@peff.net>
X-GPG-Fingerprint: 182E 161D 1130 B9FC CD7D  B167 E42A A04F A6AA 8C72
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262839>

On Thu, Jan 22, 2015 at 08:00:36AM -0500, Jeff King wrote:
> On Thu, Jan 22, 2015 at 06:50:37PM +0600, Alexander Kuleshov wrote:
> 
> > Standard user has no need in debugging information. This patch adds
> > DEBUG=1 option to compile git with debugging symbols and compile without
> > it by default.
> 
> This explanation is missing why it is beneficial _not_ to have the
> debugging information.
> 
> I expect the answer is "it makes the executable smaller". And that is
> true, but it gets smaller still if you run "strip" on the result:
> 
>   $ make CFLAGS= >/dev/null 2>&1 && wc -c <git
>   2424248
> 
>   $ make CFLAGS=-g >/dev/null 2>&1 && wc -c <git
>   4500816
> 
>   $ strip git && wc -c <git
>   2109200
> 
> So I am not sure who this is helping. If you are size-conscious, you
> should use strip, in which case the "-g" flag does not matter (and we
> even have "make strip" to help you).
> 
> Is there some other reason to avoid the debugging information?

Maybe this comes from the misconception that debugging information
changes the generated code, which, in fact, it doesn't.

  $ make CFLAGS=-g LDFLAGS=-Wl,--build-id=none >/dev/null 2>&1 && wc -c <git
  4432768
  $ strip --strip-debug git && wc -c < git
  2391120
  $ cp git git_
  $ make -j4 CFLAGS= LDFLAGS=-Wl,--build-id=none >/dev/null 2>&1 && wc -c <git
  2400192
  $ strip --strip-debug git && wc -c < git
  2391120
  $ diff -s git git_
  Files git and git_ are identical

LDFLAGS=-Wl,--build-id=none just avoids creating a .note.gnu.build-id
section containing a uuid that varies between builds. The 9k difference
between unstripped vs stripped for the no-debug-info case comes from the
removal of the few symbols for source file names (all the symbols from
readelf -s git | grep ABS).

Mike
