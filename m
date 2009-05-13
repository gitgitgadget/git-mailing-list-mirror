From: Andreas Ericsson <ae@op5.se>
Subject: Re: [RFC 1/8] UTF helpers
Date: Wed, 13 May 2009 12:02:10 +0200
Message-ID: <4A0A9AA2.1000004@op5.se>
References: <1242168631-30753-1-git-send-email-robin.rosenberg@dewire.com> <1242168631-30753-2-git-send-email-robin.rosenberg@dewire.com> <alpine.DEB.1.00.0905130215260.27348@pacific.mpi-cbg.de> <200905130724.44634.robin.rosenberg@dewire.com> <4A0A91CE.3080905@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-15; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Robin Rosenberg <robin.rosenberg@dewire.com>, git@vger.kernel.org
To: Esko Luontola <esko.luontola@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 13 12:02:41 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M4BI6-0005vZ-0E
	for gcvg-git-2@gmane.org; Wed, 13 May 2009 12:02:22 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757922AbZEMKCN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 May 2009 06:02:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757828AbZEMKCN
	(ORCPT <rfc822;git-outgoing>); Wed, 13 May 2009 06:02:13 -0400
Received: from fg-out-1718.google.com ([72.14.220.153]:32682 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755242AbZEMKCN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 May 2009 06:02:13 -0400
Received: by fg-out-1718.google.com with SMTP id 16so171808fgg.17
        for <git@vger.kernel.org>; Wed, 13 May 2009 03:02:12 -0700 (PDT)
Received: by 10.86.63.5 with SMTP id l5mr981276fga.35.1242208932352;
        Wed, 13 May 2009 03:02:12 -0700 (PDT)
Received: from clix.int.op5.se ([212.112.174.166])
        by mx.google.com with ESMTPS id l19sm2854027fgb.12.2009.05.13.03.02.11
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 13 May 2009 03:02:11 -0700 (PDT)
User-Agent: Thunderbird 2.0.0.21 (X11/20090320)
In-Reply-To: <4A0A91CE.3080905@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/119021>

Esko Luontola wrote:
> Robin Rosenberg wrote on 13.5.2009 8:24:
>> If the conclusion is that this is a way forward, then I
>> could start working on a completely new set of much cleaner patches.,
> 
> That would be great!
> 
> I see that in those early patches you took the approach of converting 
> the filenames from the local encoding to UTF-8 at the outer edges of 
> Git. That obviously was the easiest way to make the changes with minimal 
> changes to Git.
> 
> I've been thinking about a bit more extensive approach, which should 
> serve the interest of all stakeholders:
> 
> 
> Now the tree object contains the following information for each file: 
> filename, mode, sha1. To that would be added one more string: filename
> encoding. Unless the encoding is specified (such as in old commits 
> before the encoding information was added), the default encoding is 
> "binary", which is the same as how Git works now (it thinks filenames as 
> series of bytes, ignoring their encoding completely).
> 

[ long and incompatible plan removed ]

> One big question is, that will this change require a change to the 
> repository format? Will it be possible to add the encoding field to the 
> tree object, without breaking compatibility with older Git clients? If 
> compatibility needs to be broken, how it can be done in a controlled 
> fashion?
> 

Generally when one wants to change one of the basic object types in
git, some extraordinary benefit has to be shown that is not aimed
at just a few people. Academic benefits (ie, "non-real-worldy") do
not fall into that category. In fact, it's so rare for someone to
provide such enormous benefit that the only time a core object format
in git has been incompatibly changed is when Linus decided that trees
should be able to have subtrees. The change reduced the repository
size for the early git-tracked Linux kernel to about 4% of its
original size, so there was a clear, undisputable and obvious benefit
huge enough to warrant breaking the git repository format entirely
just to get it in (I might have gotten those details entirely wrong,
but it was something along those lines).

So unless you can change tree objects in a way that lets older git
clients understand them while still adding this encoding cruft
(it's cruft to me), I think your chances of getting such a change
into the git core are about the size of the colour green.

If you're *really* serious about it though, here's how to go about
it:

1. Make the changes so that newer git can always read and operate
on trees without the encoding information, regardless of what the
configuration says.
2. Modify 1.4.x branch to support this new format too, at least
for reading trees with the information in it. Otherwise some
package maintainers will just ignore such compatibility.
3. Modify 1.5.x branch similarly.
5. Make it configurable, but turned off by default and with a big
fat warning when its turned on.
6. 2 years later, remove the warning.
7. 2 years lter, turn it on by default.
8. 2 years later, remove the config option and make it a new
major release, but maintain the two codepaths forever.


1.[45].x branches are imaginary. They represent the branch that
gets created when a new release in that series is necessary for
some reason.


I haven't perused Robin's patches enough to know how they would
interact with older git, and I'm not really interested in encoding
issues. English being the lingua franca of internet and opensource
development anyways, every project I've ever seen has only files
named in a manner that would fit nicely into 7-bit ascii.

-- 
Andreas Ericsson                   andreas.ericsson@op5.se
OP5 AB                             www.op5.se
Tel: +46 8-230225                  Fax: +46 8-230231

Register now for Nordic Meet on Nagios, June 3-4 in Stockholm
 http://nordicmeetonnagios.op5.org/

Considering the successes of the wars on alcohol, poverty, drugs and
terror, I think we should give some serious thought to declaring war
on peace.
