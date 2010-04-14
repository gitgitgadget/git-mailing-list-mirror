From: David Michael Barr <david.barr@cordelta.com>
Subject: Re: Update on SoC proposal: git-remote-svn
Date: Thu, 15 Apr 2010 03:15:58 +1000
Message-ID: <21A95727-F438-48FB-9A16-132B4DE85B6E@cordelta.com>
References: <1271136573-sup-5613@kytes> <F0CD5B83-2D28-47E1-A336-5C88E2803CBE@gmail.com>
Mime-Version: 1.0 (Apple Message framework v1078)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Ramkumar Ramachandra <artagnon@gmail.com>,
	Sam Vilain <sam@vilain.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Steven Michalske <smichalske@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 14 19:16:13 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O26CB-0000HF-0x
	for gcvg-git-2@lo.gmane.org; Wed, 14 Apr 2010 19:16:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756234Ab0DNRQE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Apr 2010 13:16:04 -0400
Received: from ironport1-mx.cbr1.mail-filtering.com.au ([203.88.115.241]:28813
	"EHLO ironport1-mx.cbr1.mail-filtering.com.au" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1756186Ab0DNRQD (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 14 Apr 2010 13:16:03 -0400
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-Anti-Spam-Result: AvsEALeUxUvLWHsF/2dsb2JhbACbVXG0OIhGhQ0E
X-IronPort-AV: E=Sophos;i="4.52,205,1270389600"; 
   d="scan'208";a="166661031"
Received: from node2.alpha.aussiehq.net.au ([203.88.123.5])
  by ironport1-mta.cbr1.mail-filtering.com.au with ESMTP; 15 Apr 2010 03:16:00 +1000
Received: (qmail 24255 invoked from network); 15 Apr 2010 03:16:00 +1000
Received: from d122-109-106-179.mit3.act.optusnet.com.au (HELO ?192.168.1.8?) (122.109.106.179)
  by node2.alpha.aussiehq.net.au with SMTP; 15 Apr 2010 03:15:59 +1000
In-Reply-To: <F0CD5B83-2D28-47E1-A336-5C88E2803CBE@gmail.com>
X-Mailer: Apple Mail (2.1078)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144889>

Hi Steve,

> If I were to check out the svn root of that repository, I would use well
> over 3TB of disk space to have that checked out ...

This stirred my thoughts and I whipped up a bash script that uses SVK,
find, shasum and ln to build a filesystem view of the root of an svn
repository that consumes moderate storage:

SVK_DEPOT=""
MAX_REV=12345

CO_DIR=validation
HASH_DIR=hashes

svk co -r1 /$SVK_DEPOT/ $CO_DIR
mkdir -p $HASH_DIR
for (( REV=1 ; REV<=MAX_REV ; ++REV )) do
  svk up -r$REV $CO_DIR
  # Hashify working copy
  find $CO_DIR -type d -cmin -5 -prune -o \
    -type f -links 1 -exec shasum '{}' + | (
    while read HASH FILE ; do
      [ -x "$FILE" ] && HASH="$HASH"x
      ln "$FILE" $HASH_DIR/$HASH 2>/dev/null || \
        ln -f $HASH_DIR/$HASH "$FILE"
    done
  )
done

Important assumptions are that each update will take less
than 5 minutes and that SVK uses writes to a temporary file
and then renames to perform a modification.
I've used this to build a simple validation script for my project.
I estimate it will use about 20GB to represent my 1GB repo
and that it will take about 3 hours.

--
David Barr
