From: Jeff King <peff@peff.net>
Subject: Re: [PATCH] t3910: show failure of core.precomposeunicode with
 decomposed filenames
Date: Mon, 28 Apr 2014 15:35:02 -0400
Message-ID: <20140428193502.GD25993@sigill.intra.peff.net>
References: <20140428161630.GA9435@sigill.intra.peff.net>
 <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Apr 28 21:35:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WerKZ-00027m-EI
	for gcvg-git-2@plane.gmane.org; Mon, 28 Apr 2014 21:35:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755695AbaD1TfF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 28 Apr 2014 15:35:05 -0400
Received: from cloud.peff.net ([50.56.180.127]:40609 "HELO peff.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with SMTP
	id S1754774AbaD1TfE (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 28 Apr 2014 15:35:04 -0400
Received: (qmail 13225 invoked by uid 102); 28 Apr 2014 19:35:04 -0000
Received: from c-71-63-4-13.hsd1.va.comcast.net (HELO sigill.intra.peff.net) (71.63.4.13)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Mon, 28 Apr 2014 14:35:04 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Mon, 28 Apr 2014 15:35:02 -0400
Content-Disposition: inline
In-Reply-To: <xmqqbnvlqn5j.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/247412>

On Mon, Apr 28, 2014 at 12:17:28PM -0700, Junio C Hamano wrote:

> >   3. Convert index filenames to their precomposed form when
> >      we read the index from disk. This would be efficient,
> >      but we would have to be careful not to write the
> >      precomposed forms back out to disk.
> 
> I think this may be the right approach, especially if you are going
> to do this only when core.precomposeunicode is set.
> 
> the reasoning behind "we would have to be careful not to write"
> part, is unclear to me, though.  Don't decomposing filesystems
> perform the manglig from the precomposed form without even being
> asked to do so, just like a case insensitive filesystem will
> overwrite an existing "makefile" on a request to write to
> "Makefile"?

Sorry, I meant "do not write the precomposed forms back out to the
on-disk index". And by extension, do not update cache-tree and write
them out to git trees.

IOW, it is not enough to just set cache_entry->name to the normalized
form. You'd need to store both.

Since such entries are in the minority, and because cache_entry is
already a variable-length struct, I think you could get away with
sticking it after the "name" field, and then comparing like:

  const char *ce_normalized_name(struct cache_entry *ce, size_t *len)
  {
	const char *ret;

	/* Normal, fast path */
	if (!(ce->ce_flags & CE_NORMALIZED_NAME)) {
		len = ce_namelen(ce);
		return ce->name;
	}

	/* Slow path for normalized names */
	ret = ce->name + ce->namelen + 1;
	*len = strlen(name);
	return ret;
  }

The strlen is probably OK since such paths are presumably in the
minority (even for UTF-8 paths, we can avoid storing the extra copy if
they do not need any normalization). Or we could get fancy and encode
the length in front, but I am not sure it is worth the complexity.

Anyway, the tricky part is then making sure that all cache_entry name
comparisons use ce_normalized_name instead of ce->name.

-Peff
