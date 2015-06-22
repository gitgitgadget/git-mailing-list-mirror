From: David Aguilar <davvid@gmail.com>
Subject: Re: git difftool --dir-diff error in the presence of symlinks to
 directories
Date: Mon, 22 Jun 2015 05:20:25 +0000
Message-ID: <20150622052024.GA2188@gmail.com>
References: <CAFB4ZjUnhEMfjg9+sHrPp271e=V=yU_5QFHBbmPpWMkb72+ENw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, John Keeping <john@keeping.me.uk>,
	Tim Henigan <tim.henigan@gmail.com>
To: Ismail Badawi <ismail@badawi.io>
X-From: git-owner@vger.kernel.org Mon Jun 22 07:20:39 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z6u9s-0005kV-Lb
	for gcvg-git-2@plane.gmane.org; Mon, 22 Jun 2015 07:20:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753955AbbFVFUd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Jun 2015 01:20:33 -0400
Received: from mail-pa0-f48.google.com ([209.85.220.48]:36129 "EHLO
	mail-pa0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750919AbbFVFUb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Jun 2015 01:20:31 -0400
Received: by paceq1 with SMTP id eq1so101657422pac.3
        for <git@vger.kernel.org>; Sun, 21 Jun 2015 22:20:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=nP9Z9ZUupVR5qeJ+sA8BtTMTbqfhAwpfUQkr5sFflkY=;
        b=zh/H9dpuTM1vRKNwQMQ/AMlqfV1QfuoWh9tNJhW1L3Iq1QLNLeBeaS3pvs9V9p3s1P
         irTMC1ELx3PfPK2giaYp7Ru3iPoukDCj77H2fHvwgOFqEBzLQ7KNEdXq9jUvhbInWyOS
         CGZF6M8vuuRw5DjX4HaoZ3SlNJctfqSoSEgEuFs70nP7UoROxl9DmwF8E5lvLhFSGrd6
         mkeePwCP3QFbh0rSCFOEHaULl6IIdsns6Wux81dV5oIRPdUK/VGimWjQ4nm8Ono2igEa
         JhPg15xTwO5WYgueQTXDxCfgNwpRiWNj84ZfYf5CJvKZOri7btjBKBc4BRKEqoJhnOaQ
         AznQ==
X-Received: by 10.69.26.170 with SMTP id iz10mr54591575pbd.81.1434950431052;
        Sun, 21 Jun 2015 22:20:31 -0700 (PDT)
Received: from gmail.com (208-106-56-2.static.sonic.net. [208.106.56.2])
        by mx.google.com with ESMTPSA id kw5sm5975998pab.29.2015.06.21.22.20.28
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 21 Jun 2015 22:20:29 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <CAFB4ZjUnhEMfjg9+sHrPp271e=V=yU_5QFHBbmPpWMkb72+ENw@mail.gmail.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272315>

On Wed, Jun 17, 2015 at 06:39:27PM -0400, Ismail Badawi wrote:
> Reproduce like this (using git 2.4.3):
> 
> git init
> mkdir foo
> touch foo/bar
> git add .
> git commit -m "Initial commit."
> ln -s foo link
> git add .
> git commit -m "Add link to foo."
> git difftool -d HEAD^ HEAD
> 
> That last command outputs:
> 
> fatal: Unable to hash /Users/isbadawi/test/link
> hash-object /Users/isbadawi/test/link: command returned error: 128
> 
> Briefly looking at the 'git difftool' source it looks like it uses the
> output of 'git diff --raw' and calls 'hash-object' on any object whose
> mode is nonzero, including symlinks.
> 
> I'm not sure what the right thing to do here is -- just thought I'd
> report this failure.
> 
> Thanks,
> Ismail

Thanks for the bug report, Ismail.

This looks like an unhandled edge case that difftool's dir-diff
mode doesn't take into account.  I've cc'd Tim and John since
they're both familiar with this part of the code.

We should take your bug recipe above and add it to difftool's
test suite when fixing the bug.  I've included a diff below that
adds the above snippet to t7800-difftool.sh.

As far as how to handle this edge case -- one option is that we
could detect that the link points at a directory and ignore it.

I think what's happening is that we're hashing the file so that
we can later detect whether it's changed.  The fix might be as
simple as skipping links to directories in that code path, but I
haven't looked too closely yet.  I can take a look in a couple
of weeks if no one beats me to it by then.

--- >8 --- >8 ---
diff --git a/t/t7800-difftool.sh b/t/t7800-difftool.sh
index ea35a02..f67fc65 100755
--- a/t/t7800-difftool.sh
+++ b/t/t7800-difftool.sh
@@ -504,4 +504,24 @@ test_expect_success PERL 'difftool properly honors gitlink and core.worktree' '
 	)
 '
 
+test_expect_success PERL,SYMLINKS 'difftool --dir-diff symlinked directories' '
+	test_config diff.tool checktrees &&
+	test_config difftool.checktrees.cmd "echo good" &&
+	git init dirlinks &&
+	(
+		cd dirlinks &&
+		mkdir foo &&
+		: >foo/bar &&
+		git add foo/bar &&
+		test_commit one &&
+		ln -s foo link
+		git add link
+		test_commit two &&
+		echo good >expect &&
+		git difftool --dir-diff HEAD~ >actual &&
+		test_commit expect actual
+
+	)
+'
+
 test_done
-- 
David
