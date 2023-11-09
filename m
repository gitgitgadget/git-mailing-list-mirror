Received: from lindbergh.monkeyblade.net (lindbergh.monkeyblade.net [23.128.96.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8A8EAD27E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 18:48:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dkim=none
Received: from cloud.peff.net (cloud.peff.net [104.130.231.41])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D40EB3C0E
	for <git@vger.kernel.org>; Thu,  9 Nov 2023 10:48:44 -0800 (PST)
Received: (qmail 31466 invoked by uid 109); 9 Nov 2023 18:48:44 -0000
Received: from Unknown (HELO peff.net) (10.0.1.2)
 by cloud.peff.net (qpsmtpd/0.94) with ESMTP; Thu, 09 Nov 2023 18:48:44 +0000
Authentication-Results: cloud.peff.net; auth=none
Received: (qmail 9087 invoked by uid 111); 9 Nov 2023 18:48:45 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
 by peff.net (qpsmtpd/0.94) with (TLS_AES_256_GCM_SHA384 encrypted) ESMTPS; Thu, 09 Nov 2023 13:48:45 -0500
Authentication-Results: peff.net; auth=none
Date: Thu, 9 Nov 2023 13:48:43 -0500
From: Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
Cc: Patrick Steinhardt <ps@pks.im>, git@vger.kernel.org
Subject: Re: [PATCH 1/4] global: convert trivial usages of `test <expr> -a/-o
 <expr>`
Message-ID: <20231109184843.GC2711684@coredump.intra.peff.net>
References: <cover.1699526999.git.ps@pks.im>
 <c5e627eb3fef0df162da56723093a03bfd2321fb.1699526999.git.ps@pks.im>
 <xmqqpm0jyx02.fsf@gitster.g>
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
List-Id: <git.vger.kernel.org>
List-Subscribe: <mailto:git+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:git+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <xmqqpm0jyx02.fsf@gitster.g>

On Thu, Nov 09, 2023 at 08:41:33PM +0900, Junio C Hamano wrote:

> > -elif test -d ${GIT_DIR:-.git} -o -f .git &&
> > +elif ( test -d ${GIT_DIR:-.git} || test -f .git ) &&
> 
> I do not think this is strictly necessary.
> 
> Because the command line parser of "test" comes from left, notices
> "-d" and takes the next one to check if it is a directory.  There is
> no value in ${GIT_DIR} can make "test -d ${GIT_DIR} -o ..." fail the
> same way as the problem Peff pointed out during the discussion.

I think this is one of the ambiguous cases. If $GIT_DIR is "=", then
"test" cannot tell if you meant:

  var1=-d
  var2=-o
  test "$var1" = "$var2" ...

or:

  var1="="
  test -d "$var1" -o ...

With bash, for example:

  $ test -d /tmp -o -f .git; echo $?
  0
  $ test -d = -o -f .git; echo $?
  bash: test: syntax error: `-f' unexpected
  2

Without "-o", it uses the number of arguments to disambiguate (though of
course the lack of quotes around $GIT_DIR is another potential problem
here).

And I think the same is true of the other cases below using "-z", "-n",
and so on.

But IMHO it is worth getting rid of all -o/-a regardless. Even
non-ambiguous cases make reasoning about the code harder, and we don't
want to encourage people to think they're OK to use.

> I do not need a subshell for grouping, either.  Plain {} should do
> (but you may need a LF or semicolon after the statement)..

This I definitely agree with. :)

-Peff
