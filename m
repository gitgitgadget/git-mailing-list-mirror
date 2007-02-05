From: Junio C Hamano <junkio@cox.net>
Subject: Re: [PATCH] Use "-f" when adding files with odd names in t9200.
Date: Sun, 04 Feb 2007 17:30:58 -0800
Message-ID: <7vwt2xpezx.fsf@assigned-by-dhcp.cox.net>
References: <1AAD2384-C52D-4D60-A948-4F14C9515B53@silverinsanity.com>
	<20070203181329.GA10192@179.242.249.10.in-addr.arpa>
	<7v4pq358q4.fsf@assigned-by-dhcp.cox.net>
	<F16FE131-CF33-4DD0-9A06-4A24C59C7623@silverinsanity.com>
	<7vabzv3qxi.fsf@assigned-by-dhcp.cox.net>
	<A9623793-111E-47F7-9709-1D569333C40C@silverinsanity.com>
	<7vlkje243u.fsf@assigned-by-dhcp.cox.net>
	<155A5E6A-9EC5-424B-A231-02EF1FE0FD2B@silverinsanity.com>
	<D7716B9E-0F00-4AEF-95BC-699933B7FFD8@silverinsanity.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Brian Gernhardt <benji@silverinsanity.com>
X-From: git-owner@vger.kernel.org Mon Feb 05 02:31:04 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HDshD-00040z-T5
	for gcvg-git@gmane.org; Mon, 05 Feb 2007 02:31:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752654AbXBEBbA convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git@m.gmane.org>); Sun, 4 Feb 2007 20:31:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752655AbXBEBbA
	(ORCPT <rfc822;git-outgoing>); Sun, 4 Feb 2007 20:31:00 -0500
Received: from fed1rmmtai14.cox.net ([68.230.241.45]:51693 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752654AbXBEBa7 convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 4 Feb 2007 20:30:59 -0500
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070205013059.XELS4586.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Sun, 4 Feb 2007 20:30:59 -0500
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo01.cox.net with bizsmtp
	id KdWy1W00J1kojtg0000000; Sun, 04 Feb 2007 20:30:59 -0500
In-Reply-To: <D7716B9E-0F00-4AEF-95BC-699933B7FFD8@silverinsanity.com> (Brian
	Gernhardt's message of "Sun, 4 Feb 2007 11:50:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/38716>

Brian Gernhardt <benji@silverinsanity.com> writes:

> I really think the patch is useful and allows the test to pass even o=
n
> systems with idiotic filesystems and doesn't make it vulnerable to
> any bugs in cvsexportcommit.  (Bugs in git-add, maybe, but that's not
> what it's testing.)

In reality, I find highly valuable that our tests find new bugs
introduced in unexpected places.  I agree that the person who
wrote t9200 did not _mean_ to test "git add", but it ended up
helping us identify the problematic behaviour between creat()
and readdir() on HFS+ affects "git add".

We at least know that the test as written has a problem in an
environment where "touch '$p'; ls | fgrep '$p'" fails, and have
a clear understand why it fails.  I think that knowledge is
valuable -- adding '-f' to the test may hide potential problems
we might have with "git add" in other environments.

So how about doing this instead?  It tests if the filesystem has
that particular issue we know "git add" has a problem with, and
skips the test in such an environment.

---

 t/t9200-git-cvsexportcommit.sh |   14 ++++++++++++++
 1 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/t/t9200-git-cvsexportcommit.sh b/t/t9200-git-cvsexportcomm=
it.sh
index c443f32..4efa0c9 100755
--- a/t/t9200-git-cvsexportcommit.sh
+++ b/t/t9200-git-cvsexportcommit.sh
@@ -169,6 +169,16 @@ test_expect_success \
       test "$(echo $(sort "G g/CVS/Entries"|cut -d/ -f2,3,5))" =3D "wi=
th spaces.png/1.2/-kb with spaces.txt/1.2/"
       )'
=20
+# Some filesystems mangle pathnames with UTF-8 characters --
+# check and skip
+if p=3D"=C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/s/t/u/v/w/x/y/z/=E5=
/=E4/=F6" &&
+	mkdir -p "tst/$p" &&
+	date >"tst/$p/day" &&
+	found=3D$(find tst -type f -print) &&
+	test "z$found" =3D "ztst/$p/day" &&
+	rm -fr tst
+then
+
 # This test contains UTF-8 characters
 test_expect_success \
      'File with non-ascii file name' \
@@ -184,6 +194,10 @@ test_expect_success \
       test "$(echo $(sort =C5/goo/a/b/c/d/e/f/g/h/i/j/k/l/m/n/o/p/q/r/=
s/t/u/v/w/x/y/z/=E5/=E4/=F6/CVS/Entries|cut -d/ -f2,3,5))" =3D "g=E5rde=
ts=E5g=E5rdet.png/1.1/-kb g=E5rdets=E5g=E5rdet.txt/1.1/"
       )'
=20
+fi
+
+rm -fr tst
+
 test_expect_success \
      'Mismatching patch should fail' \
      'date >>"E/newfile5.txt" &&
