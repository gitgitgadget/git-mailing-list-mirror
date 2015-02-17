From: Martin Maas <maas@eecs.berkeley.edu>
Subject: Potential Bug: git merge overwrites uncommitted changes
Date: Mon, 16 Feb 2015 20:26:38 -0800
Message-ID: <CAHBpcCZMqFyFga4hyGQA3Sum3Lsn=knR1i9PAHr8G+Zyx8FepA@mail.gmail.com>
Reply-To: maas@eecs.berkeley.edu
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Feb 17 05:27:15 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YNZkF-0004Ru-Dg
	for gcvg-git-2@plane.gmane.org; Tue, 17 Feb 2015 05:26:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751936AbbBQE0m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Feb 2015 23:26:42 -0500
Received: from mail-la0-f46.google.com ([209.85.215.46]:44642 "EHLO
	mail-la0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751371AbbBQE0l (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Feb 2015 23:26:41 -0500
Received: by lams18 with SMTP id s18so33562269lam.11
        for <git@vger.kernel.org>; Mon, 16 Feb 2015 20:26:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:reply-to:date:message-id:subject
         :from:to:content-type;
        bh=zmGOGXR300OpgiRpBKd/qu9mbElGBMJx07b+VglRvtE=;
        b=EdWFxs6jYopyRtriA+Nxp4SbpVl0bmizg4+WSOi18Pdxguh/kdZgUZccHx/E7Mb/Aw
         IReZHL7yJp9GuPB9JZCQFEys8mptWNLdQNtTf+fLYGN+vW3lar4QId1J2nkg5n9e9QDY
         +Ni0etKaQ/gWETdp5QSy4BOG333AG+1r6tig6EZrFKFnw/Yyux+pqpD+DGCEFAufcA7J
         afl/MZvxHbRWlc4e5/TgKVrsnSkslkarpVAktrS5j8TNJ+BLeH3gc2+FfwwSOc+RQl8i
         429vskOmViAfJkd8h5iwKtQ/qzW1YfNU5M4Wjo5SOjoV+2PPlVBxfBSTOR6mQE1zceZh
         P9Mw==
X-Gm-Message-State: ALoCoQlhT3eEEfnyJJjcGDSq4u2c80EA/yLlQjG4rR6lmdbxMULiT+bZfD1hOQsqYlHAJfI4ZBcm
X-Received: by 10.112.214.204 with SMTP id oc12mr14631113lbc.10.1424147198126;
 Mon, 16 Feb 2015 20:26:38 -0800 (PST)
Received: by 10.112.12.200 with HTTP; Mon, 16 Feb 2015 20:26:38 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/263931>

Hi all,

Teaching a university class using git, we encountered a case of
potentially incorrect behavior when students made changes to a file,
forgot to commit them, and then pulled a new one-line change from our
remote repository. This resulted in the uncommitted changes being
overwritten without a warning.

To our understanding, the expected behavior should have been a warning
that uncommitted files are being overwritten, or an auto-merge that
preserves the changes in the uncommitted files. Instead, git shows the
merge as a single-line change, while in reality discarding potentially
a large number of uncommitted lines.

I have attached a script that replicates this behavior -- we have been
able to replicate the problem with git versions 1.9.1, 1.9.3 and
2.2.2. Please let us know whether this is a bug, or whether this is
the intended behavior.

It appears that it is only this specific sequence of commands that
causes the behavior. Across a range of small modifications to the
sequence of steps, the behavior is as expected:

* using git cp and dropping the add step -> modifications preserved
* not doing commit 2 (or its changes) -> modifications live in new file
* any change in branch use other than test first master second ->
modifications preserved

(Asking colleagues, one of them pointed me to the following article
which describes a potentially related problem that appears to have
been fixed in 1.7.7:
http://benno.id.au/blog/2011/10/01/git-recursive-merge-broken)

Thanks,
Martin

---

git-test.sh: Run in a clean directory!

#!/bin/bash

# Replicate the two different states of hw2_starter, before and after
our update.
git clone git@github.com:cs61c-spring2015/hw2_starter.git
cd hw2_starter
git checkout f8a2e4418b4c370921790d1dfd1b6f9761262d4a
git checkout -b test
cd ..

# Set up the cs61c-xx repository, and fetch "first" hw2_starter.
mkdir cs61c-test
cd cs61c-test
git init
git remote add hw2_starter ../hw2_starter/
git fetch hw2_starter
git merge hw2_starter/test -m "add hw2 changes"

# Perform a series of commits that some students accidentally did.
mkdir hw2
git mv hw1 hw2
git commit -a -m "commit 1"

cp hw2/hw1/* hw2/
git add hw2/*
git commit -a -m "commit 2"

# Now we make changes to the beargit.c file, but don't commit them.
for i in `seq 1 5`; do
echo "beargitcode line $i" >> hw2/beargit.c
done

echo
echo
echo " *** SHOULD HAVE A LINE CONTAINING beargitcode IN beargit.c ***"
echo
echo "CONTENT OF beargit.c | grep beargitcode BEFORE MERGE:"
cat hw2/beargit.c | grep beargitcode
echo "[EOF]"
echo

# Now we fetch the update, as we told students
git fetch hw2_starter
git merge hw2_starter/master -m "add hw2 changes"

# This should fail, because there are uncommitted changes!!!

echo
echo "CONTENT OF beargit.c | grep beargitcode AFTER MERGE:"
cat hw2/beargit.c | grep beargitcode
echo "[EOF]"
echo
