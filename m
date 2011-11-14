From: Jeff King <peff@peff.net>
Subject: Re: git behaviour question regarding SHA-1 and commits
Date: Mon, 14 Nov 2011 06:48:56 -0500
Message-ID: <20111114114856.GF10847@sigill.intra.peff.net>
References: <CAJuRt+r9BjYcead6hgzdUT0Bisz1D48cegqkoJ0S537VMYBy_g@mail.gmail.com>
 <CACBZZX7VTdc2wHYHb1BB-wCJbKLVEmbzQaBTV04S1KDrqeN73A@mail.gmail.com>
 <7vwrb3l6v2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: =?utf-8?B?w4Z2YXIgQXJuZmrDtnLDsA==?= Bjarmason <avarab@gmail.com>,
	vinassa vinassa <vinassa.vinassa@gmail.com>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Nov 14 12:49:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RPv28-000330-4y
	for gcvg-git-2@lo.gmane.org; Mon, 14 Nov 2011 12:49:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755187Ab1KNLs7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Nov 2011 06:48:59 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:41028
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754560Ab1KNLs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Nov 2011 06:48:59 -0500
Received: (qmail 28668 invoked by uid 107); 14 Nov 2011 11:49:03 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 14 Nov 2011 06:49:03 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 14 Nov 2011 06:48:56 -0500
Content-Disposition: inline
In-Reply-To: <7vwrb3l6v2.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185380>

On Sun, Nov 13, 2011 at 07:29:05PM -0800, Junio C Hamano wrote:

> If the collision is between commit objects, for example, we would write
> the (old) commit object name to the tip of the current branch. Most
> likely, the tree object recorded in the (old) commit would not match the
> tree object your "git commit" wanted to record (otherwise you have hit
> SHA-1 collision twice in a row ;-), which would mean "git status" would
> show that a whole bunch of paths have changed between the HEAD and the
> index. Also "git log" would show the history leading to the (old) commit
> that is likely to be very different from what you would expect immediately
> after committing the collided commit. Of course, you could recover from it
> with "git reset --soft" after finding out what the previous HEAD was from
> the reflog, but it won't be a pleasant experience.
> 
> There can be other kinds of collisions (e.g. your latest commit might have
> collided with an existing blob or tree, in which case it is likely that
> almost nothing would work after finding a blob or tree in HEAD).

You are more likely to just have blobs collide, since we generate many
more blobs than commits (each commit should have at least one changed
blob, but typically has more).

And in that case, I expect git would silently lose that state. We would
fail to write the new blob to the object db, but "git diff" would report
nothing, as it would see that the index entry's sha1 is the same as what
is in HEAD, and that the file is up to date with respect to the stat
information in the index. So if you were to "git checkout", your content
would be lost forever. However, if you instead modify the file further,
the new content will be kept (and you will get a very confusing diff).

-Peff
