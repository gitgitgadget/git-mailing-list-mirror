From: Mark Levedahl <mdl123@verizon.net>
Subject: Re: [PATCH] git-bundle - bundle objects and references for
 disconnected   transfer.
Date: Wed, 14 Feb 2007 21:32:13 -0500
Message-ID: <45D3C62D.6090609@verizon.net>
References: <11714622292110-git-send-email-mdl123@verizon.net>
 <11714622292295-git-send-email-mdl123@verizon.net>
 <Pine.LNX.4.63.0702142238310.22628@wbgn013.biozentrum.uni-wuerzburg.de>
 <45D398F9.6070205@verizon.net>
 <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Thu Feb 15 03:32:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HHWQD-0008CM-Nx
	for gcvg-git@gmane.org; Thu, 15 Feb 2007 03:32:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S964860AbXBOCc3 (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 14 Feb 2007 21:32:29 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S964866AbXBOCc3
	(ORCPT <rfc822;git-outgoing>); Wed, 14 Feb 2007 21:32:29 -0500
Received: from vms042pub.verizon.net ([206.46.252.42]:52638 "EHLO
	vms042pub.verizon.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964860AbXBOCc2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Feb 2007 21:32:28 -0500
Received: from [127.0.0.1] ([71.246.235.75])
 by vms042.mailsrvcs.net (Sun Java System Messaging Server 6.2-6.01 (built Apr
 3 2006)) with ESMTPA id <0JDH00KVYGDRI782@vms042.mailsrvcs.net> for
 git@vger.kernel.org; Wed, 14 Feb 2007 20:32:16 -0600 (CST)
In-reply-to: <Pine.LNX.4.63.0702150054210.22628@wbgn013.biozentrum.uni-wuerzburg.de>
Newsgroups: gmane.comp.version-control.git
User-Agent: Thunderbird 1.5.0.9 (Windows/20061207)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/39791>

Johannes Schindelin wrote:
> Hi,
> 
> On Wed, 14 Feb 2007, Mark Levedahl wrote:
> 
> 
> Ah, I just realized that you do not shift. This is wrong. For example,
> 
> 	git bundle --output=a1 a..b
> 
> would pass "--output=a1 a..b" to git-rev-parse. While you say 
> "--revs-only", this would work, but so would "these are no refs". You lose 
> valuable information that way (namely invalid parameters). The standard 
> shell way is nicely visible in git-tag.sh (see the while loop). It is 
> basically
> 
> while case "$#" in 0) break ;; esac
> do
> 	case "$1" in
> 	--output)
> 		# handle $1 (and check that you can write to it).
> 		;;
> 	-*)
> 		usage
> 		;;
> 	*)
> 		break
> 	esac
> done

And that loop would always abort on things meant for git-rev-list. I 
want to avoid making git-bundle have to understand everything that is 
legal to git-rev-list. The current construct does this: it lets 
git-rev-parse remove what that function knows, aborting if something is 
amiss (or aborting later in git-rev-list), leaving git-bundle's parser 
to chew on the rest. I really don't see a way out of the dilemma: either 
allow --output foo but don't barf on bad arguments, or only accept 
--output=foo and be able to trap errors, or teach git-bundle everything 
that is valid for the other two.  (Let me write this in python, the 
dilemma is gone).

>>>   
>> Originally, this was in python with zip file built in memory (no 
>> temporaries). Sticking to portable shell makes many easy things really 
>> hard.
> 
> Not if you just pipe the two parts (refs & pack) into the output. Piping 
> also allows for "--output -" meaning stdout...

git-unbundle uses no temporary files: it pipes directly from tar (was 
zip, but I've changed to tar per Junio's request).

The problem is creating the tar: I know of no way to create a tar file 
with two separately addressable items, both created by piping in to 
stdin. If there are not two streams, I don't know how to split the data 
in sh without mangling the pack file due to sh variable substitution 
rules. So, I think the temporary file solution is a reasonable compromise.
> 
> Not at all. I meant to verify that these _hashes_ exist as commits. Not 
> necessarily refs.

See my other note.

>
> 
> We have shallow clones. This means that you can mark commits as "fake 
> root" commits, i.e. even if they have parents, they are treated as if they 
> had no parents. You do this by adding the hashes of the shallow commits to 
> ..git/shallow. For a short description, search for "shallow" in 
> Documentation/glossary.txt.

Thanks.

> 
> Ciao,
> Dscho
> 

Mark
