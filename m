From: Pete Wyckoff <pw@padd.com>
Subject: Re: [PATCHv2 02/11] git-p4: test debug macro
Date: Sun, 18 Dec 2011 08:50:47 -0500
Message-ID: <20111218135047.GA16487@padd.com>
References: <1324147942-21558-1-git-send-email-pw@padd.com>
 <1324147942-21558-3-git-send-email-pw@padd.com>
 <4EED1B06.80007@diamand.org>
 <20111218013651.GA18735@padd.com>
 <20111218032238.GA6368@elie.hsd1.il.comcast.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Luke Diamand <luke@diamand.org>, git@vger.kernel.org
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Sun Dec 18 14:50:59 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcH8j-0002kh-Tz
	for gcvg-git-2@lo.gmane.org; Sun, 18 Dec 2011 14:50:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751823Ab1LRNux (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 18 Dec 2011 08:50:53 -0500
Received: from honk.padd.com ([74.3.171.149]:40275 "EHLO honk.padd.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751686Ab1LRNuv (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 18 Dec 2011 08:50:51 -0500
Received: from arf.padd.com (unknown [50.55.144.134])
	by honk.padd.com (Postfix) with ESMTPSA id 8F839339A;
	Sun, 18 Dec 2011 05:50:50 -0800 (PST)
Received: by arf.padd.com (Postfix, from userid 7770)
	id 7FBA5313F0; Sun, 18 Dec 2011 08:50:47 -0500 (EST)
Content-Disposition: inline
In-Reply-To: <20111218032238.GA6368@elie.hsd1.il.comcast.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187421>

jrnieder@gmail.com wrote on Sat, 17 Dec 2011 21:26 -0600:
> Pete Wyckoff wrote:
> 
> > +	# 2 is SIGINT, ash/dash does not know symbolic names
> > +	trap echo 2
> 
> 'trap "$cmd" INT' works, and it's even in POSIX. ;)
> http://pubs.opengroup.org/onlinepubs/9699919799/utilities/V3_chap02.html#trap

Nice!  But ash/dash handle subshell INT differently.  With ash,
the entire test exits after the ctrl-C, even if caught by a trap in a
subshell.  Not so nice.  Here's a demonstration.

-----------8<-------------
# shell top.sh
echo top.sh
$SHELL trap.sh
echo top.sh: exit status from trap.sh: $?
echo top.sh: exiting
exit 0
-----------8<-------------

-----------8<-------------
# shell trap.sh
echo trap.sh
trap "echo trap.sh caught INT" INT
sleep 3600
trap - INT
echo trap.sh: exiting
exit 0
-----------8<-------------

Run "bash top.sh".  Hit ctrl-c, you'll see:

    $ bash top.sh
    top.sh
    trap.sh
    ^Ctrap.sh caught INT
    trap.sh: exiting
    top.sh: exit status from trap.sh: 0
    top.sh: exiting

Similarly with "ash top.sh":

    $ ash top.sh
    top.sh
    trap.sh
    ^Ctrap.sh caught INT
    trap.sh: exiting

The top-level script also gets the ctrl-c, but exits on the INT
anyway, after reaping its child.  I can't find where POSIX says
if this is correct or not.  It isn't how I want it to work here.

I'll add a comment above debug() to explain that it works in bash
but not ash.  At least it prints out the P4 environment
information needed to debug.

		-- Pete
