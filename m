From: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
Subject: Re: [PATCH] grep: do not do external grep on skip-worktree entries
Date: Sun, 3 Jan 2010 02:15:22 +0700
Message-ID: <fcaeb9bf1001021115j7b23264n42cfba7855c2253e@mail.gmail.com>
References: <1262182304-19911-1-git-send-email-pclouds@gmail.com>
	 <7v637nzky0.fsf@alter.siamese.dyndns.org>
	 <7vzl4zy5z3.fsf@alter.siamese.dyndns.org> <20100102115041.GA32381@do>
	 <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Jan 02 20:15:57 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NR9S8-0004vc-2K
	for gcvg-git-2@lo.gmane.org; Sat, 02 Jan 2010 20:15:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751202Ab0ABTP0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 2 Jan 2010 14:15:26 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751162Ab0ABTP0
	(ORCPT <rfc822;git-outgoing>); Sat, 2 Jan 2010 14:15:26 -0500
Received: from mail-yw0-f176.google.com ([209.85.211.176]:44893 "EHLO
	mail-yw0-f176.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751027Ab0ABTPZ (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 2 Jan 2010 14:15:25 -0500
Received: by ywh6 with SMTP id 6so14155949ywh.4
        for <git@vger.kernel.org>; Sat, 02 Jan 2010 11:15:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type;
        bh=2CzWtI07LdaIdOtR/ziUw4iuuVpT+DUwowHHgOO73gA=;
        b=SbXG7G4JueTS24SIYmwmhyDtic/1B6pmYm+fHSNDo3HfYGtOM3OC1M6tyPe7AJOkZo
         ctFHw6KwHQ1j5lsCvZY8mmM9hPg2rWwzj6FVf7o0DS3X+jlSoMXuDGpprhbo2WFOJJmr
         pMeUmxbkjk8NeS4O3VeNKxKmpC7uerU+6UPQE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        b=K2Xk4W+TzQsu3l4lebgYjE2tBU/2XZzdzONhLljrD0UKwv6t4ibrExX6ModXAC33Qq
         BOFJK4b1w23htQYDAH4itUqUQd+cKjJvOZ6Z0LlrF+MH+uaFZIFuZ4Sce5JCOVGVdCdV
         GyXazZ+U+Cz/cuqrnGwLKqiaYRiRrEaXZl+6E=
Received: by 10.101.176.7 with SMTP id d7mr90837anp.71.1262459722521; Sat, 02 
	Jan 2010 11:15:22 -0800 (PST)
In-Reply-To: <7vtyv4cpna.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/136040>

On 1/3/10, Junio C Hamano <gitster@pobox.com> wrote:
> Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:
>
>  > On Wed, Dec 30, 2009 at 11:09:52PM -0800, Junio C Hamano wrote:
>  >> Junio C Hamano <gitster@pobox.com> writes:
>  >>
>  >> > This looks a bit wrong for a couple of reasons:
>  >> >
>  >> >  - external_grep() is designed to return negative without running external
>  >> >    grep when it shouldn't be used (see the beginning of the function for
>  >> >    how it refuses to run when opt->extended is set and other conditions).
>  >> >    The new logic seems to belong there, i.e. "in addition to the existing
>  >> >    case we decline, if ce_skip_worktree() entry exists in the cache, we
>  >> >    decline";
>  >>
>  >> IOW, something like this instead of your patch.  You would want to tests
>  >> to demonstrate the original breakage, perhaps?
>  >
>  > Your patch works great. By the way I think we should move "cached"
>  > check from grep_cache() into external_grep() too, for consistency.
>
>
> I think what I gave you is more consistent.
>
>  "cached" is about "are we searching in the index or in the work tree?" and
>  "external_grep()" is about "it often is faster to run external grep when
>  we are searching in the work tree, so do that if the other constraints
>  allow us to".  An example of such a constraint is that we must be able to
>  express the operation on the command line of a traditional grep, and use
>  of git extended grep synatx makes it unfeasible, hence the function says
>  "I can't" in such a case.
>
>  You can change the definition of "external_grep()" to "try to use external
>  grep somewhere, if the other constraints allow us to", and have the caller
>  and the function do an "this time, please grep for this pattern in the
>  index---I can't" exchange, but I don't see much point.  We _know_ no
>  external grep will ever be able to read from the index.
>
>  We should simply drop "cached" argument from external_grep().

OK.

>  > diff --git a/t/t7002-grep.sh b/t/t7002-grep.sh
>  > index abd14bf..f77970c 100755
>  > --- a/t/t7002-grep.sh
>  > +++ b/t/t7002-grep.sh
>  > @@ -8,6 +8,14 @@ test_description='git grep various.
>  >
>  >  . ./test-lib.sh
>  >
>  > +support_external_grep() {
>  > +     case "$(git grep -h 2>&1 >/dev/null|grep -e --ext-grep)" in
>  > +     *"(default)"*)  return 0;;
>  > +     *"(ignored by this build)"*) return 1;;
>  > +     *) test_expect_success 'External grep check is broken' 'false';;
>  > +     esac
>  > +}
>
>
> Heh, clever.
>
>         git grep -h 2>&1 | grep 'allow calling of grep.*default' >/dev/null
>
>  may be sufficient, though.
>

Yes, until somebody changes help text in builtin-grep.c and all
external grep tests become disable. I wanted to catch that case too.

Or maybe just add another option --show-features to "git rev-parse"
(or extend git version string, is the version format fixed?) to list
all built-time features that a git build supports. Some comes to mind:
external-grep, iconv, ipv6, http (unlikely), threading... Much less
tricky to test.
-- 
Duy
