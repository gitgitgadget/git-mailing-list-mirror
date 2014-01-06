From: Jeff King <peff@peff.net>
Subject: Re: Bug report: stash in upstream caused remote fetch to fail
Date: Mon, 6 Jan 2014 10:27:42 -0500
Message-ID: <20140106152742.GA26221@sigill.intra.peff.net>
References: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Matt Burke <spraints@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 06 16:28:23 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W0C5k-0003qJ-PE
	for gcvg-git-2@plane.gmane.org; Mon, 06 Jan 2014 16:27:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754918AbaAFP1o (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Jan 2014 10:27:44 -0500
Received: from cloud.peff.net ([50.56.180.127]:55920 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753767AbaAFP1o (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Jan 2014 10:27:44 -0500
Received: (qmail 1047 invoked by uid 102); 6 Jan 2014 15:27:43 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 06 Jan 2014 09:27:43 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 06 Jan 2014 10:27:42 -0500
Content-Disposition: inline
In-Reply-To: <CAECVvXYD69Xrp85bVJg6XogvctUTwrFDae+3tawFgoCAUGhwGg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240016>

On Fri, Jan 03, 2014 at 04:12:51PM -0500, Matt Burke wrote:

> + git init -q
> + git fetch -q -fu ../../../other '+refs/*:refs/*'
> fatal: bad object 9b985fbe6a2b783c16756077a8be261c94b6c197
> error: ../../../other did not send all necessary objects

I was going to ask you to send your repository, but I can easily
reproduce here. I guess people don't run into it because it's uncommon
to fetch the whole refs/ namespace from a non-bare repo (and bare repos
do not tend to have stashes). Here's a minimal reproduction recipe:

  git init repo &&
  cd repo &&
  echo content >foo &&
  git add . &&
  git commit -m foo &&
  echo more >>foo &&
  git stash &&
  git init --bare sub &&
  cd sub &&
  git fetch .. 'refs/*:refs/*'

It looks like we are not feeding refs/stash properly to pack-objects.
I'll try to take a closer look later today.

-Peff
