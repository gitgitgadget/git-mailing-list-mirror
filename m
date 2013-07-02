From: Johan Herland <johan@herland.net>
Subject: Re: [RFD] Making "git push [--force/--delete]" safer?
Date: Wed, 3 Jul 2013 00:55:34 +0200
Message-ID: <CALKQrgenpqKUxOZ+p79NsaQD9M2-q4h93ZqN0oencVo-QZF=zg@mail.gmail.com>
References: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jul 03 00:55:51 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Uu9UC-0005SZ-Eg
	for gcvg-git-2@plane.gmane.org; Wed, 03 Jul 2013 00:55:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755596Ab3GBWzm (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 2 Jul 2013 18:55:42 -0400
Received: from mail10.copyleft.no ([188.94.218.231]:62062 "EHLO
	mail10.copyleft.no" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753052Ab3GBWzl (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 2 Jul 2013 18:55:41 -0400
Received: from locusts.copyleft.no ([188.94.218.116] helo=mail.mailgateway.no)
	by mail10.copyleft.no with esmtp (Exim 4.66 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uu9U2-000POs-Ny
	for git@vger.kernel.org; Wed, 03 Jul 2013 00:55:39 +0200
Received: from mail-oa0-f49.google.com ([209.85.219.49])
	by mail.mailgateway.no with esmtpsa (TLSv1:RC4-SHA:128)
	(Exim 4.72 (FreeBSD))
	(envelope-from <johan@herland.net>)
	id 1Uu8EU-000Fuu-6g
	for git@vger.kernel.org; Tue, 02 Jul 2013 23:35:30 +0200
Received: by mail-oa0-f49.google.com with SMTP id n9so7117625oag.36
        for <git@vger.kernel.org>; Tue, 02 Jul 2013 15:55:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=/dhcWzxetOTQtp26RD4UYSgQo2wUJtgxfv0Jcqmc/jM=;
        b=h/tGyerFBJr0W3dhWoFdaECOGPLVe1CUC413jCsuSFXpvgLTuXwoyDavS1HKKxuVx4
         /r/lmIszrQbm8/fYbWzBVZrIaKEzJTKoNMBWaMMGcW4mBeByTE1JcXqsLD+9J08lgY7u
         3qVy1y8k90D+IVtty5s4Q2HQd2x5rVwL2M9TpbM7Pm/0h++7hihOr1q+r+nehhz8p93s
         kTuR5JXIE08OEE7QTGRioEh9y490km9WZvTyIkZkbyMl82vZng1c7MFClHCrpwmSCkIc
         LCVV0z1mS+/qZYXPhy94JhR8ficmANFdwwWl8lwZ0D9UdIn8Tb14Byd8+l5uurpblIA8
         aBPg==
X-Received: by 10.182.213.10 with SMTP id no10mr14447127obc.76.1372805734963;
 Tue, 02 Jul 2013 15:55:34 -0700 (PDT)
Received: by 10.182.102.5 with HTTP; Tue, 2 Jul 2013 15:55:34 -0700 (PDT)
In-Reply-To: <7vfvvwk7ce.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229444>

On Tue, Jul 2, 2013 at 10:57 PM, Junio C Hamano <gitster@pobox.com> wrote:

[...]

>   (2) Add --compare-and-swap=dst:expect parameters, e.g.
>
>       $ git push --cas=master:deadbabecafe --cas=next:cafebabe ":"
>
>       This removes the "reservation" I expressed against (1) above
>       (i.e. we are doing a "matching" push in this example, but we
>       will fail if 'master' and 'next' are not pointing at the
>       expected objects).

I still think this is too long/verbose for the average user to
remember, and type out. Also, I don't like the name, as it is too
'technical', and describes the nature of the implementation (i.e. the
"how") rather than the purpose of using it (i.e. the "why" or "what").

>   (3) Add a mechanism to call a custom validation script after "git
>       push" reads the list of <current object name, refname> tuples,
>       but before responding with the proposed update.  The script
>       would be fed a list of <current object name, new object
>       name, refname> tuples (i.e. what the sender _would_ tell the
>       receiving end if there weren't this mechanism), and can tell
>       "git push" to fail with its exit status.
>
>       This would be the most flexible in that the validation does
>       not have to be limited to "the ref must be still pointing at
>       the object we expect" (aka compare-and-swap); the script could
>       implement other semantics (e.g. "the ref must be pointing at
>       the object or its ancestor").

With this, I guess --dry-run could be reformulated as a trivial
validation script that always returns a non-zero exit code (although
it should still cause 'push' to return zero).

[...]

> I am inclined to say, if we were to do this, we should do (2) among
> the above three.
>
> But of course, others may have better ideas ;-).

I assume that in most cases the expected value of the remote ref would
equal the current value of the corresponding remote-tracking ref in
the user's repo, so why not use that as the default expected value?
E.g.:

  $ git config push.default simple
  $ git checkout -b foo -t origin/foo
  # prepare non-ff update
  $ git push --force-if-expected
  # the above validates foo @ origin != origin/foo before pushing

And if the users expects a different value, (s)he can pass that to the
same option:

  $ git push --force-if-expected=refs/original/foo my_remote HEAD:foo
  # the above fails if foo @ origin != refs/original/foo

The option name probably needs a little work, but as long as it
properly communicates the user's _intent_ I'm fine with whatever we
call it.


...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
