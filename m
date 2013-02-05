From: Roberto Tyley <roberto.tyley@gmail.com>
Subject: A fast alternative to git-filter-branch - The BFG Repo-Cleaner
Date: Tue, 5 Feb 2013 00:04:20 +0000
Message-ID: <CAFY1edb6osN+Qe33K9e6imaMG=3_ZUJx7Q1R++RHfY6h+zGXYQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 05 01:04:47 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U2W1k-0006dF-QL
	for gcvg-git-2@plane.gmane.org; Tue, 05 Feb 2013 01:04:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755360Ab3BEAEW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 4 Feb 2013 19:04:22 -0500
Received: from mail-ie0-f178.google.com ([209.85.223.178]:41694 "EHLO
	mail-ie0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755292Ab3BEAEV (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 4 Feb 2013 19:04:21 -0500
Received: by mail-ie0-f178.google.com with SMTP id c13so6445017ieb.23
        for <git@vger.kernel.org>; Mon, 04 Feb 2013 16:04:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:date:message-id:subject:from:to
         :content-type;
        bh=eDa98ksSDAGYqkDvg3PfAPvfDbJ3tNbZl9462X3NJNY=;
        b=S3qWcc0u6fUK5l9E/sPA11oFjr/Dp84GSkbfPLEBvF1+GWLTFzt+TaaLuWGARgbcv1
         /eL4yK4N17eP/xNiMwyAIbP9QWH151srygCIRyQ3KFgXR/W3c3BvIfPlOEEQD02nTcks
         2yMUGQsqmT4Gao753RON+rWJSMY9eupYWwKmk8W3qGFKLAfSOlkXtD3suXQ53zrLe0sd
         z/PuhIX4+TX1pzFJ4FYKVSZfUS5RkLkpf1SdTrenfLxyMURBoTgnz7HPew0A8OM0wRik
         3++1inQjDMCiQ0piiNz8rUIZ1KE5j7VwAvDXU7QXBDHhmCxtOEjOv0nYEZ2Z5TN2Ndi7
         rqOw==
X-Received: by 10.50.209.100 with SMTP id ml4mr9550686igc.28.1360022661185;
 Mon, 04 Feb 2013 16:04:21 -0800 (PST)
Received: by 10.64.8.178 with HTTP; Mon, 4 Feb 2013 16:04:20 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/215437>

I recently released The BFG Repo-Cleaner, a new tool for cleansing bad
data out of Git repository histories. The BFG is typically at least
10-50x faster than git-filter-branch at these tasks:

* Removing Crazy Big Files from repo history
* Removing Passwords, Credentials & other Private data

http://rtyley.github.com/bfg-repo-cleaner/

As an example, these are timings for deleting an arbitrary file from
the large GCC repository (148495 commits):

The BFG : 3m29s
$ bfg -D README-fixinc

git filter-branch : 472m31s
$ git filter-branch --index-filter 'git rm --cached --ignore-unmatch
gcc/README-fixinc' --prune-empty --tag-name-filter cat -- --all

(roughly a 135x speed increase, reducing the task of processing a
large codebase from an overnight job to the work of a few minutes....
all timings done in a 4GB tmpfs ramdisk)


The BFG has some simple but very powerful command-line options, which
perform at similar speed:

remove all blobs bigger than 1 megabyte :
$ bfg --strip-blobs-bigger-than 1M  my-repo.git

replace all passwords (listed in a file 'passwords.txt') with ***REMOVED*** :
$ bfg --replace-banned-strings passwords.txt  my-repo.git


The main source of the BFG's performance advantage comes from
preventing repeated examination of the same tree objects. The approach
of git-filter-branch performs filtering for each commit, against the
complete file-hierarchy of each commit, one after the other, even
though commit trees are largely very similar. For the use-cases of The
BFG that's unnecessary- we don't care where, and in which commit, a
'bad' file exists - we just want it dealt with. Consequently the BFG
processes the Git object db on a memoised tree-by-tree basis,
processing each and every file & folder exactly once - the final
processing of the commit hierarchy is very quick. This _does_ mean
that it's not possible to delete files based on their absolute path
within the repo, but they can deleted based on their filename,
blob-id, or contents. This, and multi-core processing by default,
gives the dramatic speed-up while still providing the same results.
There's more performance data here:
https://docs.google.com/spreadsheet/ccc?key=0AsR1d5Zpes8HdER3VGU1a3dOcmVHMmtzT2dsS2xNenc

I'd welcome feedback, and if anyone has cause to filter a repository's
history in future, I'd appreciate you giving the BFG a try and letting
me know how you found it.

thanks,
Roberto Tyley
software dev @ The Guardian

http://rtyley.github.com/bfg-repo-cleaner/
