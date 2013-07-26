From: Bryan Head <bryan.head@gmail.com>
Subject: subtree split prepends "-n<newline>" to commit messages on OS X
Date: Fri, 26 Jul 2013 17:47:29 -0500
Message-ID: <CAFM=nTeRpZ=Y-+4KMCZd8Qj-9K105uSquh8Y=7mC3aqJiE0gbQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Jul 27 00:47:36 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V2qnO-0001kL-EP
	for gcvg-git-2@plane.gmane.org; Sat, 27 Jul 2013 00:47:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932324Ab3GZWra (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 26 Jul 2013 18:47:30 -0400
Received: from mail-oa0-f54.google.com ([209.85.219.54]:39608 "EHLO
	mail-oa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756749Ab3GZWr3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 26 Jul 2013 18:47:29 -0400
Received: by mail-oa0-f54.google.com with SMTP id o6so8929016oag.27
        for <git@vger.kernel.org>; Fri, 26 Jul 2013 15:47:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=ZLjiECAgEy3WH77uYAhCCRQcWhJANWfXFAoAyzklcTc=;
        b=fNJ1B5hQbaTp5PpYvs9b1bzWGLvo3FNNAjO+wlZXU8XYjVMGNitTNV7GkMQCNGP8lx
         V1xXdLNEv1x/b8VkhMo+XEbiM25PTFsXkEctjEyEyWQ+XdSPhrUrS9oTq8sw0mACjpCf
         GqWrGh8qj3FH0IPFNSixDqxCIsS3BXA9KGX9YFQOSiG+rtpG+Tgp/p/Tav+Xy0Oq0wii
         fJple5Dt2rL1lriHxidwag4By1qAZbQmqLpv9qm4WvRS7ujNytv3gmrkTuF4UqDl9qbn
         i4NqfBIZRc0FGmUImJYuHma55yg6Q85fiMJInC/BOvs9VSmVuFYsRHtZregfvk/EfcN2
         YyzA==
X-Received: by 10.182.87.170 with SMTP id az10mr44458682obb.10.1374878849296;
 Fri, 26 Jul 2013 15:47:29 -0700 (PDT)
Received: by 10.182.70.103 with HTTP; Fri, 26 Jul 2013 15:47:29 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231213>

Looks like this was introduced in 1.8.3.3.

To reproduce, run

git init repo
cd repo
mkdir splitme
touch splitme/foo
git add splitme/
git commit -m 'Add foo'
git subtree split -P splitme -b splitme-only


After that, I get:

$ git log splitme-only
commit 6ce8124a0b5e52d4bba198144d2f3f664d7b19e7
Author: me
Date:   Fri Jul 26 12:22:27 2013 -0500
    -n
    Add foo


Compared with the original:

$ git log master
commit 6d5164076bd88d1dab8963d91ec013372e58a444
Author: me
Date:   Fri Jul 26 12:22:27 2013 -0500
    Add foo


Notice how `-n<newline>` has been prepended to the commit message.

This was introduced when subtree was changed to use `sh` instead of
`bash`, in this
commit:https://github.com/git/git/commit/6912ea952bf5d1b2d21d5935d6b726bab02d8bf6#contrib/subtree/git-subtree.sh
This was merged in here:
https://github.com/git/git/commit/779fd737d79a3e19a1aa420c33cf1195c7e20dd7#contrib/subtree/git-subtree.sh

I verified that changing the line in question back to `#!/bin/bash`
eliminates the problem.

I believe that it was caused by the fact that sh echos the "-n" in
this line: https://github.com/git/git/blob/master/contrib/subtree/git-subtree.sh#L314

Note that this consequently happens when, for instance, using `git
subtree push` to push the subtree to an upstream repository.

I'm using OS X 10.8.4. The problem does not occur on Ubuntu at least
since Ubuntu's sh is actually dash.
