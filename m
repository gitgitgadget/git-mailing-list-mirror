From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 17:52:31 -0500
Message-ID: <20130301225231.GB862@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Mar 01 23:53:02 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBYp1-0006G3-92
	for gcvg-git-2@plane.gmane.org; Fri, 01 Mar 2013 23:52:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751371Ab3CAWwe (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 17:52:34 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39581 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751140Ab3CAWwd (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 17:52:33 -0500
Received: (qmail 4727 invoked by uid 107); 1 Mar 2013 22:54:09 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 17:54:09 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 17:52:31 -0500
Content-Disposition: inline
In-Reply-To: <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217301>

On Fri, Mar 01, 2013 at 02:27:32PM -0800, Junio C Hamano wrote:

> > I've been using git for a while and this is the first time I've had to
> > use `git am` and I've got a 16 patch patchset that I'm looking to apply.
> > The files were copied to a separate maildir by mutt to keep things
> > clean, and then I ran `git am -i /path/to/maildir/` expecting things to
> > start from the patch with the subject 
> >
> >     [PATCH 01/16] refactor common code in query_search/sync_search
> >
> > But instead, it starts with the 16/16 patch and works backwards, which,
> > obviously, breaks the application process as the patches depend on each
>
> Note to bystanders.  This is coming from populate_maildir_list() in
> builtin/mailsplit.c; the function claims to know what "maildir"
> should look like, so it should be enforcing the ordering as
> necessary by sorting the list, _if_ the implicit ordering given by
> string_list_insert() is insufficient.
> 
> It also is likely that it is a user error to expect that patch
> e-mails are received and stored in the maildir in the order they
> were sent, or it could be "mutt" copying the mails in the order the
> messages were originally received, or something silly like that.

I think it is a property of the maildir format that it does not
technically define the message order. The order of items you get from
readdir is filesystem specific and not necessarily defined (and that is
what we use now). On my ext4 system, I do not even get them in backwards
order; it is jumbled.

We could sort based on the mtime of the file, but in some cases that
won't have sufficient resolution (e.g., with one second resolution,
they'll all probably have the same timestamp).

The maildir spec explicitly says that readers should not make
assumptions about the content of the filenames. Mutt happens to write
them as:

  ${epoch_seconds}.${pid}_${seq}.${host}

so in practice, sorting them kind of works. Except that a series written
out at once will all have the same timestamp and pid, and because ${seq}
is not zero-padded, you have to actually parse up to there and do a
numeric instead of byte-wise comparison.  So we can add a mutt-specific
hack, but that's the best we can do. Other maildir writers (including
future versions of mutt) will not necessarily do the same thing.

I think maildir's philosophy is that ordering is not important, and the
contents of the messages themselves should define the order in which a
MUA presents them, anyway. It would make sense to me if we actually
parsed the '[PATCH n/m]' bit from the subject of each and sorted based
on that. That is blurring the line between git-mailsplit and
git-mailinfo, in that mailsplit would have to start parsing the files.

We could also sort based on the rfc822 "Date" header, but I don't think
that is a good idea. It represents the author timestamp, so patches
moved via "rebase -i" will have out-of-sequence dates with respect to
the actual history graph.  You can encounter this if you "format-patch
--stdout" a series into a single mbox and load it into a MUA that sorts
by date (like mutt). The patches appear jumbled until you switch to
"unsorted" or "sort by subject".

-Peff
