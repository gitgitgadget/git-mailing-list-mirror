From: Jeff King <peff@peff.net>
Subject: [PATCH 0/2] improving "git stash list -p"
Date: Tue, 29 Jul 2014 07:53:34 -0400
Message-ID: <20140729115334.GA8976@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 29 13:53:43 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XC5yQ-0004eL-Lp
	for gcvg-git-2@plane.gmane.org; Tue, 29 Jul 2014 13:53:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750854AbaG2Lxi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Jul 2014 07:53:38 -0400
Received: from cloud.peff.net ([50.56.180.127]:42408 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750764AbaG2Lxi (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Jul 2014 07:53:38 -0400
Received: (qmail 13371 invoked by uid 102); 29 Jul 2014 11:53:37 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 29 Jul 2014 06:53:37 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 29 Jul 2014 07:53:34 -0400
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254420>

Imagine you have a simple stash like:

  git init
  echo base >file && git add file && git commit -m file
  echo new >file
  git stash

Before this series:

  $ git stash list -p
  stash@{0}: WIP on master: 7a1fd22 file

Er, what? It didn't give me a patch. Oh, that's because stashes are
merge commits, and we need to tell it how to handle merges.

  $ git stash list -p --cc
  stash@{0}: WIP on master: 7a1fd22 file

  diff --cc file
  index df967b9,df967b9..3e75765
  --- a/file
  +++ b/file
  @@@ -1,1 -1,1 +1,1 @@@
  --base
  ++new

Better, though the combined diff is useless, since I didn't touch the
index at all. Here it is after this series:

  $ git stash list -p
  stash@{0}: WIP on master: 7a1fd22 file

  diff --cc file
  index df967b9..3e75765
  --- a/file
  +++ b/file
  @@ -1,1 +1,1 @@
  -base
  +new

Ah, a nice readable diff with no hassle.

  [1/2]: add --simplify-combined-diff option
  [2/2]: stash: default listing to "--cc --simplify-combined-diff"

-Peff
