From: Adam Dinwoodie <adam@dinwoodie.org>
Subject: [PATCH] t9117: test specifying full url to git svn init -T
Date: Wed, 16 Mar 2016 19:09:54 +0000
Message-ID: <20160316190954.GR29016@dinwoodie.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Eric Wong <normalperson@yhbt.net>,
	"Michael G. Schwern" <schwern@pobox.com>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 20:10:07 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1agGpZ-0003XD-E0
	for gcvg-git-2@plane.gmane.org; Wed, 16 Mar 2016 20:10:05 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755476AbcCPTJ7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2016 15:09:59 -0400
Received: from mail-wm0-f48.google.com ([74.125.82.48]:34830 "EHLO
	mail-wm0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752216AbcCPTJ6 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2016 15:09:58 -0400
Received: by mail-wm0-f48.google.com with SMTP id l68so200727997wml.0
        for <git@vger.kernel.org>; Wed, 16 Mar 2016 12:09:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dinwoodie.org; s=google;
        h=date:from:to:cc:subject:message-id:mime-version:content-disposition
         :user-agent;
        bh=4e0xhta8ju7xGoOUJq/xShPIYO7jCVVdi2ykA3Y1nEk=;
        b=gWKJh1ctEhK0tP236pTm1UX56fRQdYz4HQCuLofnBFQkWJIpQrGxz1fb+ee14dJrW/
         pgxb3HZ/Zva0XtlgkIzCz0RUnf+jsstwiftF4R8e8po6+UvVhjd8Diil0GXSDc5ssg7E
         LinsP7vz0Gzwz8iHsdC+1JVJPzKrEz5F2M8Y0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=4e0xhta8ju7xGoOUJq/xShPIYO7jCVVdi2ykA3Y1nEk=;
        b=QQZ22higfguZlrLw++PL+2bqpKMjyssk4EcDWKhOPPAji0ga/5Zh+yvw5/UPQvYjyE
         YURuLHLpCa4s00TxpabpylC7OPnrGI8O6U0ZY3hmpcsAKRhUcPVhuMXAbeCFZu8hWEua
         C7wrmoRrZUnZlkZZPzJkJfQ6WxUMYUlt5hR8clAC/+xRVm/Crx7VSJP5bwEYvZ3OnI7G
         kwTRBchHZxN/CUaEOYPxRIkA8p9elYMIUVk7jeiZ3hNevooq+fp+vHldorKb1CJleglg
         UfOijZR+ezaLQrx2f42lBzCLhxUoPOKMITafAcl3iVXknaYeQpiDu5zNSzTk+BTGgRIW
         dLRg==
X-Gm-Message-State: AD7BkJJkGFhXZMVlrFAZaxf0Kg7OWB8yKLmUbsiT1rWwGLew6JNLQNtscLulStPJBToixw==
X-Received: by 10.194.90.229 with SMTP id bz5mr6044624wjb.143.1458155396613;
        Wed, 16 Mar 2016 12:09:56 -0700 (PDT)
Received: from dinwoodie.org ([2001:ba8:0:1c0::9:1])
        by smtp.gmail.com with ESMTPSA id t3sm4346990wjz.11.2016.03.16.12.09.55
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Wed, 16 Mar 2016 12:09:55 -0700 (PDT)
Content-Disposition: inline
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/289019>

According to the documentation, full URLs can be specified in the `-T`
argument to `git svn init`.  However, the canonicalization of such
arguments squashes together consecutive "/"s, which unsurprisingly
breaks http://, svn://, etc URLs.  Add a failing test case to provide
evidence of that.

On systems where Subversion provides svn_path_canonicalize but not
svn_dirent_canonicalize (Subversion 1.6 and earlier?), this test passes,
as svn_path_canonicalize doesn't mangle the consecutive "/"s.

Signed-off-by: Adam Dinwoodie <adam@dinwoodie.org>
---

I think the bug here is in using perl/Git/SVN/Utils.pm's
`canonicalize_path` on the `-T` argument.  If it's available, that
function calls Subversion's `svn_dirent_canonicalize`.  The Subversion
code[0] makes it clear that this function is fine for relative and
absolute local paths, and for UNC paths on Windows, but it isn't
suitable for use on URLs.

[0]: https://svn.apache.org/repos/asf/subversion/trunk/subversion/include/svn_dirent_uri.h

It occurs to me that the correct "fix" here may simply be to stop
claiming support for specifying URLs as arguments to -T, and mandate
users use the `git svn init $url -T $dirent` syntax instead, but I
figured providing the failing testcase would be a good start to that
discussion regardless.

 t/t9117-git-svn-init-clone.sh | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/t/t9117-git-svn-init-clone.sh b/t/t9117-git-svn-init-clone.sh
index a66f43c..2ba003d 100755
--- a/t/t9117-git-svn-init-clone.sh
+++ b/t/t9117-git-svn-init-clone.sh
@@ -119,4 +119,10 @@ test_expect_success 'clone with -s/-T/-b/-t and --prefix "" still works' '
        rm -f warning
        '

+test_expect_failure 'init with -T as a full url works' '
+       test ! -d project &&
+       git svn init -T "$svnrepo"/project/trunk project &&
+       rm -rf project
+       '
+
 test_done
--
2.7.0
