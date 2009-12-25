From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH 1/2] Report exec errors from run-command
Date: Thu, 24 Dec 2009 23:35:04 -0800
Message-ID: <7vr5qjecbb.fsf@alter.siamese.dyndns.org>
References: <1261676971-3285-1-git-send-email-ilari.liusvaara@elisanet.fi>
 <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Ilari Liusvaara <ilari.liusvaara@elisanet.fi>
X-From: git-owner@vger.kernel.org Fri Dec 25 08:37:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NO4kH-0004AY-G2
	for gcvg-git-2@lo.gmane.org; Fri, 25 Dec 2009 08:37:57 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752074AbZLYHfP (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Dec 2009 02:35:15 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752009AbZLYHfP
	(ORCPT <rfc822;git-outgoing>); Fri, 25 Dec 2009 02:35:15 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:46036 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbZLYHfO (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Dec 2009 02:35:14 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2B73AA9DE1;
	Fri, 25 Dec 2009 02:35:11 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Q4rA23Khed67AHJWieUyeO2j6tY=; b=PzlYGg
	XnLuyDSVkC4ciqdn0+dHt5xhRoI46z259feeh6wTDbc8Gwuwo2xmX32WCFEyVCcC
	w2S6sutbHnizZTMNkrbdyRWWS9T4ADHkGF6oFMUQI2cd7X1EsCwPM6bLMWa1bSSj
	5pCPALx8iDnUaYPjnXW6cJPLpqAjmloTPQlRA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=GAXFCwpBxMSD0/qTfgH9CsbbgkFoHPrZ
	MkUZoA2m40xmh7AZbwEaPDZCJSRFxwpU+pZTmXNbUS0N11H1n982OK23zv86Juk5
	SMWKnVr+puLG1HEtWHeVw1Y1F1Nlf76z+VXZ7ObgNo7f/NXbBrTtLXfcZgGc7Qz8
	FbJIFpBqwUA=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0987EA9DE0;
	Fri, 25 Dec 2009 02:35:09 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1ABEDA9DDF; Fri, 25 Dec 2009
 02:35:05 -0500 (EST)
In-Reply-To: <1261676971-3285-2-git-send-email-ilari.liusvaara@elisanet.fi>
 (Ilari Liusvaara's message of "Thu\, 24 Dec 2009 19\:49\:30 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 073B2AF8-F128-11DE-9F0C-465EBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/135665>

Ilari Liusvaara <ilari.liusvaara@elisanet.fi> writes:

> Previously run-command was unable to report errors happening in exec
> call. Change it to pass errno from failed exec to errno value at
> return.
>
> The errno value passing can be done by opening close-on-exec pipe and
> piping the error code through in case of failure. In case of success,
> close-on-exec closes the pipe on successful exec and parent process
> gets end of file on read.

Thanks; I think overall this is a good idea, even though I have no clue
if WIN32 side wants a similar support.

 - At first reading, the "while (close(fd) < 0 && errno != EBADF);"
   pattern was a bit of eyesore.  It might be worth factoring that out to
   a small static helper function that a smart compiler would
   automatically inline (or mark it as a static inline).

 - Is it guaranteed that a failed pipe(2) never touches its int fildes[2]
   parameter, or the values are undefined when it fails?  The approach
   would save one extra variable, compared to an alternative approach to
   keep an explicit variable to record a pipe failure, but It feels iffy
   that the code relies on them being left as their initial -1 values.

 - Should we worry about partial write as well (you seem to warn when you
   get a partial read)?  Is it worth using xread() and friends found in
   wrapper.c instead of goto read/write_again?

 - Shouldn't any of these warning() be die() instead?

 - The two extra file descriptors this patch uses are allocated after all
   the existing pipe flipping is done, and all the dup's done in the child
   process are to use dup2() to set up the known file descriptors at low
   numbers, so I don't think we have to worry about this patch changing
   the behaviour of the process pair by changing the assignment of file
   descriptors (we had a bug or two in the past that made subprocess
   misbehave under some funky condition, e.g. run with fd#0 closed).
