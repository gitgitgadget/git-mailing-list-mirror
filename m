From: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
Subject: git stash: add --index-only, or --keep-index should not stash index?
Date: Fri, 11 Mar 2011 19:47:19 +0100
Message-ID: <4D7A6E37.8080104@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Mar 11 19:47:37 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Py7NA-0001tw-WD
	for gcvg-git-2@lo.gmane.org; Fri, 11 Mar 2011 19:47:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753581Ab1CKSrb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Mar 2011 13:47:31 -0500
Received: from mail-bw0-f46.google.com ([209.85.214.46]:40544 "EHLO
	mail-bw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753143Ab1CKSr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Mar 2011 13:47:29 -0500
Received: by bwz15 with SMTP id 15so2919342bwz.19
        for <git@vger.kernel.org>; Fri, 11 Mar 2011 10:47:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:message-id:date:from:user-agent:mime-version:to
         :subject:content-type:content-transfer-encoding;
        bh=a7HtMvcQdONxBHM78Hbj5Mm4Vm9JeXuxa5mTUXfl+7U=;
        b=syf0BuDqMyJ/e1fFkKVKr9t3VrcU89XUVCAJYvsN2AvTDoHG74ROJJeMN8/B9/lXZO
         IbDfkwKXca18b6YDE3WbQm2GwZLGJ5FIzhvrIbYyG4gI/8zqMCNtrkCzZgjtY0IRuoO6
         fHx2JWUD97c0OjTmgnRSgHPkxRQFtfkLde0OM=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:user-agent:mime-version:to:subject
         :content-type:content-transfer-encoding;
        b=mUhPGHlZ8hgIygJ/coAnWsoIRvaotNM4Hhm51DR9R7dIndnAFrKWt7sknNcGXWXFsb
         6N8MdYlxqggg2uZT5g0Qd2jjTKwBIaKahhnVJUNeLQl4KVlZG/J5r4TZVe2wzMHeI006
         t/9w6pFSd7A19eB8wBmQZJodzFUiY84/+57BA=
Received: by 10.205.24.13 with SMTP id rc13mr1703023bkb.75.1299869247515;
        Fri, 11 Mar 2011 10:47:27 -0800 (PST)
Received: from [192.168.1.101] (bxd250.neoplus.adsl.tpnet.pl [83.29.253.250])
        by mx.google.com with ESMTPS id c11sm1668220bkc.2.2011.03.11.10.47.25
        (version=SSLv3 cipher=OTHER);
        Fri, 11 Mar 2011 10:47:26 -0800 (PST)
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.14) Gecko/20110223 Thunderbird/3.1.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/168921>

Hi,

I wanted to do something like "Testing partial commits" described in
git-stash documentation (see end of mail for reference). I think this
is a common scenario: you start working on some feature, then discover
a bug, start fixing it, but realize it needs more work. So now you have
two features that needs more work (both are not ready for committing). 

The documentation says to use --keep-index in this case.

The problem is that --keep-index leaves changes in index intact, but at
the same time it saves them in stash. So if I edit those changes I'm likely
to get conflicts when applying the stash.

For example:

$ git init && echo a > a && git add . && git commit -m a
$ echo x > a && git add a && git stash save --keep-index
$ echo y > a && git add a && git commit -m y
$ git stash pop
Auto-merging a
CONFLICT (content): Merge conflict in a

Maybe --keep-index should not stash staged changes? This would fix this
problem. And I can't  think of a situation when would want to stash changes
and at the same time keep them.

If --keep-index works correctly maybe a new option, for example --index-only
(or --cached-only?) could be introduced?


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

Testing partial commits::

You can use `git stash save --keep-index` when you want to make two or
more commits out of the changes in the work tree, and you want to test
each change before committing:
+
----------------------------------------------------------------
# ... hack hack hack ...
$ git add --patch foo            # add just first part to the index
$ git stash save --keep-index    # save all other changes to the stash
$ edit/build/test first part
$ git commit -m 'First part'     # commit fully tested change
$ git stash pop                  # prepare to work on all other changes
# ... repeat above five steps until one commit remains ...
$ edit/build/test remaining parts
$ git commit foo -m 'Remaining parts'
----------------------------------------------------------------


-- 
Piotr Krukowiecki
