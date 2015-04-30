From: David Turner <dturner@twopensource.com>
Subject: Re: RFC: git cat-file --follow-symlinks?
Date: Thu, 30 Apr 2015 12:17:59 -0700
Organization: Twitter
Message-ID: <1430421479.22711.50.camel@ubuntu>
References: <20150430033725.GB12361@peff.net>
	 <xmqqfv7i2n81.fsf@gitster.dls.corp.google.com>
	 <5541E3D4.7040207@alum.mit.edu> <1430417023.22711.8.camel@ubuntu>
	 <xmqqzj5pzdfo.fsf@gitster.dls.corp.google.com>
	 <1430418522.22711.22.camel@ubuntu> <20150430183226.GA2855@peff.net>
	 <1430419490.22711.30.camel@ubuntu> <20150430184944.GA3661@peff.net>
	 <1430420422.22711.37.camel@ubuntu> <20150430191043.GA4461@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	git mailing list <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 30 21:18:17 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YntyS-0002a8-Il
	for gcvg-git-2@plane.gmane.org; Thu, 30 Apr 2015 21:18:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752800AbbD3TSI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 30 Apr 2015 15:18:08 -0400
Received: from mail-pd0-f181.google.com ([209.85.192.181]:36298 "EHLO
	mail-pd0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752780AbbD3TSD (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 30 Apr 2015 15:18:03 -0400
Received: by pdea3 with SMTP id a3so69645441pde.3
        for <git@vger.kernel.org>; Thu, 30 Apr 2015 12:18:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=h7HgztWJF88/OLRPxPMVYDmTkRgOz9WsGb+xw1SkXG8=;
        b=LnsxPpCi4jG3LU15wj/pzxaWEgyaiiHaYVc07fTkT1+Ylwnc1HYh2ylYVoJnzXVd7Q
         LcHIuxz3psdcPTp0detKnngfmekWcVZygHb1x4iQ9gT61D7XhXQqeA/pDx+OKi0fnYO5
         aLSL4ofSl1GdtTWNCvMW2wIps4zwtvooQSIE7iEplKRgW1Me3YVAkn714XX4K0PWRzxj
         SyztbSqF1739kInBmvCrK8KzvgXukVZ03dWBNQcStryONJI6fe7c14ml6FkM/qGhHT6y
         CQRHomqxlLiVkQ00TVBijQOhzF9KF7YaHB520juOavfnXXTPybT7gOn5G/VtJxjuOXan
         OWWA==
X-Gm-Message-State: ALoCoQmkuX9K76wPk69pLkmGvxM5zFVCFEy+9iuz4NGBfAFjJU7/vF3azwZutJHtehwuFYEWY7iE
X-Received: by 10.66.55.104 with SMTP id r8mr10837144pap.75.1430421481875;
        Thu, 30 Apr 2015 12:18:01 -0700 (PDT)
Received: from [172.25.135.195] ([8.25.197.26])
        by mx.google.com with ESMTPSA id l5sm2903668pbq.15.2015.04.30.12.18.00
        (version=TLSv1.2 cipher=AES128-GCM-SHA256 bits=128/128);
        Thu, 30 Apr 2015 12:18:01 -0700 (PDT)
In-Reply-To: <20150430191043.GA4461@peff.net>
X-Mailer: Evolution 3.10.4-0ubuntu2 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268094>

On Thu, 2015-04-30 at 15:10 -0400, Jeff King wrote:
> On Thu, Apr 30, 2015 at 12:00:22PM -0700, David Turner wrote:
> 
> > > > Also, BUILD files are scattered throughout the tree, so the entire tree
> > > > would still need to be traversed.  At present, our monorepo is not quite
> > > > large enough for this to matter (a full ls-tree only takes me 0.6s), but
> > > > it is growing.
> > > 
> > > But aren't you asking git to do that internally? I.e., it can limit the
> > > traversal for a prefix-match, but it cannot do so for an arbitrary
> > > filename. It has to open every tree. So the extra expense is really just
> > > the I/O over the pipe. That's not optimal, but it is a constant factor
> > > slowdown from what git would do internally.
> > 
> > No, I'm not trying to find all BUILD files -- only ones that are in the
> > transitive dependency tree of the target I'm trying to sparsely check
> > out. So if the target foo/bar/baz depends on morx/fleem, and morx/fleem
> > depends on plugh/xyzzy, then I have to examine those three places only.
> > I don't have to examine anything in the gibbberish/ subtree, for
> > instance.  
> 
> OK, let me see if I understand your use case by parroting it back.
> 
> You _don't_ want to feed git a "find all BUILD" pattern, which is good
> (because it doesn't work ;) ). You do want to feed it a set of raw
> paths to find, because you're going to discover the paths yourself at
> each step as you recurse through the dependency-chain of build files. 
> You don't actually care about feeding those paths to "ls-tree" at all.
> You care only about the _content_ at each path (and will parse that
> content to see if you need to take a further recursive step).
> 
> So I think git out-of-the-box supports that pretty well (via cat-file).
> And your sticking point is that some of the paths may involve symlinks
> in the tree, so you want cat-file to answer "if I had checked this out
> and typed cat /some/path/to/BUILD, what content would I get". Which
> brings us back to the original symlink question.
> 
> Is that all accurate?

Yes.  That is a very good summary.
