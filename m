From: Max Horn <max@quendi.de>
Subject: Re: How to combine git repos with similar code and keep all branches and tags?
Date: Tue, 14 Apr 2015 19:14:36 +0200
Message-ID: <13B30361-1BCD-4481-A33B-E5C65C8169F9@quendi.de>
References: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: "git@vger.kernel.org" <git@vger.kernel.org>
To: Jose de Leon <jdeleon@ensim.com>
X-From: git-owner@vger.kernel.org Tue Apr 14 19:31:37 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Yi4gT-0002z0-4C
	for gcvg-git-2@plane.gmane.org; Tue, 14 Apr 2015 19:31:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933143AbbDNRbc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Apr 2015 13:31:32 -0400
Received: from merkurneu.hrz.uni-giessen.de ([134.176.2.3]:47248 "EHLO
	merkurneu.hrz.uni-giessen.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S964779AbbDNR34 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Apr 2015 13:29:56 -0400
X-Greylist: delayed 902 seconds by postgrey-1.27 at vger.kernel.org; Tue, 14 Apr 2015 13:29:56 EDT
Received: from [134.176.4.18] by merkurneu.hrz.uni-giessen.de with ESMTP; Tue, 14 Apr 2015 19:14:41 +0200
Received: from hermes.hrz.uni-giessen.de (hermes.hrz.uni-giessen.de [134.176.2.15])
	by mailgw32.hrz.uni-giessen.de (Postfix) with ESMTP id A033DEDACA37;
	Tue, 14 Apr 2015 19:14:35 +0200 (CEST)
Received: from [134.176.2.15] by hermes.hrz.uni-giessen.de with ESMTP; Tue, 14 Apr 2015 19:14:35 +0200
In-Reply-To: <BBAA9EAE77388248BCAB045DA762C5A83EFE242F@EXBE01-ENSIM.ms.ensim.com>
X-Mailer: Apple Mail (2.1510)
X-HRZ-JLUG-MailScanner-Information: Passed JLUG virus check
X-HRZ-JLUG-MailScanner: No virus found
X-Envelope-From: max@quendi.de
X-Spam-Status: No
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267153>

Hi Jose,

On 14.04.2015, at 18:44, Jose de Leon <jdeleon@ensim.com> wrote:

> Hi All,
> 
> 
> I've got an interesting problem and the possible solutions I've found from searching google don't seem to work for us.  In a nutshell, I need to combine multiple git repositories into single repository and preserve all history, branches and tags from each repository.    
> 
> Does anybody have a solution for this, how do this kind of thing, is it even possible?
> 
> For some unknown reason to me, our developers started a git project, called Ver1, this was the first version.  Then sometime later, they created a new git repository called Ver2, the initial commit for Ver2 was essentially a copy of the code in Ver1 from the master.  They didn't clone it, they just copied the code at the latest point.  This wasn't done by forking.  Then they repeated this for Ver3 and Ver4, etc.  On top of all that, they have been adding new code to Ver1, Ver2, etc. that has caused each to divert from the other and each have their own branch and tag sets.  They have similar directory structure and similar file names, but there are some slight differences in structure.
> 
> Well, this has become unmanageable and now we want to combine them into one single git repository.   
> 
> Logically, these are the same project but at different versions, basically, Ver1 and Ver2, etc, should be simply branches at different times if these were combined into a single repository.

Here is one possible way to go about this using grafts (I used something
similar in the past);

1) Get all the data into a single git repository.

  Since everything is already in a git repositories, you could e.g. create a
  clone of Ver1; then add remotes for Ver2 ... VerN, and fetch them all,
  along with tags. If there are conflicts between branch or tag names, deal
  with them at this point.

2) Create graft points to tie the history together.

   Identify the commit in Ver1 at which Ver2 branched off. Then, graft that
   as parent for the initial commits of Ver2. See here for some basic
   instructions <https://git.wiki.kernel.org/index.php/GraftPoint> or feel
   free to ask for details (or Google, or... :)

   Repeat vor Ver2+Ver3, Ver3+Ver4, etc.

3) Finally, you can get rid of the graft points, and turn everything into a
"proper" history, by running "git filter-branch". Something like

  git filter-branch -- --all

ought to do it, but I might be forgetting something (I am sure somebody will
correct me soon in that case, though ;-). Best to have a look at
<http://git-scm.com/docs/git-filter-branch> for yourself, though.


This all is under the assumption that you want to stay as close to how
things really were (usually a good idea). But sometimes it may be desirable
to make further adjustments. E.g. you may wish to adjust committer names,
rearrange some stuff (though usually git is quite good at doing the right
thing automatically, etc. How to do that of course depends on what exactly
you want to do, but in many cases, filter-branch is your friend.

Hope that helps!

Max
