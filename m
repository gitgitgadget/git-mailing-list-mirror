From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v5 14/15] fast-export: make sure updated refs get updated
Date: Wed, 21 Nov 2012 10:12:04 -0800
Message-ID: <7vsj823h0z.fsf@alter.siamese.dyndns.org>
References: <1352642392-28387-1-git-send-email-felipe.contreras@gmail.com>
 <1352642392-28387-15-git-send-email-felipe.contreras@gmail.com>
 <D39D26A9-16B4-4A9F-9102-BD2C92FA10AF@quendi.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>, git@vger.kernel.org,
	Johannes Schindelin <johannes.schindelin@gmx.de>,
	Jeff King <peff@peff.net>,
	Sverre Rabbelier <srabbelier@gmail.com>,
	Brandon Casey <drafnel@gmail.com>,
	Brandon Casey <casey@nrlssc.navy.mil>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Ilari Liusvaara <ilari.liusvaara@elisanet.fi>,
	Pete Wyckoff <pw@padd.com>, Ben Walton <bdwalton@gmail.com>,
	Matthieu Moy <Matthieu.Moy@imag.fr>,
	Julian Phillips <julian@quantumfyre.co.uk>
To: Max Horn <max@quendi.de>
X-From: git-owner@vger.kernel.org Wed Nov 21 20:14:44 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TbFks-0004Kn-MN
	for gcvg-git-2@plane.gmane.org; Wed, 21 Nov 2012 20:14:39 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755752Ab2KUTOY (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 21 Nov 2012 14:14:24 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48755 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755732Ab2KUTOX (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 21 Nov 2012 14:14:23 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B7F1B962A;
	Wed, 21 Nov 2012 14:14:22 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 s=sasl; bh=lksIJRD6VyL1xs6XlCcXZtKS/fI=; b=cJjo8ZNhOQLs/rM6Fr7t
	jCTPN+9207tBB3VVDi5zdoOJSuf1wHUTol48Cz/Dw325qgPAhtvOwscDvVwFszoO
	XF6fPAUjJzLiMb4yCzxk89PTaHQj42qYTzb7C3Ii9PwqqcCUHu3895wqbKAmd+cy
	+sPIHh5ZWhtKjyfYeT/tpfA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:references:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=SfUrboz40YuN5i8X42Q9VOVR2xxp/fSQWIMIKm6EuViQ7l
	wvm6IjY+NiA91vA+0CIKqJb0BiUrqQT83Yxt+/5kBmotd4+frpnYiFryqxj568so
	+YXHfzOvqh1Ms7hHFpmQj8nLah3HccLacH0DMqME/+Tdm51yJlL+rT14YFKPM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A26DD9629;
	Wed, 21 Nov 2012 14:14:22 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EA4359625; Wed, 21 Nov 2012
 14:14:21 -0500 (EST)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A7DD18C2-340F-11E2-9644-C2612E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/210154>

Max Horn <max@quendi.de> writes:

> On 11.11.2012, at 14:59, Felipe Contreras wrote:
>
>> When an object has already been exported (and thus is in the marks) it's
>> flagged as SHOWN, so it will not be exported again, even if in a later
>> time it's exported through a different ref.
>> 
>> We don't need the object to be exported again, but we want the ref
>> updated, which doesn't happen.
>> 
>> Since we can't know if a ref was exported or not, let's just assume that
>> if the commit was marked (flags & SHOWN), the user still wants the ref
>> updated.
>> 
>> IOW: If it's specified in the command line, it will get updated,
>> regardless of wihether or not the object was marked.
>
> Typo: wihether => whether
>
>> 
>> So:
>> 
>> % git branch test master
>> % git fast-export $mark_flags master
>> % git fast-export $mark_flags test
>> 
>> Would export 'test' properly.
>> 
>> Additionally, this fixes issues with remote helpers; now they can push
>> refs wich objects have already been exported, and a few other issues as
>
> Typo: wich => which

I'd rather use "whose" there.
