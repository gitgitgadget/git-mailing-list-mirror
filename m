From: Barry Roberts <blr@robertsr.us>
Subject: Replacing large blobs in git history
Date: Tue, 6 Mar 2012 09:09:44 -0700
Message-ID: <CAD-6W7byTiuE9MFZY1yG_ann-Ox7+wGjYduZ=Wwmw0ToF5Pynw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Mar 06 17:09:49 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1S4wxQ-0004GY-BI
	for gcvg-git-2@plane.gmane.org; Tue, 06 Mar 2012 17:09:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754722Ab2CFQJq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Mar 2012 11:09:46 -0500
Received: from mail-wi0-f174.google.com ([209.85.212.174]:53295 "EHLO
	mail-wi0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754705Ab2CFQJp (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Mar 2012 11:09:45 -0500
Received: by wibhm2 with SMTP id hm2so2741637wib.19
        for <git@vger.kernel.org>; Tue, 06 Mar 2012 08:09:44 -0800 (PST)
Received-SPF: pass (google.com: domain of manithree@gmail.com designates 10.180.94.33 as permitted sender) client-ip=10.180.94.33;
Authentication-Results: mr.google.com; spf=pass (google.com: domain of manithree@gmail.com designates 10.180.94.33 as permitted sender) smtp.mail=manithree@gmail.com; dkim=pass header.i=manithree@gmail.com
Received: from mr.google.com ([10.180.94.33])
        by 10.180.94.33 with SMTP id cz1mr23422857wib.13.1331050184285 (num_hops = 1);
        Tue, 06 Mar 2012 08:09:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=qfMyF7D1fh2aS/GrcxWCto8RuRJLaa3LvxR0kZmcgog=;
        b=tKuBhJ9mogxqHD8bc+kjw8TgK4Xs1Ha8jJQohPJN7E11oVhNivwfxw7/5xyMm5Ip5F
         gBvPqVTAE1HqbMVRrutAtlk0x77erxRYpaawRICAJEb8lofCJrKvbSG3AlLvgC1dboMS
         9h+IqIZi+4HYgo97W7o6cETMyk+cokok5Yo82BvPrG44Sw/22bRb+9wx7XWt9uzTppUj
         ER3vk7Q5bB0kVTKupryB8LU1oD7lB4mD3IcdfQSmkFlmDT/MEvR/5Aiu1WwgClonhtuD
         UlF6xIuvdxMM/DTnXJpnHrmQ1byx2W7TMwPj4bs+57StWBya9iJnjYybbjV5zto0XpD5
         Z4Qw==
Received: by 10.180.94.33 with SMTP id cz1mr18634258wib.13.1331050184235; Tue,
 06 Mar 2012 08:09:44 -0800 (PST)
Received: by 10.216.67.83 with HTTP; Tue, 6 Mar 2012 08:09:44 -0800 (PST)
X-Google-Sender-Auth: eXfwJ089IsT8EGRdVWSJRdw7dLI
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/192362>

I started this question on #git last week, but this is getting long,
and things have changed some, so I'm going to try here.

I had a 3rd party jar file checked in to our git repository.  It was
about 4 mb, so no big deal.  Then about 17 months ago somebody checked
in a 550 mb version.  There were several versions of the original file
in several different directories.  The large version replaced the
small version in some of those directories (but not all of them).
Then somebody found a "small" version that was only 110 mb and
replaced some of the 550 mb files and some of the old 4 mb files.
Finally several months after that we got the correct updated 5 mb
latest version.  But I'm still carrying around an extra 660 mb in my
object database, and we are adding developers and moving to an
off-site location with lower bandwidth and higher latency, so I would
like to clean this up.

My first attempt just removed the blob (by hash ID).  It's been over a
year since the small correct file was checked in, so the odds of ever
needing to build anything that old are very slim. But after thinking
about it some, I came up with this to replace the blob with the
correct one and wanted to see if this is a reasonable way to do this
before I actually backup and then replace my central git repository.

git filter-branch --index-filter 'killem=$(git ls-files --stage  |
grep 7a36af54a6c47\\\|abe809091bcb3 ) ; if [ -n "$killem" ] ; then git
ls-files --stage |grep 7a36af54a6c47\\\|abe809091bcb3 | sed -f
/home/blr/tmp/chgblob.sed |  git update-index --index-info ; fi'

chgblob.sed looks like this:
s/7a36af54a6c47a29eb9690caefa132489d39c4d0/8924ef0f78b3d09957a8697ca93cce6700771071/g
s/abe809091bcb37a06284f8353366074622d72373/8924ef0f78b3d09957a8697ca93cce6700771071/g

7a36af is the 550 mb blob, abe80909 is the 110 mb, and 8924ef0f is the
5 mb new version.

This isn't extremely efficient since it does the 'git ls-filess
--stage' twice (once to see if the blob is used, then again to change
it ONLY if the blob is referenced in the current index).  But that
only adds a few seconds to the 28 minute runtime, so I'm not too
worried about that.  And yes, I could just check for the return value
of grep, but I did echo $killem while I was debugging and that was
useful, so I just left it like that.

Does this look like a reasonable way to accomplish what I'm trying to
do, or am I doing something that's going to cause grief later?

Thanks,
Barry
