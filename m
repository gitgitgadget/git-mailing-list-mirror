From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] commit: Add -f, --fixes <commit> option to add Fixes: line
Date: Tue, 29 Oct 2013 05:45:00 +0100
Message-ID: <CAP8UFD0R7JAkQSiX=1nqg_fmo-o7B-ekkxvsjHFgwspk5V0PHA@mail.gmail.com>
References: <20131024122255.GI9378@mwanda>
	<20131024122512.GB9534@mwanda>
	<20131026181709.GB10488@kroah.com>
	<20131027013402.GA7146@leaf>
	<xmqqa9hui2lp.fsf@gitster.dls.corp.google.com>
	<xmqq1u35iwyl.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Josh Triplett <josh@joshtriplett.org>, git <git@vger.kernel.org>,
	Dan Carpenter <dan.carpenter@oracle.com>,
	Greg KH <greg@kroah.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 29 05:45:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vb1Az-0006bN-A4
	for gcvg-git-2@plane.gmane.org; Tue, 29 Oct 2013 05:45:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751554Ab3J2EpD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Oct 2013 00:45:03 -0400
Received: from mail-vc0-f170.google.com ([209.85.220.170]:44873 "EHLO
	mail-vc0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751359Ab3J2EpB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Oct 2013 00:45:01 -0400
Received: by mail-vc0-f170.google.com with SMTP id hv10so2765582vcb.15
        for <git@vger.kernel.org>; Mon, 28 Oct 2013 21:45:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=uut6pvvik1CAtrvSmKa6i2Q/CE3h3jlmeCcND03ImXE=;
        b=tY9e89DmEQUi/kubxiIs30Jn+RmWN4vR9ZqEKDdnT95SbrFHCa7FiWtYmU0cOLAYSo
         1PTlqnvvwBoGlEsjl7na0RWzSNyb8lBZKKC/GuESkDIeyrYG5F9qTAWMuqK1JmXoas9m
         0Qnu4AL0wF6GJqbFRO+t7z7RzB5U6RLQYc9JTjC9Z/rZdBMlzsriJoNCXcSXTVZqApdX
         p8YK4q4aGpIv5sH9HUv0zyqV21j2dTHTc9W4jIyorS19dpTDN2xlHRByStRkwnd3XFg1
         Esq3zf5sAl9UcB2Fmdlyqm/2jLHmDZ63HUfDBspvqfvIf6uSHOZDPEuCRztc+v6YHnXr
         pMag==
X-Received: by 10.220.203.195 with SMTP id fj3mr2683942vcb.21.1383021900700;
 Mon, 28 Oct 2013 21:45:00 -0700 (PDT)
Received: by 10.58.253.136 with HTTP; Mon, 28 Oct 2013 21:45:00 -0700 (PDT)
In-Reply-To: <xmqq1u35iwyl.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/236891>

On Mon, Oct 28, 2013 at 10:08 AM, Junio C Hamano <gitster@pobox.com> wrote:
>
> Thinking aloud further, what I had in mind was along the lines of
> the following.
>
>  * The most generic external interface would be spelled as
>
>     --trailer <token>[=<param>]
>
>    where <token> can be things like "signoff", "closes", "acked-by",
>    "change-id", "fixes", etc.; they can be taken from an unbounded
>    set.  The historical "--signoff" can become a short-hand for
>    "--trailer signoff".  More than one "--trailer" option can be
>    given on a single command line.

Ok, and maybe the <token> could also be the full trailer like "Signed-off-by".

>  * The token is used to look into the configuration, e.g.,
>
>    [commitTrailer "signoff"]
>         style = append-norepeat
>         trailer = Signed-off-by
>         command = echo "$GIT_COMMITTER_NAME <$GIT_COMMITTER_EMAIL>"'
>
>    [commitTrailer "change-id"]
>         style = append-only-if-missing
>         trailer = Change-Id
>         command = 'git hash-object -t commit --stdin <$GIT_PROTO_COMMIT'
>
>    [commitTrailer "fixes"]
>         style = overwrite
>         trailer = Fixes
>         command = 'git log -1 --oneline --format="%h (%s)" --abbrev-commit=14 $ARG'
>
>    where
>
>    - "commitTrailer.<token>.style" defines the interaction with
>      existing trailer of the same kind (e.g. S-o-b: accumulates by
>      appending, but we try not to repeat the same sign-off twice
>      which would show you forwarding your own message you are the
>      last person in the Sign-off chain; Fixes: if there is already
>      one will remove the old one and replaces; etc.);
>
>    - "commitTrailer.<token>.trailer" defines the trailer label at
>      the beginning of the trailer line;
>
>    - "commitTrailer.<token>.command" gives the command to run to
>      obtain the payload after the "trailer" label.  A handful
>      obvious and useful variables are exported for the command to
>      use, and <param> is exported as $ARG, if present.
>
> With the most generic syntax, with the above commitTrailer.fixes.*
> configuration, I would imagine that you can say something like:
>
>     git commit --trailer fixes="v2.6.12^{/^i386: tweak frobnitz}"
>
> to say that the first commit you find traversing the history of
> v2.6.12 whose title is "i386: tweak frobnitz" was faulty, and you
> are creating a commit that corrects its mistake.
>
> Giving some default configuration to often used trailer types
> (e.g. configuration for "--trailer signoff") and promoting some
> commonly used ones into a separate built-in option (e.g. an option
> "--signoff" that does not have to say "--trailer signoff") are
> entirely separate issues, and only time can nudge us into evaluating
> individual types of trailers.

Ok, and maybe, if there is no configuration for a trailer token, we
could look at the commit template.

Thanks,
Christian.
