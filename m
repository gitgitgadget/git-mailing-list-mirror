Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 779C8D5F
	for <git@vger.kernel.org>; Wed,  6 Dec 2023 14:36:13 -0800 (PST)
Received: (qmail 6014 invoked by uid 109); 6 Dec 2023 22:36:13 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Wed, 06 Dec 2023 22:36:13 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 29241 invoked by uid 111); 6 Dec 2023 22:36:14 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Wed, 06 Dec 2023 17:36:14 -0500
Authentication-Results: peff.net; auth=none
Date: Wed, 6 Dec 2023 17:36:12 -0500
From: Jeff King <peff@peff.net>
To: git@vger.kernel.org
Subject: Re: t7900 fails with recent debian systemd?
Message-ID: <20231206223612.GA650770@coredump.intra.peff.net>
References: <20231206223145.GA638844@coredump.intra.peff.net>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20231206223145.GA638844@coredump.intra.peff.net>

On Wed, Dec 06, 2023 at 05:31:45PM -0500, Jeff King wrote:

> I noticed t7900 failing today. The failure looks like this:
> 
>   $ ./t7900-maintenance.sh -v -i -x
>   [...]
>   + systemd-analyze verify systemd/user/git-maintenance@hourly.service
>   Unit git-maintenance@hourly.service not found.
>   error: last command exited with $?=1
>   not ok 36 - start and stop Linux/systemd maintenance
> 
> The problem started after upgrading my Debian unstable system to the
> systemd 255~rc4-2 deb. Downgrading back to 254.5-1 makes the test pass
> again.
> 
> I'm sure it's something silly with finding paths in XDG_CONFIG_HOME or
> something like that. I haven't dug further, but I thought I'd post this
> to save somebody else going through the same initial debugging. (And of
> course any wisdom or further debugging is greatly appreciated).

After stracing, it is indeed looking for:

  trash directory.t7900-maintenance/systemd/user/git-maintenance@hourly.service

but that file doesn't exist. We installed git-maintenance@hourly.timer,
and git-maintenance@.service. Is the latter supposed to be a wildcard of
some kind? Maybe the rules changed. I don't really know anything about
systemd.

-Peff
