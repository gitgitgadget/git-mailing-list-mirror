From: Aleksander Nitecki <ixendr@itogi.re>
Subject: [BUG] checkout --orphan breaks HEAD reflog
Date: Mon, 14 Jul 2014 21:44:25 +0200
Message-ID: <53C43319.7000208@itogi.re>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------010709080901080907040409"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jul 14 22:00:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X6mQ9-0001L3-JN
	for gcvg-git-2@plane.gmane.org; Mon, 14 Jul 2014 22:00:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757000AbaGNUAS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Jul 2014 16:00:18 -0400
Received: from 10.mo69.mail-out.ovh.net ([46.105.73.241]:45421 "EHLO
	mo69.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1757068AbaGNUAQ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Jul 2014 16:00:16 -0400
X-Greylist: delayed 601 seconds by postgrey-1.27 at vger.kernel.org; Mon, 14 Jul 2014 16:00:16 EDT
Received: from mail401.ha.ovh.net (gw6.ovh.net [213.251.189.206])
	by mo69.mail-out.ovh.net (Postfix) with SMTP id CDCB3FF99BB
	for <git@vger.kernel.org>; Mon, 14 Jul 2014 21:44:28 +0200 (CEST)
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 14 Jul 2014 21:43:00 +0200
Received: from unknown (HELO ?192.168.2.2?) (ixendr@itogi.re@176.221.120.189)
  by ns0.ovh.net with SMTP; 14 Jul 2014 21:42:59 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
X-Ovh-Tracer-Id: 3657767323160185822
X-Ovh-Remote: 176.221.120.189 ()
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-OVH-SPAMSTATE: OK
X-OVH-SPAMSCORE: 0
X-OVH-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejfedrvdelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
X-Spam-Check: DONE|U 0.5/N
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrfeejfedrvdelucetufdoteggodetrfcurfhrohhfihhlvgemucfqggfjnecuuegrihhlohhuthemuceftddtnecu
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253511>

This is a multi-part message in MIME format.
--------------010709080901080907040409
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi, this is my first mail to this list (and I'm not a native English speaker), so let me apologise from the start for any slips in following message.

Ok, so I think I've found a bug in git.
It concerns orphan checkouts breaking (gapping in non-traversable way) the HEAD reflog display.

% git --version
git version 2.0.1


# Repro commands; output omitted.

% mkdir /tmp/git-orphan-checkout-reflog-bug
% cd /tmp/git-orphan-checkout-reflog-bug
% git init
% echo a  > foo; git add foo; git commit -m 'newly created master; rev. a'
% echo b >> foo; git add foo; git commit -m 'master; rev. b'
% echo c >> foo; git add foo; git commit -m 'master; rev. c'
% git checkout --orphan some_orphan_branch
% echo 1  > bar; git add bar; git commit -m 'newly created orphan branch; rev. 1'
% echo 2 >> bar; git add bar; git commit -m 'orphan branch; rev. 2'
% echo 3 >> bar; git add bar; git commit -m 'orphan branch; rev. 3'


# Actual (IMHO buggy) output

% git reflog HEAD
1af4e3c HEAD@{0}: commit: orphan branch; rev. 3
6d200b4 HEAD@{1}: commit: orphan branch; rev. 2
ed4ad67 HEAD@{2}: commit (initial): newly created orphan branch; rev. 1

% git reflog HEAD@{3}
warning: Log .git/logs/HEAD has gap after Mon, 14 Jul 2014 20:55:05 +0200.
0cada62 HEAD@{3}: commit: master; rev. c
42d7cc3 HEAD@{4}: commit: master; rev. b
222a0b3 HEAD@{5}: commit (initial): newly created master; rev. a


# Expected output:

% git reflog HEAD
1af4e3c HEAD@{0}: commit: orphan branch; rev. 3
6d200b4 HEAD@{1}: commit: orphan branch; rev. 2
ed4ad67 HEAD@{2}: commit (initial): newly created orphan branch; rev. 1
warning: Log .git/logs/HEAD has gap after Mon, 14 Jul 2014 20:55:05 +0200.
0cada62 HEAD@{3}: commit: master; rev. c
42d7cc3 HEAD@{4}: commit: master; rev. b
222a0b3 HEAD@{5}: commit (initial): newly created master; rev. a

Well, actually git doesn't seem to show warning messages when traversing reflogs with other gaps, but only when started from point where a gap is.
Whether those warnings should be displayed while traversing the reflog, not only when starting from gapped entries is another matter, but I think it could be useful.


# Raw reflog file (shortened to fit in 80 columns).
# Omissions marked with ##. Full contents in attachment.
# (does sending attachments to mailing list even work? Sorry, if it doesn't.)

% cat .git/logs/HEAD
00000## 222a0## ## commit (initial): newly created master; rev. a
222a0## 42d7c## ## commit: master; rev. b
42d7c## 0cada## ## commit: master; rev. c
00000## ed4ad## ## commit (initial): newly created orphan branch; rev. 1
ed4ad## 6d200## ## commit: orphan branch; rev. 2
6d200## 1af4e## ## commit: orphan branch; rev. 3

So the problem seems to be that git stops traversing the reflog after finding first initial commit (all-0s hash) and completely ignores rest of log.
The problem is that this commit is initial only to the orphaned branch, not to the whole repo.


--------------010709080901080907040409
Content-Type: text/plain; charset=UTF-8;
 name="gitdir_logs_HEAD.txt"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="gitdir_logs_HEAD.txt"

MDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMCAyMjJhMGIzODY1NGQy
YzhjZjMwMjZkYjU5MTNkMjE4NTdhNWExN2U3IEFsZWtzYW5kZXIgTml0ZWNraSA8aXhlbmRy
QGl0b2dpLnJlPiAxNDA1MzY0MDcwICswMjAwIGNvbW1pdCAoaW5pdGlhbCk6IG5ld2x5IGNy
ZWF0ZWQgbWFzdGVyOyByZXYuIGEKMjIyYTBiMzg2NTRkMmM4Y2YzMDI2ZGI1OTEzZDIxODU3
YTVhMTdlNyA0MmQ3Y2MzOWNiNGU4OWUwMmU4YjA4NjhkNGJkMzJkMThjMGZjZDg0IEFsZWtz
YW5kZXIgTml0ZWNraSA8aXhlbmRyQGl0b2dpLnJlPiAxNDA1MzY0MDg2ICswMjAwIGNvbW1p
dDogbWFzdGVyOyByZXYuIGIKNDJkN2NjMzljYjRlODllMDJlOGIwODY4ZDRiZDMyZDE4YzBm
Y2Q4NCAwY2FkYTYyZGYwMDdhYTllYzFlZTAwODE2YWRiMWIxZDljZTNmNTkzIEFsZWtzYW5k
ZXIgTml0ZWNraSA8aXhlbmRyQGl0b2dpLnJlPiAxNDA1MzY0MTA1ICswMjAwIGNvbW1pdDog
bWFzdGVyOyByZXYuIGMKMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAwMDAw
MCBlZDRhZDY3OWQzYzY5MDNiM2JiYWQ0NzdmOGU2MWE4NWFmYTg4MmE1IEFsZWtzYW5kZXIg
Tml0ZWNraSA8aXhlbmRyQGl0b2dpLnJlPiAxNDA1MzY0MzI0ICswMjAwIGNvbW1pdCAoaW5p
dGlhbCk6IG5ld2x5IGNyZWF0ZWQgb3JwaGFuIGJyYW5jaDsgcmV2LiAxCmVkNGFkNjc5ZDNj
NjkwM2IzYmJhZDQ3N2Y4ZTYxYTg1YWZhODgyYTUgNmQyMDBiNDFmMjMwNzYyNTg1ZTBjMjVi
OWIzMzMzNmUwY2Y2OWJhOSBBbGVrc2FuZGVyIE5pdGVja2kgPGl4ZW5kckBpdG9naS5yZT4g
MTQwNTM2NDM3MSArMDIwMCBjb21taXQ6IG9ycGhhbiBicmFuY2g7IHJldi4gMgo2ZDIwMGI0
MWYyMzA3NjI1ODVlMGMyNWI5YjMzMzM2ZTBjZjY5YmE5IDFhZjRlM2NmMTU3NmQwNWZhNWM1
NzljODA5MGUyOTYxZWJhZmQ0ZTkgQWxla3NhbmRlciBOaXRlY2tpIDxpeGVuZHJAaXRvZ2ku
cmU+IDE0MDUzNjQ0MjEgKzAyMDAgY29tbWl0OiBvcnBoYW4gYnJhbmNoOyByZXYuIDMK
--------------010709080901080907040409--
