From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/23] pack v4: initial pack dictionary structure and code
Date: Tue, 27 Aug 2013 08:08:08 -0700
Message-ID: <xmqqbo4jf9yf.fsf@gitster.dls.corp.google.com>
References: <1377577567-27655-1-git-send-email-nico@fluxnic.net>
	<1377577567-27655-2-git-send-email-nico@fluxnic.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Tue Aug 27 17:08:20 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VEKsU-0003Oi-Q7
	for gcvg-git-2@plane.gmane.org; Tue, 27 Aug 2013 17:08:19 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751905Ab3H0PIP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 27 Aug 2013 11:08:15 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48781 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751739Ab3H0PIO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 27 Aug 2013 11:08:14 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 266823C428;
	Tue, 27 Aug 2013 15:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=cQJsk7P8GQNRA3THllN0wYN59v8=; b=i3NQF4
	ugIG4mHi24SZe4JEaMl0czPVyUBDZU48UPY6QeBDboplot3UEvPit3gRujzC+1D6
	uB8zsB1vonn61k3Z2sDmbnYzARJU+BOzUkIHvBuZQchii5CTN2UyQu7Xeo5SBRuS
	t/Ej0+i8mck05dxTxGzExhgt+5oMFPbUXJTZ8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tK//azPzqgZuI2i/mjEVcidnsGzhPedO
	KY+2EZeiHobFSRETC8AtvVppr3A8VGL8iah/Qe5wMFw/nJCunO2ECupUkLFzUMBR
	gQAIWAGleJHFLfnyW+omZsHLaneZBl8K57lZT52Q2iDOs+KAZ0U2q+TdvTIjflGU
	EWhvNhCxpTA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DE36E3C427;
	Tue, 27 Aug 2013 15:08:12 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 9639E3C41E;
	Tue, 27 Aug 2013 15:08:10 +0000 (UTC)
In-Reply-To: <1377577567-27655-2-git-send-email-nico@fluxnic.net> (Nicolas
	Pitre's message of "Tue, 27 Aug 2013 00:25:45 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7CB37D02-0F2A-11E3-BB1F-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/233098>

Nicolas Pitre <nico@fluxnic.net> writes:

> Signed-off-by: Nicolas Pitre <nico@fluxnic.net>
> ---

Was there a reason not to reuse the hash-table Linus did in
hash.[ch]?

It may not make much of a difference for something so small and
isolated from the rest of the system, but if hash.[ch] can be easily
fixed with a small tweak to suit the use by this subsystem better,
it might be worth reusing the existing code with improvement, which
may help other potential users.

>  packv4-create.c | 137 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 137 insertions(+)
>  create mode 100644 packv4-create.c
>
> diff --git a/packv4-create.c b/packv4-create.c
> new file mode 100644
> index 0000000..2de6d41
> --- /dev/null
> +++ b/packv4-create.c
> @@ -0,0 +1,137 @@
> +/*
> + * packv4-create.c: management of dictionary tables used in pack v4
> + *
> + * (C) Nicolas Pitre <nico@fluxnic.net>
> + *
> + * This code is free software; you can redistribute it and/or modify
> + * it under the terms of the GNU General Public License version 2 as
> + * published by the Free Software Foundation.
> + */
> +
> +#include "cache.h"
> +
> +struct data_entry {
> +	unsigned offset;
> +	unsigned hits;
> +};
> +
> +struct dict_table {
> +	char *data;
> +	unsigned ptr;
> +	unsigned size;
> +	struct data_entry *entry;
> +	unsigned nb_entries;
> +	unsigned max_entries;
> +	unsigned *hash;
> +	unsigned hash_size;
> +};
> +
> +struct dict_table *create_dict_table(void)
> +{
> +	return xcalloc(sizeof(struct dict_table), 1);
> +}
> +
> +void destroy_dict_table(struct dict_table *t)
> +{
> +	free(t->data);
> +	free(t->entry);
> +	free(t->hash);
> +	free(t);
> +}
> +
> +static int locate_entry(struct dict_table *t, const char *str)
> +{
> +	int i = 0;
> +	const unsigned char *s = (const unsigned char *) str;
> +
> +	while (*s)
> +		i = i * 111 + *s++;
> +	i = (unsigned)i % t->hash_size;
> +
> +	while (t->hash[i]) {
> +		unsigned n = t->hash[i] - 1;
> +		if (!strcmp(str, t->data + t->entry[n].offset))
> +			return n;
> +		if (++i >= t->hash_size)
> +			i = 0;
> +	}
> +	return -1 - i;
> +}
> +
> +static void rehash_entries(struct dict_table *t)
> +{
> +	unsigned n;
> +
> +	t->hash_size *= 2;
> +	if (t->hash_size < 1024)
> +		t->hash_size = 1024;
> +	t->hash = xrealloc(t->hash, t->hash_size * sizeof(*t->hash));
> +	memset(t->hash, 0, t->hash_size * sizeof(*t->hash));
> +
> +	for (n = 0; n < t->nb_entries; n++) {
> +		int i = locate_entry(t, t->data + t->entry[n].offset);
> +		if (i < 0)
> +			t->hash[-1 - i] = n + 1;
> +	}
> +}
> +
> +int dict_add_entry(struct dict_table *t, const char *str)
> +{
> +	int i, len = strlen(str) + 1;
> +
> +	if (t->ptr + len >= t->size) {
> +		t->size = (t->size + len + 1024) * 3 / 2;
> +		t->data = xrealloc(t->data, t->size);
> +	}
> +	memcpy(t->data + t->ptr, str, len);
> +
> +	i = (t->nb_entries) ? locate_entry(t, t->data + t->ptr) : -1;
> +	if (i >= 0) {
> +		t->entry[i].hits++;
> +		return i;
> +	}
> +
> +	if (t->nb_entries >= t->max_entries) {
> +		t->max_entries = (t->max_entries + 1024) * 3 / 2;
> +		t->entry = xrealloc(t->entry, t->max_entries * sizeof(*t->entry));
> +	}
> +	t->entry[t->nb_entries].offset = t->ptr;
> +	t->entry[t->nb_entries].hits = 1;
> +	t->ptr += len + 1;
> +	t->nb_entries++;
> +
> +	if (t->hash_size * 3 <= t->nb_entries * 4)
> +		rehash_entries(t);
> +	else
> +		t->hash[-1 - i] = t->nb_entries;
> +
> +	return t->nb_entries - 1;
> +}
> +
> +static int cmp_dict_entries(const void *a_, const void *b_)
> +{
> +	const struct data_entry *a = a_;
> +	const struct data_entry *b = b_;
> +	int diff = b->hits - a->hits;
> +	if (!diff)
> +		diff = a->offset - b->offset;
> +	return diff;
> +}
> +
> +static void sort_dict_entries_by_hits(struct dict_table *t)
> +{
> +	qsort(t->entry, t->nb_entries, sizeof(*t->entry), cmp_dict_entries);
> +	t->hash_size = (t->nb_entries * 4 / 3) / 2;
> +	rehash_entries(t);
> +}
> +
> +void dict_dump(struct dict_table *t)
> +{
> +	int i;
> +
> +	sort_dict_entries_by_hits(t);
> +	for (i = 0; i < t->nb_entries; i++)
> +		printf("%d\t%s\n",
> +			t->entry[i].hits,
> +			t->data + t->entry[i].offset);
> +}
