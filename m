From: Jeff King <peff@peff.net>
Subject: Re: [PATCH 6/7] t1303 (config): style tweaks
Date: Tue, 7 Sep 2010 00:30:50 -0400
Message-ID: <20100907043050.GA13291@sigill.intra.peff.net>
References: <4C85357A.8090000@web.de>
 <20100906190655.GG25426@burratino>
 <4C854B36.6010606@web.de>
 <20100907014135.GA1182@burratino>
 <20100907015317.GG1182@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jens Lehmann <Jens.Lehmann@web.de>,
	Junio C Hamano <gitster@pobox.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 07 06:30:39 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OsppN-0005j5-CL
	for gcvg-git-2@lo.gmane.org; Tue, 07 Sep 2010 06:30:37 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750814Ab0IGEad (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 Sep 2010 00:30:33 -0400
Received: from xen6.gtisc.gatech.edu ([143.215.130.70]:60599 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750745Ab0IGEac (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 Sep 2010 00:30:32 -0400
Received: (qmail 2955 invoked by uid 111); 7 Sep 2010 04:30:30 -0000
Received: from 99-108-226-0.lightspeed.iplsin.sbcglobal.net (HELO sigill.intra.peff.net) (99.108.226.0)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.40) with ESMTPA; Tue, 07 Sep 2010 04:30:30 +0000
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 07 Sep 2010 00:30:50 -0400
Content-Disposition: inline
In-Reply-To: <20100907015317.GG1182@burratino>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/155671>

On Mon, Sep 06, 2010 at 08:53:18PM -0500, Jonathan Nieder wrote:

> This test already has impeccable style,

I don't think my style has ever been called impeccable...

> with one exception: there is an unnecessary use of a subshell.  Use a
> {} block instead.

OK. Does this actually matter for anything? I know Windows has slow
fork, but I doubt it is measurable here.

> While at it:
> 
>  - guard setup commands with test_expect_success, so the commands
>    are printed when the test is run with "-v" and errors in setup
>    can be caught;

This confuses me. The setup is _already_ run inside test_expect_success.
It is only the shell function definitions you are moving inside. Do we
really care about this? If so, aren't there a zillion other places where
we define shell functions in test scripts? Try "git grep
'^[a-z][a-z]* *('".

You do move some variable definitions inside, too,, but IMO you are
making at least one of them less readable, because you have to deal with
the extra quoting layer of test_expect_success. IOW:

> -SECTION="test.q\"s\\sq'sp e.key"
>  test_expect_success 'make sure git config escapes section names properly' '
> +       SECTION="test.q\"s\\sq'\''sp e.key" &&

seems like a net loss to me.

>  - use echo instead of printf to print simple text ending with a
>    newline, so the later use of printf stands out more;

No complaint here.

>  - put a single space before () in function definitions, for
>    consistency with other shell scripts in git;

Again, I am not sure we care, but if we do, there are a ton of other
places: git grep '^[a-z][a-z]*('.

>  - reorder arguments to test_cmp as "test_cmp expected actual".

Yeah, I prefer it as "test_cmp expected actual". I'm surprised I ever
wrote it the other way (actually, I think it is because my writing
predates test_cmp, even).

So I dunno. Most of it I am fine with, though I question whether it is
really worth the effort. But I really don't want to be too draconian
about "everything must go into test_expect_success". Sure, if you are
executing commands that might have output, or might be of interest to
the user, put them there. But I find this a lot more readable:

cat >expect <<'EOF'
... some expected output ...
EOF
test_expect_success 'frob it' '
        git frob &&
        test_cmp expect actual
'

than:

test_expect_success 'frob it' '
        cat >expect <<"EOF" &&
... some expected output ...
EOF
        git frob &&
        test_cmp expect actual
'

-Peff
