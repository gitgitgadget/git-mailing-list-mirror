From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] Introduce remove_dir_recursively()
Date: Fri, 28 Sep 2007 02:05:17 -0700
Message-ID: <7v8x6rqhwy.fsf@gitster.siamese.dyndns.org>
References: <Pine.LNX.4.64.0709280602580.28395@racer.site>
	<Pine.LNX.4.64.0709280606350.28395@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: gitster@pobox.com, Daniel Barkalow <barkalow@iabervon.org>,
	git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Fri Sep 28 11:05:59 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1IbBmx-000390-0n
	for gcvg-git-2@gmane.org; Fri, 28 Sep 2007 11:05:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754485AbXI1JF2 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Sep 2007 05:05:28 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753630AbXI1JF2
	(ORCPT <rfc822;git-outgoing>); Fri, 28 Sep 2007 05:05:28 -0400
Received: from rune.pobox.com ([208.210.124.79]:50534 "EHLO rune.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753179AbXI1JF1 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Sep 2007 05:05:27 -0400
Received: from rune (localhost [127.0.0.1])
	by rune.pobox.com (Postfix) with ESMTP id 71D2813D707;
	Fri, 28 Sep 2007 05:05:48 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by rune.sasl.smtp.pobox.com (Postfix) with ESMTP id 9397B13D3DE;
	Fri, 28 Sep 2007 05:05:41 -0400 (EDT)
In-Reply-To: <Pine.LNX.4.64.0709280606350.28395@racer.site> (Johannes
	Schindelin's message of "Fri, 28 Sep 2007 06:06:44 +0100 (BST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/59378>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> +int remove_dir_recursively(char *path, int len, int only_empty)
> +{
> ...
> +		namlen = strlen(e->d_name);
> +		if (len + namlen > PATH_MAX ||
> +				!memcpy(path + len, e->d_name, namlen) ||
> +				(path[len + namlen] = '\0') ||
> +				lstat(path, &st))
> +			; /* fall thru */
> +		else if (S_ISDIR(st.st_mode)) {
> +			if (!remove_dir_recursively(path, len + namlen,
> +						only_empty))
> +				continue; /* happy */
> +		} else if (!only_empty &&
> +				len + namlen + 1 < PATH_MAX &&
> +				!unlink(path))
> +			continue; /* happy, too */
> +
> +		/* path too long, stat fails, or non-directory still exists */
> +		ret = -1;
> +		break;

Is it only me who finds the first if () condition way too
convoluted and needs to read three times to convince oneself
that it is doing a sane thing?

Please, especially...

 * For $DEITY's sake, memcpy() returns pointer to dst which you
   know is not NULL. so !memcpy() is always false here, which
   might be _convenient_ for you and the compiler but not for
   a human reader of the code who needs to blink twice wondering
   if you meant !memcmp().

 * Same for (path[] = '\0'), wondering if it is misspelled
   (path[] == '\0').
