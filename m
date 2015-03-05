From: Jeff King <peff@peff.net>
Subject: Re: git describe --contains doesn't work properly for a commit
Date: Thu, 5 Mar 2015 00:12:11 -0500
Message-ID: <20150305051211.GA3344@peff.net>
References: <20150226133534.GB14878@dhcp22.suse.cz>
 <20150226142314.GC14878@dhcp22.suse.cz>
 <20150304105408.GA19693@peff.net>
 <54F71F69.3080500@drmicha.warpmail.net>
 <20150304180529.GA28074@peff.net>
 <xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Michael J Gruber <git@drmicha.warpmail.net>,
	Michal Hocko <mhocko@suse.cz>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Mar 05 06:12:26 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YTO5B-0001Ey-WE
	for gcvg-git-2@plane.gmane.org; Thu, 05 Mar 2015 06:12:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751540AbbCEFMQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Mar 2015 00:12:16 -0500
Received: from cloud.peff.net ([50.56.180.127]:56654 "HELO cloud.peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1750869AbbCEFMO (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Mar 2015 00:12:14 -0500
Received: (qmail 24559 invoked by uid 102); 5 Mar 2015 05:12:14 -0000
Received: from Unknown (HELO peff.net) (10.0.1.1)
    by cloud.peff.net (qpsmtpd/0.84) with SMTP; Wed, 04 Mar 2015 23:12:14 -0600
Received: (qmail 8250 invoked by uid 107); 5 Mar 2015 05:12:19 -0000
Received: from Unknown (HELO sigill.intra.peff.net) (10.0.1.2)
    by peff.net (qpsmtpd/0.84) with SMTP; Thu, 05 Mar 2015 00:12:19 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 05 Mar 2015 00:12:11 -0500
Content-Disposition: inline
In-Reply-To: <xmqq7fuw8pgq.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264813>

On Wed, Mar 04, 2015 at 12:41:57PM -0800, Junio C Hamano wrote:

> > Calculating them is simple. Caching and storage is the bigger question.
> 
> Yes, also having to handle the ones whose generation numbers haven't
> been computed yet adds to the complexity.

I'm not sure it's that bad. If you cache generation numbers for all
known commits when you repack, then worst case you have to traverse all
commits not in the pack.

> This one, and $gmane/264101, are a few instances of this known issue
> raised here recently.

If $gmane/264101 is caused by clock skew, I'd find that disturbing.
Those algorithms are supposed to be "correct, but slower" in the face of
skew, not ever incorrect.

> I have been wondering if we can do something
> along the following (these are not alternatives) as a cheaper
> workaround:
> 
>  (1) Introduce '--skewed-timestamps[=(allow|warn|reject)' to all
>      commands that create new commit objects.  If the committer
>      timestamp being used is older than any of the parent commits,
>      "warn" or "reject" depending on the setting.

I think this idea has come up before. If it's _your_ timestamp that is
screwed up, this detects it, which is good. But if it's somebody else's
timestamp that is screwed up, there's often not much you can do. It's
already baked into the history.

I don't mind it as an extra layer of protection, I guess. But my
recollection of the great skew survey[1] is that most of these problems
don't come from actual clock skew, but from software bugs or bogus data
in imported commits. True skew is generally less than a day, and can be
handled with a fixed slop time.

[1] http://article.gmane.org/gmane.comp.version-control.git/159065

>  (2) Compute a bitmap whose timestamps are suspect when we pack to
>      mark commits.  When revision.c:limit_list() tries to see if
>      there still are interesting commits, an UNINTERESTING commit
>      marked as such shouldn't be counted as "not interesting because
>      it is old enough".  Use the same hint in the walker used in
>      "describe --contains".

If you see mismatched timestamps between a parent and child commit, it's
often not clear which one is suspicious.  Is the parent skewed to the
future, or is the child skewed to the past? Which one do you mark as
suspect?

IMHO, if you are going to go to the trouble to detect and store skew,
you should just go to the trouble to calculate and store reliable
generation numbers.

-Peff
