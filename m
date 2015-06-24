From: Theodore Ts'o <tytso@mit.edu>
Subject: Re: [PATCH] Enable core.fsyncObjectFiles by default
Date: Wed, 24 Jun 2015 10:30:07 -0400
Message-ID: <20150624143007.GC14324@thunk.org>
References: <1435096643-18159-1-git-send-email-sbeller@google.com>
 <xmqqpp4maww7.fsf@gitster.dls.corp.google.com>
 <20150623232921.GB14324@thunk.org>
 <xmqqegl1brjb.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <sbeller@google.com>, git@vger.kernel.org,
	peff@peff.net, torvalds@linux-foundation.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jun 24 16:30:31 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z7lh4-000325-7T
	for gcvg-git-2@plane.gmane.org; Wed, 24 Jun 2015 16:30:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753585AbbFXOaR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Jun 2015 10:30:17 -0400
Received: from imap.thunk.org ([74.207.234.97]:52598 "EHLO imap.thunk.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752908AbbFXOaM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Jun 2015 10:30:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=thunk.org; s=ef5046eb;
	h=In-Reply-To:Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date; bh=+tnYW9BaYECJKlg3RnSB4+F+o+LCTx/go0SMhTVW9x4=;
	b=bMC8Zwr1AV/ZRH7GLipwIfjXyWVjaHFB1KmbVWc+hL486l0KM13SODb8qa5sRJyco4wWqUrgYGxyWKhVIkSiA+mN75a/8oWkRRnIvf17R5yjlORBGL/5EUIxfJch1hYrC68QNXnDJ753WLKijp61JA7F7QWasrIDa7hZzlTt4tk=;
Received: from root (helo=closure.thunk.org)
	by imap.thunk.org with local-esmtp (Exim 4.84)
	(envelope-from <tytso@thunk.org>)
	id 1Z7lgm-0004g3-JY; Wed, 24 Jun 2015 14:30:08 +0000
Received: by closure.thunk.org (Postfix, from userid 15806)
	id A8E16580A74; Wed, 24 Jun 2015 10:30:07 -0400 (EDT)
Content-Disposition: inline
In-Reply-To: <xmqqegl1brjb.fsf@gitster.dls.corp.google.com>
User-Agent: Mutt/1.5.23 (2014-03-12)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: tytso@thunk.org
X-SA-Exim-Scanned: No (on imap.thunk.org); SAEximRunCond expanded to false
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/272551>

On Tue, Jun 23, 2015 at 10:32:08PM -0700, Junio C Hamano wrote:
> 
> Regarding loose object files, given that we write to a temporary,
> optionally fsync, close and then move to the final name, would we
> still see partially written file if we omit the fsync, or would the
> corruption be limited to either empty or missing?

*Most* of the time the corruption will be an empty or missing file.
It's possible that the file could be partially written.  This is a
relatively low-probability event, with the probability going up if the
object file is large, and/or if the system is under memory pressure.

> The reason I am wondering is because the codepath to create an
> object (i.e. "update-index --add", "hash-object -w", or "add") first
> checks if a packed or a loose object file _exists_ and if so
> bypasses writing the same thing anew, but the existence check for a
> loose object is to merely making sure that access(F_OK) (and
> optionally utime()) succeeds.  If the potential breakage is limited
> to truncation to empty, then we could replace it with stat(2) and
> st.st_size check, as no loose object file can be empty.

It would certainly be a good thing to do a st_size check; it can't
possible hurt, and it will catch a large number of failures after a
power failure.  I could also imagine some hueristics that force an
fsync if the object file is larger than a certain size (say, 4k if you
are very paranoid, a few hundred kilobytes if you are less so), but
past a certain point, it might be better just to tell the user to use
fsyncObjectFiles and be done with it.

						- Ted
