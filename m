From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Question about removing old objects
Date: Sat, 21 Apr 2007 16:29:06 -0700
Message-ID: <462A9E42.3050409@midwinter.com>
References: <A2948362-ADC0-4F86-92BB-D942E9EF0AAC@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: John Wiegley <jwiegley@gmail.com>
X-From: git-owner@vger.kernel.org Sun Apr 22 01:29:14 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HfP0y-0007WE-F4
	for gcvg-git@gmane.org; Sun, 22 Apr 2007 01:29:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753797AbXDUX3I (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 21 Apr 2007 19:29:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753865AbXDUX3I
	(ORCPT <rfc822;git-outgoing>); Sat, 21 Apr 2007 19:29:08 -0400
Received: from tater.midwinter.com ([216.32.86.90]:49156 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753797AbXDUX3H (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 21 Apr 2007 19:29:07 -0400
Received: (qmail 17152 invoked from network); 21 Apr 2007 23:29:05 -0000
Received: from c-76-21-17-123.hsd1.ca.comcast.net (HELO ?192.168.0.132?) (koreth@76.21.17.123)
  by tater.midwinter.com with SMTP; 21 Apr 2007 23:29:05 -0000
User-Agent: Thunderbird 1.5.0.10 (Macintosh/20070221)
In-Reply-To: <A2948362-ADC0-4F86-92BB-D942E9EF0AAC@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/45197>

John Wiegley wrote:
> Hello, I am thinking of using git to track my home directory.  
> However, rather than keeping old history around forever, I'd like to 
> physically remove old objects after X days -- in essence, causing the 
> repository to appear as if it had begun life X days ago.  Is there a 
> git command to do this?

Not exactly, but you can fake it using shallow clones. Something like 
this, assuming you do one revision per day and want to keep 10 days 
around (if you commit at irregular intervals, you'll have to do some 
scanning to figure out how deep to make the clone):

# Go to the top level of your home-dir repo
cd $HOME
# Shallow clone the home-directory repo into a temporary one
git clone --depth 10 -n . .temp-repo
# Replace the home directory's repo with the shallow clone
rm -rf .git.old
mv .git .git.old
mv .temp-repo/.git .
# Since we did clone -n, there's nothing left in .temp-repo
rmdir .temp-repo
# Make the shallow clone cloneable so we can do this again tomorrow
rm -f .git/shallow

I haven't tried that exactly, but I think it should work. Of course, the 
final step removes a safety measure from the clone: you are technically 
not supposed to clone a shallow repo since it has an incomplete history 
and merges will probably fail horribly. But if, as it sounds like may be 
the case, you only ever have one copy of the repo anyway, I believe that 
should be harmless. If you're doing lots of branching and merging of 
your home directory then all bets are off.

A more experienced git user than me will probably tell you (and me) if 
I've suggested something stupid there, so you might want to wait for 
some replies to this message before you start relying on that procedure.

-Steve
