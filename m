From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [RFH] Spurious failures of t0025.[34]
Date: Fri, 6 Aug 2010 00:01:28 +0200
Message-ID: <201008060001.28734.trast@student.ethz.ch>
References: <201007292340.01836.trast@student.ethz.ch> <20100730182532.GB18544@coredump.intra.peff.net> <201007310047.46206.trast@student.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: <git@vger.kernel.org>,
	Eyvind Bernhardsen <eyvind.bernhardsen@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Aug 06 00:02:02 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Oh8Vl-0006en-85
	for gcvg-git-2@lo.gmane.org; Fri, 06 Aug 2010 00:02:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932067Ab0HEWBy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Aug 2010 18:01:54 -0400
Received: from gwse.ethz.ch ([129.132.178.238]:39989 "EHLO gwse.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934502Ab0HEWBw (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Aug 2010 18:01:52 -0400
Received: from CAS22.d.ethz.ch (172.31.51.112) by gws01.d.ethz.ch
 (129.132.178.238) with Microsoft SMTP Server (TLS) id 8.2.254.0; Fri, 6 Aug
 2010 00:01:50 +0200
Received: from thomas.site (84.74.100.241) by CAS22.d.ethz.ch (172.31.51.112)
 with Microsoft SMTP Server (TLS) id 14.0.702.0; Fri, 6 Aug 2010 00:01:29
 +0200
User-Agent: KMail/1.13.5 (Linux/2.6.34-12-desktop; KDE/4.4.4; x86_64; ; )
In-Reply-To: <201007310047.46206.trast@student.ethz.ch>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/152726>

Thomas Rast wrote:
> Jeff King wrote:
> > which dumped me with a shell in the "broken" state. The interesting
> > thing is that I can then repeatably run "git diff two" and get an empty
> > diff.  So I don't think the error or race condition is in the run of
> > "git diff" itself, but rather what happened above (presumably the in
> > the read-tree step).
>
> This, and Jonathan's observation about git-apply, finally got me
> somewhere.  The issue is that the index file has a timestamp different
> from the saved mtimes of the file itself.  This can be provoked
> deterministically by the patch below, even without valgrind; valgrind
> merely makes it much more likely to happen by slowing down
> git-read-tree.
>
> Now I don't know what the next step in the chain is.  Who's the
> resident expert on index raciness?  Does git-diff then reindex the
> file, and in doing so, change the index entry?

I did some experiments using ls-files --debug and xxd, and I'm tempted
to blame it on the "impossible" state of the index that results.  The
dump below was made by inserting 'false' into the crlf=true test as in

---- 8< ----
diff --git i/t/t0025-crlf-auto.sh w/t/t0025-crlf-auto.sh
index f5f67a6..f2c2c58 100755
--- i/t/t0025-crlf-auto.sh
+++ w/t/t0025-crlf-auto.sh
@@ -46,6 +46,8 @@ test_expect_success 'crlf=true causes a CRLF file to be normalized' '
 	echo "two crlf" > .gitattributes &&
 	git read-tree --reset -u HEAD &&

+	false &&
+
 	# Note, "normalized" means that git will normalize it if added
 	has_cr two &&
 	twodiff=`git diff two` &&
---- >8 ----

and then using the test with -i.  I even disabled __git_ps1 to be sure
that nothing touches the repo under my nose.

At first, all instances I can get at have the CRLF:

  $ git ls-files -s --debug two
  100644 44fc21c05337594f3e788f058aec8e2f127bb0d7 0       two
    ctime: 1280668935:778139933
    mtime: 1280668935:778139933
    dev: 2054     ino: 5111895
    uid: 1000     gid: 100
    size: 37      flags: 3
  $ xxd two
  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..
  $ git cat-file blob :two | xxd
  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..
  $ git cat-file blob 44fc21c053 | xxd
  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..

This persists even if I remove the file from the worktree and then
restore it:

  $ rm two
  $ git checkout -- two
  $ git ls-files -s --debug two
  100644 44fc21c05337594f3e788f058aec8e2f127bb0d7 0       two
    ctime: 1280669420:849395853
    mtime: 1280669420:849395853
    dev: 2054     ino: 5111895
    uid: 1000     gid: 100
    size: 37      flags: 3
  $ git cat-file blob :two | xxd
  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..

But doing it the other way gives a different object in the index:

  $ git rm --cached two
  rm 'two'
  $ git add two
  warning: CRLF will be replaced by LF in two.
  The file will have its original line endings in your working directory.
  $ git ls-files -s --debug two
  100644 666dbf4b28512a26b262e0c9934c3378061cc353 0       two
    ctime: 1280669420:849395853
    mtime: 1280669420:849395853
    dev: 2054     ino: 5111895
    uid: 1000     gid: 100
    size: 37      flags: 3

And indeed, while the worktree version still has CRLF, the indexed
version has only LFs.

  $ xxd two
  0000000: 490d 0a61 6d0d 0a76 6572 790d 0a76 6572  I..am..very..ver
  0000010: 790d 0a66 696e 650d 0a74 6861 6e6b 0d0a  y..fine..thank..
  0000020: 796f 750d 0a                             you..
  $ git cat-file blob :two | xxd
  0000000: 490a 616d 0a76 6572 790a 7665 7279 0a66  I.am.very.very.f
  0000010: 696e 650a 7468 616e 6b0a 796f 750a       ine.thank.you.

Again nuking from the worktree and restoring from the repository
finally gives LFs everywhere.

  $ rm two
  $ git checkout -- two
  $ git ls-files -s --debug two
  100644 666dbf4b28512a26b262e0c9934c3378061cc353 0       two
    ctime: 1280669504:819361409
    mtime: 1280669504:819361409
    dev: 2054     ino: 5111895
    uid: 1000     gid: 100
    size: 30      flags: 3

  $ xxd two
  0000000: 490a 616d 0a76 6572 790a 7665 7279 0a66  I.am.very.very.f
  0000010: 696e 650a 7468 616e 6b0a 796f 750a       ine.thank.you.


So revisiting the text above

> The issue is that the index file has a timestamp different from the
> saved mtimes of the file itself.
>
> Now I don't know what the next step in the chain is.  Who's the
> resident expert on index raciness?  Does git-diff then reindex the
> file, and in doing so, change the index entry?

and having looked at Documentation/technical/racy-git.txt again, my
current working theory is:

* racy-git defines a file as racily clean if index and stat data agree
  but also the mtimes of index and file agree, so that we cannot be
  sure if the file was edited between saving the index and the next
  tick.

* Therefore, 'two' in the test is racily clean most of the time, but
  not racy (whether it's clean is probably the main point) when I'm
  hitting the failure.

* A racily clean file must be inspected again to see whether it is
  actually clean.  Therefore, git-diff in a "good" run will load the
  worktree copy, convert it to LF, load the index copy, and find that
  they are different.

* However in a "bad" run, the index does not have to be "doubted".
  Apparently it somehow states that the file is still clean, whereas
  it is not.

So I think git-read-tree needs to somehow indicate that the file is
not clean, even though it actually just wrote out a copy of the blob
to the worktree.

--
Thomas Rast
trast@{inf,student}.ethz.ch
