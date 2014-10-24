From: Juan Palacios <jpalacios@atlassian.com>
Subject: jpalacios@atlassian.com
Date: Fri, 24 Oct 2014 13:50:02 +1100
Message-ID: <CABY2JrJjZH+hgeGCBwFjBxsTdo_M2yXctr1dJKLxFL28hacQPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:50:09 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhUx6-0006ra-SB
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 04:50:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754614AbaJXCuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2014 22:50:04 -0400
Received: from na3sys009aog111.obsmtp.com ([74.125.149.205]:52321 "HELO
	na3sys009aog111.obsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with SMTP id S1751700AbaJXCuD (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 23 Oct 2014 22:50:03 -0400
Received: from mail-yh0-f42.google.com ([209.85.213.42]) (using TLSv1) by na3sys009aob111.postini.com ([74.125.148.12]) with SMTP
	ID DSNKVEm+Wos1mMWzqUMiMiC1I9BhlJhC8YOW@postini.com; Thu, 23 Oct 2014 19:50:03 PDT
Received: by mail-yh0-f42.google.com with SMTP id t59so2091901yho.29
        for <git@vger.kernel.org>; Thu, 23 Oct 2014 19:50:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:mime-version:date:message-id:subject:from:to
         :content-type;
        bh=yUOHZ+8ablQd36mey0XqNrWRssEdwrGYZPbQSsWN7+I=;
        b=GIRA1cV0SVtdWaF2LBd5dBi4Cjc3Ib8nT0yuf6bcW6YA7c4wWFzRk450r/y7XMx8h2
         k3CRg6/vUK/fFpk5i1rjo52rwW5Lbgox/RxD4RBU2F2/5jYVyxwVmviYVCGJ+AwFV3hs
         PnAbh51N/u01YcP/OnCKlVZ6BrG44eda4rvhljQwyHAhxgpWVolLlFLDOYhkQjS+4W7s
         EtNtFPqYwlSYDEiqtM5dhseigD2MkQmfbnUfduMI2QyiKm9UeS0rJFpafZG2r2OByA8z
         E1p5sDdnHbxvA62uKPK1mVtBYe1h1QjeHzyJ4lXm60EgKFNAmxs7DIzAr9bLI/zKW6iG
         hVBA==
X-Gm-Message-State: ALoCoQm9eThrNOhtHbjVzSl17Drcj4j+IJmF+hwZq4DP35p0rec9+sB2fv+foyfAD5iHgFVGYZ44ZT3f8Op5jAAEPUQbi5Y+3y+fpRVkLn3Wp7dOEEjOhj/c2FxZ8n7bonxCsubZsBM9OWKkfKDlIViK630x2UTobA==
X-Received: by 10.170.83.198 with SMTP id z189mr1702869ykz.70.1414119002259;
        Thu, 23 Oct 2014 19:50:02 -0700 (PDT)
X-Received: by 10.170.83.198 with SMTP id z189mr1702859ykz.70.1414119002180;
 Thu, 23 Oct 2014 19:50:02 -0700 (PDT)
Received: by 10.50.221.180 with HTTP; Thu, 23 Oct 2014 19:50:02 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

In a project with a submodule, if you merge two diverging branches in
which one branch updated which commit the submodule points to, and the
other branch moves the submodule to a new location, the resulting
merge error message does not provide information about what the
conflict was, or the path to the conflicted directory.

I've included at the bottom a short script which sets up a project
with a submodule and creates both branches. If after running it you cd
into 'top-level-project' and run 'git merge
branch_that_points_the_submodule_to_new_commit' the resulting error
message is:

Auto-merging submodule-moved
Adding as submodule-moved~HEAD instead
Automatic merge failed; fix conflicts and then commit the result.

I would have expected an output in line with other merge conflict
messages. Something with the format:

CONFLICT (<REASON>): Merge conflict in <PATH_TO_CONFLICT>

Where <REASON> would be something like (delete/modify) I believe this
might be a bug in the implementation.

Thank you

--------------------------

# Create a submodule
mkdir submodule
pushd submodule
echo "This is a submodule" > README.txt
git init
git add README.txt
git commit -m "Initial commit"
popd

# Create a top level project
mkdir top-level-project
pushd top-level-project
echo "This is a parent project" > README.txt
git init
git add README.txt
git commit -m "Initial commit"

# Add submodule to top level project
git submodule add ../submodule/
git commit -m "Added a submodule"

# Create two diverging branches
git checkout -b branch_that_points_the_submodule_to_new_commit
git checkout -b branch_that_moves_the_submodule_to_new_path

# Update the commit the submodule points to in one branch
git checkout branch_that_points_the_submodule_to_new_commit
pushd submodule
echo "This modifies the README file" > README.txt
git add .
git commit -m "Added line to README file"
popd
git add submodule
git commit -m "Updated submodule to point to new commit"

# Move the submodule directory in the other branch
git checkout branch_that_moves_the_submodule_to_new_path
git submodule update
git mv submodule submodule-moved
git commit -m "Moved submodule to new path"
