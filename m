From: Pete Wyckoff <pw@padd.com>
Subject: Re: Test failure in t9814-git-p4-rename.sh - my environment or bad
 test?
Date: Sun, 6 Jul 2014 21:10:17 -0400
Message-ID: <20140707011017.GA3802@padd.com>
References: <CABUJjW-iZU2Dp-yfuf302pNMuMj8NBXTvBW-0UHNxXdSWSk4Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Christoph Bonitz <ml.christophbonitz@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jul 07 03:10:40 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X3xS0-0008E2-J6
	for gcvg-git-2@plane.gmane.org; Mon, 07 Jul 2014 03:10:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752637AbaGGBKW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 6 Jul 2014 21:10:22 -0400
Received: from honk.padd.com ([71.19.245.7]:54206 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752234AbaGGBKV (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 6 Jul 2014 21:10:21 -0400
Received: from arf.padd.com (unknown [50.105.4.164])
	by honk.padd.com (Postfix) with ESMTPSA id 7D0676371;
	Sun,  6 Jul 2014 18:10:20 -0700 (PDT)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 08B912055E; Sun,  6 Jul 2014 21:10:17 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <CABUJjW-iZU2Dp-yfuf302pNMuMj8NBXTvBW-0UHNxXdSWSk4Zw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252945>

ml.christophbonitz@gmail.com wrote on Sun, 06 Jul 2014 16:32 +0200:
> I'm trying to get the git p4 tests to pass on my machine (OS X
> Mavericks) from master before making some changes. I'm experiencing a
> test failure in "detect copies" of the rename test.
> 
> The test creates file2 with some content, creates a few copies (each
> with a commit), then does the following (no git write operations
> omitted):
> echo "file2" >>file2 &&
> cp file2 file10 &&
> git add file2 file10 &&
> git commit -a -m "Modify and copy file2 to file10" &&
> ... (some non-write-operations) ...
> cp file2 file11 &&
> git add file11 &&
> git commit -a -m "Copy file2 to file11" &&
> git diff-tree -r -C --find-copies-harder HEAD &&
> src=$(git diff-tree -r -C --find-copies-harder HEAD | sed 1d | cut -f2) &&
> test "$src" = file10 &&
> 
> This is where it fails on my machine. The git diff-tree output is this
> :100644 100644 22a35c17c4c0779f75142036beef6ccd58525b9c
> 22a35c17c4c0779f75142036beef6ccd58525b9c C100 file2 file11
> so git diff-tree sees file2 as the copy source, not file10. In my
> opinion, the diff-tree result is legitimate (at that point, file2,
> file10 and file11 are identical). Later in the tests, after making
> more copies of file2, the conditions are more flexible, e.g.
> test "$src" = file10 || test "$src" = file11 || test "$src" = file12 &&
> 
> IMO, the test discounts the legitimate possibility of diff-tree
> detecting file2 as source, making unnecessary assumptions about
> implementation details. Is this correct, or do I misunderstand the
> workings of diff-tree?
> 
> I'd be grateful for advice, both on whether this is a bug, and if so,
> which branch to base a patch on.

I think your analysis is correct.  And I agree that later tests
have noticed this ambiguity and added multiple comparisons like
you quote.

I'm not sure how to robustify this.  At least doing the multiple
comparisons should make the tests work again.  The goal of this
series of tests is to make sure that copy detection is working,
not to verify that the correct copy choice was made.  That should
be in other (non-p4) tests.

Do send patches based on Junio's master.  I can ack, and they'll
show up in a future git release.

Thanks!

		-- Pete
