From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] repack: call prune_packed_objects() and
 update_server_info() directly
Date: Sat, 13 Sep 2014 16:15:38 -0400
Message-ID: <20140913201538.GA24854@peff.net>
References: <5413F201.8030005@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	Stefan Beller <stefanbeller@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: =?utf-8?B?UmVuw6k=?= Scharfe <l.s.r@web.de>
X-From: git-owner@vger.kernel.org Sat Sep 13 22:15:46 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XStjV-0002UP-RG
	for gcvg-git-2@plane.gmane.org; Sat, 13 Sep 2014 22:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752175AbaIMUPm convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 13 Sep 2014 16:15:42 -0400
Received: from cloud.peff.net ([50.56.180.127]:47790 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1752125AbaIMUPl (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Sep 2014 16:15:41 -0400
Received: (qmail 8637 invoked by uid 102); 13 Sep 2014 20:15:41 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 15:15:41 -0500
Received: (qmail 10236 invoked by uid 107); 13 Sep 2014 20:16:02 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Sat, 13 Sep 2014 16:16:02 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 13 Sep 2014 16:15:38 -0400
Content-Disposition: inline
In-Reply-To: <5413F201.8030005@web.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256972>

On Sat, Sep 13, 2014 at 09:28:01AM +0200, Ren=C3=A9 Scharfe wrote:

> Call the functions behind git prune-packed and git update-server-info
> directly instead of using run_command().  This is shorter, easier and
> quicker.

It can also introduce bugs, since a lot of git code assumes it is
running in a single process and can die() or mark up global variables a=
t
will. :)

I gave a quick read-through of the code and I think these calls are OK.
The two things I noticed were:

  1. We might die on a malloc failure that would otherwise go unnoticed
     in a sub-process. That's probably OK.

  2. The info/packs file is generated from our internal packed_git list=
=2E
     This list can get crufty if you have a long-running process that
     accesses objects and other processes are repacking. I think that's
     OK here; the parent repack process is not very long-lived.

I did, however, notice that the code we are calling has some problems o=
f
its own. :) Here are some fixes:

  [1/3]: prune-packed: fix minor memory leak
  [2/3]: make update-server-info more robust
  [3/3]: server-info: clean up after writing info/packs

-Peff
