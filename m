From: Sam Vilain <sam@vilain.net>
Subject: Re: [PATCH] git-fast-import: note 1M limit of mark number
Date: Wed, 16 Apr 2008 09:05:06 +1200
Message-ID: <48051882.8000201@vilain.net>
References: <20080415125222.C55C121CE8F@mail.utsl.gen.nz> <4804CECE.2040205@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Apr 15 23:03:30 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JlsIY-0004hc-6t
	for gcvg-git-2@gmane.org; Tue, 15 Apr 2008 23:02:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755028AbYDOVBx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 15 Apr 2008 17:01:53 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753211AbYDOVBx
	(ORCPT <rfc822;git-outgoing>); Tue, 15 Apr 2008 17:01:53 -0400
Received: from watts.utsl.gen.nz ([202.78.240.73]:42820 "EHLO mail.utsl.gen.nz"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752303AbYDOVBw (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 15 Apr 2008 17:01:52 -0400
Received: by mail.utsl.gen.nz (Postfix, from userid 1004)
	id 8F3F921CE96; Wed, 16 Apr 2008 09:01:50 +1200 (NZST)
X-Spam-Checker-Version: SpamAssassin 3.1.7-deb (2006-10-05) on 
	mail.musashi.utsl.gen.nz
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=5.0 tests=ALL_TRUSTED,AWL,BAYES_00 
	autolearn=ham version=3.1.7-deb
Received: from [192.168.69.233] (203-97-235-49.cable.telstraclear.net [203.97.235.49])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mail.utsl.gen.nz (Postfix) with ESMTP id F23F521CE47;
	Wed, 16 Apr 2008 09:01:41 +1200 (NZST)
User-Agent: Thunderbird 2.0.0.6 (X11/20071022)
In-Reply-To: <4804CECE.2040205@alum.mit.edu>
X-Enigmail-Version: 0.95.0
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79629>

Michael Haggerty wrote:
>> ++
>> +Note that due to current internal limitations, you may not make marks
>> +with a higher number than 1048575 (2^20-1).
>>  
>>  * A complete 40 byte or abbreviated commit SHA-1 in hex.
>>  
> 
> Oh.  Um.  That is an awkwardly small number nowadays.
> 
> cvs2svn has been used for repositories with O(2^20) distinct file
> revisions (KDE, Mozilla, NetBSD, ...).  So this limit will likely be too
> small for some users.

Right.  But, if you're not making the importer you write for a
conversion of that size restartable, you're insane.  So, marking more
than 1Mi *marks* in a single gfi session might not be so vital.

It only tripped me up because I was using a database sequence to
generate the marks, which meant I hit the ceiling.

> Moreover, cvs2git needs to generate marks for both file contents and for
> commits.  It generates the latter by adding 1000000000 to the small
> integer IDs that it uses internally.  If git-fast-import only allows
> 20-bit integers, this makes me wonder why this hasn't broken
> dramatically in the past.  Pure numerological good fortune, combined
> with weak range checking in git-fast-import?

Perhaps.  All I saw was that after I hit 1Mi for the mark ID, the mark
numbers in the returned file were drastically different from the ones I
put in.  I had a glance over this code and it seemed likely to be a
culprit - this docpatch is really more raising awareness of the problem.
 Obviously finding the fault and fixing it would be preferable.

> While I'm at it, let me also renew my suggestion that git-fast-import
> use separate namespaces ("markspaces", so to speak) for file content
> marks and for commit marks.  There is no reason for these distinct types
> of marks to be located in a shared space of integers.

There is a reason, it's because they're both just object IDs.  Is it
really that much of a drag?  I know what you mean though, it meant for
my code I had to keep track of which type each mark was.

Sam.
