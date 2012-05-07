From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC/PATCH v4 5/6] completion: calculate argument position
 properly
Date: Mon, 07 May 2012 11:59:20 -0700
Message-ID: <7v7gwn6cmv.fsf@alter.siamese.dyndns.org>
References: <1336353800-17323-1-git-send-email-felipe.contreras@gmail.com>
 <1336353800-17323-6-git-send-email-felipe.contreras@gmail.com>
 <CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jonathan Nieder <jrnieder@gmail.com>,
	SZEDER =?utf-8?Q?G=C3=A1bor?= <szeder@ira.uka.de>,
	Thomas Rast <trast@student.ethz.ch>,
	Scott Bronson <bronson@rinspin.com>,
	Nathan Broadbent <nathan.f77@gmail.com>
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Mon May 07 20:59:40 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SRT9f-0004C9-QL
	for gcvg-git-2@plane.gmane.org; Mon, 07 May 2012 20:59:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757619Ab2EGS7Z convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 7 May 2012 14:59:25 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38349 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757616Ab2EGS7X convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 7 May 2012 14:59:23 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76EF178F6;
	Mon,  7 May 2012 14:59:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=mGY5otiUUFl8
	+W3XhBKvvPckIjc=; b=Q/FPObnN/pSF93USNa8WOE9/yTC75bzsNnap+s1ztExw
	rjrvDdJQFXWCz6PBRHidRdslgf9mK25Ufrp4z66DpE+2mX24HzIiPlBI4gX+ayp5
	PnoWEV4L+xSZJKfHEOK3hagPX0I+hafy+yT7964liNQ4vpItaUPZmQykjzi36Rw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=oqsw37
	fPOtivyBfpHUAWACFU4mRddYAkeuPI2p7MiVv+h4k+JmZINPwPdnQAu6Tbbw0RiG
	GC03rLUnU30ac5A9Ht36wPFL4bHOuKqPXclPi/Skilbyq4vm44gb7Mxi5f/wIUep
	W5mKwhjaYH7MtzzCluLr21uQ3iLCCSq6GTNxc=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 614EF78F5;
	Mon,  7 May 2012 14:59:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 6535978F2; Mon,  7 May 2012
 14:59:22 -0400 (EDT)
In-Reply-To: <CAMP44s3Bscm0T_=-g-wRc9kkZYZjGHGaP6hPi8598=Oh=skjxw@mail.gmail.com> (Felipe
 Contreras's message of "Mon, 7 May 2012 03:27:31 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C1E79F9C-9876-11E1-AF2C-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/197297>

=46elipe Contreras <felipe.contreras@gmail.com> writes:

> On Mon, May 7, 2012 at 3:23 AM, Felipe Contreras
> <felipe.contreras@gmail.com> wrote:
>
>> @@ -2642,6 +2642,8 @@ _git ()
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0return
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0fi
>>
>> + =C2=A0 =C2=A0 =C2=A0 (( cmd_pos =3D c + 1 ))
>
> Actually, I would prefer cmd_pos=3D$((c + 1)).

Yeah, that would feel more natural.

Together with 4/6, I am guessing that you are using $cmd and $cmd_pos a=
s a
global variable to pass state to/from helper functions.  Are they prope=
rly
documented in code (if not, please do so)?
