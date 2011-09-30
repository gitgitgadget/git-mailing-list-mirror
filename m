From: Christian Halstrick <christian.halstrick@gmail.com>
Subject: how to produce an index with smudged entries
Date: Fri, 30 Sep 2011 17:33:54 +0200
Message-ID: <CAENte7h-sbv7VTBdV7A+=TtONTpgOBBfVWz2Nejm1DqJJ9tFiQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git <git@vger.kernel.org>,
	Robin Rosenberg <robin.rosenberg@dewire.com>
X-From: git-owner@vger.kernel.org Fri Sep 30 17:34:22 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R9f6T-0004yK-45
	for gcvg-git-2@lo.gmane.org; Fri, 30 Sep 2011 17:34:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755319Ab1I3PeQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Sep 2011 11:34:16 -0400
Received: from mail-vw0-f46.google.com ([209.85.212.46]:47532 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754733Ab1I3PeQ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Sep 2011 11:34:16 -0400
Received: by vws1 with SMTP id 1so1391183vws.19
        for <git@vger.kernel.org>; Fri, 30 Sep 2011 08:34:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:from:date:message-id:subject:to:content-type;
        bh=JiOYqvbb7lo/xDr0ISamN4sTa8NU/KVhPUY+AeUsPvs=;
        b=wCSVsRCrSbk00kaUiEdi1MSCT73sc6jZxc5GeMS+ot/ZO4ywh9Pm6+Ru7hPLRMkeyb
         EGCp/V45NCbnn78hHrj/5hOB/FWl6i9SraioUFoxvx56zpHhyYcgKHiNUZKwBkI2UJjt
         AnHHyz90sKOlLPnKvulQVxkx2XEQzzN9373Dc=
Received: by 10.52.174.113 with SMTP id br17mr852662vdc.508.1317396855069;
 Fri, 30 Sep 2011 08:34:15 -0700 (PDT)
Received: by 10.52.113.73 with HTTP; Fri, 30 Sep 2011 08:33:54 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/182488>

I am trying to find out how native git handles the racy git problem. I
read https://raw.github.com/git/git/master/Documentation/technical/racy-git.txt.
But I cannot reproduce the behaviour described in this text.

I want to create an index which contains entries where the length of
the file was set to 0 to mark the entry as "racily clean". As I
understood the text you have to modify a file and execute 'git
update-index <file>' so fast that in the end the files modification
time is the same as the modification time of the file .git/index. That
should be sufficient that when persisting the index during the 'git
update-index' call git should detect that the files mod-time is
younger than the index mod time  and should mark this entry "racily
clean" with a length of 0.

Here is the script with which I try to produce it but it always fails
to create an index with a smudged entry. Any ideas? (Btw: I would
assume that the first entry in the index is smduged when I find 4
zeros beginning at position 48. That's what I deduced from
https://github.com/gitster/git/blob/master/Documentation/technical/index-format.txt)

#!/bin/bash

git init
echo "initial" > foo

# wait for the next tick on the filesystem clock
touch foo
lastTouch=$(stat -c %Y foo)
while [ $lastTouch = $(stat -c %Y foo) ] ;do
  touch foo
done

git add foo

# modify 'foo' and update the index
# (hopefully before the filesystem clock has increased)
# repeat this step until the filesystem timer increased and
# print the index everytime
lastTouch=$(stat -c %Y foo)
while [ $lastTouch = $(stat -c %Y foo) ] ;do
  echo "modification #$n" > foo
  git update-index foo
  let "n += 1"
  echo "after attempt $n:"
  # dump 4 bytes of index beginning from pos 48.
  # That should be the length of the first entry
  od -j 48 -N 4 -x -A d .git/index
done
