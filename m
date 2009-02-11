From: Stefan Karpinski <stefan.karpinski@gmail.com>
Subject: [RFC] post-commit hook to "fix" patches
Date: Wed, 11 Feb 2009 01:48:31 -0800
Message-ID: <d4bc1a2a0902110148u4e13d77cs3dde64d27003e58c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Feb 11 10:50:05 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LXBjF-0000yl-Hs
	for gcvg-git-2@gmane.org; Wed, 11 Feb 2009 10:50:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754650AbZBKJsd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 11 Feb 2009 04:48:33 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752567AbZBKJsd
	(ORCPT <rfc822;git-outgoing>); Wed, 11 Feb 2009 04:48:33 -0500
Received: from wa-out-1112.google.com ([209.85.146.177]:27105 "EHLO
	wa-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752501AbZBKJsc (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 11 Feb 2009 04:48:32 -0500
Received: by wa-out-1112.google.com with SMTP id v33so60832wah.21
        for <git@vger.kernel.org>; Wed, 11 Feb 2009 01:48:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:date:message-id:subject
         :from:to:content-type:content-transfer-encoding;
        bh=/53pIv8TTLwDy+iouBaO0L2sYVMpVBKlPxz6ep//ND0=;
        b=wn6rj6Ut/Fc/IwG1ITnSJmNZip6Kei5TroJDq+CFlOx1mlHMzukNxCCZ6uZ466xnYH
         oyjVTM43x6eeyrhOAd55HDDt8Dk83pHR91tsJ6KMFHUAbb4b++Qfek1xw8npkKc2saHg
         JVf80HdHyNCoDHwS6xVs8I6p3Jxt5/RJVEq58=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:date:message-id:subject:from:to:content-type
         :content-transfer-encoding;
        b=VDkgfgXca4vReDe9I3UDBCf6RFS/6H2UpObrRh5RFA8sYTgR3sRfyCIQCD2eaOkAIy
         5tWn2YJhSpkyGvZOl2i/esNvaPhab94U8f8RfdbK7oxdEL5+6MnJJ/E6sBvnSqQx101e
         sYWARD9WrWIC0nSDJjzFMzhJrh/n/e+KkADIE=
Received: by 10.114.95.12 with SMTP id s12mr5442776wab.223.1234345711800; Wed, 
	11 Feb 2009 01:48:31 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/109392>

I just wrote the following post-commit hook that I thought others
might find interesting or useful. It's a non-intrusive, efficient and
IMO elegant solution to the problem that I was trying to solve here:

  http://thread.gmane.org/gmane.comp.version-control.git/98228

The post-commit hook calls a named "git-fix-patch", presumed to be in
the path somewhere, which munges a git diff to enforce whatever
stylistic rules a project might have (typically whitespace)---but only
in added lines. The hook creates a new commit with the same effect as
the HEAD commit, but without the added style errors.

That part's easy. What's much more interesting is making sure that the
workspace is left essentially the way it was, but reflecting the
changes wrought by the "enforcer." This involves generating reverse
patches, fixing them up, and then applying the fixed up patch in
reverse. I had to think about this for a long time (and draw a bunch
of commutative diagrams) to grok that this was what needed to be done,
but it seems to work quite nicely and generally.

Here's the post-commit hook:

== >8 ==
#!/bin/sh

if test -z "$GIT_POST_COMMIT_HOOK_RUNNING"
then
  export GIT_POST_COMMIT_HOOK_RUNNING=true
  x=$(git rev-parse HEAD)
  git reset -q $x^
  git diff -U0 $x^ $x | git-fix-patch | \
    git apply --unidiff-zero --cached
  if git diff --cached --quiet $x
  then
    git reset -q $x
  else
    echo "Automatically amending style errors..."
    git commit -q -C $x
    if git diff -R -U0 $x | git-fix-patch | \
      git apply -R --unidiff-zero --cached --check 2>/dev/null
    then
      git diff -R -U0 $x | git-fix-patch | \
        git apply -R --unidiff-zero --cached 2>/dev/null
      git checkout-index -a -f
      git reset -q
    else
      echo "WARNING: Failed patching uncommitted changes."
    fi
  fi
  unset GIT_POST_COMMIT_HOOK_RUNNING
fi
== >8 ==

I also wrote a sample git-fix-patch script that enforces the following
coding styles:
  1. no trailing whitespace
  2. all leading indentation with tabs (assumed to have width $t, below)
  3. indentation only with spaces after the initial indentation

== >8 ==
#!/usr/bin/env perl

$t=4;

while (<>) {
  if (m{^\+}) {
    s{\s*$}{\n};
    while (s{\t}{" "x($t-((length($`)-1)%$t))}e) {0}
    s{^\+((?: {$t})+)}{"+"."\t"x(length($1)/$t)}e;
  }
  print;
}
== >8 ==

I'd be really interested in reactions or thoughts about this. Maybe it
can even go into the collection of contrib scripts.

Stefan
