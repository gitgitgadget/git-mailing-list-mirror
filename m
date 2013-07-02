From: Lee Winder <lee.winder@gmail.com>
Subject: git fetch --prune removes branches from origin/ with inconsistent
 case in path names
Date: Tue, 2 Jul 2013 21:37:25 +0100
Message-ID: <CAJz8ETuFC=STDRbPOxsTDdYbuMh0phdR3AYCzW3AvOrSAmKpWw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jul 02 22:37:31 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu7KM-0000rp-AO
	for gcvg-git-2@plane.gmane.org; Tue, 02 Jul 2013 22:37:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755643Ab3GBUh0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 16:37:26 -0400
Received: from mail-oa0-f46.google.com ([209.85.219.46]:43036 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754906Ab3GBUhZ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 16:37:25 -0400
Received: by mail-oa0-f46.google.com with SMTP id h1so7036932oag.33
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 13:37:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:date:message-id:subject:from:to:content-type;
        bh=THABq+pbMWfTepd87ruhVwJmtusKwhEyna4cnGPDs8I=;
        b=Fz6gzIYrPED/bXdoWYC67g5WoO1OIJjnmVHxlOH3BCW9VyVMCpW6M38l8Qx64L3GAV
         xWNFoRdhMBaIz0ekT1lqpfRhfsiKKsfF868kFwmu7n988C0ChCn3lQx1apjvrTACWIoi
         tVNyNGBliI6zY+PCYcDLMol8ATEWdjfBZW8wewhv2613jGcdSIYdyg1uzDQOdEVh+g8G
         imKJye+ljyoceY+LcyL4wL4wtjKDtb3aHB9WgmmZ1aHA1RwYACchkYHiHbxjvdacJsBv
         QH5PP9tuU1srm4X/wcbF4lG2A+YG0LgspiJhzDfaNp7UCM35MGjtP+b4Bily4XGD/FEM
         sKUA==
X-Received: by 10.60.102.41 with SMTP id fl9mr13012109oeb.37.1372797445073;
 Tue, 02 Jul 2013 13:37:25 -0700 (PDT)
Received: by 10.76.1.37 with HTTP; Tue, 2 Jul 2013 13:37:25 -0700 (PDT)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229428>

When using git fetch --prune, git will remove any branches from
remotes/origin/ that have inconsistent case in folder names.

This issue has been verified in versions 1.7.10.2, 1.7.11.1 and 1.8.3.2.

I've described the reproduction steps here as I carried them out, and
listed the plaforms I used to replicate it.  The issue will most
likely occur on a different combination of platforms also.

- On Mac, create a new repository and push a master branch to a central server
- On Mac, create a branch called feature/lower_case_branch and push
this to the central server (note that 'feature' is all lower case)
- On Windows, clone the repository but stay on master, do not checkout
the feature/lower_case_branch branch
- On Windows, branch from master a branch called
Feature/upper_case_branch (note the uppercase F) and push to the
server
- On Mac, run git fetch and see that
remote/origin/Feature/upper_case_branch is updated

Couple of things to note here
1) In the git fetch output it lists the branch with an upper case 'F'
  * [new branch]      Feature/upper_case_branch ->
origin/Feature/upper_case_branch
2) When I run git branch --all it is actually listed with a lower case 'f'
  remotes/origin/feature/upper_case_branch

Now the problem happens when I run git fetch --prune, I get the following output
  * [new branch]      Feature/upper_case_branch ->
origin/Feature/upper_case_branch
  x [deleted]         (none)     -> origin/feature/upper_case_branch

Note the new branch uses 'F' and the deleted branch uses 'f'.

The results of this bug seem to be
* Everytime I call git fetch it thinks Feature/upper_case_branch is a
new branch (if I call 'git branch' multiple times I always get the
[new branch] output)
* Whenever I run with --prune, git will *always* remove the branch
with a different folder name (from a case sensitive perspective) than
the one originally created on the current machine.


Thanks
Lee
