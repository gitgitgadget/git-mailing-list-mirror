From: Jeff King <peff@peff.net>
Subject: Re: [Request] Git export with hardlinks
Date: Mon, 11 Feb 2013 12:13:57 -0500
Message-ID: <20130211171357.GF16402@sigill.intra.peff.net>
References: <201302061619.07765.thomas@koch.ro>
 <20130208095819.GA17220@sigill.intra.peff.net>
 <201302101133.28746.thomas@koch.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org
To: Thomas Koch <thomas@koch.ro>
X-From: git-owner@vger.kernel.org Mon Feb 11 18:14:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U4wxV-0004uQ-Ao
	for gcvg-git-2@plane.gmane.org; Mon, 11 Feb 2013 18:14:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758174Ab3BKROA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 12:14:00 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44366 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757740Ab3BKRN7 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 12:13:59 -0500
Received: (qmail 23949 invoked by uid 107); 11 Feb 2013 17:15:27 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 11 Feb 2013 12:15:27 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 11 Feb 2013 12:13:57 -0500
Content-Disposition: inline
In-Reply-To: <201302101133.28746.thomas@koch.ro>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216056>

On Sun, Feb 10, 2013 at 11:33:26AM +0100, Thomas Koch wrote:

> thank you very much for your idea! It's good and simple. It just breaks down 
> for the case when a large folder got renamed.

Yes, it would never find renames, which a true sha1->path map could.

> But I already hacked the basic layout of the algorithm and it's not 
> complicated at all, I believe:
> 
> https://github.com/thkoch2001/git_export_hardlinks/blob/master/git_export_hardlinks.py

It looks like you create the sha1->path mapping by asking the user to
provide <tree_sha1>,<path> pairs, and then assuming that the exported
tree at <path> exactly matches <tree_sha1>. Which it would in the
workflow you've proposed, but it is also easy for that not to be the
case (e.g., somebody munges a file in <path> after it has been
exported).

So it's a bit dangerous as a general purpose tool, IMHO. It's also a
slight pain in that you have to keep track of the tree sha1 for each
exported path somehow.

A safer and more convenient (but slightly less efficient) solution would
be to keep a git index file for each exported tree. Then we can just
refresh that index, which would check that our sha1 for each path is up
to date (and in the common case of nothing changed, would only be as
expensive as stat()-ing each entry). And then we use that index as the
sha1->path map.

The simplest way to have an index for each export would be to actually
give each one its own git repo (which does not have to use much space,
if you use "-s" to share the objects with the master repo).

That's more complex, and uses more disk than what your script does, but
I do think the added safety would be worth it for a general-purpose
tool.

> I had to interrupt work on this and could not yet finish and test it. But I 
> thought you might be interested. Maybe something like this might one day be 
> rewritten in C and become part of git core?

I think if we had a `git export` command (and we do not, but there has
been discussion in a nearby thread about whether such a thing might be a
good idea), having a `--hard-link-from` option to link with other
checkouts would make sense. It could also potentially be an option to
git-checkout-index, and you could script around it at that low level.

-Peff
