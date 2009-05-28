From: Jeff King <peff@peff.net>
Subject: Re: [PATCH v2 2/2] diff: generate prettier filenames when using
	GIT_EXTERNAL_DIFF
Date: Thu, 28 May 2009 13:44:36 -0400
Message-ID: <20090528174436.GA12723@coredump.intra.peff.net>
References: <1243491077-27738-1-git-send-email-davvid@gmail.com> <1243491077-27738-2-git-send-email-davvid@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: git@vger.kernel.org, gitster@pobox.com, markus.heidelberg@web.de,
	jnareb@gmail.com, j.sixt@viscovery.net
To: David Aguilar <davvid@gmail.com>
X-From: git-owner@vger.kernel.org Thu May 28 19:45:04 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1M9jf4-00066v-BM
	for gcvg-git-2@gmane.org; Thu, 28 May 2009 19:45:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbZE1Roo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 28 May 2009 13:44:44 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755677AbZE1Roo
	(ORCPT <rfc822;git-outgoing>); Thu, 28 May 2009 13:44:44 -0400
Received: from peff.net ([208.65.91.99]:56621 "EHLO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756538AbZE1Ron (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 28 May 2009 13:44:43 -0400
Received: (qmail 22004 invoked by uid 107); 28 May 2009 17:44:47 -0000
Received: from coredump.intra.peff.net (HELO coredump.intra.peff.net) (10.0.0.2)
    by peff.net (qpsmtpd/0.40) with (AES128-SHA encrypted) SMTP; Thu, 28 May 2009 13:44:47 -0400
Received: by coredump.intra.peff.net (sSMTP sendmail emulation); Thu, 28 May 2009 13:44:36 -0400
Content-Disposition: inline
In-Reply-To: <1243491077-27738-2-git-send-email-davvid@gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/120203>

On Wed, May 27, 2009 at 11:11:17PM -0700, David Aguilar wrote:

> +int git_mkstemps(char *path, size_t n, const char *template, int suffix_len);

FWIW, I find this name not very descriptive. From the name, I would
expect it to do the exact same thing as mkstemps, but be our own
personal implementation. But it is actually a wrapper that behaves
somewhat differently. So I wonder if "mkstemps_tmpdir" or something
would be a better name.

> +	if (pretty_filename) {
> +		/* Generate "XXXXXX_filename" */

Is there a reason _not_ to always just use the pretty filename? It looks
like you turn it on for external diff, but off for textconv. I don't
think there is a reason not to use it for textconv.

Is there some other code path that changes it that I'm missing?

> +		int pretty_filename = 1;
> +		temp_one = prepare_temp_file(name, one, pretty_filename);
> +		temp_two = prepare_temp_file(othername, two, pretty_filename);

I think this reads much better as just:

  temp_one = prepare_temp_file(name, one, 1);
  temp_two = prepare_temp_file(othername, two, 1);

Then it eliminates one bit of state for the reader to keep track of; I
don't have to wonder if pretty_filename might ever change. If I care
about what the '1' means, I can go look at the definition of
prepare_temp_file (or if you really want to make it more
self-documenting, make it a "flags" field and set the
USE_PRETTY_FILENAME flag).

However, I suspect that all callers should use pretty filenames, and
then this bit would just go away.

> +	int pretty_filename = 0;
>  
> -	temp = prepare_temp_file(spec->path, spec);
> +	temp = prepare_temp_file(spec->path, spec, pretty_filename);

Ditto here.

-Peff
