From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 3 Jul 2013 08:34:25 +0200
Message-ID: <CALKQrgdovWTd50LVDnNR+BhurWgSCKkhr88wCo01VZF3sd5PNg@mail.gmail.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
	<CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 08:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UuGeL-0008GY-MV
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 08:34:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753697Ab3GCGeb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 3 Jul 2013 02:34:31 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:58975 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753255Ab3GCGea (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 3 Jul 2013 02:34:30 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuGe4-000429-Vz
	for git@vger.kernel.org; Wed, 03 Jul 2013 08:34:28 +0200
Received: from mail-oa0-f41.google.com ([209.85.219.41])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1UuFOV-000MvY-Qa
	for git@vger.kernel.org; Wed, 03 Jul 2013 07:14:19 +0200
Received: by mail-oa0-f41.google.com with SMTP id n10so7666105oag.28
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 23:34:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=aW7y4W57y58jElYF/PvfWbyV1yizWyawvxxc7GXqTKw=;
        b=Zm2UCqMrJjRVOFPirPEV/+dVjp3AlxtHhB2KuhJkpoGWMgGpo+JYFEppB13xyVcXjl
         xlXxNQgG1mJDAxxoBtbewBe6Pk7RkgHtaNe23rkbjOEVNMW/WCACg5pg0KhItoRpsORL
         jXNYZylqm0Azrdu1sO7wgm7tOsSXDfHxCJV43WWyv122KJW94+G+YQRDq28Q8K+de4tu
         8ZyYpZ8OPxKFE4P1ZbmcNM2+m+sWbytKBW/9UASLLqCo9ySSgWtvAd4G44nm4zHI54Sm
         +SU6LK0Goq/dgPysb2Ue18S4P85zM5PONn7v2HZgmsswX+ItWDbeiboS/Ky7schCgKPW
         BjvQ==
X-Received: by 10.60.84.147 with SMTP id z19mr14712441oey.21.1372833265160;
 Tue, 02 Jul 2013 23:34:25 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Tue, 2 Jul 2013 23:34:25 -0700 (PDT)
In-Reply-To: <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229454>

On Wed, Jul 3, 2013 at 12:55 AM, Johan Herland <johan@herland.net> wrote:
> I assume that in most cases the expected value of the remote ref would
> equal the current value of the corresponding remote-tracking ref in
> the user's repo, so why not use that as the default expected value?
> E.g.:
>
>   $ git config push.default simple
>   $ git checkout -b foo -t origin/foo
>   # prepare non-ff update
>   $ git push --force-if-expected
>   # the above validates foo @ origin != origin/foo before pushing

Oops, typo: s/!=/==/

>
> And if the users expects a different value, (s)he can pass that to the
> same option:
>
>   $ git push --force-if-expected=refs/original/foo my_remote HEAD:foo
>   # the above fails if foo @ origin != refs/original/foo
>
> The option name probably needs a little work, but as long as it
> properly communicates the user's _intent_ I'm fine with whatever we
> call it.

Overnight, it occured to me that --force-if-expected could be
simplified by leveraging the existing --force option; for the above
two examples, respectively:

  $ git push --force --expect
  # validate foo @ origin == @{upstream} before pushing

and

  $ git push --force --expect=refs/original/foo my_remote HEAD:foo
  # validate foo @ my_remote == refs/original/foo before pushing

In other words, the --expect option becomes a modifier on the --force
behaviour: If --expect is given, and the remote ref is not as
expected, then the push will still fail, even when --force is given.
Furthermore, this could be fleshed out by allowing the user to
configure push.expect = True, in which case --expect will be assumed
whenever --force is used, and the user can override with --no-expect.

If push.expect == True (or if --expect is given on command-line
without a parameter), we default to using @{upstream} as the expected
value, and we complain to the user if the current branch has no
upstream. This way, you can still enable push.expect even when you do
not configure @{upstream}, but it compels you to always supply
--expect=$something (or --no-expect) when you use --force.


...Johan

PS: I'm still unsure about the option naming. Maybe --validate would
be better than --expect, but I feel it should convey more strongly
that we're doing _pre_-validation, as opposed to (post-)validating the
_result_ of the push, whatever that would look like.

-- 
Johan Herland, <johan@herland.net>
www.herland.net
