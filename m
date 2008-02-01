From: Michael Witten <mfwitten@MIT.EDU>
Subject: Re: [PATCH] git-send-email: ssh/login style password requests
Date: Fri, 1 Feb 2008 13:38:47 -0500
Message-ID: <FE992810-2B2E-4C23-A7D3-AD4C39D925ED@MIT.EDU>
References: <1201841954-17949-1-git-send-email-mfwitten@mit.edu> <7vodb19edp.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0 (Apple Message framework v915)
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 01 19:39:54 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JL0no-0004Zt-1z
	for gcvg-git-2@gmane.org; Fri, 01 Feb 2008 19:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754231AbYBASjT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Feb 2008 13:39:19 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753736AbYBASjT
	(ORCPT <rfc822;git-outgoing>); Fri, 1 Feb 2008 13:39:19 -0500
Received: from BISCAYNE-ONE-STATION.MIT.EDU ([18.7.7.80]:34752 "EHLO
	biscayne-one-station.mit.edu" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751227AbYBASjS (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 1 Feb 2008 13:39:18 -0500
Received: from outgoing.mit.edu (OUTGOING-AUTH.MIT.EDU [18.7.22.103])
	by biscayne-one-station.mit.edu (8.13.6/8.9.2) with ESMTP id m11IcmgN009070;
	Fri, 1 Feb 2008 13:38:48 -0500 (EST)
Received: from MACGREGOR-THREE-SEVENTY-SEVEN.MIT.EDU (MACGREGOR-THREE-SEVENTY-SEVEN.MIT.EDU [18.239.6.122])
	(authenticated bits=0)
        (User authenticated as mfwitten@ATHENA.MIT.EDU)
	by outgoing.mit.edu (8.13.6/8.12.4) with ESMTP id m11Icl43024147
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NOT);
	Fri, 1 Feb 2008 13:38:48 -0500 (EST)
In-Reply-To: <7vodb19edp.fsf@gitster.siamese.dyndns.org>
X-Mailer: Apple Mail (2.915)
X-Scanned-By: MIMEDefang 2.42
X-Spam-Flag: NO
X-Spam-Score: 0.00
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/72181>


On 1 Feb 2008, at 5:09 AM, Junio C Hamano wrote:

> Michael Witten <mfwitten@MIT.EDU> writes:
>
>> +--smtp-pass::
>> +	Password for SMTP-AUTH. The default value can be specified
>> +	with the configuration variable 'sendemail.smtppass' or
>> +	sendemail.<identity>.smtppass (see sendemail.identity).
>> +	The argument is optional: If no argument is specified, then
>> +	the password is assumed to be the empty string.
>> +	If a username has been set, but no password has been set,
>> +	the user is prompted for a password with masked input for
>> +	privacy; passwords need not be recorded in configuration
>> +	files.
>
> I am a bit puzzled about the above description, though.  It is
> not clear if there is any difference between "the empty string"
> password, and "no password has been set".  It makes me wonder
> what the possible cases are.

How are these descriptions:

	http://web.mit.edu/mfwitten/git-send-email.html

I've attempted to keep them short, but complete. Also, the
resulting man page versions are formatted similarly (though
at the expense of some ASCIIdoc readability).

> In other cases, lack of *.smtppass
> and having *.smtppass with an empty string as its value are  
> equivalent.
> And in any case, an empty string (or lack of specification) results
> in prompting.

Actually, a lack of *.smtp<user|pass> results in variables without
definition rather than with empty-string values; the original code,
too, makes use of this fact. Consequently, an empty string for
*.smtppass does not result in prompting, as tested.

>> +		if (defined $smtp_authuser) {
>> +
>> +			if (!defined $smtp_authpass) {
>> +				
>> +				system "stty -echo";
>> +
>> +				do {
>> +					$_ = $term->readline("Password: ");
>> +				} while (!defined $_);
>> +
>> +				system "stty echo";
>> +
>> +				$smtp_authpass = $_ if ($_);
>> +			}
>> +
>
> I like what the patch tries to do, but the system() there feels
> a tad ugly.  In addition it makes me wonder (1) what happens if
> you ^C out from this while loop

Good question! Though I'm not sure you can handle this any other
way than to intercept the signal.

> (2) $term->readline() interface might already have a method to turn  
> echo off.

I have very limited knowledge of these things, especially of Perl's  
interfaces,
but this is what `perldoc -q password` has to say about it:

> 	There's an example of this in "crypt" in perlfunc).
> 	First, you put the terminal into "no echo" mode,
> 	then just read the password normally.  You may do
> 	this with an old-style ioctl() function, POSIX
> 	terminal control (see POSIX or its documentation
> 	the Camel Book), or a call to the stty program,
> 	with varying degrees of portability.
> 	
> 	You can also do this for most systems using the
> 	Term::ReadKey module from CPAN, which is easier
> 	to use and in theory more portable.
> 	
> 	   use Term::ReadKey;
> 	
> 	   ReadMode('noecho');
> 	   $password = ReadLine(0);

My code is from the "crypt" version. The other versions require
extra module dependencies, and the portability doesn't extend
immediately to Windows with any of these methods.

> We are not in a hurry, so I expect a polished resubmit after
> 1.5.4.  Thanks.

Great!

Sincerely,
Michael Witten
