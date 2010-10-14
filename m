From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: Why is "git tag --contains" so slow?
Date: Thu, 14 Oct 2010 13:59:45 -0500
Message-ID: <20101014185945.GA14634@burratino>
References: <E1OU82h-0001xY-3b@closure.thunk.org>
 <AANLkTikkLIKm3soF9agXnN34P7Xnq4AiVqGU_qFaaRmZ@mail.gmail.com>
 <20100701121711.GF1333@thunk.org>
 <20100701150331.GA12851@sigill.intra.peff.net>
 <20100701153842.GA15466@sigill.intra.peff.net>
 <20100702192612.GM1333@thunk.org>
 <20100703080618.GA10483@sigill.intra.peff.net>
 <20100704005543.GB6384@thunk.org>
 <20100705122723.GB21146@sigill.intra.peff.net>
 <20100705123923.GC21146@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tytso@mit.edu, Avery Pennarun <apenwarr@gmail.com>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Oct 14 21:03:23 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1P6T5H-0005pC-Dv
	for gcvg-git-2@lo.gmane.org; Thu, 14 Oct 2010 21:03:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755466Ab0JNTDR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Oct 2010 15:03:17 -0400
Received: from mail-ew0-f46.google.com ([209.85.215.46]:51319 "EHLO
	mail-ew0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754930Ab0JNTDQ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Oct 2010 15:03:16 -0400
Received: by ewy20 with SMTP id 20so3830363ewy.19
        for <git@vger.kernel.org>; Thu, 14 Oct 2010 12:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=IqOGlLDwAvtH4vV07jUSLn3/totfV2k1JAKcSDAUDgs=;
        b=v8MimAyvVNdasRT964hIDhGj6Hc4fyzgA/Gl+T21v4DxeooFDo2lYqElv7DLVY8nz9
         JeZVVGRI0BuzaE0/isu1bH7SLmZJd4Z8jUjLqXptHoadkvFNpGMIQ01K7DmO+WrYA82K
         I3fGEYrvpxkzJgmtgj33UuzYL3AAhqzBwCkTw=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=Wa4ykTMFpMQpE3e0X2LHFLjlJmJdEYl5trQE1wk57s5/F7qg72bMn3xK3RH3DDH8yw
         bGorA3Wmk5m16THa8n++4U7r5utEe0eYxTAB2mnbD66j6QsYvZNiK8Y06urg0SCzF/eh
         vBvwb1uVm4qRisi9C9iQXdA1D3v4nlT4wktR8=
Received: by 10.213.22.66 with SMTP id m2mr2347378ebb.56.1287082994838;
        Thu, 14 Oct 2010 12:03:14 -0700 (PDT)
Received: from burratino (adsl-68-255-106-176.dsl.chcgil.ameritech.net [68.255.106.176])
        by mx.google.com with ESMTPS id v56sm1513104eeh.14.2010.10.14.12.03.12
        (version=SSLv3 cipher=RC4-MD5);
        Thu, 14 Oct 2010 12:03:13 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20100705123923.GC21146@sigill.intra.peff.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/159065>

Jeff King wrote:

> This patch doesn't implement auto-detection of skew, but is the program
> I used to calculate, and would provide the basis for such
> auto-detection. It would be interesting to see average skew numbers for
> popular repositories. You can run it as "git skew --all".

Fun.  The story this tells me is that most repositories would benefit
more from special-casing a few commits than from a "[core] clockskew"
setting.

Caveat: the repos mentioned below are not canonical at all.  They are
just some repos I happened to have around, some tracking multiple upstreams.

project # skewed        maximum skew    notes
------- --------        ------------    -----
gtk+    13              13 hrs          worst example seems to be tz related

systemd 3               1 hr            all three come from a single 65min
                                        jump.  Same committer before+after.

dpkg    2               76 days         automatic import from manually
                                        written changelog

glibc   2               31 months       (tag) commits imported to wrong
                                        branches by "git cvsimport", I think

git     4               7 minutes       all four come from a single merge
                                        commit, parents have same committer
                                        as the merge.  probably clock drift
                                        corrected with something like ntp.

guilt   22              96 minutes      from the known (fixed) bug, I assume

linux-2.6 1226          99 days         probably the old guilt bug (e.g., in
                                        ext4, blackfin trees)

sed     0
