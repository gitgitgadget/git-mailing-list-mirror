From: Dominique Quatravaux <domq@google.com>
Subject: git rebase and merge commits
Date: Wed, 20 Oct 2010 18:45:45 +0200
Message-ID: <AANLkTikroNPehcyBsueCnJ5hR0idd3cBP4m1KNccdRqL@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Oct 20 18:46:22 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P8bny-0001WE-0e
	for gcvg-git-2@lo.gmane.org; Wed, 20 Oct 2010 18:46:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754312Ab0JTQqK convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 20 Oct 2010 12:46:10 -0400
Received: from smtp-out.google.com ([74.125.121.35]:19236 "EHLO
	smtp-out.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754163Ab0JTQqI convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 20 Oct 2010 12:46:08 -0400
Received: from wpaz33.hot.corp.google.com (wpaz33.hot.corp.google.com [172.24.198.97])
	by smtp-out.google.com with ESMTP id o9KGk6vg013289
	for <git@vger.kernel.org>; Wed, 20 Oct 2010 09:46:07 -0700
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=google.com; s=beta;
	t=1287593167; bh=oHhgDAFWJGFkN/YC+QMnBTZ7nuw=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Content-Type:
	 Content-Transfer-Encoding;
	b=l138WABxage1PNyTxT1EQX6T7kVFVADorX3X7e6OCHfcs6Ig+JKy7LPFIqqlTMnI/
	 oSeyM3FG3mbMxPcx7ZI3g==
Received: from gxk28 (gxk28.prod.google.com [10.202.11.28])
	by wpaz33.hot.corp.google.com with ESMTP id o9KGk5xM013296
	for <git@vger.kernel.org>; Wed, 20 Oct 2010 09:46:05 -0700
Received: by gxk28 with SMTP id 28so2681270gxk.15
        for <git@vger.kernel.org>; Wed, 20 Oct 2010 09:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=beta;
        h=domainkey-signature:received:mime-version:received:from:date
         :message-id:subject:to:content-type:content-transfer-encoding;
        bh=ZwhyTOzBIXA5lJYonH899hj7qnCNbyMmYV/lVMy63Fs=;
        b=R19jt6sMG7jJnk4JsB6145n7sJZa6nGIb0BiHX6cn1osvXyADkDQdpsMuY2kjO8Tm4
         b9oFseh5UQuzWxOgt2hg==
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=google.com; s=beta;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        b=J/f6vjJu4DjTjMGoG5QRNp1II1OmdrNtemI7Vh1ATDaVhplsq7yDiqlQKMnLL/EkgF
         CkBtcBcBl2Q/V7n2uv0w==
Received: by 10.101.40.1 with SMTP id s1mr5585973anj.248.1287593165310; Wed,
 20 Oct 2010 09:46:05 -0700 (PDT)
Received: by 10.100.249.8 with HTTP; Wed, 20 Oct 2010 09:45:45 -0700 (PDT)
X-System-Of-Record: true
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159416>

Hi all, I'm trying to write "git shove", a wrapper around git rebase
--interactive that would turn this


#        A---B---C---K targetbranch
#       /         \
#  D---E---F---G---H---I--J srcbranch

into this:

#   A---B---C---I'---K'  targetbranch
#  /             \
# D---E---F---G---H'---J' srcbranch
#

(ie I has been shoved into targetbranch).

It seemed to me that the first step should be to simply rebase I, H, an=
d J (in
this order) onto C. Unfortunately git rebase --interactive -p C propose=
s a
git-rebase-todo that contains only "noop"; if I forcefully put this ins=
tead,

edit iiii I
edit hhhh H
edit jjjj J

it seems to me that the HEAD jumps backward to the original H on the se=
cond
rebase step, instead of daisy-chaining H behind I.  This is with git 1.=
7.3.1.

Here are the outputs of git log --graph --pretty=3Doneline --abbrev-com=
mit at each
rebase step:

1/3

* a810395 I
*   1cfccc7 H
|\
| * c477d4e C
| * 7002290 B
| * aa9f1d0 A
* | b614d31 G
* | 2ad4496 F
|/
* 0d512e9 E
* b6cbc2b D

2/3

*   1cfccc7 H
|\
| * c477d4e C
| * 7002290 B
| * aa9f1d0 A
* | b614d31 G
* | 2ad4496 F
|/
* 0d512e9 E
* b6cbc2b D

3/3

* 3a41a45 J
* a810395 I
*   1cfccc7 H
|\
| * c477d4e C
| * 7002290 B
| * aa9f1d0 A
* | b614d31 G
* | 2ad4496 F
|/
* 0d512e9 E
* b6cbc2b D


Is there a way to do a real rebase of a merge commit?

=46WIW, here is the script I use to create my toy environment in the cu=
rrent
directory:

function _make_commit() {
  echo "$1" > "$1"
  git add "$1"
  git commit -a -m "$1"
  git tag "$1" HEAD
}

function _prepare_merged_history() {
  git init
  _make_commit "D"
  git checkout -b targetbranch
  _make_commit "E"
  _make_commit "A"
  _make_commit "B"
  _make_commit "C"
  _make_commit "K"
  git checkout E
  git checkout -b srcbranch
  _make_commit "F"
  _make_commit "G"
  git merge  -m "H" C
  git tag H HEAD
  _make_commit "I"
  _make_commit "J"
}

function _git_rebase_todo_line() {
  echo -n "pick "
  git rev-list -n 1 --pretty=3Doneline --abbrev-commit --abbrev=3D7 "$1=
"
}

function _make_git_rebase_todo() {
  {
    _git_rebase_todo_line refs/tags/I
    _git_rebase_todo_line refs/tags/H
    _git_rebase_todo_line refs/tags/J
  } > git-rebase-todo
}

[ -d ".git" ] && exit
_prepare_merged_history
_make_git_rebase_todo


Thanks in advance,

--=20
=A0 Dominique Quatravaux
=A0 +41 79 609 40 72
