From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: [ANNOUNCE] git-related-0.1
Date: Thu, 10 Oct 2013 16:43:21 -0500
Message-ID: <CAMP44s0wPzV6FkfON4zazkOWqTB0qbpdEtruHD01NybtiK6-Og@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Oct 10 23:43:30 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VUO13-0005Ae-Ql
	for gcvg-git-2@plane.gmane.org; Thu, 10 Oct 2013 23:43:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757664Ab3JJVnY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Oct 2013 17:43:24 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:46748 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757653Ab3JJVnX (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Oct 2013 17:43:23 -0400
Received: by mail-la0-f53.google.com with SMTP id el20so2603191lab.40
        for <git@vger.kernel.org>; Thu, 10 Oct 2013 14:43:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=58so/Hdq/1ScnwWK/nl47sl9QRupFB5ACibI8LHUOGI=;
        b=M6aykQSfNKjtA1/I+LRKC1/xTgj5n/aiqZQ2FeobeOkCe2PfAOV0315zlr7T0gPJd8
         8BfuVPqd7bID+VJSMzUE/8R3Gtqn04bI2fqqBCWoPqlceg1ObeXEY+TQvoj89oxnrwD7
         aNzj8AOykhLxcsvHvV83Xt5EhZ01SCHsDJqKWz5Kiowf1+idfkkJJeyXKb1l3RxUReq8
         TRYyLJrRqCl7j5cY3Y2zhRTMSZ884kUMr8lsNsZk+xYpp6BHxZ7CrT2tuJaNay1sO5c7
         w9Q4XyGlwIfiqwEYRBWTXeDB4skFzPoic/kliXXzMoa2gAmtg/drC/zNbpH3ufj5Ib4H
         iNgA==
X-Received: by 10.152.170.166 with SMTP id an6mr13129076lac.20.1381441401404;
 Thu, 10 Oct 2013 14:43:21 -0700 (PDT)
Received: by 10.114.91.230 with HTTP; Thu, 10 Oct 2013 14:43:21 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/235886>

Hi,

This is basically the same as my original series[1] which was dropped
for no good reasons, plus all the other features I also sent patches
for.

This is way superior to the current git-contacts that sits on the contrib area.

For the uninitiated, this tool finds people that might be interested
in a patch, by going back through the history for each single hunk
modified, and finding people that reviewed, acknowledged, signed, or
authored the code the patch is modifying.

It does this by running `git blame` incrementally on each hunk, and
then parsing the commit message. After gathering all the relevant
people, it groups them to show what exactly was their role when the
participated in the development of the relevant commit, and on how
many relevant commits they participated. They are only displayed if
they pass a minimum threshold of participation.

For example:

  % git related master..fc/transport/improv
  Junio C Hamano <gitster@pobox.com> (signer: 90%, author: 5%)
  Felipe Contreras <felipe.contreras@gmail.com> (author: 25%, reviewer: 2%)
  Sverre Rabbelier <srabbelier@gmail.com> (author: 17%, acker: 2%, signer: 7%)
  Jeff King <peff@peff.net> (acker: 17%, author: 10%)
  Shawn O. Pearce <spearce@spearce.org> (author: 5%, signer: 2%, cced: 2%)
  Elijah Newren <newren@gmail.com> (author: 10%)

In addition, it has an option to output the list of commits, instead
of the contributors, which allows you to easily find out the previous
changes to the lines your patches modify.

  % git related -c master..fc/transport/improv
  99d9ec0 Merge branch 'fc/transport-helper-no-refspec'
  67c9c78 transport-helper: barf when user tries old:new
  0460ed2 documentation: trivial style cleanups
  126aac5 transport-helper: fix remote helper namespace regression
  21610d8 transport-helper: clarify pushing without refspecs
  a93b4a0 transport-helper: warn when refspec is not used
  664059f transport-helper: update remote helper namespace
  c4458ec fast-export: Allow pruned-references in mark file
  ...

Moreover, when sending patches for review, you can configure `git
send-email` to use `git related` to find relevant people that should
be Cc'ed:

  % git send-email --cc-cmd='git related' *.patch

It has way many more features than git-contacts which is a rewrite in
Perl of this script, but only the initial bare minimum stage.

I've also added tests, and this is how git-contacts fares in comparison:

--- expected 2013-10-10 21:13:45.938291298 +0000
+++ actual 2013-10-10 21:13:45.937291298 +0000
@@ -1,2 +1,2 @@
-Jon Stewart <jon@stewart.com> (author: 50%)
-Pablo Escobar <pablo@escobar.com> (author: 50%)
+Jon Stewart <jon@stewart.com>
+Pablo Escobar <pablo@escobar.com>
not ok 1 - basic

git-contacts doesn't show the amount of involvement, but that's easy to fix.

--- expected 2013-10-10 21:13:45.975291299 +0000
+++ actual 2013-10-10 21:13:45.974291299 +0000
@@ -1,2 +1,3 @@
-John Poppins <john@doe.com> (author: 66%)
-Jon Stewart <jon@stewart.com> (reviewer: 33%, author: 33%)
+John Doe <john@doe.com>
+John Poppins <john@doe.com>
+Jon Stewart <jon@stewart.com>
not ok 2 - others

git-contacts doesn't show the kind of involvement (reviewer, author)
nor does it group people by their email address.

(skip other failures)

expecting success:
git related -craw -1 master | git log --format='%s' --no-walk --stdin
> actual &&
cat > expected <<-EOF &&
four
three
one
EOF
test_cmp expected actual

not ok 7 - commits

Also, it doesn't have the option to show the commits themselves, which
is useful to investigate the diffs. This feature alone is what makes
the make "git-contacts" not appropriate, because if this feature is
implemented, 'git contacts --commits' wouldn't have anything to do
with "contacts".

For that matter it doesn't support any options at all (e.g.
--min-percent, --since), and doesn't have a usage helper (--help).

Just put git-related in your PATH, and enjoy :)

Cheers.

[1] http://article.gmane.org/gmane.comp.version-control.git/226058

-- 
Felipe Contreras
