From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH jn/fast-import-blob-access] t9300: avoid short reads from
 dd
Date: Sun, 12 Dec 2010 23:21:37 -0800
Message-ID: <7vfwu25e9q.fsf@alter.siamese.dyndns.org>
References: <0BB1933F-1C3D-4C24-9C91-263121BF55FB@gernhardtsoftware.com>
 <20101212214909.GA19709@burratino>
 <2F4185D2-5846-45CB-BC92-6BC07AE5CEC8@gernhardtsoftware.com>
 <20101213063151.GB20812@burratino>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brian Gernhardt <brian@gernhardtsoftware.com>,
	"git\@vger.kernel.org List" <git@vger.kernel.org>,
	David Barr <david.barr@cordelta.com>,
	Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 13 08:21:59 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PS2jN-0005kN-Uo
	for gcvg-git-2@lo.gmane.org; Mon, 13 Dec 2010 08:21:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755351Ab0LMHVw (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Dec 2010 02:21:52 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:61468 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751793Ab0LMHVv (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Dec 2010 02:21:51 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 1B8742593;
	Mon, 13 Dec 2010 02:22:15 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=n/SAaPNbuB6HhKIsOKinFfuM68Q=; b=Fn7muJ
	kgzlcDLeRDFAAmOu5LDCoqGiZfaQvrCU1rHHrBUlvLRs84+KcjFPVn1OS/b6MwVm
	RbyYHT43GL2fjB//DwPk2M4GmxXJ6lLKEztJ9A5Dnr6a3pVMzp89irAOCrEAi7Fn
	gRChnMQu/xZ/2ZLT6CsTflIVzqwLhj0ecfGl0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=L5iBr3n4qZWvSrUVyydOJzJl1ThYJKeo
	FZwb+1FVyyjuu5pOXXt/nZb+Sw5bDiOKqsVsSQraXWhhL9Y08LZdCht/m7GTjOmQ
	/rLcMMWyxnHkkd+Wfw+WiMlHkIn8bfncgicKHqLtbMeWx+xzwRNNO5dZOunfBitS
	wJWjD8rWq+Q=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id BF0FE2591;
	Mon, 13 Dec 2010 02:22:10 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 31C4F2590; Mon, 13 Dec 2010
 02:22:03 -0500 (EST)
In-Reply-To: <20101213063151.GB20812@burratino> (Jonathan Nieder's message of
 "Mon\, 13 Dec 2010 00\:31\:51 -0600")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: B32C4136-0689-11E0-91C3-C4BE9B774584-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/163520>

Jonathan Nieder <jrnieder@gmail.com> writes:

> dd is a thin wrapper around read(2).  As open group Issue 7 explains:
>
> 	It shall read the input one block at a time, using the specified
> 	input block size; it shall then process the block of data
> 	actually returned, which could be smaller than the requested
> 	block size.
>
> Any short read --- for example from a pipe whose capacity cannot fill
> a block --- results in that block being truncated.  As a result, the
> first cat-blob test (9300.114) fails on Mac OS X, where the pipe
> capacity is around 8 KiB.

I saw a similar breakage on my FBSD 8 bochs.  It is unfortunate and feels
yucky that we have to issue 8k+ read(2) of one byte, but I don't think of
a better way.  I thought it might be possible to specify cbs and/or conv
to have the input buffered to a size to defeat the short read issue, but
count specifies in terms of input blocks, so there doesn't seem to be a
way to do so...  Oh well...

Thanks.
