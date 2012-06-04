From: Stefan Beller <stefanbeller@googlemail.com>
Subject: Re: Bugreport on Ubuntu LTS: not ok - 2 Objects creation does not
 break ACLs with restrictive umask
Date: Mon, 4 Jun 2012 22:49:36 +0200
Message-ID: <CALbm-EYZrSU2toOOLTKTQsyT9WCejnNMGMtMYrc+Q25kTCdHaQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Jun 04 22:49:54 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SbeDd-0004yL-99
	for gcvg-git-2@plane.gmane.org; Mon, 04 Jun 2012 22:49:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754762Ab2FDUti (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Jun 2012 16:49:38 -0400
Received: from mail-gg0-f174.google.com ([209.85.161.174]:46032 "EHLO
	mail-gg0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755243Ab2FDUth (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Jun 2012 16:49:37 -0400
Received: by gglu4 with SMTP id u4so3426975ggl.19
        for <git@vger.kernel.org>; Mon, 04 Jun 2012 13:49:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=JITJcU57zt7yiGxUmkb+zEKYj3eOLhx/IMymuQ6aFR4=;
        b=axe1bzXjUlrkcS/p/oY/vZpWb6dPCyQURsp4geYzqDYYul8RhlgtMAJzjfuWINDoUW
         U3qFUa7XoziAynOgZR0Hc8+u2H865vd5LOGuH446lOmglrGb4dWAhiy6Tt2vhb4veIfz
         9SG6Sr6El8K2yZcH/5LiRJ8H1jv/qZ/MEcVUHMd7/PSDRmitL7swNeWEjpQsSisvfAAS
         Twc7VMXqIs7/rs3rBd4Kw/sa2ei8r5ud9i8eG5L6obVLMJhXrXvICHxuWZx7JXNZSMEC
         2Oerw5tTITjUyp1WXr0Aj5KxPUE9z3Lht/4mc2S3JmH3ZRukEZm4xJ6zsAmKwIhnKbVZ
         lDIg==
Received: by 10.236.73.136 with SMTP id v8mr8373530yhd.103.1338842976679; Mon,
 04 Jun 2012 13:49:36 -0700 (PDT)
Received: by 10.236.175.226 with HTTP; Mon, 4 Jun 2012 13:49:36 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199186>

Hi,

I tried debugging into it:
In git/t/t1304-default-acl.sh there is:
check_perms_and_acl () {
   test -r "$1" &&
   getfacl "$1" > actual &&
   grep -q "user:root:rwx" actual &&
   grep -q "user:${LOGNAME}:rwx" actual &&
   egrep "mask::?r--" actual > /dev/null 2>&1 &&
   grep -q "group::---" actual || false
}

but when I do all the commands as in the test2:
test_expect_success SETFACL 'Objects creation does not break ACLs with
restrictive umask' '
   # SHA1 for empty blob
   check_perms_and_acl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
'
Now I run the second line in check_perms_and_acl ()  with
.git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
there is

getfacl .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
# file: .git/objects/e6/9de29bb2d1d6434b8b29ae775ad8c2e48c5391
# owner: sb
# group: sb
user::r--
user:root:rwx                   #effective:---
user:sb:rwx                     #effective:---
group::---
mask::---
other::---

This command seem to fail 'egrep "mask::?r--" actual' as there is
mask::---
but expected is
mask::r--

That's my understanding of the test case so far.


2012/6/4 Junio C Hamano <gitster@pobox.com>:

> Stefan Beller <stefanbeller@googlemail.com> writes:
>
>> so I just pulled the new git v1.7.10.4 and tried to test it with
>>> make test
>> This yields this output:
>> stderr http://pastebin.com/V8yuZFfi
>> stdout http://dl.dropbox.com/u/6520164/git/maketest.txt
>>
>> In Test 1304 there is
>> not ok - 2 Objects creation does not break ACLs with restrictive umask
>>
>> I am running Ubuntu 12.04 with Linux sb 3.2.0-25-generic #40-Ubuntu
>> SMP Wed May 23 20:30:51 UTC 2012 x86_64 x86_64 x86_64 GNU/Linux
>
> Interesting. I've seen t1304 break from time to time.
>
> I set the DEFAULT_TEST_TARGET to "prove", and when the test suite
> finishes with this failure, I noticed t3600-rm and some other test I
> do not recall also failed, with two extra files (actual and expect)
> at the root of the TEST_OUTPUT_DIRECTORY (set to /dev/shm/testpen
> via "--root=/dev/shm/testpen" option).
>
> I the breakage does not happen reproducibly with any pattern other
> than the above (I do not know if it never happens when test target
> is set to "test", for example), so haven't looked (and will not
> look) into it myself further than that.
