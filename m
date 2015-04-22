From: Yohei Endo <yoheie@gmail.com>
Subject: Wrong gitignore precedence?
Date: Wed, 22 Apr 2015 15:05:58 +0900
Message-ID: <20150422150558.6326cb6152a306f028fb6ad3@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 22 08:06:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YknnX-0002ja-BO
	for gcvg-git-2@plane.gmane.org; Wed, 22 Apr 2015 08:06:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756247AbbDVGGG convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 22 Apr 2015 02:06:06 -0400
Received: from mail-pa0-f46.google.com ([209.85.220.46]:34447 "EHLO
	mail-pa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621AbbDVGGE convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 22 Apr 2015 02:06:04 -0400
Received: by pacyx8 with SMTP id yx8so263381154pac.1
        for <git@vger.kernel.org>; Tue, 21 Apr 2015 23:06:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:subject:message-id:mime-version:content-type
         :content-transfer-encoding;
        bh=bO3/7Wjb0fZi7n4z1W35i5ktR7OIi+OtIaxbUXzchmU=;
        b=jIm1wWkClQZ7dDGK9VBG7DiqvRtMcC5z9rZ+GuO+DH/lcK6BasX5LUFzsozXpLo1th
         eqY8CUyqRnRE0ZgSHcdWW3DOmggGwegblyeH9zSFIY0NEgP68tzFcjkbqACc0WQkz+4a
         cUPg3fDrHXxa/9yHu7HkdWKIeDPO/W2AhvroKQC3bUTmYXsV1a43s4Wuh21mkQo0jsn7
         pJzlvyOkrWCYTVvnvf5TETA5hyof/Omomalzuc+mxprRXuyHZyOEHxvzeHnANuPRxNiJ
         KPewT6IG3z41H3DkVfjo8CY8tRmGNMLN/t7zMvZUM7Sawlwz++aadTp6ZM2O5BSPwH7d
         tsWA==
X-Received: by 10.68.65.17 with SMTP id t17mr44292779pbs.74.1429682763703;
        Tue, 21 Apr 2015 23:06:03 -0700 (PDT)
Received: from UPLT060 (europa.ul-net.co.jp. [114.179.20.132])
        by mx.google.com with ESMTPSA id pq5sm3787297pbb.92.2015.04.21.23.06.02
        for <git@vger.kernel.org>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Tue, 21 Apr 2015 23:06:03 -0700 (PDT)
X-Mailer: Sylpheed 3.4.2 (GTK+ 2.10.14; i686-pc-mingw32)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267578>

Hello All,

I read the document of gitignore (http://git-scm.com/docs/gitignore),
and learned that $GIT_DIR/info/exclude has higher precedence than
the file specified by core.excludesfile.

But I noticed that patterns in core.excludesfile override patterns in
$GIT_DIR/info/exclude.

I tested as below:

   1. Make a new git repository for test, and move into the repository.
      $ git init testrepo
      $ cd testrepo
   2. Change core.excludesfile configuration.
      $ touch ../core_excludesfile
      $ git config core.excludesfile `realpath ../core_excludesfile`
   3. Create test~. In each step I check if the file is ignored or not.
      $ touch test~
   4. See git status. In this case I expect that test~ should not be ig=
nored.
      $ git status --ignored
   5. Change settings in .git/info/exclude.
      $ echo '*~' > .git/info/exclude
   6. See git status. In this case I expect that test~ should be ignore=
d.
      $ git status --ignored
   7. Change settings in .git/info/exclude and core.excludesfile.
      $ echo '*~' > ../core_excludesfile
      $ echo '!*~' > .git/info/exclude
   8. See git status. In this case I expect that test~ should not be ig=
nored.
      $ git status --ignored
   9. Change settings in .git/info/exclude and core.excludesfile
      $ echo '!*~' > ../core_excludesfile
      $ echo '*~' > .git/info/exclude
  10. See git status. In this case I expect that test~ should be ignore=
d.
      $ git status --ignored

Steps 4. and 6. worked as I expected, but 8. and 10. didn't.

I read the source code of Git, and found out the point that seems to
cause the problem.

In dir.c, setup_standard_excludes() adds patterns in .git/info/exclude =
to
the excludes list first, and patterns in core.excludesfile are added ne=
xt.

In last_exclude_matching_from_list(), pattern is searched from the end =
of
the list, and the first matching pattern is used. Therefore the pattern=
s
in core.excludesfile are used in precedence to .git/info/exclude.

To meet the precedence described in the document of gitignore, I guess
setup_standard_excludes() should be fixed so that patterns in
core.excludesfile are added to the list before those in
=2Egit/info/ecdlude are added.

Thanks

--=20
  =E9=81=A0=E8=97=A4 =E9=99=BD=E5=B9=B3 (Yohei Endo)
    yoheie@gmail.com
