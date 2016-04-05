From: Erik Bray <erik.m.bray@gmail.com>
Subject: Timestamp of zero in reflog considered invalid
Date: Tue, 5 Apr 2016 13:28:31 +0200
Message-ID: <CAOTD34YpTXperaC0=Sy=21Q9_+0eGO1y-bP-WzrkxFvrDykRXg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Apr 05 13:28:39 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1anP9y-0003sG-RM
	for gcvg-git-2@plane.gmane.org; Tue, 05 Apr 2016 13:28:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932490AbcDEL2e (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 5 Apr 2016 07:28:34 -0400
Received: from mail-lf0-f51.google.com ([209.85.215.51]:36729 "EHLO
	mail-lf0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757961AbcDEL2c (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 5 Apr 2016 07:28:32 -0400
Received: by mail-lf0-f51.google.com with SMTP id g184so8142654lfb.3
        for <git@vger.kernel.org>; Tue, 05 Apr 2016 04:28:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to;
        bh=JKdW+vFZsHF8v3ux4iWYvbB9jAp5fYRflGfc0oH13Ms=;
        b=Jv0BvbQhfSyRxr1+lQMSgrV5IMtBzWhZjSUhc0vJO4Vfhaht3zUf6UK/lo1qNeb97q
         nI7eucAnVtk7LxnyeKfQDn6XPyhSXdOcE6UeymsQN22Ug4geKGjrCT2GUyTmfUp4HDyX
         xXRfJegLL1WsQLHIwUjyg5bFWTbarctOdb6Qix/1R8sB+8AZJBR6MKNZcQTUggOs4/1w
         GbZ4dAwUFiS/abw/axBfrhbY1N23LBngb8Vg1iSpAZitfgtUGH1zWWdaBwO0Qh7+Auki
         NkT1Lwj03nVwQD8Fqt07f4yFV5S2HG+0r4yf9eAZF8MJskwUtW4W0U6urD8648s8P4Vh
         YpUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to;
        bh=JKdW+vFZsHF8v3ux4iWYvbB9jAp5fYRflGfc0oH13Ms=;
        b=QrNWEXVBb2vFYThQhKaMnDZXV/TLPc2b0lgZ7BzZb/WL9Em1m8BlmTM2zMj6XHdfvU
         3fHmW6dSgkgtEbrG3Yz0UO5lqofAp+K/HenOOhe68iA5AyW8tlP3GQ0eBZuyCYNSnsZR
         qm0X1hmZ9v4QzQSZFX/RGPiYxUoLQnCqlimGujLw5OZfIAYFVH6b0Ji/K8HXe+Qz8Ynv
         +ASKeP516jE7O2n28I4JR6KgDHe5hVMlA7MrP/Gi4HY6Dk/fzkfmVHZyi7c6oTQCxgSI
         CC0wylKtW2cC9PzWEv2ubhe9p4nw0Y7SP2KKaQN08KlAq0098PELGAGG/U4q+OXlikPE
         wcVw==
X-Gm-Message-State: AD7BkJKkJBqtHXmfmaLwrmt4GBjeDfObvNw5VgY5D8xHl2bvH3F6stIe6DDvgrd06wMWjAgkxL6fe6lpg00LgA==
X-Received: by 10.25.135.8 with SMTP id j8mr2513210lfd.64.1459855711283; Tue,
 05 Apr 2016 04:28:31 -0700 (PDT)
Received: by 10.25.148.148 with HTTP; Tue, 5 Apr 2016 04:28:31 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/290775>

Hi all,

I found this issue through a test suite for a Python git interface,
which during the tests at some point sets

GIT_COMMITTER_DATE=1970-01-01T00:00:00

To reproduce the issue:

$ git init
$ echo foo > testfile
$ git add testfile
$ git commit -m "test"
$ echo bar >> testfile
$ export GIT_COMMITTER_DATE=1970-01-01T00:00:00
$ git stash save
$ git stash apply
refs/stash@{0} is not a valid reference

At this point one can see:

$ git rev-parse --symbolic --verify 'refs/stash@{0}'
fatal: Log for refs/stash is empty.

Expected:

$ git rev-parse --symbolic --verify 'refs/stash@{0}'
refs/stash@{0}

I tracked the issue to refs/files-backend.c in show_one_reflog_ent :

https://github.com/git/git/blob/11529ecec914d2f0d7575e6d443c2d5a6ff75424/refs/files-backend.c#L2923

in which

!(timestamp = strtoul(email_end + 2, &message, 10)) ||

implies an invalid reflog entry.  Why should 0 be treated as an
invalid timestamp (even if it's unlikely outside of corner cases)?

Thanks,
Erik
