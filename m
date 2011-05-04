From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH 1/1] Honor $(prefix) set in config.mak* when defining
 ETC_GIT* and sysconfdir
Date: Wed, 04 May 2011 16:39:54 +0200
Message-ID: <4DC1653A.7000000@viscovery.net>
References: <20110428022922.GC4833@camk.edu.pl> <7v62py5nbp.fsf@alter.siamese.dyndns.org> <20110428192751.GE4833@camk.edu.pl> <4DBFA3C6.8060209@viscovery.net> <7vzkn3itb5.fsf@alter.siamese.dyndns.org> <4DC0E99E.6090402@viscovery.net> <20110504135827.GC18585@camk.edu.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-2
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Kacper Kornet <kornet@camk.edu.pl>
X-From: git-owner@vger.kernel.org Wed May 04 16:40:10 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QHdFK-0002g2-5g
	for gcvg-git-2@lo.gmane.org; Wed, 04 May 2011 16:40:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754313Ab1EDOkB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 May 2011 10:40:01 -0400
Received: from lilzmailso01.liwest.at ([212.33.55.23]:5490 "EHLO
	lilzmailso01.liwest.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754208Ab1EDOkA (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 May 2011 10:40:00 -0400
Received: from cpe228-254-static.liwest.at ([81.10.228.254] helo=theia.linz.viscovery)
	by lilzmailso01.liwest.at with esmtpa (Exim 4.69)
	(envelope-from <j.sixt@viscovery.net>)
	id 1QHdF5-0003sT-Eb; Wed, 04 May 2011 16:39:55 +0200
Received: from [127.0.0.1] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id 229DD1660F;
	Wed,  4 May 2011 16:39:55 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows; U; Windows NT 5.1; de; rv:1.9.2.17) Gecko/20110414 Thunderbird/3.1.10
In-Reply-To: <20110504135827.GC18585@camk.edu.pl>
X-Enigmail-Version: 1.1.1
X-Spam-Score: -1.4 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172746>

Am 5/4/2011 15:58, schrieb Kacper Kornet:
> On Wed, May 04, 2011 at 07:52:30AM +0200, Johannes Sixt wrote:
>> Looking closer, the patch introduces git_etcdir for no good reason,
>> IIUC.
>> It should just re-use sysconfdir (the meaning of this variable is to
>> point
>> to the etc directory).
> 
> And the first version of my patch did it. However Junio has written:
> 
>> But this part in the Makefile outside the context of the patch bothers
>> me.  It seems to imply that sysconfdir is _not_ that variable you want
>> to
>> define later.
>>
>>    # Among the variables below, these:
>>    #   gitexecdir
>>    #   template_dir
>>    #   mandir
>>    #   infodir
>>    #   htmldir
>>    #   ETC_GITCONFIG (but not sysconfdir)
>>    #   ETC_GITATTRIBUTES
>>    # can be specified as a relative path some/where/else;
>>
>> So I have a suspicion that your patch as is will break when prefix is
>> set
>> to something other than /usr directory.  I don't think anybody in-tree
>> currently uses sysconfdir, but that does not mean nobody will ever do.
> 
>>From that I understood that he prefers sysconfdir to be always an
> absolute path.

Junio's worries should not be discarded lightly. But in this case they are
unfounded. Digging the history shows:

b51b8bbf (Create a sysconfdir variable, and use it for ETC_GITCONFIG,
2007-04-24) introduced the variable to be able to treat the special case
where prefix == /usr. It was never intended as a user-settable value.

In 49fa65a7 (Allow the built-in exec path to be relative to the command
invocation path, 2008-07-23), I added the comment above because at that
time, a relocatable build should be requested by setting ETC_GITCONFIG to
a relative path, but not by changing sysconfdir. (The comment sounds as if
the user can set sysconfdir, but I did not intend to say that.)

026fa0d5 (Move computation of absolute paths from Makefile to runtime (in
preparation for RUNTIME_PREFIX), 2009-01-18) practically obsoleted
sysconfdir. In particular, it removed one of the cases where the value of
sysconfdir mattered, leaving only the reference where it is guaranteed to
be set to /etc. This commit could have removed sysconfdir entirely.

6df42ab9 (Add global and system-wide gitattributes, 2010-09-01) added
another consumer of sysconfdir, but in the same spirit as ETC_GITCONFIG.

So, I don't think that sysconfdir must survive. It was always only a
helper variable to shorten the code.

-- Hannes
