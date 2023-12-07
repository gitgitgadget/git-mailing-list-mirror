Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 638BDD4B
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 22:27:54 -0800 (PST)
Received: (qmail 9390 invoked by uid 109); 7 Dec 2023 06:27:54 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 07 Dec 2023 06:27:54 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 501 invoked by uid 111); 7 Dec 2023 06:27:57 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 07 Dec 2023 01:27:57 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 7 Dec 2023 01:27:52 -0500
From: Jeff King <peff@peff.net>
To: Eric Sunshine <sunshine@sunshineco.com>
Cc: git@vger.kernel.org
Subject: Re: t7900 fails with recent debian systemd?
Message-ID: <20231207062752.GA777253@coredump.intra.peff.net>
References: <20231206223145.GA638844@coredump.intra.peff.net>
 <20231206223612.GA650770@coredump.intra.peff.net>
 <CAPig+cT-vCraf2tfA3t3Rh6mLNTr0rB5mApmz0vu2MCRvssaVw@mail.gmail.com>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPig+cT-vCraf2tfA3t3Rh6mLNTr0rB5mApmz0vu2MCRvssaVw@mail.gmail.com>

On Wed, Dec 06, 2023 at 05:40:59PM -0500, Eric Sunshine wrote:

> On Wed, Dec 6, 2023 at 5:36 PM Jeff King <peff@peff.net> wrote:
> > After stracing, it is indeed looking for:
> >
> >   trash directory.t7900-maintenance/systemd/user/git-maintenance@hourly.service
> >
> > but that file doesn't exist. We installed git-maintenance@hourly.timer,
> > and git-maintenance@.service. Is the latter supposed to be a wildcard of
> > some kind? Maybe the rules changed. I don't really know anything about
> > systemd.
> 
> Apparently, that's intentional. From builtin/gc.c:
> 
>     /*
>      * No matter the schedule, we use the same service and can make
>      * use of the templating system. When installing
>      * git-maintenance@<schedule>.timer, systemd will notice that
>      * git-maintenance@.service exists as a template and will use this
>      * file and insert the <schedule> into the template at the
>      * position of "%i".
>      */
>     static int systemd_timer_write_service_template(const char *exec_path)
>     {
>         char *local_service_name = xstrfmt(SYSTEMD_UNIT_FORMAT, "", "service");

OK, that makes sense, and this is indeed the way to do template files in
systemd.

> I'm not sure why the comment is talking about "%i", though.

The "%i" replacement is done on the contents of the template file
itself. So inside git-maintenance@.service, the ExecStart line specifies
that we should run "git maintenance run --schedule=%i".

This looks like a regression in systemd itself. I was able to bisect and
I left a comment there:

  https://github.com/systemd/systemd/pull/30172#issuecomment-1844699620

I don't really see a way to work around it within our test suite, short
of just skipping the "systemd-analyze verify" calls entirely. Hopefully
my analysis is right and they will fix it soon, and we can consider it
"not our problem" on this end. :)

-Peff
