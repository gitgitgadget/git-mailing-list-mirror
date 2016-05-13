From: Stefan Beller <sbeller@google.com>
Subject: [RFC PATCH 0/4] pathspec labels [WAS: submodule groups]
Date: Thu, 12 May 2016 17:19:32 -0700
Message-ID: <20160513001936.7623-1-sbeller@google.com>
Cc: pclouds@gmail.com, git@vger.kernel.org, jrnieder@gmail.com,
	Jens.Lehmann@web.de, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Fri May 13 02:19:51 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1b10pa-0006f2-Tq
	for gcvg-git-2@plane.gmane.org; Fri, 13 May 2016 02:19:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751379AbcEMATl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 12 May 2016 20:19:41 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:32951 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751006AbcEMATk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 May 2016 20:19:40 -0400
Received: by mail-pa0-f53.google.com with SMTP id xk12so34700893pac.0
        for <git@vger.kernel.org>; Thu, 12 May 2016 17:19:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id;
        bh=57WIl3/7MjHfieAAlsX/IKt0UzGChJphqhe3/vFbO0w=;
        b=kREMcNidQmUMwTbo0hGbWLcVYprYZlZddeJwh3VDMVF0/ExQAeFx1ERRmKsu9Y76bK
         +9+3jyrjdp+FAJI5JrUqjAKLU0JM4R8K9/lWCqh0Lz93+Sgkij+QmDKwMceiEsmB8xCh
         8tWWRBDBhK/MBVnRL5sFVWd1HViohkRifjoM9UtFcsePpNY8J0I8bJb8F9+osLpHapWQ
         ZNL7TQ/7KxE1A11AwHwyRAlWDd85ZNBG87aN6QWcUvT/HnCLQhy7mMWrUbHiCUtimUK4
         vwwor9154IvNnbTcaP94eFak+BE+WM+fRdQhuoEeS9Hgcs1R7nk7ISTq3t8jIWBbrIQf
         Rsaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=57WIl3/7MjHfieAAlsX/IKt0UzGChJphqhe3/vFbO0w=;
        b=hQBT8WR+BeNiZhXpt0TTtngI8me3xv6DxK8Vb8OgKndtQQToENb2VZnOFU6aFCnEEG
         GzEcZM/sd2CUcUQWBuguMUJKEw1pc7kIHQE0LzR7cv8Q+ldJOBLZnIjCvzp4oPFbt6jp
         Q0DBF/cFPJ+2qR19350o8iuT7b1wl6HBQnrrLu20jq/BBaHMqQceMOqIDz5IOyjiLInF
         l1J7Q6rpA9vSzfRoCfUt/ugRt3lXImCAIFjkk8hcyFcRJWZNsBlNOK/ozbnZ09ADyvbp
         RMI+/cD159SAQkYCocfD2lP/Fxof7oJnJ+I81cvKaEq8PsIabRuExTwqydTdeH9dvtxB
         vjvg==
X-Gm-Message-State: AOPr4FUI5rRsyOAH4pzseWz0myHApm24qUrHzbnseFBSv5qygMqb/6yvgQJXoqDNEcmRH6gx
X-Received: by 10.66.166.78 with SMTP id ze14mr18099786pab.149.1463098779591;
        Thu, 12 May 2016 17:19:39 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b10:c9fc:8b37:8cb7:4400])
        by smtp.gmail.com with ESMTPSA id xn3sm22487669pab.32.2016.05.12.17.19.38
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Thu, 12 May 2016 17:19:38 -0700 (PDT)
X-Mailer: git-send-email 2.8.2.400.g8bfb85c.dirty
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/294494>

After some fruitful discussion[1] in which Junio suggested trying a very
different route[2] that is more general and not submodule related, I considered
doing a mock for this.

This lets you label arbitrary pathspecs, e.g. in git.git we may want to have:

    t/t[0-9]*.sh label=tests
    
such that

    $ git log --author=Beller ":(label=tests)"
    
would show all commits in which I touched tests.

This has suprisingly few lines of code, as the first 3 patches are refactoring.
The actual new feature is in the last patch.

This would solve the submodule issues I want to solve, as I can produce a
.gitattributes like:

    ./submodule1 label=default
    ./submodule2 label=default
    ./submodule3 label=optional-feature1
    
and then I'd instruct the users to clone like this:

    git clone .. superproject
    cd superproject
    git submodule update --init :(label:default)
    
The second part of the submodule series to collapse these three commands
will come as an extra series later, then.

What annoys me here:
Attributes can only be set once at the moment, there is no way to collect all
attributes. If we'd have such a collection feature we would be able to
configure this:

    *.[ch] label=C,code
    contrib/** label=oldstuff
    
and run this:

    git status ":(label:C oldstuff)"
    
which would be the equivalent to

    contrib/**.[ch]
    
as in this proposed implementation the labels which are given within one
pathspec item are logical AND. To get the logical OR, you'd have to give multiple
pathspec items, i.e. ":(label:C)" ":(label:oldstuff)"

Feedback welcome!

Thanks,
Stefan

[1] http://thread.gmane.org/gmane.comp.version-control.git/294212
[2] http://thread.gmane.org/gmane.comp.version-control.git/294212/focus=294391

Stefan Beller (4):
  Documentation: correct typo in example for querying attributes
  pathspec: move long magic parsing out of prefix_pathspec
  pathspec: move prefix check out of the inner loop
  pathspec: record labels

 Documentation/glossary-content.txt            |   5 ++
 Documentation/technical/api-gitattributes.txt |   2 +-
 attr.h                                        |   1 +
 dir.c                                         |  31 ++++++++
 pathspec.c                                    | 109 +++++++++++++++++---------
 pathspec.h                                    |   1 +
 t/t6134-pathspec-with-labels.sh               |  91 +++++++++++++++++++++
 7 files changed, 201 insertions(+), 39 deletions(-)
 create mode 100755 t/t6134-pathspec-with-labels.sh

-- 
2.8.2.400.g66c4903.dirty
