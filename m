From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Thu, 28 Jan 2016 08:10:00 +0100
Message-ID: <20160128070959.GA6815@ecki.hitronhub.home>
References: <20160122060720.GA15681@sigill.intra.peff.net>
 <20160124143403.GL7100@hank>
 <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
 <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
 <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
 <20160127151602.GA1690@ecki.hitronhub.home>
 <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Jan 28 08:13:14 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aOglC-0007Q2-0L
	for gcvg-git-2@plane.gmane.org; Thu, 28 Jan 2016 08:12:54 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754324AbcA1HMv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 Jan 2016 02:12:51 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:39681 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751178AbcA1HMt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Jan 2016 02:12:49 -0500
Received: from [127.0.0.1] (ip5f5ade73.dynamic.kabel-deutschland.de [95.90.222.115])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3prY0Q590Lz5tlP;
	Thu, 28 Jan 2016 08:12:38 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284981>

On Wed, Jan 27, 2016 at 12:49:31PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I wonder what would break if we ask this question instead:
> >
> >     We do not know if the working tree file and the indexed data
> >     match.  Let's see if "git checkout" of that path would leave the
> >     same data as what currently is in the working tree file.

If we do this, then git diff should show the diff between
convert_to_worktree(index state) and the worktree state. That would be
nice, because the diff would actually show what we have in the worktree.
It keeps confusing me that with eol conversion enabled, git diff does
not actually show me the worktree state.

However, even if the file is clean in that direction, there could be a
mismatch between convert_to_git(worktree state) and the index state.
This will happen for example in t0025.4, where we have a CRLF file in
the index and the worktree, but convert_to_git converts it to a file
with LF line endings. Still, I do not see a problem if we also provide a
command like git add --fix-index, which will force normalization of all
files.

> > If we did this, "reset --hard HEAD" followed by "diff HEAD" will by
> > definition always report "is clean" as long as nobody changes files
> > in the working tree, even with the inconsistent data in the index.

Yes, this is a more elegant and a more complete solution to the problem
which prompted me to submit the GIT_ATTRIBUTES_DISABLED patch.

> > This still requires that convert_to_working_tree(), i.e. your smudge
> > filter, is deterministic, though, but I think that is a sensible
> > assumption for sane people, even for those with inconsistent data in
> > the index.

Deterministic, yes. But not unchanging. When a smudge filter is added,
or modified, or if the filter program changes, we still have to remove
the index before we can trust git diff again. The only way to avoid this
would be to somehow detect if the conversion itself changes. One could
hash the attributes, but changes to the filter configuration or the
filter itself are hard to detect. So I think we have to live with this.

> [...] Doing the other check will have to
> inflate the blob data and apply the convert_to_working_tree()
> processing, and also read the whole thing from the filesystem and
> compare, which is more work at runtime.

If we assume that the smudge filter is deterministic, then we could also
hash the output of convert_to_working_tree, and store the hash in the
index. With this optimization, the comparision would be less work,
because we do not have to apply a filter again, whereas currently we
have to apply convert_to_git.

> IOW, I am saying that the "add --fix-index" lunchbreak patch I sent
> earlier in the thread that has to hold the data in-core while
> processing is not a production quality patch ;-)

Ok. The existing implementation in renormalize_buffer (convert.c) works
for me, though.
