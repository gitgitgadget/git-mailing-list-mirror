From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/7] strbuf: add "include_delim" parameter to
 "strbuf_split"
Date: Fri, 13 Mar 2009 00:06:02 -0700
Message-ID: <7v7i2tj411.fsf@gitster.siamese.dyndns.org>
References: <20090312085103.e83b34a5.chriscool@tuxfamily.org>
 <200903130548.30370.chriscool@tuxfamily.org>
 <7v1vt2j91x.fsf@gitster.siamese.dyndns.org>
 <200903130702.01039.chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nanako Shiraishi <nanako3@lavabit.com>, git@vger.kernel.org,
	Ingo Molnar <mingo@elte.hu>, John Tapsell <johnflux@gmail.com>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	Pierre Habouzit <madcoder@debian.org>
To: Christian Couder <chriscool@tuxfamily.org>
X-From: git-owner@vger.kernel.org Fri Mar 13 08:07:58 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Li1Ur-0001xl-Sp
	for gcvg-git-2@gmane.org; Fri, 13 Mar 2009 08:07:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751646AbZCMHGQ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Mar 2009 03:06:16 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750761AbZCMHGQ
	(ORCPT <rfc822;git-outgoing>); Fri, 13 Mar 2009 03:06:16 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:62196 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750952AbZCMHGP (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Mar 2009 03:06:15 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id E08DC2696;
	Fri, 13 Mar 2009 03:06:12 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 30BA12691; Fri,
 13 Mar 2009 03:06:04 -0400 (EDT)
In-Reply-To: <200903130702.01039.chriscool@tuxfamily.org> (Christian Couder's
 message of "Fri, 13 Mar 2009 07:02:00 +0100")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 6FE27CD6-0F9D-11DE-BCC7-C5D912508E2D-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/113148>

Christian Couder <chriscool@tuxfamily.org> writes:

>> Also comparing this with Perl/Python split() forgets that you are working
>> in C, where truncating an existing string is quite cheap (just assign
>> '\0'). There is a different trade-off to be made in these language
>> environments.
>
> Sorry but I think the goal of the strbuf API is to be quite high level, so I 
> think comparing this with Perl/Python is ok.

I think you are mistaken again.

The highlevel-ness of strbuf holds true only while you live in the strbuf
world, but you should consider what happens when its end product finally
gets used in the calling function written in C.  It will be a good-old NUL
terminated string or just a chunk of memory with known length.

For a user written in C, it is far easier and cheaper to trim excess at
the end, especially when the length of the string is known (strbuf_detach
gives you the length of the string exactly for this reason) than having to
extend it (in order to recover the lost delimiter because the splitter
removed it).  Trimming from the front is also cheap (just move the head
pointer and start consuming from the middle).
