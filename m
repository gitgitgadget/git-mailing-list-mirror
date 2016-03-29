From: Elliott Cable <me@ell.io>
Subject: `git rev-parse --is-inside-work-tree` and $GIT_WORK_TREE
Date: Tue, 29 Mar 2016 06:42:44 -0500
Message-ID: <CAPZ477NxXVNNwDvzaFt7GoUGuJwnOuX3y1N+aPtVRFD3E8dQBA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 13:43:13 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aks3D-0007lM-EX
	for gcvg-git-2@plane.gmane.org; Tue, 29 Mar 2016 13:43:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756961AbcC2LnH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 29 Mar 2016 07:43:07 -0400
Received: from mail-vk0-f51.google.com ([209.85.213.51]:33002 "EHLO
	mail-vk0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756877AbcC2LnF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 29 Mar 2016 07:43:05 -0400
Received: by mail-vk0-f51.google.com with SMTP id k1so14635816vkb.0
        for <git@vger.kernel.org>; Tue, 29 Mar 2016 04:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ell.io; s=google;
        h=mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3ExRxI6VQkhL37ePxgX2apoaX4OYMfsN7rCQ7PW8Zp8=;
        b=ZJ8evJ3sv6hdqT8jwVP9qMh86lk5DZNiN/5hbCbfhjrXIo9/OL3l1Tjqris+avZ/yx
         HnDIWKfk3lng3ed9fmjoCuS91QDOrGKK7ROA5BgOqZvl9gNrjmzGb25qOBgCPW4VSuid
         GBO9sMn2K04DEWiJVWELMGCceFGr7kfaQaIqs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:from:date:message-id:subject:to
         :content-transfer-encoding;
        bh=3ExRxI6VQkhL37ePxgX2apoaX4OYMfsN7rCQ7PW8Zp8=;
        b=INdkr9XY3aFkVINTkSLGoM3zo+SM7wDNT8rj/51/HOgaqFK+LBKbul2bNKXVIbswuR
         /V/PBnUS7l6k2UOOB1CjS03byFmPPwJYYKClPJXsFqhAAVSrWTgnHzbRurcEk/6YXr1n
         cYG7qO3jVlXyIRp84eYU73Q9wgw0fBmDHB8Vm+VA//zBNlB8I94DcA3ZhKs11gtiToVB
         DiE+ujdpz8QfjJijSxzq80IVuet7IKP3RdIyYJjAjg4dRw9PwNbVeAGPCaf9TrKYxrYw
         3uhaSobn3cftc5tyOAyIUUy/nIDQX5Ddi9To/IwtNS5HfqrsVIcfbEgr7G7GxIXgQhYw
         8l3g==
X-Gm-Message-State: AD7BkJIP3QGTEC9C/f150FLE/f1EFu6g3ERcaZA1NYnZvTjqq6HmMlPKOqBKVWeMETE+t4BOsMPuJid3x+18YA==
X-Received: by 10.31.54.139 with SMTP id d133mr879758vka.132.1459251783758;
 Tue, 29 Mar 2016 04:43:03 -0700 (PDT)
Received: by 10.31.92.206 with HTTP; Tue, 29 Mar 2016 04:42:44 -0700 (PDT)
X-Originating-IP: [204.14.154.168]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290119>

So, I find this behaviour a little strange; I can't determine if it's
a subtle bug, or intentionally undefined/=E2=80=98fuzzy=E2=80=99 behavi=
our:

    $ cd a-repo/.git/
    $ pwd
    /path/to/a-repo/.git
    $ git rev-parse --is-inside-work-tree
    false
    $ export GIT_WORK_TREE=3D/path/to/a-repo
    $ git rev-parse --is-inside-work-tree
    true

i.e. when within the repository (the `.git` directory), and when that
directory is a sub-directory of the working-tree, `rev-parse
--is-inside-work-tree` reports *false* (reasonable enough, I suppose);
but then if `$GIT_WORK_TREE` is set to precisely the directory that
git was *already* assuming was the working-directory, then the same
command, in the same location, reports *true*.

This should probably be made consistent: either `rev-parse
--is-inside-work-tree` should report =E2=80=9Ctrue=E2=80=9D, even insid=
e the `.git`
dir, as long as that directory is a sub-directory of the working-tree
=E2=80=A6 or repository-directories / `$GIT_DIR` / `.git` directories s=
hould
be excluded from truthy responses to `rev-parse
--is-inside-work-tree`.


=E2=81=93=E2=80=89ELLIOTTCABLE=E2=80=84=E2=80=94=E2=80=84fly safe.
=E2=80=83=E2=80=89http://ell.io/tt
