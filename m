From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC] Adding a challenge-response authentication method to	git://
Date: Thu, 14 Aug 2008 11:15:22 +0200
Message-ID: <48A3F7AA.8070001@op5.se>
References: <20080813162644.GC12200@cuci.nl> <20080813164038.GE3782@spearce.org> <20080813173757.GE12200@cuci.nl> <20080813180857.GH3782@spearce.org> <20080814001029.GA14939@cuci.nl> <20080814005723.GM3782@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: "Stephen R. van den Berg" <srb@cuci.nl>, git <git@vger.kernel.org>
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Aug 14 11:17:31 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTYxP-0008Up-1p
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 11:17:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758642AbYHNJQQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 05:16:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758633AbYHNJQP
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 05:16:15 -0400
Received: from mail.op5.se ([193.201.96.20]:53862 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756116AbYHNJQN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 05:16:13 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id D68121B80087;
	Thu, 14 Aug 2008 11:19:31 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -2.499
X-Spam-Level: 
X-Spam-Status: No, score=-2.499 tagged_above=-10 required=6.6
	tests=[BAYES_00=-2.599, RDNS_NONE=0.1]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id NEe5YDvxbmZX; Thu, 14 Aug 2008 11:19:29 +0200 (CEST)
Received: from clix.int.op5.se (unknown [172.27.78.10])
	by mail.op5.se (Postfix) with ESMTP id CF6181B80050;
	Thu, 14 Aug 2008 11:19:28 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.16 (X11/20080723)
In-Reply-To: <20080814005723.GM3782@spearce.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92339>

Shawn O. Pearce wrote:
> "Stephen R. van den Berg" <srb@cuci.nl> wrote:
>> I'm not trying to solve all management problems, I'm just trying to
>> offer a simple solution for the small-user-base-central-repository case
>> without a lot of code-bloat on the git side.
>> If it doesn't fit ones needs, use ssh or something else; but it does
>> have its merits for the simple centralised setups.
> 
> OK, then my final two cents, and I'll shutup.
> 
> - Add to git-daemon a new service command, "git-authenticate-user".
> - Clients request "git-authenticate-user 'repository'".
> - The auth_user routine:
> 	enters 'repository' ('ala upload-pack)
> 	execs "git-authenticate-user ."
> 
> - git-authenticate-user:
> 	send pkt-line challenge
> 	recv pkt-line username
> 	recv pkt-line SHA-1(username + password + challenge)
> 	
> 	read gitconfig for "auth.passwordfile"
> 	read passwordfile for entry $username
> 		("user:pass:upload-pack,receive-pack")
> 	verify response
> 
> 	send pkt-line ok/fail
> 	recv pkt-line "git-$service '.'"
> 	check $service is allowed
> 	exec git-$service .
> 

I'd do it like this instead:

daemon: auth_user = dlsym(dlopen("auth-module.so", RTLD_NOW), "authenticat");
client: "git-authenticate action 'repository'"
daemon: send pkt-line challenge
client: send pkt-line username
client: send pkt-line SHA1(username + password + challenge)
daemon: if (auth_user(repository, action, username, password, struct sockaddr_in *inbound))
               allow_connection();

This approach has several nifty benefits:
* The otherwise duplicated code (for different auth schemes) is
  done only once (in the git daemon).
* If the git daemon has no authentication module loaded, we might
  as well not bother sending any challenge and just pretend we do
  not know about the authentication scheme.
* Any kind of authentication scheme can be supported without changing
  the core code. If the authentication module does something wrong,
  one can continue to serve read-only requests by simply unloading
  the module.
* Modules is a great way for newcomers to get started contributing to
  git so it's a nice way of getting more contributors/sub-maintainers.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
