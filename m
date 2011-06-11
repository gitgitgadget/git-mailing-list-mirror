From: =?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
Subject: [PATCH 0/4] Speed up git tag --contains
Date: Sat, 11 Jun 2011 19:04:07 +0000
Message-ID: <1307819051-25748-1-git-send-email-avarab@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Cc: Junio C Hamano <gitster@pobox.com>, Jeff King <peff@peff.net>,
	=?UTF-8?q?=C3=86var=20Arnfj=C3=B6r=C3=B0=20Bjarmason?= 
	<avarab@gmail.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jun 11 21:05:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QVTUn-0005fV-E3
	for gcvg-git-2@lo.gmane.org; Sat, 11 Jun 2011 21:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753517Ab1FKTFP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 11 Jun 2011 15:05:15 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:49518 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751679Ab1FKTFO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 11 Jun 2011 15:05:14 -0400
Received: by ewy4 with SMTP id 4so1232841ewy.19
        for <git@vger.kernel.org>; Sat, 11 Jun 2011 12:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:from:to:cc:subject:date:message-id:x-mailer
         :mime-version:content-type:content-transfer-encoding;
        bh=p/iQLiIsO9vbc36bCNQzfNTUa/zVMrUpVj+Wk8QEsaU=;
        b=VP/reowrHIJm1JuY79Zrv6QM6AFXXJ3zCqAbdsV6gCzQQEXjrRNSpBHrtDrmsS3jZb
         HKZL+zVevcFUtfqkjDTKxCM1YPGOKJj7usVm4MJ8jtcUHFUfncOZGN9gZHwTjlFyeCQC
         Ed3UMg3XZzGqHaJVLYY4vnCx0CGOilBIpHNbY=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:cc:subject:date:message-id:x-mailer:mime-version
         :content-type:content-transfer-encoding;
        b=I7sSQ6GXUGNdz9uXZBHj7XsY8CD7reKjSux9tSMtA3gmQYmIIYT/UMy9hkXStAkf0B
         JmT62NTbvt+Q3TrkFJSAKoYgvTb1ukOpvQugLGxUZFdwBDCsnY6NZCXbs8iojHCkG2w/
         sosYU6MvUk4xQmWlqfiqn9wMIcVfzIGK2Ih7Y=
Received: by 10.213.27.14 with SMTP id g14mr427694ebc.90.1307819112955;
        Sat, 11 Jun 2011 12:05:12 -0700 (PDT)
Received: from w.nix.is (w.nix.is [188.40.98.140])
        by mx.google.com with ESMTPS id v76sm477161eea.17.2011.06.11.12.05.11
        (version=SSLv3 cipher=OTHER);
        Sat, 11 Jun 2011 12:05:11 -0700 (PDT)
X-Mailer: git-send-email 1.7.5.3
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/175643>

This is a resubmission of Jeff King's patch series to speed up git tag
--contains with some changes. It's been cooking for a while as:

    * jk/tag-contains (2010-07-05) 4 commits
     - Why is "git tag --contains" so slow?
     - default core.clockskew variable to one day
     - limit "contains" traversals based on commit timestamp
     - tag: speed up --contains calculation
    
    The idea of the bottom one is probably Ok, except that the use of object
    flags needs to be rethought, or at least the helper needs to be moved to
    builtin/tag.c to make it clear that it should not be used outside the
    current usage context.

I've moved the relevant code from commit.[ch] to builtin/tag.c as
Junio's comment suggested. So IMO the "tag: speed up --contains
calculation" patch is ready to be applied.

The next two patches look OK to me, but they need some documentation
for the core.clockskew variable, which perhaps should be renamed to
tag.clockskew, or was the plan to use it for other things in the
future?

Is the "Why is "git tag --contains" so slow?" utility something we
want? We'd need some documentation for it, which I could
write. However I couldn't find the magic that turns --all into a
traversal of all revisions, and how that would work with supporting
another --verbose command-line option, to print out the revisions that
have high clock skew. I monkeypatched that in locally and found it
very useful to find the worst-case revisions, which in my case were on
topic branches that could simply be deleted.

In any case I've been running git with this series for a while, and
it's really helpful for a repository I work on with ~10k tags. I'm
willing to help get it accepted into the core.

Jeff King (4):
  tag: speed up --contains calculation
  limit "contains" traversals based on commit timestamp
  default core.clockskew variable to one day
  Why is "git tag --contains" so slow?

 .gitignore     |    1 +
 Makefile       |    1 +
 builtin.h      |    1 +
 builtin/skew.c |   50 ++++++++++++++++++++++++++++++++++++
 builtin/tag.c  |   76 +++++++++++++++++++++++++++++++++++++++++++++++++++++++-
 git.c          |    1 +
 6 files changed, 129 insertions(+), 1 deletions(-)
 create mode 100644 builtin/skew.c

-- 
1.7.5.3
