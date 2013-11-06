From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v5 06/10] fast-export: add new --refspec option
Date: Wed, 6 Nov 2013 14:14:27 -0800
Message-ID: <20131106221427.GB13258@sigill.intra.peff.net>
References: <1383212197-14259-1-git-send-email-felipe.contreras@gmail.com>
 <1383212197-14259-6-git-send-email-felipe.contreras@gmail.com>
 <xmqq61sd70vw.fsf@gitster.dls.corp.google.com>
 <CAMP44s246M5DaeX80tqzfjRWnbE4vKh-vp_tLW-qAQUFFPsP0Q@mail.gmail.com>
 <xmqq38n98cud.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Richard Hansen <rhansen@bbn.com>,
	Ramsay Jones <ramsay@ramsay1.demon.co.uk>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Nov 06 23:14:44 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VeBN5-0002vX-IF
	for gcvg-git-2@plane.gmane.org; Wed, 06 Nov 2013 23:14:43 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754579Ab3KFWOa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 6 Nov 2013 17:14:30 -0500
Received: from cloud.peff.net ([50.56.180.127]:34566 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754112Ab3KFWO3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 6 Nov 2013 17:14:29 -0500
Received: (qmail 11098 invoked by uid 102); 6 Nov 2013 22:14:29 -0000
Received: from GITHUB-INC.bar1.SanFrancisco1.Level3.net (HELO sigill.intra.peff.net) (4.53.133.38)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 06 Nov 2013 16:14:29 -0600
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 06 Nov 2013 14:14:27 -0800
Content-Disposition: inline
In-Reply-To: <xmqq38n98cud.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237373>

On Wed, Nov 06, 2013 at 01:00:42PM -0800, Junio C Hamano wrote:

> I didn't think things through, but at the external UI level, I see a
> possibility of a nicer way to express the above.
> 
> In our "push" refspec (and export is about pushing what we have), a
> colonless refspec A is a short-hand for A:A, so the traditional
> 
> 	git fast-export master
> 
> can be thought of, in a new world order with a patch that lets you
> do a ref mapping, a short-hand for an identical mapping:
> 
> 	git fast-export master:master
> 
> It follows that the syntax naturally support
> 
> 	git fast-export refs/heads/master:refs/heads/foobar
> 
> I would think.
> 
> That approach lets you express ref mapping without a new option
> --refspec, which goes contrary to existing UI for any commands in
> Git (I think nobody takes refspec as a value to a dashed-option in
> the transport; both in fetch and push, they are proper operands,
> i.e. command line arguments to the command), no?

I think that is much nicer for the simple cases, but how do we handle
more complex rev expressions? One can say:

  git fast-export master ^origin

or even:

  git fast-export origin..master

The "^origin" is not a refspec, and finding the refspec in the
dot-expression would involve parsing it into two components. I think you
can come up with a workable system by parsing the arguments as revision
specifiers and then applying some rules. E.g., a positive ref "foo" is a
refspec "foo:foo", but negative "^bar" does not impact refspecs at all,
and the same rules are applied for "bar..foo". There is a syntactic
conflict where "foo:bar" would be interpreted as a tree:path by the
revision code, though, whereas in this context it means a refspec.

So I think it is possible to go that route (and perhaps preferable,
even, because it keeps the simple and common cases easy for the user),
but the implementation is not as simple as just treating the arguments
as refspecs.

-Peff
