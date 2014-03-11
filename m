From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] implement submodule config cache for lookup of submodule
 names
Date: Tue, 11 Mar 2014 17:58:08 -0400
Message-ID: <20140311215808.GB32129@sigill.intra.peff.net>
References: <20140310212412.GA8693@sandbox-ub>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Jens Lehmann <jens.lehmann@web.de>,
	Jonathan Nieder <jrnieder@gmail.com>
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Mar 11 22:58:17 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WNUgj-0005cH-4a
	for gcvg-git-2@plane.gmane.org; Tue, 11 Mar 2014 22:58:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755492AbaCKV6M (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 11 Mar 2014 17:58:12 -0400
Received: from cloud.peff.net ([50.56.180.127]:37669 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754268AbaCKV6K (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 11 Mar 2014 17:58:10 -0400
Received: (qmail 855 invoked by uid 102); 11 Mar 2014 21:58:10 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Tue, 11 Mar 2014 16:58:10 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Tue, 11 Mar 2014 17:58:08 -0400
Content-Disposition: inline
In-Reply-To: <20140310212412.GA8693@sandbox-ub>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243905>

On Mon, Mar 10, 2014 at 10:24:12PM +0100, Heiko Voigt wrote:

> I have also moved all functions into the new submodule-config-cache
> module. I am not completely satisfied with the naming since it is quite
> long. If someone comes up with some different naming I am open for it.
> Maybe simply submodule-config (submodule_config prefix for functions)?

Since the cache is totally internal to the submodule-config code, I do
not know that you even need to have a nice submodule-config-cache API.
Can it just be a singleton?

That is bad design in a sense (it becomes harder later if you ever want
to pull submodule config from two sources simultaneously), but it
matches many other subsystems in git which cache behind the scenes.

I also suspect you could call submodule_config simply "submodule", and
let it be a stand-in for the submodule (for now, only data from the
config, but potentially you could keep other data on it, too).

So with all that, the entry point into your code is just:

  const struct submodule *submodule_from_path(const char *path);

and the caching magically happens behind-the-scenes.

But take all of this with a giant grain of salt, as I am not too
familiar with the needs of the callers.

> +/* one submodule_config_cache entry */
> +struct submodule_config {
> +	struct strbuf path;
> +	struct strbuf name;
> +	unsigned char gitmodule_sha1[20];
> +};

Do these strings need changed after they are written once? If not, you
may want to just make these bare pointers (you can still use strbufs to
create them, and then strbuf_detach at the end). That may just be a matter of
taste, though.

-Peff
