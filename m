From: Johan Herland <johan@herland.net>
Subject: Re: Merge into locally modified files?
Date: Mon, 8 Jun 2009 20:22:09 +0200
Message-ID: <200906082022.09936.johan@herland.net>
References: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="utf-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: skillzero@gmail.com
X-From: git-owner@vger.kernel.org Mon Jun 08 20:22:32 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MDjUN-000550-6f
	for gcvg-git-2@gmane.org; Mon, 08 Jun 2009 20:22:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751296AbZFHSWW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 8 Jun 2009 14:22:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750727AbZFHSWV
	(ORCPT <rfc822;git-outgoing>); Mon, 8 Jun 2009 14:22:21 -0400
Received: from sam.opera.com ([213.236.208.81]:36866 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750698AbZFHSWU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 8 Jun 2009 14:22:20 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n58IMCH7024498
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Mon, 8 Jun 2009 18:22:18 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <2729632a0906081030k5048cb27p6950a0decaa7396a@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/121095>

On Monday 08 June 2009, skillzero@gmail.com wrote:
> If I have some local changes to a file that I don't want to commit
> (e.g. temp debug changes like printf's) and I see somebody else has
> pushed some changes to that file, how do I merge their changes to the
> file while trying to preserve my local changes (and conflicting if
> it's not possible)?
>
> After a git fetch, I tried 'git checkout --merge origin/master <path
> to my locally modified file>', but that just overwrote my local
> changes.
>
> I'm converting people from CVS to git and this is a common thing
> people do with CVS. They have some local changes and see that the
> server has some other changes so they do 'cvs up' and it tries to
> merge changes from the server into the locally modified file. The
> local changes are often things that will never be committed. I know
> git tries to avoid things you can't undo, but like a 'git checkout
> <file>' that can't be undone, is there a way to say "merge what you
> can and generate conflict markers for things you can't?".
>
> I think what I want to do is the equivalent of rebasing for local
> modified files rather than committed files.

Being a CVS convert myself, I know this may be difficult to grasp when 
coming from CVS. Here's the deal: In the scenario you describe above, 
CVS forces you to merge your local modifications with the updates from 
the server. Thus, if/when you commit your changes, they will no longer 
be your changes only, but they will also contain whatever you did to 
resolve the conflicts. (This is also know as "merge-before-commit".)

Git, instead encourages you to commit your changes _first_ 
(aka. "commit-before-merge"), so that your changes are not necessarily 
affected by the updated changes from the server. By committing your 
changes first, you can choose at a later date whether to _merge_ your 
changes into the updates from the server (in a separate merge commit), 
or whether to _rebase_ your changes on top of the updates from the 
server (as if you made your changes after the update, and not before 
the update).

In this scenario, since you have not published your changes, it makes 
sense to rebase them on top of the updates from the server. In other 
words, what you should do is first "git commit" your changes, and 
then "git fetch" and "git rebase origin/master". (You can also use "git 
pull --rebase" instead of the last two commands.)

Now, since you probably don't want to push your changes (debug printfs 
etc.), you should probably put them on a separate branch, so that they 
are not automatically part of your next "git push". If you have already 
committed them to you local "master" branch, you can do the following:

	git checkout -b debug  # Create and switch to a new branch "debug"
	git branch -f master HEAD^ # Reset "master" to the previous commit

Your "master" is now back "in sync" with the server, and you have a 
debug branch which contains your debug printfs. Now, when you make 
further changes, you can choose whether to put them on "master" 
or "debug".  With a default push configuration, "git push" will now 
push "master", but not "debug", so your debug printfs will stay in your 
local repo. Note that if you still need the debug printfs after there 
are more commits on "master", you will have to

	git checkout debug
	git rebase master

to put your debug printfs back on top of the "master" branch.


BTW, I find it very helpful to use gitk to visualize the commit history 
before and after each of these commands, so that I get a "natural" feel 
for how each command operates on the commit graph.


Have fun! :)

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
