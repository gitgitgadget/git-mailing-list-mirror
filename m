From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 12/13] credentials: add "store" helper
Date: Tue, 29 Nov 2011 10:19:06 -0800
Message-ID: <7vsjl6ssf9.fsf@alter.siamese.dyndns.org>
References: <20111124105801.GA6168@sigill.intra.peff.net>
 <20111124110756.GJ8417@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Tue Nov 29 19:19:17 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RVSGy-0004wD-8K
	for gcvg-git-2@lo.gmane.org; Tue, 29 Nov 2011 19:19:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756100Ab1K2STK (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 29 Nov 2011 13:19:10 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36823 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754966Ab1K2STJ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 29 Nov 2011 13:19:09 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F3B7D68A6;
	Tue, 29 Nov 2011 13:19:08 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=5Yayy/W7rhQ6SGC30NuVqSbh7EE=; b=FObHz6jszb8pDXagvbuF
	3TNJ1V19Dv7cAUmSajmkhYy9Vw8DSE7h+BDnIXpZzhHK4mJkJajuaNiZrFgdBhC7
	pU8Dk2Bek/8dv3LEnyE4CeZDzycQXwyYCFpv3jW6rvaSIfaf0JBVRThL+pJFFhWD
	BT+5jHq3JKWR5l9A1VPsHVI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=WTg5lkn1q2lwlBUEY7tbLKVfM+TURG7PmeYx3KA4rkGmao
	pJuLgzaGe9RrClUWy6IfJPspgv3tgU7V6n90R56YjD99+0rNsagL4opgCKKu6P5h
	4V9yDAjopysaE2kU5HQpAhrIBZZjbLaMFBT2ydPitS5wMGcGjzNGCCUT5qGf4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EC2AC689B;
	Tue, 29 Nov 2011 13:19:08 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 20A7A689A; Tue, 29 Nov 2011
 13:19:08 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A0C4A62C-1AB6-11E1-B1E1-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/186070>

Jeff King <peff@peff.net> writes:

> +static void parse_credential_file(const char *fn,
> +				  struct credential *c,
> +				  void (*match_cb)(struct credential *),
> +				  void (*other_cb)(struct strbuf *))
> +{
> +	FILE *fh;
> +	struct strbuf line = STRBUF_INIT;
> +	struct credential entry = CREDENTIAL_INIT;
> +
> +	fh = fopen(fn, "r");
> +	if (!fh) {
> +		if (errno != ENOENT)
> +			die_errno("unable to open %s", fn);
> +		return;
> +	}
> +
> +	while (strbuf_getline(&line, fh, '\n') != EOF) {
> +		credential_from_url(&entry, line.buf);
> +		if (entry.username && entry.password &&
> +		    credential_match(c, &entry)) {

This looks curious; isn't checking .username and .password part of the
responsibility of credential_match()? And even if entry lacks password
(which won't happen in the context of this program, given the
implementation of store_credential() below) shouldn't it still be
considered a match?

> +			if (match_cb) {
> +				match_cb(&entry);
> +				break;

Multiple matches not allowed, which sounds fine.

> +			}
> +		}
> +		else if (other_cb)
> +			other_cb(&line);
> +	}
> +
> +	credential_clear(&entry);
> +	strbuf_release(&line);
> +	fclose(fh);
> +}
> +
> +static void print_entry(struct credential *c)
> +{
> +	printf("username=%s\n", c->username);
> +	printf("password=%s\n", c->password);
> +}
> +
> +static void print_line(struct strbuf *buf)
> +{
> +	strbuf_addch(buf, '\n');
> +	write_or_die(credential_lock.fd, buf->buf, buf->len);
> +}
> +
> +static void rewrite_credential_file(const char *fn, struct credential *c,
> +				    struct strbuf *extra)
> +{
> +	umask(077);

Curious placement of umask(). I would expect a function that has its own
call to umask() restore it before it returns, and a stand-alone program
whose sole purpose is to work with a private file, setting a tight umask
upfront at the beginning of main() may be easier to understand.

> +	if (hold_lock_file_for_update(&credential_lock, fn, 0) < 0)
> +		die_errno("unable to get credential storage lock");
> +	parse_credential_file(fn, c, NULL, print_line);
> +	if (extra)
> +		print_line(extra);

An entry for a newly updated password comes at the end of the file,
instead of replacing an entry already in the file in-place? Given that
parse_credential_file() when processing a look-up request (which is the
majority of the case) stops upon finding a match, it might make more sense
to have the new one (which may be expected to be used often) at the
beginning instead, no?

> +	if (commit_lock_file(&credential_lock) < 0)
> +		die_errno("unable to commit credential store");
> +}
> +
> +static void store_credential(const char *fn, struct credential *c)
> +{
> +	struct strbuf buf = STRBUF_INIT;
> +
> +	if (!c->protocol || !(c->host || c->path) ||
> +	    !c->username || !c->password)
> +		return;
> +
> +	strbuf_addf(&buf, "%s://", c->protocol);
> +	strbuf_addstr_urlencode(&buf, c->username, 1);
> +	strbuf_addch(&buf, ':');
> +	strbuf_addstr_urlencode(&buf, c->password, 1);
> +	strbuf_addch(&buf, '@');
> +	if (c->host)
> +		strbuf_addstr_urlencode(&buf, c->host, 1);
> +	if (c->path) {
> +		strbuf_addch(&buf, '/');
> +		strbuf_addstr_urlencode(&buf, c->path, 0);
> +	}
> +
> +	rewrite_credential_file(fn, c, &buf);
> +	strbuf_release(&buf);
> +}
> +
> +static void remove_credential(const char *fn, struct credential *c)
> +{
> +	if (!c->protocol || !(c->host || c->path))
> +		return;

The choice of the fields looks rather arbitrary. I cannot say "remove all
the credentials whose username is 'gitster' at 'github.com' no matter what
protocol is used", but I can say "remove all credentials under any name
for any host as long as the transfer goes over 'https' and accesses a
repository at 'if/xyzzy' path", it seems.

This filtering matches what lookup_credential() does but shouldn't it be
implemented at a single place in any case?

> +	rewrite_credential_file(fn, c, NULL);
> +}
> +
> +static int lookup_credential(const char *fn, struct credential *c)
> +{
> +	if (!c->protocol || !(c->host || c->path))
> +		return 0;
> +	parse_credential_file(fn, c, print_entry, NULL);
> +	return c->username && c->password;
> +}
