From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: remote tracking branch deletion problem
Date: Fri, 19 Dec 2008 15:56:55 +0100
Message-ID: <494BB637.3070304@drmicha.warpmail.net>
References: <200812191257.18678.thomas.jarosch@intra2net.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Thomas Jarosch <thomas.jarosch@intra2net.com>
X-From: git-owner@vger.kernel.org Fri Dec 19 15:58:28 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LDgo6-00063O-7B
	for gcvg-git-2@gmane.org; Fri, 19 Dec 2008 15:58:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750961AbYLSO5A (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Dec 2008 09:57:00 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750963AbYLSO5A
	(ORCPT <rfc822;git-outgoing>); Fri, 19 Dec 2008 09:57:00 -0500
Received: from out1.smtp.messagingengine.com ([66.111.4.25]:48439 "EHLO
	out1.smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750957AbYLSO47 (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 19 Dec 2008 09:56:59 -0500
Received: from compute2.internal (compute2.internal [10.202.2.42])
	by out1.messagingengine.com (Postfix) with ESMTP id 962A31E9A45;
	Fri, 19 Dec 2008 09:56:58 -0500 (EST)
Received: from heartbeat2.messagingengine.com ([10.202.2.161])
  by compute2.internal (MEProxy); Fri, 19 Dec 2008 09:56:58 -0500
X-Sasl-enc: sSD2ECHxUTRgo1xVC8n74KhZSA6ax3gVhLwnSvNNI/d3 1229698618
Received: from [139.174.44.12] (whitehead.math.tu-clausthal.de [139.174.44.12])
	by mail.messagingengine.com (Postfix) with ESMTPSA id E791D1C206;
	Fri, 19 Dec 2008 09:56:57 -0500 (EST)
User-Agent: Thunderbird 2.0.0.18 (X11/20081105)
In-Reply-To: <200812191257.18678.thomas.jarosch@intra2net.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/103564>

Thomas Jarosch venit, vidit, dixit 19.12.2008 12:57:
> Hello together,
> 
> while playing around with git, I stumbled upon a strange remote tracking 
> branch deletion problem. It seems I'm unable to delete the remote tracking 
> branch "origin/HEAD" using git 1.6.0.5. Here's what I did:
> 
> [tomj@storm repo]$ git init
> Initialized empty Git repository in /tmp/repo/.git/
> 
> [tomj@storm repo]$ echo "test" >test
> [tomj@storm repo]$ git add test
> [tomj@storm repo]$ git commit -m "Test"
> 
> [tomj@storm tmp]$ git clone repo alice
> Initialized empty Git repository in /tmp/alice/.git/
> 
> [tomj@storm alice]$ git branch -r
>   origin/HEAD
>   origin/master
> 
> [tomj@storm alice]$ git branch -r -d origin/HEAD
> Deleted remote branch origin/HEAD.
> [tomj@storm alice]$ git branch -r -d origin/master
> Deleted remote branch origin/master.
> 
> [tomj@storm alice]$ ls -al .git/refs/remotes/origin/HEAD
> -rw-rw---- 1 tomj intra2net 32 19. Dec 12:43 .git/refs/remotes/origin/HEAD
> [tomj@storm alice]$ git branch -r
> error: refs/remotes/origin/HEAD points nowhere!
> 
> Is this supposed to be? git 1.6.1.rc3.35.gc0ceb shows a similar behavior.

I think the point here is that HEAD is really a symref. "git remote rm
origin" makes sure that symrefs are removed, and is the right command to
use here.

"git branch -r -d", as well as "git update-ref -d" fail to remove HEAD
because it's really not a branch but a symref.

You can use "git update-ref -d --no-deref" to remove HEAD.

Making builtin-branch use delete_ref(,,REF_ISSYMREF) leads to success
for your above commands. I don't know about side effects, though all
tests pass. Is this sensible?

I guess I should come up with a test for this along with the patch.

Michael
