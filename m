From: =?UTF-8?B?w4Z2YXIgQXJuZmrDtnLDsCBCamFybWFzb24=?= <avarab@gmail.com>
Subject: Should GIT_AUTHOR_{NAME,EMAIL} set the tagger name/email?
Date: Sat, 1 Sep 2012 17:34:12 +0200
Message-ID: <CACBZZX7Ud8Xx225ss6SYqZFXyW0FG2XJimBWdvW_NuMqn8yOnA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat Sep 01 17:35:29 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1T7pjJ-0004jH-Jc
	for gcvg-git-2@plane.gmane.org; Sat, 01 Sep 2012 17:35:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752621Ab2IAPee convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 1 Sep 2012 11:34:34 -0400
Received: from mail-ob0-f174.google.com ([209.85.214.174]:53837 "EHLO
	mail-ob0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751854Ab2IAPed convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sat, 1 Sep 2012 11:34:33 -0400
Received: by obbuo13 with SMTP id uo13so7198872obb.19
        for <git@vger.kernel.org>; Sat, 01 Sep 2012 08:34:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:from:date:message-id:subject:to:content-type
         :content-transfer-encoding;
        bh=StyoGrHUlNLpfOPUZRAa1b99cQnoxNm5jkVi1GYheFQ=;
        b=olhN/lf5rcoPJatqMSLb7Bgi1moLsDnyF9Gj0Rhxt53xOB3mrTDBsGbbpII+HnN7Oq
         pGWvNb81wxdloA5r3YcGgUlmLAZYarmm4jsq1BjktyLJjuWb6Wq0WoZMkMQxtCrKoPRI
         izckggT9d5NVl9vn8n08c+PfwGoAXXp1fAuPtwZD2yZ2gryLmJa+VJ9WJkoXnYDEMEdL
         Fl+xsnkKNDS3pRmMGreDuoBwytksN/7oJE3cBm01benAVQugC/0CJAHcdk8YOU4SL+BQ
         ORfI0yYPJpXD+WVO/0HiAT6n9FyAZSJNKDfQvKISxomsRrSa9OvksZRlINSyW2U7cjaK
         piow==
Received: by 10.60.27.41 with SMTP id q9mr10307339oeg.80.1346513672675; Sat,
 01 Sep 2012 08:34:32 -0700 (PDT)
Received: by 10.182.48.34 with HTTP; Sat, 1 Sep 2012 08:34:12 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/204635>

Maybe this is documented in some place I didn't spot, but I expected
that when I set GIT_AUTHOR_{NAME,EMAIL} it would affect the operation
of git-tag, but it doesn't seem to. When I create tags it seems to
completely ignore those variables.

Should it be doing that? Here's a test script demonstrating the issue:

    #!/bin/sh -e
    # Set defaults
    git config --global user.name "=C3=86var Arnfj=C3=B6r=C3=B0 Bjarmas=
on"
    git config --global user.email "avarab@gmail.com"

    rm -rf /tmp/test-git
    git init /tmp/test-git
    cd /tmp/test-git

    make_commit() {
        file=3D$1
        content=3D$2
        echo $content >$file
        git add $file
        git commit -m"$file: $content" $file
        git --no-pager log -1 HEAD | grep ^Author
    }

    make_commit README "testing content"
    git config user.name "Test User"
    git config user.email "test@example.com"
    make_commit README "testing content again"
    git tag -a -m"annotated tag" tag-name-1
    git --no-pager show tag-name-1 | grep ^Author

    GIT_AUTHOR_NAME=3D"Tag Test User"
GIT_AUTHOR_EMAIL=3D"tagtest@example.com" git tag -a -m"another annotate=
d
tag" tag-name-2
    git --no-pager show tag-name-2 | grep ^Author

Which outputs:

    $ sh /tmp/test-tag.sh
    Initialized empty Git repository in /tmp/test-git/.git/
    [master (root-commit) 9816756] README: testing content
     1 file changed, 1 insertion(+)
     create mode 100644 README
    Author: =C3=86var Arnfj=C3=B6r=C3=B0 Bjarmason <avarab@gmail.com>
    [master 304b71e] README: testing content again
     1 file changed, 1 insertion(+), 1 deletion(-)
    Author: Test User <test@example.com>
    Author: Test User <test@example.com>
    Author: Test User <test@example.com>

I'd expect references to "Tag Test User <tagtest@example.com>" for the
second tag I created.
