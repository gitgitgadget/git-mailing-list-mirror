From: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
Subject: Re: Getting git to help my memory
Date: Wed, 06 Jul 2011 09:52:40 +0200
Message-ID: <vpqpqlnkfqv.fsf@bauges.imag.fr>
References: <loom.20110705T232905-603@post.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
Cc: git@vger.kernel.org
To: Evan Driscoll <driscoll@cs.wisc.edu>
X-From: git-owner@vger.kernel.org Wed Jul 06 09:53:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QeMuz-00058L-Sb
	for gcvg-git-2@lo.gmane.org; Wed, 06 Jul 2011 09:53:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751591Ab1GFHxE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Jul 2011 03:53:04 -0400
Received: from mx2.imag.fr ([129.88.30.17]:40359 "EHLO rominette.imag.fr"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751299Ab1GFHxD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Jul 2011 03:53:03 -0400
Received: from mail-veri.imag.fr (mail-veri.imag.fr [129.88.43.52])
	by rominette.imag.fr (8.13.8/8.13.8) with ESMTP id p667qd4l012412
	(version=TLSv1/SSLv3 cipher=AES256-SHA bits=256 verify=NO);
	Wed, 6 Jul 2011 09:52:39 +0200
Received: from bauges.imag.fr ([129.88.7.32])
	by mail-veri.imag.fr with esmtp (Exim 4.69)
	(envelope-from <Matthieu.Moy@grenoble-inp.fr>)
	id 1QeMuW-0004A5-DB; Wed, 06 Jul 2011 09:52:40 +0200
In-Reply-To: <loom.20110705T232905-603@post.gmane.org> (Evan Driscoll's
	message of "Tue, 5 Jul 2011 21:34:18 +0000 (UTC)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.0.50 (gnu/linux)
X-Greylist: Sender IP whitelisted, not delayed by milter-greylist-4.2.2 (rominette.imag.fr [129.88.30.17]); Wed, 06 Jul 2011 09:52:39 +0200 (CEST)
X-IMAG-MailScanner-Information: Please contact MI2S MIM  for more information
X-MailScanner-ID: p667qd4l012412
X-IMAG-MailScanner: Found to be clean
X-IMAG-MailScanner-SpamCheck: 
X-IMAG-MailScanner-From: matthieu.moy@grenoble-inp.fr
MailScanner-NULL-Check: 1310543560.7186@9rDRnIlzIyXeD7p2KFekFA
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/176646>

--=-=-=
Content-Type: text/plain

Evan Driscoll <driscoll@cs.wisc.edu> writes:

> I have a somewhat unusual question. I often forget to push after committing,
> and a few times this has come back to bite me. (One time I didn't even really
> realize for a couple months because I was working on other stuff, so
> unraveling the conflicts was "fun".)

I have a cron job that sends me a mail with the list of "unpushed"
repositaries on my account every nights (it also runs "git fsck", "git
gc", and writes some .keep files to prevent "git gc" from repacking
large packs and be friendly with backups and unison).

It's not really cleaned up, and may well work just for me, but in case
you're interested, the scripts are attached:

* git-gc-fsck.sh is the script itself

* git-foreach is a home-made git command to manage a set of unrelated
  repositories. Essentially, one can

  git foreach update   => run some "find" commands in your $HOME to find
                          repositories.

  git foreach do blah  => run command blah in each repository.


--=-=-=
Content-Type: text/x-sh
Content-Disposition: attachment; filename=git-gc-fsck.sh

#! /bin/sh

status=0
subject=""
email=Matthieu.Moy@imag.fr
body=/tmp/git-gc-fsck.$$

diff=$(git-foreach update)

if [ "$diff" != "" ]; then
    (
	echo "Git repository list changed:"
	echo "$diff"
	echo
    ) >> "$body"
    subject="$subject change"
fi

unpushed=$(git foreach --quiet do sh -c 'u=$(git rev-parse @{upstream} 2>/dev/null);
if [ $? = 0 ]; then
    graph=$(git log --graph --oneline $u..);
    if [ "$graph" != "" ]; then
        pwd
        echo "$graph" | sed "s/^/    /"
        echo
    fi
    graph=""
fi')

if [ "$unpushed" != "" ]; then
    (
	echo "Some Git repositories have unpushed content:"
	echo "$unpushed"
	echo
    ) >> "$body"
    subject="$subject unpushed"
fi

failed_fsck=$(git-foreach do git fsck 2>&1)
fsck_status=$?

echo "$failed_fsck"

if [ "$fsck_status" != 0 ]; then
    subject="FSCK $subject"
    status=1
    (
	echo "Some Git repositories FAILED to fsck:"
	echo "$failed_fsck"
	echo
    ) >> "$body"
elif git-foreach do git keep-pack --size +10M && \
    git-foreach do git gc > /dev/null; then
    echo "git gc succeeded"
else
    echo "git gc failed, fsck succeeded. This is VERY strange ..."
    subject="GC $subject"
    status=1
fi

if [ "$subject" != "" ]; then
    mail -s "Git cron: $subject" "$email" < "$body"
    echo "Email sent to $email : $subject"
    cat "$body"
    rm -f "$body"
fi

exit "$status"

--=-=-=
Content-Type: application/octet-stream
Content-Disposition: attachment; filename=git-foreach
Content-Transfer-Encoding: base64

IyEgL2Jpbi9iYXNoCgp1c2FnZSAoKSB7CiAgICAgICAgICAgIGNhdCA8PCBFT0YKVXNhZ2U6Cgkk
KGJhc2VuYW1lICQwKSBbb3B0aW9uc10gdXBkYXRlICAgICAgICAgVXBkYXRlIHRoZSBjYWNoZWQg
bGlzdCBvZiByZXBvc2l0b3JpZXMuCgkkKGJhc2VuYW1lICQwKSBbb3B0aW9uc10gYWRkICAgICAg
ICAgICAgQWRkIGEgZGlyZWN0b3J5IHRvIHRoZSBjYWNoZWQgbGlzdCBvZiByZXBvc2l0b3JpZXMu
CgkkKGJhc2VuYW1lICQwKSBbb3B0aW9uc10gbHN8bGlzdCAgICAgICAgU2hvdyB0aGUgY2FjaGVk
IGxpc3Qgb2YgcmVwb3NpdG9yaWVzLgoJJChiYXNlbmFtZSAkMCkgW29wdGlvbnNdIGRvIGNtZCBh
cmdzICAgIEV4ZWN1dGUgImNtZCBhcmdzIiBpbiBlYWNoIHJlcG9zaXRvcnkuCk9wdGlvbnM6Cgkt
LWhlbHAsIC1oCVRoaXMgaGVscCBtZXNzYWdlLgoJLS1kaXIsIC1kCURpcmVjdG9yeSB3aGVyZSBy
ZXBvc2l0b3JpZXMgc2hvdWxkIGJlIHNlYXJjaGVkIGZvcgoJLS12ZXJib3NlLCAtdglCZSB2ZXJi
b3NlCgktLXF1aWV0CQlEb24ndCBkaXNwbGF5IGNvbW1hbmRzIGJlZm9yZSBleGVjdXRpbmcgdGhl
bQoKRmlsZXM6Cgl+Ly5naXQtZm9yZWFjaAlMaXN0IG9mIHJlcG9zaXRvcmllcy4KCQkJVXBkYXRl
ZCBieSBnaXQgZm9yZWFjaCB1cGRhdGUsIHVzZWQgYnkgZ2l0IGZvcmVhY2ggZG8uCgoJfi8uZ2l0
LWZvcmVhY2gtZGlycwoJCQlMaXN0IG9mIGRpcmVjdG9yaWVzIHdoZXJlIEdpdCByZXBvc2l0b3Jp
ZXMgc2hvdWxkIGJlIGxvb2tlZCBmb3IKCgl+Ly5naXQtZm9yZWFjaC1leGNsdWRlCgkJCUxpc3Qg
b2YgcGF0aHMgdG8gZXhjbHVkZSBpbiAnZ2l0IGZvcmVhY2ggdXBkYXRlJyAocmVnZXhwKS4KRU9G
Cn0KCmRpcnM9KCIkSE9NRSIpCmlmIFsgLWYgfi8uZ2l0LWZvcmVhY2gtZGlycyBdOyB0aGVuCiAg
ICBkaXJzPSgpCiAgICB3aGlsZSByZWFkIGxpbmU7IGRvCgkjIGV4cGFuZCB+ICYgZnJpZW5kcy4K
CWV2YWwgbGluZT0kbGluZQoJZGlycz0oIiR7ZGlyc1tAXX0iICRsaW5lKQogICAgZG9uZSA8IH4v
LmdpdC1mb3JlYWNoLWRpcnMKZmkKCmdpdF91cGRhdGUgKCkgewogICAgcm0gLWYgIiRIT01FIi8u
Z2l0LWZvcmVhY2gub2xkCiAgICBtdiAiJEhPTUUiLy5naXQtZm9yZWFjaCAiJEhPTUUiLy5naXQt
Zm9yZWFjaC5vbGQKICAgIGZpbmQgIiR7ZGlyc1tAXX0iIFwhIFwoIC1uYW1lIHNzaGZzIC1vIC1u
YW1lIHRtcCBcKSAtd2hvbGVuYW1lIFwqL3JlZnMvaGVhZHMgfCBcCiAgICAgICAgc2VkICdzQFwo
Ly5naXRcfFwpXCgvbG9nc1x8XCkvcmVmcy9oZWFkcyRAQCcgfCBcCiAgICAgICAgdW5pcSB8IGdy
ZXAgLXYgLWYgIiRIT01FLy5naXQtZm9yZWFjaC1leGNsdWRlIiB8IFwKCXRlZSAiJEhPTUUvLmdp
dC1mb3JlYWNoIiA+JjIKICAgIGRpZmYgLVUgMCAiJEhPTUUiLy5naXQtZm9yZWFjaC5vbGQgIiRI
T01FIi8uZ2l0LWZvcmVhY2gKfQoKZ2l0X2xzICgpIHsKICAgIGNhdCAiJEhPTUUvLmdpdC1mb3Jl
YWNoIgp9CgpnaXRfYWRkICgpIHsKICAgIGNkICIkMSIgfHwgZXhpdCAxCiAgICBpZiAhIGdpdCBy
ZXYtcGFyc2UgSEVBRCA+IC9kZXYvbnVsbCAyPiYxOyB0aGVuCiAgICAgICAgZWNobyAiJDE6IG5v
dCBhIGdpdCByZXBvc2l0b3J5IgogICAgZmkKICAgIHB3ZCA+PiAiJEhPTUUvLmdpdC1mb3JlYWNo
Igp9CgpnaXRfZG8gKCkgewogICAgKAoJPiAvdG1wL2dpdC1mb3JlYWNoLWVycm9yLiQkCiAgICAg
ICAgSUZTPSIKIgogICAgICAgIGNhdCAiJEhPTUUvLmdpdC1mb3JlYWNoIiB8IHdoaWxlIHJlYWQg
ZmlsZTsgZG8KICAgICAgICAgICAgKAogICAgICAgICAgICAgICAgY2QgIiRmaWxlIiAyPj4gL3Rt
cC9naXQtZm9yZWFjaC1lcnJvci4kJCB8fCBleGl0IDEgIyBleGl0IGp1c3QgZnJvbSBzdWJzaGVs
bC4KICAgICAgICAgICAgICAgIElGUz0iICIKCQlpZiBbICIkcXVpZXQiID0gIm5vIiBdOyB0aGVu
CiAgICAgICAgICAgICAgICAgICAgZWNobyAiUnVubmluZyAkQCBpbiBkaXJlY3RvcnkgJGZpbGUg
Li4uIgoJCWZpCiAgICAgICAgICAgICAgICAiJEAiIHx8IGVjaG8gIiRmaWxlIChleGl0ICQ/KSIg
Pj4gL3RtcC9naXQtZm9yZWFjaC1lcnJvci4kJAogICAgICAgICAgICAgICAgKQogICAgICAgIGRv
bmUgMz4mMQogICAgICAgICkKICAgIGlmIFsgIiQoY2F0IC90bXAvZ2l0LWZvcmVhY2gtZXJyb3Iu
JCQpIiAhPSAiIiBdOyB0aGVuCiAgICAgICAgZWNobyAiRXJyb3JzIG9jY3VyZWQ6IgogICAgICAg
IGNhdCAvdG1wL2dpdC1mb3JlYWNoLWVycm9yLiQkCglybSAtZiAvdG1wL2dpdC1mb3JlYWNoLWVy
cm9yLiQkCiAgICAgICAgZXhpdCAxCiAgICBmaQogICAgcm0gLWYgL3RtcC9naXQtZm9yZWFjaC1l
cnJvci4kJAp9Cgp2ZXJib3NlPW5vCnF1aWV0PW5vCndoaWxlIHRlc3QgJCMgLW5lIDA7IGRvCiAg
ICBjYXNlICIkMSIgaW4KICAgICAgICAiLS1oZWxwInwiLWgiKQoJICAgIHVzYWdlCiAgICAgICAg
ICAgIGV4aXQgMAogICAgICAgICAgICA7OwogICAgICAgICItLXZlcmJvc2UifCItdiIpCgkgICAg
dmVyYm9zZT15ZXMKCSAgICA7OwoJIi0tcXVpZXQifCItcSIpCgkgICAgcXVpZXQ9eWVzCgkgICAg
OzsKICAgICAgICAiLS1kaXIifCItZCIpCiAgICAgICAgICAgIHNoaWZ0CiAgICAgICAgICAgIGRp
cnM9IiQoY2QgLVAgIiQxIjsgcHdkKSIKICAgICAgICAgICAgOzsKICAgICAgICAidXBkYXRlIikK
ICAgICAgICAgICAgc2hpZnQKICAgICAgICAgICAgZ2l0X3VwZGF0ZSAiJEAiCiAgICAgICAgICAg
IGV4aXQgMAogICAgICAgICAgICA7OwogICAgICAgICJkbyIpCiAgICAgICAgICAgIHNoaWZ0CiAg
ICAgICAgICAgIGdpdF9kbyAiJEAiCiAgICAgICAgICAgIGV4aXQgMAogICAgICAgICAgICA7Owog
ICAgICAgICJsaXN0InwibHMiKQogICAgICAgICAgICBzaGlmdAogICAgICAgICAgICBnaXRfbHMg
IiRAIgogICAgICAgICAgICBleGl0IDAKICAgICAgICAgICAgOzsKICAgICAgICAiYWRkIikKICAg
ICAgICAgICAgc2hpZnQKICAgICAgICAgICAgZ2l0X2FkZCAiJEAiCiAgICAgICAgICAgIGV4aXQg
MAogICAgICAgICAgICA7OwogICAgICAgICopCiAgICAgICAgICAgIGVjaG8gInVucmVjb2duaXpl
ZCBvcHRpb24gJDEiCiAgICAgICAgICAgIHVzYWdlCiAgICAgICAgICAgIGV4aXQgMQogICAgICAg
ICAgICA7OwogICAgZXNhYwogICAgc2hpZnQKZG9uZQoKaWYgWyAiJHZlcmJvc2UiID0geWVzIF07
IHRoZW4KICAgIGVjaG8gIkRpcmVjdG9yaWVzIHRvIGxvb2sgaW50bzoiCiAgICBlY2hvICIke2Rp
cnNbQF19IgpmaQoKdXNhZ2UK
--=-=-=
Content-Type: text/plain


BTW, if you really always want to push after commit, you can as well
have a post-commit-hook that does the push for you. But you lose part of
the power of Git by doing so (you can't rebase -i before pushing for
example).

-- 
Matthieu Moy
http://www-verimag.imag.fr/~moy/

--=-=-=--
