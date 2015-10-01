From: Jacob Keller <jacob.keller@gmail.com>
Subject: Re: [PATCH] notes: allow merging from arbitrary references
Date: Thu, 1 Oct 2015 15:51:19 -0700
Message-ID: <CA+P7+xp6XtsZ3jCN91+2Mt4Ad0VxRvd3Ra3yAWHktpYW2Ho7uw@mail.gmail.com>
References: <1443739165-17526-1-git-send-email-jacob.e.keller@intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git List <git@vger.kernel.org>, Mike Hommey <mh@glandium.org>,
	Johan Herland <johan@herland.net>,
	Michael Haggerty <mhagger@alum.mit.edu>,
	Junio C Hamano <gitster@pobox.com>
To: Jacob Keller <jacob.e.keller@intel.com>
X-From: git-owner@vger.kernel.org Fri Oct 02 00:51:45 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZhmhU-0005I0-JU
	for gcvg-git-2@plane.gmane.org; Fri, 02 Oct 2015 00:51:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751348AbbJAWvk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 1 Oct 2015 18:51:40 -0400
Received: from mail-io0-f174.google.com ([209.85.223.174]:34733 "EHLO
	mail-io0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751236AbbJAWvj (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 1 Oct 2015 18:51:39 -0400
Received: by iow1 with SMTP id 1so65466741iow.1
        for <git@vger.kernel.org>; Thu, 01 Oct 2015 15:51:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=hUKg6VWB83AZSaGSXptrHNOmFF663gMMldRP4V+WoR8=;
        b=MHqxb2SczNP8LaiQkYz45eGXXl6WDYQzGCEUN7kW9TKj4PSkF7+hjdRFzPZXo6OD+f
         Yu+qEQD9PJdPFsdsaGTPzGyn/IpLvaWYy+Ecl/XmnT8XnDnkmtEfux5aFqj8PAp+9xys
         Oc06bkWU2/DZyYPMqkOJlzvtO1BB/6errvWiRKpMn8FUYPPL5zp2m8ijwXV7L2wnHbGZ
         xEZEFp3WQ5EOHpqfHerNwteWsdRAx7v64RdoybzS9zNl/HROOJuf0ZqjVBbyqhZZEdIt
         lMJ9YT7EI59G3FA9QB+qSuyX3czARnjDh1FYLoAIKHNkmDFf0/DwqTScrM80uCY73ll9
         KWmg==
X-Received: by 10.107.166.201 with SMTP id p192mr16509491ioe.0.1443739898640;
 Thu, 01 Oct 2015 15:51:38 -0700 (PDT)
Received: by 10.107.132.155 with HTTP; Thu, 1 Oct 2015 15:51:19 -0700 (PDT)
In-Reply-To: <1443739165-17526-1-git-send-email-jacob.e.keller@intel.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/278904>

On Thu, Oct 1, 2015 at 3:39 PM, Jacob Keller <jacob.e.keller@intel.com> wrote:
> From: Jacob Keller <jacob.keller@gmail.com>
>
> Create a new expansion function, expand_loose_notes_ref which will
> expand any ref using get_sha1, but falls back to expand_notes_ref if
> this fails. The contents of the strbuf will be either the hex string of
> the sha1, or the expanded notes ref. It is expected to be re-expanded
> using get_sha1 inside the notes merge machinery, and there is no real
> error checking provided at this layer.
>
> Since we now support merging from non-notes refs, remove the test case
> associated with that behavior. Add a test case for merging from a
> non-notes ref.
>
> Signed-off-by: Jacob Keller <jacob.keller@gmail.com>
> ---

I haven't yet figured out how to handle showing of notes on non-notes
refs, since the core notes command uses expand_notes_ref very early on
in the flow before we even know what kind of command we're using. I
think this will take a larger structural change to get right.

For merges it's pretty straight forward. This patch may seem weird,
but it's expected that the internal notes machinery will (re)expand
the remote_ref again and properly error out if it doesn't exist. We
need this since merging from a notes ref that doesn't exist isn't
considered an error today (it just falls back to using an empty ref).

Note that this does have some weird consequences, in that if you typo
a reference name such as refs/foo/bar which doesn't exist, then it
will be expanded into refs/notes/refs/foo/bar, which I am not sure is
the best approach, but otherwise things such as "x" don't properly
expand... I think in practice this will always result in the "empty"
notes ref being used for the source of the merge, so it may not be a
big deal.

Regards,
Jake
