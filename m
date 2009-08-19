From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: Continue git clone after interruption
Date: Wed, 19 Aug 2009 17:19:50 +0200
Message-ID: <200908191719.52974.jnareb@gmail.com>
References: <1250509342.2885.13.camel@cf-48> <200908182302.10619.jnareb@gmail.com> <alpine.LFD.2.00.0908181711350.6044@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Tomasz Kontusz <roverorna@gmail.com>, git <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Wed Aug 19 17:20:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MdmxM-00022o-Jw
	for gcvg-git-2@lo.gmane.org; Wed, 19 Aug 2009 17:20:09 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752110AbZHSPT6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 19 Aug 2009 11:19:58 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbZHSPT6
	(ORCPT <rfc822;git-outgoing>); Wed, 19 Aug 2009 11:19:58 -0400
Received: from fg-out-1718.google.com ([72.14.220.158]:18040 "EHLO
	fg-out-1718.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752011AbZHSPT5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 19 Aug 2009 11:19:57 -0400
Received: by fg-out-1718.google.com with SMTP id e21so1080337fga.17
        for <git@vger.kernel.org>; Wed, 19 Aug 2009 08:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=Fh4+nifyRvDkieTe9VTOCyQDVGIrUQ0SJHrzanSMH2s=;
        b=kXhCpqmjOI0vMfNwI+lGIu6WtpNwNLEOIbPOyf3F/s9S5Acj/lwJmWSSt0YNwk8shb
         Os6O0l9qG48BG3V+FPy91RJ59K5i97rqZOVS28ehoEYznjt5dY3REKBElUlhTkWYwt2i
         fUc+shhlXd6+Qurz2LnaG8k7nHci140JCyNdk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=XvN4LkHVL/9+4229i8kC8/hghQo1+IVby/Fet3eYXEk2dU6dMseza7lq6GqlMKq5Q6
         j6NIF3836zeUnzojGJ/whN1W8R4Pf5tQ7Hl13kqozzRFKNgQOXmSjAWGYyOSNADadHzO
         +ayd23cqaGbwp31hvWmvcpwfI/I27umwJ7nbM=
Received: by 10.86.173.4 with SMTP id v4mr4309073fge.78.1250695197637;
        Wed, 19 Aug 2009 08:19:57 -0700 (PDT)
Received: from ?192.168.1.13? (abvk137.neoplus.adsl.tpnet.pl [83.8.208.137])
        by mx.google.com with ESMTPS id l19sm732453fgb.12.2009.08.19.08.19.56
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Wed, 19 Aug 2009 08:19:56 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <alpine.LFD.2.00.0908181711350.6044@xanadu.home>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/126549>

On Tue, 18 Aug 2009, Nicolas Pitre wrote:
> On Tue, 18 Aug 2009, Jakub Narebski wrote:
> 
>> You can probably get number and size taken by delta and non-delta (base)
>> objects in the packfile somehow.  Neither "git verify-pack -v <packfile>"
>> nor contrib/stats/packinfo.pl did help me arrive at this data.
> 
> Documentation for verify-pack says:
> 
> |When specifying the -v option the format used is:
> |
> |        SHA1 type size size-in-pack-file offset-in-packfile
> |
> |for objects that are not deltified in the pack, and
> |
> |        SHA1 type size size-in-packfile offset-in-packfile depth base-SHA1
> |
> |for objects that are deltified.
> 
> So a simple script should be able to give you the answer.

Thanks.

There are 114937 objects in this packfile, including 56249 objects
used as base (can be deltified or not).  git-verify-pack -v shows
that all objects have total size-in-packfile of 33 MB (which agrees
with packfile size of 33 MB), with 17 MB size-in-packfile taken by
deltaified objects, and 16 MB taken by base objects.

  git verify-pack -v | 
    grep -v "^chain" | 
    grep -v "objects/pack/pack-" > verify-pack.out

  sum=0; bsum=0; dsum=0; 
  while read sha1 type size packsize off depth base; do
    echo "$sha1" >> verify-pack.sha1.out
    sum=$(( $sum + $packsize ))
    if [ -n "$base" ]; then 
       echo "$sha1" >> verify-pack.delta.out
       dsum=$(( $dsum + $packsize ))
    else
       echo "$sha1" >> verify-pack.base.out
       bsum=$(( $bsum + $packsize ))
    fi
  done < verify-pack.out
  echo "sum=$sum; bsum=$bsum; dsum=$dsum"
 
>>>> (BTW what happens if this pack is larger than file size limit for 
>>>> given filesystem?).
[...]

>> If I remember correctly FAT28^W FAT32 has maximum file size of 2 GB.
>> FAT is often used on SSD, on USB drive.  Although if you have  2 GB
>> packfile, you are doing something wrong, or UGFWIINI (Using Git For
>> What It Is Not Intended).
> 
> Hopefully you're not performing a 'git clone' off of a FAT filesystem.  
> For physical transport you may repack with the appropriate switches.

Not off a FAT filesystem, but into a FAT filesystem.
 
[...]

>>> I think it is better to "prime" the repository with the content of the 
>>> top commit in the most straight forward manner using git-archive which 
>>> has the potential to be fully restartable at any point with little 
>>> complexity on the server side.
>> 
>> But didn't it make fully restartable 2.5 MB part out of 37 MB packfile?
> 
> The front of the pack is the critical point.  If you get enough to 
> create the top commit then further transfers can be done incrementally 
> with only the deltas between each commits.

How?  You have some objects that can be used as base; how to tell 
git-daemon that we have them (but not theirs prerequisites), and how
to generate incrementals?

>> A question about pack protocol negotiation.  If clients presents some
>> objects as "have", server can and does assume that client has all 
>> prerequisites for such objects, e.g. for tree objects that it has
>> all objects for files and directories inside tree; for commit it means
>> all ancestors and all objects in snapshot (have top tree, and its 
>> prerequisites).  Do I understand this correctly?
> 
> That works only for commits.

Hmmmm... how do you intent for "prefetch top objects restartable-y first"
to work, then?
 
>> BTW. because of compression it might be more difficult to resume 
>> archive creation in the middle, I think...
> 
> Why so?  the tar+gzip format is streamable.

gzip format uses sliding window in compression.  "cat a b | gzip"
is different from "cat <(gzip a) <(gzip b)".

But that doesn't matter.  If we are interrupted in the middle, we can
uncompress what we have to check how far did we get, and tell server
to send the rest; this way server wouldn't have to even generate 
(but not send) what we get as partial transfer.

P.S. What do you think about 'bundle' capability extension mentioned
     in a side sub-thread?
-- 
Jakub Narebski
Poland
