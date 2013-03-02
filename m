From: Jeff King <peff@peff.net>
Subject: Re: suggestion for a simple addition: git update-ref --ff-only
Date: Fri, 1 Mar 2013 20:10:50 -0500
Message-ID: <20130302011049.GA16458@sigill.intra.peff.net>
References: <20130301231859.GA334@achernar.madore.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: David Madore <david+news@madore.org>
X-From: git-owner@vger.kernel.org Sat Mar 02 02:11:21 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBayu-0005PV-37
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 02:11:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751448Ab3CBBKw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 20:10:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39692 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751269Ab3CBBKw (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 20:10:52 -0500
Received: (qmail 6214 invoked by uid 107); 2 Mar 2013 01:12:28 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 20:12:28 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 20:10:50 -0500
Content-Disposition: inline
In-Reply-To: <20130301231859.GA334@achernar.madore.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217318>

On Sat, Mar 02, 2013 at 12:18:59AM +0100, David Madore wrote:

> I'd like to suggest a very simple, but IMHO quite useful, additional
> option to git-update-ref: an option --ff-only which would cause the
> command to refuse unless the current ref is an ancestor of the new
> one.
> 
> The reason I think it would be useful: I occasionally wish to perform
> a trivial (i.e., fast-forward) merge of some branch into another
> (e.g., after a git-fetch) without checking it out.  Now git-update-ref
> is perfect for that, but there is always the possibility of getting
> something wrong (which one would not have with git merge --ff-only,
> but the latter requires checking out the branch), and this option
> would avoid tedious verifications.

The update-ref command is plumbing, which is supposed to do one small,
well-defined job. But you can compose many plumbing commands to do what
you want:

  # input
  ref=refs/heads/master
  new=$some_sha1

  # where are we now?
  old=`git rev-parse --verify $ref` || exit 1

  # is it a fast-forward?
  if ! git merge-base --is-ancestor $old $new; then
    echo >&2 "Not a fast-forward"
    exit 1
  fi

  # update it; we do not have to worry about race conditions because
  # update-ref will abort if somebody touched the ref in the meantime
  git update-ref $ref $new $old

Yes, it's three commands instead of one, but it's much more flexible
(you get to write your own message, you can use the same "merge-base" to
handle the "already up to date" case, etc).

-Peff
