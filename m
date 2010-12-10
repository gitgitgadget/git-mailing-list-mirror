From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 11/18] gitweb: add isDumbClient() check
Date: Thu, 09 Dec 2010 20:00:51 -0800
Message-ID: <4D01A5F3.8030108@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-12-git-send-email-warthog9@eaglescrag.net> <m3hbem1o7a.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 04:59:18 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQu8Y-0005sY-Gq
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 04:59:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755008Ab0LJD7I (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 9 Dec 2010 22:59:08 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:55307 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752464Ab0LJD7G (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 9 Dec 2010 22:59:06 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA3x41g028065
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 19:59:04 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3hbem1o7a.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 19:59:04 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163386>

>> +	my($user_agent) = $ENV{'HTTP_USER_AGENT'};
> 
> What if $ENV{'HTTP_USER_AGENT'} is unset / undef, e.g. because we are
> runing gitweb as a script... which includes running gitweb tests?

It can be disabled for the running of tests, but the default is to show
'Generating...' vs. not.  I'd rather assume there's an intelligent
client on the other end and give users a reason why they aren't staring
at their initial content immediately (and thus thinking something is
broken).

>> +	
>> +	if(
>> +		# wget case
>> +		$user_agent =~ /^Wget/i
>> +		||
>> +		# curl should be excluded I think, probably better safe than sorry
>> +		$user_agent =~ /^curl/i
>> +	  ){
>> +		return 1;	# True
>> +	}
>> +
>> +	return 0;
>> +}
> 
> Compare (note: handcrafted solution is to whitelist, not blacklist):
> 
> +sub browser_is_robot {
> +       return 1 if !exists $ENV{'HTTP_USER_AGENT'}; # gitweb run as script
> +       if (eval { require HTTP::BrowserDetect; }) {
> +               my $browser = HTTP::BrowserDetect->new();
> +               return $browser->robot();
> +       }
> +       # fallback on detecting known web browsers
> +       return 0 if ($ENV{'HTTP_USER_AGENT'} =~ /\b(?:Mozilla|Opera|Safari|IE)\b/);
> +       # be conservative; if not sure, assume non-interactive
> +       return 1;
> +}

My initial look indicated that perl-http-browserdetect wasn't available
for RHEL / CentOS 5 - it is however available in EPEL.

However there are a couple of things to note about User Agents at all:
	- They lie... a lot
	- Robots lie even more

Blacklisting is still the better option, by a lot.  I'll re-work this
some in v9, as I'm fine with the added dependency.

- John 'Warthog9' Hawley
