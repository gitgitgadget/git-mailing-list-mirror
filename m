From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 18:05:08 -0500
Message-ID: <20130301230508.GC862@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:05:43 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZ1J-0001qo-ST
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:05:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751559Ab3CAXFN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:05:13 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39593 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751381Ab3CAXFM (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:05:12 -0500
Received: (qmail 4829 invoked by uid 107); 1 Mar 2013 23:06:47 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 18:06:47 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 18:05:08 -0500
Content-Disposition: inline
In-Reply-To: <20130301225231.GB862@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217302>

On Fri, Mar 01, 2013 at 05:52:31PM -0500, Jeff King wrote:

> > Note to bystanders.  This is coming from populate_maildir_list() in
> > builtin/mailsplit.c; the function claims to know what "maildir"
> > should look like, so it should be enforcing the ordering as
> > necessary by sorting the list, _if_ the implicit ordering given by
> > string_list_insert() is insufficient.
> [...]
> 
> I think it is a property of the maildir format that it does not
> technically define the message order. The order of items you get from
> readdir is filesystem specific and not necessarily defined (and that is
> what we use now). On my ext4 system, I do not even get them in backwards
> order; it is jumbled.

Hmph, sorry, I mistook string_list_insert for string_list_append. So we
do actually sort them by filename, not just random readdir order. But
due to this:

> The maildir spec explicitly says that readers should not make
> assumptions about the content of the filenames. Mutt happens to write
> them as:
> 
>   ${epoch_seconds}.${pid}_${seq}.${host}
> 
> so in practice, sorting them kind of works. Except that a series written
> out at once will all have the same timestamp and pid, and because ${seq}
> is not zero-padded, you have to actually parse up to there and do a
> numeric instead of byte-wise comparison.  So we can add a mutt-specific
> hack, but that's the best we can do. Other maildir writers (including
> future versions of mutt) will not necessarily do the same thing.

That ordering is not necessarily useful.

So one strategy could be to try harder to sort numeric elements
numerically. That is, to treat:

  1234.5678_90.foo

as the list

  {1234, '.', 5678, '_', 90, "foo"}

for the purposes of sorting (even though we do not necessarily know what
each piece means). That works for mutt and similar schemes (dovecot, for
example, does something like "M${seq}P${pid}"), but some systems may put
random bytes in the middle (the point of it is to create a unique name).

So it is somewhat against the maildir spec, but I think in practice it
would help.

-Peff
