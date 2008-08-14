From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/3] strbuf: Add method to convert byte-size to human
 readable form
Date: Thu, 14 Aug 2008 16:04:55 -0700
Message-ID: <7viqu3ci5k.fsf@gitster.siamese.dyndns.org>
References: <1218752308-3173-1-git-send-email-marcus@griep.us>
 <1218752308-3173-2-git-send-email-marcus@griep.us>
 <1218752308-3173-3-git-send-email-marcus@griep.us>
 <20080814223429.GC10544@machine.or.cz>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marcus Griep <marcus@griep.us>,
	Git Mailing List <git@vger.kernel.org>
To: Petr Baudis <pasky@suse.cz>
X-From: git-owner@vger.kernel.org Fri Aug 15 01:06:20 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTltU-00069o-RY
	for gcvg-git-2@gmane.org; Fri, 15 Aug 2008 01:06:13 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751818AbYHNXFI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 19:05:08 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751390AbYHNXFI
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 19:05:08 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44266 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751424AbYHNXFH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 19:05:07 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id CAC425EE3D;
	Thu, 14 Aug 2008 19:05:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AE7FF5EE3C; Thu, 14 Aug 2008 19:04:57 -0400 (EDT)
In-Reply-To: <20080814223429.GC10544@machine.or.cz> (Petr Baudis's message of
 "Fri, 15 Aug 2008 00:34:29 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6C9AC972-6A55-11DD-92F9-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92435>

Petr Baudis <pasky@suse.cz> writes:

> My point still stands - in case of binary units, we should always
> consistently use the i suffix. So having an example in the commit
> message that advertises "bps" is simply wrong when it should read "iB/s"
> (like it does with the current progress.c code).
>
> I may sound boring, but it seems to me that you're still ignoring my
> point quitly without proper counter-argumentation and I think it's an
> important want, and since it's so hard to keep things consistent across
> the wide Git codebase, we should do all we can to keep it.

I pretty much agree with everything you said in this thread.  In addition,
I wonder if we would want to be able to say:

	960 bps
        0.9 KiB/s
	2.3 MiB/s

IOW, I do not think it is a good idea to have the list of "prefixes" in
this function and force callers to _append_ unit.  You might be better off
by making the interface to the function to pass something like this:

	struct human_unit {
		char *unitname;
                unsigned long valuescale;
	} bps_to_human[] = {
        	{ "bps", 1 },
                { "KiB/s", 1024 },
                { "MiB/s", 1024 * 1024 },
                { NULL, 0 },
	};

and perhaps give canned set of unit list for sizes and throughputs as
convenience.

By doing so, you could even do this:

	struct human_unit bits_to_human[] = {
        	{ "bits", 1 },
                { "bytes", 8 },
                { "Kbytes", 8 * 1024 },
                { "Mbytes", 8 * 1024 * 1024 },
                { NULL, 0 },
	};

I also am not particularly happy about using "double" in this API.  Most
of the callers that gather stats in the rest of the codebase count in
(long) integers as far as I can tell, and it may be conceptually cleaner
to keep the use of double as an internal implementation issue of this
particular function.
