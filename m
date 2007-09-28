From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/2] fetch/push: readd rsync support
Date: Fri, 28 Sep 2007 14:20:44 -0700
Message-ID: <7vtzpeo5ar.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
	<Pine.LNX.4.64.0709281629270.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Daniel Barkalow <barkalow@iabervon.org>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 23:21:13 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbNGo-0008M3-GL
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 23:21:10 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754097AbXI1VUr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 17:20:47 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753893AbXI1VUq
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 17:20:46 -0400
Received: from fed1rmmtao101.cox.net ([68.230.241.45]:52695 "EHLO
	fed1rmmtao101.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753695AbXI1VUq (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 17:20:46 -0400
Received: from fed1rmimpo01.cox.net ([70.169.32.71])
          by fed1rmmtao101.cox.net
          (InterMail vM.7.08.02.01 201-2186-121-102-20070209) with ESMTP
          id <20070928212045.ONLS13309.fed1rmmtao101.cox.net@fed1rmimpo01.cox.net>;
          Fri, 28 Sep 2007 17:20:45 -0400
Received: from localhost ([68.225.240.77])
	by fed1rmimpo01.cox.net with bizsmtp
	id txLk1X00X1gtr5g0000000; Fri, 28 Sep 2007 17:20:44 -0400
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59420>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> diff --git a/transport.c b/transport.c
> index 4f9cddc..c8eed95 100644
> --- a/transport.c
> +++ b/transport.c
> @@ -6,6 +6,330 @@
> ...
> +static int direntry_cmp(const void *a, const void *b)
> +{
> +	const struct dirent *d1 = a;
> +	const struct dirent *d2 = b;
> +
> +	return strcmp(d1->d_name, d2->d_name);
> +}
> ...
> +/*
> + * path is assumed to point to a buffer of PATH_MAX bytes, and
> + * path + name_offset is expected to point to "refs/".
> + */
> +
> +static int read_loose_refs(struct strbuf *path, int name_offset,
> +		struct ref **tail)
> +{
> +	DIR *dir = opendir(path->buf);
> +	struct dirent *de;
> +	struct {
> +		char **entries;
> +		int nr, alloc;
> +	} list;
> ...
> +	while ((de = readdir(dir))) {
> +		if (de->d_name[0] == '.' && (de->d_name[1] == '\0' ||
> +				(de->d_name[1] == '.' &&
> +				 de->d_name[2] == '\0')))
> +			continue;
> +		ALLOC_GROW(list.entries, list.nr + 1, list.alloc);
> +		list.entries[list.nr++] = xstrdup(de->d_name);
> +	}
> +	closedir(dir);
> +
> +	/* sort the list */
> +
> +	qsort(list.entries, list.nr, sizeof(*de), direntry_cmp);

Hmmmph...?
