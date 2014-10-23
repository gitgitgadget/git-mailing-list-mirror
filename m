From: =?UTF-8?Q?=C3=89ric_Alber?= <eric.alber@gmail.com>
Subject: [BUG] Possible issue with word-diff option
Date: Thu, 23 Oct 2014 20:54:15 +0200
Message-ID: <CAGDZK6HVevTPXVcwhHvmwdv9LZKzcv-3j-tBNV60tvhMuMhKtQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 23 20:54:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhNWk-0005Du-MP
	for gcvg-git-2@plane.gmane.org; Thu, 23 Oct 2014 20:54:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752109AbaJWSyT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 14:54:19 -0400
Received: from mail-wi0-f178.google.com ([209.85.212.178]:53154 "EHLO
	mail-wi0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751250AbaJWSyQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2014 14:54:16 -0400
Received: by mail-wi0-f178.google.com with SMTP id q5so1620412wiv.5
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 11:54:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=xvbBgiyKqlb+kseWjSQa6xXw5g2EleUAMvL528op53A=;
        b=VvM3P2eBqm/+NTUqXh/ibWxTlvxu2iKpRZAqQvrBvVIGGLOK8KHtxOvrcgw83OQlfG
         AaoYQwFOd5cltocNUQJd/dRwFjqig7tyA9Eh20c/EdbQ+dYC1YvzI1Hcpk3Ex5TVbzlJ
         fjPNetVKlxJde1g7IJbJYu6rizf09aHqBqZB0CUo3XOFY4PKw6exAHLiklzCelt78BzV
         lPul57rdKz49rUu+cx1zUwF4+dLN6fCaNzUjBaF1J1E1E7p6WNgUbdwNugchM6K7nzBP
         +PkzR3Yiw5KDJKE+2mvN7XlallZAvb9Uusiw/4c5BTtFTuEZsWLnmeQkmcBpLgSyPR2+
         /2Pw==
X-Received: by 10.194.241.201 with SMTP id wk9mr7437688wjc.101.1414090455315;
 Thu, 23 Oct 2014 11:54:15 -0700 (PDT)
Received: by 10.217.136.7 with HTTP; Thu, 23 Oct 2014 11:54:15 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Hi,

I'm currently developing a local web based GUI for git in the same
fashion as mercurial's 'hg serve': git-webui
(https://github.com/alberthier/git-webui)
I tried to add word-diff highlighting in my diff visualization panels.
I used the '--word-diff=porcelain' option of 'git show' and 'git
diff'.

Unfortunately I ran into an issue so I want to make sure I understand
properly the format
Here is how I interpret this output:
- A line of the diff no longer corresponds to a line in the source
file. A line of the source file, is represented between two leading
'~' markers
- A line starting with a '+' or '-' is respectively an added or
removed line fragment
- A line starting with a ' ' (space) is an unchanged line fragment

The problem is visible with the git-webui repository itself:

git clone https://github.com/alberthier/git-webui
git show --word-diff=porcelain ed934a7            # This is the head
of the 'word-diff' branch
# search for the first occurrence of 'fragment'

In the source code, several lines have been replaced with the
following single line:

         var fragment = line.substr(1);

But in the diff, 'fragment' and 'line.substr(1);' don't apprear in the
same '~' block.
I get:

~
         var
-pre
+fragment
  =
-$('<pre class="diff-view-line">').appendTo(view)[0];
~
[ some removed lines....]
~
-        }
+line.substr(1);
~

By reading this output, it looks like 'var fragment = ' and
'line.substr(1);' aren't on the same line.
I would have expected:

~
         var
-pre
+fragment
  =
-$('<pre class="diff-view-line">').appendTo(view)[0];
+line.substr(1);
~
[ some removed lines....]

Is there something I miss or is this a bug of git's word-diff algorithm ?

Regards,

Eric
