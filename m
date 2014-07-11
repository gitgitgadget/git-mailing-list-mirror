From: Ephrim Khong <dr.khong@gmail.com>
Subject: [Bug] data loss with cyclic alternates
Date: Fri, 11 Jul 2014 11:37:25 +0200
Message-ID: <53BFB055.206@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jul 11 11:37:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X5XGs-0004mB-65
	for gcvg-git-2@plane.gmane.org; Fri, 11 Jul 2014 11:37:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957AbaGKJhd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Jul 2014 05:37:33 -0400
Received: from mail-we0-f179.google.com ([74.125.82.179]:62841 "EHLO
	mail-we0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753073AbaGKJhb (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Jul 2014 05:37:31 -0400
Received: by mail-we0-f179.google.com with SMTP id p10so503853wes.38
        for <git@vger.kernel.org>; Fri, 11 Jul 2014 02:37:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        bh=DJRDuCTnA8nhUo71tbWnM8j5XHF41F3Y23UF8L3YVSw=;
        b=oUnLf1bqQ3HjWzbkTlvkRTM8hnDtCc04IXU0xq7zR18Qw7IRoJH9jdv9pZLi4/iHpl
         BS0j/NOMsu3dsOLEU3mQUYXNlI+efF4kMsFsWnIS4pRzeSmwqQNFlSY0LZbr9u2kCnOD
         TKyYJskeNQ9lABnDX036admyaAkX2EKBK4a49tCGT3w5AJ854hyocqeudlZy/wHwUQnE
         Yzg48CtjEQoeIMkNcxFy4q7KiUlnFp8o4vWBmXEHa/5LLWWcZcHMqPoXq9+8qJOpKjre
         23/6zLHUgITpu99xswVd4aBdiH9xhC/4taFB6LMB4u8/h3X9W9GWRQUT2EDb9u8oyWo0
         WC5g==
X-Received: by 10.194.133.42 with SMTP id oz10mr56196777wjb.40.1405071445815;
        Fri, 11 Jul 2014 02:37:25 -0700 (PDT)
Received: from floh-wuff-book.speedport_w723_v_typ_a_1_01_001 (p200300624D39BA013D393F00C5E8C7E1.dip0.t-ipconnect.de. [2003:62:4d39:ba01:3d39:3f00:c5e8:c7e1])
        by mx.google.com with ESMTPSA id fb8sm5397855wib.15.2014.07.11.02.37.24
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 11 Jul 2014 02:37:25 -0700 (PDT)
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.8; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253265>

Hi,

git seems to have issues with alternates when cycles are present (repo A 
has B/objects as alternates, B has A/objects as alternates). In such 
cases, gc and repack might delete objects that are present in only one 
of the alternates, leading to data loss.

I understand that this is no big use case, and requires manual editing 
of objects/info/alternates. But for the sake of preventing unneccesary 
data loss, and since I found no warning regarding alternate cycles in 
the documentation, it might make sense to handle such cases properly 
(maybe it's a simple "after finding all alternates directories, remove 
duplicates"?).

Here is a small test case that adds the object storage of a repository 
as alternate to itsself. After git repack -adl, all objects are deleted.

---
rm -rf test_repo &&
mkdir test_repo &&
cd test_repo &&
git init &&
touch a &&
git add a &&
git commit -m "c1" &&
git repack -adl &&
echo $PWD/.git/objects > .git/objects/info/alternates &&
echo ">> re-packing..." &&
git repack -adl &&
echo ">> git fsck..." &&
git fsck
---

Output:

---
Initialized empty Git repository in /somewhere/test_repo/.git/
[master (root-commit) ab9e123] c1
  1 file changed, 0 insertions(+), 0 deletions(-)
  create mode 100644 a
Counting objects: 3, done.
Writing objects: 100% (3/3), done.
Total 3 (delta 0), reused 0 (delta 0)
 >> re-packing...
Nothing new to pack.
error: refs/heads/master does not point to a valid object!
 >> git fsck...
Checking object directories: 100% (256/256), done.
Checking object directories: 100% (256/256), done.
error: HEAD: invalid sha1 pointer 1494ec24356cbbbd66e19f22cef762dd83de7f54
error: refs/heads/master does not point to a valid object!
notice: No default references
missing blob e69de29bb2d1d6434b8b29ae775ad8c2e48c5391
---

Thanks
- Eph
