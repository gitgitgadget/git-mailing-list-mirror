From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 3/4] diff: introduce diff.<driver>.binary
Date: Thu, 23 Oct 2008 22:46:32 -0400
Message-ID: <20081024024631.GA20365@coredump.intra.peff.net>
References: <20081005214114.GA21875@coredump.intra.peff.net> <20081005214336.GC21925@coredump.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>,
	Johannes Sixt <j.sixt@viscovery.net>,
	Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 04:47:53 2008
connect(): Connection refused
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KtCiK-0003Ec-B6
	for gcvg-git-2@gmane.org; Fri, 24 Oct 2008 04:47:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752200AbYJXCqf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 23 Oct 2008 22:46:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751983AbYJXCqf
	(ORCPT <rfc822;git-outgoing>); Thu, 23 Oct 2008 22:46:35 -0400
Received: from peff.net ([208.65.91.99]:1604 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751935AbYJXCqe (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 23 Oct 2008 22:46:34 -0400
Received: (qmail 12765 invoked by uid 111); 24 Oct 2008 02:46:33 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.32) with SMTP; Thu, 23 Oct 2008 22:46:33 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 23 Oct 2008 22:46:32 -0400
Content-Disposition: inline
In-Reply-To: <20081005214336.GC21925@coredump.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98999>

On Sun, Oct 05, 2008 at 05:43:36PM -0400, Jeff King wrote:

> However, there is at least one conflicting situation: there
> is no way to say "use the regular rules to determine whether
> this file is binary, but if we do diff it textually, use
> this funcname pattern." That is, currently setting diff=foo
> indicates that the file is definitely text.

Hrm. I don't know what crack I was smoking when I wrote this (and then
argued about it for weeks afterward). It is actually the _opposite_
situation.  That is, once you have said "diff=foo", there is no way to
say "btw, foo files are _definitely_ text."

See, this is the old code:

> -static void diff_filespec_check_attr(struct diff_filespec *one)
> +void diff_filespec_load_driver(struct diff_filespec *one)
>  {
> -	struct userdiff_driver *drv;
> -	int check_from_data = 0;
> -
> -	if (one->checked_attr)
> -		return;
> -
> -	drv = userdiff_find_by_path(one->path);
> -	one->is_binary = 0;
> -
> -	/* binaryness */
> -	if (drv == USERDIFF_ATTR_TRUE)
> -		;
> -	else if (drv == USERDIFF_ATTR_FALSE)
> -		one->is_binary = 1;
> -	else
> -		check_from_data = 1;
> -
> -	if (check_from_data) {
> -		if (!one->data && DIFF_FILE_VALID(one))
> -			diff_populate_filespec(one, 0);
> -
> -		if (one->data)
> -			one->is_binary = buffer_is_binary(one->data, one->size);
> -	}
> +	if (!one->driver)
> +		one->driver = userdiff_find_by_path(one->path);
> +	if (!one->driver)
> +		one->driver = userdiff_find_by_name("default");
>  }

You can clearly see that we use check_from_data as long as the value is
not true or false. Meaning if it is unspecified _or_ if it has a string
value (actually, this text is hacked up by my previous patch, but you
can look at maint:diff.c and see that it is similar).

And this makes sense. Otherwise, plumbing like "git diff-tree" would
get mightily confused by external diff commands. For example, consider
if you had "foo diff=bar" in your attributes file, and defined
"diff.bar.command". That external diff would be used for git-diff, but
_not_ for diff-tree. But it would be stupid for diff-tree to look at the
attribute and say "oh, we have a diff attr, it must be text."

So the patch is right to keep the binary value to "-1" except for the
few cases where it has been specified explicitly. I found this out when
I tried to "fix" it to the old behavior tonight and discovered lots of
breakage.

And this also means that diff.*.binary really _does_ do something
useful. If you have, for example, a ".foo" file that looks like binary,
but really isn't, _and_ you want to set a custom hunk header for it,
previously you were out of luck. You could do one or the other. Now you
can do:

  git config diff.foo.xfuncname whatever
  git config diff.foo.binary false

and get the desired effect.

As for the fallout from this with regards to our discussion last week,
there were two relevant points:

 - Junio suggested that anytime we use funcname, we always want text
   anyway. I think that is reasonable, but it has never been the case up
   until now (in fact, you were stuck with the _opposite_ until now, so
   my series at least makes it possible to say "always text", though
   you have to do it manually). So I will leave it for now, and
   if people feel strongly, my series provides a sane basis for a patch
   that does this automatically.

 - Johannes complained about having to set "diff.foo.binary = false"
   when we have set "diff.foo.textconv".  I agree that having to set it
   is cumbersome, but what's worse is that it is wrong. You are saying
   "this file is not binary" which is only _sometimes_ true. That is, it
   is only true if we are in a command which actually performs the text
   conversion. Plumbing sees _just_ the binary half, which is outright
   wrong (and which became painfully obvious once I wrote some tests).

   The solution is that textconv'd data should always be treated as
   text, and that takes some refactoring of my patches. I will post a
   series dealing with this in a minute.

Hopefully that explanation made sense. This turned out to be a lot
trickier than I thought (in combination with my apparent crack habit),
and I just spent several hours trying to figure out all of the niggling
details. But I realize the rest of you haven't thought about it for at
least a week. :)

-Peff
