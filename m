From: Eran Tromer <git2eran@tromer.org>
Subject: Re: question about git-submodule
Date: Fri, 03 Aug 2007 19:01:38 -0400
Message-ID: <46B3B3D2.6030000@tromer.org>
References: <20070713214630.GB7106@genesis.frugalware.org> <20070715083959.GC999MdfPADPa@greensroom.kotnet.org> <20070715104712.GF2568@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: skimo@liacs.nl, VMiklos <vmiklos@frugalware.org>,
	git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Sat Aug 04 01:47:27 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IH6re-00067r-Us
	for gcvg-git@gmane.org; Sat, 04 Aug 2007 01:47:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758807AbXHCXrY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 3 Aug 2007 19:47:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752269AbXHCXrY
	(ORCPT <rfc822;git-outgoing>); Fri, 3 Aug 2007 19:47:24 -0400
Received: from rozz.csail.mit.edu ([128.30.2.16]:50113 "EHLO
	rozz.csail.mit.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751417AbXHCXrX (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Aug 2007 19:47:23 -0400
X-Greylist: delayed 2727 seconds by postgrey-1.27 at vger.kernel.org; Fri, 03 Aug 2007 19:47:23 EDT
Received: from [128.30.48.144] (helo=moby.tromer.org)
	by rozz.csail.mit.edu with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63)
	(envelope-from <git2eran@tromer.org>)
	id 1IH69O-00063p-AS; Fri, 03 Aug 2007 19:01:42 -0400
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.5) Gecko/20070719 Fedora/2.0.0.5-1.fc7 Thunderbird/2.0.0.5 Mnenhy/0.7.5.0
In-Reply-To: <20070715104712.GF2568@steel.home>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/54773>

On 2007-07-15 06:47, Alex Riesen wrote:
> Sven Verdoolaege, Sun, Jul 15, 2007 10:39:59 +0200:
>> On Fri, Jul 13, 2007 at 11:46:30PM +0200, VMiklos wrote:
>>> i mean, first i thought that after configuring a submodule under libfoo,
>>> then a git pull will update libfoo's repo under libfoo, too. or
>>> something like that.
>> Unless I've missed something, it doesn't.
>> Some of use would like git to do just that (at least Alex Riesen,
>> Martin Waitz and myself have sent in patches to that effect),
>> but we haven't been able to convince Junio yet.
> 
> Count me out. Junio convinced me instead and having tried the
> subprojects I find it really convenient: I can choose when and what
> should be updated and I can see what _can_ be updated, iff I decide
> to. Subprojects defined in such a loosely way are more flexible then
> having git-pull fetch subprojects by default. Sometimes I even want be
> _sure_ the subprojects are completely untouched (I have some critical
> parts in them).

All of the above also applies to normal files, not just submodules. So
by this logic, maybe "git pull" and "git checkout" should by default
update just the index, and require a manual "git file update" to update
the files in the working tree?

Leaving the working tree (including submodules) in an inconsistent state
right after a pull or checkout is a very strange thing to do. It means,
for example, that even simple switching between branches doesn't work in
a superproject. Consider this example (tested on next aac97aacbccd):

--------------------------------------------------
Create the subproject repo:

$ mkdir sub-to-be
$ cd sub-to-be
$ git init
$ echo AAA > foo
$ git add foo
$ git commit -m sub
$ cd ..

Create the superproject repo and clone subproject into it:

$ mkdir super
$ cd super
$ git init
$ git submodule add ../sub-to-be sub
$ git commit -m super

Update the submodule:

$ cd sub
$ echo BBB > foo
$ git add foo
$ git commit -m sub
$ cd ..

Update the supermodule:

$ git add sub
$ git commit -m super

Try to switch between versions, and fail miserably:

$ git checkout -b old HEAD^
M       sub
Switched to a new branch "old"
$ git checkout master
fatal: Entry 'sub' not uptodate. Cannot merge.
--------------------------------------------------

BTW, is there any easy way to create a submodule directly inside the
supermodule's working tree, instead of cloning it as in the above example?

  Eran
