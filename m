From: Adam Spiers <git@adamspiers.org>
Subject: Re: [PATCH 1/5] check-ignore: move setup into cmd_check_ignore()
Date: Thu, 11 Apr 2013 12:05:11 +0100
Message-ID: <20130411110511.GB24296@pacific.linksys.moosehall>
References: <20130408181311.GA14903@pacific.linksys.moosehall>
 <1365645575-11428-1-git-send-email-git@adamspiers.org>
 <20130411052553.GA28915@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
To: git list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Thu Apr 11 13:05:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UQFJh-0001DK-9B
	for gcvg-git-2@plane.gmane.org; Thu, 11 Apr 2013 13:05:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752705Ab3DKLFO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 11 Apr 2013 07:05:14 -0400
Received: from coral.adamspiers.org ([85.119.82.20]:58973 "EHLO
	coral.adamspiers.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752244Ab3DKLFN (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 11 Apr 2013 07:05:13 -0400
Received: from localhost (2.d.c.d.2.5.f.b.c.0.4.8.0.1.4.d.0.0.0.0.b.1.4.6.0.b.8.0.1.0.0.2.ip6.arpa [IPv6:2001:8b0:641b:0:d410:840c:bf52:dcd2])
	by coral.adamspiers.org (Postfix) with ESMTPSA id CAD9E58EB3
	for <git@vger.kernel.org>; Thu, 11 Apr 2013 12:05:11 +0100 (BST)
Content-Disposition: inline
In-Reply-To: <20130411052553.GA28915@sigill.intra.peff.net>
X-OS: GNU/Linux
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220845>

On Thu, Apr 11, 2013 at 01:25:53AM -0400, Jeff King wrote:
> On Thu, Apr 11, 2013 at 02:59:31AM +0100, Adam Spiers wrote:
> > -static int check_ignore(const char *prefix, const char **pathspec)
> > +static int check_ignore(struct path_exclude_check check,
> > +			const char *prefix, const char **pathspec)
> 
> Did you mean to pass the struct by value here? If it is truly a per-path
> value, shouldn't it be declared and initialized inside here? Otherwise
> you risk one invocation munging things that the struct points to, but
> the caller's copy does not know about the change.
> 
> In particular, I see that the struct includes a strbuf. What happens
> when one invocation of check_ignore grows the strbuf, then returns? The
> copy of the struct in the caller will not know that the buffer it is
> pointing to is now bogus.
> 
> > -static int check_ignore_stdin_paths(const char *prefix)
> > +static int check_ignore_stdin_paths(struct path_exclude_check check, const char *prefix)
> 
> Ditto here.

It's not a per-path value; it's supposed to be reused across checks
for multiple paths, as explained in the comments above
last_exclude_matching_path():

    ...
     * A path to a directory known to be excluded is left in check->path to
     * optimize for repeated checks for files in the same excluded directory.
     */
    struct exclude *last_exclude_matching_path(struct path_exclude_check *check,
    ...

So I think you're probably right that there is potential for
check->path to become effectively corrupted due to the caller not
seeing the reallocation.  I'll change this too.
