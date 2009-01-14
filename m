From: Jan Engelhardt <jengelh@medozas.de>
Subject: Re: [PATCH 1/3] git-daemon: single-line logs
Date: Wed, 14 Jan 2009 14:03:33 +0100 (CET)
Message-ID: <alpine.LSU.2.00.0901141342060.23212@fbirervta.pbzchgretzou.qr>
References: <alpine.LSU.2.00.0901141147120.16109@fbirervta.pbzchgretzou.qr> <7vy6xe2kbx.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 14 14:05:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LN5Qb-00021e-7u
	for gcvg-git-2@gmane.org; Wed, 14 Jan 2009 14:05:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755365AbZANNDi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Jan 2009 08:03:38 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755160AbZANNDh
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Jan 2009 08:03:37 -0500
Received: from sovereign.computergmbh.de ([85.214.69.204]:46865 "EHLO
	sovereign.computergmbh.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755045AbZANNDg (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Jan 2009 08:03:36 -0500
Received: by sovereign.computergmbh.de (Postfix, from userid 25121)
	id E64C1180C566A; Wed, 14 Jan 2009 14:03:33 +0100 (CET)
Received: from localhost (localhost [127.0.0.1])
	by sovereign.computergmbh.de (Postfix) with ESMTP id E4BFC1D160A19;
	Wed, 14 Jan 2009 14:03:33 +0100 (CET)
In-Reply-To: <7vy6xe2kbx.fsf@gitster.siamese.dyndns.org>
User-Agent: Alpine 2.00 (LSU 1167 2008-08-23)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/105624>


On Wednesday 2009-01-14 12:33, Junio C Hamano wrote:
>
>> parent v1.6.1
>>
>> git-daemon: single-line logs
>
>Please drop these two needless lines when/if you are submitting patches
>for inclusion..

The patches are produced by my git-export-patch script (or in this
specific case it was quilt); so they usually look like this.
Especially when I do make mental notes that do not go into the
commit log, the patch is tacked on, as in, for example,
http://marc.info/?l=netfilter-devel&m=123191159015731&w=2

>> Having just a single line per connection attempt, much like Apache
>> httpd2 access logs, makes log parsing much easier, especially when
>> just glancing over it non-automated.
>
>While I like the motivation, and I wish the log were as terse as possible
>from the day one,

Well, why did no one do it like that then? My guess is that it was not a 
"real" logging infrastructure but more of a debug aid. Especially when 
it required --syslog --verbose to pass to git-daemon this seems like 
--debug=yesPlease.

>I think changing the output format unconditionally like
>this patch does is a horrible idea.  I'd expect there are many people who
>already have their infrastructure set up to parse the current output; this
>patch actively breaks things for them, doesn't it?

Probably. Which just shows that git-daemon is in need of
some configuration .. thing so that each user can choose
his own if desired.


>> @@ -295,12 +295,13 @@ static int git_daemon_config(const char
>> -static int run_service(char *dir, struct daemon_service *service)
>> +static int run_service(char *dir, struct daemon_service *service,
>> +    const char *origin, const char *vhost)
>>  {
>>  	const char *path;
>>  	int enabled = service->enabled;
>>  
>> -	loginfo("Request %s for '%s'", service->name, dir);
>> +	loginfo("%s->%s %s \"%s\"\n", origin, vhost, service->name, dir);
>
>Mental note.  You are adding origin and vhost probably because you are
>losing them from elsewhere..

Not quite sure what you mean by losing.

But in 1.6.0.x, run_service had a variable interp of type itable or so 
and it was possible to use interp[SLOT_DIR].val without someone raising 
a hand declaring I lost them elsewhere ;-)

>> @@ -529,7 +530,6 @@ static int execute(struct sockaddr *addr
>>  			port = ntohs(sin6_addr->sin6_port);
>>  #endif
>>  		}
>> -		loginfo("Connection from %s:%d", addrbuf, port);
>
>Mental note.  Port is not logged anymore here.

Right, I did not see a need for it, and it in itself just stood
in the way of getting 1-line-output.

>> @@ -541,10 +541,6 @@ static int execute(struct sockaddr *addr
>>  	alarm(0);
>>  
>>  	len = strlen(line);
>> -	if (pktlen != len)
>> -		loginfo("Extended attributes (%d bytes) exist <%.*s>",
>> -			(int) pktlen - len,
>> -			(int) pktlen - len, line + len + 1);
>
>Mental note.  XA are not logged here anymore.

I only ever saw the hostname XA, and this is still logged.

>> @@ -569,7 +565,8 @@ static int execute(struct sockaddr *addr
>>  			 * Note: The directory here is probably context sensitive,
>>  			 * and might depend on the actual service being performed.
>>  			 */
>> -			return run_service(line + namelen + 5, s);
>> +			return run_service(line + namelen + 5, s,
>> +			       addrbuf, hostname);
>>  		}
>>  	}
>
>So not just you are changing the format, but you are losing information as
>well.
>
>By the way, I think hostname has already been freed and NULLed at this
>call site.  Aren't you getting entries like:
>
>	192.168.0.1->(null) upload-pack "/pub/git.git"
>
>in your log?

No. Which means someone succeeded at obfuscating daemon.c.
It seems that parse_extra_args() sets hostname again after it has been 
NULLified just moments ago.
