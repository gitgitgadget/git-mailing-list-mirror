From: David Turner <dturner@twopensource.com>
Subject: Re: [PATCH v2 40/43] refs: allow ref backend to be set for clone
Date: Mon, 05 Oct 2015 21:16:38 -0400
Organization: Twitter
Message-ID: <1444094198.7739.15.camel@twopensource.com>
References: <1443477738-32023-1-git-send-email-dturner@twopensource.com>
	 <1443477738-32023-41-git-send-email-dturner@twopensource.com>
	 <5612653F.5070502@alum.mit.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Michael Haggerty <mhagger@alum.mit.edu>
X-From: git-owner@vger.kernel.org Tue Oct 06 03:16:55 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjGsA-0007vu-Kn
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 03:16:55 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752440AbbJFBQn (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 5 Oct 2015 21:16:43 -0400
Received: from mail-qg0-f51.google.com ([209.85.192.51]:36616 "EHLO
	mail-qg0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751738AbbJFBQk (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 5 Oct 2015 21:16:40 -0400
Received: by qgx61 with SMTP id 61so166018697qgx.3
        for <git@vger.kernel.org>; Mon, 05 Oct 2015 18:16:39 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=n4XpwlNc+Gbpt4x9/tafv8uOk96xys2jmwJPdATkxjk=;
        b=btdKKbjkSWEsIv3w7cno+QqypnQonBLKuoxyW8ElUUo6vtLZiGPgARZgkhJMo/ed6y
         pzpFHDJjq/q01wkxw/H3yd0t+jLY5E2eoXNqvduVDRumwBdtzk3ydv3fyt6cLontJS6b
         ej8IEj2Qe8tVmfFtJgoUy0jWwM7NS0nax101xCv2ahXF/Bs+WvKmqFLurHpP6cvH3XRz
         3k3k75VNBXvFd2t7wIg+0yzX7SUS7ysqaA9Y6y6bAoHZT9zNlA0Bu/o2VNJ7iZK88aTj
         r4OV+dumQuXPrMwIOG7t2+5sAt8XRfPAyZToHEe2+E82zljtpq5Ahd6bvg8GtCaUG5+U
         l3sg==
X-Gm-Message-State: ALoCoQk8wbzDrEXwCFRvLn3GZT0L9xJ0Grg86QOdsWmYhkluwv97BknLTKO1Yq0CYTenEFqg3Wx/
X-Received: by 10.140.216.202 with SMTP id m193mr46298445qhb.30.1444094199801;
        Mon, 05 Oct 2015 18:16:39 -0700 (PDT)
Received: from ubuntu (207-38-164-98.c3-0.43d-ubr2.qens-43d.ny.cable.rcn.com. [207.38.164.98])
        by smtp.gmail.com with ESMTPSA id v10sm12670730qgv.32.2015.10.05.18.16.38
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 05 Oct 2015 18:16:38 -0700 (PDT)
In-Reply-To: <5612653F.5070502@alum.mit.edu>
X-Mailer: Evolution 3.12.11-0ubuntu3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279109>

On Mon, 2015-10-05 at 13:55 +0200, Michael Haggerty wrote:
> On 09/29/2015 12:02 AM, David Turner wrote:
> > Add a new option, --refs-backend-type, to allow the ref backend type to
> > be set on new clones.
> > 
> > Submodules must use the same ref backend as the parent repository, so
> > we also pass the --refs-backend-type option option when cloning
> > submodules.
> > 
> > Signed-off-by: David Turner <dturner@twopensource.com>
> > ---
> >  Documentation/git-clone.txt |  4 ++++
> >  builtin/clone.c             | 27 +++++++++++++++++++++++++--
> >  builtin/submodule--helper.c |  5 ++++-
> >  cache.h                     |  1 +
> >  refs.c                      |  2 ++
> >  5 files changed, 36 insertions(+), 3 deletions(-)
> > 
> > [...]
> > diff --git a/builtin/clone.c b/builtin/clone.c
> > index 3e14491..d489a87 100644
> > --- a/builtin/clone.c
> > +++ b/builtin/clone.c
> > [...]
> > @@ -744,6 +762,11 @@ static void write_config(struct string_list *config)
> >  					       write_one_config, NULL) < 0)
> >  			die("unable to write parameters to config file");
> >  	}
> > +
> > +	if (refs_backend_type &&
> > +	    write_one_config("core.refs-backend-type",
> > +			     refs_backend_type, NULL) < 0)
> > +			die("unable to write backend parameter to config file");
> >  }
> 
> Our config variable names don't use separated-with-hyphens but rather
> wordsruntogether (though in documentation this would be written
> core.refsBackendType, because the actual names are case-insensitive).

Will fix, thanks.
