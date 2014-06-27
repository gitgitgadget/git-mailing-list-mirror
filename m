From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Fri, 27 Jun 2014 10:13:28 -0700
Message-ID: <xmqqr42a2s3r.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A99FEB.5040808@ramsay1.demon.co.uk>
	<xmqq61joamcc.fsf@gitster.dls.corp.google.com>
	<vpq1tubinbx.fsf@anie.imag.fr>
	<xmqqpphv4hu6.fsf@gitster.dls.corp.google.com>
	<vpqzjgyg3x5.fsf@anie.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Ramsay Jones <ramsay@ramsay1.demon.co.uk>,
	Tanay Abhra <tanayabh@gmail.com>, git@vger.kernel.org,
	Ramkumar Ramachandra <artagnon@gmail.com>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jun 27 19:13:45 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X0ZiW-0002Pw-Ls
	for gcvg-git-2@plane.gmane.org; Fri, 27 Jun 2014 19:13:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751881AbaF0RNh (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 27 Jun 2014 13:13:37 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51738 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751348AbaF0RNg (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 27 Jun 2014 13:13:36 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id D309521DC6;
	Fri, 27 Jun 2014 13:13:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=gG6cSLLneACnEKrCyk8PXZByPzo=; b=saMmPk
	0hr80OrPxdoNvh4Y2KjQPmWAysuBXQ7AGYmwuCG9CNJcJlqGkMvDb9UN75fFO4Hd
	t6JslfmI5qRZBmx8CNV4oGlyha9nOWSxoy0UAMfPAQ3zv3sj/iVEaECyN8SKJq1B
	Tk51/ks8pBrf55GQl7kT7tIWu1S68kj2oo4OA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=xo6j10/afhAZxyPhfs5kyAK+dxJEo64X
	0j97Mvk2QUIpvzFfoY4UEa5pzWp4tpymUUgEooh3KYIJNXMJwP/vcMcTKw26UStN
	pg9xFSEveuEvjK3bhJ0VDplPp0MUKlxZ+3Iz6g31P6lxodHY41DQP/LUnef8D/Y/
	JTj7pya43kw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C82D121DC5;
	Fri, 27 Jun 2014 13:13:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D9E2B21DBF;
	Fri, 27 Jun 2014 13:13:21 -0400 (EDT)
In-Reply-To: <vpqzjgyg3x5.fsf@anie.imag.fr> (Matthieu Moy's message of "Fri,
	27 Jun 2014 10:19:50 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 5757B2E2-FE1E-11E3-8528-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252561>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

>>> Isn't that a bit overkill? Why not just let the caller manage a hashmap
>>> directly instead of a config_set?
>>
>> Because I had an experience under my belt of a painful refactoring
>> of "the_index" which turned out to be not just a single array, I
>> simply suspect that the final data structure to represent a "set of
>> config-like things" will not be just a single hashmap, hence I do
>> prefer to have one layer of abstraction "struct config_set", which
>> would contain a hashmap and possibly more.
>
> OK, I guess I overinterpreted what you meant by "struct config_set". If
> it's a thin abstraction layer on top of the hashmap (i.e. essentially
> contain the hashmap, and possibly a few more metadata), then it
> definitely makes sense.

Yup, and I do not strongly mind the initialization sequence of "if
you want to overlay from a file, call *_from_file()" you outlined;
an initialiser that takes a list of file paths to read from was
merely an example and not meant to be the sole interface (it is
overly rigid to be one).
