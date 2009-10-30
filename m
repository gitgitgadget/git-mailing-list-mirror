From: Sverre Rabbelier <srabbelier@gmail.com>
Subject: Re: [RFC PATCH 06/19] Factor ref updating out of fetch_with_import
Date: Fri, 30 Oct 2009 05:57:21 -0700
Message-ID: <fabb9a1e0910300557x42d3612pf7e83907e91efdc9@mail.gmail.com>
References: <1256839287-19016-1-git-send-email-srabbelier@gmail.com> 
	<1256839287-19016-7-git-send-email-srabbelier@gmail.com> <alpine.LNX.2.00.0910300221290.14365@iabervon.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Git List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Johan Herland <johan@herland.net>
To: Daniel Barkalow <barkalow@iabervon.org>
X-From: git-owner@vger.kernel.org Fri Oct 30 13:57:51 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3r38-0005t6-QO
	for gcvg-git-2@lo.gmane.org; Fri, 30 Oct 2009 13:57:51 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757002AbZJ3M5j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 30 Oct 2009 08:57:39 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756917AbZJ3M5j
	(ORCPT <rfc822;git-outgoing>); Fri, 30 Oct 2009 08:57:39 -0400
Received: from mail-ew0-f228.google.com ([209.85.219.228]:34680 "EHLO
	mail-ew0-f228.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756758AbZJ3M5i (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 30 Oct 2009 08:57:38 -0400
Received: by ewy28 with SMTP id 28so2960451ewy.18
        for <git@vger.kernel.org>; Fri, 30 Oct 2009 05:57:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :from:date:message-id:subject:to:cc:content-type;
        bh=+QwHYKK28eAKIG7gXMSoUVP8NrZQjIkCeyosZNLR9mA=;
        b=QBnHCbCLY+mjdnqUqvODqIBbFk+q1SXj2bt4rXXPbunajtStX9HW10/a3AfXpYJA+8
         E6kNLpnQDKpk1UsefXTKhx4LGFGJSXhSltmMTamHbTuqJhCQ+/Lyi9Pdb0mG2b/EKDE+
         C6Ladz3AhLjLzOynmnwrLI++H2EJEa2hQVMgI=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        b=dAIv+LNkvmMaE7Eo4PMyospxoDwgi/+2AgAIvpnn8O47ukY8fLIEILWudJAXw+b6nX
         y569U3NRDtjh4p9xE5vM6Yr28tzw7hdz6+wrHhZG3jtW6AxP8/pB6V1Pi26G0LjbM6uz
         5kYSoM1DYhxIiQicd9jAKDhHPihnYu/7qPcwY=
Received: by 10.216.86.72 with SMTP id v50mr573091wee.184.1256907461922; Fri, 
	30 Oct 2009 05:57:41 -0700 (PDT)
In-Reply-To: <alpine.LNX.2.00.0910300221290.14365@iabervon.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131703>

On Fri, Oct 30, 2009 at 00:10, Daniel Barkalow <barkalow@iabervon.org> wrote:
> Actually, I think the problem is that builtin-clone will always default to
> setting up a refspec of "refs/heads/*:refs/remotes/origin/*", but that
> doesn't actually make any sense if the source repository isn't presented
> as having refs names like "refs/heads/*". The immediate problem that you
> don't get HEAD because it's a symref to something outside the pattern is
> somewhat secondary to the general problem that you don't get anything at
> all, because everything's outside the pattern.

Ah, I didn't realize that as long as HEAD is a symref to something in
refs/heads/* it would be fetched.

> I don't really think that presenting the real refs in refs/<vcs>/*, and
> having the list give symrefs to them from refs/heads/* and refs/tags/*
> really makes sense; I think it would be better to rework fetch_with_import
> and the list provided by a foreign vcs helper such that it can present
> refs with normal names (refs/heads/*, refs/tags/*, etc) if the foreign vcs
> has standards that correspond to branches and tags. Then "clone" would
> work normally.

Perhaps we could introduce an additional phase before import to set
the default refspec? If we could tell git that we want
"refs/heads/*:refs/hg/origin/*" before line 468 "if (option_bare) {",
that would save us a lot of trouble. Does that sound like a good idea?
It would mean we have to move the transport_get part up a bit, but I
don't think that will be a problem. A svn helper for example might
respond the following to the "refspec" command:
"refs/heads/trunkr:refs/svn/origin/trunk"
"refs/tags/*:refs/svn/origin/tags/*"
"refs/heads/*:refs/svn/origin/branches/*"

How does that sound?

-- 
Cheers,

Sverre Rabbelier
