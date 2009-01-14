From: "=?ISO-8859-1?Q?Santi_B=E9jar?=" <santi@agolina.net>
Subject: Re: [PATCH 0/4] refactor the --color-words to make it more hackable
Date: Wed, 14 Jan 2009 14:00:57 +0100
Message-ID: <adf1fd3d0901140500j10556a1as6370d40d766f1899@mail.gmail.com>
References: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Thomas Rast" <trast@student.ethz.ch>
To: "Johannes Schindelin" <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:02:40 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN5OG-0001Js-Nw
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:02:37 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755045AbZANNBA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:01:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754766AbZANNBA
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:01:00 -0500
Received: from mail-bw0-f21.google.com ([209.85.218.21]:59565 "EHLO
	mail-bw0-f21.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754588AbZANNA7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:00:59 -0500
Received: by bwz14 with SMTP id 14so1695990bwz.13
        for <git@vger.kernel.org>; Wed, 14 Jan 2009 05:00:57 -0800 (PST)
Received: by 10.103.117.8 with SMTP id u8mr34822mum.123.1231938057069;
        Wed, 14 Jan 2009 05:00:57 -0800 (PST)
Received: by 10.103.189.7 with HTTP; Wed, 14 Jan 2009 05:00:57 -0800 (PST)
In-Reply-To: <alpine.DEB.1.00.0901112057300.3586@pacific.mpi-cbg.de>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105623>

2009/1/11 Johannes Schindelin <Johannes.Schindelin@gmx.de>:
>

[...]

> The basic idea is to decouple the original text from the text that is
> passed to libxdiff to find the word differences.
>
> To that end, the words of the pre and post texts are put into two lists that
> are fed to libxdiff.  While the words are extracted, an array is created which
> contains pointers back to the word boundaries in the original text.
>

Thanks. With this I will no longer need to add some spurious spaces in
my latex files :-)

I've tested and it seems to work, but there are some corner cases that
it does not handle well. If you have this two files:

---8<--- pre
h(4)

a = b + c
---8<--- post
h(4),hh[44]

a = b + c

aa = a

aeff = aeff * ( aaa )
---8<---

The "git diff" is okay, but not the "git diff --color-words", the
addition of "aeff = ..." is not shown.

Additionally with "git diff --no-index --color-words='^[A-Za-z0-9]*'
the ']' character is not shown as an addition, and instead of the
"aeff" line you get a ")" in green, as:

h(4),{GREEN}hh[44{ENDGREEN}]

a = b + c

{GREEN}aa = a
 ){ENDGREEN}

Also if the lost text is at the end the next "diff --git" line is
printed in read:

--8<---
#!/bin/bash
git init
cat > file <<EOF
a

aa
EOF
cat > gfile <<EOF
a
EOF
git add .
git commit -m "Initial import"
git rm file
cat > gfile <<EOF
b
EOF
git add gfile
git commit -m "changes"
git show --color-words
---8<---

Thanks,
Santi

P.D.: I've test the version that is in 'pu', it does not have the
patch to fix the segfault but I've also tested with it.
