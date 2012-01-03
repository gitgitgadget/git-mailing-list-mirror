From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Work around sed portability issue in
 t8006-blame-textconv
Date: Tue, 03 Jan 2012 11:05:58 -0800
Message-ID: <7vd3b0vc6h.fsf@alter.siamese.dyndns.org>
References: <1325339068-6063-1-git-send-email-bwalton@artsci.utoronto.ca>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ben Walton <bwalton@artsci.utoronto.ca>
X-From: git-owner@vger.kernel.org Tue Jan 03 20:06:14 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ri9ga-0002ct-J2
	for gcvg-git-2@lo.gmane.org; Tue, 03 Jan 2012 20:06:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754724Ab2ACTGH (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jan 2012 14:06:07 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49140 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754680Ab2ACTGG (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jan 2012 14:06:06 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 86B827FEF;
	Tue,  3 Jan 2012 14:06:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=4gKLJ3fOYiMR50z5HLLnH30K/vQ=; b=eHsrKY
	y8aTV/Ol//MwF63iVXnW/bcM1EJwTU+5q2xTfgNL6Hq4/LezW4hmuj/HJ07mQqQ2
	jGAzrGMXqJUjGxvTniexO+F6wboxWGWZp2rU0M4+gdBOYsuiBuARTiYNBJgD5O68
	miT8+90vlvj/Mb3xr8sQS1ZXoPUDAedzcRElg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cbCiVGlJ2bdjyDIISoup8Lcbf2o5m+Bd
	w9l17jJ6n8big61TADhCwXNfJjqfHTxb2Z0KDtJp25ebAYt0nIoDgsdtS2eIvL1j
	HID9xiVA2s0NKX+IZZM5FqmvqoXCp3Lge5G3y+8HSklDlySX4bSawkpsgoq+OdOi
	wQ9POLoYDQs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 7DD357FEE;
	Tue,  3 Jan 2012 14:06:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0E6407FED; Tue,  3 Jan 2012
 14:06:04 -0500 (EST)
In-Reply-To: <1325339068-6063-1-git-send-email-bwalton@artsci.utoronto.ca>
 (Ben Walton's message of "Sat, 31 Dec 2011 08:44:28 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: FC3E9BF0-363D-11E1-98CB-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187874>

Ben Walton <bwalton@artsci.utoronto.ca> writes:

> In test 'blame --textconv with local changes' of t8006-blame-textconv,
> using /usr/xpg4/bin/sed on Solaris as set by SANE_TOOL_PATH, an
> additional newline was added to the output from the 'helper' script
> driven by git attributes.
>
> This was noted by sed with a message such as:
> sed: Missing newline at end of file zero.bin.
>
> In turn, this was triggering a fatal error from git blame:
> fatal: unable to read files to diff

Interesting. A file with incomplete line technically is not a text file
and sed is supposed to work on text files, so it is allowed to be picky.

> Use perl -p -e instead of sed -e to work around this portability issue
> as it will not insert the newline.

I am not sure if additional newline is the problem, or the exit status
from sed is, from your description. Your first paragraph says you will get
output from sed but with an extra newline, and then later you said blame
noticed an error in its attempt to read the contents. I am suspecting that
it checked the exit status from the textconv subprocess and noticed the
error and that is the cause of the issue, but could you clarify?  IOW, I
am suspecting that replacing "as it will not insert the newline" with "as
it does not error out on an incomplete line" is necessary in this
sentence.

Thanks.
