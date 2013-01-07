From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] status: report ignored yet tracked directories
Date: Mon, 7 Jan 2013 03:33:18 -0500
Message-ID: <20130107083318.GA18052@sigill.intra.peff.net>
References: <20130105112432.GA14666@sigill.intra.peff.net>
 <1357418563-6626-1-git-send-email-apelisse@gmail.com>
 <20130105230303.GA5195@sigill.intra.peff.net>
 <CALWbr2yRQai2Z08G2qFbA3AvsgivR-8kQ64SZ4pEktyrf+ZXiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 07 09:33:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ts89P-0005Ra-MR
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jan 2013 09:33:44 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753762Ab3AGIdX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 7 Jan 2013 03:33:23 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:46034 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751798Ab3AGIdW (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 7 Jan 2013 03:33:22 -0500
Received: (qmail 8162 invoked by uid 107); 7 Jan 2013 08:34:35 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 07 Jan 2013 03:34:35 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 07 Jan 2013 03:33:18 -0500
Content-Disposition: inline
In-Reply-To: <CALWbr2yRQai2Z08G2qFbA3AvsgivR-8kQ64SZ4pEktyrf+ZXiQ@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/212885>

On Sun, Jan 06, 2013 at 05:40:46PM +0100, Antoine Pelisse wrote:

> > Looking at your fix and remembering how the index hashing works, I think
> > the answer is that:
> >
> >   1. This bug only affects directories, because they are the only thing
> >      that can be simultaneously "ignored and untracked" and "tracked"
> >      (i.e., they have entries of both, and we are using
> >      DIR_SHOW_OTHER_DIRECTORIES).
> >
> >   2. When core.ignorecase is false, the index name hash contains only
> >      the file entries, and cache_name_exists returns an exact match. So
> >      it doesn't matter if we make an extra check when adding the
> >      directory via dir_add_name; we know that it will not be there, and
> >      the final check is a no-op.
> >
> >   3. When core.ignorecase is true, we also store directory entries in
> >      the index name hash, and this extra check is harmful; the entry
> >      does not really exist in the index, and we still need to add it.
> 
> Yes, because of this couple of lines I guess (name-hash.c, hash_index_entry()):
> 
>   if (ignore_case)
>     hash_index_entry_directories(istate, ce);

Exactly. I couldn't remember at first why this was the case, but after
reading 5102c61 (Add case insensitivity support for directories when
using git status, 2010-10-03) again, I think it is because we cannot do
a partial-name lookup via the hash (i.e., the hash for "foo/" and
"foo/bar" have no relation to each other). Not related to your patch,
obviously, but it was the missing piece for me to understand why the
code was doing what it does.

> > I think in the normal file case, we'd expect treat_path to just tell us
> > that it is handled, and we would not ever call dir_add_name in the first
> > place. But what if we have an index entry for a file, but the working
> > tree now contains a directory?
> 
> The directory is treated as any other untracked directory (it never
> matches indexed file because of the trailing /).

Ah, right. That makes sense.

> > I _think_ we still do not hit this code path in that instance, because
> > we will end up in treat_directory, and we will end up checking
> > directory_exists_in_index. And I cannot get it to misbehave in practice.
> > So I think your fix is correct, but the exact how and why is a bit
> > subtle.
> 
> Thanks a lot for the help, I will try to come up with a better commit
> message now.

Thanks. I think the patch is right, but the reasoning is just a bit
subtle.

-Peff
