From: Jeff King <peff@peff.net>
Subject: Re: inotify to minimize stat() calls
Date: Wed, 13 Feb 2013 13:18:51 -0500
Message-ID: <20130213181851.GA5603@sigill.intra.peff.net>
References: <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh>
 <CABPQNSZ282Lre=sy-+ZQdJA9JnGqQguq2bQDOwvjb0fP+1-w8Q@mail.gmail.com>
 <CACsJy8AWyJ=dW5f44huWyPPe4X62xyi+R9CNM5Tg6u6TYf+thQ@mail.gmail.com>
 <511AAA92.4030508@gmail.com>
 <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: blees@dcon.de, kusmabite@gmail.com,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Junio C Hamano <gitster@pobox.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Feb 13 19:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U5gvd-0003S5-EG
	for gcvg-git-2@plane.gmane.org; Wed, 13 Feb 2013 19:19:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934533Ab3BMSS7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Feb 2013 13:18:59 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:48160 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759463Ab3BMSS4 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Feb 2013 13:18:56 -0500
Received: (qmail 13730 invoked by uid 107); 13 Feb 2013 18:20:22 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 13 Feb 2013 13:20:22 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 13 Feb 2013 13:18:51 -0500
Content-Disposition: inline
In-Reply-To: <CACsJy8C=2xKcsby048WWCFNhgKObGwrzeCOJPVVqgj88AfSHQw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216275>

On Wed, Feb 13, 2013 at 07:15:47PM +0700, Nguyen Thai Ngoc Duy wrote:

> On Wed, Feb 13, 2013 at 3:48 AM, Karsten Blees <karsten.blees@gmail.com> wrote:
> > 2.) 0.135 s is spent in name-hash.c/hash_index_entry_directories, reindexing the same directories over and over again. In the end, the hashtable contains 939k directory entries, even though the WebKit test repo only has 7k directories. Checking if a directory entry already exists could reduce that, i.e.:
> 
> This function is only used when core.ignorecase = true. I probably
> won't be able to test this, so I'll leave this to other people who
> care about ignorecase.
> 
> This function used to have lookup_hash, but it was removed by Jeff in
> 2548183 (fix phantom untracked files when core.ignorecase is set -
> 2011-10-06). There's a looong commit message which I'm too lazy to
> read. Anybody who works on this should though.

Yeah, the problem that commit tried to solve is that linking to a single
cache entry through the hash is not enough, because we may remove cache
items. Imagine you have "dir/one" and "dir/two", and you add them to the
in-memory index in that order. The original code hashed "dir/" and
inserted a link to the "dir/one" cache entry. When it came time to put
in the "dir/two" entry, we noticed that there was already a "dir/" entry
and did nothing. Then later, if we remove "dir/one", we do so by marking
it with CE_UNHASHED. So a later query for "dir/" will see "nope, nothing
here that wasn't CE_UNHASHED", which is wrong. We never recorded that
"dir/two" existed under the hash for "dir/", so we can't know about it.

My patch just stores the cache_entry for both under the "dir/" hash.
As Karsten noticed, that can lead to a large number of hash entries,
because adding "some/deep/hierarchy/with/files" will add 4 directory
entries for just that single file. Moreover, looking at it again, I
don't think my patch produces the right behavior: we have a single
dir_next pointer, even though the same ce_entry may appear under many
directory hashes. So the cache_entries that has to "dir/foo/" and those
that hash to "dir/bar/" may get confused, because they will also both be
found under "dir/", and both try to create a linked list from the
dir_next pointer.

Looking at Karsten's patch, it seems like it will not add a cache entry
if there is one of the same name. But I'm not sure if that is right, as
the old one might be CE_UNHASHED (or it might get removed later). You
actually want to be able to find each cache_entry that has a file under
the directory at the hash of that directory, so you can make sure it is
still valid.

And of course that still leaves the existing correctness problem I
mentioned above.

I think the best way forward is to actually create a separate hash table
for the directory lookups. I note that we only care about these entries
in directory_exists_in_index_icase, which is really about whether
something is there, versus what exactly is there. So could we maybe get
by with a separate hash table that stores a count of entries at each
directory, and increment/decrement the count when we add/remove entries?

The biggest problem I see with that is that we do indeed care a little
bit what is at the directory: we check the mode to see if it is a gitdir
or not. But I think we can maybe sneak around that: gitdirs have actual
entries in the index, whereas the directories do not. So we would find
them via index_name_exists; anything that is not there, but _is_ in the
special directory hash would therefore be a directory.

I realize it got pretty esoteric there in the middle. I'll see if I can
work up a patch that expresses what I'm thinking.

-Peff
