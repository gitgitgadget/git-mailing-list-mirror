From: Martin Langhoff <martin.langhoff@gmail.com>
Subject: Pitfalls in auto-fast-forwarding heads that are not checked out?
Date: Fri, 3 May 2013 18:46:08 -0400
Message-ID: <CACPiFCLnjCeCpt8wR71bFweFyA3rFCsnbEiR1yRD1n=X5K84Mw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sat May 04 00:46:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UYOkY-0005pX-2Q
	for gcvg-git-2@plane.gmane.org; Sat, 04 May 2013 00:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763846Ab3ECWqa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 May 2013 18:46:30 -0400
Received: from mail-qc0-f179.google.com ([209.85.216.179]:50036 "EHLO
	mail-qc0-f179.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761986Ab3ECWq3 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 May 2013 18:46:29 -0400
Received: by mail-qc0-f179.google.com with SMTP id b40so945560qcq.24
        for <git@vger.kernel.org>; Fri, 03 May 2013 15:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:from:date:message-id:subject:to
         :content-type;
        bh=gsKxGV0XprtQ3uQmZ1hYTBcXTj6xVoEY6xiY2fK7RK4=;
        b=Z75vNgb9mBdB3zEKO634Hdcl47odGIzLFEVSE+07S9KV6sYDJleJ2NTUWMVp65bsvK
         i+9SGCJ4fxS0mnMdGdwpydfCclW3wtArSVE6oSkDQ2FMnIKOeHv75Ol5qx4D9rEm3kCt
         0JDccc8wD64skfLfkIEMOQNe8gIzb0CMMh65r2QUgK8MbEv0cyLgB3TmcYgw+BrXER0W
         ZvhjHreExM9sfu24rHDxEaqvNSZCgL3amVs1jL610fDjowRIII6gPtegmF9kFFqsyABM
         wXM3TAeNjvwuMYqFbYjlI2JdxrmGOTEdHJ2Wrtf8UACo+KF2LYu4Nv82NR9vyITHwHZL
         4ZOA==
X-Received: by 10.49.116.101 with SMTP id jv5mr16751920qeb.30.1367621188809;
 Fri, 03 May 2013 15:46:28 -0700 (PDT)
Received: by 10.49.75.198 with HTTP; Fri, 3 May 2013 15:46:08 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223330>

I am building a small git wrapper around puppet, and one of the
actions it performs is auto-fastforwarding of branches without
checking them out.

In simplified code... we ensure that we are on a head called master,
and in some cases "ppg commit", will commit to master and...

  ## early on
  # sanity-check we are on master
  headname=$(git rev-parse --symbolic-full-name --revs-only HEAD)
  if [ "$headname" -ne "refs/heads/headname" ]; then
      echo >&2 "ERROR: can only issue --immediate commit from the
master branch!"
      exit 1
  fi

  ## then
  git commit -bla blarg baz

  ## and then...

  # ensure we can ff
  head_sha1=$(git rev-parse --revs-only master)
  mb=$(git merge-base $production_sha1 refs/heads/master)
  if [[ "$mb" -ne "$production_sha1" ]]; then
      echo >&2 "ERROR: cannot fast-forward master to production"
      exit 1
  fi
  $GIT_EXEC_PATH/git-update-ref -m "ppg immediate commit"
refs/heads/production $head_sha1 $production_sha1 || exit 1

Are there major pitfalls in this approach? I cannot think of any, but
git has stayed away from updating my local tracking branches; so maybe
there's a reason for that...

cheers,


m
--
 martin.langhoff@gmail.com
 -  ask interesting questions
 - don't get distracted with shiny stuff  - working code first
 ~ http://docs.moodle.org/en/User:Martin_Langhoff
