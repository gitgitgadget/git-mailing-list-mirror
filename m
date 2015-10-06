From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 05 Oct 2015 21:29:37 -0400
Organization: Twitter
Message-ID: <1444094977.7739.24.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-41-git-send-email-dturner@twopensource.com>
	 <5612439E.4080200@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 06 03:29:53 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjH4h-0001Vl-6M
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 03:29:51 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751330AbbJFB3k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 21:29:40 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:36649 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbJFB3j (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 21:29:39 -0400
Received: by qgx61 with SMTP id 61so166211155qgx.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 18:29:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=0VdYlyE4/j/DjLz3GxBVCjfiq5eGarLjfZtsrzmVIvs=;
        b=cT9MYn4vpy4VnbOVr8AnzoOuwhd/5d5I4oYavpHlPLV4QIv+zfWUx4SNTaz/bbzKsR
         8LNFk2aq1iuf1dpb/GutuWo2dMtppgGqVzn2ItCADkbUTgN/jGTzAyOftiggc1jBX399
         3flfPqqVCdriAIUfJO1oIwTesUCChCWcEbSLWAKQror8/Lrpx4L2lg3kAxMm9vKF1+n5
         0AVn2QaF5ZgAXtqlOTPSXet4lmPSbVfpJe0UoCq8EcVK7pgsLZQgzHCVpb9jQcCRtvp9
         KUpZCGRWlIIVWyX9MJKkZoPERnsD/OUHnfujv2CgNl53rEQ6jt4/98QWvcutKKZbY6YK
         1gaA==
X-Gm-Message-State: ALoCoQmBTCYZXIxOnstadP2oeyMbzwzjbQ6CGZQmujw+r+c4ZDE//FMX3MHXOJ5UtVsVUOofZglO
X-Received: by 10.140.231.76 with SMTP id b73mr47456051qhc.87.1444094979060;
        Mon, 05 Oct 2015 18:29:39 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id 28sm9759279qkw.12.2015.10.05.18.29.37
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 18:29:38 -0700 (PDT)
In-Reply-To: <5612439E.4080200@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279111>

On Mon, 2015-10-05 at 11:32 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > Add a new option, --refs-backend-type, to allow the ref backend type to
> > be set on new clones.
> > 
> > Submodules must use the same ref backend as the parent repository, so
> > we also pass the --refs-backend-type option option when cloning
> > submodules.
> 
> If I'm reading this correctly, you propose to add a new configuration
> setting,
> 
>     core.refs-backend-type
> 
> to record which reference backend the repository is using.
> 
> (By the way, please document any new config settings in
> Documentation/config.txt.)

Fixed, thanks.

> This does not provide adequate backwards compatibility. Suppose I create
> a repository with a DB backend, then later try to access the repository
> using an older version of Git (or JGit or libgit2 or ...) that doesn't
> know about this configuration setting. It will think it is a normal
> repository that only has a couple of references (HEAD, stash, etc). If I
> run `git gc` using the older version of git, *poof* all of the objects
> referred to by other branches will be garbage-collected.
> 
> Therefore, I don't think this can be merged without a bump to
> core.repositoryformatversion. Such a bump will tell well-behaved older
> Git clients keep their hands off the repository. (Of course repositories
> that use the files backend can continue using
> core.repositoryformatversion 0.)
> 
> I thought Peff proposed a way to do such a bump, including a way to
> extend repositories one by one with new features. But that was something
> that we were chatting about off-list.
> 
> I haven't reviewed the actual code in this patch yet but I wanted to get
> the above comment on your radar.
> 
> Michael

I'll fix this to upgrade to v=1 when the lmdb refs backend is in use,
and to give sensible error messages in a v1 repo if built without LMDB.
