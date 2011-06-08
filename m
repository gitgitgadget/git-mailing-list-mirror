From: Andrew Wong <andrew.kw.w@gmail.com>
Subject: blame -C: adding a line in moved content sometimes affect blame result
Date: Wed, 08 Jun 2011 01:09:46 -0400
Message-ID: <4DEF041A.9070003@gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="------------030105000000010208060907"
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Jun 08 07:09:58 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QUB1h-00014a-2R
	for gcvg-git-2@lo.gmane.org; Wed, 08 Jun 2011 07:09:57 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751435Ab1FHFJv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Jun 2011 01:09:51 -0400
Received: from mail-iy0-f174.google.com ([209.85.210.174]:62479 "EHLO
	mail-iy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751060Ab1FHFJu (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2011 01:09:50 -0400
Received: by iyb14 with SMTP id 14so132439iyb.19
        for <git@vger.kernel.org>; Tue, 07 Jun 2011 22:09:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type;
        bh=d0erQ6nQ1CFfAoStdGNyV3mXVoFZkedb7ic34NhS2EU=;
        b=s7j3f4UZU/JPZQQ1yRwfmaoaIz4KQpNT7xW//LhY1rtEw23pRaXHXwsx5i1KPX2yEn
         nCJ9v6oCkvSEfx+rjJrebMW4L19jJFW4lSiGX/DMkLmMRtS8dziWfscAmun+spTUAAhq
         C8GdXH3ZPNX8PjcLqF7UBedo4KnoDoDCZLIgA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type;
        b=d4bIYw1AKZW7cjBsaPSrOiDaKApgg2DOY4T5wPt1ByTcox7YhSDPCXjObVXK0oIdhr
         gfq5kF69dXaFZh2+KkzqkUNt5ZyGkkrBgVd8afdGKoIjBoE7oO1OWcBy6FBcDPrieBJh
         z2UmcKYpYmsD5giFSBZ1VDOOnMPElzuExkX6M=
Received: by 10.42.149.138 with SMTP id w10mr11676453icv.100.1307509789964;
        Tue, 07 Jun 2011 22:09:49 -0700 (PDT)
Received: from ZanarkandMac.local (24-246-58-202.cable.teksavvy.com [24.246.58.202])
        by mx.google.com with ESMTPS id s9sm108208ibe.61.2011.06.07.22.09.47
        (version=TLSv1/SSLv3 cipher=OTHER);
        Tue, 07 Jun 2011 22:09:48 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; U; Intel Mac OS X 10.6; en-US; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175294>

This is a multi-part message in MIME format.
--------------030105000000010208060907
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit

I've attached a script for illustration.

After moving content from file1 to file2, "git blame -C file2" correctly 
shows that the content came from file1. However, if I add a line in near 
the top or bottom of the moved content in file2, "git blame -C file2" 
fails to detect that the top or bottom of the moved contents came from 
file1. I looked around in blame.c, and this feels like a boundary case 
somewhere inside find_copy_in_blob? Any clues?

--------------030105000000010208060907
Content-Type: application/x-sh;
 name="blame_issue.sh"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="blame_issue.sh"

#!/bin/bash
test -d test_repo && rm -fr test_repo
git init test_repo
cd test_repo

cat - << EOF > file1
line 1 line 1 line 1 line 1
line 2 line 2 line 2 line 2
line 3 line 3 line 3 line 3
line 4 line 4 line 4 line 4
line 5 line 5 line 5 line 5
line 6 line 6 line 6 line 6
line 7 line 7 line 7 line 7
line 8 line 8 line 8 line 8
EOF

git add file1
git commit -m "initial commit"

cat - << EOF > file1
line 1 line 1 line 1 line 1
line 8 line 8 line 8 line 8
EOF

cat - << EOF > file2
line 2 line 2 line 2 line 2
line 3 line 3 line 3 line 3
line 4 line 4 line 4 line 4
line 5 line 5 line 5 line 5
line 6 line 6 line 6 line 6
line 7 line 7 line 7 line 7
EOF

git add file1 file2
git commit -m "moved some lines to file2"

cat - << EOF > file2
line 2 line 2 line 2 line 2
line 3 line 3 line 3 line 3
move this line around to get different blame results
line 4 line 4 line 4 line 4
line 5 line 5 line 5 line 5
line 6 line 6 line 6 line 6
line 7 line 7 line 7 line 7
EOF

git add file2
git commit -m "change something in moved content"

git --no-pager blame -C file2

--------------030105000000010208060907--
