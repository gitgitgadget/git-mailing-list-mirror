From: Dennis Kaarsemaker <dennis@kaarsemaker.net>
Subject: Re: Bug report about symlinks
Date: Fri, 01 Aug 2014 21:10:59 +0200
Message-ID: <1406920259.3253.7.camel@spirit>
References: <1406719800.686251712@f362.i.mail.ru>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: NickKolok <nickkolok@mail.ru>
X-From: git-owner@vger.kernel.org Fri Aug 01 21:11:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XDIEf-0008D4-De
	for gcvg-git-2@plane.gmane.org; Fri, 01 Aug 2014 21:11:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754684AbaHATLI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Aug 2014 15:11:08 -0400
Received: from mail-wi0-f179.google.com ([209.85.212.179]:38936 "EHLO
	mail-wi0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751460AbaHATLH (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Aug 2014 15:11:07 -0400
Received: by mail-wi0-f179.google.com with SMTP id f8so1866235wiw.0
        for <git@vger.kernel.org>; Fri, 01 Aug 2014 12:11:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:content-type:mime-version:content-transfer-encoding;
        bh=QuEB7XakfVIKkjBSTgU5Z+13E1dHcviVlrDohEq4nMQ=;
        b=dEHjDnOSlGW38yUZxKCDs1XxTnVpx6zBr0dgzm1lXZBtCoYUvqe8vp1dijRDq5yA+j
         6DkUriunOYYuUJDK4tN1yg5ttAAxPl7TbdGgUMh/qhSmpEFf8bvrq/dUEXdBZ1iZkYGL
         WZzxOozL7aEyC6cKI8NOn9bQ4zEj/k45UQFTBvUZwIq5WgJYThUnUidHTfCeyZOA2lQO
         vSojt9BjS3rpJiWzEWd2qJ/8NtZinVrURNCgMKyB0m0Vgdh7WIDCunCnhv9ERCsfyaiz
         6ASbKz20Kclyfpil3mKheS7HwDqTSmqU/HK0z7OKt9Q8QLU0Fnm8TcHbWEkg6DB6MbaV
         1HDA==
X-Gm-Message-State: ALoCoQl2Brrmns1dgfoD93j1QW3YlmSNjNYtoKKrouAb1JZBzuV+bvnNllousEVfg3yvztCfLpPt
X-Received: by 10.180.94.34 with SMTP id cz2mr9665213wib.74.1406920263455;
        Fri, 01 Aug 2014 12:11:03 -0700 (PDT)
Received: from [10.0.0.24] (80-121-71-233.adsl.highway.telekom.at. [80.121.71.233])
        by mx.google.com with ESMTPSA id w7sm11374598wiy.6.2014.08.01.12.11.02
        for <multiple recipients>
        (version=TLSv1 cipher=RC4-SHA bits=128/128);
        Fri, 01 Aug 2014 12:11:02 -0700 (PDT)
In-Reply-To: <1406719800.686251712@f362.i.mail.ru>
X-Mailer: Evolution 3.10.4-0ubuntu1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254650>

On wo, 2014-07-30 at 15:30 +0400, NickKolok wrote:
> Greetings from Russia, comrads!
> 
> I've noticed something strange with git status when replacing a folder with symlink to another folder.
> There is a git repo with script with demo in the attachment.

I think there is a bug here:

+ mkdir bug
+ cd bug
+ git init
Initialized empty Git repository in /tmp/bug/.git/
+ mkdir dir1 dir2
+ echo 1
+ echo 1
+ echo 2a
+ echo 2b
+ git add dir1/1.txt dir1/2.txt dir2/1.txt dir2/2.txt
+ git commit -m first
[master (root-commit) b60ecc8] first
 4 files changed, 4 insertions(+)
 create mode 100644 dir1/1.txt
 create mode 100644 dir1/2.txt
 create mode 100644 dir2/1.txt
 create mode 100644 dir2/2.txt
+ rm -r dir2
+ ln -s dir1 dir2
+ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working
directory)

	deleted:    dir2/2.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	dir2

no changes added to commit (use "git add" and/or "git commit -a")

It looks like git status is thinking dir2/1.txt still exists with the
same content, even though dir2 is gone, and now an untracked symlink. 

Moreover, git diff and git status disagree with each other:

dennis@spirit:/tmp/bug$ git status
On branch master
Changes not staged for commit:
  (use "git add/rm <file>..." to update what will be committed)
  (use "git checkout -- <file>..." to discard changes in working
directory)

	deleted:    dir2/2.txt

Untracked files:
  (use "git add <file>..." to include in what will be committed)

	dir2

no changes added to commit (use "git add" and/or "git commit -a")
dennis@spirit:/tmp/bug$ git --no-pager diff
diff --git a/dir2/1.txt b/dir2/1.txt
deleted file mode 100644
index d00491f..0000000
--- a/dir2/1.txt
+++ /dev/null
@@ -1 +0,0 @@
-1
diff --git a/dir2/2.txt b/dir2/2.txt
deleted file mode 100644
index b8a4cf4..0000000
--- a/dir2/2.txt
+++ /dev/null
@@ -1 +0,0 @@
-2b

-- 
Dennis Kaarsemaker
www.kaarsemaker.net
