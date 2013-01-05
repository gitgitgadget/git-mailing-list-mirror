From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: report ignored yet tracked directories
Date: Sat, 5 Jan 2013 18:03:03 -0500
Message-ID: <20130105230303.GA5195@sigill.intra.peff.net>
References: <20130105112432.GA14666@sigill.intra.peff.net>
 <1357418563-6626-1-git-send-email-apelisse@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: tboegi@web.de, git@vger.kernel.org
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jan 06 00:03:29 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Trclz-0007ad-JT
	for gcvg-git-2@plane.gmane.org; Sun, 06 Jan 2013 00:03:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755935Ab3AEXDH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 5 Jan 2013 18:03:07 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:44789 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755898Ab3AEXDG (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 5 Jan 2013 18:03:06 -0500
Received: (qmail 30209 invoked by uid 107); 5 Jan 2013 23:04:18 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Sat, 05 Jan 2013 18:04:18 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Sat, 05 Jan 2013 18:03:03 -0500
Content-Disposition: inline
In-Reply-To: <1357418563-6626-1-git-send-email-apelisse@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212736>

On Sat, Jan 05, 2013 at 09:42:43PM +0100, Antoine Pelisse wrote:

> Tracked directories (i.e. directories containing tracked files) that
> are ignored must be reported as ignored if they contain untracked files.
> 
> Currently, tracked files or directories can't be reported untracked or ignored.
> Remove that constraint when searching ignored files.
> 
> Signed-off-by: Antoine Pelisse <apelisse@gmail.com>
> ---

I was expecting to see some explanation of the user-visible bug here. In
other words, what does this fix, and why does the bug only happen when
core.ignorecase is set.

Looking at your fix and remembering how the index hashing works, I think
the answer is that:

  1. This bug only affects directories, because they are the only thing
     that can be simultaneously "ignored and untracked" and "tracked"
     (i.e., they have entries of both, and we are using
     DIR_SHOW_OTHER_DIRECTORIES).

  2. When core.ignorecase is false, the index name hash contains only
     the file entries, and cache_name_exists returns an exact match. So
     it doesn't matter if we make an extra check when adding the
     directory via dir_add_name; we know that it will not be there, and
     the final check is a no-op.

  3. When core.ignorecase is true, we also store directory entries in
     the index name hash, and this extra check is harmful; the entry
     does not really exist in the index, and we still need to add it.

But that makes me wonder. In the ignorecase=false case, I claimed that
the check in dir_add_name is a no-op for mixed tracked/ignored
directories. But it is presumably not a no-op for other cases. Your
patch only turns it off when DIR_SHOW_IGNORED is set. But is it possible
for us to have DIR_SHOW_IGNORED set, _and_ to pass in a path that exists
in the index as a regular file?

I think in the normal file case, we'd expect treat_path to just tell us
that it is handled, and we would not ever call dir_add_name in the first
place. But what if we have an index entry for a file, but the working
tree now contains a directory?

I _think_ we still do not hit this code path in that instance, because
we will end up in treat_directory, and we will end up checking
directory_exists_in_index. And I cannot get it to misbehave in practice.
So I think your fix is correct, but the exact how and why is a bit
subtle.

-Peff
