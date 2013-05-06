From: Ilya Basin <basinilya@gmail.com>
Subject: Re[3]: [PATCH 4/5] git-svn: fix bottleneck in stash_placeholder_list()
Date: Mon, 6 May 2013 12:58:46 +0400
Message-ID: <366899002.20130506125846@gmail.com>
References: <1438528085.20130501090926@gmail.com> <1409591910.20130501123153@gmail.com> <7vhaim8w48.fsf@alter.siamese.dyndns.org> <455264907.20130501235104@gmail.com> <20130501213031.GA13056@dcvr.yhbt.net> <7v1u9q5pu5.fsf@alter.siamese.dyndns.org> <20130502024926.GA12172@dcvr.yhbt.net> <12810110770.20130502213124@gmail.com>
Reply-To: Ilya Basin <basinilya@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Git mailing list <git@vger.kernel.org>,
	Ray Chen <rchen@cs.umd.edu>
To: Eric Wong <normalperson@yhbt.net>
X-From: git-owner@vger.kernel.org Mon May 06 10:59:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZHGA-000443-AN
	for gcvg-git-2@plane.gmane.org; Mon, 06 May 2013 10:59:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752742Ab3EFI65 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 May 2013 04:58:57 -0400
Received: from mail-la0-f45.google.com ([209.85.215.45]:52904 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752469Ab3EFI65 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 May 2013 04:58:57 -0400
Received: by mail-la0-f45.google.com with SMTP id fp12so3079900lab.4
        for <git@vger.kernel.org>; Mon, 06 May 2013 01:58:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:date:from:x-mailer:reply-to:x-priority:message-id:to:cc
         :subject:in-reply-to:references:mime-version:content-type
         :content-transfer-encoding;
        bh=L2Y3xYtJyXwCddeI+4MJkZ6v/R7P20mBND4NGGEe0Ag=;
        b=rAVc/VaFM0wpfObfyulsAanqJKksa25c8IPOeFYAWgvff3q2AHqID8kKEsjhFXkrez
         Xi4Q3v7iSxo62aMP+W3g1/tt6UZy6Y2rilf4VKU8NB+1HhWaxVNKS2Zg8AGIC86ABLQU
         Vpbrzl5x2AJtX2owBdzReAe0CNITHr86hGhsaJrrvYUEYYm+2782y/T+oqEOPy3ru7Xx
         c9AmhBb52mo4lYPpW5OJ5VFaf7KD/m5gya3QcczcuX7n7YVGZr57XohNBrCAksN2wYXR
         Yegv1NBk/mIrRbPiyAXkZFIXMGuLw8HD+A0NhRseEuKyS4FyEp1O4GdrP/AclF2rQsKn
         qDnA==
X-Received: by 10.112.201.4 with SMTP id jw4mr7258380lbc.47.1367830732719;
        Mon, 06 May 2013 01:58:52 -0700 (PDT)
Received: from BASIN.reksoft.ru ([2a00:1120:0:1001:1842:ea3c:41c8:517a])
        by mx.google.com with ESMTPSA id t6sm8632959lae.3.2013.05.06.01.58.50
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Mon, 06 May 2013 01:58:51 -0700 (PDT)
X-Mailer: Voyager (v3.99.4) Professional
X-Priority: 3 (Normal)
In-Reply-To: <12810110770.20130502213124@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223430>

Hi Eric. I'm out of spare time and I still unable to import my repo.
The code of SVN.pm is too complex. Please help me.
Here's the list of my issues:

* I think git-svn doesn't handle the case, when a tag is deleted.
  I expected it to rename the ref from "tags/tagname" to
  "tags/tagname@rev", but that doesn't happen.
  If a tag is replaced, there's no way to tell what was the previous
  state of that tag: git-svn just rewrites the ref.
  On the contrary, the temporary refs (with "@rev" suffix), used for
  re-import subdir tags are kept after successful reimport, although
  they have no usage.

* As I said already, I have 25k revisions and 200 tags created from
  subdirs in trunk. This increases the import time from 2h to 12h.
  I would bear it, if it had to be done once, but fetching a new
  revision may cause re-import of all 25k revisions too.
  You should implement some mechanism to find the parent branches of
  subdir tags. Maybe the unused refs I mentioned in the previous issue
  are good candidates for that, but I would name them somehow
  different to distinguish with deleted/replaced tags/branches.

* There are mistake commits in the svn history, similar to this:
    ------------------------------------------------------------------------
    r21255 | xxx_xxxxxx_xxxxxxxxx | 2012-03-02 18:46:30 +0300 (Fri, 02 Mar 2012) | 1 line
    Changed paths:
      A /tags/dmagentenabler-4.1.31/DMAgent (from /tags:20998)
    
    Delivery 4.1.31
    ------------------------------------------------------------------------
  git-svn tries to creates a tag, containing dirs with other tags.
  Technically, behaves correctly, but it hangs, because of the size of
  the commit.
  To solve it, I had to edit the svn dump file:

     Node-path: tags/dmagentenabler-4.1.31/DMAgent
     Node-kind: dir
     Node-action: add
    -Node-copyfrom-rev: 20998
    -Node-copyfrom-path: tags
    +Prop-content-length: 10
    +Content-length: 10
    +
    +PROPS-END
     
     
     Revision-number: 21256

  It creates an empty dir, instead of copying. Since the author
  noticed the mistake, he immediately deleted the dir in the next
  revision, so it works.
