From: Clemens Buchacher <drizzd@aon.at>
Subject: Re: [PATCH] travis-ci: run previously failed tests first, then
 slowest to fastest
Date: Wed, 27 Jan 2016 16:16:02 +0100
Message-ID: <20160127151602.GA1690@ecki.hitronhub.home>
References: <DBA834D2-BFC9-4A2F-94D9-A1D0D60377BD@gmail.com>
 <20160122023359.GA686558@vauxhall.crustytoothpaste.net>
 <20160122055255.GA14657@sigill.intra.peff.net>
 <20160122060720.GA15681@sigill.intra.peff.net>
 <20160124143403.GL7100@hank>
 <xmqqd1sqd9sq.fsf@gitster.mtv.corp.google.com>
 <xmqq8u3ed45r.fsf@gitster.mtv.corp.google.com>
 <20160125144250.GM7100@hank>
 <xmqqk2mxa7ug.fsf@gitster.mtv.corp.google.com>
 <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Gummerer <t.gummerer@gmail.com>, Jeff King <peff@peff.net>,
	Torsten =?iso-8859-1?Q?B=F6gershausen?= <tboegi@web.de>,
	"brian m. carlson" <sandals@crustytoothpaste.net>,
	Lars Schneider <larsxschneider@gmail.com>,
	Mike Hommey <mh@glandium.org>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 27 16:23:42 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aORs0-0006kw-Sc
	for gcvg-git-2@plane.gmane.org; Wed, 27 Jan 2016 16:18:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933492AbcA0PSx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Jan 2016 10:18:53 -0500
Received: from bsmtp8.bon.at ([213.33.87.20]:49022 "EHLO bsmtp8.bon.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933215AbcA0PSv (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Jan 2016 10:18:51 -0500
X-Greylist: delayed 19544 seconds by postgrey-1.27 at vger.kernel.org; Wed, 27 Jan 2016 10:18:51 EST
Received: from [127.0.0.1] (ip5f5adbb8.dynamic.kabel-deutschland.de [95.90.219.184])
	by bsmtp8.bon.at (Postfix) with ESMTPSA id 3pr7qh4khTz5tlP;
	Wed, 27 Jan 2016 16:18:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <xmqqegd5fht9.fsf@gitster.mtv.corp.google.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/284915>

I think Junio pointed me to this thread from "[PATCH] optionally disable
gitattributes". Since I am not sure I am following everything correctly
in this thread, allow me to recapitulate what I understood so far.

Firstly, I think the racy'ness of t0025 is understood. It is due to the
is_racy_timestamp check in read-cache.c's ie_match_stat. But for the
moment I would like to put this aside, because the issue can be
reproduced reliably with this change to t0025:

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..e30e9b3 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -55,8 +55,11 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 test_expect_success 'text=true causes a CRLF file to be normalized' '
 
        rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
-       echo "CRLFonly text" > .gitattributes &&
        git read-tree --reset -u HEAD &&
+       sleep 1 &&
+       rm .git/index &&
+       git reset &&
+       echo "CRLFonly text" > .gitattributes &&
 
        # Note, "normalized" means that git will normalize it if added
        has_cr CRLFonly &&

I intentionally wait for one second and then I remove and re-read the
index. Now the timestamps of CRLFonly and .git/index are different, so
we avoid the is_racy_timestamp check. From now on Git will not read the
contents of CRLFonly from disk again until either the index entry or the
mtime of CRLFonly changes (maybe we also check the size, I am not sure).

Now we add .gitattributes. This does not change the index entry, nor
does it change the mtime of CRLFonly. Therefore the subsequent git diff
turns out empty, and the test fails.

I believe this behavior is expected. In gitattributes(5) we therefore
recommend using rm .git/index and git reset to "force Git to rescan the
working directory." The test should be fixed accordingly, something
like:

diff --git a/t/t0025-crlf-auto.sh b/t/t0025-crlf-auto.sh
index c164b46..2917591 100755
--- a/t/t0025-crlf-auto.sh
+++ b/t/t0025-crlf-auto.sh
@@ -57,6 +57,8 @@ test_expect_success 'text=true causes a CRLF file to be normalized' '
        rm -f .gitattributes tmp LFonly CRLFonly LFwithNUL &&
        echo "CRLFonly text" > .gitattributes &&
        git read-tree --reset -u HEAD &&
+       rm .git/index &&
+       git reset &&
 
        # Note, "normalized" means that git will normalize it if added
        has_cr CRLFonly &&



On Mon, Jan 25, 2016 at 01:52:18PM -0800, Junio C Hamano wrote:
> Junio C Hamano <gitster@pobox.com> writes:
> 
> > I do not think there is a canned command to help dealing with these
> > broken paths right now.

I think (rm .git/index && git reset) works well enough in most cases,
but not all:

> We could go even fancier and attempt the round-trip twice or more.
> It is possible that the in-index representation will not converge
> when you use a misconfigured pair of clean/smudge filters

This can also happen with eol conversion, for example if you have files
with CRCRLF line endings. The eol conversion will remove only one CR.
Two conversions would be needed to achieve a normalized format. But
iterating (rm .git/index && git reset) does not help. Since we do not
touch the file on disk, after the first round, we have CRCRLF on disk
and CRLF in the index. During the second round, Git reads CRCRLF from
disk again, converts it to CRLF, which matches the index. Even
git reset --hard will not checkout the CRLF version to the worktree.

A possible solution is to iterate (rm -r * && git checkout -- . && git
add -u) until the work tree is clean. Quite ugly.

A command like git add --fix-index would make this conversion less
painful.  It should be ok if the user has to run it several times in
corner cases like CRCRLF, but it would be nice to issue a warning if the
index is still not normalized after running git add --fix-index.

Regarding the name of the option, maybe git add --renormalize-index
would be more consistent, since we also have the related merge option
"renormalize", which is very similar. In fact possibly you can share
some code with it.

Your patch looks good to me otherwise.


Coming back to "[PATCH] optionally disable gitattributes": The topics
are related, because they both deal with the situation where the work
tree has files which are not normalized according to gitattributes. But
my patch is more about saying: ok, I know I may have files which need to
be normalized, but I want to ignore this issue for now. Please disable
gitattributes for now, because I want to work with the files as they are
committed. Conversely, the discussion here is about how to reliably
detect and fix files which are not normalized.
