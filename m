From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: BUG: git-svn dcommit and concurrency (Re: git svn dcommit errors all
 no-yet-commited changes are left squashed/uncommited?)
Date: Wed, 13 Apr 2011 21:48:55 +0200
Message-ID: <BANLkTikdGPW+B7rAEVj2DZhOS1HrtXjZ4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=0016e6470ef85378ad04a0d219ed
Cc: Eric Wong <normalperson@yhbt.net>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Apr 13 21:49:36 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QA64B-0000sP-UH
	for gcvg-git-2@lo.gmane.org; Wed, 13 Apr 2011 21:49:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758148Ab1DMTtY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Apr 2011 15:49:24 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:48666 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757958Ab1DMTs5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Apr 2011 15:48:57 -0400
Received: by vws1 with SMTP id 1so746535vws.19
        for <git@vger.kernel.org>; Wed, 13 Apr 2011 12:48:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:date:message-id:subject:from:to:cc
         :content-type;
        bh=pMiDoUUTtUmO4L7RqUYW0da/wNz7i+gcjbv+SIat7pU=;
        b=Ju3UGMAs7NG4bZfPgVvPYf2MKQwUyWehjCugI6pF9+o72FeFuYwm+npSmFACcJsGie
         5/e6oxZQlTOtIhyQ6JrhNkhKgXlY9e8hOMk07bmWFIlYY6FnYrU9u/DwLQNYpuRh98UT
         vt7GXkYx7gi/ZekeExzlTRyx2/bAl33ahdiws=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        b=dziWZ/k9lejGO6hScp+JipOZznfBCgCokLQu6mmABncWLXnF4xZMr5pKy8RdcS9oee
         7BlfujdGVvk5xPTf1MmJRDAbKNSce2IZuEO3YbqK4YG+JsSxkMn8bsXIK2hWmuG0owIE
         DjuF0vLM5NJF5rMVLmTGgmoNpkFblNl12h7dQ=
Received: by 10.220.96.130 with SMTP id h2mr2476483vcn.121.1302724135318; Wed,
 13 Apr 2011 12:48:55 -0700 (PDT)
Received: by 10.220.180.202 with HTTP; Wed, 13 Apr 2011 12:48:55 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/171481>

--0016e6470ef85378ad04a0d219ed
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hello again,

resending mail, this time with involved people on CC and with clearer messa=
ge.

I believe there's a bug in git-svn dcommit.

If during dcommit someone else commits to svn repository then git
a) stops
b) loses commits not-yet dcommitted

"a" is bug IMO, because it seems to work sometimes (only for first
dcommited change?)
"b" is more severe, because it destroys user data (in a way) - you
have to use reflog to get it back, I believe.

I have reproduced it locally - added "sleep" to git-svn in the dcommit
loop and did svn commit when it slept.

Pasting log from dcommit below. Notes:
- local git commits and unfetched svn commits were not conflicting
(changed different files)
- when starting dcommit there was one unfetched commit (r4) - this
worked without problems
- new change commited to svn was r8 - during sleep after r6
- "git log remotes/git-svn.." shows nothing =3D> commit history is lost
- "git diff" shows all not-yet-commited changes merged in working tree

---------------------------------------------------------------------------=
-------------
piotr@piotr-laptop:/tmp/d/b$ git svn dcommit
Committing to file:///tmp/b ...
	A	two.txt
Committed r5
	M	file.txt
r4 =3D 161ef277a311148c42a4391fab1531b818d6b8ba (refs/remotes/git-svn)
	A	two.txt
r5 =3D e2ac55eff258832e0dc7612b9a12913c861897a3 (refs/remotes/git-svn)
W: 9a64a0288d5474a78eb528c81efe38a026331fdb and refs/remotes/git-svn
differ, using rebase:
:100644 100644 b77ce16c276583c177f535cde69e8764ee4a1497
928a139863b65711aa12167b81fefccfacc00d69 M	file.txt
First, rewinding head to replay your work on top of it...
Applying: three.txt
Applying: next
Applying: next
Applying: next
Applying: next
Sleeping...
	A	three.txt
Committed r6
	A	three.txt
r6 =3D fe11637f550e3158acf333cbd6197fbc775d9000 (refs/remotes/git-svn)
No changes between current HEAD and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
Unstaged changes after reset:
M	three.txt
Sleeping...
	M	three.txt
Committed r7
	M	three.txt
r7 =3D 9ebda9f54668427441daa97b0f152eb1885d266b (refs/remotes/git-svn)
No changes between current HEAD and refs/remotes/git-svn
Resetting to the latest refs/remotes/git-svn
Unstaged changes after reset:
M	three.txt
Sleeping...
	M	three.txt
Committed r9
	M	file.txt
r8 =3D 92bcba5a1a5be41d4393be1810bed0e9417da1a8 (refs/remotes/git-svn)
	M	three.txt
r9 =3D 6988d79c042c21534241e4f6e82ef29056ce69bc (refs/remotes/git-svn)
W: cdc341b381aab0ab01233bcc0b47d36acef75eb8 and refs/remotes/git-svn
differ, using rebase:
:100644 100644 928a139863b65711aa12167b81fefccfacc00d69
a063167d351d2715c1a612cd0f431ac77b9eba92 M	file.txt
Cannot rebase: You have unstaged changes.
Please commit or stash them.
rebase refs/remotes/git-svn: command returned error: 1

piotr@piotr-laptop:/tmp/d/b$ git status
# On branch master
# Changes not staged for commit:
#   (use "git add <file>..." to update what will be committed)
#   (use "git checkout -- <file>..." to discard changes in working director=
y)
#
#	modified:   three.txt
#
no changes added to commit (use "git add" and/or "git commit -a")
piotr@piotr-laptop:/tmp/d/b$ git log remotes/git-svn..
piotr@piotr-laptop:/tmp/d/b$ git diff
diff --git a/three.txt b/three.txt
index 7bfc0fd..ce447d2 100644
--- a/three.txt
+++ b/three.txt
@@ -1,2 +1,5 @@
 three
 next
+next
+next
+next
---------------------------------------------------------------------------=
-------------

I'm also attaching "sleep" patch, logs from creating/commiting to svn
repository and from git svn clone for convenience (some messages from
svn are in Polish but that shouldn't matter)

git version 1.7.5-rc1


On Mon, Apr 11, 2011 at 4:32 PM, Piotr Krukowiecki
<piotr.krukowiecki@gmail.com> wrote:
> Hi,
>
> I've done some changes to "local" trunk, dcomitted them to svn server,
> then cherry-picked those changes to "local" branch and tried to
> dcommit them to svn.
> Several changes where successfully dcommited, but then I got an error.
>
> Two problems:
> 1. after the error I'm left with changes not sent to svn server as
> unstaged changes
> 2. git-svn errors if someone commits something to svn during my commit
> even if there is no conflict
>
> Even if the second problem is intentional (which I'm not sure is a
> good idea), the first problem means it's not possible to continue
> after the error (which is not really an error but should be a warning,
> even if it stops the dcommit).
>
>
> Full story:
>
> The log looked like this:
>
> [... this is the end of older commit, which succeeded ...]
> W: -empty_dir: cptests/branches/a_branch/src/file
> r23939 =3D 400e84221ca15be3976ba4dcd6d7a2eb1464b00e (refs/remotes/a_branc=
h)
> No changes between current HEAD and refs/remotes/a_branch
> Resetting to the latest refs/remotes/a_branch
> Unstaged changes after reset:
> M =A0 =A0 =A0 src/file
> [... next commit preparation and commit ...]
> =A0 =A0 =A0 =A0R =A0 =A0 =A0 src/file
> Committed r23941
> =A0 =A0 =A0 =A0M =A0 =A0 =A0 etc/file.xml
> r23940 =3D 420c7b2c8f155563a4f4c8e5421857846bf3ebe5 (refs/remotes/a_branc=
h)
> =A0 =A0 =A0 =A0D =A0 =A0 =A0 src/file
> [...]
> r23941 =3D 010c5b3883c473dd236de1a146fad1e90bd323fd (refs/remotes/a_branc=
h)
> W: bfb909cb21e26930364331660460ccd7be355a2e and refs/remotes/a_branch
> differ, using rebase:
> :040000 040000 5df0982b1cf277dd7d915d32a9ff145554fb9c94
> a662095f06bd349c1a458d52697561ba9d005bac M =A0 =A0 =A0etc
> Cannot rebase: You have unstaged changes.
> Please commit or stash them.
> rebase refs/remotes/a_branch: command returned error: 1
>
> Now I was left with all the remaining changes "squashed" - git status
> showed a list of unstaged changes. So all changes not yet commited
> were in fact lost as commits and left in the working tree as one bit
> not-yet-added change.
>
> I believe the reason for this was that while I was dcommiting my
> changes someone changed the "etc/file.xml"
>
> So my previous dcommit was r23939 (src/*). Then someone else checked
> into svn r23940 (etc/file.xml). Then (or earlier) git svn dcommited
> r23941 (src/*). After that dcommit stopped with error.
>
>
> In this case I have just reset --hard and cherry-picked changes that
> were not commited, and it worked this time, but I wonder what should I
> do next time.
> What if those are not cherry-picked changes, but normal changes? Will
> I have to use reflog to get back in time?
>
> Also, I think in this case svn might continue with dcommit. It already
> commited one revision after the other-person commit. The other commit
> changed a completely different directory.
>
> Even if this is left as error, it should be possible to continue
> dcommit in an easy way. Not-commited changes should not be deleted and
> left as unstaged changes.
>
> Also, the "you have unstaged changes" error is not very helpful. I
> thought it meant it commited a change partially, or maybe some other
> weird thing happened.
>
>
> Thanks,
>
> --
> Piotr Krukowiecki
>



--=20
Piotr Krukowiecki

--0016e6470ef85378ad04a0d219ed
Content-Type: text/plain; charset=UTF-8; name="svn.txt"
Content-Disposition: attachment; filename="svn.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmgo9vlq1

cGlvdHJAcGlvdHItbGFwdG9wOi90bXAvYyQgc3ZuIGNoZWNrb3V0IGZpbGU6Ly8vdG1wL2IKUG9i
cmFubyB3ZXJzasSZIDAuCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2MkIGNkIGIKcGlvdHJAcGlv
dHItbGFwdG9wOi90bXAvYy9iJCBlY2hvIGhpID4gZmlsZS50eHQKcGlvdHJAcGlvdHItbGFwdG9w
Oi90bXAvYy9iJCBzdm4gYWRkIGZpbGUudHh0CkEgICAgICAgICBmaWxlLnR4dApwaW90ckBwaW90
ci1sYXB0b3A6L3RtcC9jL2IkIHN2biBjb21taXQKRG9kYXdhbmllICAgICAgIGZpbGUudHh0ClBy
emVzecWCYW5pZSB0cmXFm2NpIHBsaWt1IC4KWmF0d2llcmR6b25hIHdlcnNqYSAxLgpwaW90ckBw
aW90ci1sYXB0b3A6L3RtcC9jL2IkIGVjaG8gc3ZuIG5leHQgPj4gZmlsZS50eHQgJiYgc3ZuIGNv
bW1pdCAtbSAic3ZuIG5leHQiCld5c3nFgmFuaWUgICAgICAgZmlsZS50eHQKUHJ6ZXN5xYJhbmll
IHRyZcWbY2kgcGxpa3UgLgpaYXR3aWVyZHpvbmEgd2Vyc2phIDIuCnBpb3RyQHBpb3RyLWxhcHRv
cDovdG1wL2MvYiQgZWNobyBzdm4gbmV4dCA+PiBmaWxlLnR4dCAmJiBzdm4gY29tbWl0IC1tICJz
dm4gbmV4dCIKV3lzecWCYW5pZSAgICAgICBmaWxlLnR4dApQcnplc3nFgmFuaWUgdHJlxZtjaSBw
bGlrdSAuClphdHdpZXJkem9uYSB3ZXJzamEgMy4KcGlvdHJAcGlvdHItbGFwdG9wOi90bXAvYy9i
JCBlY2hvIHN2biBuZXh0ID4+IGZpbGUudHh0ICYmIHN2biBjb21taXQgLW0gInN2biBuZXh0IgpX
eXN5xYJhbmllICAgICAgIGZpbGUudHh0ClByemVzecWCYW5pZSB0cmXFm2NpIHBsaWt1IC4KWmF0
d2llcmR6b25hIHdlcnNqYSA0LgpwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9jL2IkIGVjaG8gc3Zu
IG5leHQgPj4gZmlsZS50eHQgJiYgc3ZuIGNvbW1pdCAtbSAic3ZuIG5leHQiCld5c3nFgmFuaWUg
ICAgICAgZmlsZS50eHQKUHJ6ZXN5xYJhbmllIHRyZcWbY2kgcGxpa3UgLgpaYXR3aWVyZHpvbmEg
d2Vyc2phIDguCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2MvYiQgCg==
--0016e6470ef85378ad04a0d219ed
Content-Type: text/x-patch; charset=US-ASCII; name="git-svn.perl.diff"
Content-Disposition: attachment; filename="git-svn.perl.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmgnydq90

ZGlmZiAtLWdpdCBhL2dpdC1zdm4ucGVybCBiL2dpdC1zdm4ucGVybAppbmRleCBiZjA0NTFiLi4w
ZWE1MzAyIDEwMDc1NQotLS0gYS9naXQtc3ZuLnBlcmwKKysrIGIvZ2l0LXN2bi5wZXJsCkBAIC02
NTAsNiArNjUwLDggQEAgc3ViIGNtZF9kY29tbWl0IHsKIAkJCQkkbGluZWFyX3JlZnMgPSBcQGw7
CiAJCQl9CiAJCX0KKwkJcHJpbnQgIlNsZWVwaW5nLi4uXG4iOworCQlzbGVlcCAxMDsKIAl9CiAK
IAlpZiAoJG9sZF9oZWFkKSB7Cg==
--0016e6470ef85378ad04a0d219ed
Content-Type: text/plain; charset=UTF-8; name="git.txt"
Content-Disposition: attachment; filename="git.txt"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_gmgoa2kr2

cGlvdHJAcGlvdHItbGFwdG9wOi90bXAvZCQgZ2l0IHN2biBjbG9uZSBmaWxlOi8vL3RtcC9iCklu
aXRpYWxpemVkIGVtcHR5IEdpdCByZXBvc2l0b3J5IGluIC90bXAvZC9iLy5naXQvCglBCWZpbGUu
dHh0CnIxID0gODcwMjhhNWQ4ZmVjNzc4ODk4YmU3NmU5OWFkNzkxMjE5Y2YyMzAwMyAocmVmcy9y
ZW1vdGVzL2dpdC1zdm4pCkNoZWNrZWQgb3V0IEhFQUQ6CiAgZmlsZTovLy90bXAvYiByMQpwaW90
ckBwaW90ci1sYXB0b3A6L3RtcC9kJCBjZCBiCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2QvYiQg
bHMKZmlsZS50eHQKcGlvdHJAcGlvdHItbGFwdG9wOi90bXAvZC9iJCBnaXQgc3ZuIGluZm8KUGF0
aDogLgpVUkw6IGZpbGU6Ly8vdG1wL2IKUmVwb3NpdG9yeSBSb290OiBmaWxlOi8vL3RtcC9iClJl
cG9zaXRvcnkgVVVJRDogODYyMjA1NDctZmY5Ni00YjAwLWEzZjAtZmE1NzE5NDVkMGJhClJldmlz
aW9uOiAxCk5vZGUgS2luZDogZGlyZWN0b3J5ClNjaGVkdWxlOiBub3JtYWwKTGFzdCBDaGFuZ2Vk
IEF1dGhvcjogcGlvdHIKTGFzdCBDaGFuZ2VkIFJldjogMQpMYXN0IENoYW5nZWQgRGF0ZTogMjAx
MS0wNC0xMyAyMDo1NToyMyArMDIwMCAoxZtybywgMTMga3dpIDIwMTEpCgpwaW90ckBwaW90ci1s
YXB0b3A6L3RtcC9kL2IkIGVjaG8gdHdvID4gdHdvLnR4dApwaW90ckBwaW90ci1sYXB0b3A6L3Rt
cC9kL2IkIGdpdCBhZGQgdHdvLnR4dApwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9kL2IkIGdpdCBj
b21taXQgLW0gdHdvClttYXN0ZXIgMDFlNWUwYV0gdHdvCiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9ucygrKSwgMCBkZWxldGlvbnMoLSkKIGNyZWF0ZSBtb2RlIDEwMDY0NCB0d28udHh0CnBp
b3RyQHBpb3RyLWxhcHRvcDovdG1wL2QvYiQgZWNobyB0aHJlZSA+IHRocmVlLnR4dApwaW90ckBw
aW90ci1sYXB0b3A6L3RtcC9kL2IkIGdpdCBhZGQgdGhyZWUudHh0CnBpb3RyQHBpb3RyLWxhcHRv
cDovdG1wL2QvYiQgZ2l0IGNvbW1pdCAtbSB0aHJlZS50eHQKW21hc3RlciBkMjg0NzY4XSB0aHJl
ZS50eHQKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCspLCAwIGRlbGV0aW9ucygtKQog
Y3JlYXRlIG1vZGUgMTAwNjQ0IHRocmVlLnR4dApwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9kL2Ik
IGVjaG8gbmV4dCA+PiB0aHJlZS50eHQgJiYgZ2l0IGFkZCB0aHJlZS50eHQgJiYgZ2l0IGNvbW1p
dCAtbSBuZXh0ClttYXN0ZXIgMGEwYzBjY10gbmV4dAogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2Vy
dGlvbnMoKyksIDAgZGVsZXRpb25zKC0pCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2QvYiQgZWNo
byBuZXh0ID4+IHRocmVlLnR4dCAmJiBnaXQgYWRkIHRocmVlLnR4dCAmJiBnaXQgY29tbWl0IC1t
IG5leHQKW21hc3RlciA3N2Q5MWY4XSBuZXh0CiAxIGZpbGVzIGNoYW5nZWQsIDEgaW5zZXJ0aW9u
cygrKSwgMCBkZWxldGlvbnMoLSkKcGlvdHJAcGlvdHItbGFwdG9wOi90bXAvZC9iJCBlY2hvIG5l
eHQgPj4gdGhyZWUudHh0ICYmIGdpdCBhZGQgdGhyZWUudHh0ICYmIGdpdCBjb21taXQgLW0gbmV4
dApbbWFzdGVyIGNlYTE3YjBdIG5leHQKIDEgZmlsZXMgY2hhbmdlZCwgMSBpbnNlcnRpb25zKCsp
LCAwIGRlbGV0aW9ucygtKQpwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9kL2IkIGVjaG8gbmV4dCA+
PiB0aHJlZS50eHQgJiYgZ2l0IGFkZCB0aHJlZS50eHQgJiYgZ2l0IGNvbW1pdCAtbSBuZXh0Cltt
YXN0ZXIgZmY0NDA0NF0gbmV4dAogMSBmaWxlcyBjaGFuZ2VkLCAxIGluc2VydGlvbnMoKyksIDAg
ZGVsZXRpb25zKC0pCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2QvYiQgZ2l0IGxvZwpjb21taXQg
ZmY0NDA0NDRhNWI4ZTM4MGZiNDQxODBkODZmNjZiYjU2NjkwN2E1MwpBdXRob3I6IFBpb3RyIEty
dWtvd2llY2tpIDw+CkRhdGU6ICAgV2VkIEFwciAxMyAyMTowMjoyMSAyMDExICswMjAwCgogICAg
bmV4dAoKY29tbWl0IGNlYTE3YjAyOGIxOTVkMjk4OGVlNWU0ZGM5ZGEwYmQ0ZmZhNWM1N2EKQXV0
aG9yOiBQaW90ciBLcnVrb3dpZWNraSA8PgpEYXRlOiAgIFdlZCBBcHIgMTMgMjE6MDI6MjEgMjAx
MSArMDIwMAoKICAgIG5leHQKCmNvbW1pdCA3N2Q5MWY4OGJmOWFlODFkNzQ3ZDgwYmI1YzM3MGQx
NmU3NjczN2ZmCkF1dGhvcjogUGlvdHIgS3J1a293aWVja2kgPD4KRGF0ZTogICBXZWQgQXByIDEz
IDIxOjAyOjIwIDIwMTEgKzAyMDAKCiAgICBuZXh0Cgpjb21taXQgMGEwYzBjYzBmNjEyMWQ4MTM5
MmQ4ZGY4MDQ0MGJlZjQyOTI3MGIxNgpBdXRob3I6IFBpb3RyIEtydWtvd2llY2tpIDw+CkRhdGU6
ICAgV2VkIEFwciAxMyAyMTowMjoxOSAyMDExICswMjAwCgogICAgbmV4dAoKY29tbWl0IGQyODQ3
Njg2NTg1N2E5ZmZmMjM3YjI5ODY5YmYyMWIzYzgzZDkxNmUKQXV0aG9yOiBQaW90ciBLcnVrb3dp
ZWNraSA8PgpEYXRlOiAgIFdlZCBBcHIgMTMgMjE6MDE6NDEgMjAxMSArMDIwMAoKICAgIHRocmVl
LnR4dAoKY29tbWl0IDAxZTVlMGFiYjljMTMzYTZmZjdlZjg1YmJiZGJjMmM5ODIyOWNkNjgKQXV0
aG9yOiBQaW90ciBLcnVrb3dpZWNraSA8PgpEYXRlOiAgIFdlZCBBcHIgMTMgMjE6MDE6MjAgMjAx
MSArMDIwMAoKICAgIHR3bwoKY29tbWl0IDg3MDI4YTVkOGZlYzc3ODg5OGJlNzZlOTlhZDc5MTIx
OWNmMjMwMDMKQXV0aG9yOiBwaW90ciA8cGlvdHJAODYyMjA1NDctZmY5Ni00YjAwLWEzZjAtZmE1
NzE5NDVkMGJhPgpEYXRlOiAgIFdlZCBBcHIgMTMgMTg6NTU6MjMgMjAxMSArMDAwMAoKICAgIGhp
CiAgICAKICAgIAogICAgZ2l0LXN2bi1pZDogZmlsZTovLy90bXAvYkAxIDg2MjIwNTQ3LWZmOTYt
NGIwMC1hM2YwLWZhNTcxOTQ1ZDBiYQpwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9kL2IkIGdpdCBz
dm4gcmViYXNlCglNCWZpbGUudHh0CnIyID0gMTA1NWM4YTkyMzlkN2E3NTg1NmY5NGE2NDc5MTky
MTU4ZTEwNzNlYyAocmVmcy9yZW1vdGVzL2dpdC1zdm4pCglNCWZpbGUudHh0CnIzID0gYzljOTE4
YTAxOGQyMWU2YWY4ZjRiM2Q0ZTIyYTJhYTcwMDAyNGVjYSAocmVmcy9yZW1vdGVzL2dpdC1zdm4p
CkZpcnN0LCByZXdpbmRpbmcgaGVhZCB0byByZXBsYXkgeW91ciB3b3JrIG9uIHRvcCBvZiBpdC4u
LgpBcHBseWluZzogdHdvCkFwcGx5aW5nOiB0aHJlZS50eHQKQXBwbHlpbmc6IG5leHQKQXBwbHlp
bmc6IG5leHQKQXBwbHlpbmc6IG5leHQKQXBwbHlpbmc6IG5leHQKcGlvdHJAcGlvdHItbGFwdG9w
Oi90bXAvZC9iJCBnaXQgc3ZuIGRjb21taXQKQ29tbWl0dGluZyB0byBmaWxlOi8vL3RtcC9iIC4u
LgoJQQl0d28udHh0CkNvbW1pdHRlZCByNQoJTQlmaWxlLnR4dApyNCA9IDE2MWVmMjc3YTMxMTE0
OGM0MmE0MzkxZmFiMTUzMWI4MThkNmI4YmEgKHJlZnMvcmVtb3Rlcy9naXQtc3ZuKQoJQQl0d28u
dHh0CnI1ID0gZTJhYzU1ZWZmMjU4ODMyZTBkYzc2MTJiOWExMjkxM2M4NjE4OTdhMyAocmVmcy9y
ZW1vdGVzL2dpdC1zdm4pClc6IDlhNjRhMDI4OGQ1NDc0YTc4ZWI1MjhjODFlZmUzOGEwMjYzMzFm
ZGIgYW5kIHJlZnMvcmVtb3Rlcy9naXQtc3ZuIGRpZmZlciwgdXNpbmcgcmViYXNlOgo6MTAwNjQ0
IDEwMDY0NCBiNzdjZTE2YzI3NjU4M2MxNzdmNTM1Y2RlNjllODc2NGVlNGExNDk3IDkyOGExMzk4
NjNiNjU3MTFhYTEyMTY3YjgxZmVmY2NmYWNjMDBkNjkgTQlmaWxlLnR4dApGaXJzdCwgcmV3aW5k
aW5nIGhlYWQgdG8gcmVwbGF5IHlvdXIgd29yayBvbiB0b3Agb2YgaXQuLi4KQXBwbHlpbmc6IHRo
cmVlLnR4dApBcHBseWluZzogbmV4dApBcHBseWluZzogbmV4dApBcHBseWluZzogbmV4dApBcHBs
eWluZzogbmV4dApTbGVlcGluZy4uLgoJQQl0aHJlZS50eHQKQ29tbWl0dGVkIHI2CglBCXRocmVl
LnR4dApyNiA9IGZlMTE2MzdmNTUwZTMxNThhY2YzMzNjYmQ2MTk3ZmJjNzc1ZDkwMDAgKHJlZnMv
cmVtb3Rlcy9naXQtc3ZuKQpObyBjaGFuZ2VzIGJldHdlZW4gY3VycmVudCBIRUFEIGFuZCByZWZz
L3JlbW90ZXMvZ2l0LXN2bgpSZXNldHRpbmcgdG8gdGhlIGxhdGVzdCByZWZzL3JlbW90ZXMvZ2l0
LXN2bgpVbnN0YWdlZCBjaGFuZ2VzIGFmdGVyIHJlc2V0OgpNCXRocmVlLnR4dApTbGVlcGluZy4u
LgoJTQl0aHJlZS50eHQKQ29tbWl0dGVkIHI3CglNCXRocmVlLnR4dApyNyA9IDllYmRhOWY1NDY2
ODQyNzQ0MWRhYTk3YjBmMTUyZWIxODg1ZDI2NmIgKHJlZnMvcmVtb3Rlcy9naXQtc3ZuKQpObyBj
aGFuZ2VzIGJldHdlZW4gY3VycmVudCBIRUFEIGFuZCByZWZzL3JlbW90ZXMvZ2l0LXN2bgpSZXNl
dHRpbmcgdG8gdGhlIGxhdGVzdCByZWZzL3JlbW90ZXMvZ2l0LXN2bgpVbnN0YWdlZCBjaGFuZ2Vz
IGFmdGVyIHJlc2V0OgpNCXRocmVlLnR4dApTbGVlcGluZy4uLgoJTQl0aHJlZS50eHQKQ29tbWl0
dGVkIHI5CglNCWZpbGUudHh0CnI4ID0gOTJiY2JhNWExYTViZTQxZDQzOTNiZTE4MTBiZWQwZTk0
MTdkYTFhOCAocmVmcy9yZW1vdGVzL2dpdC1zdm4pCglNCXRocmVlLnR4dApyOSA9IDY5ODhkNzlj
MDQyYzIxNTM0MjQxZTRmNmU4MmVmMjkwNTZjZTY5YmMgKHJlZnMvcmVtb3Rlcy9naXQtc3ZuKQpX
OiBjZGMzNDFiMzgxYWFiMGFiMDEyMzNiY2MwYjQ3ZDM2YWNlZjc1ZWI4IGFuZCByZWZzL3JlbW90
ZXMvZ2l0LXN2biBkaWZmZXIsIHVzaW5nIHJlYmFzZToKOjEwMDY0NCAxMDA2NDQgOTI4YTEzOTg2
M2I2NTcxMWFhMTIxNjdiODFmZWZjY2ZhY2MwMGQ2OSBhMDYzMTY3ZDM1MWQyNzE1YzFhNjEyY2Qw
ZjQzMWFjNzdiOWViYTkyIE0JZmlsZS50eHQKQ2Fubm90IHJlYmFzZTogWW91IGhhdmUgdW5zdGFn
ZWQgY2hhbmdlcy4KUGxlYXNlIGNvbW1pdCBvciBzdGFzaCB0aGVtLgpyZWJhc2UgcmVmcy9yZW1v
dGVzL2dpdC1zdm46IGNvbW1hbmQgcmV0dXJuZWQgZXJyb3I6IDEKCnBpb3RyQHBpb3RyLWxhcHRv
cDovdG1wL2QvYiQgZ2l0IHN0YXR1cwojIE9uIGJyYW5jaCBtYXN0ZXIKIyBDaGFuZ2VzIG5vdCBz
dGFnZWQgZm9yIGNvbW1pdDoKIyAgICh1c2UgImdpdCBhZGQgPGZpbGU+Li4uIiB0byB1cGRhdGUg
d2hhdCB3aWxsIGJlIGNvbW1pdHRlZCkKIyAgICh1c2UgImdpdCBjaGVja291dCAtLSA8ZmlsZT4u
Li4iIHRvIGRpc2NhcmQgY2hhbmdlcyBpbiB3b3JraW5nIGRpcmVjdG9yeSkKIwojCW1vZGlmaWVk
OiAgIHRocmVlLnR4dAojCm5vIGNoYW5nZXMgYWRkZWQgdG8gY29tbWl0ICh1c2UgImdpdCBhZGQi
IGFuZC9vciAiZ2l0IGNvbW1pdCAtYSIpCnBpb3RyQHBpb3RyLWxhcHRvcDovdG1wL2QvYiQgZ2l0
IGxvZyByZW1vdGVzL2dpdC1zdm4uLgpwaW90ckBwaW90ci1sYXB0b3A6L3RtcC9kL2IkIGdpdCBk
aWZmCmRpZmYgLS1naXQgYS90aHJlZS50eHQgYi90aHJlZS50eHQKaW5kZXggN2JmYzBmZC4uY2U0
NDdkMiAxMDA2NDQKLS0tIGEvdGhyZWUudHh0CisrKyBiL3RocmVlLnR4dApAQCAtMSwyICsxLDUg
QEAKIHRocmVlCiBuZXh0CituZXh0CituZXh0CituZXh0CnBpb3RyQHBpb3RyLWxhcHRvcDovdG1w
L2QvYiQK
--0016e6470ef85378ad04a0d219ed--
