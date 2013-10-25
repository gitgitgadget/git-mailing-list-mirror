From: Jeff King <peff@peff.net>
Subject: [BUG] "git --literal-pathspecs blame" broken in master
Date: Thu, 24 Oct 2013 23:49:47 -0400
Message-ID: <20131025034947.GA4959@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Oct 25 05:49:56 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VZYPK-0000Zj-Ng
	for gcvg-git-2@plane.gmane.org; Fri, 25 Oct 2013 05:49:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755384Ab3JYDtu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 24 Oct 2013 23:49:50 -0400
Received: from cloud.peff.net ([50.56.180.127]:55210 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754415Ab3JYDtu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 24 Oct 2013 23:49:50 -0400
Received: (qmail 29323 invoked by uid 102); 25 Oct 2013 03:49:50 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 24 Oct 2013 22:49:50 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 24 Oct 2013 23:49:47 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236651>

There seems to be a bad interaction with --literal-pathspecs and the
pathspec magic that is in master. Here's an example:

  [setup]
  $ git init
  $ echo content >':(foo)bar'
  $ git add . && git commit -m foo

  [with git v1.8.4]
  $ git blame ':(foo)bar'
  ^6b07eb4 (Jeff King 2013-10-24 22:59:02 -0400 1) content
  $ git --literal-pathspecs blame ':(foo)bar'
  ^6b07eb4 (Jeff King 2013-10-24 22:59:02 -0400 1) content

So originally "blame" did not handle pathspec magic at all, and
--literal-pathspecs did nothing. So the former is arguably buggy, but
the latter did the right thing (if only by accident :) ).

Then along came 9a08727 (remove init_pathspec() in favor of
parse_pathspec(), 2013-07-14), and we get:

  $ git blame ':(foo)bar'
  fatal: Invalid pathspec magic 'foo' in ':(foo)bar'
  $ git --literal-pathspecs blame ':(foo)bar'
  fatal: Invalid pathspec magic 'foo' in ':(foo)bar'

The first is an improvement, because we are now consistent with other
pathspec handling in git. But the latter is a regression; we are not
respecting the literal pathspec flag.

We get another change with a16bf9d (pathspec: make --literal-pathspecs
disable pathspec magic, 2013-07-14), which I would think would fix
things, but doesn't.

  $ git blame ':(foo)bar'
  fatal: Invalid pathspec magic 'foo' in ':(foo)bar'
  $ git --literal-pathspecs blame ':(foo)bar'
  fatal: :(foo)bar: pathspec magic not supported by this command: 'literal'

The first one remains good, but the second one is still broken. I
haven't dug further yet, but I thought it might be a bit more obvious to
you.

-Peff
