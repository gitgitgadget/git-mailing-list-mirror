From: Juergen Ruehle <j.ruehle@bmiag.de>
Subject: Re: [PATCH 2/2] git-reset <tree> -- <path> restores absense of <path> in <tree>
Date: Fri, 5 Jan 2007 17:17:49 +0100
Message-ID: <17822.31277.52000.636821@lapjr.intranet.kiel.bmiag.de>
References: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 05 17:19:02 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1H2rlr-0002yD-At
	for gcvg-git@gmane.org; Fri, 05 Jan 2007 17:18:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1161139AbXAEQSK (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Fri, 5 Jan 2007 11:18:10 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1161140AbXAEQSK
	(ORCPT <rfc822;git-outgoing>); Fri, 5 Jan 2007 11:18:10 -0500
Received: from bilbo.bmiag.de ([62.154.210.131]:1634 "HELO bilbo.bmiag.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1161139AbXAEQSJ (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 5 Jan 2007 11:18:09 -0500
Received: (qmail 1211 invoked by uid 106); 5 Jan 2007 16:18:04 -0000
Received: from eorl.intranet.kiel.bmiag.de(10.131.2.1)
 via SMTP by bilbo.bmiag.de, id smtpd6nznb3; Fri Jan  5 17:17:56 2007
Received: from localhost (localhost.localdomain [127.0.0.1])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id 644BA3ADC8;
	Fri,  5 Jan 2007 17:17:56 +0100 (CET)
Received: from eorl.intranet.kiel.bmiag.de ([127.0.0.1])
	by localhost (eorl [127.0.0.1]) (amavisd-new, port 10024) with ESMTP
	id 03168-09; Fri, 5 Jan 2007 17:17:51 +0100 (CET)
Received: from LAPJR (lapjr.intranet.kiel.bmiag.de [10.191.7.182])
	by eorl.intranet.kiel.bmiag.de (Postfix) with ESMTP id D43DD3ADC6;
	Fri,  5 Jan 2007 17:17:50 +0100 (CET)
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vmz4xiz6t.fsf@assigned-by-dhcp.cox.net>
X-Mailer: VM 7.19 under Emacs 21.3.1
X-Virus-Scanned: by amavisd-new-20030616-p10 (Debian) at eorl.intranet.kiel.bmiag.de
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/36005>

Junio C Hamano writes:
 > When <path> exists in the index (either merged or unmerged), and
 > <tree> does not have it, git-reset should be usable to restore
 > the absense of it from the tree.  This implements it.

Great! It took some time, but I think I understand now why the first
part was even necessary:-)

 > diff --git a/git-reset.sh b/git-reset.sh
 > index a969370..76c8a81 100755
 > --- a/git-reset.sh
 > +++ b/git-reset.sh
 > @@ -44,8 +44,10 @@ if test $# != 0
 >  then
 >  	test "$reset_type" == "--mixed" ||
 >  		die "Cannot do partial $reset_type reset."
 > -	git ls-tree -r --full-name $rev -- "$@" |
 > -	git update-index --add --index-info || exit
 > +
 > +	git-diff-index --cached $rev -- "$@" |
 > +	sed -e 's/^:\([0-7][0-7]*\) [0-7][0-7]* \([0-9a-f][0-9a-f]*\) [0-9a-f][0-9a-f]* [A-Z]	\(.*\)$/\1 \2	\3/' |
 > +	git update-index --add --remove --index-info || exit

All other scripts calling update-index --index-info don't mention
add/remove (which are ignored anyway). Might be useful as a reminder
though.

 >  	git update-index --refresh
 >  	exit
 >  fi
