From: "H. Peter Anvin" <hpa@zytor.com>
Subject: Suggestion: superceded tags
Date: Thu, 26 May 2005 22:29:53 -0700
Message-ID: <4296B051.10603@zytor.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Fri May 27 07:28:37 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DbXOG-0006lH-3K
	for gcvg-git@gmane.org; Fri, 27 May 2005 07:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S261823AbVE0FaI (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 27 May 2005 01:30:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S261824AbVE0FaI
	(ORCPT <rfc822;git-outgoing>); Fri, 27 May 2005 01:30:08 -0400
Received: from terminus.zytor.com ([209.128.68.124]:37038 "EHLO
	terminus.zytor.com") by vger.kernel.org with ESMTP id S261823AbVE0F37
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2005 01:29:59 -0400
Received: from [172.27.0.18] (c-67-169-23-106.hsd1.ca.comcast.net [67.169.23.106])
	(authenticated bits=0)
	by terminus.zytor.com (8.13.1/8.13.1) with ESMTP id j4R5TrmQ016068
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 26 May 2005 22:29:54 -0700
User-Agent: Mozilla Thunderbird 1.0.2-1.3.2 (X11/20050324)
X-Accept-Language: en-us, en
To: Git Mailing List <git@vger.kernel.org>
X-Virus-Scanned: ClamAV version 0.85.1, clamav-milter version 0.85 on localhost
X-Virus-Status: Clean
X-Spam-Status: No, score=0.3 required=5.0 tests=AWL,BAYES_00,
	RCVD_IN_NJABL_DUL,RCVD_IN_SORBS_DUL autolearn=no version=3.0.3
X-Spam-Checker-Version: SpamAssassin 3.0.3 (2005-04-27) on terminus.zytor.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

It's a pretty fundamental concept in git that objects in the object 
repository live forever.  This is key to distribution, and is a good thing.

However, for tag objects, this is somewhat awkward.  It is occationally 
necessary to move a tag (restarted release processes, being one reason); 
purists tend to frown on it but it's reality.

It would be nice to maintain that all tag information exists in the 
object database and loss of the .git/refs directory will not harm that. 
  Thus, I'd like to suggest the following protocol:

When a tag is moved, a new tag object is created.  This tag object will 
have a "supercedes" header which references the old tag object.

Say, for example, that tag "klibc-1.0.14", object 
4695b4d163b62f6a9860b9bbe06ff30edb6e02be, exists with the following 
contents:

object fdb8a185ef261568f01140989745b8636212db71
type commit
tag klibc-1.0.14

Now "klibc-1.0.14" needs to be moved to new commit 
088c166af39b1ca2712667c44dccd3c7af99a8fb.

The new tag object should thus look like:

object 088c166af39b1ca2712667c44dccd3c7af99a8fb
type commit
supercedes 4695b4d163b62f6a9860b9bbe06ff30edb6e02be
tag klibc-1.0.14

(I put "supercedes" before "tag", because unfortunately the tag header 
terminates immediately after the "tag" line without having an 
intervening blank line.)

This will make it possible to move the tag, but still to recreate all 
tag information from the object database alone.

None of this can of course help the conflict if the same tag is created 
in different places by different people, and then they are trying to be 
merged.  The above at least makes it possible to distinguish the case of 
a tag conflict with the case of a moved tag, and in the case of the 
moved tag, will stand out.

On the other hand, it makes it possible for more than one tag to exist 
with the same name pointing to the same object:

User 1 creates tag X referring to object A	-> T1
User 1 moves tag X to object B			-> T2
User 2 creates tag X referring to object B	-> T3

There is no conflict here, but T2 and T3 will be different objects (one 
will supercede T1, and the other won't.)  An object-database-scanning 
program should observe that T2 and T3 are consistent, and T1 is 
superceded, therefore tag X is well-defined; it can arbitrarily use 
either instance T2 or T3.

	-hpa
