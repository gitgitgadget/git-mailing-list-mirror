From: Andreas Ericsson <ae@op5.se>
Subject: Re: git-send-mail in sh
Date: Sat, 26 Nov 2005 23:35:38 +0100
Message-ID: <4388E33A.8000004@op5.se>
References: <4386DD45.6030308@op5.se>	<7v7jaxou5b.fsf@assigned-by-dhcp.cox.net> <43874935.2080804@op5.se> <7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Nov 26 23:36:39 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([209.132.176.167])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1Eg8e0-0000l4-T4
	for gcvg-git@gmane.org; Sat, 26 Nov 2005 23:35:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750760AbVKZWfk (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sat, 26 Nov 2005 17:35:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750766AbVKZWfk
	(ORCPT <rfc822;git-outgoing>); Sat, 26 Nov 2005 17:35:40 -0500
Received: from linux-server1.op5.se ([193.201.96.2]:55203 "EHLO
	smtp-gw1.op5.se") by vger.kernel.org with ESMTP id S1750760AbVKZWfk
	(ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Nov 2005 17:35:40 -0500
Received: from [192.168.1.19] (1-2-9-7a.gkp.gbg.bostream.se [82.182.116.44])
	by smtp-gw1.op5.se (Postfix) with ESMTP
	id B17366BCBE; Sat, 26 Nov 2005 23:35:38 +0100 (CET)
User-Agent: Mozilla Thunderbird 1.0.7-1.1.fc3 (X11/20050929)
X-Accept-Language: en-us, en
To: Junio C Hamano <junkio@cox.net>
In-Reply-To: <7vwtiwmvfp.fsf@assigned-by-dhcp.cox.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/12790>

Junio C Hamano wrote:
> Andreas Ericsson <ae@op5.se> writes:
> 
> 
>>It doesn't CC them, but any number of email-addresses can be specified 
>>on the command line (so long as they don't include spaces, but that can 
>>be taken care of).
> 
> 
> Again I do not think I'd ever use that feature from the original
> send-email myself, but the difference is that this CC list
> depends on each commit (sign-offs taken from a commit are
> added to CC list for only that commit).
> 

Had a thinko when I wrote that. I've added --cc-signers, --cc-author and 
--cc (for both --cc-signers and --cc-author).

> But you are right.  We could make a single <commit> a short-hand
> for "origin"..<commit>;


Actually, I meant that a single <commit> would mean "<commit>..HEAD", 
like git-format-patch does it. Doing the other way around in a tool so 
closely coupled would be very confusing, I think.

Here's what I have on disk right now. The ${var##*^} syntax was decided 
to be portable in some earlier discussion, so I'm sticking with it 
(mostly because I don't know how to do it with expr and Junio pokes me 
when I do it with sed. Enlightenment welcome).

if [ "$com2" ]; then
     range="$com1..$com2"
else
     case "$com1" in
         ?*..?*)
             # nicely ranged already
             range="$com1"
             ;;
         ..)
             range=origin..HEAD
             ;;
         ?*^)
             # single commit
             com1="${com1##*^}"
             range="$com1^1..$com1"
             ;;
         ?*^[0-9]|?*^[0-9][0-9])
             # series of commits, ranging back from <commit-ish>
             range="$com1..${com1%%^*}"
             ;;
         ^[0-9]|^[0-9][0-9])
             # series of commits, ranging back from HEAD
             range="HEAD$com1..HEAD"
             ;;
         *)
             range="$com1..HEAD"
             ;;
     esac
fi

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231
