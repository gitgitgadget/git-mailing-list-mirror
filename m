From: Jeff King <peff@peff.net>
Subject: Re: Git 2.8.1 fails test 32 of t7300-clean.sh, breaks profile build
Date: Tue, 3 May 2016 14:48:41 -0400
Message-ID: <20160503184841.GA30530@sigill.intra.peff.net>
References: <CAA6PgK7b=ithSYREV5axaE3fmRG5Vp06UtWiZXD-aJuZKfEVYA@mail.gmail.com>
 <CAA6PgK4of46eEJOJstnVvPvDFqU_OC5QVz9LWxyKgqHt9V5ySQ@mail.gmail.com>
 <CAGZ79kYy=+xz5k0pN+MZTRBALd-sqbQ0TePNjkx6itjQpbRUvA@mail.gmail.com>
 <CAA6PgK4M2Ag6anEFYakW9NJe0ehTtS1UEQmDWe387W_uV-MCXA@mail.gmail.com>
 <CAGZ79kav27h+_eswTd3hRWjYhH5aApVcERa1bSxKD8p2R50HTw@mail.gmail.com>
 <CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Stefan Beller <sbeller@google.com>, Jan Keromnes <janx@linux.com>,
	Erik =?utf-8?B?RWxmc3Ryw7Zt?= <erik.elfstrom@gmail.com>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue May 03 20:49:06 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1axfNZ-0001Zy-W6
	for gcvg-git-2@plane.gmane.org; Tue, 03 May 2016 20:49:06 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932904AbcECSsp (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 May 2016 14:48:45 -0400
Received: from cloud.peff.net ([50.56.180.127]:33263 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1755635AbcECSso (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 May 2016 14:48:44 -0400
Received: (qmail 21080 invoked by uid 102); 3 May 2016 18:48:43 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 14:48:43 -0400
Received: (qmail 32553 invoked by uid 107); 3 May 2016 18:48:55 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
    by peff.net (qpsmtpd/0.84) with SMTP; Tue, 03 May 2016 14:48:55 -0400
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 03 May 2016 14:48:41 -0400
Content-Disposition: inline
In-Reply-To: <CAPc5daX4noqHaOZCrZ78s0ytFBkeU7znXs0QY1LXEw8w3RnQ1A@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/293433>

On Tue, May 03, 2016 at 11:05:09AM -0700, Junio C Hamano wrote:

> On Tue, May 3, 2016 at 11:02 AM, Stefan Beller <sbeller@google.com> wrote:
> >
> > So I wonder if is_nonbare_repository_dir() is the culprit here.
> > (We do a chmod 0 on the .git before the `git clean` in the test to confuse Git)
> 
> Ask if the test is run as root; if so, then mark the test to require
> SANITY prerequisite.

Yeah, I can easily reproduce the failure with `sudo ./t7300-clean.sh`.
So the immediate fix is the SANITY prereq.

Looking at Stefan's message, I wondered if the patch he came up with:

        diff --git a/setup.c b/setup.c
        index 3439ec6..4cfba8f 100644
        --- a/setup.c
        +++ b/setup.c
        @@ -323,8 +323,7 @@ int is_nonbare_repository_dir(struct strbuf *path)
                strbuf_addstr(path, ".git");
                if (read_gitfile_gently(path->buf, &gitfile_error) ||
is_git_directory(path->buf))
                        ret = 1;
        -       if (gitfile_error == READ_GITFILE_ERR_OPEN_FAILED ||
        -           gitfile_error == READ_GITFILE_ERR_READ_FAILED)
        +       if (gitfile_error)
                        ret = 1;
                strbuf_setlen(path, orig_path_len);
                return ret;

is related or worth doing on top. But I don't think so. That code is
just trying to convert some error-cases into "let's err on the side of
assuming it is a repo". Doing that for all values of gitfile_error is
definitely the wrong thing (it would treat a totally non-existent
".git" file as "yes, it's there", which is clearly bogus).

-Peff
