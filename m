From: Jon Seymour <jon.seymour@gmail.com>
Subject: git submodule: git sync does the wrong thing if the origin URL is relative
Date: Fri, 18 May 2012 18:44:28 +1000
Message-ID: <CAH3Anrr6mLVedBPcgfVwy=5KRjUgdp5W8P0DQ3qaX_UjH-npDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri May 18 10:44:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SVIne-0002iN-TA
	for gcvg-git-2@plane.gmane.org; Fri, 18 May 2012 10:44:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965279Ab2ERIod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 May 2012 04:44:33 -0400
Received: from mail-we0-f174.google.com ([74.125.82.174]:65453 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964847Ab2ERIo3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 May 2012 04:44:29 -0400
Received: by weyu7 with SMTP id u7so1660176wey.19
        for <git@vger.kernel.org>; Fri, 18 May 2012 01:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:cc:content-type;
        bh=uC+HcZstnRVgVSUiyjI4CYN6hNr+p//iIDrfqKzIVFM=;
        b=btkzNmK70N7sdEyWeJ9BFKWAqJCeMAD/bM1J1E5V5pUej5ss3cFZFE3RGmjE6gk2V9
         vtMhMjIVdq7Dcv+2kSgBqZz8thp1vLX4mXNeBgla78zUoJVpYhyRA24YA9BB4Amw6LQg
         uMjDgVmLSLCx+GSpbjU5sLRSIO0tKUaUqm9a9pbpRVV/1HFIou5wErIa9epUxDTs/pmL
         +ghcvaRlMINZKZ3tqbx+zVrIJvLSWbpBvKAIfprkdyTkAtAPG9k+sfF7NQg3dlmw+h8+
         J6abEOvJsf0y75+3gri/TZH53hUoKc194uhpPgnciU6Q+G2nX/PXSATT2W5MNY5hjYa6
         aqjw==
Received: by 10.180.75.241 with SMTP id f17mr26050499wiw.11.1337330668081;
 Fri, 18 May 2012 01:44:28 -0700 (PDT)
Received: by 10.180.83.131 with HTTP; Fri, 18 May 2012 01:44:28 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197943>

The following is a test case that demonstrates a problem with the
heuristic that git sync uses to update the origin URL of submodules in
the case that the origin URL of the super module itself is a relative
URL

I think what it should be doing is prefixing the relative path between
the submodule and the supermodule to the supermodules origin URL as
well as doing what it currently does with the suffix.

Does anyone disagree?

jon.

--

#!/bin/sh
mkdir work &&
cd work &&
rm -rf public &&
rm -rf checkout &&
rm -rf private &&
mkdir public &&
mkdir checkout &&
mkdir -p private/progenitor &&
cd private/progenitor &&
git init &&
mkdir child &&
pushd child &&
git init &&
:> .gitignore &&
git add .gitignore &&
git commit -m "initial child" &&
popd &&
git submodule add ../progenitor/child ./child &&
git commit -m "initial progenitor" &&
git clone --bare . ../../public/progenitor.git &&
git clone --bare child ../../public/progenitor/child.git &&
cd ../../checkout &&
git clone ../public/progenitor.git progenitor &&
cd progenitor &&
git submodule init &&
git submodule update --rebase &&
git fetch origin &&
git submodule foreach git fetch origin &&
git remote set-url origin ../../public/progenitor.git &&
git submodule sync &&
git submodule update --rebase &&
git fetch origin &&
git submodule foreach git fetch origin
