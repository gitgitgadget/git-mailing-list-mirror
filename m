From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v2 11/19] pack-objects: use bitmaps when packing objects
Date: Sat, 26 Oct 2013 17:25:14 +0700
Message-ID: <CACsJy8DMOfZu+2DS=-J9jfiP796XYi=e7B28cdV=ck9J-VOTtA@mail.gmail.com>
References: <20131025055521.GD11810@sigill.intra.peff.net> <20131025060352.GI23098@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>,
	Vicent Marti <vicent@github.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Oct 26 12:26:03 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Va14E-0004X7-Su
	for gcvg-git-2@plane.gmane.org; Sat, 26 Oct 2013 12:26:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751467Ab3JZKZp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 26 Oct 2013 06:25:45 -0400
Received: from mail-qe0-f43.google.com ([209.85.128.43]:47973 "EHLO
	mail-qe0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751414Ab3JZKZp (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 26 Oct 2013 06:25:45 -0400
Received: by mail-qe0-f43.google.com with SMTP id nc12so3002218qeb.30
        for <git@vger.kernel.org>; Sat, 26 Oct 2013 03:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=p+bm/yXA73byKDdc9SnyHAow7xn5wqMh5teQ1rcMkZU=;
        b=FgM5m3KIo6hCXTn87YO6kuyhJgQpIuNJH7x8OZpAV26He1PBvlIRfb3RSqEqG4y5zE
         Qn9kqfXj1Mxq8Ebu6eDPlqoYdKTFO0G3TTg6mEbNrZ9JQ+AC/F2mebBFT9sM+k58QUBX
         Fa6frxKInz67bIba1sQbnZfr8SSj1itpzaqVfFJFMXdFMn5mE5GQ5cezi5wOtcMMXvz3
         L4vRPaVE+1bU9mm4sVxalBkW5WHoJqaxN/9htjmt6xc78NV6dq93yFwWNLlrI8ZB6MUN
         ojIytGLIJACpXpCMxeppdS+/1dvddNOWnHUoxcaqjnNjh2SOqxI3lqVj3WCUOPoDR5qc
         VRXQ==
X-Received: by 10.224.79.12 with SMTP id n12mr963323qak.109.1382783144221;
 Sat, 26 Oct 2013 03:25:44 -0700 (PDT)
Received: by 10.96.27.202 with HTTP; Sat, 26 Oct 2013 03:25:14 -0700 (PDT)
In-Reply-To: <20131025060352.GI23098@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236750>

On Fri, Oct 25, 2013 at 1:03 PM, Jeff King <peff@peff.net> wrote:
> From: Vicent Marti <tanoku@gmail.com>
>
> In this patch, we use the bitmap API to perform the `Counting Objects`
> phase in pack-objects, rather than a traditional walk through the object
> graph. For a reasonably-packed large repo, the time to fetch and clone
> is often dominated by the full-object revision walk during the Counting
> Objects phase. Using bitmaps can reduce the CPU time required on the
> server (and therefore start sending the actual pack data with less
> delay).
>
> For bitmaps to be used, the following must be true:
>
>   1. We must be packing to stdout (as a normal `pack-objects` from
>      `upload-pack` would do).
>
>   2. There must be a .bitmap index containing at least one of the
>      "have" objects that the client is asking for.
>
>   3. Bitmaps must be enabled (they are enabled by default, but can be
>      disabled by setting `pack.usebitmaps` to false, or by using
>      `--no-use-bitmap-index` on the command-line).
>
> If any of these is not true, we fall back to doing a normal walk of the
> object graph.

I haven't read the bitmap creation code yet. But it probably does not
matter. If the client requests a shallow fetch, you probably want to
fall back to normal walk too.

Bitmaps may be made work with shallow fetches too, I'm not sure. We
could substract the shallow'd commits out. The problem is if some
other commits share parts of the shallow'd commits, I'm not sure how
to detect that.
-- 
Duy
