From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 15/16] index-pack: use nr_objects_final as sha1_table size
Date: Mon, 09 Sep 2013 11:34:31 -0700
Message-ID: <xmqq61u94zew.fsf@gitster.dls.corp.google.com>
References: <1378652660-6731-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-1-git-send-email-pclouds@gmail.com>
	<1378735087-4813-16-git-send-email-pclouds@gmail.com>
	<alpine.LFD.2.03.1309091047510.20709@syhkavp.arg>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Nicolas Pitre <nico@fluxnic.net>
X-From: git-owner@vger.kernel.org Mon Sep 09 20:34:46 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VJ6IP-0000X8-12
	for gcvg-git-2@plane.gmane.org; Mon, 09 Sep 2013 20:34:45 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753086Ab3IISel convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 9 Sep 2013 14:34:41 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:43226 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751320Ab3IISek convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 9 Sep 2013 14:34:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 11FE84077B;
	Mon,  9 Sep 2013 18:34:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=ZkVRlf4ROn8u
	wzqUBTtERUHJSLU=; b=RBMrssNnX+B6LgTdvKnKAyg2UUArpATB8vjBvOifScFH
	UjnWNYRWiyAIV+uANNivSEB+Kg6/2tFdVmW8Dsd1wOLjbOpBs8gGaKfTnKEHxUyv
	bJ8ubpaV+9nOFR8f0/Ab+o01lZCG1Pg50JDWjYNLncv2Om+9cbXkTDVtLq6EF/A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=QCp63F
	aTAAb2xMZT8X8fq3oyBFASVlZyI0N+9hZ8qMgM4wlF0QBf/8lgQlgZLMT4cGwF/s
	uAReORSzBmLnOTbo7U4NzfRcQm0MUSIITWG54kFJTz35cnP5j+lDLD1oJGQc4IfI
	VnlFtJwaDOKb89kEjCz+HOe7/iIBt2hkx0WTI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id EA64040779;
	Mon,  9 Sep 2013 18:34:38 +0000 (UTC)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 55B0B40771;
	Mon,  9 Sep 2013 18:34:36 +0000 (UTC)
In-Reply-To: <alpine.LFD.2.03.1309091047510.20709@syhkavp.arg> (Nicolas
	Pitre's message of "Mon, 09 Sep 2013 11:01:10 -0400 (EDT)")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7A89445E-197E-11E3-8507-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/234354>

Nicolas Pitre <nico@fluxnic.net> writes:

> On Mon, 9 Sep 2013, Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy wrote:
>
>> nr_objects in the next patch is used to reflect the number of actual
>> objects in the stream, which may be smaller than the number recorded
>> in pack header.
>
> This highlights an issue that has been nagging me for a while.
>
> We decided to send the final number of objects in the thin pack heade=
r=20
> for two reasons:
>
> 1) it allows to properly size the SHA1 table upfront which already=20
>    contains entries for the omitted objects;
>
> 2) the whole pack doesn't have to be re-summed again after being=20
>    completed on the receiving end since we don't alter the header.
>
> However this means that the progress meter will now be wrong and that=
's=20
> terrible !  Users *will* complain that the meter doesn't reach 100% a=
nd=20
> they'll protest for being denied the remaining objects during the=20
> transfer !
>
> Joking aside, we should think about doing something about it.  I was=20
> wondering if some kind of prefix to the pack stream could be inserted=
=20
> onto the wire when sending a pack v4.  Something like:
>
> 'T', 'H', 'I', 'N', <actual_number_of_sent_objects_in_network_order>
>
> This 8-byte prefix would simply be discarded by index-pack after bein=
g=20
> parsed.
>
> What do you think?

I do not think it is _too_ bad if the meter jumped from 92% to 100%
when we finish reading from the other end ;-), as long as we can
reliably tell that we read the right thing.

Which brings me to a tangent.  Do we have a means to make sure that
the data received over the wire is bit-for-bit correct as a whole
when it is a thin pack stream?  When it is a non-thin pack stream,
we have the checksum at the end added by sha1close() which
index-pack.c::parse_pack_objects() can (and does) verify.
