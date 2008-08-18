From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] compat: introduce stat_to_kilobytes
Date: Mon, 18 Aug 2008 13:40:04 -0700
Message-ID: <7vbpzqm50b.fsf@gitster.siamese.dyndns.org>
References: <273481A4-0BB2-4A58-83AD-604B425DE824@web.de>
 <7vy72w6kiv.fsf@gitster.siamese.dyndns.org>
 <200808182157.16392.johannes.sixt@telecom.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Andreas =?utf-8?Q?F=C3=A4rber?= <andreas.faerber@web.de>
To: Johannes Sixt <johannes.sixt@telecom.at>
X-From: git-owner@vger.kernel.org Mon Aug 18 22:41:26 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KVBXS-0004BN-Fn
	for gcvg-git-2@gmane.org; Mon, 18 Aug 2008 22:41:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182AbYHRUkN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 18 Aug 2008 16:40:13 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753061AbYHRUkN
	(ORCPT <rfc822;git-outgoing>); Mon, 18 Aug 2008 16:40:13 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:34399 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754212AbYHRUkM (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 18 Aug 2008 16:40:12 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 21ADC515BD;
	Mon, 18 Aug 2008 16:40:11 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 68BFC515B8; Mon, 18 Aug 2008 16:40:07 -0400 (EDT)
In-Reply-To: <200808182157.16392.johannes.sixt@telecom.at> (Johannes Sixt's
 message of "Mon, 18 Aug 2008 21:57:16 +0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: DA38A266-6D65-11DD-861A-B29498D589B0-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/92738>

Johannes Sixt <johannes.sixt@telecom.at> writes:

> From: Junio C Hamano <gitster@pobox.com>
>
> Some platforms do not have st_blocks member in "struct stat"; mingw
> already emulates it by rounding it up to closest 512-byte blocks (even
> though it could overcount when a file has holes).
>
> The reason to use the member is only to figure out how many kilobytes the
> file occupies on-disk, so give a helper in git-compat-util.h to help these
> platforms.
>
> Signed-off-by: Junio C Hamano <gitster@pobox.com>
> Acked-by: Johannes Sixt <johannes.sixt@telecom.at>
> ---
> On Sonntag, 17. August 2008, Junio C Hamano wrote:
>>    The comment before "struct mingw_stat" suggests that the only reason
>>    this compatiblity definition exists is to add st_blocks member, so I
>>    suspect we could remove the definition and simplify the compatibility
>>    layer a lot more, but I do not know MinGW, so I am CC'ing j6t here.
>
> Makes sense. Here it is again, with the Makefile fixup noted by Andreas.
>
> But notice that we now underestimated the size of loose objects more than
> we did previously because we now round down individual sizes; previously
> we rounded down only the total size.

Ah, you are right.

Perhaps we should fix this by making the helper stat_to_on_disk_bytes(),
so that on platform with st_blocks counted in 512-byte blocks we multiply
it by 512?
