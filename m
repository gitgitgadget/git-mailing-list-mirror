From: Volkmar Glauche <volkmar.glauche@uniklinik-freiburg.de>
Subject: subtree merge strategy - merge upstream branches that share
	history
Date: Thu, 11 Jul 2013 12:35:39 +0200
Message-ID: <20130711123539.kya5rtfpc4gs08w4@webmail1.uniklinik-freiburg.de>
Mime-Version: 1.0
Content-Type: multipart/mixed;
	boundary="=_50sq5ssw7vcw"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jul 11 12:44:07 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UxEM1-0000VI-1y
	for gcvg-git-2@plane.gmane.org; Thu, 11 Jul 2013 12:44:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932123Ab3GKKoA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Jul 2013 06:44:00 -0400
Received: from skl5.ukl.uni-freiburg.de ([193.196.199.5]:52604 "EHLO
	skl5.ukl.uni-freiburg.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932094Ab3GKKn7 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Jul 2013 06:43:59 -0400
X-Greylist: delayed 498 seconds by postgrey-1.27 at vger.kernel.org; Thu, 11 Jul 2013 06:43:59 EDT
Received: from ews1.ukl.uni-freiburg.de (ews1.ukl.uni-freiburg.de [193.196.237.32])
	by skl5.ukl.uni-freiburg.de (Email) with SMTP id A6EED1A65CD
	for <git@vger.kernel.org>; Thu, 11 Jul 2013 12:35:38 +0200 (CEST)
Received: from (unknown [193.196.199.31]) by ews1.ukl.uni-freiburg.de with smtp
	 id 4b92_9675_a0a1375c_ea15_11e2_807b_001d096f4a4d;
	Thu, 11 Jul 2013 12:35:37 +0200
Received: from ed01073.ukl.uni-freiburg.de (ed01073.ukl.uni-freiburg.de
	[10.235.1.73]) by webmail1.uniklinik-freiburg.de (Horde MIME library) with
	HTTP; Thu, 11 Jul 2013 12:35:39 +0200
User-Agent: Internet Messaging Program (IMP) H3 (4.1.6)
X-NAI-Spam-Flag: NO
X-NAI-Spam-Level: **
X-NAI-Spam-Threshold: 5
X-NAI-Spam-Score: 2.9
X-NAI-Spam-Report: 5 Rules triggered
	*  1 -- CT_BNDRY_SHORT_1
	*  0.9 -- INVALID_MSGID_W_GEN_SPAM_FEATRE
	*  0.8 -- INVALID_MSGID
	*  0.2 -- GEN_SPAM_FEATRE
	*  0 -- RV4635
X-NAI-Spam-Version: 2.3.0.9362 : core <4635> : streams <997905> : uri
 <1473877>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/230082>

This message is in MIME format.

--=_50sq5ssw7vcw
Content-Type: text/plain;
	charset=ISO-8859-1;
	DelSp="Yes";
	format="flowed"
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Dear list,

I would like to set up a repository that has multiple branches from a =20
upstream project merged at different paths. Also, I would like to be =20
able to access upstream history in my project (it is interpreted code, =20
and I would like to git-blame to display a mix of local and upstream =20
history line-by-line in the code).
I have documented the steps to demonstrate my desired repository =20
layout in the attached shell script snippet. It is self-contained and =20
sets up two repositories upstream and main-repo in /tmp. It then reads =20
two branches featureA and featureB from upstream into separate paths =20
in main-repo.
Then, the script modifies contents in the upstream repository. There =20
are modifications that apply to both featureA and featureB as well as =20
modifications to one branch only.
Up to this point, things seemed to work well using either git-subtree =20
or a combination of git-read-tree and "subtree" merge strategy.
Finally, the changes to upstream are to be pulled into the =20
corresponding paths in main-repo. Here, neither git-subtree nor git =20
pull with subtree merge do what I want. The changes that apply to one =20
of the features only are applied correctly. However, changes from the =20
common history of featureA and featureB are only applied to the path =20
that is updated first.
Apparently, git records that the common change has been applied and =20
doesn't apply it a second time (which is correct for ~99.9999999% of =20
all use cases). In this special case however, git does not take into =20
account that it applied the common change to a different path.
I found that git pull --squash would apply the right set of updates to =20
both featureA and featureB in main-repo (i.e. in this case, the common =20
change would be applied on each path). However, this would leave me =20
unlinked to upstream history.
Now:
1) Am I doing something completely wrong, am I missing some important detail=
?
2) Am I asking for something impossible?
3) Is it expected behaviour, that --squash adds a different set of =20
text changes than a pull without squash?

Best,

Volkmar




--=20
Freiburg Brain Imaging
http://fbi.uniklinik-freiburg.de/
Tel. +761 270-54783
Fax. +761 270-54819


--=_50sq5ssw7vcw
Content-Type: application/x-shellscript;
	name="upstream-example.sh"
Content-Disposition: attachment;
	filename="upstream-example.sh"
Content-Transfer-Encoding: 7bit

# Layout
# upstream has master, featureA, featureB
# upstream/master corresponds to upstream
# MAIN_REPO imports featureA,featureB from upstream

# main repo
cd /tmp
MAIN_REPO=/tmp/main-repo
rm -rf ${MAIN_REPO}
git init ${MAIN_REPO}
cd ${MAIN_REPO}
git commit --allow-empty -m "Initial commit."

# upstream
PROXY_REPOS=/tmp/proxy-repos
rm -rf ${PROXY_REPOS}
mkdir ${PROXY_REPOS}
git init ${PROXY_REPOS}/upstream
cd ${PROXY_REPOS}/upstream
echo "Created in upstream/master" > upstream.txt
git add .
git commit -m "Created in upstream/master"
git checkout -b featureA
echo "Created in upstream/featureA" > featureA.txt
git add .
git commit -m "Created in upstream/featureA"
git checkout master
git checkout -b featureB
echo "Created in upstream/featureB" > featureB.txt
git add .
git commit -m "Created in upstream/featureB"
git checkout master

# set up subtree merges, including local tracking branches for upstream
cd ${MAIN_REPO}
git remote add -f upstream ${PROXY_REPOS}/upstream/.git -t featureA -t featureB
git branch -t local_upstream_featureA upstream/featureA
git merge -s ours --no-commit local_upstream_featureA
git read-tree --prefix=featureA/ -u local_upstream_featureA
git commit -m "read tree upstream/featureA"
git branch -t local_upstream_featureB upstream/featureB
git merge -s ours --no-commit local_upstream_featureB
git read-tree --prefix=featureB/ -u local_upstream_featureB
git commit -m "read tree upstream/featureB"

# create in upstream repo, local to featureA
cd ${PROXY_REPOS}/upstream
git checkout featureA
echo "Created in upstream/featureA" > featureAonly.txt
git add .
git commit -m "Created in upstream/featureA - update"

# create in upstream repo, local to featureB
cd ${PROXY_REPOS}/upstream
git checkout featureB
echo "Created in upstream/featureB" > featureBonly.txt
git add .
git commit -m "Created in upstream/featureB - update"

# Modify common file in upstream for both branches
cd ${PROXY_REPOS}/upstream
git checkout master
echo "Modified common file in upstream/master" >> upstream.txt
git add .
git commit -m "Modified common file in upstream/master"

# Merge changes from master into featureA
cd ${PROXY_REPOS}/upstream
git checkout featureA
git merge master -m "Merged master into featureA"

# Merge changes from master into featureB
cd ${PROXY_REPOS}/upstream
git checkout featureB
git merge master -m "Merged master into featureB"

# pull upstream/featureA and upstream/featureB
cd ${MAIN_REPO}
git checkout master
# without --squash, order matters. Only the first pull applies the change to 
# featureX/upstream.txt. The second pull does not modify featureY/upstream.txt
# as it should.
git pull -s recursive -X subtree=featureA upstream featureA # --squash
git pull -s recursive -X subtree=featureB upstream featureB # --squash


--=_50sq5ssw7vcw--
