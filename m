From: "Randall S. Becker" <rsbecker@nexbridge.com>
Subject: RE: Allowing weak references to blobs and strong references to commits
Date: Tue, 31 Mar 2015 17:08:47 -0400
Message-ID: <006a01d06bf6$e2512540$a6f36fc0$@nexbridge.com>
References: <20150331100756.GA13377@glandium.org> <1E05987AFD4A4ABCB5515905B517C021@PhilipOakley>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: "'Philip Oakley'" <philipoakley@iee.org>,
	"'Mike Hommey'" <mh@glandium.org>, <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 31 23:09:23 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yd3PS-00075J-IY
	for gcvg-git-2@plane.gmane.org; Tue, 31 Mar 2015 23:09:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753404AbbCaVJM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Mar 2015 17:09:12 -0400
Received: from elephants.elehost.com ([216.66.27.132]:22514 "EHLO
	elephants.elehost.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752278AbbCaVJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Mar 2015 17:09:09 -0400
X-Virus-Scanned: amavisd-new at elehost.com
Received: from pangea (CPE0023eb577e25-CM602ad06c91a7.cpe.net.cable.rogers.com [99.237.128.150])
	(authenticated bits=0)
	by elephants.elehost.com (8.14.9/8.14.9) with ESMTP id t2VL8mZd065945
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=NO);
	Tue, 31 Mar 2015 17:08:49 -0400 (EDT)
	(envelope-from rsbecker@nexbridge.com)
In-Reply-To: <1E05987AFD4A4ABCB5515905B517C021@PhilipOakley>
X-Mailer: Microsoft Outlook 15.0
Thread-Index: AQH4oE68xzJHwiB8s4/r0zMlkxKrWAISUSNunNYXXqA=
Content-Language: en-ca
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266556>

On March 31, 2015 3:55 PM Philip Oakley wrote:
> From: "Mike Hommey" <mh@glandium.org>
> [...]
> > So I thought, since commits are already allowed in tree objects, for
> > submodules, why not add a bit to the mode that would tell git that
> > those commit object references are meant to always be there aka strong
> > reference, as opposed to the current weak references for submodules.
> > I was thinking something like 0200000, which is above S_IFMT, but I
> > haven't checked if mode is expected to be a short anywhere, maybe one
> > of the file permission flags could be abused instead (sticky bit?).
> >
> > I could see this used in the future to e.g. implement a fetchable
> > reflog (which could be a ref to a tree with strong references to
> > commits).
> >
> > Then that got me thinking that the opposite would be useful to me as
> > well: I'm currently storing mercurial manifests as git trees with
> > (weak) commit references using the mercurial sha1s for files.
> > Unfortunately, that doesn't allow to store the corresponding file
> > permissions, so I'm going through hoops to get that. It would be
> > simpler for me if I could just declare files or symlinks with the
> > right permissions and say 'the corresponding blob doesn't need to
> > exist'.
> > I'm sure other tools using git as storage would have a use for such
> > weak references.
> >
> The "weak references" idea is something that's on my back list of
Toh-Doh's for
> the purpose of having a Narrow clone.
> 
> However it's not that easy as you need to consider three areas - what's on
disk
> (worktree/file system), what's in the index, and what's in the object
store and
> how a coherent view is kept of all three without breakage.
> 
> The 'Sparse Checkout' / 'Skip Worktree' (see `git help read-tree`) covers
the
> first two but not the third (which submodules does) [that's your 'the
> corresponding blob doesn't need to exist' aspect from my perspective]
> 
> 
> > What do you think about this? Does that seem reasonable to have in git
> > core, and if yes, how would you go about implementing it (same bit
> > with different meaning for blobs and commits (or would you rather that
> > were only done for commits and not for blobs)? what should I be
> > careful about, besides making sure gc and fsck don't mess up?)

I don't know whether this is relevant or not - forgiveness requested in
advance. It may be useful to store primarily the SHA1 for a weak object. In
a product called RMS, this was called an "External Reference". The file
itself was not stored, but its signature was. It was possible to tell that
the commit was validly and completely on disk, only if the signature matched
(so git status would know). If the file was missing, or had an invalid
signature, the working area was considered dirty (so git status would
presumably report "modified"). All signatures were stored for these types of
files, but the contents were not - hence "external". Otherwise, we stored
all other repository attributes - except the contents, with the obvious
risks. This was typically used to track versions of the compilers and
headers being used for builds, which we did not want to store in the
repository, managed by a separate systems operations group, but wanted to
know the signatures in case we had to go back in time. From my point of
view, I would like to be able to have /usr/include (example only) as a
working area where I can be 100% certain it contains what I expect it to
contain, but I don't really want to store the objects in a repository - and
may not have root anyway.

Cheers,
Randall

-- Brief whoami: NonStop&UNIX developer since approximately
UNIX(421664400)/NonStop(211288444200000000)
-- In my real life, I talk too much.
