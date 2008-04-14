From: Sergio Callegari <sergio.callegari@gmail.com>
Subject: Re: Interaction between clean/smudge and git status
Date: Mon, 14 Apr 2008 08:18:32 +0000 (UTC)
Message-ID: <loom.20080414T074356-925@post.gmane.org>
References: <loom.20080413T231611-113@post.gmane.org> <4802FE3C.4090306@viscovery.net> <7vej98apdo.fsf@gitster.siamese.dyndns.org> <loom.20080414T072615-85@post.gmane.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Mon Apr 14 10:19:39 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlJua-0003IM-Jm
	for gcvg-git-2@gmane.org; Mon, 14 Apr 2008 10:19:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754225AbYDNISo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 14 Apr 2008 04:18:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754815AbYDNISo
	(ORCPT <rfc822;git-outgoing>); Mon, 14 Apr 2008 04:18:44 -0400
Received: from main.gmane.org ([80.91.229.2]:47022 "EHLO ciao.gmane.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754225AbYDNISn (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 14 Apr 2008 04:18:43 -0400
Received: from list by ciao.gmane.org with local (Exim 4.43)
	id 1JlJte-0006h9-Ej
	for git@vger.kernel.org; Mon, 14 Apr 2008 08:18:38 +0000
Received: from host40-61-dynamic.6-87-r.retail.telecomitalia.it ([87.6.61.40])
        by main.gmane.org with esmtp (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 08:18:38 +0000
Received: from sergio.callegari by host40-61-dynamic.6-87-r.retail.telecomitalia.it with local (Gmexim 0.1 (Debian))
        id 1AlnuQ-0007hv-00
        for <git@vger.kernel.org>; Mon, 14 Apr 2008 08:18:38 +0000
X-Injected-Via-Gmane: http://gmane.org/
X-Complaints-To: usenet@ger.gmane.org
X-Gmane-NNTP-Posting-Host: main.gmane.org
User-Agent: Loom/3.14 (http://gmane.org/)
X-Loom-IP: 87.6.61.40 (Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.8.1.13) Gecko/20080325 Ubuntu/7.10 (gutsy) Firefox/2.0.0.13)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79490>

Sergio Callegari <scallegari <at> arces.unibo.it> writes:

> 
> Junio C Hamano <gitster <at> pobox.com> writes:
> 
> 
> > Are you recreating the .zip file in the filter in such a way that a file
> > with the same contents results in byte-to-byte identical .zip file?
> > Otherwise as far as git is concerned you have changed the file in the work
> > tree.
> 
> And here you are right!!!
> I thought that re-zip script was repeatable in behaviour, but it is not
> (probably because things like file dates change when files are unpacked in the
> temporary dir and dates get stored).
> 
> I absolutely overlooked that.
> 

OK, here is a testcase too...

mkdir TEST
git init
# create zip file x.zip
git add x.zip
git commit

In this git commit the clean filter runs.

rm x.zip

git checkout x.zip

or 

git reset --hard

In this checkout the smudge filter runs

git status

It says that x.zip is changed

And yes, in some sense it is changed, because it is a different file than the
one I had before the check in. But no, in some other sense it is not changed,
because it is the file that I have just checked out (it has not been touched
after the checkout).

Not that if I had only the clean filter and not the smudge one, then the same
would have happened. 


So I think that I see your point: if the clean/smudge filters always provide the
same output independently from when they are run, then I get the message about
the changed file at most once, when I check in for the first time the "cleaned"
file.  

And this behaviour makes sense: to say that nothing has changed, git wants
things to be identical.  However it is a bit counterintuitive, because one would
think that something that has just been freshly checked out should not be
considered as changed anyway.

I wonder if this comes from the fact that when git status is run, git compares
the workdir file with the index and the index contains information on the file
as it was before the last checkin.  When filters exist, wouldn't it make sense
to have the index hold information on the files as they are after the checkout?

Sergio 
