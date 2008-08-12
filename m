From: "Stephen R. van den Berg" <srb@cuci.nl>
Subject: Re: [PATCH] git-daemon: Simplify child management and associated logging by
Date: Wed, 13 Aug 2008 01:12:10 +0200
Message-ID: <20080812231210.GB15265@cuci.nl>
References: <20080812193613.32388.92145.stgit@aristoteles.cuci.nl> <20080812212534.6871.19377.stgit@aristoteles.cuci.nl> <20080812223224.GA4134@steel.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Alex Riesen <raa.lkml@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 13 01:13:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KT33C-00015q-8z
	for gcvg-git-2@gmane.org; Wed, 13 Aug 2008 01:13:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751876AbYHLXMM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 12 Aug 2008 19:12:12 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751871AbYHLXMM
	(ORCPT <rfc822;git-outgoing>); Tue, 12 Aug 2008 19:12:12 -0400
Received: from aristoteles.cuci.nl ([212.125.128.18]:38199 "EHLO
	aristoteles.cuci.nl" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751868AbYHLXML (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 12 Aug 2008 19:12:11 -0400
Received: by aristoteles.cuci.nl (Postfix, from userid 500)
	id 2BCEA5465; Wed, 13 Aug 2008 01:12:10 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <20080812223224.GA4134@steel.home>
User-Agent: Mutt/1.5.13 (2006-08-11)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92154>

Alex Riesen wrote:
>Stephen R. van den Berg, Tue, Aug 12, 2008 23:25:35 +0200:
>> +        struct child*newborn;

>You may want to reformat the patch using tabs instead of spaces.

Tried to do it right, but apparently missed a few spots, thanks.

>> +        newborn = xmalloc(sizeof *newborn);

>The custom here is to use "sizeof(type)". Brackets and typename.

Well, as for the parens, current git source shows a ratio of 26 : 887
in your favour; apparently not everyone agrees, but most do.
As for the typename, that rather uncommon, in most cases actual
variables are used (with good reason).

>> +        if (newborn) {
>> +	        struct child**cradle,*blanket;

>"struct child **cradle, *blanket;" (the spaces before asterisks)

I'll be more careful.

>> +		memcpy(memset(&newborn->address, 0, sizeof newborn->address),
>> +		 addr, addrlen);

>Aren't separate calls easier to read (and type)?

Possibly, yes.

>	memset(&newborn->address, 0, sizeof(newborn->address));
>	memcpy(&newborn->address, addr, addrlen);

But it results in more machinecode in most cases.  Sorry, is my builtin
micro-optimiser at work.

>> -static void kill_some_children(int signo, unsigned start, unsigned stop)
>> +static void kill_some_child(int signo)
>>  {
>> -	start %= MAX_CHILDREN;
>> -	stop %= MAX_CHILDREN;
>> -	while (start != stop) {
>> -		if (!(start & 3))
>> -			kill(live_child[start].pid, signo);
>> -		start = (start + 1) % MAX_CHILDREN;
>> +	const struct child *blanket;
>> +
>> +	if ((blanket = firstborn)) {

>	if (firstborn) {
>	    const struct child *blanket = firstborn;

>You don't even use blanket outside of the "if".

Good thinking.  I restructured the code a few times, previously this
wasn't possible.

>>  static void check_dead_children(void)
>>  {
>> +		loginfo("[%d] Disconnected%s", (int)pid, dead);

>BTW, why do you need that pid_t->int cast?

Because pid_t might be wider than int (unlikely, but possible),
and then this call might crash the program.

>> @@ -1105,6 +1026,10 @@ int main(int argc, char **argv)
>>  			init_timeout = atoi(arg+15);
>>  			continue;

>> +		if (!prefixcmp(arg, "--max-connections=")) {
>> +			max_connections = atoi(arg+18);

>An error checking wouldn't go amiss. And it can't be done with atoi
>(consider strtol).

I merely copied the other argument parsing methods, didn't want to
improve this, just functionally equivalent (will do fine here, IMO).
-- 
Sincerely,
           Stephen R. van den Berg.

Father's Day Special at the local clinic -- Vasectomy!
