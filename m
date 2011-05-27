From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv3 1/3] diff.c: omit hidden entries from namelen
 calculation with --stat
Date: Fri, 27 May 2011 15:45:50 -0700
Message-ID: <7v39jzsqxt.fsf@alter.siamese.dyndns.org>
References: <4DC0FD3D.9010004@drmicha.warpmail.net>
 <b47e2f0865bac1ad0e7b777ce9f27493292c502c.1306499600.git.git@drmicha.warpmail.net> <7vvcwwrqd7.fsf@alter.siamese.dyndns.org> <4DE00755.1020404@drmicha.warpmail.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Michael J Gruber <git@drmicha.warpmail.net>
X-From: git-owner@vger.kernel.org Sat May 28 00:46:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QQ5nB-0003WM-0P
	for gcvg-git-2@lo.gmane.org; Sat, 28 May 2011 00:46:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757252Ab1E0Wp7 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 May 2011 18:45:59 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64420 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757146Ab1E0Wp6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 May 2011 18:45:58 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 228A45A70;
	Fri, 27 May 2011 18:48:04 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=3wk3HoSAkwUFdIDS0kipsnFvizo=; b=xyppvK
	MHAXnQKav8JTCZHuKRUGWMDQ5AXlW4LY7ps50blLhh52JXt0Eedb5KS4XzdmWukT
	o0chm6D/ea3lq5OhQWMVQ2//KPJD+J3svCO/ELy/E4P8QldTniGv5g+LcWEKuER+
	HmobhF0G+s9fORkp2sji0bar/GukCgy3An34M=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oW1uvXDRIMxCLCCLSrOPh6BxjcQJv+16
	Fd3/G5sJN/yMCLr6m/FeQlaB1Ps7yp8JD86uhmsCQB5JK73x2LAO9XRthePXEb9u
	57z0OlKSZG9k97y0twf8v82d+F/RSYtFWWPX7wEIto6FMBMgE0YdTimJO91RsgqI
	lZPX4nKQItg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D55AB5A6F;
	Fri, 27 May 2011 18:48:01 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id DBD925A6E; Fri, 27 May 2011
 18:47:58 -0400 (EDT)
In-Reply-To: <4DE00755.1020404@drmicha.warpmail.net> (Michael J. Gruber's
 message of "Fri, 27 May 2011 22:19:33 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 60536ED8-88B3-11E0-A186-D6B6226F3D4C-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/174649>

Michael J Gruber <git@drmicha.warpmail.net> writes:

> Again, I'm sorry I'm not seeing through the call chain here.

diff_flush() notices it needs to produce textual patch and count added or
deleted lines here:

	if (output_format & (DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT...
		struct diffstat_t diffstat;

		memset(&diffstat, 0, sizeof(struct diffstat_t));
		for (i = 0; i < q->nr; i++) {
			struct diff_filepair *p = q->queue[i];
			if (check_pair_status(p))
				diff_flush_stat(p, options, &diffstat);
		}
		if (output_format & DIFF_FORMAT_NUMSTAT)
			show_numstat(&diffstat, options);
		if (output_format & DIFF_FORMAT_DIFFSTAT)
			show_stats(&diffstat, options);
		if (output_format & DIFF_FORMAT_SHORTSTAT)
			show_shortstats(&diffstat, options);
		free_diffstat_info(&diffstat);
		separator++;
	}

In the loop, it calls diff_flush_stat() for each and every filepair in the
queue.  The result is collected in &diffstat, and that is what your patch
works on in show_stats() function.  Before you look at it in show_stats(),
the same &diffstat may be examined by show_numstat(), and after you look
at it, the same &diffstat may be examined by show_shortstats().

diff_flush_stat() calls run_diffstat() to get textual patch for one
filepair. It ends up calling builtin_diffstat().

builtin_diffstat() looks at the preimage and postimage, and feeds the low
level xdiff machinery with it, and uses diffstat_consume() callbac to
count the +/- lines in the patch between the two.

Even though three show_*stat* function look at the same &diffstat, two
have duplicated logic to ignore (and uncount) a path whose executable
bit was changed without any other change, with:

	if (!it->is_renamed && (added + deleted) == 0)
        	ignore it!
