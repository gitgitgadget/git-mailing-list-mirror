From: Karl =?iso-8859-1?Q?Hasselstr=F6m?= <kha@treskal.com>
Subject: Re: [stgit] understanding why --diff-opts was dropped from stg status
Date: Fri, 29 Aug 2008 00:55:36 +0200
Message-ID: <20080828225536.GC21850@diana.vm.bytemark.co.uk>
References: <20080828214338.GJ4985@nan92-1-81-57-214-146.fbx.proxad.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Catalin Marinas <catalin.marinas@gmail.com>,
	GIT list <git@vger.kernel.org>
To: Yann Dirson <ydirson@altern.org>
X-From: git-owner@vger.kernel.org Fri Aug 29 00:35:08 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KYq4y-0005fx-L1
	for gcvg-git-2@gmane.org; Fri, 29 Aug 2008 00:35:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758290AbYH1Wda convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 28 Aug 2008 18:33:30 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758285AbYH1Wda
	(ORCPT <rfc822;git-outgoing>); Thu, 28 Aug 2008 18:33:30 -0400
Received: from diana.vm.bytemark.co.uk ([80.68.90.142]:4480 "EHLO
	diana.vm.bytemark.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758268AbYH1Wd2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 Aug 2008 18:33:28 -0400
Received: from kha by diana.vm.bytemark.co.uk with local (Exim 3.36 #1 (Debian))
	id 1KYqOu-0005x0-00; Thu, 28 Aug 2008 23:55:36 +0100
Content-Disposition: inline
In-Reply-To: <20080828214338.GJ4985@nan92-1-81-57-214-146.fbx.proxad.net>
X-Manual-Spam-Check: kha@treskal.com, clean
User-Agent: Mutt/1.5.9i
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/94193>

On 2008-08-28 23:43:38 +0200, Yann Dirson wrote:

> It's been quite some time I have been away from stgit developement,
> so I have missed many things.

Yes, we've missed you!

> I just noticed that the post-0.14.3 stable branch contains a change
> that adds tests for "stg status --diff-opts", then one that removes
> that flag claiming it did not work.
>
> Quite puzzled (since it is a feature I heavily used), I tried "git
> co 15ad449" expecting the tests added there would break... but it
> does pass on my box. What problems did you see ?

This is the kind of output you get from git diff-index, diff-files, et
al (from Documentation/diff-format.txt):

in-place edit  :100644 100644 bcd1234... 0123456... M file0
copy-edit      :100644 100644 abcd123... 1234567... C68 file1 file2
rename-edit    :100644 100644 abcd123... 1234567... R86 file1 file3
create         :000000 100644 0000000... 1234567... A file4
delete         :100644 000000 1234567... 0000000... D file5
unmerged       :000000 000000 0000000... 0000000... U file6

Note that in the copy and rename cases (which are only triggered when
-C or -M are in effect) there are two filenames and not one. I don't
recall the details, but the code parsing this output barfed on it. (I
discovered this problem when I added stgit.diff-opts =3D -M to my globa=
l
config, and stg status started failing.) I considered fixing it, but
as I recall making it handle two filenames required more surgery than
I was prepared to do at that point, in the stable branch and all. But
I'm in no way opposed to the feature. Quite the contrary. As long as
it isn't broken ...

( In case you feel like fixing this:
  stgit.lib.git.Repository.diff_tree_files() knows how to parse the
  output including copy and rename records, so no need to write a new
  parser. Just make stg status use this one, and teach it to handle
  pairs of filenames. )

About the test succeeding for you -- are you sure? The stable branch
has an older version of the test suite lib, which just prints "OK" for
expected failures that indeed fail. Try changing that test from
test_expect_success to test_expect_failure, and you should see the
magic blue smoke coming out of your computer ...

--=20
Karl Hasselstr=F6m, kha@treskal.com
      www.treskal.com/kalle
