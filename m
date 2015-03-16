From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFC] git submodule purge
Date: Mon, 16 Mar 2015 13:03:53 -0700
Message-ID: <20150316200353.GB5186@google.com>
References: <20150316134407.GA31794@pks-tp.elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Patrick Steinhardt <ps@pks.im>
X-From: git-owner@vger.kernel.org Mon Mar 16 21:04:03 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YXbF4-000254-0m
	for gcvg-git-2@plane.gmane.org; Mon, 16 Mar 2015 21:04:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754843AbbCPUD5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 16 Mar 2015 16:03:57 -0400
Received: from mail-ig0-f173.google.com ([209.85.213.173]:38729 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753118AbbCPUD4 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 16 Mar 2015 16:03:56 -0400
Received: by igbue6 with SMTP id ue6so53350592igb.1
        for <git@vger.kernel.org>; Mon, 16 Mar 2015 13:03:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        bh=0arzt5m6yZDDfKPuaKeFohUH9j8A08EdsGUTh1Wyh1E=;
        b=R+rKvekwadLQOXtztYRHiN0fDRTj1utuOvqF5eKra3CqLLbhsKEynoWeo4d2ZLfHsU
         dyOf3O6XGjfzUPmSOOUhOGgFmGYf07PWicVo2aVzHUYRK1xEOye5/sYBk0lSPCaKCtNH
         eTZ6D7+cSC9H254YpsIrPQ45Fo2csvW+Db0oaRkzoFJ+4QSdNhAMDTFCoHOJhOH7Ff6U
         KS3wexCG3CGskaOdxrrVJ+aZumt9S4kjfCGM3iinh2BWZugyKtdy2mFPniWZbXPtBzOp
         etd6GFJWxe7p/nyIbfqCUKEAKorRO+hj/A3RywfHIAlSKrbFQ7tuKLfiG7utr0ib2LMS
         8U0w==
X-Received: by 10.42.93.83 with SMTP id w19mr81026808icm.37.1426536235461;
        Mon, 16 Mar 2015 13:03:55 -0700 (PDT)
Received: from google.com ([2620:0:1000:5b00:55cd:39b6:71e9:ec64])
        by mx.google.com with ESMTPSA id o8sm7361937igp.11.2015.03.16.13.03.54
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 16 Mar 2015 13:03:55 -0700 (PDT)
Content-Disposition: inline
In-Reply-To: <20150316134407.GA31794@pks-tp.elego.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/265592>

(+cc: Jens and Heiko, submodule experts)
Hi,

Patrick Steinhardt wrote:

> This proposal is just for discussion. If there is any interest I
> will implement the feature and send some patches.
>
> Currently it is hard to properly remove submodules. That is when
> a submodule is deinitialized and removed from a repository the
> directory '.git/modules/<SM_NAME>' will still be present and
> there is no way to remove it despite manually calling `rm` on it.
> I think there should be a command that is able to remove those
> dangling repositories if the following conditions are met:
>
> - the submodule should not be initialized
>
> - the submodule should not have an entry in .gitmodules in the
>   currently checked out revision
>
> - the submodule should not contain any commits that are not
>   upstream
>
> - the submodule should not contain other submodules that do not
>   meet those conditions
>
> This would ensure that it is hard to loose any commits that may
> be of interest. In the case that the user knows what he is doing
> we may provide a '--force' switch to override those checks.

Those conditions look simultaneously too strong and too weak. ;-)

In principle, it should be safe to remove .git/modules/<name> as
long as

 (1) it (and its submodules, sub-sub-modules, etc) doesn't have any
     un-pushed local commits.

 (2) it is not being referred to by a .git file in the work tree of
     the parent repository.

Condition (1) can be relaxed if the user knows what they are losing
and is okay with that.  Condition (2) can be avoided by removing
(de-initing) the copy of that submodule in the worktree at the same
time.

The functionality sounds like a useful thing to have, whether as an
option to 'git submodule deinit' or as a new subcommand.  In the long
term I would like it to be possible to do everything 'git submodule'
can do using normal git commands instead of that specialized
interface.  What command do you think this would eventually belong in?
(An option to "git gc", maybe?)

Thanks,
Jonathan
