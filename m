From: Pavel Roskin <proski@gnu.org>
Subject: Re: Implementing branch attributes in git config
Date: Tue, 09 May 2006 00:20:25 -0400
Message-ID: <1147148425.4453.43.camel@dv>
References: <1147037659.25090.25.camel@dv>
	 <Pine.LNX.4.64.0605071629080.3718@g5.osdl.org>
	 <1147048587.17371.13.camel@dv>
	 <Pine.LNX.4.64.0605071740550.3718@g5.osdl.org>
	 <7vfyjli9vf.fsf@assigned-by-dhcp.cox.net>
	 <BAYC1-PASMTP0334B471C6908E4E40BFD2AEA80@CEZ.ICE>
	 <7vbqu9i6zl.fsf@assigned-by-dhcp.cox.net>
	 <BAYC1-PASMTP110777A694DAF1D7623895AEA80@CEZ.ICE>
	 <Pine.LNX.4.64.0605081905240.6713@iabervon.org>
	 <BAYC1-PASMTP0453E2D70B10C6D116167EAEA80@CEZ.ICE>
	 <Pine.LNX.4.63.0605090142280.5778@wbgn013.biozentrum.uni-wuerzburg.de>
	 <BAYC1-PASMTP03ADC2F3E75E482ADC5CD3AEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605081731440.3718@g5.osdl.org>
	 <7virogc90u.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605081801360.3718@g5.osdl.org>
	 <7v1wv4c7wk.fsf@assigned-by-dhcp.cox.net>
	 <Pine.LNX.4.64.0605081854190.3718@g5.osdl.org>
	 <BAYC1-PASMTP04C9C4BF5B89E55B9D877AAEA90@CEZ.ICE>
	 <Pine.LNX.4.64.0605082007100.3718@g5.osdl.org>
	 <20060508230752.43118643.seanlkml@sympatico.ca>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
X-From: git-owner@vger.kernel.org Tue May 09 06:20:43 2006
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1FdJiB-0007px-9a
	for gcvg-git@gmane.org; Tue, 09 May 2006 06:20:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751368AbWEIEU2 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 9 May 2006 00:20:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751369AbWEIEU2
	(ORCPT <rfc822;git-outgoing>); Tue, 9 May 2006 00:20:28 -0400
Received: from fencepost.gnu.org ([199.232.76.164]:6053 "EHLO
	fencepost.gnu.org") by vger.kernel.org with ESMTP id S1751368AbWEIEU2
	(ORCPT <rfc822;git@vger.kernel.org>); Tue, 9 May 2006 00:20:28 -0400
Received: from proski by fencepost.gnu.org with local (Exim 4.34)
	id 1FdJhz-0001i5-1v
	for git@vger.kernel.org; Tue, 09 May 2006 00:20:27 -0400
Received: from proski by dv.roinet.com with local (Exim 4.62)
	(envelope-from <proski@dv.roinet.com>)
	id 1FdJhx-0004OY-Fr
	for git@vger.kernel.org; Tue, 09 May 2006 00:20:25 -0400
To: git@vger.kernel.org
In-Reply-To: <20060508230752.43118643.seanlkml@sympatico.ca>
X-Mailer: Evolution 2.6.1 (2.6.1-3) 
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/19815>

Hello!

I feel so bad that I sparked this discussion about config files and
couldn't participate in it in real time.  I'd like to summarize my
thoughts on the subject - maybe they will help us come to an agreement.

User convenience trumps backward compatibility.

Case in-sensitivity is almost a foreign concept for POSIX.  There is no
expectation (except among newbies) that bash would run grep if it's
asked to run Grep.  Why would git-repo-config need to foster such
expectations, and do so inconsistently, e.g. for key names but not for
values?

The config files use escaping by backslash, which is easier to work with
than quoting.  Quoting should be introduced if backslash escaping
doesn't work, and I think backslash escaping in fine.

Users who edit the config file manually and mindlessly get what they
deserve.  Users who misspell "master" as "Master" get what they deserve.
Occasional typos could be caught and reported if practical, but hand
holding shouldn't be a design goal.

Either we need the third layer in key hierarchy, and that layer should
support user defined strings, or we need to relax one of the layers to
user define strings.  User defined means that it can include spaces,
slashes, dots and many other characters.  Whenever a character is not
allowed, we should have a good reason.

An example of two-layer approach:

[branchdescriptions]
	master = My master branch
	netdev-master = Patches for netdev
[branchremotes]
	master = origin
	netdev-master = netdev

All other examples quoted here are examples of three-layer approach.
Either the extra key is inserted into the section name (Linus) or into
the value (Dscho).  It can also be inserted into the existing key.

If we want to group all branch properties for each branch, we have to go
three-layer.  If we don't want that, the above example should accepted
as the simplest approach.

Adding an additional key layer to the existing keys is syntactically
nice, but buys us very little in terms of ability to group branch data:

[branchdata]
	remote[master] = origin
	remote[netdev-master] = master
	description[master] = My master branch
	description[netdev-master] = Patches for netdev

Adding an additional key layer to the value is inherently fragile.  The
value has free format, and so is the new key.  It also has the same
problem that the data for different branches is mixed together.

Adding an additional key layer to the section name looks strange
syntactically, but it's the approach that gives us immediate grouping of
all branch data for every branch.

My personal preference is the Linus' proposal, but with backslash
escaping instead of quoting, with explicit "branch." in the section
names, and with case sensitive sections and keys.

-- 
Regards,
Pavel Roskin
