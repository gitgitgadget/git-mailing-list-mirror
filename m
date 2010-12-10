From: "J.H." <warthog9@eaglescrag.net>
Subject: Re: [PATCH 15/18] gitweb: Add show_warning() to display an immediate
 warning, with refresh
Date: Thu, 09 Dec 2010 23:38:42 -0800
Message-ID: <4D01D902.1030102@eaglescrag.net>
References: <1291931844-28454-1-git-send-email-warthog9@eaglescrag.net>	<1291931844-28454-16-git-send-email-warthog9@eaglescrag.net> <m3zksezbkm.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 10 08:37:58 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PQxYE-0005Z9-1o
	for gcvg-git-2@lo.gmane.org; Fri, 10 Dec 2010 08:37:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752918Ab0LJHg5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 10 Dec 2010 02:36:57 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:50843 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750966Ab0LJHg4 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 10 Dec 2010 02:36:56 -0500
Received: from voot-cruiser.eaglescrag.net (c-71-202-185-40.hsd1.ca.comcast.net [71.202.185.40])
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.4/8.14.3) with ESMTP id oBA7asXV013532
	(version=TLSv1/SSLv3 cipher=DHE-RSA-CAMELLIA256-SHA bits=256 verify=NO);
	Thu, 9 Dec 2010 23:36:54 -0800
X-Virus-Status: Clean
X-Virus-Scanned: clamav-milter 0.95.3 at shards.monkeyblade.net
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.1.15) Gecko/20101027 Fedora/3.0.10-1.fc12 Lightning/1.0b2pre Thunderbird/3.0.10
In-Reply-To: <m3zksezbkm.fsf@localhost.localdomain>
X-Enigmail-Version: 1.0.1
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.2.3 (shards.monkeyblade.net [198.137.202.13]); Thu, 09 Dec 2010 23:36:55 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163392>

On 12/09/2010 05:01 PM, Jakub Narebski wrote:
> "John 'Warthog9' Hawley" <warthog9@eaglescrag.net> writes:
> 
>> die_error() is an immediate and abrupt action.  show_warning() more or less
>> functions identically, except that the page generated doesn't use the
>> gitweb header or footer (in case they are broken) and has an auto-refresh
>> (10 seconds) built into it.
> 
> Why not use gitweb header/footer?  If they are broken, it should be
> caught in git development.  If we don't se them, the show_warning()
> output would look out of place.

The only other 'transient' style page, the 'Generating...' page doesn't
use it, and I felt that since this was also transient, and only (likely)
to be seen once it wasn't worth the header & footer.

That said I've added it back in, in v9.

>> +sub show_warning {
>> +	$| = 1;
> 
>   +	local $| = 1;
> 
> $| is global variable, and otherwise you would turn autoflush for all
> code, which would matter e.g. for FastCGI.

Since the execution exits immediately after, wouldn't FastCGI reset at
that point, since execution of that thread has stopped?  Or does FastCGI
retain everything as is across subsequent executions of a process?

>> +<meta http-equiv="refresh" content="10"/>
> 
> Why 10 seconds?

Long enough to see the error, but not too long to be a nuisance.  Mainly
just there to warn the admin that it did something automatic they may
not have been expecting.

>> +</head>
>> +<body>
>> +$warning
>> +</body>
>> +</html>
>> +EOF
>> +	exit(0);
> 
> "exit(0)" and not "goto DONE_GITWEB", or "goto DONE_REQUEST"?

DONE_REQUEST doesn't actually exist as a label, the exit was used
partially for my lack of love for goto's, but mostly out of not
realizing what that was calling back to (mainly for the excitement of
things like PSGI and their ilk)

I will change that that, but considering there are other locations where
I do explicit exit's and those are actually inherent to the way the
caching engine currently works, I might need to go take a look at what's
going on with respect to multi-threaded items inside of PSGI and their
like.  It's possible the caching engine doesn't actually work on those...

>> +}
>> +
>>  sub isBinaryAction {
>>  	my ($action) = @_;
> 
> Didn't you ran gitweb tests?

I did, they passed for me - for whatever reason my cache dir wasn't
cleaned up, and stayed resident once it was created.

- John 'Warthog9' Hawley
