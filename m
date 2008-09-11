From: Jakub Narebski <jnareb@gmail.com>
Subject: Re: [RFC] origin link for cherry-pick and revert
Date: Thu, 11 Sep 2008 10:20:53 +0200
Message-ID: <200809111020.55115.jnareb@gmail.com>
References: <20080909132212.GA25476@cuci.nl> <alpine.LFD.1.10.0809101733050.3384@nehalem.linux-foundation.org> <20080911062242.GA23070@cuci.nl>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Cc: Linus Torvalds <torvalds@linux-foundation.org>, git@vger.kernel.org
To: "Stephen R. van den Berg" <srb@cuci.nl>
X-From: git-owner@vger.kernel.org Thu Sep 11 10:22:15 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KdhRM-0000wk-UH
	for gcvg-git-2@gmane.org; Thu, 11 Sep 2008 10:22:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751847AbYIKIVG (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Sep 2008 04:21:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751806AbYIKIVG
	(ORCPT <rfc822;git-outgoing>); Thu, 11 Sep 2008 04:21:06 -0400
Received: from ik-out-1112.google.com ([66.249.90.180]:6489 "EHLO
	ik-out-1112.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751797AbYIKIVD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Sep 2008 04:21:03 -0400
Received: by ik-out-1112.google.com with SMTP id c30so220429ika.5
        for <git@vger.kernel.org>; Thu, 11 Sep 2008 01:21:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:from:to:subject:date
         :user-agent:cc:references:in-reply-to:mime-version:content-type
         :content-transfer-encoding:content-disposition:message-id;
        bh=0AdbDdTBKVOhNjHl9LzAq/2f0YGKLKGjaVmsGctbRvs=;
        b=dcS5pRTIxBBPtKapV6qlHCin2KQCgkgzzp4dOiuIcfYvBCUb+drm3SHa4JSOaRJaML
         FxFtpwItcjdM/9A24H1R5pNguH8K8ehvfiN4tqDo3K7FHL9np8nVOeS2RDXF6hAydigd
         VDORWOSl+dULIHg+5NBwWbglMdrXToHkYweQ4=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=from:to:subject:date:user-agent:cc:references:in-reply-to
         :mime-version:content-type:content-transfer-encoding
         :content-disposition:message-id;
        b=WVwGDlDdJmC3aqsZS3yR3CDzw89Mjqghh8k2sSrgF2BdW/rDAwl8DjlZvOl67OF+Xx
         NLubZU8ZaPoRormMlVYIv0hGebOXjBGN40UKdxVYU42/Q8wZEt4Vd57VSPMa5wgpBFof
         21X9OFxxlnxIMOyAnHg12sgChnEQZBNO0wZV8=
Received: by 10.86.80.17 with SMTP id d17mr1791634fgb.33.1221121260243;
        Thu, 11 Sep 2008 01:21:00 -0700 (PDT)
Received: from ?192.168.1.11? ( [83.8.234.133])
        by mx.google.com with ESMTPS id 12sm8890870fgg.0.2008.09.11.01.20.57
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Thu, 11 Sep 2008 01:20:59 -0700 (PDT)
User-Agent: KMail/1.9.3
In-Reply-To: <20080911062242.GA23070@cuci.nl>
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/95593>

Stephen R. van den Berg wrote:

[...]
> Please focus on the semantics and on the *non*-made up use case of
> development of several stable branches with backports between them.
> Discussing made-up use cases is wasting energy at this point.

By the way, I would really consider trying first to host 'origin' links 
not in repository database itself, but in some extra database inside 
git repository, like reflog or index.  Git community is _very_ 
reluctant to modifying / extending format of persistent objects.  From 
all the proposals to add some extra header to a 'commit' object: 
the 'prior' link to previous version of rebased, cherry-picked or redone 
commit (superceded somewhat by local reflog, on by default in modern 
git); the generic 'note' header, with examples of usage including 
_non-linking_ cherry-pick and reverted commit-id, merge strategy used, 
and hints for rename detection, i.e. something like #pragma in C 
(rejected on the grounds that it was too generic and didn't have well 
defined semantic); the 'generation' header which was meant to help and 
speed up sorting commits, with root (parentless) commit having 
generation of 1, and each commit having generation being 1 more than 
maximum of generations of its parents (I think that backwards 
compatibility killed it, and the fact that date-based heuristics was 
improved); only the 'encoding' header was accepted.

So I think you should go the route of externally (outside 'commit' 
objects) maintaing 'origin'/'changeset'/'cset' links (like XLink 
extended links ;-)) as a prototype to examine consequences of the idea. 
That was the way _submodule_ support was added to Git, by the way.  
First there were (at least) two implementations maintaining submodules 
outside object database (see http://git.or.cz/gitwiki/SubprojectSupport
especially "References" section), then it was officially added first at 
the level of plumbing support, as extension of a 'tree' object (and 
index format, I think).

-- 
Jakub Narebski
Poland
