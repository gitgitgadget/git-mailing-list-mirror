From: Ilya Basin <basinilya@gmail.com>
Subject: git svn dcommit  doesn't work with useSvnsyncProps
Date: Tue, 23 Apr 2013 20:07:34 +0400
Message-ID: <163892758.20130423200734@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 23 18:07:53 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUfl1-0005oP-Fa
	for gcvg-git-2@plane.gmane.org; Tue, 23 Apr 2013 18:07:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755761Ab3DWQHp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Apr 2013 12:07:45 -0400
Received: from mail-la0-f46.google.com ([209.85.215.46]:44192 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755450Ab3DWQHn (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Apr 2013 12:07:43 -0400
Received: by mail-la0-f46.google.com with SMTP id ep20so708487lab.33
        for <git@vger.kernel.org>; Tue, 23 Apr 2013 09:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to
         :subject:mime-version:content-type:content-transfer-encoding;
        bh=SmUaRw2yDvfqe1BA4XfBrS1qCMe+X8PBGSB/FQmjZAo=;
        b=J9TGYHZnE4ZBOaaCOwfmeBNqoLenSWeiWGbTjlBrCNd5RM1peTu9Ap2OZQjVeEagfP
         0xTZGXXFtLqpFqcjBr/VrBTbXPyvyODomY81ik/bGYw5i7x17z4b7qFWFO51H0PmVoNy
         GFUFIGi1F3Z21H4qRlhovdc1BFJFUXDsA6Otlqrtz0J2ZDOudsyuZnxjzJuom4SfuYFz
         vsLVloJcqk0P9UaLqvLmtmZCPJAhwcegCie+oSn6c5WkvQZB/KVKZhanlpKSXwvxXgny
         Zxvk0urEDblYSXD9PZLP71jTQ6s1d5pTVEN7z3rAr3wZu+W81B5A3y3iyAdOU9DZaHUI
         xGoQ==
X-Received: by 10.112.147.170 with SMTP id tl10mr15489977lbb.100.1366733261588;
        Tue, 23 Apr 2013 09:07:41 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:4120:6166:deca:ee11])
        by mx.google.com with ESMTPS id b2sm12470775lbv.4.2013.04.23.09.07.38
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 23 Apr 2013 09:07:39 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222184>

Hi list.
Things often go wrong with git svn. Often you have to try different
svn layouts and path ignores.
This is why I prefer to do the long lasting svn mirror once and then
clone the mirror to git with --use-svnsync-props. Why use this option
at all? Because without it the commits have different commit message
and are are valid only on local machine.

Till now I only imported from svn and never exported. And today I get
this:
    $ git svn info # or rebase, or dcommit
    Unable to determine upstream SVN information

I found a workaround:
    - delete .git/svn/.metadata (once).
    - to do 'git svn dcommit'  temporarily change the svn url to the
    real one
    - to do 'git svn fetch' temporarily change the svn url to the
    mirror

or
    - import a few commits from the upstream svn repo to init the
    metadata
    - switch to the mirror

    
test script:

    testdir=`mktemp -d`
    echo "testdir = $testdir"
    cd "$testdir"
    
    pushurl="file://$testdir/test.svn"
    echo "creating repo test.svn"
    svnadmin create test.svn
    svn mkdir -m "" "$pushurl/trunk" "$pushurl/tags" "$pushurl/branches"
    
    echo "checking out"
    svn checkout "$pushurl/trunk" "test"
    cd "test"
    
    echo "committing"
    echo x > f
    svn add f
    svn commit -mx >/dev/null
    
    svn cp -m"create testbranch" "$pushurl/trunk" "$pushurl/branches/testbranch"
    
    for ((i=0; i<4; i++)); do
    echo $i > f
      svn commit -m"$i" >/dev/null
    done
    
    svn cp -m"create testtag" "$pushurl/trunk" "$pushurl/tags/testtag"
    
    cd ..
    rm -rf test
    
    mkdir gitsvn
    cd gitsvn
    
    rourl=file://`pwd`/test.svn
    
    svnadmin create "test.svn"
    echo '#!/bin/sh' > "test.svn/hooks/pre-revprop-change"
    chmod +x "test.svn/hooks/pre-revprop-change"
    
    svnsync init "$rourl" "$pushurl"
    svnsync sync "$rourl"
    
    
    git svn init --stdlayout $pushurl test
    cd test
    git config svn-remote.svn.pushurl "$pushurl"
    
    # need to fetch one revision from pushurl for proper metadata init
    git svn fetch --revision BASE:1
    
    # switching to mirror
    git config svn-remote.svn.useSvnsyncProps 1
    git config svn-remote.svn.url "$rourl"
    
    # hiding real repo
    mv $testdir/test.svn{,.1}
    
    # feetching from mirror
    git svn fetch
    
    # restoring real repo
    mv $testdir/test.svn{.1,}
    
    # here's the error: Unable to determine upstream SVN information from working tree history
    git svn info
    git svn rebase
    
    # switching to real repo
    git config svn-remote.svn.useSvnsyncProps 0
    git config svn-remote.svn.url "$pushurl"
    
    # now it works:
    git svn info
    git svn rebase
