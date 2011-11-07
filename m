From: Jeff King <peff@peff.net>
Subject: Re: git-apply that handles rejects like merge conflicts
Date: Mon, 7 Nov 2011 17:55:08 -0500
Message-ID: <20111107225508.GB28188@sigill.intra.peff.net>
References: <4EB85768.1060508@avtalion.name>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Ori Avtalion <ori@avtalion.name>
X-From: git-owner@vger.kernel.org Mon Nov 07 23:55:20 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RNY60-00056Q-UD
	for gcvg-git-2@lo.gmane.org; Mon, 07 Nov 2011 23:55:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752093Ab1KGWzK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Nov 2011 17:55:10 -0500
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net ([99.108.226.0]:35971
	"EHLO peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750918Ab1KGWzK (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Nov 2011 17:55:10 -0500
Received: (qmail 31083 invoked by uid 107); 7 Nov 2011 22:55:11 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Nov 2011 17:55:11 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Nov 2011 17:55:08 -0500
Content-Disposition: inline
In-Reply-To: <4EB85768.1060508@avtalion.name>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/185044>

On Tue, Nov 08, 2011 at 12:10:48AM +0200, Ori Avtalion wrote:

> I'm trying to get git-apply to apply patches, and let me handle the
> conflicts in a way I'm comfortable with -- by staging the "successful"
> hunks and leaving conflict markers in the working tree.
> 
> With the available flags, I seem to only be able to have successful
> hunks in the index, and rejected ones in patch-like .rej files.
> 
> Is there a way to accomplish this? If not, does anyone think it's a good
> idea?

No, I don't think there's a way to do it now. I do find the conflict
markers the easiest way to mark something up. But most of my "git apply"
use is through "git am", which knows the trick of falling back to a
3-way merge (see fall_back_3way in git-am.sh).

If it's an actual git diff, the same 3-way trick will yield good
results, and it would be nice if it were easier to do that trick without
calling "git am". But if it's not a git diff (i.e., missing the original
blob information), then you won't be able to do that.

In the general case, you can't represent all failed hunks with conflict
markers, can you? I'm thinking something where we couldn't find any
relevant context. You know the lines from the original patch from the
hunk header, so you can drop the failed content from the patch in the
right spot. But how do you know how big a conflict marker to make for
the "current" side? The same number of lines as were in the hunk?
I think you'd end up with confusing conflict markers.

-Peff
