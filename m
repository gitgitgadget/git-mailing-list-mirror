From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/3] make commit --verbose work with --no-status
Date: Mon, 24 Feb 2014 03:33:12 -0500
Message-ID: <20140224083312.GB32594@sigill.intra.peff.net>
References: <1393009762-31133-1-git-send-email-rctay89@gmail.com>
 <1393009762-31133-2-git-send-email-rctay89@gmail.com>
 <1393009762-31133-3-git-send-email-rctay89@gmail.com>
 <1393009762-31133-4-git-send-email-rctay89@gmail.com>
 <20140222083110.GE1576@sigill.intra.peff.net>
 <CALUzUxrO-=a5u-NpPVcQdnc2sp9dq3St0PZm=QOWr7oMWDz-Jw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Tay Ray Chuan <rctay89@gmail.com>
X-From: git-owner@vger.kernel.org Mon Feb 24 09:33:22 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WHqyV-0002i1-Kw
	for gcvg-git-2@plane.gmane.org; Mon, 24 Feb 2014 09:33:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751622AbaBXIdP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 24 Feb 2014 03:33:15 -0500
Received: from cloud.peff.net ([50.56.180.127]:55893 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750899AbaBXIdO (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 24 Feb 2014 03:33:14 -0500
Received: (qmail 17573 invoked by uid 102); 24 Feb 2014 08:33:14 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 24 Feb 2014 02:33:14 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 24 Feb 2014 03:33:12 -0500
Content-Disposition: inline
In-Reply-To: <CALUzUxrO-=a5u-NpPVcQdnc2sp9dq3St0PZm=QOWr7oMWDz-Jw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/242577>

On Mon, Feb 24, 2014 at 12:24:42PM +0800, Tay Ray Chuan wrote:

> > What happens here when there is an alternate status format _and_
> > --verbose is used? If I say "git commit --porcelain" it should imply
> > --dry-run. But "git commit --porcelain --verbose" no longer does so
> > after your patch.
> 
> I should have just left the --dry-run inference alone, like this.
> 
> -->8--
> 
> @@ -1141,7 +1146,12 @@ static int parse_and_validate_options
>         if (all && argc > 0)
>                 die(_("Paths with -a does not make sense."));
> 
> -       if (status_format != STATUS_FORMAT_DEFAULT)
> +       if (verbose && !include_status) {
> +               include_status = 1;
> +               status_format = STATUS_FORMAT_NONE;
> +       } else if (status_format != STATUS_FORMAT_DEFAULT)
>                 dry_run = 1;
> 
>         return argc;

Hrm, not quite, because the way include_status works is weird. If I turn
it off in the config, like this:

  git config commit.status false

then asking explicitly for a status format should still dry-run and show
it:

  git commit --porcelain

IOW, include_status is only respected when we are generating the actual
commit. So I think you need something more like:

  if (status_format == STATUS_FORMAT_DEFAULT) {
          if (verbose && !include_status) {
                  include_status = 1;
                  status_format = STATUS_FORMAT_NONE;
          }
  } else
          dry_run = 1;

-Peff
