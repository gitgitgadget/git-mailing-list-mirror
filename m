From: David Turner <dturner@twopensource.com>
Subject: Re: RFC/Pull Request: Refs db backend
Date: Tue, 23 Jun 2015 14:47:06 -0400
Organization: Twitter
Message-ID: <1435085226.28466.37.camel@twopensource.com>
References: <1435020656.28466.8.camel@twopensource.com>
	 <xmqqvbefdm0d.fsf@gitster.dls.corp.google.com>
	 <CACsJy8DA3oOt8QRsztdJXwmfUwDvY_nGALQrOpSA3M_eNSuT8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>,
	git mailing list <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Jun 23 20:47:16 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7TE3-0006KG-Fm
	for gcvg-git-2@plane.gmane.org; Tue, 23 Jun 2015 20:47:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933328AbbFWSrL (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 23 Jun 2015 14:47:11 -0400
Received: from mail-qk0-f181.google.com ([209.85.220.181]:33667 "EHLO
	mail-qk0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932981AbbFWSrJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 23 Jun 2015 14:47:09 -0400
Received: by qkhu186 with SMTP id u186so9735202qkh.0
        for <git@vger.kernel.org>; Tue, 23 Jun 2015 11:47:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:message-id:subject:from:to:cc:date:in-reply-to
         :references:organization:content-type:mime-version
         :content-transfer-encoding;
        bh=F5ViSiWOiARf0Kw1jhW7ZnQwum9fVnEYVQ90P3mBi4g=;
        b=T75jET5VhrD4914SDybajloiS1WBOxpAlUa8tUERvo0ZLyf63FDq+vk0TNCGC1qpW1
         sIq5pjVL9KmOJBC24njHuGyJ9ePaO2vx6Aj7rwCP0VGmpx/DnSRKOQsQTrY1tPPiua+v
         LfA6UX7VCNiZVppOzAybY4VkFhzWOsYbhkM7eN8MEEgekTQKc/D1JagbnEYK8l0ettWa
         scrHV9XmNw4rZ+MC7Dr8aEZJ3YeR6faqEpWDEmbRprSNfcbqVwXeNefyvIJwZ0hgkzOX
         bbaGU5x1XULLvT6pddmpu3qQlmqPQQYEOdqE5qqfw8qpIJJXhkF1UDVn5iuGe77S1yI+
         167Q==
X-Gm-Message-State: ALoCoQkEmVIc9yeoue870rLKHgeAyCLIE6DQ13PD8gvKnOA9JuzApDgkIU0TdEGYRRVAmL3XNrlF
X-Received: by 10.140.147.129 with SMTP id 123mr48594751qht.79.1435085228715;
        Tue, 23 Jun 2015 11:47:08 -0700 (PDT)
Received: from ubuntu ([192.133.79.145])
        by mx.google.com with ESMTPSA id b133sm1877329qhc.40.2015.06.23.11.47.07
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 11:47:07 -0700 (PDT)
In-Reply-To: <CACsJy8DA3oOt8QRsztdJXwmfUwDvY_nGALQrOpSA3M_eNSuT8g@mail.gmail.com>
X-Mailer: Evolution 3.12.10-0ubuntu1~14.10.1 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272477>

On Tue, 2015-06-23 at 17:23 +0700, Duy Nguyen wrote:
> On Tue, Jun 23, 2015 at 7:50 AM, David Turner
<dturner@twopensource.com> wrote:
> > To test this backend's correctness, I hacked test-lib.sh and
> > test-lib-functions.sh to run all tests under the refs backend.
> 
> Now we have two. split-index also benefits from running through full
> test suite like this. I propose we make "make test" run the test suite
> twice. The first run is with default configuration, no split index, no
> fancy ref backend. The second run enables split-index and switches to
> new backend, running through all test cases. In future we can also
> enable packv4 in this second run. There won't be a third run.
> 
> When the second ref backend comes, we can switch between the two
> backends using a random number generator where we control both
> algorithm and seed, so that when a test fails, the user can give us
> their seed and we can re-run with the same configuration.

I'm not in love with this idea, because it makes it hard to do
exhaustive testing efficiently.  I would rather have make test run
through all tests under all combinations -- or at least all relevant
tests.  We could perhaps mark tests with a list of features that they
exercise, so that we don't have to run e.g. t8xxx with alternate refs
backends.  

> Dozens of tests use manual ref/reflog reading/writing, or create
submodules
> > without passing --refs-backend-type to git init.  If those tests are
> > changed to use the update-ref machinery or test-refs-be-db (or, in
the
> > case of packed-refs, corrupt refs, and dumb fetch tests, are
skipped),
> > the only remaining failing tests are the git-new-workdir tests and
the
> > gitweb tests.
> 
> I haven't read the series, but I guess you should also add a few tests
> to run on the first run, so new code is exercised a bit even if people
> skip the second run.

I did this already, yes.
