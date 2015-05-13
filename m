From: Russ Cox <rsc@golang.org>
Subject: 'EDITOR=false git add -e' adds to index
Date: Tue, 12 May 2015 20:31:26 -0400
Message-ID: <CAA8EjDS9HePk6ZFa0kOy7GDa9_c_TsJ7uv7t+N9RL-3z=ZrQFQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed May 13 02:31:35 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YsKaE-0002sV-0c
	for gcvg-git-2@plane.gmane.org; Wed, 13 May 2015 02:31:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964816AbbEMAb1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 May 2015 20:31:27 -0400
Received: from mail-ob0-f172.google.com ([209.85.214.172]:35074 "EHLO
	mail-ob0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964807AbbEMAb1 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 May 2015 20:31:27 -0400
Received: by obcus9 with SMTP id us9so18243223obc.2
        for <git@vger.kernel.org>; Tue, 12 May 2015 17:31:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=8q+2f1XRN55IyLjpEhkdavyVEm3o9tF2Z0scYwv9qvg=;
        b=JcOHRTrK5y64yVzZtjYg4+sxx97iMo4ahEoA3yWbB9iRe/cL2vU1eb/jVuLssN5nc1
         PG6KgSFb5tx6o/oJ87dWhNDvSCf0H/zqWX6oS4qidCTfOx0uK0fnI2ovMzeVFE6V9PD1
         ech+Ij7wTlWMypCTTiWGLAcXd0VUi0iBke0skebhUXb7PiI35ot5+TvRxiDHHkjrTe9A
         9jPyWkJEeYDEmOARm6VswsCz7hM0d7u8wVw+H8JZXjB2g5YLtgz2WfrZITZUAiad41t8
         rB+oXLPzYnWszPqG3KSDbgmv4vVGAXcFq3eV/CDhzUE0h1BfwOQr4JKCkkLYdxEfdMv+
         889g==
X-Gm-Message-State: ALoCoQld+d2VaHCFUAwpN9ZTcuI/HwctpPGtmK9KZLCexhSeUTcyOG8tZZ615qoWzp7XLDutcwn9
X-Received: by 10.202.232.14 with SMTP id f14mr13324941oih.66.1431477086224;
 Tue, 12 May 2015 17:31:26 -0700 (PDT)
Received: by 10.76.116.202 with HTTP; Tue, 12 May 2015 17:31:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268908>

In contrast to most other git commands, git add -e does not check
whether the editor it invokes exits successfully. This means that if
you cause your editor to exit unsuccessfully, hoping to abort the add
-e, the add -e continues anyway.

The specific instance I've observed is that you set EDITOR to a
program that starts the editor outside the current terminal and waits
for it to exit. Then you realize you didn't want to add anything and
type ^C in the terminal where git is waiting for $EDITOR to finish.
That makes $EDITOR exit unsuccessfully, and git prints an error about
not being able to invoke the editor, but it continues on with the add
-e, adding everything from the patch to the index.

I am using the acme editor, but I believe that EDITOR='emacs -nw' or
EDITOR='subl -w' for Sublime Text are more common settings that would
have the same problem. In a test, EDITOR=false suffices.

The root cause seems to be that builtin/add.c's edit_patch does not
check the result of  the launch_editor call. It probably should.

The call to launch_editor in builtin/config.c should probably also be
checked, although there it's not as big a deal, provided the editor
did not modify the file; reapplying the same file should be a no-op.
This is different from git add -e.

I am seeing this behavior with git 2.2.1, but I checked the main repo
and commit c518059 from yesterday still has the unchecked
launch_editor call.

Thanks.
Russ
