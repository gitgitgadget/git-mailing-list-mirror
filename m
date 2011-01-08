From: Jonathan Nieder <jrnieder@gmail.com>
Subject: Re: [RFD] My thoughts about implementing gitweb output caching
Date: Fri, 7 Jan 2011 18:26:43 -0600
Message-ID: <20110108002643.GD15495@burratino>
References: <201101080042.36156.jnareb@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, "J.H." <warthog9@eaglescrag.net>,
	John 'Warthog9' Hawley <warthog9@kernel.org>
To: Jakub Narebski <jnareb@gmail.com>
X-From: git-owner@vger.kernel.org Sat Jan 08 01:27:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PbMeJ-0004Tl-Ui
	for gcvg-git-2@lo.gmane.org; Sat, 08 Jan 2011 01:27:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752340Ab1AHA1C (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Jan 2011 19:27:02 -0500
Received: from mail-gw0-f46.google.com ([74.125.83.46]:61763 "EHLO
	mail-gw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751480Ab1AHA1A (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Jan 2011 19:27:00 -0500
Received: by gwj20 with SMTP id 20so7954383gwj.19
        for <git@vger.kernel.org>; Fri, 07 Jan 2011 16:26:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:date:from:to:cc:subject
         :message-id:references:mime-version:content-type:content-disposition
         :in-reply-to:user-agent;
        bh=nhuXjZqFxIhQh1F4JjFMlQQM0AQhGJ6fWpbm6uOCifQ=;
        b=Wu03HGyCfjV1z2+Y/p3SMTIbIUXFqGy7OiJP6AxL+66nSNctm7LpHJNk8TXrM4Oj1L
         5W/b2qrmotC1lodzdCKmSO1UaibhXSs4C1gUdJaU/gLRmMYAwt+sm8KdHRoTmf6nhK5a
         oXgXyH2HSE3xzuvkX0b1XIfbhs1SujDCfr9M0=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-type:content-disposition:in-reply-to:user-agent;
        b=cAqF4IkaQ7qFEIltC8+LSXJpQVthPxpuXqgA0CLsYjSGQ+RJnGUIi63nnlUj2aPwSZ
         NEIsX64YEZWNp66VYbzIeRvyCpLJFpR9iwVh8tjfRiMN5rbbjWIvBiSQvA3HB19C6FVZ
         IrvHY22RRVK4Chhfy1TwUzx97N1WOqxQxvmGs=
Received: by 10.236.110.1 with SMTP id t1mr469827yhg.94.1294446419726;
        Fri, 07 Jan 2011 16:26:59 -0800 (PST)
Received: from burratino (adsl-69-209-72-219.dsl.chcgil.ameritech.net [69.209.72.219])
        by mx.google.com with ESMTPS id h48sm4422992yha.21.2011.01.07.16.26.56
        (version=SSLv3 cipher=RC4-MD5);
        Fri, 07 Jan 2011 16:26:58 -0800 (PST)
Content-Disposition: inline
In-Reply-To: <201101080042.36156.jnareb@gmail.com>
User-Agent: Mutt/1.5.21 (2010-09-15)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164795>

Hi,

Thanks for these design notes.  A few uninformed reactions.

Jakub Narebski wrote:

> There was request to support installing gitweb modules in a separate
> directory, but that would require changes to "gitweb: Prepare for
> splitting gitweb" patch (but it is doable).  Is there wider interest
> in supporting such feature?

If you are referring to my suggestion, I see no reason to wait on
that.  The lib/ dir can be made configurable later.

> Simplest solution is to use $cgi->self_url() (note that what J.H. v8
> uses, i.e.: "$my_url?". $ENV{'QUERY_STRING'}, where $my_url is just
> $cgi->url() is not enough - it doesn't take path_info into account).
>
> Alternate solution, which I used in my rewrite, is to come up with
> "canonical" URL, e.g. href(-replay => 1, -full => 1, -path_info => 0);
> with this solution using path_info vs query parameters or reordering
> query parameters still gives the same key.

It is easy to miss dependencies on parts of the URL that are being
fuzzed out.  For example, the <base href...> tag is only inserted with
path_info.  Maybe it would be less risky to first use self_url(), then
canonicalize it in a separate patch?

> J.H. patches up and including v7, and my rewrite up and including v6,
> excluded error pages from caching.  I think that the original resoning
> behind choosing to do it this way was that A.), each of specific error
> pages is usually accessed only once, so caching them would only take up
> space bloating cache, but what is more important B.) that you can't
> cache errors from caching engine.

Perhaps there is a user experience reason?  If I receive an error page
due to a problem with my repository, all else being equal, I would
prefer that the next time I reload it is fixed.  By comparison, having
to reload multiple times to forget an obsolete non-error response
would be less aggravating and perhaps expected.

But the benefit from caching e.g. a response from a broken link would
outweigh that.

> Second is if there is no stale data to serve (or data is too stale), but
> we have progress indicator.  In this case the foreground process is
> responsible for rendering progress indicator, and background process is
> responsible for generating data.  In this case foreground process waits
> for data to be generated (unless progress info subroutine exits), so
> strictly spaking we don't need to detach background process in this
> case.

What happens when the client gets tired of waiting and closes the
connection?

> With output caching gitweb can also support 'Range' requests, which
> means that it would support resumable download.  This would mean hat we
> would be able to resume downloading of snapshot (or in the future
> bundle)... if we cannot do this now.  This would require some more code
> to be added.

Exciting stuff.

Teaching gitweb to generate bundles sounds like a recipe for high server
loads, though.  I suspect manual (or by cronjob) generation would work
better, with a possible exception of very frequently cloned and
infrequently pushed-to repos like linus's linux-2.6.

Jonathan
