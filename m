From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] sideband.c: Use xmalloc() instead of variable-sized arrays.
Date: Tue, 08 Jan 2008 12:13:13 -0800
Message-ID: <7v7iikrs86.fsf@gitster.siamese.dyndns.org>
References: <4783A3B2.3060801@viscovery.net>
	<7v4pdotdtl.fsf@gitster.siamese.dyndns.org>
	<alpine.LFD.1.00.0801081444360.3054@xanadu.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nicolas Pitre <nico@cam.org>
X-From: git-owner@vger.kernel.org Tue Jan 08 21:13:56 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JCKpc-00025E-GR
	for gcvg-git-2@gmane.org; Tue, 08 Jan 2008 21:13:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751987AbYAHUNZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Jan 2008 15:13:25 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752020AbYAHUNZ
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Jan 2008 15:13:25 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:39008 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751746AbYAHUNY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Jan 2008 15:13:24 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 4BED6C1E0;
	Tue,  8 Jan 2008 15:13:21 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 9AC15C1DC;
	Tue,  8 Jan 2008 15:13:16 -0500 (EST)
In-Reply-To: <alpine.LFD.1.00.0801081444360.3054@xanadu.home> (Nicolas Pitre's
	message of "Tue, 08 Jan 2008 14:59:20 -0500 (EST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/69911>

Nicolas Pitre <nico@cam.org> writes:

> On Tue, 8 Jan 2008, Junio C Hamano wrote:
>
>> Johannes Sixt <j.sixt@viscovery.net> writes:
>> 
>> > From: Johannes Sixt <johannes.sixt@telecom.at>
>> >
>> > How come we got along with this not very portable construct for so long?
>> > Probably because the array sizes were computed from the results of
>> > strlen() of string constants. Anyway, a follow-up patch will make the
>> > lengths really non-constant.
>> >
>> > Signed-off-by: Johannes Sixt <johannes.sixt@telecom.at>
>> > ---
>> >  sideband.c |   14 ++++++++++++--
>> >  1 files changed, 12 insertions(+), 2 deletions(-)
>> >
>> > diff --git a/sideband.c b/sideband.c
>> > index 756bbc2..513d7b3 100644
>> > --- a/sideband.c
>> > +++ b/sideband.c
>> > @@ -19,7 +19,10 @@ int recv_sideband(const char *me, int in_stream, int out, int err)
>> >  {
>> >  	unsigned pf = strlen(PREFIX);
>> >  	unsigned sf = strlen(SUFFIX);
>> > -	char buf[pf + LARGE_PACKET_MAX + sf + 1];
>> > +	char *buf, *save;
>> > +
>> > +	save = xmalloc(sf);
>> > +	buf = xmalloc(pf + LARGE_PACKET_MAX + sf + 1);
>> 
>> I have to wonder if the malloc() overhead is small enough
>> compared to the network bandwidth to make a two malloc-free
>> pairs per packet a non-issue...
>
> Eeek.  Overhead might be insignificant, but it still doesn't feel right.
>
> What about using alloca() instead?  This is not like if we are doing 
> funky things with the allocated memory anyway.

That's double Eek as I recall AIX is not dead.

How about using a constant large enough slop?  It is not like
PREFIX and SUFFIX are different vastly between calls.
