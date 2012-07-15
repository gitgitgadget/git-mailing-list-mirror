From: Wincent Colaiuta <win@wincent.com>
Subject: Re: (Ab)using filter-branch from a post-receive hook
Date: Sat, 14 Jul 2012 22:50:02 -0700
Message-ID: <CEAB8F11-05A4-46B4-A0B5-B51B14EAD536@wincent.com>
References: <8D1AF968-AF34-4590-AB8F-E644C534A928@wincent.com> <7vipdp61fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v1278)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Jul 15 08:21:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SqIDO-0008Dx-6r
	for gcvg-git-2@plane.gmane.org; Sun, 15 Jul 2012 08:21:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750935Ab2GOGVP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 15 Jul 2012 02:21:15 -0400
Received: from outmail149113.authsmtp.com ([62.13.149.113]:63849 "EHLO
	outmail149113.authsmtp.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750807Ab2GOGVN convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 15 Jul 2012 02:21:13 -0400
X-Greylist: delayed 1861 seconds by postgrey-1.27 at vger.kernel.org; Sun, 15 Jul 2012 02:21:13 EDT
Received: from mail-c193.authsmtp.com (mail-c193.authsmtp.com [62.13.128.118])
	by punt5.authsmtp.com (8.14.2/8.14.2/Kp) with ESMTP id q6F5o9u4043782;
	Sun, 15 Jul 2012 06:50:09 +0100 (BST)
Received: from zenyatta.unixhosts.net (ec2-184-73-234-210.compute-1.amazonaws.com [184.73.234.210])
	(authenticated bits=128)
	by mail.authsmtp.com (8.14.2/8.14.2) with ESMTP id q6F5o6do056079
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Sun, 15 Jul 2012 06:50:07 +0100 (BST)
Received: from [192.168.1.131] (c-69-181-20-120.hsd1.ca.comcast.net [69.181.20.120])
	(authenticated bits=0)
	by zenyatta.unixhosts.net (8.14.2/8.14.2) with ESMTP id q6F5o3Tv013629
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Sun, 15 Jul 2012 01:50:05 -0400
In-Reply-To: <7vipdp61fp.fsf@alter.siamese.dyndns.org>
X-Mailer: Apple Mail (2.1278)
X-Server-Quench: ee8bec3e-ce40-11e1-97bb-002264978518
X-AuthReport-Spam: If SPAM / abuse - report it at: http://www.authsmtp.com/abuse
X-AuthRoute: OCd3ZggRAFZKTQIy FSICByJGVUMuIRha BAIHMQpCJFdJD0VH axsdDEdXdwdEHAsR A2ABXlReUFo/WGtx dQ1ScwdeZlRMXgV1 Uk1WQxwTEnNtXhpV WR4bVBl1fktHeX5y bQg3C3gJCRd5IFsu F0pUCGwHMGZ9YWdN Al1YdwFWdgdDeRdA a1gxNiYHcX12NGMl BA41MHg/PDFDJT4Q SBsEK1kSCUgRGTt0 TlgaGi4zWFcITCgy MRFuKlkbHy4A
X-Authentic-SMTP: 61633436303433.1014:706
X-AuthFastPath: 0 (Was 255)
X-AuthSMTP-Origin: 184.73.234.210/25
X-AuthVirus-Status: No virus detected - but ensure you scan with your own anti-virus system.
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201469>

On Jul 14, 2012, at 10:25 PM, Junio C Hamano wrote:

> Wincent Colaiuta <win@wincent.com> writes:
> 
>> Specifically, I was thinking of doing the following:
>> 
>> - on pushing into our authoritative repo, we replicate to a second
>> "scratch" repo where all the dirty work gets done
>> 
>> - the scratch repo has a master branch, and an initial "open" branch
>> created using `git filter-branch`
> 
> Who controls when "authoritative" to "scratch" transfer happens?
> Using post-receive-hook in "authoritative" sounds like a sensible
> way to do this.
> 
>> - a post-receive hook in the scratch repo, given a series of commits
>> A..B on the master branch, cherry-picks them onto the "open" branch,
>> producing commits A'..B'
> 
> Are there mechanisms to add commits to the "scratch" repository
> other than the one that relays the changes from "authoritative"?  If
> so, post-receive in "scratch" may be inevitable, but otherwise, I do
> not know why you need this processing triggered by the post-receive
> in the scratch.  Wouldn't it suffice to make the post-receive in the
> "authoritative" do all of these?
> 
> I did not see anything wrong doing what you described in the
> post-receive, even though having the hook in the "scratch" felt
> strange, as the "copying from authoritative" would also want to be
> automated and the natural triggering mechanism to do so would be a
> post-receive there.  What issues were you worried about?

The part that I left out, to keep things simple, is that our actual repository structure is the following:

- developers work in their local clones and push to Gerrit (for code review)

- commits which pass code review get merged by Gerrit, and auto-replicated to a couple of places (specifically, an upstream repo in our colo for deployment purposes, and a private GitHub repo, for redundancy)

Gerrit has its own embedded Java-powered Git daemon, but it doesn't support post-receive hooks like the native Git daemon does, so in order to run arbitrary code like we'd need to, we have to tell Gerrit to replicate into some other (non-Gerrit) repo which is capable of running the hook. This was the "scratch" repo that I described above, and I was thinking of putting it on the same machine as Gerrit with a "file" URL and an appropriately configured receivepack property as suggested here by Shawn Pearce[1].

(Gerrit _does_ have its own hook system[2], but I'd feel more comfortable writing this using a standard hook, as I think the code will be more straightforward, and it won't couple us any more tightly to Gerrit than we already are.)

Cheers,
Wincent

[1] http://code.google.com/p/gerrit/issues/detail?id=383#c2
[2] http://gerrit.googlecode.com/svn/documentation/2.2.0/config-hooks.html#_change_merged
