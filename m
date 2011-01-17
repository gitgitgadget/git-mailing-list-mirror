From: Stephen Kelly <steveire@gmail.com>
Subject: Creating remote branch called HEAD corrupts remote clones
Date: Mon, 17 Jan 2011 11:02:49 +0100
Message-ID: <ih1449$ul6$1@dough.gmane.org>
Reply-To: KDE PIM <kde-pim@kde.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: kde-pim@kde.org
X-From: kde-pim-bounces-+kde-kde-pim=m.gmane.org@kde.org Mon Jan 17 11:04:28 2011
Return-path: <kde-pim-bounces-+kde-kde-pim=m.gmane.org@kde.org>
Envelope-to: kde-kde-pim@lo.gmane.org
Received: from ktown.kde.org ([131.246.120.250])
	by lo.gmane.org with smtp (Exim 4.69)
	(envelope-from <kde-pim-bounces-+kde-kde-pim=m.gmane.org@kde.org>)
	id 1Pelwl-0005bn-Mm
	for kde-kde-pim@lo.gmane.org; Mon, 17 Jan 2011 11:04:23 +0100
Received: (qmail 23083 invoked by uid 72); 17 Jan 2011 10:04:15 -0000
Received: (qmail 23073 invoked from network); 17 Jan 2011 10:04:12 -0000
X-Spam-Checker-Version: SpamAssassin 3.2.5 (2008-06-10) on ktown.kde.org
Received: from unknown (HELO lo.gmane.org) (80.91.229.12)
	by ktown.kde.org with SMTP; 17 Jan 2011 10:04:12 -0000
Received: from list by lo.gmane.org with local (Exim 4.69)
	(envelope-from <kde-kde-pim@m.gmane.org>) id 1Pelvn-0004vw-7d
	for kde-pim@kde.org; Mon, 17 Jan 2011 11:03:23 +0100
Received: from 188.111.54.34 ([188.111.54.34])
	by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kde-pim@kde.org>; Mon, 17 Jan 2011 11:03:23 +0100
Received: from steveire by 188.111.54.34 with local (Gmexim 0.1 (Debian))
	id 1AlnuQ-0007hv-00
	for <kde-pim@kde.org>; Mon, 17 Jan 2011 11:03:23 +0100
X-Injected-Via-Gmane: http://gmane.org/
Followup-To: gmane.comp.version-control.git
X-Complaints-To: usenet@dough.gmane.org
X-Gmane-NNTP-Posting-Host: 188.111.54.34
User-Agent: KNode/4.4.6
X-BeenThere: kde-pim@kde.org
X-Mailman-Version: 2.1.9
Precedence: list
List-Id: KDE PIM <kde-pim.kde.org>
List-Unsubscribe: <https://mail.kde.org/mailman/listinfo/kde-pim>,
	<mailto:kde-pim-request@kde.org?subject=unsubscribe>
List-Post: <mailto:kde-pim@kde.org>
List-Help: <mailto:kde-pim-request@kde.org?subject=help>
List-Subscribe: <https://mail.kde.org/mailman/listinfo/kde-pim>,
	<mailto:kde-pim-request@kde.org?subject=subscribe>
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/165171>


Hi,

On Friday we had an issue where a developer pushed a branch called HEAD to 
the remote server. The result was that other developers could not pull or 
push. I have not been able to reproduce the exact issue locally, but this 
script shows that the bob clone behaves oddly on each pull. That is a 
symptom we saw on Friday. However, bob is still able to push, which we were 
not able to. That point could be something to do with how the kde git 
infrastructure is configured.

mkdir remote
cd remote/
git init --bare
cd ../
git clone remote/ alice
cd alice/
echo test >> file
git add file
git commit -am w
git push origin master
echo test >> file
git commit -am w
git branch HEAD
git push origin HEAD
git push
cd ..
git clone remote bob
cd bob/
git pull --rebase
echo test >> file
git commit -am w
git push
git pull
git pull
git pull

There were also messages like this:

$ git pull
remote: Counting objects: 5, done.
remote: Total 3 (delta 0), reused 0 (delta 0)
Unpacking objects: 100% (3/3), done.
From /home/kde-devel/dev/src/playground/git/tmp/remote
 + 1434cd2...dd30974 HEAD       -> origin/HEAD  (forced update)
error: Ref refs/remotes/origin/master is at 
dd3097498a6c1c5bc73ad1f2ff3b7969a6f6d059 but expected 
1434cd2bb9823d2d2b1548c75fdd4ff8b1feddc1
 ! 1434cd2..2fb560d  master     -> origin/master  (unable to update local 
ref)

The HEAD branch was created accidentally and the issue was resolved by doing 
a git push origin -f :refs/heads/HEAD. Again though, git push -f is not 
something all developers are allowed to do on the kde git infrastructure, so 
until that was done, the repo was corrupt for everyone.

Shouldn't git forbit the creation of a branch called HEAD? Hopefully the 
provided script can lead to the actual issue that caused the corruption of 
our repo.

Thanks,

Steve.


_______________________________________________
KDE PIM mailing list kde-pim@kde.org
https://mail.kde.org/mailman/listinfo/kde-pim
KDE PIM home page at http://pim.kde.org/
