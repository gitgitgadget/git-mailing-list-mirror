From: Johan Herland <johan@herland.net>
Subject: Re: git submodule update --merge (Was: What's cooking in git.git (May 2009, #02; Sun, 17))
Date: Tue, 19 May 2009 15:26:40 +0200
Message-ID: <200905191526.40471.johan@herland.net>
References: <7vab5ci281.fsf@alter.siamese.dyndns.org> <200905191045.39108.johan@herland.net> <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	markus.heidelberg@web.de, Peter Hutterer <peter.hutterer@who-t.net>
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue May 19 15:27:25 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M6PLl-00038B-EN
	for gcvg-git-2@gmane.org; Tue, 19 May 2009 15:27:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752952AbZESN1L (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 19 May 2009 09:27:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752372AbZESN1L
	(ORCPT <rfc822;git-outgoing>); Tue, 19 May 2009 09:27:11 -0400
Received: from sam.opera.com ([213.236.208.81]:57068 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750849AbZESN1K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 19 May 2009 09:27:10 -0400
Received: from pc107.coreteam.oslo.opera.com (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.13.4/8.13.4/Debian-3sarge3) with ESMTP id n4JDQgSm013324
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Tue, 19 May 2009 13:26:43 GMT
User-Agent: KMail/1.9.9
In-Reply-To: <alpine.DEB.1.00.0905191348460.4266@intel-tinevez-2-302>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119524>

On Tuesday 19 May 2009, Johannes Schindelin wrote:
> On Tue, 19 May 2009, Johan Herland wrote:
> > On Tuesday 19 May 2009, Johannes Schindelin wrote:
> > > On Tue, 19 May 2009, Johan Herland wrote:
> > > > [git submodule update --merge]
> > >
> > > We have a _lot_ of obscure things that are not supported by core
> > > Git, but are _very_ easy to add as _tiny_ add-on scripts by the
> > > user, without the need for "official" feature support.
> > >
> > > Just like this one
> >
> > Does that mean you're also opposed to 'git submodule update
> > --rebase' (which is already in 'next', and is even Signed-off-by
> > yourself)?
>
> No, because -- as I said myself already a couple of times -- I can
> see this supporting a common workflow.
>
> > I still don't see any reason why one should be added (--rebase),
> > and not the other (--merge).
>
> When you rebase, you see your personal stuff (i.e. stuff that you do
> not want to submit, or not in its current form, or that you submitted
> and it waits for inclusion) on top of things right away.

But if there are developers downstream whose work is based on your 
submodule branch, the rebase will disrupt _their_ work, in the same way 
that rebasing any other public branch would disrupt people's work.

> In contrast, if you merge, you will have a different state from the
> upstream _forever_.  Even if your stuff gets included.

Correct, but there are cases where reconciliation with the upstream repo 
is less important than not disrupting downstream developers (see 
below).

> Needless to say, I do not see much use for the latter case, but tons
> for the former.

I fully agree that for a regular downstream (or "leaf") developer, there 
is not much use for git submodule rebase --merge.

But not all developers fit nicely into your scenario above. Please 
consider the following scenario (loosely based on the setup at my 
$dayjob):

1. There is a collection of "core" repositories that provide common 
platform-independent functionality that is useful to several projects.

2. There is a group of "core" developers that work directly on 
the "core" repos in #1. These developers are not much concerned with 
submodule functionality at all.

3. There are multiple projects that each have their own project 
super-repo, which contains a set of submodules. Most of these 
submodules are clones of the "core" repos in #1.

4. Each project has a group of developers that work on that project. 
These developers clone the project super-repo in #3, and do their work, 
both directly in the super-repo, and within the submodules. Their 
changes (both in the super-repo and its submodules), are pushed back 
into the shared project repos (i.e. the project super-repo, and the 
project's clones of the "core" repos). The project developers will 
typically use "git submodule update --rebase" to keep their own 
unfinished changes on top of submodule updates.

5. Finally, there is the last group of developers, in between the two 
other groups - call them "branch managers" or "integration developers". 
These developers are responsible for synchronizing the work done by the 
downstream project developers (#4) and the work done by the 
upstream "core" developers (#2):

a) Some of the changes done by the project developers are useful to 
_all_ projects using that "core" module, and are sent as patches to 
the "core" developers for inclusion upstream.

b) Some changes are NOT useful to the upstream project, and are kept on 
the project-specific branch of the submodule.

Now, consider what happens when a new version of a "core" module (#1) is 
released/published: The new version contains general improvements to 
that module, and all projects that use the module should upgrade to the 
new version. The integration developers (#5) for a given project is 
responsible for this upgrade. How are they going to do the upgrade 
without disrupting the work of the project developers (#4)?

- They obviously cannot use the default "git submodule update", since 
that would lose all project-specific changes (see b), and it would also 
disrupt the downstream project developers.

- Using "git submodule update --rebase" is certainly better (they don't 
lose the project-specific changes), but they still rebase the project 
branch (which disrupts the downstream project developers).

Therefore, the straightforward solution is to merge the new upstream 
version into the existing project branch. This preserves the 
project-specific changes, AND it does not disrupt the downstream 
developers.

Hence, support for "git submodule update --merge" is a very welcome 
feature for these integration developers.


I understand that the above scenario is not common in the free software 
world, but I believe it is much more common in an enterprise/company 
setting. Therefore, the support of such workflows is important to 
companies that are currently considering (or have already chosen) Git. 
I believe there is value in supporting such workflows, especially when 
doing so is as straightforward as my patch shows.


Thanks for your attention,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
