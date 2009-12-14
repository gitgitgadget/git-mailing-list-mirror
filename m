From: =?iso-8859-1?Q?Bj=F6rn?= Steinbrink <B.Steinbrink@gmx.de>
Subject: am fails to apply patches for files with CRLF lineendings
Date: Mon, 14 Dec 2009 19:33:37 +0100
Message-ID: <20091214183337.GA25462@atjola.homenet>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: jk@silentcow.com, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Dec 14 19:33:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NKFjz-0005u4-3l
	for gcvg-git-2@lo.gmane.org; Mon, 14 Dec 2009 19:33:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753062AbZLNSdq convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 14 Dec 2009 13:33:46 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752863AbZLNSdq
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Dec 2009 13:33:46 -0500
Received: from mail.gmx.net ([213.165.64.20]:57940 "HELO mail.gmx.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750997AbZLNSdp (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Dec 2009 13:33:45 -0500
Received: (qmail invoked by alias); 14 Dec 2009 18:33:42 -0000
Received: from i59F56AFC.versanet.de (EHLO atjola.homenet) [89.245.106.252]
  by mail.gmx.net (mp050) with SMTP; 14 Dec 2009 19:33:42 +0100
X-Authenticated: #5039886
X-Provags-ID: V01U2FsdGVkX1/e6iFJHZ3eBt/oGOdCzUQ/VHCu4NtOOksiibPBUQ
	TKSjZO9RWzUhhb
Content-Disposition: inline
User-Agent: Mutt/1.5.20 (2009-06-14)
X-Y-GMX-Trusted: 0
X-FuHaFi: 0.51
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135229>

Hi,

Jason King (cc'd) reported that a patch for a file with CRLF lineending=
s
fails to apply, even if generated and applied in the same repo.

doener@atjola:x $ git init

doener@atjola:x (master) $ for x in $(seq 10); do echo -e "$x\r" >> foo=
; done
doener@atjola:x (master) $ vim foo
doener@atjola:x (master) $ git add foo; git commit -m init
[master (root-commit) b59b963] init
 1 files changed, 10 insertions(+), 0 deletions(-)
 create mode 100644 foo

doener@atjola:x (master) $ sed -ie s/5/changed/ foo
doener@atjola:x (master) $ git commit -am changed
[master fe4ee44] changed
 1 files changed, 1 insertions(+), 1 deletions(-)

doener@atjola:x (master) $ git format-patch HEAD^
0001-changed.patch

doener@atjola:x (master) $ git checkout HEAD^
Note: moving to 'HEAD^' which isn't a local branch

doener@atjola:x ((b59b963...)) $ git am 0001-changed.patch
Applying: changed
error: patch failed: foo:2
error: foo: patch does not apply
Patch failed at 0001 changed
When you have resolved this problem run "git am --resolved".
If you would prefer to skip this patch, instead run "git am --skip".
To restore the original branch and stop patching run "git am --abort".

Using "--whitespace=3Dfix" makes the patch apply, but converts the chan=
ged
line and the context area from CRLF to LF.

Commit c2ca1d7 "Allow mailsplit ... to handle mails with CRLF line-endi=
ngs"
seems to be responsible. Using "git am --rebasing" to trigger the
--keep-cr flag to mailsplit makes things work:

doener@atjola:x ((b59b963...)) $ git am --rebasing 0001-changed.patch
Applying: changed

And reverting that commit also gives the expected whitespace warning
(which is somehow squelched by the --rebasing flag it seems).

doener@atjola:x ((b59b963...)) $ git am 0001-changed.patch
Applying: changed
/home/doener/x/.git/rebase-apply/patch:14: trailing whitespace.
changed
warning: 1 line adds whitespace errors.

Bj=F6rn
