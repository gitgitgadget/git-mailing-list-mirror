From: Jeff King <peff@peff.net>
Subject: Re: Revert option for git add --patch
Date: Thu, 8 Nov 2012 15:04:49 -0500
Message-ID: <20121108200449.GA3018@sigill.intra.peff.net>
References: <EE89F0A1-1C07-4597-B654-035F657AD09F@me.com>
 <20121108151501.GB15560@sigill.intra.peff.net>
 <CAPXHQbPrjZ_Ezi3RkHny-fW0=mQCTmX9NVJfgUh7P-Xx9pgBcg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jonathon Mah <jmah@me.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Nathan Broadbent <nathan.f77@gmail.com>
X-From: git-owner@vger.kernel.org Thu Nov 08 21:05:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TWYLb-0005iu-OB
	for gcvg-git-2@plane.gmane.org; Thu, 08 Nov 2012 21:05:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756786Ab2KHUEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 8 Nov 2012 15:04:54 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:36658 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756769Ab2KHUEx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 8 Nov 2012 15:04:53 -0500
Received: (qmail 32290 invoked by uid 107); 8 Nov 2012 20:05:39 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 08 Nov 2012 15:05:39 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 08 Nov 2012 15:04:49 -0500
Content-Disposition: inline
In-Reply-To: <CAPXHQbPrjZ_Ezi3RkHny-fW0=mQCTmX9NVJfgUh7P-Xx9pgBcg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209186>

On Fri, Nov 09, 2012 at 08:42:33AM +1300, Nathan Broadbent wrote:

> It sounds like we want a tool that combines the functionality of 'git add
> --patch', 'git checkout --patch', and other features, so that we can
> perform various actions on 'hunks' without switching context. What do you
> think about naming this command 'git patch'?

I think it would be a slightly confusing name, given that it is not
related to the usual Unix "patch" command (git's analog to that is "git
apply").

I was thinking something like "git organize" because it is about
organizing muddled changes. Duy mentioned my earlier "git put", which is
based around the same ideas. This could be thought of as "git put
--patch", I suppose.

> I'm not sure how dropping hunks into 'buckets' would work, but the main
> idea is to be able to stage, discard or edit hunks in a single pass.

Buckets are really just patches you are building up from hunks. So I
think you are dealing with two buckets either way: a to-stage bucket and
a to-discard bucket. Adding more buckets isn't hard; you just turn the
to-stage bucket into an array of buckets.

The tricky part is figuring out how to keep the state persistent across
multiple invocations. The simplest program flow for the 2-bucket case
would be something like:

  for h in hunks
  do
          show hunk to user
          ask user what they want to do
          if they want to stage
             append to to-stage patch
          else if they want to discard
             append to to-discard patch
          else
             ignore the hunk
  done
  feed to-stage patch to "git apply --cached"
  feed to-discard patch to "git apply -R"

Modifying the loop to have more buckets is easy. But the end is probably
something like:

  feed to-discard patch to "git apply -R"
  feed bucket[0] to "git apply --cached"
  save bucket[1..n] somewhere
  exit

Then the user gets control back, builds, tests, commits, whatever, and
then runs "git organize --continue" to apply bucket[1], and so on. And
since we don't know what the user did in between, we have to be ready
for conflicts in applying the buckets.  Hmm, this is sounding a lot like
how "rebase --interactive" works.

One way to implement this would be to store each bucket as a commit
against HEAD (i.e., stage it into a temporary index, then run "git
write-tree" and "git commit-tree"), and then make a "rebase -i"
instruction sheet like:

  pick $sha1_of_bucket_1_commit
  edit
  pick $sha1_of_bucket_2_commit
  edit

and so forth, except that we would not want our picks to actually commit
(just pull the changes into the working tree and/or index).

That's just me thinking off the top of my head. Obviously what you are
proposing is way simpler, and it is probably sane to start with the
simple thing, and then build the more complex thing on top. But it might
be worth keeping in mind the complex case when building out the
infrastructure for the simple case.

-Peff
