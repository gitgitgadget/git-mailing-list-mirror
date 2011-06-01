From: Jeff King <peff@peff.net>
Subject: Re: unable to get type of object
Date: Wed, 1 Jun 2011 12:04:48 -0400
Message-ID: <20110601160447.GA7132@sigill.intra.peff.net>
References: <4DE5E60B.2030903@garrigos.cat>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Robert Garrigos <robert@garrigos.cat>
X-From: git-owner@vger.kernel.org Wed Jun 01 18:04:56 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QRnuh-0004Q3-Hu
	for gcvg-git-2@lo.gmane.org; Wed, 01 Jun 2011 18:04:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756678Ab1FAQEv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 1 Jun 2011 12:04:51 -0400
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:45907
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754558Ab1FAQEu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 1 Jun 2011 12:04:50 -0400
Received: (qmail 13190 invoked by uid 107); 1 Jun 2011 16:04:53 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 01 Jun 2011 12:04:53 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 01 Jun 2011 12:04:48 -0400
Content-Disposition: inline
In-Reply-To: <4DE5E60B.2030903@garrigos.cat>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174873>

On Wed, Jun 01, 2011 at 09:11:07AM +0200, Robert Garrigos wrote:

> ************
> predircam@eduab:~/public_html/idosing> git pull
> Generating pack...
> Done counting 117 objects.
> error: unable to find c3117d23df0c01ba8558bad81ad3488f0e8d430a
> fatal: unable to get type of object c3117d23df0c01ba8558bad81ad3488f0e8d430a
> fatal: early EOF
> fatal: git-unpack-objects died with error code 128
> Fetch failure: /home/predircam/gitrepos/idosing.git
> ***************
> 
> google suggests me to run git fsck to get a list of corrupted files.
> Besides that I'm running git 1.2.4 and that the git command for that
> version is fsck-objects, I'm not having any result at all.

Wow, that's pretty ancient by git standards.

> Could this be a compatibility problem? As I said, I run git 1.2.4 on
> the repo server and git 1.7.0.2 on my development server. BTW, on my
> devel server running the git command fsck gives no result either.

It could be. In the 1.6.x series we started using some newer encodings
for packfiles and their associated indexes. From the 1.6.0 release
notes:

  By default, packfiles created with this version uses delta-base-offset
  encoding introduced in v1.4.4.  Pack idx files are using version 2
  that allows larger packs and added robustness thanks to its CRC
  checking, introduced in v1.5.2 and v1.4.4.5.  If you want to keep your
  repositories backwards compatible past these versions, set
  repack.useDeltaBaseOffset to false or pack.indexVersion to 1,
  respectively.

However, note that this is for the _local_ pack storage. When two git
versions are talking to each other on the network, they will negotiate
the use of delta-base-offsets (and the index is never transmitted, but
regenerated locally on the receiving side).

But you can still run into problems if you are accessing the repo at the
filesystem level with two different versions (e.g., by mounting from a
remote server, or by copying your .git directory from machine to
machine).

For example (I keep many old git versions around as git.$version, but
in your case it would presumably happen on separate machines).

  # set up a simple repo with v1.7.0.2
  git.v1.7.0.2 init repo
  cd repo
  echo content >file
  git.v1.7.0.2 add file
  git.v1.7.0.2 commit -m foo
  git.v1.7.0.2 repack -ad

  # now try accessing with v1.2.4, which yields:
  # error: non-monotonic index
  # fatal: bad object ab929d107cceaf4d4b4d6a2d9b0aac275fd6e227
  git.v1.2.4 log

It can be fixed with:

  git.v1.7.0.2 config repack.useDeltaBaseOffset false
  git.v1.7.0.2 config pack.indexVersion 1
  git.v1.7.0.2 repack -ad
  # and now this works
  git.v1.2.4 log

where again, you would do the v1.7.0.2 bits on the machine with the
newer git.

Does this apply to your situation (two versions of git accessing the
same repo at the filesystem level)? If so, does setting that config and
repacking clear things up?

-Peff
