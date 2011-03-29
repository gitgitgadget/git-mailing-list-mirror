From: Hallvard B Furuseth <h.b.furuseth@usit.uio.no>
Subject: denyNonFastForwards & co fail outside refs/<heads,tags>
Date: Tue, 29 Mar 2011 13:54:00 +0200
Message-ID: <hbf.20110329j1zo@bombur.uio.no>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Mar 29 13:54:11 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q4XUw-0000il-Bk
	for gcvg-git-2@lo.gmane.org; Tue, 29 Mar 2011 13:54:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752736Ab1C2LyE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Mar 2011 07:54:04 -0400
Received: from mail-out2.uio.no ([129.240.10.58]:52208 "EHLO mail-out2.uio.no"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752504Ab1C2LyD (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Mar 2011 07:54:03 -0400
Received: from mail-mx5.uio.no ([129.240.10.46])
	by mail-out2.uio.no with esmtp (Exim 4.74)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q4XUm-0000WU-LA
	for git@vger.kernel.org; Tue, 29 Mar 2011 13:54:00 +0200
Received: from bombur.uio.no ([129.240.6.233])
	by mail-mx5.uio.no with esmtp  (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q4XUm-0000nm-5a; Tue, 29 Mar 2011 13:54:00 +0200
Received: from hbf by bombur.uio.no with local (Exim 4.72)
	(envelope-from <hbf@ulrik.uio.no>)
	id 1Q4XUm-0003in-3q; Tue, 29 Mar 2011 13:54:00 +0200
X-UiO-Ratelimit-Test: rcpts/h 5 msgs/h 2 sum rcpts/h 6 sum msgs/h 2 total rcpts 1133 max rcpts/h 17 ratelimit 0
X-UiO-Spam-info: not spam, SpamAssassin (score=-5.0, required=5.0, autolearn=disabled, T_RP_MATCHES_RCVD=-0.01,UIO_MAIL_IS_INTERNAL=-5, uiobl=NO, uiouri=NO)
X-UiO-Scanned: 79C2C40D60E45EBA44C4446EE1834F8F15BA89EE
X-UiO-SPAM-Test: remote_host: 129.240.6.233 spam_score: -49 maxlevel 80 minaction 1 bait 0 mail/h: 2 total 481 max/h 5 blacklist 0 greylist 0 ratelimit 0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170257>

config options receive.<denyNonFastForward, denyDeletes> do not work in
nonstandard ref namespaces.  I stumbled over it in refs/notes/, but the
problem is general.  Or if it this intentional, it is the git-config(1)
doc of these options which needs fixing.

Git version 1.7.4.2.


To reproduce:

########################################################################
#!/bin/sh
rm -rf hi ho

git --version

# Create initial repos
git init -q hi
(cd hi
    git config receive.denyDeletes         true
    git config receive.denyNonFastForwards true
    echo foo > foo && git add foo && git commit -q -m first foo)
git clone -q hi ho

# Make them diverge, except the checked-out branch
for r in hi ho; do
    (cd $r
	echo $r >> foo && git commit -q -m next foo
	git update-ref refs/outside/test HEAD
	git checkout -q -b br HEAD^
	# Shut up a bit
	git config advice.pushNonFastForward false
	git gc --quiet
	# For ssh push
	git update-server-info)
done

cd ho
# Optional; makes no difference
#git config remote.origin.pushurl localhost:`pwd`/../hi

# Can push test despite 'deny's, fails as expeceted for master:
for b in refs/outside/test refs/heads/master; do
    git push -f origin $b:$b
    git push -f origin   :$b
    echo ""
done
# Just to check: Pushing the master normal way fails the same way.
git push -f origin


########################################################################
Output:

git version 1.7.4.2
To /tmp/hi
 + 1bb5836...5bf63f8 refs/outside/test -> refs/outside/test (forced update)
To /tmp/hi
 - [deleted]         refs/outside/test

remote: error: denying non-fast-forward refs/heads/master (you should pull first)        
To /tmp/hi
 ! [remote rejected] master -> master (non-fast-forward)
error: failed to push some refs to '/tmp/hi'
remote: error: denying ref deletion for refs/heads/master        
To /tmp/hi
 ! [remote rejected] master (deletion prohibited)
error: failed to push some refs to '/tmp/hi'

remote: error: denying non-fast-forward refs/heads/master (you should pull first)        
To /tmp/hi
 ! [remote rejected] master -> master (non-fast-forward)
error: failed to push some refs to '/tmp/hi'

-- 
Hallvard
