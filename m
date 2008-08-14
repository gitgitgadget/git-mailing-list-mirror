From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2] count-objects: add human-readable size option
Date: Wed, 13 Aug 2008 22:22:17 -0700
Message-ID: <7vskt8f9x2.fsf@gitster.siamese.dyndns.org>
References: <1218657910-22096-1-git-send-email-marcus@griep.us>
 <1218687684-11671-1-git-send-email-marcus@griep.us>
 <20080814043817.GC11232@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Shawn O. Pearce" <spearce@spearce.org>,
	Git Mailing List <git@vger.kernel.org>
To: Marcus Griep <marcus@griep.us>
X-From: git-owner@vger.kernel.org Thu Aug 14 07:23:29 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KTVJ2-0000Qk-8a
	for gcvg-git-2@gmane.org; Thu, 14 Aug 2008 07:23:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751896AbYHNFW1 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Aug 2008 01:22:27 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753871AbYHNFW0
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Aug 2008 01:22:26 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:45082 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751272AbYHNFW0 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Aug 2008 01:22:26 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id AF0F957611;
	Thu, 14 Aug 2008 01:22:24 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 90FF45760F; Thu, 14 Aug 2008 01:22:20 -0400 (EDT)
In-Reply-To: <20080814043817.GC11232@spearce.org> (Shawn O. Pearce's message
 of "Wed, 13 Aug 2008 21:38:17 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: FA6CA13E-69C0-11DD-BF0D-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92317>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Marcus Griep <marcus@griep.us> wrote:
>> diff --git a/Documentation/git-count-objects.txt b/Documentation/git-count-objects.txt
>> index 75a8da1..291bc5e 100644
>> --- a/Documentation/git-count-objects.txt
>> +++ b/Documentation/git-count-objects.txt
>> +++ b/builtin-count-objects.c
> ...
>> +void human_readable_size(char *buf, int buf_size, double size /* in bytes */)
>
> Hmm.  This probably should be static.  Or if it really is meant
> to be a utility for use elsewhere in Git, moved to someplace where
> string handling is done.  Its not strbuf related, but maybe strbuf.c
> is a better location for this sort of library function.

Yes, with customizable precision (so that the caller can control "1.6k" vs
"1.62k"), and perhaps cutomizable unit (so that you can use this for
"3.6kB" and "2.6Mbps"), this kind of thing is a good candidate to be a
library function in strbuf.c.

>> +{
>> +	char human_readable_prefixes[10] = "BKMGTPEZY";

This enumerates suffix if I am not mistaken.  Do you have to say "10"
here, or does the compiler counts them for you?

>> +	for (; i < 8 && size >= 1000 ; ++i, size = size / 1024)
>> +		;

I do not think you would need to use the magic number "8" here.

I have this suspicion that the caller, if this is made into a generic
library, would want to pass in a list of units, not magnitude suffixes,
like this:

    extern int human_readable(struct strbuf *,
    			      double value, int precision,
                              const char **unit);

    static const char **size_unit = {
    	"byte", "KB", "MB", "GB", NULL,
    };
    static const char **throughput_unit = {
    	"bps", "Kbps", "Mbps", "Gbps", NULL,
    };

    human_readble(&sb, (double) bytes_transferred, 0, size_unit);
    human_readble(&sb, (double) throughput, 2, throughput_unit);
