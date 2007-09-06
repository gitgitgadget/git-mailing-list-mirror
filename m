From: Kyle Moffett <mrmacman_g4@mac.com>
Subject: Re: Git's database structure
Date: Wed, 5 Sep 2007 21:27:20 -0400
Message-ID: <ED15F422-C83D-4749-8B0A-24F862AB1940@mac.com>
References: <9e4733910709040823k731f0ffchba1f93bdb4a8373d@mail.gmail.com> <7vtzqany0z.fsf@gitster.siamese.dyndns.org> <9e4733910709041044r71264346n341d178565dd0521@mail.gmail.com> <20070904212507.GA24434@thunk.org> <9e4733910709041454i189e6629k78ddeb89797276b3@mail.gmail.com> <46DE5861.4050201@op5.se> <9e4733910709050641j34d58683ra72caa52c56cdf0f@mail.gmail.com> <46DEC26E.7030809@op5.se> <9e4733910709050837o61a2dedfpc5f72a239b1cb8e3@mail.gmail.com> <Pine.LNX.4.64.0709051648400.3189@reaper.quantumfyre.co.uk> <9e4733910709050912i57ed7137o6abb02ee741d394b@mail.gmail.com> <Pine.LNX.4.64.0709051823470.26016@reaper.quantumfyre.co.uk>
Mime-Version: 1.0 (Apple Message framework v752.2)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Jon Smirl <jonsmirl@gmail.com>, Andreas Ericsson <ae@op5.se>,
	Theodore Tso <tytso@mit.edu>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Julian Phillips <julian@quantumfyre.co.uk>
X-From: git-owner@vger.kernel.org Thu Sep 06 03:28:19 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IT6AG-0000X7-3P
	for gcvg-git@gmane.org; Thu, 06 Sep 2007 03:28:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757312AbXIFB2G (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 5 Sep 2007 21:28:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757300AbXIFB2F
	(ORCPT <rfc822;git-outgoing>); Wed, 5 Sep 2007 21:28:05 -0400
Received: from smtpout.mac.com ([17.250.248.184]:62245 "EHLO smtpout.mac.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757271AbXIFB2E (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 5 Sep 2007 21:28:04 -0400
Received: from mac.com (smtpin02-en2 [10.13.10.147])
	by smtpout.mac.com (Xserve/smtpout14/MantshX 4.0) with ESMTP id l861RZ4V027180;
	Wed, 5 Sep 2007 18:27:35 -0700 (PDT)
Received: from [10.0.4.100] (n150s180.ntc.blacksburg.shentel.net [204.111.150.180])
	(authenticated bits=0)
	by mac.com (Xserve/smtpin02/MantshX 4.0) with ESMTP id l861RUfn013505
	(version=TLSv1/SSLv3 cipher=AES128-SHA bits=128 verify=NO);
	Wed, 5 Sep 2007 18:27:34 -0700 (PDT)
In-Reply-To: <Pine.LNX.4.64.0709051823470.26016@reaper.quantumfyre.co.uk>
X-Mailer: Apple Mail (2.752.2)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/57795>

On Sep 05, 2007, at 13:31:43, Julian Phillips wrote:
> And this is advantaged by having the path in the blob how?  The  
> important information here is knowing which commits touched the  
> file - this information is expensive in git because it is snapshot  
> based.  You have to go back through all the commits looking for  
> changes to the given path. The information you might want to cache  
> is which commits touched the file, which you could do without  
> changing the current data storage. Presumably you are suggesting  
> that such a cache would be cleaner with the filename in the blob?   
> Or do you think that it would somehow be faster to create?  If so,  
> how?

The only possible reason I can think of for moving data into the blob  
would be to make a POSIX-compliant git-like filesystem, and EVEN THEN  
you would NOT move the path out of the tree objects.  In order to  
have somewhat consistent inodes (and also for performance when  
changing 4 bytes in a 40GB file) you would want to have 3 different  
types of "inode" objects:

1)  4-64k of (metadata + filedata)
2)  4-64k of (metadata + list of 4-64k filedata blobs)
3)  4-64k of (metadata + list of 4-64k lists of filedata blobs)

On the other hand... that isn't GIT, it's something completely  
different with a very different usage pattern and set of  
requirements.  And you still don't put the path name in the objects,  
just the permissions and other attributes/metadata.

<Random Thought Experiment>
You would of course want to better define those 4-64k limits for  
allocation and performance reasons, but a double-indirect table of  
SHA128s with 64kb chunks lets you address up to 1TB of file data, and  
for each additional power-of-two increase in the chunk size you get 8  
times the storage space.  Furthermore, the actual double-indirect  
tables for an 8TB file using 128k chunks would be all of 64MB, for a  
more reasonable 4GB file with 32k tables (max of 128GB) it would be  
maybe 128kB of indirect SHA1 hash tables.
</Random Thought Experiment>

Cheers,
Kyle Moffett
