From: Bo Yang <struggleyb.nku@gmail.com>
Subject: git blame -M problem
Date: Thu, 25 Mar 2010 22:07:52 +0800
Message-ID: <41f08ee11003250707ta80f691mbd66a7d88a99e589@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 25 15:08:51 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NunjV-00016Z-1A
	for gcvg-git-2@lo.gmane.org; Thu, 25 Mar 2010 15:08:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754474Ab0CYOH4 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 25 Mar 2010 10:07:56 -0400
Received: from mail-qy0-f188.google.com ([209.85.221.188]:58429 "EHLO
	mail-qy0-f188.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752625Ab0CYOHy (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 25 Mar 2010 10:07:54 -0400
Received: by qyk26 with SMTP id 26so5531355qyk.19
        for <git@vger.kernel.org>; Thu, 25 Mar 2010 07:07:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type;
        bh=GYQnDu80AHj0GNASlujHgzlM5lpOrYXFek3PErYeFks=;
        b=OAXiWWl3vtICtdFGimXxr18Wj4PE9Ge9ucz2UpznJI+CIKYHnEOiQoWCPEVh0pmvs8
         /TCyldLMm3OgMKen/sOBuoaODMWL4yF5LNWohAJ754CRJAhb0M2i74CKhMq8S5kyhTwx
         ni6Dk3UGbAAbaJ0HFRMH7v+rdUsqnjy0wp0Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type;
        b=kLZDF73J/CmzjVIrh+HFMWC7QQls1oat2kzUCVNTMt+YxnvF7pbSuzwBPFgwE+eJVG
         Ewcunq/6HtHYf2vkK1Z+Eh1O4MxbntPDaO+K0pGYEHtql6N0O7TahZO7o6w1otWYjAsm
         jmVxicem2INGTz75yK4q3Ji582VgmVONT9D0Y=
Received: by 10.229.230.84 with SMTP id jl20mr3628833qcb.88.1269526072730; 
	Thu, 25 Mar 2010 07:07:52 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/143179>

Hi,
    I am now digging into blame/log code recent days. And I find that
'git blame -M' act not as what express in the document. In the docs:

-M|<num>|
Detect moving lines in the file as well. When a commit moves a block
of lines in a file (e.g. the original file has A and then B, and the
commit changes it to B and then A), the traditional blame algorithm
typically blames the lines that were moved up (i.e. B) to the parent
and assigns blame to the lines that were moved down (i.e. A) to the
child commit. With this option, both groups of lines are blamed on the
parent.

<num> is optional but it is the lower bound on the number of
alphanumeric characters that git must detect as moving within a file
for it to associate those lines with the parent commit.

It said, -M will blame the moved code to its author before movement.
But from the code, I find, the function 'find_move_in_parent' is
really try to find some same code with the current suspected lines in
the current blamed file instead of searching code movement. So, if you
have a file like:
-------------------
byang@byang-laptop:~/git/test$ cat n
one
two
three
one
two
three
--------------------
Note that, the last three lines is copied from the first three ones.

byang@byang-laptop:~/git/test$ git blame n
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 1) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 2) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 3) three
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 4) one
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 5) two
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 6) three

byang@byang-laptop:~/git/test$ git blame -M1 n
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 1) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 2) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 3) three
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 4) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 5) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 6) three

And blame -C

byang@byang-laptop:~/git/test$ git blame -C1 n
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 1) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 2) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 3) three
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 4) one
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 5) two
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 6) three

byang@byang-laptop:~/git/test$ git blame -C1 -C1 n
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 1) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 2) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 3) three
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 4) one
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 5) two
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 6) three

byang@byang-laptop:~/git/test$ git blame -C1 -C1 -C1 n
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 1) one
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 2) two
41f445bd (Bo Yang 2010-03-25 22:01:26 +0800 3) three
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 4) one
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 5) two
b2b6ac51 (Bo Yang 2010-03-25 22:01:38 +0800 6) three

So, I think indeed, -M deals with the code move/copy inside same file
and -C deal with code copy between files. I am wondering is this
behavior desired? If so, should the documents to be changed to make it
more clear?

Thanks!

Regards!
Bo
-- 
My blog: http://blog.morebits.org
