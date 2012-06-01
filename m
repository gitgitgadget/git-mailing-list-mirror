From: Adam Spiers <git@adamspiers.org>
Subject: Bug in git citool when staging symlink as replacement for submodule
Date: Fri, 1 Jun 2012 11:31:26 +0100
Message-ID: <CAOkDyE9q1n=oLoEXXxurDjNM0B2+cZ9eoeGE57F9hEQUjK0hZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Jun 01 12:31:43 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SaP8w-0001Z9-CZ
	for gcvg-git-2@plane.gmane.org; Fri, 01 Jun 2012 12:31:42 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758980Ab2FAKb2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Jun 2012 06:31:28 -0400
Received: from mail-yx0-f174.google.com ([209.85.213.174]:60540 "EHLO
	mail-yx0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758864Ab2FAKb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Jun 2012 06:31:27 -0400
Received: by yenm10 with SMTP id m10so1592371yen.19
        for <git@vger.kernel.org>; Fri, 01 Jun 2012 03:31:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:sender:date:x-google-sender-auth:message-id:subject
         :from:to:content-type;
        bh=fS7iznaAcztCQRvZRPrMWWoPu89Wy39hPGilfNy+pDE=;
        b=O8WwoOqFmu3w0J2rhrMjR2sON60lXmxz8EKkm57Z3Gi6JBE5kOjtn50SgAedQL/fwq
         u6i0eCPCmqiYtrNOrG1ASWJYp4KRnlOrKXdH3udY0qTArMutT8d0priNkHIEiFLqs4Z7
         S0/prObojbO9KaigvTkZi7BrtnGMGTLgvOTKUlpvkKQQDSRLx9fcabWoDG+LibAl+eEZ
         XESSiZkL9BWxRLjkjeE0vBvZMFJXMO8exRI2gA6849wCITing9exNnLGme5EzMtSqB1K
         YNhrabRkF05FKM/D0Y5kBeSwNY2jXkNEy21xdJZ5PY2L0j/AeRWuLQjURG4UPqNEa6oC
         OK/g==
Received: by 10.50.42.196 with SMTP id q4mr725298igl.28.1338546686547; Fri, 01
 Jun 2012 03:31:26 -0700 (PDT)
Received: by 10.42.25.142 with HTTP; Fri, 1 Jun 2012 03:31:26 -0700 (PDT)
X-Google-Sender-Auth: d9DDVkrbZdt3xLpIuzUWAg8yaCo
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198974>

I found some strange behaviour in git citool when trying to stage a
symlink into the index as a replacement for a (non-registered) submodule.
I just reproduced with latest master (1.7.11.rc0.55.gb2478aa):

    mkdir repo
    cd repo
    git init
    echo foo > one
    git add one
    git commit -m'first commit'

    mkdir two
    cd two
    git init
    echo foo > submodule-file
    git add submodule-file
    git commit -m'first submodule commit'

    cd ..

    git add two
    git commit -m'second commit'

    rm -rf two
    ln -s one two

    git citool

At this point, git citool outputs:

    error: Unhandled submodule diff marker: {@@ }
    error: Unhandled submodule diff marker: {+on}

Now if I press Control-T to try to stage 'two' into the index, I get a new
dialog which says:

    Updating the Git index failed. A rescan will be automatically
    started to resynchronize git-gui.

    error: two is already a gitlink, not replacing
    fatal: Unable to process path two


                              [Unlock Index] [Continue]

I can work around via 'git add two', but it would be nice if citool
handled this correctly.

Thanks!
Adam
