From: =?ISO-8859-1?Q?Kirill_M=FCller?= <kirill.mueller@ivt.baug.ethz.ch>
Subject: Hard reset of a subdirectory in a sparse checkout setting
Date: Fri, 22 Mar 2013 11:28:25 +0100
Message-ID: <514C3249.7000100@ivt.baug.ethz.ch>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"; format=flowed
Content-Transfer-Encoding: 7bit
To: <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Fri Mar 22 11:35:06 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UIzJQ-0005ZX-Eb
	for gcvg-git-2@plane.gmane.org; Fri, 22 Mar 2013 11:35:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753922Ab3CVKeh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Mar 2013 06:34:37 -0400
Received: from edge10.ethz.ch ([82.130.75.186]:10207 "EHLO edge10.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753806Ab3CVKeg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Mar 2013 06:34:36 -0400
X-Greylist: delayed 368 seconds by postgrey-1.27 at vger.kernel.org; Fri, 22 Mar 2013 06:34:36 EDT
Received: from CAS22.d.ethz.ch (172.31.51.112) by edge10.ethz.ch
 (82.130.75.186) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 22 Mar
 2013 11:28:23 +0100
Received: from [129.132.210.153] (129.132.210.153) by mail.ethz.ch
 (172.31.51.112) with Microsoft SMTP Server (TLS) id 14.2.298.4; Fri, 22 Mar
 2013 11:28:27 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:17.0) Gecko/20130308 Thunderbird/17.0.4
X-Originating-IP: [129.132.210.153]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/218789>

Hi

I can't find a neat way to "git reset --hard" a subdirectory of a 
checkout without reading in directories or files which are excluded by a 
sparse checkout. This has been asked on StackOverflow in greater detail, 
but the "right" answer is still missing: 
http://stackoverflow.com/q/15404535/946850

The options I see are:

- git checkout . (will restore excluded directories)

- git reset --hard (won't accept a path argument)

- git diff | patch -R (awkward)

What's the proper way to do this in Git?

The script below illustrates the problem. The proper command should be 
inserted below the "How to make files ..." comment -- the current 
command "git checkout -- a" will restore the file a/c/ac which is 
supposed to be excluded by the sparse checkout. Note that I do not want 
to explicitly restore a/a and a/b, I only "know" a and want to restore 
everything below. And I also don't "know" b, or which other directories 
reside on the same level as a.

Thank you for your help.


Cheers

Kirill


#!/bin/sh

rm -rf repo; git init repo; cd repo
for f in a b; do
   for g in a b c; do
     mkdir -p $f/$g
     touch $f/$g/$f$g
     git add $f/$g
     git commit -m "added $f/$g"
   done
done
git config core.sparsecheckout true
echo a/a > .git/info/sparse-checkout
echo a/b >> .git/info/sparse-checkout
echo b/a >> .git/info/sparse-checkout
git read-tree -m -u HEAD
echo "After read-tree:"
find * -type f

rm a/a/aa
rm a/b/ab
echo >> b/a/ba
echo "After modifying:"
find * -type f
git status

# How to make files a/* reappear without changing b and without 
recreating a/c?
git checkout -- a

echo "After checkout:"
git status
find * -type f
