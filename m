From: Jeff King <peff@peff.net>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 1 Mar 2013 18:35:48 -0500
Message-ID: <20130301233548.GA13422@sigill.intra.peff.net>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:36:26 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZUz-0005Qi-RC
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:36:22 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751957Ab3CAXfw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:35:52 -0500
Received: from 75-15-5-89.uvs.iplsin.sbcglobal.net ([75.15.5.89]:39626 "EHLO
	peff.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751346Ab3CAXfv (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:35:51 -0500
Received: (qmail 5135 invoked by uid 107); 1 Mar 2013 23:37:26 -0000
Received: from sigill.intra.peff.net (HELO sigill.intra.peff.net) (10.0.0.7)
  (smtp-auth username relayok, mechanism cram-md5)
  by peff.net (qpsmtpd/0.84) with ESMTPA; Fri, 01 Mar 2013 18:37:26 -0500
Received: by sigill.intra.peff.net (sSMTP sendmail emulation); Fri, 01 Mar 2013 18:35:48 -0500
Content-Disposition: inline
In-Reply-To: <7vlia6em9x.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217308>

On Fri, Mar 01, 2013 at 03:24:42PM -0800, Junio C Hamano wrote:

> Jeff King <peff@peff.net> writes:
> 
> > On Fri, Mar 01, 2013 at 05:52:31PM -0500, Jeff King wrote:
> > ...
> >> The maildir spec explicitly says that readers should not make
> >> assumptions about the content of the filenames. Mutt happens to write
> >> them as:
> >> 
> >>   ${epoch_seconds}.${pid}_${seq}.${host}
> >> 
> >> so in practice, sorting them kind of works. Except that ...
> >> << it does not work >> ...
> > That ordering is not necessarily useful.
> > ...
> > So it is somewhat against the maildir spec, but I think in practice it
> > would help.
> 
> I do not think it would help, unless these epoch_seconds are the
> sender timestamps.  And the number of digits in epoch-seconds for
> recent messages would be the same, so ordering textually would be
> sufficient if ordering by timestamp were.

The epoch_seconds are the time of writing into the maildir. They will
typically all be the same, unless your system is very slow, or you are
writing a really long patch series. The PID likewise should be the same
for a given series. It's the sequence number that is the interesting bit
to sort numerically (for mutt, anyway; ditto for dovecot).

The patch below seems to fix the issue for me with mutt. It's possible
that it regresses another case (which has numbers, but really wants them
sorted as byte strings), but I find that unlikely. If you're
zero-padding your numbers this will still work, and if you're not, then
you likely have no meaningful sort order at all.

-- >8 --
Subject: [PATCH] mailsplit: sort maildir filenames more cleverly

A maildir does not technically record the order in which
items were placed into it. That means that when applying a
patch series from a maildir, we may get the patches in the
wrong order. We try to work around this by sorting the
filenames. Unfortunately, this may or may not work depending
on the naming scheme used by the writer of the maildir.

For instance, mutt will write:

  ${epoch_seconds}.${pid}_${seq}.${host}

where we have:

  - epoch_seconds: timestamp at which entry was written
  - pid: PID of writing process
  - seq: a sequence number to ensure uniqueness of filenames
  - host: hostname

None of the numbers are zero-padded. Therefore, when we sort
the names as byte strings, entries that cross a digit
boundary (e.g., 10) will sort out of order.  In the case of
timestamps, it almost never matters (because we do not cross
a digit boundary in the epoch time very often these days).
But for the sequence number, a 10-patch series would be
ordered as 1, 10, 2, 3, etc.

To fix this, we can use a custom sort comparison function
which traverses each string, comparing chunks of digits
numerically, and otherwise doing a byte-for-byte comparison.
That would sort:

  123.456_1.bar
  123.456_2.bar
  ...
  123.456_10.bar

according to the sequence number. Since maildir does not
define a filename format, this is really just a heuristic.
But it happens to work for mutt, and there is a reasonable
chance that it will work for other writers, too (at least as
well as a straight sort).

Signed-off-by: Jeff King <peff@peff.net>
---
 builtin/mailsplit.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
index 2d43278..772c668 100644
--- a/builtin/mailsplit.c
+++ b/builtin/mailsplit.c
@@ -130,6 +130,26 @@ static int populate_maildir_list(struct string_list *list, const char *path)
 	return 0;
 }
 
+static int maildir_filename_cmp(const char *a, const char *b)
+{
+	while (1) {
+		if (isdigit(*a) && isdigit(*b)) {
+			long int na, nb;
+			na = strtol(a, (char **)&a, 10);
+			nb = strtol(b, (char **)&b, 10);
+			if (na != nb)
+				return na - nb;
+			/* strtol advanced our pointers */
+		}
+		else {
+			if (*a != *b)
+				return *a - *b;
+			a++;
+			b++;
+		}
+	}
+}
+
 static int split_maildir(const char *maildir, const char *dir,
 	int nr_prec, int skip)
 {
@@ -139,6 +159,8 @@ static int split_maildir(const char *maildir, const char *dir,
 	int i;
 	struct string_list list = STRING_LIST_INIT_DUP;
 
+	list.cmp = maildir_filename_cmp;
+
 	if (populate_maildir_list(&list, maildir) < 0)
 		goto out;
 
-- 
1.8.1.39.gbb3bf60
