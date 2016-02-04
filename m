From: Jeff King <peff@peff.net>
Subject: Re: Bug: Branch Deletion Doesn't Clean Up
Date: Thu, 4 Feb 2016 02:54:02 -0500
Message-ID: <20160204075402.GA21112@sigill.intra.peff.net>
References: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Karl Moskowski <kmoskowski@me.com>
X-From: git-owner@vger.kernel.org Thu Feb 04 08:54:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aREjz-0004BZ-LG
	for gcvg-git-2@plane.gmane.org; Thu, 04 Feb 2016 08:54:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751333AbcBDHyG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 4 Feb 2016 02:54:06 -0500
Received: from cloud.peff.net ([50.56.180.127]:37244 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750897AbcBDHyF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Feb 2016 02:54:05 -0500
Received: (qmail 15308 invoked by uid 102); 4 Feb 2016 07:54:04 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:54:04 -0500
Received: (qmail 32544 invoked by uid 107); 4 Feb 2016 07:54:04 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 04 Feb 2016 02:54:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 04 Feb 2016 02:54:02 -0500
Content-Disposition: inline
In-Reply-To: <4AC354E1-9E78-42A8-9828-BF1C084A6CBB@me.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285404>

On Thu, Jan 07, 2016 at 02:24:41PM -0500, Karl Moskowski wrote:

> The problem is, deleting a branch whose name contains slashes doesn=E2=
=80=99t
> delete the directories in .git/refs/heads/.

Yes. Git's model is to leave the directories in place, and remove them
only when they get in the way of creating another ref. In theory, the
effect is the same as deleting the directories proactively.

But as you noticed, it does funny things with case-preserving
filesystems. It also can cause performance problems if you have a very
large number of empty directories (because git has to open each of them
just to find out they're empty).

We can into the latter case at GitHub. Michael Haggerty (cc'd) worked u=
p
some patches recently for this, but I don't now if they're yet polished
enough to send upstream.

> It seems like git branch -d ascend the hierarchy (up to
> .git/refs/heads/), deleting any empty directories.

Yes, though it needs to be coupled with making the branch-creation
process more robust to races (since we might create "refs/heads/foo" in
order to make "refs/heads/foo/bar" while somebody else is deleting it t=
o
get rid of "refs/heads/foo/baz").

-Peff
