From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] Notes: Connect the %N flag to --{show,no}-notes
Date: Sat, 10 Apr 2010 18:08:43 -0400
Message-ID: <20100410220843.GA29987@coredump.intra.peff.net>
References: <7vaatbw00u.fsf@alter.siamese.dyndns.org>
 <1270935032-10536-1-git-send-email-heipei@hackvalue.de>
 <7v1venvuv8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Johannes Gilger <heipei@hackvalue.de>,
	Git ML <git@vger.kernel.org>,
	Thomas Rast <trast@student.ethz.ch>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Apr 11 00:09:34 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1O0irs-0006xE-VW
	for gcvg-git-2@lo.gmane.org; Sun, 11 Apr 2010 00:09:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751865Ab0DJWJK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Apr 2010 18:09:10 -0400
Received: from peff.net ([208.65.91.99]:56112 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751692Ab0DJWJJ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Apr 2010 18:09:09 -0400
Received: (qmail 26494 invoked by uid 107); 10 Apr 2010 22:09:08 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Sat, 10 Apr 2010 18:09:08 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Sat, 10 Apr 2010 18:08:43 -0400
Content-Disposition: inline
In-Reply-To: <7v1venvuv8.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/144599>

On Sat, Apr 10, 2010 at 02:51:55PM -0700, Junio C Hamano wrote:

> > +++ b/builtin/log.c
> > @@ -58,9 +58,9 @@ static void cmd_log_init(int argc, const char **argv, const char *prefix,
> >  		usage(builtin_log_usage);
> >  	argc = setup_revisions(argc, argv, rev, opt);
> >  
> > -	if (!rev->show_notes_given && !rev->pretty_given)
> > +	if (!rev->show_notes_given)
> >  		rev->show_notes = 1;
> 
> I am puzzled by this change and its possible interaction with codepaths
> that do not have anything to do with %N.  When there is no show-notes and
> an explicit --pretty, we do not want to have rev->show_notes set.

Could we perhaps just do:

  if (!rev->show_notes_given &&
      (!rev->pretty_given ||
       (rev->commit_format == CMIT_FMT_USERFORMAT && fmt_wants_notes(...))

where fmt_wants_notes is similar to what I posted earlier, or even just
strstr(fmt, "%N")? As I discussed earlier, it is not 100% accurate, but
it is extremely unlikely for it to be wrong, and when it is, we will
load notes when we don't need to. Which is an optimization failure, but
not a correctness failure.

And then just guard the '%N' placeholder by checking show_notes. That
will protect random codepaths that call format_commit_message() but
aren't log (they can't trigger an assert, but will just get '%N'
unexpanded or whatever). And doing:

  git log --no-notes --format='%N'

should also just fail to expand %N. Which is maybe a little crazy, but
what the user is asking for is crazy, and it makes the most sense to me.

-Peff
