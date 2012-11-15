From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] config: don't segfault when given --path with a missing
 value
Date: Thu, 15 Nov 2012 08:08:49 -0800
Message-ID: <20121115160847.GA6157@sigill.intra.peff.net>
References: <1352868604-20459-1-git-send-email-cmn@elego.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>
X-From: git-owner@vger.kernel.org Thu Nov 15 17:09:09 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TZ204-0005hN-Tu
	for gcvg-git-2@plane.gmane.org; Thu, 15 Nov 2012 17:09:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1768361Ab2KOQIx convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 15 Nov 2012 11:08:53 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:49499 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1768346Ab2KOQIx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 15 Nov 2012 11:08:53 -0500
Received: (qmail 17474 invoked by uid 107); 15 Nov 2012 16:09:42 -0000
Received: from m8c0536d0.tmodns.net (HELO sigill.intra.peff.net) (208.54.5.140)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Thu, 15 Nov 2012 11:09:42 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Thu, 15 Nov 2012 08:08:49 -0800
Content-Disposition: inline
In-Reply-To: <1352868604-20459-1-git-send-email-cmn@elego.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/209822>

On Tue, Nov 13, 2012 at 08:50:04PM -0800, Carlos Mart=C3=ADn Nieto wrot=
e:

> When given a variable without a value, such as '[section] var' and
> asking git-config to treat it as a path, git_config_pathname returns
> an error and doesn't modify its output parameter. show_config assumes
> that the call is always successful and sets a variable to indicate
> that vptr should be freed. In case of an error however, trying to do
> this will cause the program to be killed, as it's pointing to memory
> in the stack.

Whoops.

> Set the must_free_vptr flag depending on the return value of
> git_config_pathname so it's accurate.

That is definitely the right thing to do. But do we also need to take
note of the error for later? After this code:

>  	} else if (types =3D=3D TYPE_PATH) {
> -		git_config_pathname(&vptr, key_, value_);
> -		must_free_vptr =3D 1;
> +		must_free_vptr =3D !git_config_pathname(&vptr, key_, value_);

We don't have any clue that nothing got written into vptr. Which means
it still points at the stack buffer "value", which contains
uninitialized bytes. We will later try to print it, thinking it has the
expanded path in it.

Do we need something like:

  if (!git_config_pathname(&vptr, key_, value_))
          must_free_vptr =3D 1;
  else
          vptr =3D "";

?

-Peff
