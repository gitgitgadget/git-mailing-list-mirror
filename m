From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 02:30:51 -0700
Message-ID: <7v3awzqgqc.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
	<Pine.LNX.4.64.0709280606530.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:31:18 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbCBm-0003Uz-Sm
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:31:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758460AbXI1JbE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:31:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757046AbXI1JbB
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:31:01 -0400
Received: from rune.pobox.com ([208.210.124.79]:53056 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1758368AbXI1JbA (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:31:00 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 6FFEC13C29E;
	Fri, 28 Sep 2007 05:31:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id A86FE13C06A;
	Fri, 28 Sep 2007 05:31:17 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709280606530.28395@racer.site> (Johannes
	Schindelin's message of "Fri, 28 Sep 2007 06:07:19 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59381>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +/*
> + * path is assumed to point to a buffer of PATH_MAX bytes, and
> + * path + name_offset is expected to point to "refs/".
> + */
> +
> +static int read_loose_refs(char *path, int name_offset, struct ref **tail)
> +{
> +	DIR *dir = opendir(path);
> +	struct dirent *de;
> +	struct {
> +		struct dirent *entries;
> +		int nr, alloc;
> +	} list;
> +	int i, pathlen;
> +
> +	if (!dir)
> +		return -1;
> +
> +	memset (&list, 0, sizeof(list));
> +
> +	while ((de = readdir(dir))) {
> +		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
> +				(de->d_name[1] == '.' &&
> +				 de->d_name[2] == '\0')))
> +			continue;
> +		if (list.nr >= list.alloc) {
> +			list.alloc = alloc_nr(list.nr);
> +			list.entries = xrealloc(list.entries,
> +				list.alloc * sizeof(*de));
> +		}

ALLOC_GROW() not applicable here?

> +		list.entries[list.nr++] = *de;

Are you sure about this?

The last paragraph in Rationale section, in

    http://www.opengroup.org/onlinepubs/000095399/basedefs/dirent.h.html

suggests that the d_name[] member in struct dirent could be
declared at the very end of the structure as length of 1 (the
traditional trick to implement a flex-array); your assignment
from *de into entries[] would not work as expected on such an
implementation.

On Linux with glibc it appears bits/dirent.h defines dirent with
"char d_name[256]", so you may not see a breakage there, though.

You only use a list of strings (char **), don't you?

> ...
> +			if (fd < 0)
> +				continue;
> +			next = alloc_ref(strlen(path + name_offset));

And as we discussed earlier you would need one more byte here ;-).
