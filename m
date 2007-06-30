From: "Matt McCutchen" <hashproduct@gmail.com>
Subject: Concurrent modification breaks "racy git"
Date: Sat, 30 Jun 2007 16:53:12 -0400
Message-ID: <3bbc18d20706301353j346ce393y8dbd9c9a755618a8@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org, "Petr Baudis" <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Sat Jun 30 22:53:22 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1I4jwX-00039I-0M
	for gcvg-git@gmane.org; Sat, 30 Jun 2007 22:53:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752511AbXF3UxO (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 30 Jun 2007 16:53:14 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752427AbXF3UxO
	(ORCPT <rfc822;git-outgoing>); Sat, 30 Jun 2007 16:53:14 -0400
Received: from nz-out-0506.google.com ([64.233.162.239]:22993 "EHLO
	nz-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751355AbXF3UxN (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 30 Jun 2007 16:53:13 -0400
Received: by nz-out-0506.google.com with SMTP id s18so685028nze
        for <git@vger.kernel.org>; Sat, 30 Jun 2007 13:53:13 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=A76+wuznVPp7s4THi2gf9Jk4gGdokXGFV/cASslofc5OL6LqMqWIFzv7kbjneWT7sEZzbrjFco99aeeGlotU2dECq98dd/lbzRBPbNpZER5HKv8FJoHsxOhsQCLogIXyYvv/ToyNowMah0yv+DAUmKUGT9lE6i1L0gHw95miTdI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=JzymEzYTGfOVq6by5vGlC7PcYKHURYVehbVR75XrAR3bOnXbl5ipNwEUMxXbpZnF+z8BJwp8A/kZpUxsD5z9FhTlExEWzNCH9Pbjk6fwXRkAwPWPUoewGY3YdfVWloP7rBC3c4EqhkhknymAAvU+JJnVNG8l5Q6vD+mtJ6LmEXU=
Received: by 10.142.51.4 with SMTP id y4mr266706wfy.1183236792234;
        Sat, 30 Jun 2007 13:53:12 -0700 (PDT)
Received: by 10.143.30.9 with HTTP; Sat, 30 Jun 2007 13:53:12 -0700 (PDT)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/51257>

I found a case in which git fails to notice a modification to a file
in the working tree if the modification is concurrent with git-add.
The script below demonstrates it:

-----------

#!/bin/bash
set -x

rm -rf test
mkdir test
cd test

git-init-db
perl -e 'foreach $i (1...100) { open F, ">foo$i";
                truncate F, 5000000; close F; }'

echo data1 >bar # Write bar...
git-add bar foo* &
sleep .1        # give git-add time to add it...
echo data2 >bar # and change it again in the same second!

# git-add takes a while to read foo*, so the index file gets a
# later timestamp, so git doesn't realize that bar's cleanliness
# is racy.
wait

git-diff bar # Now you don't see the difference...

touch bar
git-diff bar # Now you do!

-----------

I doubt this case will happen to anyone in practice, but I at least
wanted to make sure people knew about it.  To fix it, git-add could
use a timestamp taken just before it starts reading files in place of
the mtime of the index.

Matt
