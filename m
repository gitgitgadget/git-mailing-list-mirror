From: "J.H." <warthog9@kernel.org>
Subject: Re: [PATCH 1/6] GITWEB - Load Checking
Date: Thu, 10 Dec 2009 18:19:57 -0800
Message-ID: <4B21AC4D.2020407@kernel.org>
References: <1260488743-25855-1-git-send-email-warthog9@kernel.org>	<1260488743-25855-2-git-send-email-warthog9@kernel.org> <m34onye3h8.fsf@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org,
	"John 'Warthog9' Hawley" <warthog9@eaglescrag.net>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Fri Dec 11 03:20:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NIv7Q-0003US-Tl
	for gcvg-git-2@lo.gmane.org; Fri, 11 Dec 2009 03:20:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1762152AbZLKCUV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 10 Dec 2009 21:20:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762147AbZLKCUV
	(ORCPT <rfc822;git-outgoing>); Thu, 10 Dec 2009 21:20:21 -0500
Received: from shards.monkeyblade.net ([198.137.202.13]:60289 "EHLO
	shards.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1761999AbZLKCUT (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 10 Dec 2009 21:20:19 -0500
Received: from voot-cruiser.eaglescrag.net (76-10-145-13.dsl.ncf.ca [76.10.145.13] (may be forged))
	(authenticated bits=0)
	by shards.monkeyblade.net (8.14.1/8.14.1) with ESMTP id nBB2Jvwx020595
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Thu, 10 Dec 2009 18:19:58 -0800
User-Agent: Thunderbird 2.0.0.23 (X11/20090825)
In-Reply-To: <m34onye3h8.fsf@localhost.localdomain>
X-Enigmail-Version: 0.95.6
X-Virus-Scanned: ClamAV 0.88.7/10149/Thu Dec 10 14:26:20 2009 on shards.monkeyblade.net
X-Virus-Status: Clean
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.1.1 (shards.monkeyblade.net [198.137.202.13]); Thu, 10 Dec 2009 18:19:59 -0800 (PST)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135066>

<snip>
>> adds $maxload configuration variable.  Default is a load of 300,
>> which for most cases should never be hit.
> 
> Your patch doesn't allow for *turning off* this feature.  Reasonable
> solution would be to use 'undef' or negative number to turn off this
> check (this feature).

Well there's the opposite argument that setting the number arbitrarily 
high, 4096 for instance would also in essence negate this (though I'll 
admit I've reached and exceeded those numbers before)

That said I agree, being able to turn this off needs to be added and 
will be shortly.

>> Please note this makes the assumption that /proc/loadavg exists
>> as there is no good way to read load averages on a great number of
>> platforms [READ: Windows], or that it's reasonably accurate.
> 
> What about MacOS X, or FreeBSD, or OpenSolaris?

Will comment on this further down

> You should mention that it is intended that if gitweb cannot read load
> average (for example /proc/loadavg does not exist), then the feature
> is turned off, i.e. the check always succeeds.  Which is reasonable.

That's fine.

> 
>> Signed-off-by: John 'Warthog9' Hawley <warthog9@eaglescrag.net>
> 
> Why signoff is different from author (warthog9@kernel.org)?  Why this
> email for signoff?  Just curious...

My bad, did the patches up on my laptop but had to send them out from 
kernel.org, thus the miss-match: I.E. user error.

<snip>

>> +# loadavg throttle
>> +sub get_loadavg() {
>> +    my $load;
>> +    my @loads;
>> +
>> +    open($load, '<', '/proc/loadavg') or return 0;
> 
> Why not use one of existing CPAN modules: Sys::Info::Device::CPU,
> BSD::getloadavg, Sys::CpuLoad?

Here's the fundamental problem:

Sys:Info:Device:CPU
	Windows:
		Using this method under Windows is not recommended
		since, the WMI interface will possibly take at least 2
		seconds to complete the request.

BSD::getloadavg
	While this more or less supports anything with a libc getloadavg
	(and thus might be the best one I've seen, I'll admit I didn't
	notice this one when I looked years ago) getting it to work on
	windows looks, exciting.

Sys::CpuLoad:
	http://cpansearch.perl.org/src/CLINTDW/Sys-CpuLoad-0.03/README
	Specifically:
		- Currently FreeBSD and OpenBSD are supported.
		- Wanted: HPUX 11.11 ...
		- Todo: Win32 support

	So this doesn't really buy me anything but, maybe, BSD support.
	
So at the end of the day, none of those really gets me a "useful" cross 
platform load checker (though like I said BSD::getloadavg looks to be 
the best of the ones you mentioned) and more or less Windows is going to 
lose this as a usable feature no matter what.

I think I'd almost rather set this up so that if it can't get something 
useful (I.E. /proc/loadavg is missing) it just skips past it as if the 
load was 0.

I might try out the BSD::getloadavg but I want to take a look and see if 
that's easily installed or not, if it's not it might be difficult to 
justify that as a dependency.

<snip>

>> +if (get_loadavg() > $maxload) {
>> +    print "Content-Type: text/plain\n";
>> +    print "Status: 503 Excessive load on server\n";
>> +    print "\n";
>> +    print "The load average on the server is too high\n";
>> +    exit 0;
> 
> Why not use die_error subroutine?  Is it to have generate absolutely
> minimal load, and that is why you do not use die_error(), or even
> $cgi->header()?
> 
> Wouldn't a better solution be to use here-doc syntax?
> 
> +    print <<'EOF';
> +Content-Type: text/plain; charset=utf-8
> +Status: 503 Excessive load on server
> +
> +The load average on the server is too high
> +EOF
> +    exit 0;

It was intended to be the most minimal possible, mainly get in, get out. 
  Also not sure the die_error existed in gitweb when this was originally 
written.  Probably worth switching to it now since it's there either 
way, and I don't think using it would add enough overhead to matter.

- John 'Warthog9' Hawley
