From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Mon, 1 Feb 2016 20:33:42 +0100
Message-ID: <20160201193340.GA892@ecki>
References: <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
 <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
 <20160127151602.GA1690@ecki.hitronhub.home>
 <xmqqd1sm9730.fsf@gitster.mtv.corp.google.com>
 <xmqqmvrq7nok.fsf@gitster.mtv.corp.google.com>
 <20160128070959.GA6815@ecki.hitronhub.home>
 <xmqqk2mtmlu9.fsf@gitster.mtv.corp.google.com>
 <20160130081306.GA2931@ecki.hitronhub.home>
 <xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Feb 01 20:36:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aQKH6-0002eR-F4
	for gcvg-git-2@plane.gmane.org; Mon, 01 Feb 2016 20:36:36 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752872AbcBATgc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 1 Feb 2016 14:36:32 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:33356 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752725AbcBATgb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 1 Feb 2016 14:36:31 -0500
Received: from [127.0.0.1] (p5B22DE32.dip0.t-ipconnect.de [91.34.222.50])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pvKJh42hmz5tlJ;
	Mon,  1 Feb 2016 20:36:20 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqlh74wb0r.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285211>

On Mon, Feb 01, 2016 at 10:17:24AM -0800, Junio C Hamano wrote:
> 
> Your proposal is to redefine "is the working tree dirty?"; it would
> check if "git checkout -f" would change what is in the working tree.

I like this definition. Sounds obviously right.

> > Regarding performance impact: We only need to do this extra check if the
> > usual check convert_to_git(work tree) against index state fails, and
> > conversion is in effect.
> 
> How would you detect the failure, though?  Having contents in the
> index that contradicts the attributes and eol settings affects the
> cleanliness both ways.  Running the working tree contents via to-git
> conversion and hashing may match the blob in the index, declaring
> that the index entry is "clean", but passing the blob to to-worktree
> conversion may produce result different from what is in the
> worktree, which is "falsely clean".

True. But this is what we do today, and I thought at first that we have
to keep this behavior. The following enables eol conversion on git add,
but not on checkout:

 printf 'line 1\r\n' >dos.txt
 echo '* text' >.gitattributes
 git add dos.txt
 git commit

After git add the worktree is considered clean, even though dos.txt
still has CRLF line endings, and rm dos.txt && git checkout dos.txt
re-creates dos.txt with LF line endings. If we change the definition as
proposed above, then the worktree would be dirty even though we just
did git add and git commit.

So I concluded that we have to treat the worktree clean if either git
add -u does not change the index state, _or_ git checkout -f does not
change the worktree state.

But doing only the git checkout -f check makes much more sense. Maybe we
can handle the above situation better by doing an implicit
git checkout -f <committed files> after git commit. After all, I would
expect git commit to give me exactly the same state that I get later
when I do git checkout <commit> for the same commit.

> > On the other hand, a user who simply follows an upstream repository by
> > doing git pull all the time, and who does not make changes to their
> > configuration, can still run into this issue, because upstream could
> > change .gitattributes. This part we could actually detect by hashing the
> > attributes for each index entry, and if that changes we re-evaluate the
> > file state.
> 
> If this has to bloat each index entry, I do not think solving the
> problem is worth that cost of that overhead.  I'd rather just say
> "if you have inconsistent data, here is a workaround using 'reset'
> and then 'reset --hard'" and be done with it.

Works for me.

> > This is also an issue only if a smudge filter is in place. The eol
> > conversion which only acts in the convert_to_git direction is not
> > affected.
> 
> IIRC, autocrlf=true would strip CR at the end of line in to-git
> conversion, and would add CR in to-worktree conversion.  So some eol
> conversion may only act in to-git, but some others do affect both,
> and without needing you to touch attributes.

I was somehow under the impression that autocrlf=true is discouraged,
and setting the text attribute to true is the new recommended way to
configure eol conversion. But I see that the Git for Windows installer
still offers autocrlf=true as the default option, so clearly we need to
support it well.
