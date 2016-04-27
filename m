From: Jacob Smith <jaroslov@gmail.com>
Subject: BUG on OSX `git p4 submit` can fail when the workspace root doesn't
 exist locally.
Date: Wed, 27 Apr 2016 11:15:26 -0500
Message-ID: <CAMsgv2UXPkxpocjKhoR7HbmubSBnhJPJ3hMq9Jsk2AD0DoCifA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Apr 27 18:15:35 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avS7j-0005Fw-G9
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 18:15:35 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753099AbcD0QP3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 12:15:29 -0400
Received: from mail-lf0-f46.google.com ([209.85.215.46]:34313 "EHLO
	mail-lf0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753057AbcD0QP2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 12:15:28 -0400
Received: by mail-lf0-f46.google.com with SMTP id j11so62742206lfb.1
        for <git@vger.kernel.org>; Wed, 27 Apr 2016 09:15:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=ybW5yed65KNauBE8aM4OHIA+J5N1XUpGOYeQXyQdUds=;
        b=NoKFxMKdgQDfdY+G0U8J8q3y4v3Fkzh6L+FU1rZ1KwvyeZmQBwhvGmsHlyOByw2vtt
         FesEPpLst8vIZLM66eNsHwhQvM4wi/oRLn7wm7LISSJy4G+RKy7X5SVjMiksnHHkdkdx
         fr6mwve1FS81PVUuJCtpCr1ufq5MdQjiTbUmS4WuBwQua82IKtnqGBPY40mp/N1ob9PY
         1/UioU5gHDLh4ht21uSuDWFHBGvhLoK7aBYPS/lyd2WLjkiWgf0paNfuU4rzk/VyCtmZ
         6YBxXZnGE7xX3Ay6E3KJBIBNj762SxWxiLTQJKa/8DDghdQVWK24278J5x64bMvwWhL3
         GZwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=ybW5yed65KNauBE8aM4OHIA+J5N1XUpGOYeQXyQdUds=;
        b=Z8UoSe/RcyL5wTkWmQpDtEJ2gRoNEcacYGsJvNS7XOUBsKI8Uyz9aNgujpnhVQ2mkV
         Gw5B7pCPLIrJgwtOcoi2ae31CbNgmZxk5MaXeAIWUz6mXe3LPXIy2qxSOcVp39My+SSK
         aAcTwZzxjr8pf8FZ/ezO9CiKuB6d6ynxSEwLrD59bhkK9Jy4zsODid92ZuIkfKWfVCdc
         0bokMh4KGgh7LmXwSf1fTJeS9I6oqIU7A70faYLmlj9QyxFSqmwzA0e61+9L/rSOE98I
         S5+AnUtM+qx4YM+YIsJXgD5gdxAgn6KxG9ZEpqCovdv2wTkaSCu+iYtTRsBQ3O7WO1uI
         feSQ==
X-Gm-Message-State: AOPr4FXH66MIquHpyDTn/q/gbHQ7szRRXXyDoX2K2J13wVLBHMRe2yh/XMJuCGcWFI5m34Lbb/1NfISvCzV5UQ==
X-Received: by 10.25.196.20 with SMTP id u20mr4005003lff.164.1461773726388;
 Wed, 27 Apr 2016 09:15:26 -0700 (PDT)
Received: by 10.25.21.37 with HTTP; Wed, 27 Apr 2016 09:15:26 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292739>

On OS X, if the local p4 workspace root doesn't exist, then git-p4 can
fail on submit. The error message looks like this:

    Synchronizing p4 checkout...

    Git submit failed!
    shell-init: error retrieving current directory: getcwd: cannot
access parent directories: No such file or directory
    fatal: Unable to read current working directory: No such file or directory
    Command failed: ['git', 'rev-list', '--no-merges',
'remotes/p4/master..master']

The problem is in the function 'run()' around line 1957. The logic in
the code is:

    1. Detect if the clientPath exists;
    2. If the clientPath doesn't exist, set the 'new_client_dir'
variable to 'True';
    3. chdir() to the clientPath; then,
    4. If 'new_client_dir' is 'True', then p4_sync("...", True).

On my system, the call to `p4 sync -f` leaves the clientPath directory
that git-p4 had chdir()'d into an orphan, so the call to 'git rev-list
...' a few lines fails because the call to getcwd() fails (the
directory has no parents).

I can make the problem "go away" by moving the location of the call to
'chdir(self.clientPath, is_client_path=True)' after the call to
`p4_sync()`, but I'm not sure if that's really fixing the issue, or
not.

Thanks!
-j.
