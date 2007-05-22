From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [PATCH] Prevent megablobs from gunking up git packs
Date: Wed, 23 May 2007 01:44:37 +0200
Message-ID: <200705230144.38290.jnareb@gmail.com>
References: <46528A48.9050903@gmail.com> <f2uigr$ufj$1@sea.gmane.org> <56b7f5510705220959x1b37a4adk537cc0cba1a27530@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, "Junio C Hamano" <junkio@cox.net>
To: "Dana How" <danahow@gmail.com>
X-From: git-owner@vger.kernel.org Wed May 23 01:45:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Hqe2O-0000PR-Fh
	for gcvg-git@gmane.org; Wed, 23 May 2007 01:45:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758178AbXEVXom (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Tue, 22 May 2007 19:44:42 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758288AbXEVXom
	(ORCPT <rfc822;git-outgoing>); Tue, 22 May 2007 19:44:42 -0400
Received: from ug-out-1314.google.com ([66.249.92.174]:22661 "EHLO
	ug-out-1314.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757791AbXEVXol (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 22 May 2007 19:44:41 -0400
Received: by ug-out-1314.google.com with SMTP id 44so460867uga
        for <git@vger.kernel.org>; Tue, 22 May 2007 16:44:39 -0700 (PDT)
DKIM-Signature: a=rsa-sha1; c=relaxed/relaxed;
        d=gmail.com; s=beta;
        h=domainkey-signature:received:received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=R6oBbhFu1wDistAwDsGeNdmtsCTYVk+0PonrPhkVFpTrmxrhARK8mICfHLuskPQFGllSXJTBVO/WlCdIcykeHILSKgEkpQGWAkMgIAt+cCIKt8fczZtfDSZaUNoI9Y5oC+XiSj0MQD1tlF/yyjotCkGoedK83gOOrGPNkFzBH1o=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=beta;
        h=received:from:to:subject:date:user-agent:cc:references:in-reply-to:mime-version:content-type:content-transfer-encoding:content-disposition:message-id;
        b=P8KNaX543NWPF0FLuvciAjV5TqVrRDoQ3t77T+Covk8Ox/6oZVVOxHPfEEpiK3FYMncPaS9aZ4Pe5FBuSyDWuWOgakHL/44QeLH+zWHX6sPUINnmayNwXstzrDASw6qzkv/nt7Chj5B9twCAl+U7g7RUAXvEKJKfqpARXdGar5g=
Received: by 10.67.93.7 with SMTP id v7mr929695ugl.1179877479905;
        Tue, 22 May 2007 16:44:39 -0700 (PDT)
Received: from host-89-229-25-173.torun.mm.pl ( [89.229.25.173])
        by mx.google.com with ESMTP id y6sm324794mug.2007.05.22.16.44.37;
        Tue, 22 May 2007 16:44:39 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <56b7f5510705220959x1b37a4adk537cc0cba1a27530@mail.gmail.com>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/48132>

Dana How wrote:
> On 5/22/07, Jakub Narebski <jnareb@gmail.com> wrote:
>> Dana How wrote:

>>> There's actually an even more extreme example from my day job.
>>> The software team has a project whose files/revisions would be
>>> similar to those in the linux kernel (larger commits, I'm sure).
>>> But they have *ONE* 500MB file they check in because it takes
>>> 2 or 3 days to generate and different people use different versions of it.
>>> I'm sure it has 50+ revisions now. If they converted to git and included
>>> these blobs in their packfile, that's a 25GB uncompressed increase!
>>> *Every* git operation must wade through 10X -- 100X more packfile.
>>> Or it could be kept in 50+ loose objects in objects/xx ,
>>> requiring a few extra syscalls by each user to get a new version.
>>
>> Or keeping those large objects in separate, _kept_ packfile, containing
>> only those objects (which can delta well, even if they are large).
> 
> Yes, I experimented with various changes to git-repack and
> having it create .keep files just before coming up with the maxblobsize
> approach.  The problem with a 12GB+ repo is not only the large
> repack time,  but the fact that the repack time keeps growing with
> the repo size.  So, with split packs, I had repack create .keep
> files for all new packs except the last (fragmentary) one.  The next
> repack would then only repack new stuff plus the single fragmentary
> pack, keeping repack time from growing (until you deleted the .keep
> files [just the ones with "repack" in them] to start over from scratch).
> But this approach is not going to distribute commits and trees all that well.

No, I was thinking about separate _kept_ pack (so it would be not 
repacked unless -f option is given) containing _only_ the large blobs.
The only difference between this and your proposal is that megablobs
would be in their mergablobs pack, but not loose.

-- 
Jakub Narebski
Poland
