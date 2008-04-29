From: Andreas Ericsson <ae@op5.se>
Subject: Re: About git and the use of SHA-1
Date: Tue, 29 Apr 2008 08:38:37 +0200
Message-ID: <4816C26D.9010304@op5.se>
References: <200804281829.11866.henrikau@orakel.ntnu.no> <alpine.LNX.1.00.0804281515480.19665@iabervon.org> <200804282329.21336.henrikau@orakel.ntnu.no>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Henrik Austad <henrikau@orakel.ntnu.no>
X-From: git-owner@vger.kernel.org Tue Apr 29 08:39:29 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JqjUu-0007Q7-MG
	for gcvg-git-2@gmane.org; Tue, 29 Apr 2008 08:39:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751782AbYD2Gil (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Apr 2008 02:38:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754513AbYD2Gik
	(ORCPT <rfc822;git-outgoing>); Tue, 29 Apr 2008 02:38:40 -0400
Received: from mail.op5.se ([193.201.96.20]:59485 "EHLO mail.op5.se"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751608AbYD2Gik (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Apr 2008 02:38:40 -0400
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.op5.se (Postfix) with ESMTP id 159431F0807D;
	Tue, 29 Apr 2008 08:38:42 +0200 (CEST)
X-Virus-Scanned: amavisd-new at 
X-Spam-Flag: NO
X-Spam-Score: -4.399
X-Spam-Level: 
X-Spam-Status: No, score=-4.399 tagged_above=-10 required=6.6
	tests=[ALL_TRUSTED=-1.8, BAYES_00=-2.599]
Received: from mail.op5.se ([127.0.0.1])
	by localhost (mail.op5.se [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id 1ciuASjFfGsT; Tue, 29 Apr 2008 08:38:41 +0200 (CEST)
Received: from clix.int.op5.se (unknown [192.168.1.27])
	by mail.op5.se (Postfix) with ESMTP id 23A671F08063;
	Tue, 29 Apr 2008 08:38:41 +0200 (CEST)
User-Agent: Thunderbird 2.0.0.12 (X11/20080226)
In-Reply-To: <200804282329.21336.henrikau@orakel.ntnu.no>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/80653>

Henrik Austad wrote:
> On Monday 28 April 2008 21:34:50 Daniel Barkalow wrote:
>> On Mon, 28 Apr 2008, Henrik Austad wrote:
>>> Hi list!
>>>
>>> As far as I have gathered, the SHA-1-sum is used as a identifier for
>>> commits, and that is the primary reason for using sha1.  However, several
>>> places (including the google tech-talk featuring Linus himself) states
>>> that the id's are cryptographically secure.
>>>
>>> As discussed in [1], SHA-1 is not as secure as it once was (and this was
>>> in 2005), and I'm wondering - are there any plans for migrating to
>>> another hash-algorithm? I.e. SHA-2, whirlpool..
>> No. The cryptographic security we care about is that it's impractical to
>> come up with another set of content that hashes to the same value as a
>> given set of content. The known attacks on SHA-1 (and more broken earlier
>> hashes in the same general class) only allow the attacker to produce two
>> files that will collide. Now, it's true that this would allow somebody to
>> produce a commit where some people see the "good" blob and some people see
>> the "evil" blob, but (a) the "good" blob contains some large chunk of
>> random data, which is a major red flag by itself, and (b) all of these
>> people have to be taking data from the attacker.
> 
> yes, I can see that point, but I was thinking more along the line of:
> 
> 1) clone repo
> 2) add malicious code
> 3) add a huge block of comment, ifdef-block etc somewhere obscure in the code 
> and keep adding random data untill hash matches a well-known release.
> 4) publish repo, or even worse, change central repo
> 

This depends greatly on git accepting objects with a colliding object-name,
which it doesn't. Once you have an object with a particular SHA1, it will
never get overwritten, ever, as git will believe it's about to do unnecessary
work. As such, you'd still have to create a new object, hashing to a new SHA1
and get that new object added to the kernel.

I think perhaps Andrew Morton and a few other "high brass" among the kernel
hackers can get away with pushing crud like that to Linus' public tree
(which is the de facto master copy of published kernel sources), but random
John Doe's such as you and me wouldn't stand a chance, as our patches would
get reviewed by someone who, at the end of the day, makes a living coding
Linux.


> Most users, and probably a lot of developers never browse through the *entire* 
> archive looking for this, and as long as the hash checks out - why would you? 
> Yes, it would probably be discovered soon enough, but take the linux kernel 
> as an example - if you get, say 100 infected machines due to this, what would 
> this do to the reputation of the kernel?
> 

That depends. If the source of it was Linus' public tree, that would not be
very good at all. If the source was a random tarball off a random webpage
or ftp site (which would be the same as fetching and, unverified, using an
unchecked git repository), I doubt it would matter much.

> 
>> If somebody gives you some source, and it's got some large random chunk in
>> it, and the behavior of the object depends on the content of this chunk,
>> and it's unspecified where this chunk comes from, you should be aware
>> that they might be able to swap this chunk for a different chunk. But such
>> a file is pretty blatantly malicious anyway.
> 
> True, but this actually means you have to verify *everything*, even though the 
> hash checks out.
> 

Not really. What you need to verify is that
a) You cloned from somewhere you trust (kernel.org, fe)
b) The SHA1 of the commit you want to build from matches the SHA1 of the same
commit in the repository you originally cloned from.

Colliding objects can never enter a repository. Git is lazy and will reuse the
already existing colliding object with the same name instead.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
