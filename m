From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [PATCH] revert.c: Allow to specify -x via git-config
Date: Tue, 18 Feb 2014 11:20:39 -0800
Message-ID: <20140218192039.GC7855@google.com>
References: <20140218065620.GA3448@bogon.m.sigxcpu.org>
 <20140218174913.GB7855@google.com>
 <20140218183842.GA163138@vauxhall.crustytoothpaste.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Guido =?iso-8859-1?Q?G=FCnther?= <agx@sigxcpu.org>,
	git@vger.kernel.org
To: "brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Tue Feb 18 20:20:48 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WFqDn-0000Li-Hk
	for gcvg-git-2@plane.gmane.org; Tue, 18 Feb 2014 20:20:47 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752004AbaBRTUn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 18 Feb 2014 14:20:43 -0500
Received: from mail-pb0-f44.google.com ([209.85.160.44]:50159 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751126AbaBRTUm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 18 Feb 2014 14:20:42 -0500
Received: by mail-pb0-f44.google.com with SMTP id rq2so17142973pbb.31
        for <git@vger.kernel.org>; Tue, 18 Feb 2014 11:20:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=LjdhMHqIgXLc863w4YhRho2XcVW2bMZlI9nHPJCnMLY=;
        b=LhcpdTi6STFb26zw3ki849CbFg50QPv10jgeNOK43QYVdas1VoYJOHpEQLKdp0pIms
         K0LYVJyNb/Gvvg7my6o8usB/W8Vd//+joKUxFbsKXqKcGApJ5Bra8I4LVkh/ti060R9s
         XILOAdupAScRaUQ8L4e+ottfk6dRtIKqRI8EzNEH1UUKFvmT12k1Rh+pmoczvaTAIoi9
         AgTgbtsZpS47yuYI20Ps51b2Zkvt9wcjomNVkyuSjubGWXI/pOM5ypUyc6c4xJak4msA
         TeCl3O7toHkaZZg/O/gcdG6H02/zP2dH+gVU7EyZ7iqA2czIy3DJULnefF+ZXfxA6xO8
         AJGw==
X-Received: by 10.68.197.66 with SMTP id is2mr34826941pbc.96.1392751241976;
        Tue, 18 Feb 2014 11:20:41 -0800 (PST)
Received: from google.com ([2620:0:1000:5b00:b6b5:2fff:fec3:b50d])
        by mx.google.com with ESMTPSA id yz5sm148440160pac.9.2014.02.18.11.20.40
        for <multiple recipients>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Tue, 18 Feb 2014 11:20:41 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <20140218183842.GA163138@vauxhall.crustytoothpaste.net>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242340>

brian m. carlson wrote:

> I can provide a use case.  At work, we merge into the maintenance and
> development branches and cherry-pick from the maintenance to the stable
> branches.  We want committers to always use -x -s because we need to
> know which reviewer backported the change and we want to be able to
> track which commits have been backported and whether any reverts also
> need to be cherry-picked.  We also have automated tools that want this
> information.
>
> I usually solve this with an alias (backport = cherry-pick -x -s), but I
> can see how this might be a useful option.

Thanks for the example.

Here the alias seems like a nicer solution than a configuration
changing the default behavior of "git cherry-pick" because

 (1) it is easy to temporarily turn the effect off, by using cherry-pick
     directly instead of using the alias

 (2) it doesn't affect scripts that use cherry-pick

 (3) The caller explicitly specifies their intent by running "git
     backport".  It doesn't affect unrelated uses of cherry-pick on
     other branches.

 (4) it can be set up globally and takes effect when appropriate
     without needing any special setup per repository

 (5) it also implements the other part of your backporting policy (-s)
     and if in the future you had more backporting rules (e.g., requirement
     to specify which commit introduced the regression that this backport
     solves) then it could be easily tweaked

All that said, I wouldn't mind some magic that changes the default
behavior of "git cherry-pick" as long as (1), (2), and (3) are
resolved somehow.  E.g.

 (i)   a working --no-record-origin option that overrides this config

 (ii)  a --porcelain or similar option or just better documentation
       about how scripts can protect themselves from further changes
       to 'git cherry-pick' behavior

 (iii) config applying per destination branch instead of globally

Hope that helps,
Jonathan
