From: Phillip Susi <psusi@cfl.rr.com>
Subject: Re: clone breaks replace
Date: Fri, 07 Jan 2011 16:44:16 -0500
Message-ID: <4D278930.7010100@cfl.rr.com>
References: <4D262D68.2050804@cfl.rr.com> <20110106213338.GA15325@burratino> <4D276CD2.60607@cfl.rr.com> <20110107205103.GC4629@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Christian Couder <chriscool@tuxfamily.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 07 22:40:24 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbK2q-0000TM-5x
	for gcvg-git-2@lo.gmane.org; Fri, 07 Jan 2011 22:40:24 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753560Ab1AGVkT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 16:40:19 -0500
Received: from cdptpa-omtalb.mail.rr.com ([75.180.132.122]:46785 "EHLO
	cdptpa-omtalb.mail.rr.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752425Ab1AGVkS (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 16:40:18 -0500
Authentication-Results: cdptpa-omtalb.mail.rr.com smtp.user=psusi@cfl.rr.com; auth=pass (PLAIN)
X-Authority-Analysis: v=1.1 cv=3jtQBdTzPyV+fq4oCU/u8ZPrJJGN11HvhaDVxyWhycI= c=1 sm=0 a=8nJEP1OIZ-IA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:17 a=-46LHPIRqy7Bs_2nh1gA:9 a=ZyR1Xt_dnByDvIRKrAABNWH6ceYA:4 a=wPNLvfGTeEIA:10 a=pg4Dpxby4z7sZisWVyJ9NA==:117
X-Cloudmark-Score: 0
X-Originating-IP: 72.242.190.170
Received: from [72.242.190.170] ([72.242.190.170:3335] helo=[10.1.1.235])
	by cdptpa-oedge02.mail.rr.com (envelope-from <psusi@cfl.rr.com>)
	(ecelerity 2.2.3.46 r()) with ESMTPA
	id BE/2D-02631-408872D4; Fri, 07 Jan 2011 21:39:17 +0000
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; en-US; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <20110107205103.GC4629@burratino>
X-Enigmail-Version: 1.1.1
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164766>

On 1/7/2011 3:51 PM, Jonathan Nieder wrote:
> Phillip Susi wrote:
> 
>> Isn't the whole purpose of using replace to avoid having to use
>> filter-branch, which throws out all of the existing commit records, and
>> creates an entirely new commit chain that is slightly modified?
> 
> No.  What documentation suggested that?  Maybe it can be fixed.

It's just what made sense to me.  If you can modify the history with
filter-branch, then you don't need replace refs.  The downside to
filter-branch is that it breaks people tracking your repository, since
the history they had been tracking is thrown out and replaced with a
completely new commit chain that looks similar, but as far as git is
concerned, is unrelated to the original.  Replace refs seem to have been
created to allow you to accomplish the goal of modifying an old commit
record, but without having to rewrite that and all subsequent commits,
causing breakage.

>  - can choose to fetch or not fetch with the usual
>    "git fetch repo refs/replace/*:refs/replace/*" syntax

It seems like this should be the default behavior.  Or perhaps
refs/replace should be forked into one meant to be private, and one
meant to be public, and fetched by default.  Or maybe it should be
fetched by default, but not pushed, so you have to explicitly push
replacements to the public mirror that you intend for public
consumption.  Having the replace only apply locally and still needing to
filter-branch to make the change visible to the public seems to render
the replace somewhat pointless.

Take the kernel history as an example, only imagine that Linus did not
originally make that first commit leaving out the prior history, but
wants to go back and fix it now.  He can do it with a replace, but then
if he runs filter-branch as you suggest to make the change 'real', then
everyone tracking his tree will fail the next time they try to pull.
You could get the same result without replace, so why bother?

If the replace was fetched by default, the people already tracking would
get it the next time they pull and would not have a problem.  If they
wanted to see the old history, then they would already have it in the
repository and just need to add --no-replace-objects to see it, or run
git log on the original commit id that the replace record should refer
you to ( in the comments ).  Those cloning the repository for the first
time would get it, and avoid fetching all of the old history since they
would be using the replace record in place of the original commit.
