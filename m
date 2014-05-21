From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v6] format-patch --signature-file <file>
Date: Wed, 21 May 2014 18:02:50 -0400
Message-ID: <20140521220250.GA11970@sigill.intra.peff.net>
References: <1400634170-18266-1-git-send-email-jmmahler@gmail.com>
 <1400634170-18266-2-git-send-email-jmmahler@gmail.com>
 <xmqq61kyq1i5.fsf@gitster.dls.corp.google.com>
 <20140521215059.GB13956@hudson.localdomain>
 <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Jeremiah Mahler <jmmahler@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu May 22 00:02:58 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnEbA-00087J-Gs
	for gcvg-git-2@plane.gmane.org; Thu, 22 May 2014 00:02:56 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753247AbaEUWCx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 May 2014 18:02:53 -0400
Received: from cloud.peff.net ([50.56.180.127]:56837 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1753183AbaEUWCw (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 May 2014 18:02:52 -0400
Received: (qmail 8356 invoked by uid 102); 21 May 2014 22:02:52 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 21 May 2014 17:02:52 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 21 May 2014 18:02:50 -0400
Content-Disposition: inline
In-Reply-To: <xmqqoayqoktp.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249845>

On Wed, May 21, 2014 at 02:58:42PM -0700, Junio C Hamano wrote:

> >> >  	! grep "^-- \$" output
> > ...
> >> 
> >> We have been trying not to do the above in recent test updates.  It
> >> would be nice if this set-up did not have to be outside of the usual
> >> test_expect_success structure.
> >> 
> >
> > Jeff caught those "! grep" instances in my patch.
> 
> Hmm, I didn't mean that one, and I do not offhand what is wrong
> about "! grep" that says "output should not contain this string".

I think he is responding to my earlier request to use test_must_fail
instead of "!".  But there is a subtlety there he does not know, which
is that we typically only use the former for git programs, and rely on
"!" for normal Unix commands.

> The problem is a "cat" you added outside test_expect_*; the recent
> push is to have as little executable outside them, especially the
> "set-up" code to prepare for the real tests.
> 
> i.e. we have been trying to write new tests (and convert old ones)
> like this:
> 
>         test_expect_success 'I test such and such ' '
>                 cat >input-for-test <<-\EOF &&
>                 here comes input
>                 EOF
>                 git command-to-be-tested <input-for-test >actual &&
>                 cat >expected <<-\EOF &&
>                 here comes expected output
>                 EOF
>                 test_cmp expected actual
>         '
> 
> not like this:
> 
>         cat >input-for-test <<-\EOF &&
>         here comes input
>         EOF
>         test_expect_success 'I test such and such ' '
>                 git command-to-be-tested <input-for-test >actual &&
>                 cat >expected <<-\EOF &&
>                 here comes expected output
>                 EOF
>                 test_cmp expected actual
>         '

Yeah, I noticed and gave a pass on this in earlier review, because the
file is used across many tests. So burying it in the first test that
uses it is probably a bad thing. However, it could go in its own setup
test.

-Peff
