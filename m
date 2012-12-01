From: Ramkumar Ramachandra <artagnon@gmail.com>
Subject: Stitching histories of several repositories
Date: Sat, 1 Dec 2012 14:41:29 +0530
Message-ID: <CALkWK0kCQQioCeuwWAAWfKodvOR+w+hB=11MYs5mGviN6Zy5qA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: Git List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Dec 01 10:12:25 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Tej7Y-00076x-HI
	for gcvg-git-2@plane.gmane.org; Sat, 01 Dec 2012 10:12:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751709Ab2LAJLx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 1 Dec 2012 04:11:53 -0500
Received: from mail-oa0-f46.google.com ([209.85.219.46]:51823 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751646Ab2LAJLv (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 1 Dec 2012 04:11:51 -0500
Received: by mail-oa0-f46.google.com with SMTP id h16so1273543oag.19
        for <git@vger.kernel.org>; Sat, 01 Dec 2012 01:11:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=8Cw+6oURWLRXboTttTiXJS3g5BHl/fEUZMZ68fZJ9uA=;
        b=CPp0LcvwG1Dg8DIZuo118hsBiQTluoFgL6jQdU/ai0I7/XJkWvj8UPRDbIlp485nZD
         Wh3IWe8EFJLVwQmHzkQQM00UmqOyToF4LFx2AkZWTJio63tCz6XLRF5CilBgc0WDTF3P
         Ar+PmGh75j0s4AcN8bsQBDqjfS1n0FPVytWyfEbZjNHgnJeRvePF1zn4N1dgTNjEE6gz
         ONytWkzSMjd9rMr7j4XjAc5mYWNiVoM+YP29D1ZNZvIyufQ2R220yz+t4FlcYFT8808J
         zqc/Tz0RTllRzy+6Za9iHhwKqHYZ8mdiEEGJich/3WL9QTRUCi/yfsv6A25CFoN7gn4x
         vRGA==
Received: by 10.60.31.39 with SMTP id x7mr3442878oeh.45.1354353110620; Sat, 01
 Dec 2012 01:11:50 -0800 (PST)
Received: by 10.76.75.198 with HTTP; Sat, 1 Dec 2012 01:11:29 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210955>

Hi,

I've written a tool to stitch the first-parent histories of several
git repositories.  To illustrate, consider that we have a toplevel git
repository inside which the other repositories reside.

  /.git
  /a/.git
  /b/.git

The tool pulls in the objects from /a/.git and /b/.git into /.git by
using alternates.  Then, it gets the list of commits by rev-list'ing
and emits a fast-import stream rewriting the paths of the files in a/
from / to a/ and the paths of files in b/ form / to b/ (using M
040000), taking care to have one unified first-parent line.  It turns
out that this is quite non-trivial when the individual git
repositories contain lots of merges.  To illustrate, this is an
example of how histories from two repositories with one merge commit
each would be stitched:

  *   c1f81f1 (refs/figlets/first/origin/master)
  |\
  | * 6eaf22f (refs/figlets/first-2/origin/master)
  * 15cd841

  *   1f2f408 (refs/figlets/second/origin/master)
  |\
  | * 4bd7fe3 (refs/figlets/second-2/origin/master)
  * bfa9f3c

  *   5e1d337 (refs/replay/stitch2, fig/stitch2)
  |\
  | * 23437d5 (refs/replay/1f2f40-2)
  |/
  *   4f2d70b
  |\
  | * e017fa5 (refs/replay/c1f81f-2)
  * c0251c7
  * 4036fea

I'd like to know whether the tool would be useful to a wider audience,
before I polish it and consider submitting it for inclusion in
contrib/.  I think the tool is especially useful for running bisect
and tracking bugs that occur in large projects that consist of many
git repositories.  Will a unified log showing commits in different
submodules be useful?

Ram
