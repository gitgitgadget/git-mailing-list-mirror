From: Jean LAULIAC <jean@lauliac.com>
Subject: Well-past commit dates unsupported
Date: Mon, 28 Oct 2013 11:04:22 +0100
Message-ID: <CALM1TLiVTq6kPB7Ke_VDEc+Fs8u5NknCOHH_CuOzphQY3b_HeA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Oct 28 11:04:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vajgw-00042p-3X
	for gcvg-git-2@plane.gmane.org; Mon, 28 Oct 2013 11:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755977Ab3J1KEy (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Oct 2013 06:04:54 -0400
Received: from mail-ea0-f174.google.com ([209.85.215.174]:64109 "EHLO
	mail-ea0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754680Ab3J1KEx (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Oct 2013 06:04:53 -0400
Received: by mail-ea0-f174.google.com with SMTP id z15so2061475ead.19
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 03:04:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:from:date:message-id:subject:to:content-type;
        bh=CgNWdtbjkZpTOdzlaw1xLB/6fXA32G4dH/zKFxUvJIo=;
        b=iIG9RPHtFZj6Ei7a1jVvwmbcJtwzs2Fpi4QiAuk8CW/Cdh4TfyyDE7RFs0GJWadyW5
         TPQNCg59tV3DJk5WLjGAeUcI76iugbgp9EVHxVZJzS8Rgqree/9Cdk/E0WumTJrq33vv
         QB4oHU8intJPi4Qy8Ey2GvFbbI1VUWo2Tcb4Coz3x7VXqFRGCTJBzr6D0xEzbpDQ66uz
         HWDI9sQGyLineWPWjXuZ7aNhWzqxNmrrE9rwNol8YRgHe0JDidNPRr5ouoZDKZ4UwmUM
         tTEVU5Et6abAlOcqrannwI0hYwNzuIMmegJ5PDVAq4EBtp5WRzoq4MGE50cNXttMGxHK
         +HnQ==
X-Received: by 10.14.122.8 with SMTP id s8mr937474eeh.106.1382954692194; Mon,
 28 Oct 2013 03:04:52 -0700 (PDT)
Received: by 10.223.38.144 with HTTP; Mon, 28 Oct 2013 03:04:22 -0700 (PDT)
X-Google-Sender-Auth: 1geU-VlorIVZ_SC5Sx2Te4uOE40
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236827>

Hi there,

I'm trying to use a well-past date for a git commit, before the UNIX Epoch, but
this does not work for the reasons below. I'm on Mac OS X 10.8, git version
1.8.3.4, and `sizeof(time_t) == 8`. The date I'm trying to set is October 4,
1958, that is around timestamp -354808800.

First technique, using the commit `--date` flags with ISO 8601: it says
"invalid date".

Second technique, described in the git ml archive, not using the porcelain:
http://article.gmane.org/gmane.comp.version-control.git/152497/

    git commit
    git cat-file -p HEAD > tmp.txt
    # at this point, edit the file to replace the timestamp

    git hash-object -t commit -w tmp.txt
    #=> 2ee8fcc02658e23219143f5bcfe6f9a4615745f9
    git update-ref -m 'commit: foo' refs/heads/master \
        2ee8fcc02658e23219143f5bcfe6f9a4615745f9

Commit date is effectively updated, but `git show` clamps the date to zero
(`Jan 1 1970`). `tig(1)` displays `55 years ago` so the actual commit date is
properly stored.

Last issue: when trying to push this commit to a remote repository:

    #=> remote: error: object 2ee8fcc02658e23219143f5bcfe6f9a4615745f9:invalid
    #       author/committer line - bad date
    #=> remote: fatal: Error in object
    #=> error: unpack failed: index-pack abnormal exit

Finally, when running `test-date` from git sources:

    ./test-date show -354808800
    #=> -354808800 -> in the future

Is it a deliberate git behavior? Is fully supporting past or far future dates
in the roadmap, since the referenced message above from 2010? Should I try
to make a patch?

Thanks!

PS: use case for past dates is to match the historical law changes. As others
did before, I'm trying to map the history of France Constitution to git.

-- 
Jean Lauliac <jean@lauliac.com>
