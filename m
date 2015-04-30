From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:00:22 -0700
Organization: Twitter
Message-ID: <1430420422.22711.37.camel@ubuntu>
References: <20150430011612.GA7530@peff.net>
	 <1430358345.14907.62.camel@ubuntu> <20150430033725.GB12361@peff.net>
	 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	 <5541E3D4.7040207@alum.mit.edu> <1430417023.22711.8.camel@ubuntu>
	 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
	 <1430418522.22711.22.camel@ubuntu> <20150430183226.GA2855@peff.net>
	 <1430419490.22711.30.camel@ubuntu> <20150430184944.GA3661@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:00:30 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YnthG-0003nt-89
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:00:30 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752170AbbD3TAZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:00:25 -0400
Received: from mail-pa0-f50.google.com ([209.85.220.50]:36412 "EHLO
	mail-pa0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750854AbbD3TAZ (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:00:25 -0400
Received: by pabsx10 with SMTP id sx10so68073187pab.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 12:00:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=m5A/IYQRxDVMyOT5Q11/M73kCo6LjvAcArp7Uc/sPBE=;
        b=d47I47e8tYUorz2SEoQq5/LB/MMDoY90V98WCWqOAiFEwIDa1QHGOMI4hHgF0ffQ/n
         Oy31dMmStDdNqBI4oBWGSTUzlj0GvphV/xNif1P7UI9iSnxx/roqHOIQebLKaKM69MNo
         fSBWLYW9LOgDWay6IzdZ+yR7dRt4se84QBTIyXAC08+lXe57yIGkUliiSiWRTl7OADhn
         NcOsL0sl2t867q7arwSAQs3FtXosIvSIxg3CP3R9Vujh+MwjWK2f1nluzN8Vt7FNdS1h
         cTGjk4PpJoBoZwMwtWkVyZhop3cxxJnpMo2cm8ACITbcdq7y1fEX/H/VM54kGEZPVx6g
         UmHg==
X-Gm-Message-State: ALoCoQkFdsqqJa6M5U3Sfj3yqR5NthrDSp7j6+68aB620ewKoPEO/Et0ELgUm22x6Ctoz1DLMgmP
X-Received: by 10.70.93.36 with SMTP id cr4mr10884320pdb.68.1430420424680;
        Thu, 30 Apr 2015 12:00:24 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id pw9sm2878809pac.27.2015.04.30.12.00.23
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 12:00:23 -0700 (PDT)
In-Reply-To: <20150430184944.GA3661@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268092>

On Thu, 2015-04-30 at 14:49 -0400, Jeff King wrote:
> On Thu, Apr 30, 2015 at 11:44:50AM -0700, David Turner wrote:
> 
> > > git ls-tree HEAD -- BUILD ?
> > 
> > This does not actually seem to work (even with -r); it only recurses
> > into directories that are named BUILD, rather than being equivalent to
> > git ls-tree -r HEAD |grep /BUILD$.
> 
> Ah, I thought that was what you wanted (to find specific files, not a
> pattern). I think `ls-tree` doesn't understand our normal pathspecs, for
> historical reasons.
> 
> > Also, BUILD files are scattered throughout the tree, so the entire tree
> > would still need to be traversed.  At present, our monorepo is not quite
> > large enough for this to matter (a full ls-tree only takes me 0.6s), but
> > it is growing.
> 
> But aren't you asking git to do that internally? I.e., it can limit the
> traversal for a prefix-match, but it cannot do so for an arbitrary
> filename. It has to open every tree. So the extra expense is really just
> the I/O over the pipe. That's not optimal, but it is a constant factor
> slowdown from what git would do internally.

No, I'm not trying to find all BUILD files -- only ones that are in the
transitive dependency tree of the target I'm trying to sparsely check
out. So if the target foo/bar/baz depends on morx/fleem, and morx/fleem
depends on plugh/xyzzy, then I have to examine those three places only.
I don't have to examine anything in the gibbberish/ subtree, for
instance.  
