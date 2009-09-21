From: Pat Thoyts <patthoyts@users.sourceforge.net>
Subject: Re: [PATCH] Re: Gitk --all error when there are more than 797 refs in a repository
Date: 22 Sep 2009 00:56:48 +0100
Message-ID: <874oqvc0n3.fsf@users.sourceforge.net>
References: <6F87406399731F489FBACE5C5FFA04584BFA53@ex2k.bankofamerica.com>
	<878wgcbb52.fsf@users.sourceforge.net>
	<19124.8378.975976.347711@cargo.ozlabs.ibm.com>
	<6F87406399731F489FBACE5C5FFA0458518DE8@ex2k.bankofamerica.com>
	<4AB78910.7010402@viscovery.net>
	<6F87406399731F489FBACE5C5FFA0458518E11@ex2k.bankofamerica.com>
	<4AB7A2E7.5000601@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Murphy, John" <john.murphy@bankofamerica.com>,
	Paul Mackerras <paulus@samba.org>, git@vger.kernel.org
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Sep 22 01:57:36 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MpslE-0001pV-AP
	for gcvg-git-2@lo.gmane.org; Tue, 22 Sep 2009 01:57:36 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754575AbZIUX45 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Sep 2009 19:56:57 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754534AbZIUX45
	(ORCPT <rfc822;git-outgoing>); Mon, 21 Sep 2009 19:56:57 -0400
Received: from smtp-out3.blueyonder.co.uk ([195.188.213.6]:56752 "EHLO
	smtp-out3.blueyonder.co.uk" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754317AbZIUX4z (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Sep 2009 19:56:55 -0400
Received: from [172.23.170.139] (helo=anti-virus01-10)
	by smtp-out3.blueyonder.co.uk with smtp (Exim 4.52)
	id 1MpskW-00077n-OR; Tue, 22 Sep 2009 00:56:52 +0100
Received: from [92.238.221.8] (helo=badger.patthoyts.tk)
	by asmtp-out4.blueyonder.co.uk with esmtp (Exim 4.52)
	id 1MpskU-0006pP-KF; Tue, 22 Sep 2009 00:56:50 +0100
Received: by badger.patthoyts.tk (Postfix, from userid 1000)
	id D68EA51843; Tue, 22 Sep 2009 00:56:49 +0100 (BST)
X-Face: .`d#euqz@6H{";Ysmx2IVe_7M3vA+2w1X[QLk?ZO&QRauXQL{*L'$3getx}9+zK.-KWDx3.
 qrlR)76MFb`6bgoGvLpLtcQKB=X~;*<JKLtwLBM(IA'?rVjs1*tq\VHn?WMNsB,3XXWF@5.)4SRFa+
 '?a?.s#@hl7CiTo'F"O!fvbL0
X-Url: http://www.patthoyts.tk/
In-Reply-To: <4AB7A2E7.5000601@viscovery.net>
User-Agent: Gnus/5.09 (Gnus v5.9.0) Emacs/21.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/128914>

Johannes Sixt <j.sixt@viscovery.net> writes:

>Murphy, John schrieb:
>
>On Windows, 'gitk --all' starts with branch-0797, on Linux it starts with
>branch-0999 aka master.

That script gives me a repository I can test against. thanks.
The start_rev_list function calls parseviewrevs and expands the
arguments into a list of appropriate revision ids. In this case --all
gets expanded to a list of 1000 sha1 ids. This is appended to any
other view arguments and passed to git log on the command line
yielding our error.
git log can accept a --all argument it seems so it looks like we can
just short-circuit the parseviewrevs function when --all is passed in
and return --all instead of expanding the list. The following seems to
work for me with this test repository.
John, if this works for you can you also check that editing and
creating new gitk views on your real repository continues to work ok.

commit 7f289ca8370e5e2f9622a4fbc30b934eb97b984f
Author: Pat Thoyts <patthoyts@users.sourceforge.net>
Date:   Tue Sep 22 00:55:50 2009 +0100

    Avoid expanding --all when passing arguments to git log.
    There is no need to expand --all into a list of all revisions as
    git log can accept --all as an argument. This avoids any
    command-line
    length limitations caused by expanding --all into a list of all
    revision ids.

    Signed-off-by: Pat Thoyts <patthoyts@users.sourceforge.net>

diff --git a/gitk b/gitk
index a0214b7..635b97e 100755
--- a/gitk
+++ b/gitk
@@ -241,6 +241,8 @@ proc parseviewrevs {view revs} {

     if {$revs eq {}} {
        set revs HEAD
+    } elseif {$revs eq "--all"} {
+        return $revs
     }
     if {[catch {set ids [eval exec git rev-parse $revs]} err]} {
        # we get stdout followed by stderr in $err

-- 
Pat Thoyts                            http://www.patthoyts.tk/
PGP fingerprint 2C 6E 98 07 2C 59 C8 97  10 CE 11 E6 04 E0 B9 DD
