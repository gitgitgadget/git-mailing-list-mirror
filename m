From: Joshua Jensen <jjensen@workspacewhiz.com>
Subject: Repository data loss in fast-export with a merge of a deleted submodule
Date: Thu, 27 Oct 2011 13:27:49 -0600
Message-ID: <4EA9B0B5.6060005@workspacewhiz.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
To: "git@vger.kernel.org" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Oct 27 21:27:07 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RJVbV-0001Kg-HD
	for gcvg-git-2@lo.gmane.org; Thu, 27 Oct 2011 21:27:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751754Ab1J0T0v (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Oct 2011 15:26:51 -0400
Received: from hsmail.qwknetllc.com ([208.71.137.138]:48587 "EHLO
	hsmail.qwknetllc.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751475Ab1J0T0v (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Oct 2011 15:26:51 -0400
Received: (qmail 27918 invoked by uid 399); 27 Oct 2011 13:26:47 -0600
Received: from unknown (HELO ?192.168.1.11?) (jjensen@workspacewhiz.com@50.8.110.77)
  by hsmail.qwknetllc.com with ESMTPAM; 27 Oct 2011 13:26:47 -0600
X-Originating-IP: 50.8.110.77
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:7.0.1) Gecko/20110929 Thunderbird/7.0.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/184318>

Hello.

We had a submodule that we deleted and then added back into the 
repository at the same location as the former submodule.  When running 
fast-export, the newly 'added' files for the merge commit are listed and 
then are followed with a:

M ... path/to/submodule/file
D path/to/submodule

On fast-import, the resultant repository becomes corrupt due to the 
Delete instruction above occurring AFTER the file adds/modifications.  
The new repository does not match the old repository where the 
fast-export was performed.

I have included a repro script below.  I have not been able to test this 
on Git 1.7.7.1, but I have tested on Git 1.7.7 (msysGit version).

Please compare the differences between the generated main.fe and 
newmain.fe files.  newmain.fe has data loss.

I am not familiar with the fast-export code.  Can anyone help out?

Thanks.

Josh

---------

rm -rf main brokenmain sub main.fenewmain.fe

# Create the submodule.
mkdir sub
cd sub
git init
echo file > file
git add file
git commit -m file
cd ..

# Create the main repository.
mkdir main
cd main
git init

# Add the submodule.
git submodule add ../sub sub
git commit -m "Add submodule"

# Remove the submodule.
rm -rf sub
git rm sub .gitmodules
git commit -m "Remove submodule"

# Add sub/file to the master branch.
mkdir sub
echo file > sub/file
git add sub/file
git commit -m "Add sub/file"
if [ -f sub/file ]; then
     echo "main: master branch: sub/file exists."
fi

# Delete the submodule directory manually, because we know that the 
incoming merge will need it gone.
git checkout -B will-be-broken HEAD^^
rm -rf sub
git merge --no-ff master

# sub/file exists within the 'will-be-broken' branch.
if [ -f sub/file ]; then
     echo "main: will-be-broken branch: sub/file exists."
fi

# Export out the main repository.
git fast-export --all > ../main.fe

# Create the brokenmain repository.
cd ..
mkdir brokenmain
cd brokenmain
git init

# Import in everything from the main repository.
git fast-import < ../main.fe

# sub/file exists within the master branch.
git checkout master
if [ -f sub/file ]; then
     echo "brokenmain: master branch: sub/file exists."
fi

# sub/file SHOULD exist within the 'will-be-broken' branch but doesn't.
git checkout will-be-broken
if [ ! -f sub/file ]; then
     echo "brokenmain: will-be-broken branch: sub/file SHOULD exist but 
doesn't."
fi

# Export out the brokenmain repository.
git fast-export --all > ../brokenmain.fe
