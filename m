From: Steven Grimm <koreth@midwinter.com>
Subject: Re: Rename handling
Date: Wed, 21 Mar 2007 15:28:41 -0700
Message-ID: <4601B199.9060300@midwinter.com>
References: <slrnevtdfh.v0v.jgoerzen@katherina.lan.complete.org> <45FED31B.8070307@midwinter.com> <200703191903.20005.andyparkins@gmail.com> <45FEE2B2.6050904@midwinter.com> <etpson$qih$1@sea.gmane.org> <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jakub Narebski <jnareb@gmail.com>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Wed Mar 21 23:28:50 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HU9IY-0006Vq-26
	for gcvg-git@gmane.org; Wed, 21 Mar 2007 23:28:50 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S965404AbXCUW2l (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 21 Mar 2007 18:28:41 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S965381AbXCUW2l
	(ORCPT <rfc822;git-outgoing>); Wed, 21 Mar 2007 18:28:41 -0400
Received: from tater.midwinter.com ([216.32.86.90]:42078 "HELO midwinter.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S965404AbXCUW2k (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Mar 2007 18:28:40 -0400
Received: (qmail 18834 invoked from network); 21 Mar 2007 22:28:39 -0000
Comment: DomainKeys? See http://antispam.yahoo.com/domainkeys
DomainKey-Signature: a=rsa-sha1; q=dns; c=nofws;
  s=200606; d=midwinter.com;
  b=ZWWgqJLvKT+LB8pY5zhMI/p8c1kT2/Tls3LzZIpDM2AULXcK2XsdkmhAjGPJlCA7  ;
Received: from localhost (HELO ?127.0.0.1?) (koreth@127.0.0.1)
  by localhost with SMTP; 21 Mar 2007 22:28:39 -0000
User-Agent: Mail/News 1.5.0.2 (Macintosh/20060324)
In-Reply-To: <Pine.LNX.4.63.0703210120230.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/42823>

Johannes Schindelin wrote:
> P.S.: It would be so nice if somebody (preferably someone who previously 
> thought manual renames were a pretty clever thing) to write up the 
> arguments, and add that to the "why automatic renaming?" section of the 
> FAQ...
>   

I completely understand the arguments in favor of automatic renaming. I 
have never once advocated getting rid of it. It is useful and valuable 
and works well within its constraints.

For some reason whenever I try to argue that we need, IN ADDITION to the 
automatic rename detection, a way to provide hints to the merge engine 
that a non-auto-detectable rename has occurred, the responses I get back 
are mostly of the form, "But the automatic rename detection handles all 
these cases that wouldn't be handled with manual rename marking!" It's 
as if one can either think autodetection is a good idea, or manual 
flagging is a good idea, but under no circumstances could they both be 
good ideas at the same time. (As evidenced by the comment above about 
"someone who previously thought manual renames were a pretty clever 
thing.") But they are not in fact mutually exclusive.

Say you're tracking a directory full of video files. Even a slight tweak 
to one of them (to put a logo in the corner, say, while moving it into 
an "accessible by the public" directory) will result in a file that has 
no content in common at all if you look at it as purely a stream of 
bytes. Short of decoding the thing to video frames and looking for 
similarities in the images, there's no way any merge tool will ever be 
able to tell the two versions are the same file unless the user 
indicates it. Any tool that saves its files in compressed form will have 
a similar problem: unless git knows how to uncompress the tool's files, 
a content comparison will often be useless to detect similarities.

Of course, git actually does give you a way to mark renames manually: 
commit them by themselves without changing the content. The problem is 
that that overloads the "record this snapshot of the tree for posterity" 
command purely for the purpose of working around the merge tool's 
inability to detect the rename. If other people are like me, when they 
record a rename-only commit immediately followed by a content-change 
commit on the same files, the intermediate state of the tree (with just 
the renames) is not actually an interesting point in the history of the 
project. It's not a revision in anything but an internal git sense. It 
probably doesn't even compile or work correctly. It exists only because 
I'm forced to create it if I want to be 100% certain my renames will be 
tracked accurately. It is, in short, pollution in the history of my project.

It also means that if I want reliable renames, I can no longer impose 
the requirement that my project be in a buildable state at each commit. 
That doesn't seem like all that unreasonable a thing to want (but maybe 
it is?) -- I don't want to be in the situation where I say, e.g. "git 
checkout -b testbranch '@{1 day ago}'" and get a broken working copy 
because I happened to do it at just the wrong time of day. But with the 
"just commit your renames separately" approach, that's exactly what can 
happen.

Now, once again, none of the above is an argument against the automatic 
rename detection. For cases where renames are automatically detectable, 
it works fine and will continue to do so, and in fact doesn't have the 
problem of committing broken builds. I am not arguing it should be 
replaced or that the user should be required to tell git about every 
rename. But the lack of an additional manual option forces me into a 
particular workflow that I wouldn't otherwise use and prevents me from 
imposing the workflow rules I *do* want.

Hopefully that shed a little light on why I think manual rename support 
is not a totally idiotic idea.

-Steve
