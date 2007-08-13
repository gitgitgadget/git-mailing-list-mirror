From: Salikh Zakirov <salikh.zakirov@gmail.com>
Subject: [PATCH/BUG] Test for git-add -u from the subdirectory
Date: Mon, 13 Aug 2007 19:54:15 +0900
Message-ID: <20070813105415.GC14775@makoto.sib>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Aug 13 12:55:07 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IKXZi-0006Ir-Ad
	for gcvg-git@gmane.org; Mon, 13 Aug 2007 12:55:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S941975AbXHMKyd (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Mon, 13 Aug 2007 06:54:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S940451AbXHMKyc
	(ORCPT <rfc822;git-outgoing>); Mon, 13 Aug 2007 06:54:32 -0400
Received: from wa-out-1112.google.com ([209.85.146.178]:58127 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1764862AbXHMKya (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Aug 2007 06:54:30 -0400
Received: by wa-out-1112.google.com with SMTP id v27so1807988wah
        for <git@vger.kernel.org>; Mon, 13 Aug 2007 03:54:28 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=NWpctWAUJzpetrJ6GVv5TNHpkLd4udxdWxxEYNzAwJDwyJNYIUExONkuszcDrij3pLTdb0/tlDeexovINW5YsQXbX9X8tkhYv3cX/z4T575GjgNnPD1cLhRO9QwtCh7tpAfCqEbFrxinhpzfDAXDlF4WaLOO3juCrEtB1IV4Yr4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:date:to:cc:subject:message-id:mime-version:content-type:content-disposition:user-agent:from;
        b=hn2dctdS9C6LTjb3OReEzuc+8RJ/QxJL/w0EDfH9MLTL1ekuDP9aGJvdxYNicYkRJAz/p/GaD9d/i4a/LccSt0f8PQ2ODL0Vn3EGHhZSj7YZo7ZUZNIIpuvwmTZ+CSSMNPca5/cgJ51u8SYTby0Vc8bGqZpHgKqT5aPDRhB/wtw=
Received: by 10.115.75.1 with SMTP id c1mr1426563wal.1187002468360;
        Mon, 13 Aug 2007 03:54:28 -0700 (PDT)
Received: from makoto ( [131.112.51.4])
        by mx.google.com with ESMTPS id v39sm6253969wah.2007.08.13.03.54.24
        (version=SSLv3 cipher=OTHER);
        Mon, 13 Aug 2007 03:54:25 -0700 (PDT)
Received: by makoto (sSMTP sendmail emulation); Mon, 13 Aug 2007 19:54:15 +0900
Content-Disposition: inline
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/55760>

---

The following modification to the t2200-add-update.sh
shows that the git-add -u from the subdirectory does not work
with path limiters.

The test modification alone fails on master. I've tried
the revision 93c44d49 'git-add: allow path limiting with -u',
which introduced 'git-add -u', and it fails the test as well.

So technically, this feature never worked.
I use it as

    [alias]
	ci = add -u
	# used to be
	#ci = update-index
	# and worked

and the simplest workaround is to use git-add instead of git-ci.

 t/t2200-add-update.sh |    8 ++++++++
 1 files changed, 8 insertions(+), 0 deletions(-)

diff --git a/t/t2200-add-update.sh b/t/t2200-add-update.sh
index 0a703af..93c007d 100755
--- a/t/t2200-add-update.sh
+++ b/t/t2200-add-update.sh
@@ -35,4 +35,12 @@ test_expect_success 'update did not touch other tracked files' \
 test_expect_success 'update did not touch untracked files' \
   'test "`git diff-files --name-status dir/other`" = ""'
 
+test_expect_success 'more changes' 'echo modified >> dir/sub'
+
+test_expect_success 'update from subdirectory' \
+  '(cd dir; git add -u sub)'
+
+test_expect_success 'update touched correct path' \
+  'test "`git diff-files --name-status dir/sub`" = ""'
+
 test_done
-- 
1.5.2.rc3.5.g93c44
