From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [bug report] git-am applying maildir patches in reverse
Date: Fri, 01 Mar 2013 15:57:39 -0800
Message-ID: <7v621aekr0.fsf@alter.siamese.dyndns.org>
References: <20130301222018.GA839@WST420>
 <7vwqtqeox7.fsf@alter.siamese.dyndns.org>
 <20130301225231.GB862@sigill.intra.peff.net>
 <20130301230508.GC862@sigill.intra.peff.net>
 <7vlia6em9x.fsf@alter.siamese.dyndns.org>
 <20130301233548.GA13422@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: William Giokas <1007380@gmail.com>, git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Sat Mar 02 00:58:09 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UBZq4-0008Te-9J
	for gcvg-git-2@plane.gmane.org; Sat, 02 Mar 2013 00:58:08 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752464Ab3CAX5n (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 1 Mar 2013 18:57:43 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:52981 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751962Ab3CAX5l (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 1 Mar 2013 18:57:41 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 6E1FFA8EA;
	Fri,  1 Mar 2013 18:57:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Kzc3LAY5x1EZ8vVB+0sBAXF/6ks=; b=soDrpy
	vyIgDeJqVvvbAxaRJEe4CbBnuz+NgVATB4XIJVgtp11GncGeZXtGTSMJu4rPciS5
	Z9sRtWTbNr8KGwya93hQWS7c7vNWY9liAlfszVwaEgVPXhtSmd2ng4+YAkokOgxs
	NHK6SHVUOUb+YVth/NRXewYpahZwTybiyzFFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rXU2p4WduNKF/vqgOpWBTVZci3osvb2Y
	mEjdOBFHO1sgu+t9ikE7eQ5JbCBXe0LIBK4cskLspvBUspogNQiuqMg+sn6+aeC0
	412FC4XOE9YQz6VpMPGp3IJtotjpzk3OfNA5CBqVWKQeZ/FAodscpInOqQG/+Elf
	bOLC5TK4wOo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 62F12A8E9;
	Fri,  1 Mar 2013 18:57:41 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9EC62A8E6; Fri,  1 Mar 2013
 18:57:40 -0500 (EST)
In-Reply-To: <20130301233548.GA13422@sigill.intra.peff.net> (Jeff King's
 message of "Fri, 1 Mar 2013 18:35:48 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: CD29D934-82CB-11E2-B28E-7FA22E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217310>

Jeff King <peff@peff.net> writes:

> On Fri, Mar 01, 2013 at 03:24:42PM -0800, Junio C Hamano wrote:
>
>> Jeff King <peff@peff.net> writes:
>> 
>> > On Fri, Mar 01, 2013 at 05:52:31PM -0500, Jeff King wrote:
>> > ...
>> >> The maildir spec explicitly says that readers should not make
>> >> assumptions about the content of the filenames. Mutt happens to write
>> >> them as:
>> >> 
>> >>   ${epoch_seconds}.${pid}_${seq}.${host}
>> >> 
>> >> so in practice, sorting them kind of works. Except that ...
>> >> << it does not work >> ...
>> > That ordering is not necessarily useful.
>> > ...
>> > So it is somewhat against the maildir spec, but I think in practice it
>> > would help.
>> 
>> I do not think it would help, unless these epoch_seconds are the
>> sender timestamps.  And the number of digits in epoch-seconds for
>> recent messages would be the same, so ordering textually would be
>> sufficient if ordering by timestamp were.
>
> The epoch_seconds are the time of writing into the maildir. They will
> typically all be the same, unless your system is very slow, or you are
> writing a really long patch series. The PID likewise should be the same
> for a given series. It's the sequence number that is the interesting bit
> to sort numerically (for mutt, anyway; ditto for dovecot).

OK, so as long as the user tells mutt what order the messages need
to be written in when choosing these 16 patches, tiebreaking with
the sequence number would be sufficient.

Is it easy to tell that to mutt, though, given that the patches
arrive in random order, not in the order they were sent?  I would
imagine that you sort the messages in your inbox, select a group of
messages and tell mutt to write them out to a (new) empty maildir,
and at that point mutt writes them out in the order you used to sort
them---is that how it is supposed to work?

Or are you assuming that the user chooses 1/16, tells mutt to write
it out, chooses 2/16, tells mut to write that out, iterating it 16
times to write out a 16-patch series?

I can see why your patch would _not_ hurt, but I cannot tell how
much it would help without knowing that part of the detail.

> -- >8 --
> Subject: [PATCH] mailsplit: sort maildir filenames more cleverly
>
> A maildir does not technically record the order in which
> items were placed into it. That means that when applying a
> patch series from a maildir, we may get the patches in the
> wrong order. We try to work around this by sorting the
> filenames. Unfortunately, this may or may not work depending
> on the naming scheme used by the writer of the maildir.
>
> For instance, mutt will write:
>
>   ${epoch_seconds}.${pid}_${seq}.${host}
>
> where we have:
>
>   - epoch_seconds: timestamp at which entry was written
>   - pid: PID of writing process
>   - seq: a sequence number to ensure uniqueness of filenames
>   - host: hostname
>
> None of the numbers are zero-padded. Therefore, when we sort
> the names as byte strings, entries that cross a digit
> boundary (e.g., 10) will sort out of order.  In the case of
> timestamps, it almost never matters (because we do not cross
> a digit boundary in the epoch time very often these days).
> But for the sequence number, a 10-patch series would be
> ordered as 1, 10, 2, 3, etc.
>
> To fix this, we can use a custom sort comparison function
> which traverses each string, comparing chunks of digits
> numerically, and otherwise doing a byte-for-byte comparison.
> That would sort:
>
>   123.456_1.bar
>   123.456_2.bar
>   ...
>   123.456_10.bar
>
> according to the sequence number. Since maildir does not
> define a filename format, this is really just a heuristic.
> But it happens to work for mutt, and there is a reasonable
> chance that it will work for other writers, too (at least as
> well as a straight sort).
>
> Signed-off-by: Jeff King <peff@peff.net>
> ---
>  builtin/mailsplit.c | 22 ++++++++++++++++++++++
>  1 file changed, 22 insertions(+)
>
> diff --git a/builtin/mailsplit.c b/builtin/mailsplit.c
> index 2d43278..772c668 100644
> --- a/builtin/mailsplit.c
> +++ b/builtin/mailsplit.c
> @@ -130,6 +130,26 @@ static int populate_maildir_list(struct string_list *list, const char *path)
>  	return 0;
>  }
>  
> +static int maildir_filename_cmp(const char *a, const char *b)
> +{
> +	while (1) {
> +		if (isdigit(*a) && isdigit(*b)) {
> +			long int na, nb;
> +			na = strtol(a, (char **)&a, 10);
> +			nb = strtol(b, (char **)&b, 10);
> +			if (na != nb)
> +				return na - nb;
> +			/* strtol advanced our pointers */
> +		}
> +		else {
> +			if (*a != *b)
> +				return *a - *b;
> +			a++;
> +			b++;
> +		}
> +	}
> +}
> +
>  static int split_maildir(const char *maildir, const char *dir,
>  	int nr_prec, int skip)
>  {
> @@ -139,6 +159,8 @@ static int split_maildir(const char *maildir, const char *dir,
>  	int i;
>  	struct string_list list = STRING_LIST_INIT_DUP;
>  
> +	list.cmp = maildir_filename_cmp;
> +
>  	if (populate_maildir_list(&list, maildir) < 0)
>  		goto out;
