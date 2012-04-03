From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH 3/3] revision: insert unsorted, then sort in prepare_revision_walk()
Date: Tue, 3 Apr 2012 10:49:01 +0700
Message-ID: <CACsJy8DGaFg=oEwLWWo33cJa=SDuuZshW4=cZpifCWLp5gGcTA@mail.gmail.com>
References: <201203291818.49933.mfick@codeaurora.org> <201204021024.49706.mfick@codeaurora.org>
 <CAJo=hJshOBg4pT8nuWZ=eZvj=E9x+4b9M_EANa=02x=NFW2OfQ@mail.gmail.com>
 <201204021049.04901.mfick@codeaurora.org> <CAJo=hJsprQtjDChtrSMcne+OCeUx=NVxLHs3k_qnYLzO=aQWuw@mail.gmail.com>
 <20120402203728.GB26503@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Shawn Pearce <spearce@spearce.org>,
	Martin Fick <mfick@codeaurora.org>,
	=?UTF-8?Q?Ren=C3=A9_Scharfe?= <rene.scharfe@lsrfire.ath.cx>,
	Shawn Pearce <sop@google.com>,
	Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Apr 03 05:49:39 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SEukT-0005Ly-Tg
	for gcvg-git-2@plane.gmane.org; Tue, 03 Apr 2012 05:49:38 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752413Ab2DCDtd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 2 Apr 2012 23:49:33 -0400
Received: from mail-wi0-f172.google.com ([209.85.212.172]:57874 "EHLO
	mail-wi0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751779Ab2DCDtd (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 2 Apr 2012 23:49:33 -0400
Received: by wibhj6 with SMTP id hj6so3216775wib.1
        for <git@vger.kernel.org>; Mon, 02 Apr 2012 20:49:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=lKvvM4nPkmsW0Mg2aKIQQs0J0gDBnj8dI8fOduMhtpk=;
        b=qbYhNtU1kxN2UCNCbDwoUUgo5SwxStwKuvlZhKfpq3gt9FDXcVofcVB4dntl6znfwV
         otGthlGik8FfplY9qIc1YbDMm2C2b+YkpUKETJqT4by4jvSvBYrSXBilCXAEtMOWO9n4
         +uXLTWWCdkMUuCjQkrzw+o49YGqbhRr5a/0bWBT/un095dmvw1JtRydh6GCLHCGPL9jE
         htkCmGKzvw15/GLXtPIk30Cn5WShLQUUYq2b96DEWdlH6VuAkQsmIhZ4VYbd3QfcQIHK
         yPwVh9tDt1PnQgAbdV3WKU2N6dghwS2oLOc4msVTZTOQUUhE60VxhZLlWEEI+SHFXeMi
         oV+Q==
Received: by 10.180.102.101 with SMTP id fn5mr31955870wib.6.1333424971741;
 Mon, 02 Apr 2012 20:49:31 -0700 (PDT)
Received: by 10.223.109.144 with HTTP; Mon, 2 Apr 2012 20:49:01 -0700 (PDT)
In-Reply-To: <20120402203728.GB26503@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/194590>

On Tue, Apr 3, 2012 at 3:37 AM, Jeff King <peff@peff.net> wrote:
> On Mon, Apr 02, 2012 at 09:51:21AM -0700, Shawn O. Pearce wrote:
>
>> Probably. But we tend to hate caches in Git because they can get stale
>> and need to be rebuilt, and are redundant with the base data. The
>> mythical "pack v4" work was going to approach this problem by storing
>> the commit timestamps uncompressed in a more machine friendly format.
>> Unfortunately the work has been stalled for years.
>
> I'd love for packv4 to exist, but even once it does, it comes with its
> own complications for network transfer (since we will have to translate
> to/from packv2 on the wire).
>
> Has anyone looked seriously at a new index format that stores the
> redundant information in a more easily accessible way? It would increase
> our disk usage, but for something like linux-2.6, only by 10MB per
> 32-bit word. On most of my systems I would gladly spare some extra RAM
> for the disk cache if it meant I could avoid inflating a bunch of
> objects. And this could easily be made optional for systems that don't
> want to make the tradeoff (if it's not there, you fall back to the
> current procedure; we could even store the data in a separate file to
> retain indexv2 compatibility).
>
> So it's sort-of a cache, in that it's redundant with the actual data.
> But staleness and writing issues are a lot simpler, since it only gets
> updated when we index the pack (and the pack index in general is a
> similar concept; we are "caching" the location of the object in the
> packfile, rather than doing a linear search to look it up each time).

I think I have something like that, (generate a machine-friendly
commit cache per pack, staying in $GIT_DIR/objects/pack/ too). It's
separate cache staying in $GIT_DIR/objects/pack, just like pack-.idx
files. It does improve rev-list time, but I'd rather wait for packv4,
or at least be sure that packv4 will not come anytime soon, before
pushing the cache route.
-- 
Duy
