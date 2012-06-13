From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git: Wrong parsing of ssh urls with IPv6 literals ignores port
Date: Wed, 13 Jun 2012 10:21:04 -0700
Message-ID: <7v4nqfi0vz.fsf@alter.siamese.dyndns.org>
References: <20111022001704.3115.87464.reportbug@hejmo>
 <20120610090516.GA30177@burratino> <4FD78EA0.2090306@lsrfire.ath.cx>
 <20120612202953.GG9764@burratino> <20120612210003.GA16816@burratino>
 <4FD8C0F6.8060609@lsrfire.ath.cx>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	Eduardo =?utf-8?Q?Tr=C3=A1pani?= <etrapani@gmail.com>,
	git@vger.kernel.org, YOSHIFUJI Hideaki <yoshfuji@linux-ipv6.org>
To: =?utf-8?Q?Ren=C3=A9?= Scharfe <rene.scharfe@lsrfire.ath.cx>
X-From: git-owner@vger.kernel.org Wed Jun 13 19:21:15 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SerFq-0006kV-1w
	for gcvg-git-2@plane.gmane.org; Wed, 13 Jun 2012 19:21:14 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753893Ab2FMRVJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 13 Jun 2012 13:21:09 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753458Ab2FMRVH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Wed, 13 Jun 2012 13:21:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AD30D80DE;
	Wed, 13 Jun 2012 13:21:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=Kfq1ZUa+Algg
	mnwr9fXcNkPFZTI=; b=fXWeHgILXqoBZS/hrMcPB/6FHd/FBVso1mmoCWafWOZv
	JmxzNvu3Sigh/DsDQ4dP+AvGSeMA6YQdDlI9sDalBB838ftIPrKBN1lYzcghHpUl
	xv/L/VOq+00/uZq55FsTI9JO3zB4G/PmoyITjCREhemQBcTLY1+6PbqQsdfslUA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=wZDqRx
	ETCgCcRtUgJ55VjctygC9fPh2UPdzfq9MAr1jN9CPME4MLNpv1/8nKOnovyGJ28m
	Y1ooDaY6xBZu+gM8WVqEdUwIm5hb+OeAxjAZu+FY98Y+fDHXFQOXOuSpjnsaJxHG
	NOmJSiRwswgLtiZHmOfpVhYMggt9K+PnWFvPE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FA6380DD;
	Wed, 13 Jun 2012 13:21:06 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 0B82380DC; Wed, 13 Jun 2012
 13:21:05 -0400 (EDT)
In-Reply-To: <4FD8C0F6.8060609@lsrfire.ath.cx> (=?utf-8?Q?=22Ren=C3=A9?=
 Scharfe"'s message of "Wed, 13 Jun 2012 18:33:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 28A978E6-B57C-11E1-A2E2-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/199908>

Ren=C3=A9 Scharfe <rene.scharfe@lsrfire.ath.cx> writes:

> Am 12.06.2012 23:00, schrieb Jonathan Nieder:
>> Jonathan Nieder wrote:
>>> Ren=C3=A9 Scharfe wrote:
>>
>>>> How about this instead?
>>>
>>> Looks good to me.
>>
>> Oh, hold on a second.  Won't this get confused by
>>
>> 	ssh://[::1]/foo/bar/baz:80/qux
>>
>> ?
>
> It shouldn't, because the host part is NUL-terminated before
> get_port() is called.  Let's see (with the patch):
>
> 	$ git clone ssh://[::1]/foo/bar/baz:80/qux
> 	Cloning into 'qux'...
> 	ssh: connect to host ::1 port 22: Connection refused
> 	fatal: The remote end hung up unexpectedly
>
> Ren=C3=A9

Yeah, I was wondering how that would get confused myself.  Jonathan,
ack again?
