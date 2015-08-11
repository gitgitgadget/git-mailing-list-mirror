From: David Turner <dturner@twopensource.com>
Subject: Re: Re* [PATCH v2 1/2] refs: refs/worktree/* become per-worktree
Date: Tue, 11 Aug 2015 17:42:35 -0400
Organization: Twitter
Message-ID: <1439329355.5283.34.camel@twopensource.com>
References: <1439268979-10456-1-git-send-email-dturner@twopensource.com>
	 <xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, pclouds@gmail.com, mhagger@alum.mit.edu,
	Christian Couder <chriscool@tuxfamily.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Aug 11 23:42:48 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZPHJo-0005a3-0y
	for gcvg-git-2@plane.gmane.org; Tue, 11 Aug 2015 23:42:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752821AbbHKVmi (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Aug 2015 17:42:38 -0400
Received: from mail-qg0-f44.google.com ([209.85.192.44]:33743 "EHLO
	mail-qg0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752160AbbHKVmh (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Aug 2015 17:42:37 -0400
Received: by qged69 with SMTP id d69so149269858qge.0
        for <git@vger.kernel.org>; Tue, 11 Aug 2015 14:42:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=mVeplUeYkbxbfs+JjzozChMukRl6K8Ta3j7p4zdRl08=;
        b=NB1MMNCxLQzbxt4XfghD5Q97hVYaY6tv9DQ9OzXQtlt1MqC9yrZ/AaNepvdaMMyn4L
         IPSe0U30rWFkJNS8xAeA8GoQpNkbk4cY4SXNrI41PFt/UJKRL1OeDPfzgBr57CwtuuzK
         OezjBF2uwumVgCqjStQx+05Mq1KNya9XYZDkaYCkMFXYvpHfhqaCSFww2LSi6/W4eHuC
         1Sr/27sl8/lQI8oqvWD4uMfs65cLenyqKiBH1WNJjII3W7ZCx6/1h8J/pVWEsDKU9m/n
         fu5TJEtG1Kj1qWftIUdYseexOYrxxDvPqlc4Ayf0MLokS7WrNo9YZoEsbbeIDWuyQXMt
         vTyA==
X-Gm-Message-State: ALoCoQmTdyKELUU46FjEDvKCvfMyD/bSnmlr82qlqNuSYIZp8GaAUQvLB6DGh5QacPys0KtQLM2q
X-Received: by 10.140.81.16 with SMTP id e16mr52313169qgd.75.1439329357023;
        Tue, 11 Aug 2015 14:42:37 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by smtp.gmail.com with ESMTPSA id 65sm1986211qkq.41.2015.08.11.14.42.36
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 11 Aug 2015 14:42:36 -0700 (PDT)
In-Reply-To: <xmqqvbclpm3h.fsf@gitster.dls.corp.google.com>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/275732>

On Tue, 2015-08-11 at 14:10 -0700, Junio C Hamano wrote:
> David Turner <dturner@twopensource.com> writes:
> 
> > We need a place to stick refs for bisects in progress that is not
> > shared between worktrees.  So we use the refs/worktree/ hierarchy.
> 
> This is by itself OK, but to help existing Porcelains, most notably
> "gitk", I think refs/bisect/ hierarchy should be treated the same
> way.  Moving them out of refs/bisect/ to refs/worktree/bisect/ would
> not be a good idea.

What does gitk do that's relevant here?

> Because refs/worktree/ hierarchy is not needed right now, I think we
> can even live with just special casing refs/bisect/ the way this
> patch does, without adding refs/worktree/ support at this point.

There are a few reasons for refs/worktree hierarchy:

1. To make it easy to see the behavior of a ref at a glance.
2. To avoid too many different special-cases.

It's true that special-casing refs/bisect would make for fewer code
changes for now, but I am worried that next week we'll discover a new
situation where we'll want per-worktree refs and then we'll have to add
more special-cases.

> > Note that git for-each-ref may have inconsistent behavior (I think; I
> > haven't confirmed this), sometimes showing refs/worktree/* and sometimes
> > not.  In the long run, we should fix this, but right now, I don't know
> > that it matters, since the only refs affected are these bisect refs.
> 
> We should fix that before this hits 'master', preferrably before
> this hits 'next', especially if we add support for the more generic
> refs/worktree/.  If it is only for refs/bisect/, we might be OK, but
> I didn't think things through.

I will do this.  Should for-each-ref include or exclude these refs?  One
simple way to do "include" is to always create the refs/worktree
directory (when creating refs/).  

I'll also fix the rest of the things you suggested.
