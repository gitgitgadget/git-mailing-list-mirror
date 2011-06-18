From: Elijah Newren <newren@gmail.com>
Subject: jk/maint-merge-rename-create [Was: Re: What's cooking in git.git (Jun
 2011, #02; Sat, 11)]
Date: Sat, 18 Jun 2011 15:49:52 -0600
Message-ID: <BANLkTimkm4SU8nML_6Q7Q34faBziJ=gheA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jay Soffian <jaysoffian@gmail.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Jun 18 23:50:01 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QY3Oz-0003vp-5U
	for gcvg-git-2@lo.gmane.org; Sat, 18 Jun 2011 23:50:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752968Ab1FRVtz convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 18 Jun 2011 17:49:55 -0400
Received: from mail-fx0-f46.google.com ([209.85.161.46]:58902 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752741Ab1FRVtx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 18 Jun 2011 17:49:53 -0400
Received: by fxm17 with SMTP id 17so316868fxm.19
        for <git@vger.kernel.org>; Sat, 18 Jun 2011 14:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type:content-transfer-encoding;
        bh=qg6hRwnRIiIvgdVcLxxVqX3pTRlkw+dPdhKWiD66XXk=;
        b=BFJZdtNc0T0AF2RG78LMumv4f56udNq1LdTEvdoKqqfPPhmeT0j+5x7sG/B3F5M1m9
         iWxBJCTXyc7WQ8FL5U5fuJILG2bIq4cjBD/Va1ca2XvFaYDw1l3MbFdHkpQ7Od16RVNM
         y8OBdBTgFhR6J/a2BxnYfLwrc0tQEL3WOwmIU=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        b=dwedEjJCfcfvOOwa9OZG7guuuQMtSavvA0zWPWr5jbLFC33Nhv3U+OI61A8DMHuymO
         hmm7m2yun2g8/dUzdfwyO8bOQZ09xNSeuGclEeI1OZjOldv4/d2IaYnGokUNgbbcV/81
         KrstK99/jwFAPU64SZe4p1scHkkHQBrVE4Pko=
Received: by 10.223.94.153 with SMTP id z25mr1767380fam.104.1308433792530;
 Sat, 18 Jun 2011 14:49:52 -0700 (PDT)
Received: by 10.223.75.201 with HTTP; Sat, 18 Jun 2011 14:49:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175990>

Hi,

On Thu, Jun 16, 2011 at 3:05 PM, Jeff King <peff@peff.net> wrote:
> Thanks. The sticking point in my series that there is a weird regress=
ion
> it introduces, and I haven't quite figured out the cause.
>
> I'm cc'ing Jay Soffian, who found it. You can reproduce with this rec=
ipe
> (sorry, the chromium repo is huge, but I don't have a smaller test ca=
se
> yet):
>
> =C2=A0git clone http://git.chromium.org/git/chromium.git &&
> =C2=A0cd chromium &&
> =C2=A0git config merge.renameLimit 0 &&
> =C2=A0git checkout 0f6d00c &&
> =C2=A0git cherry-pick d7081a74
=2E..
> If you have any input, I'd appreciate it.

The length of my email may make you change your mind about that.  :-)

Turning on break detection looks like it opens a huge can of worms;
including one issue that I don't understand, namely why break
detection doesn't work when I expect it to.  Let me start with that:

--- Why doesn't break detection work as I expect? ---
$ git init -q
$ printf "1\n2\n3\n4\n5\n6\n7\n8\n9\n10\n" >a
$ printf "a\nb\nc\nd\ne\nf\ng\nh\ni\nj\n" >b
$ git add a b
$ git commit -q -mA

$ git mv a a2
$ git mv b b2
$ git diff --name-status -B -M HEAD
R100    a       a2
R100    b       b2
$ git mv a2 b
$ git mv b2 a
$ git diff --name-status -B -M HEAD
M       a
M       b

I would have expected the output from the last command above to be
R100    a       b
R100    b       a
Why are these renames not detected?  Is there a reason, or is this a bu=
g?


--- Issues with merge-recursive and break detection ---
The chromium repository testcase Jay provided helps uncover a few
extra issues in merge-recursive when turning on break detection, but I
believe there are a number of others that need consideration as well.
Sorry for the lengthy email, but there are lots of little issues.

Whenever the read_tree logic can't handle a merge trivially at a given
path (as per Documentation/technical/trivial-merge.txt), it will load
the three relevant stages for that path into the index.  For
simplicity, let's ignore mode changes, and just consider sha1sums.
Let me name things so we can talk about the various cases:
  o_sha - sha1sum of given path in the merge-base
  a_sha - sha1sum of given path in HEAD
  b_sha - sha1sum of given path on other branch involved in merge

In the case of a rename, there are two files involved, and thus (up
to) 6 relevant stages that merge-recursive.c needs to consider.  Let
me use s_ as a prefix for the source path of a rename and d_ as a
prefix for the destination path of a rename.  That means for renames
the sha1sums we need to consider are:
  old_name -> new_name
  --------    --------
  s_o_sha     d_o_sha
  s_a_sha     d_a_sha
  s_b_sha     d_b_sha

Simple renames will have 3 of those 6 sha1sums be the null sha1; the 3
non-null sha1s will either be {s_o_sha, s_a_sha, d_b_sha} or {s_o_sha,
d_a_sha, s_b_sha}.  Git handles those just fine.

A slight complication is having both of d_[ab]_sha be non-null (while
d_o_sha remains null).  This case is either a rename/rename(2to1)
conflict or a rename/add conflict.  Either way, git has long had code
to handle both of those cases.

A slightly more complicated case is having all three of the s_*_sha be
non-null as well as exactly one of d_[ab]_sha.  Such cases would have
previously resulted in git ignoring old_name as a rename candidate,
since we were not previously using break detection.  Your series is
aimed at handling these cases, so I won't cover them in detail.  I
think you do so correctly for almost all such cases, though I'm
suspicious that there might still be issues with some corner cases
(e.g. with D/F conflicts or rename/rename(1to2) cases).

The problems the chromium repository is triggering is when all d_*_sha
are non-null.  That was impossible before your patch series, since
having all three be non-null meant it was ignored as a rename
candidate.  It also meant no code was ever needed for that case, so
none had been written.  There are a number of possibilites, I'll try
to highlight using example values, using d and e (and later f-i) as
variables standing for sha1sums:

Basic d_*_sha all non-null case:
  old_name    -> new_name
  -----------    -----------
  s_o_sha =3D d    d_o_sha =3D e
  s_a_sha =3D d    d_a_sha =3D e
  s_b_sha =3D 0    d_b_sha =3D d
This suggests that the content originally stored at new_name was
unmodified on one side of history and deleted (or renamed to something
else) on the other.  The content originally stored at old_name has
moved to new_name, so the correct resolution is to delete old_name and
write the contents of d to new_name.  git has no code for this; it
assumes d_o_sha is null and thus sees this case as a rename/add
conflict.

Slightly more complex; 3-way merge:
  s_o_sha =3D d1   d_o_sha =3D e
  s_a_sha =3D d2   d_a_sha =3D e
  s_b_sha =3D 0    d_b_sha =3D d3
This is like the last case, but now we need to do a three way merge of
d1,d2,d3 and store the results at new_name.  It appears that all of
the conflicts you saw with Jay's chromium testcase would be fixed if
there were code for this case.

Slightly more complex; 3-way merge + possible conflict:
  s_o_sha =3D d1   d_o_sha =3D e1
  s_a_sha =3D d2   d_a_sha =3D e2
  s_b_sha =3D 0    d_b_sha =3D d3
In addition to the three-way content merge of d1,d2,d3 that is
supposed to be stored at new_path, there is also a potential
modify/delete problem (e1, e2, -nothing-) that ALSO is supposed to be
stored at new_name.  (What do we call that -- rename+modify/delete
conflict?)  However, there is also a chance that it's not a
modify/delete, but rather another rename using new_path as the source
of the rename -- in which case there would be no conflict at new_path
after all (unless the 3-way merge of d1,d2,d3 had content conflicts).

Slightly more complex: 3-way merge + add conflict despite base presence=
:
  s_o_sha =3D d1   d_o_sha =3D e
  s_a_sha =3D d2   d_a_sha =3D f
  s_b_sha =3D 0    d_b_sha =3D d3
Here the original new_name was either rewritten, deleted, or renamed
on both sides of history.  e, f, and d3 all have nothing to do with
each other, which means that in addition to the three-way content
merge of d1,d2,d3 that is supposed to be stored at new_path, there is
also an added file that is unrelated.  In other words, we either have
a rename/add conflict or a rename/rename(2to1) conflict.

Just for fun:
  file_g         file_h         file_i
  ------------   ------------   ------------
  g_o_sha =3D g1   h_o_sha =3D h1   i_o_sha =3D i1
  g_a_sha =3D g2   h_a_sha =3D h2   i_a_sha =3D i2
  g_b_sha =3D i3   h_b_sha =3D g3   i_b_sha =3D h3
cyclic rename; the side of history being merged into head also had fun
with renames: (file_g, file_h, file_i) -> (file_h, file_i, file_g).
Also, each of file_g, file_h, and file_i were modified on both sides.
Correct resolution: 3-way merge of g1,g2,g3 stored in file_h, 3-way
merge of h1,h2,h3 stored in file_i, and 3-way merge of i1,i2,i3 stored
in file_g.

More complexity with more renames:
The rename/rename (either 1to2 or 2to1) conflicts will involve 9
sha1sums rather than six.  Also, as shown in the previous case, either
the source or the destination path of a rename could be involved (as
either source or destination) of yet another rename.

Don't forget the pesky D/F possibilities:
The possibility of D/F conflicts complicates things slightly -- for
example, both the source and destination paths of a rename could be
involved in a D/F conflict, and thus we may need to record the
conflicts at an alternate location.  Whether we need to do so or not
cannot be determined in process_renames(); therefore, the extra
handling we add for both source and destination entries (at least the
final index/working-directory changes) should be deferred until later.
 There may also be interesting ramifications for criss-cross merges
due to these break rewrite cases as well.

Stuff I'm still ignoring:
As Junio noted previously, break detection could be used to note that
a modify/delete conflict is really a delete/delete/add and thus there
should be no conflict.  Also, a rename/modify that has odd content
conflicts might be easier to handle if it was determined that it was
really a rename/delete/add-source case.  The only thing I'm
considering above is using break-detection as a way to get better
rename detection.


Elijah
