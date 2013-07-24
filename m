From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v8 4/4] config: allow http.<url>.* any user matching
Date: Wed, 24 Jul 2013 02:42:59 -0400
Message-ID: <20130724064258.GA30074@sigill.intra.peff.net>
References: <3c7fc982841069ce79faf227e007815@f74d39fa044aa309eaea14b9f57fe79>
 <7dfaadb69accede33b88ae2d9e47a48@f74d39fa044aa309eaea14b9f57fe79>
 <7vehaqcw66.fsf@alter.siamese.dyndns.org>
 <DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	David Aguilar <davvid@gmail.com>, Petr Baudis <pasky@ucw.cz>,
	Richard Hartmann <richih.mailinglist@gmail.com>,
	Daniel Knittl-Frank <knittl89@googlemail.com>,
	Jan =?utf-8?Q?Kr=C3=BCger?= <jk@jk.gs>,
	Alejandro Mery <amery@geeks.cl>,
	Aaron Schrab <aaron@schrab.com>,
	Eric Sunshine <sunshine@sunshineco.com>
To: "Kyle J. McKay" <mackyle@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jul 24 08:43:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V1sn0-0000Yy-11
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jul 2013 08:43:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752145Ab3GXGnF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jul 2013 02:43:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:36397 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751637Ab3GXGnD (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jul 2013 02:43:03 -0400
Received: (qmail 19594 invoked by uid 102); 24 Jul 2013 06:43:02 -0000
Received: from c-98-244-76-202.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (98.244.76.202)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Wed, 24 Jul 2013 01:43:02 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Wed, 24 Jul 2013 02:42:59 -0400
Content-Disposition: inline
In-Reply-To: <DF5B20F8-33C2-4F72-A78B-97EE1FB4A522@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/231078>

On Mon, Jul 22, 2013 at 01:24:06PM -0700, Kyle J. McKay wrote:

> >I am not yet convinced that the precedence rule specified in this
> >what we want (I do not have an example why it is *not* what we want,
> >either).  Another definition could be "if user@ is present in the
> >request, give lower precedence to config entries for the site
> >without user@ than entries with user@", and I do not have a strong
> >opinion myself which one between the two is better (and there may be
> >third and other possible rule).
> >
> >Comments?
> 
> Consider this site:
> [...]

Thanks for explaining, and sorry I missed out on the last few rounds of
review.

I think your scheme (normalization plus special handling of the username
field) addresses my biggest concern, which is matching in the face of
optional usernames. The only two things that make me wary are:

  1. The explanation and special-casing of username is a little
     complicated to explain.

  2. The behavior for resolving the value when faced with multiple
     possibilities is completely unlike the rest of the config system
     (both dropping last-one-wins, and unlike the URL matching for
     credentials).

I think we can decide that (2) is worth it if your semantics are more
flexible in practice. It would be nice to see real-world feedback on how
people use it before setting the behavior in stone, but there's sort of
a chicken and egg problem there.

For (1), I wonder if the explanation would be simpler if the precedences
of each sub-part were simply laid out. That is, would it be correct to
say something like:

  For a config key to match a URL, each element of the config key (if
  present) is compared to that of the URL, in the following order:

    1. Protocol (e.g., `https` in `https://example.com/`). This field
       must match exactly between the config key and the URL.

    2. Host/domain name (e.g., `example.com` in `https://example.com/`).
       This field must match exactly between the config key and the URL.

    3. Path (e.g., `repo.git` in `https://example.com/repo.git`). This
       field is prefix-matched by slash-delimited path elements, so that
       config key `foo/` matches URL `foo/bar`. Longer matches take
       precedence (so `foo/bar`, if it exists, is a better match than
       just `foo/`).

    4. Username (e.g., `user` in `https://user@example.com/repo.git`).

  The list above is ordered by decreasing precedence; a URL that matches
  a config key's path is preferred to one that matches its username.

I don't know if that is more or less clear of an explanation. It makes
more sense to me, but that is probably because I wrote it. I'm also not
100% sure it describes your implementation, but I think it is equivalent
to the prefix matching with normalization.

I have a few other comments on specific patches; I'll send them
separately.

-Peff
