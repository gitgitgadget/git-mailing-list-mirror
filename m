From: =?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
Subject: t1450-fsck (sometimes/often) failes on Mac OS X
Date: Sat, 14 Jul 2012 14:21:35 +0200
Message-ID: <5001644F.10901@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org,
	=?ISO-8859-1?Q?Torsten_B=F6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Jul 14 14:22:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sq1Mc-0007oi-BG
	for gcvg-git-2@plane.gmane.org; Sat, 14 Jul 2012 14:22:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755975Ab2GNMVi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 14 Jul 2012 08:21:38 -0400
Received: from mout.web.de ([212.227.15.4]:58403 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753211Ab2GNMVh (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 14 Jul 2012 08:21:37 -0400
Received: from birne.lan ([194.22.188.61]) by smtp.web.de (mrweb102) with
 ESMTPA (Nemesis) id 0LcPSk-1TZlm20UXm-00j7qz; Sat, 14 Jul 2012 14:21:36 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:13.0) Gecko/20120614 Thunderbird/13.0.1
X-Provags-ID: V02:K0:+cceTeHlCUckvcK+jOMXHqvYbKhiqCEZICquOWl3r25
 GpdTOtHhXveixNth88bNMSMf6dDnge7RSbYWEeEQWQCPkkyp2D
 d6hdaC5fkTWCat2N74g/md4uLv6u+m71FxJXNZIkxkDPO/BIEG
 HPF+maq8FhrHYhnrDsFH1jSN2rnLGUfV27qtCi5SUOo5nF852r
 FHe9gxhW0bHcLvYeJv30Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201439>

I saw the problem first on pu, some time ago, 
but it dissappeared after cloning git.git into another directory.

Now it appeared on next as well, so it's time to look a little bit deeper.

This test case of t1450 fails:
test_expect_success 'tag pointing to something else than its type' '

To debug more, I added an exit 0 here to inspect the file named out:
diff --git a/t/t1450-fsck.sh b/t/t1450-fsck.sh
index 5b79c51..f1f45c9 100755
--- a/t/t1450-fsck.sh
+++ b/t/t1450-fsck.sh
@@ -179,6 +179,7 @@ test_expect_success 'tag pointing to something else than its type' '
        test_when_finished "git update-ref -d refs/tags/wrong" &&
        test_must_fail git fsck --tags 2>out &&
        cat out &&
+       exit 0
        grep "error in tag.*broken links" out
 '

Linux:
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a blob, not a commit
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: broken links
error in tag 66f6581d549f70e05ca586bc2df5c15a95662c36: could not load tagged object

Mac OS X:
error: Object 63499e4ea8e096b831515ceb1d5a7593e4d87ae5 is a commit, not a blob
error: 63499e4ea8e096b831515ceb1d5a7593e4d87ae5: object corrupt or missing

I reverted the last change in fsck.c (Use the streaming interface), but that doesn't help

Looking into the trash directory and looking at the files, we can see that the .git/index is different
between Linux and Mac OS X.

Is there a good way to debug the index file?

BTW:  git bisect pointed out: 
 [76759c7dff53e8c84e975b88cb8245587c14c7ba] git on Mac OS and precomposed unicode
But re-running t1450 makes it pass, so that bisect went into the wrong direction
somewhere.

It seems that t1450 is timing depending, sometimes it passes, sometimes not.
And once it went into the state "non passed", it stays there.

It feels that I got stuck, any hints how to debug this further, please ?

/Torsten
