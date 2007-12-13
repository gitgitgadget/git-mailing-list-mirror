From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/5] "diff --check" should affect exit status
Date: Thu, 13 Dec 2007 15:51:48 -0800
Message-ID: <7vir32ywyz.fsf@gitster.siamese.dyndns.org>
References: <1197552751-53480-1-git-send-email-win@wincent.com>
	<1197552751-53480-2-git-send-email-win@wincent.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Wincent Colaiuta <win@wincent.com>
X-From: git-owner@vger.kernel.org Fri Dec 14 00:52:35 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1J2xqv-0001QC-1P
	for gcvg-git-2@gmane.org; Fri, 14 Dec 2007 00:52:29 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755049AbXLMXwE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 13 Dec 2007 18:52:04 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755704AbXLMXwD
	(ORCPT <rfc822;git-outgoing>); Thu, 13 Dec 2007 18:52:03 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35056 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753017AbXLMXwB (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 13 Dec 2007 18:52:01 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2CE65859C;
	Thu, 13 Dec 2007 18:51:57 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 57BED8589;
	Thu, 13 Dec 2007 18:51:50 -0500 (EST)
In-Reply-To: <1197552751-53480-2-git-send-email-win@wincent.com> (Wincent
	Colaiuta's message of "Thu, 13 Dec 2007 14:32:27 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/68201>

Wincent Colaiuta <win@wincent.com> writes:

> @@ -2965,8 +2976,8 @@ void diff_flush(struct diff_options *options)
>  			     DIFF_FORMAT_CHECKDIFF)) {
>  		for (i = 0; i < q->nr; i++) {
>  			struct diff_filepair *p = q->queue[i];
> -			if (check_pair_status(p))
> -				flush_one_pair(p, options);
> +			if (check_pair_status(p) && flush_one_pair(p, options))
> +				DIFF_OPT_SET(options, CHECK_FAILED);
>  		}
>  		separator++;
>  	}

Isn't this wrong when check is not in effect?

I think highjacking the "did we encounter problems" return value of the
entire callchain for the purpose of checkdiff is very ugly and wrong to
begin with, so please do not argue "but if checkdiff is not in effect,
the caller does not check CHECK_FAILED".

Wouldn't it be much cleaner to make diff_flush_checkdiff(), or its
underlying function run_checkdiff(), set that CHECK_FAILED flag to
options structure, and return success?  The toplevel caller can decide
to exit with non-zero when --check is in effect and CHECK_FAILED flag is
set.
