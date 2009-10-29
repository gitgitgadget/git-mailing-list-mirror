From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH v4 03/26] pkt-line: Make packet_read_line easier to
 debug
Date: Thu, 29 Oct 2009 13:43:46 -0700
Message-ID: <7v1vkm6id9.fsf@alter.siamese.dyndns.org>
References: <1256774448-7625-1-git-send-email-spearce@spearce.org>
 <1256774448-7625-4-git-send-email-spearce@spearce.org>
 <7vhbtidgmp.fsf@alter.siamese.dyndns.org>
 <20091029151152.GX10505@spearce.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Thu Oct 29 21:44:03 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1N3bqk-0002S2-Fu
	for gcvg-git-2@lo.gmane.org; Thu, 29 Oct 2009 21:44:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756672AbZJ2Unu (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 29 Oct 2009 16:43:50 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1756655AbZJ2Unt
	(ORCPT <rfc822;git-outgoing>); Thu, 29 Oct 2009 16:43:49 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:50371 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756602AbZJ2Unt (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 29 Oct 2009 16:43:49 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1A69B8AF46;
	Thu, 29 Oct 2009 16:43:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=c3ESQxzKGANlgkyxvAG6QaYr738=; b=v9yozwvueERiBzNY73HRp7c
	OAC5TEUiPrFsKhIUqfR2QHCi9ZoIhHhKxaimDRGVGNLLCiyFs7d/Sl8YAL/Bv9Yl
	nAms+RsLsof5BliTS608SC+T+/x2ED4IWiIwFw7UvKqPeBRl312XQt7IOvebqCCc
	c8z0AvJQfX+t8f0u+Pe8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=kpLGtuB4gjZbEoI1dCmaB/oyYjWl8w/v5P+RQbpRKpfrQBwCv
	+DO6bNnJgocdMRpmjlbKtavkmP6B7qAGplc7C0uVZQOrEGAX1BK1Ak7jHM61y5A/
	vBaSS2iRaODrC8JJW58Xzmh3YCxEg1+pC9xBH0W8hgK5kW+9urqvsVbPwg=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F278B8AF44;
	Thu, 29 Oct 2009 16:43:51 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id B14288AF42; Thu, 29 Oct 2009
 16:43:47 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: C45CCDDC-C4CB-11DE-9A3E-A67CBBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/131651>

"Shawn O. Pearce" <spearce@spearce.org> writes:

> Junio C Hamano <gitster@pobox.com> wrote:
>> "Shawn O. Pearce" <spearce@spearce.org> writes:
>> > diff --git a/pkt-line.c b/pkt-line.c
>> > index bd603f8..893dd3c 100644
>> > --- a/pkt-line.c
>> > +++ b/pkt-line.c
>> > @@ -124,12 +124,14 @@ static int packet_length(const char *linelen)
>> >  int packet_read_line(int fd, char *buffer, unsigned size)
>> >  {
>> >  	int len;
>> > -	char linelen[4];
>> > +	char linelen[5];
>> >  
>> >  	safe_read(fd, linelen, 4);
>> >  	len = packet_length(linelen);
>> > -	if (len < 0)
>> > -		die("protocol error: bad line length character");
>> > +	if (len < 0) {
>> > +		linelen[4] = '\0';
>> > +		die("protocol error: bad line length character: %s", linelen);
>> > +	}
>> 
>> Since this is not called recursively, you can make linelen[] static
>
> Sure.  But it wasn't static before.  It was stack allocated.  Its a
> 5 byte stack allocation.  Its not a lot of data to push onto the
> stack, why does it suddenly matter that we make it static and charge
> everyone for its memory instead of just those who really need it?
>
>> and do
>> without the NUL assignment; safe_read() won't read beyond 4 bytes anyway.
>
> The NUL assignment isn't about safe_read(), its about making the
> block of 4 bytes read a proper C-style string so we can safely pass
> it down into the snprintf that is within die().

I knew and understood all of what you just said.  static linelen[] is not
about stack allocation.  It's about letting the compiler initialize it to
five NULs so that you do not have to assign NUL to its fifth place before
you die.  This removes one added line from your patch.
