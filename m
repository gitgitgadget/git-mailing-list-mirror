From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] renaming quote_path() as quote_path_relative()
Date: Thu, 06 Mar 2008 17:41:54 -0800
Message-ID: <7vve3z5mzh.fsf@gitster.siamese.dyndns.org>
References: <7vr6en8n7k.fsf@gitster.siamese.dyndns.org>
 <1204852397-20939-1-git-send-email-dpotapov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Pierre Habouzit <madcoder@debian.org>, Git ML <git@vger.kernel.org>
To: Dmitry Potapov <dpotapov@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 07 02:42:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JXRbi-0007GA-BA
	for gcvg-git-2@gmane.org; Fri, 07 Mar 2008 02:42:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751908AbYCGBmI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Mar 2008 20:42:08 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751941AbYCGBmG
	(ORCPT <rfc822;git-outgoing>); Thu, 6 Mar 2008 20:42:06 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:53987 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751670AbYCGBmF (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Mar 2008 20:42:05 -0500
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CDDB73F7F;
	Thu,  6 Mar 2008 20:42:03 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id EC2793F7E; Thu,  6 Mar 2008 20:41:56 -0500 (EST)
In-Reply-To: <1204852397-20939-1-git-send-email-dpotapov@gmail.com> (Dmitry
 Potapov's message of "Fri, 7 Mar 2008 04:13:16 +0300")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/76447>

Dmitry Potapov <dpotapov@gmail.com> writes:

> Based on Junio's suggestion, this patch moves quote_path() from
> wt-status.c to quote.c and renames it as quote_path_relative(),
> because it is a better name for a public function.
>
> Also, instead of handcrafted quoting, quote_c_style_counted() is now
> used, so it will honor core.quotepath specified in configuration.

Thanks.
> +	strbuf_grow(out, len);
> +	strbuf_setlen(out, 0);
> +	if (prefix) {
> +		int off = 0;
> +		while (prefix[off] && off < len && prefix[off] == in[off])
> +			if (prefix[off] == '/') {
> +				prefix += off + 1;
> +				in += off + 1;
> +				len -= off + 1;
> +				off = 0;
> +			} else
> +				off++;
> +
> +		for (; *prefix; prefix++)
> +			if (*prefix == '/')
> +				strbuf_addstr(out, "../");
> +	}
> +
> +	quote_c_style_counted (in, len, out, NULL, 1);

Hmmm.  Shouldn't the whole path (including the ../ part you add) be
surrounded by a pair of dq iff quote_c_style() finds that the path needs
to be quoted?

I am reasonably sure that the scripted version of git-status (before
wt-status part was rewritten in C) acted that way.

	$ git --version
	git version 1.2.0
	$ echo frotz >qf\\w\"fq
	$ ls
	./  ../  .git/	qf\w"fq
	$ git add qf*q
	$ git status
	#
	# Initial commit
	#
	#
	# Updated but not checked in:
	#   (will commit)
	#
	#	new file: "qf\\w\"fq"
	#
