From: Sam Vilain <samv@catalyst.net.nz>
Subject: Re: [PATCH] perl: add new module Git::Config for cached 'git config'
 access
Date: Wed, 08 Apr 2009 22:44:18 +1200
Message-ID: <49DC8002.6050503@catalyst.net.nz>
References: <1238975176-14354-1-git-send-email-sam.vilain@catalyst.net.nz> <m3prfo1xh6.fsf@localhost.localdomain> <49DC3ADD.5000902@catalyst.net.nz> <200904081218.39984.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Sam Vilain <sam.vilain@catalyst.net.nz>,
	Frank Lichtenheld <frank@lichtenheld.de>, git@vger.kernel.org,
	Petr Baudis <pasky@suse.cz>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Wed Apr 08 12:46:34 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LrVIe-0001MN-4L
	for gcvg-git-2@gmane.org; Wed, 08 Apr 2009 12:46:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932093AbZDHKod (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 8 Apr 2009 06:44:33 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1762944AbZDHKoc
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Apr 2009 06:44:32 -0400
Received: from godel.catalyst.net.nz ([202.78.240.40]:49734 "EHLO
	mail1.catalyst.net.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1763884AbZDHKob (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Apr 2009 06:44:31 -0400
Received: from 203-97-235-49.cable.telstraclear.net ([203.97.235.49] helo=[192.168.69.179])
	by mail1.catalyst.net.nz with esmtpsa (TLS-1.0:DHE_RSA_AES_256_CBC_SHA1:32)
	(Exim 4.63)
	(envelope-from <samv@catalyst.net.nz>)
	id 1LrVGW-0004KS-9e; Wed, 08 Apr 2009 22:44:20 +1200
User-Agent: Thunderbird 2.0.0.14 (X11/20080505)
In-Reply-To: <200904081218.39984.jnareb@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/116077>

Jakub Narebski wrote:
> By the way, did you take a look how cached 'git config' access and
> typecasting is done in gitweb?  See commit b201927 (gitweb: Read
> repo config using 'git config -z -l') and following similar commits.
>   

Right ... sure, looks fairly straightforward.  I guess gitweb could 
potentially use this tested module instead of including that code 
itself.  Also various parts of git-svn... anything really.

I actually wrote this code because I wanted something a bit nicer for 
writing the mirror-sync initial implementations.  And I wanted to have a 
bit of control over when values get committed, and save work for 
reading, so I wrote this.

>> Any more gremlins? 
>>     
> I have nor examined your patch in detail; I'll try to do it soon,
> but with git config file parsing there lies following traps.
>
> 1. In fully qualified variable name section name and variable name
>    have to be compared case insensitive (or normalized, i.e.
>    lowercased), while subsection part (if it exists) is case sensitive.
>   

I noticed that 'git config' hides this by normalising the case of what 
it outputs with 'git config --list'; do you think anything special is 
required in light of this?

> 2. When coercing type to bool, you need to remember (and test) that
>    there are values which are truish (no value, 'true', 'yes', non-zero
>    integer usually 1), values which are falsish (empry, 'false', 'no',
>    0); other values IIRC are truish too.
>   

Yep, see the Git::Config::boolean mini-package which has a list of 
those.  I think I used the documented legal values, which are 'true', 
'yes' and '1' for affirmative and 'false', 'no' and '0' for negative.  I 
guess I could make that include non-zero integers as well.

> 3. When coercing type to int, you need to remember about optional
>    value suffixes: 'k', 'm' or 'g'.
>   

Yep, covered on input and output :-).  See Git::Config::integer for the 
conversion functions.

> 4. I don't know if you remembered about 'colorbool' and 'color'; the
>    latter would probably require some extra CPAN module for ANSI color
>    escapes... or copying color codes from the C version.
>   

Yeah, I thought those could probably be done with a follow-up patch.  
It's just a matter of writing functions Git::Config::color::thaw and 
::freeze.

> Why not represent it simply as an 'undef'? You can always distinguish 
> between not defined and not existing by using 'exists'...
>   

I don't like 'undef' being a data value.  In this case I was already 
using setting a value to undef to tell the module to remove the key from 
the config file.  But in any case you should not need to care what form 
the values exist in the internal ->{read_state} hash, as you should 
always be retrieving them using the ->config method, which will marshall 
them into the type you want.  Note it's always the same object, just 
like Perl's &PL_undef via the C API.

>> Sneak a couple of vim footer changes in too.
>>     
>
> Hmmm...
>   

Guess someone noticed them.  Oh well, rebase time ...

Thanks for your input Jakub, I'll incorporate your suggestions.

Sam
