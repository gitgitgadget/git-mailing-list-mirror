From: Jeremy Nickurak <jeremy@nickurak.ca>
Subject: Bad git log behavior with multiple glob path arguments
Date: Tue, 4 Mar 2014 22:56:20 -0700
Message-ID: <CA+eQo_21j=GzsvWAjxzr+aFYcPcnnyozySOo0m9bO-xJq_6a9A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 05 06:56:29 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WL4oc-0006bS-Bg
	for gcvg-git-2@plane.gmane.org; Wed, 05 Mar 2014 06:56:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753484AbaCEF4W (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 5 Mar 2014 00:56:22 -0500
Received: from mail-we0-f181.google.com ([74.125.82.181]:33584 "EHLO
	mail-we0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752568AbaCEF4V (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Mar 2014 00:56:21 -0500
Received: by mail-we0-f181.google.com with SMTP id q58so608806wes.12
        for <git@vger.kernel.org>; Tue, 04 Mar 2014 21:56:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nickurak.ca; s=google-dkim;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=brGG4HRoOMGv06K53BVLLNVQgIG5pPgY1Sb5m0mZsx0=;
        b=VXmZMc3xwAN9kcUBa8VFNYMmjBRrTKbgAKSiMNR+hScjELWZp3h5yuitelyvX4UEwx
         g4M0EG+2MbSWXMqMFKpZ3mfz63QbKmkgwL2nlQE4P2IBIWyO3ZBFYnQLKQwslz2emBnD
         fuXtcxtNZu0y4/25vxJugleeMWvp9No734JM8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=brGG4HRoOMGv06K53BVLLNVQgIG5pPgY1Sb5m0mZsx0=;
        b=g1CX0oChSOlqJHp/hQwM8Xhyzin4f2jdlj7M34Ekyqo7K8M97+Qkj4C/A/5J35+riY
         dI/Xr3bbJW0d2oLNFQ+HvCfpJwVhz2P8ZEnUQBKUUNCdpgU2UkbeOB4kcfUqBMssN5j8
         CnJnjvXm+humpf+k8FaR+/mrMjEGToUBpY40dHEU4nJHcNqn3/X0BCimGx5NTVG2Y0PJ
         Lj1JXpJGwnnxrlyd6leQNsikQiBl6eTuDleERdX/JxQDLmB++J09hOMFLVCc1rARRTCt
         kiRVK6/Ulry7SWX9fq0pObhgXWn/ZCja3UseoDh8VigxLwgSW67nmF+0rrdmW61GZH2I
         SEcA==
X-Gm-Message-State: ALoCoQnKecYptEh7j/s1qfwvkwW9iO+bdLy/6CB41stnFizBzjljYfz6xhT9OlYXhYso3vbKVj8E
X-Received: by 10.194.185.148 with SMTP id fc20mr5260415wjc.27.1393998980370;
 Tue, 04 Mar 2014 21:56:20 -0800 (PST)
Received: by 10.216.122.200 with HTTP; Tue, 4 Mar 2014 21:56:20 -0800 (PST)
X-Originating-IP: [96.52.225.98]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243419>

git log seems to understand globs in the last path argument, and the
last path argument only. I didn't see anything in the git log man page
expressly saying this was to be expected, but it does seem like it
ought to work for all the arguments or none of them.

Here's a little shell script I ended up using to convince myself I
wasn't going crazy. I'd expect the same output for all of the git log
test, since they all specify (either with globs or not) all the files
added to the repository. Alternatively, if globs aren't expected to
work, I'd at least expect all the glob tests to return nothing.

Note that glob matching doesn't seem to occur unless '--' is included.
I'm not exactly clear on why that is.

#!/bin/sh

TESTREPO="$(pwd)/bad-glob-test-repo"

rm  -rf "$TESTREPO"

echo "Running tests in $TESTREPO"
mkdir "$TESTREPO"
cd "$TESTREPO"
mkdir subdira
mkdir subdirb
mkdir subdirc

git init
echo a > subdira/file.txt
echo b > subdirb/file.txt
echo c > subdirc/file.txt

git add subdira/file.txt
git commit -m 'a'

git add subdirb/file.txt
git commit -m 'b'

git add subdirc/file.txt
git commit -m 'c'

echo Glob Test 1: git log --oneline -- 'subdira/*.txt' 'subdirb/*.txt'
'subdirc/*.txt'
git log --oneline -- 'subdira/*.txt' 'subdirb/*.txt' 'subdirc/*.txt'

echo Glob Test 2: git log --oneline -- 'subdira/*.txt' 'subdirc/*.txt'
'subdirb/*.txt'
git log --oneline -- 'subdira/*.txt' 'subdirc/*.txt' 'subdirb/*.txt'

echo Glob Test 3: git log --oneline -- 'subdirb/*.txt' 'subdira/*.txt'
'subdirc/*.txt'
git log --oneline -- 'subdirb/*.txt' 'subdira/*.txt' 'subdirc/*.txt'

echo Glob Test 4: git log --oneline -- 'subdirb/*.txt' 'subdirc/*.txt'
'subdira/*.txt'
git log --oneline -- 'subdirb/*.txt' 'subdirc/*.txt' 'subdira/*.txt'

echo Glob Test 5: git log --oneline -- 'subdirc/*.txt' 'subdira/*.txt'
'subdirb/*.txt'
git log --oneline -- 'subdirc/*.txt' 'subdira/*.txt' 'subdirb/*.txt'

echo Glob Test 6: git log --oneline -- 'subdirc/*.txt' 'subdirb/*.txt'
'subdira/*.txt'
git log --oneline -- 'subdirc/*.txt' 'subdirb/*.txt' 'subdira/*.txt'

echo Explicit Test 1: git log --oneline -- 'subdira/file.txt'
'subdirb/file.txt' 'subdirc/file.txt'
git log --oneline -- 'subdira/file.txt' 'subdirb/file.txt' 'subdirc/file.txt'

echo Explicit Test 2: git log --oneline -- 'subdira/file.txt'
'subdirc/file.txt' 'subdirb/file.txt'
git log --oneline -- 'subdira/file.txt' 'subdirc/file.txt' 'subdirb/file.txt'

echo Explicit Test 3: git log --oneline -- 'subdirb/file.txt'
'subdira/file.txt' 'subdirc/file.txt'
git log --oneline -- 'subdirb/file.txt' 'subdira/file.txt' 'subdirc/file.txt'

echo Explicit Test 4: git log --oneline -- 'subdirb/file.txt'
'subdirc/file.txt' 'subdira/file.txt'
git log --oneline -- 'subdirb/file.txt' 'subdirc/file.txt' 'subdira/file.txt'

echo Explicit Test 5: git log --oneline -- 'subdirc/file.txt'
'subdira/file.txt' 'subdirb/file.txt'
git log --oneline -- 'subdirc/file.txt' 'subdira/file.txt' 'subdirb/file.txt'

echo Explicit Test 6: git log --oneline -- 'subdirc/file.txt'
'subdirb/file.txt' 'subdira/file.txt'
git log --oneline -- 'subdirc/file.txt' 'subdirb/file.txt' 'subdira/file.txt'

-- 
Jeremy Nickurak -= Email/XMPP: -= jeremy@nickurak.ca =-
