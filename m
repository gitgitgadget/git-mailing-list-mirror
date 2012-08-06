From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH/RFC v2 09/16] Read index-v5
Date: Sun, 05 Aug 2012 22:17:22 -0700
Message-ID: <7v4nog1twd.fsf@alter.siamese.dyndns.org>
References: <1344203353-2819-1-git-send-email-t.gummerer@gmail.com>
 <1344203353-2819-10-git-send-email-t.gummerer@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, trast@student.ethz.ch, mhagger@alum.mit.edu,
	pcouds@gmail.com, robin.rosenberg@dewire.com
To: Thomas Gummerer <t.gummerer@gmail.com>
X-From: git-owner@vger.kernel.org Mon Aug 06 07:17:32 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SyFh5-0006TX-Is
	for gcvg-git-2@plane.gmane.org; Mon, 06 Aug 2012 07:17:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751629Ab2HFFR0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 6 Aug 2012 01:17:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43240 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751111Ab2HFFRZ (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 6 Aug 2012 01:17:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D47389CDB;
	Mon,  6 Aug 2012 01:17:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=CyZOAgxKRrwyKl1NsxKJqCeZPGQ=; b=nc+vQM
	3bD8U9HVIMTS1RbV7wfdPYyEKduCC/JhfWI2PEUvgxEggiy5HIY96vr5eVuY/d+f
	a5lR6LwnrWxrLsVmXHmAhS8bbUU1ifQaY0jXYpFQyuSMBuVpM6YWDGhSic6rSfIz
	09KFNsXDNSJDamqzVLQL0tpYx8qsYi5ew0f/g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=yNekf33SVnRJL3gf3aUbHh7bNEIbquh4
	d9QtdP45MSFYZnkY8oQ56ISmdM+9tQwEWXO+mZtOYAT9hEzBmSEQpkpePSLQ/VSc
	ok4gGZinVZWi44RfZYsF5T5/6RtXUgc+1PX4vQvPueBruVfMNGM5tBnhQRCU8mN3
	L4qHoUieIrE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B75AB9CD9;
	Mon,  6 Aug 2012 01:17:24 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 27DD29CD7; Mon,  6 Aug 2012
 01:17:24 -0400 (EDT)
In-Reply-To: <1344203353-2819-10-git-send-email-t.gummerer@gmail.com> (Thomas
 Gummerer's message of "Sun, 5 Aug 2012 23:49:06 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 018A4F36-DF86-11E1-BC15-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/202957>

Thomas Gummerer <t.gummerer@gmail.com> writes:

> +static struct directory_entry *read_directories_v5(unsigned int *dir_offset,
> +				unsigned int *dir_table_offset,
> +				void *mmap,
> +				int mmap_size)
> +{
> +	int i, ondisk_directory_size;
> +	uint32_t *filecrc, *beginning, *end;
> +	struct directory_entry *current = NULL;
> +	struct ondisk_directory_entry *disk_de;
> +	struct directory_entry *de;
> +	unsigned int data_len, len;
> +	char *name;
> +
> +	ondisk_directory_size = sizeof(disk_de->flags)
> +		+ sizeof(disk_de->foffset)
> +		+ sizeof(disk_de->cr)
> +		+ sizeof(disk_de->ncr)
> +		+ sizeof(disk_de->nsubtrees)
> +		+ sizeof(disk_de->nfiles)
> +		+ sizeof(disk_de->nentries)
> +		+ sizeof(disk_de->sha1);
> +	name = (char *)mmap + *dir_offset;
> +	beginning = mmap + *dir_table_offset;

Notice how you computed name with pointer arithmetic by first
casting mmap (which is "void *") and when computing beginning, you
forgot to cast mmap and attempted pointer arithmetic with "void *".
The latter does not work and breaks compilation.

The pointer-arith with "void *" is not limited to this function.

Please check the a band-aid (I wouldn't call it a fix-up) patch I
added on top of the series before queuing the topic to 'pu'; it is
primarily to illustrate the places I noticed that have this issue.

I do not necessarily suggest that the way the band-aid patch makes
it compile is the best approach.  It might be cleaner to use a saner
type like "char *" (or perhaps "const char *") as the type to point
at a piece of memory you read from the disk.  I haven't formed an
opinion.

Thanks.
