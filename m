From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v3 0/2] Correctly handle transient files in shared
 repositories
Date: Mon, 11 Jan 2016 16:38:02 -0500
Message-ID: <20160111213801.GB21131@sigill.intra.peff.net>
References: <cover.1452085713.git.johannes.schindelin@gmx.de>
 <cover.1452537321.git.johannes.schindelin@gmx.de>
 <xmqqa8obx1ll.fsf@gitster.mtv.corp.google.com>
 <xmqq60yzx14w.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Schindelin <johannes.schindelin@gmx.de>,
	git@vger.kernel.org, Yaroslav Halchenko <yoh@onerussian.com>,
	SZEDER =?utf-8?B?R8OhYm9y?= <szeder@ira.uka.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Jan 11 22:38:11 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aIkAF-0003M4-4p
	for gcvg-git-2@plane.gmane.org; Mon, 11 Jan 2016 22:38:11 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933932AbcAKViG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Jan 2016 16:38:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:51638 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S933790AbcAKViF (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Jan 2016 16:38:05 -0500
Received: (qmail 15298 invoked by uid 102); 11 Jan 2016 21:38:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:38:04 -0500
Received: (qmail 5991 invoked by uid 107); 11 Jan 2016 21:38:21 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Mon, 11 Jan 2016 16:38:21 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Jan 2016 16:38:02 -0500
Content-Disposition: inline
In-Reply-To: <xmqq60yzx14w.fsf@gitster.mtv.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/283726>

On Mon, Jan 11, 2016 at 01:22:07PM -0800, Junio C Hamano wrote:

>      - git fsck, when writing lost&found blobs (they are written in the
>        file under its object name, so an existing file with tighter
>        permission that you cannot write into is OK, because what you are
>        failing to write is the same contents that the file already has
>        anyway).

I'm not sure I buy this argument. Yes, you should not be writing
anything else, but that does not change the fact that "fsck" will
unceremoniously abort:

  $ git init
  $ echo foo | git hash-object -w --stdin
  $ git fsck --lost-found
  notice: HEAD points to an unborn branch (master)
  Checking object directories: 100% (256/256), done.
  notice: No default references
  dangling blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99

  $ chmod -w .git/lost-found/other/257cc5642cb1a054f08cc83f2d943e56fd3ebe99 
  $ $ git fsck --lost-found
  notice: HEAD points to an unborn branch (master)
  Checking object directories: 100% (256/256), done.
  notice: No default references
  dangling blob 257cc5642cb1a054f08cc83f2d943e56fd3ebe99
  fatal: Could not open '.git/lost-found/other/257cc5642cb1a054f08cc83f2d943e56fd3ebe99': Permission denied

So I think this would be a reasonable candidate (or alternatively, to
treat EPERM on an existing file as a soft error). I am totally fine not
to address it as part of this series, though.

-Peff
