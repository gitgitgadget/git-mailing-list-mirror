From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] abspath.c: use PATH_MAX in real_path_internal()
Date: Fri, 18 Jul 2014 09:45:57 -0700
Message-ID: <xmqqbnsmobsq.fsf@gitster.dls.corp.google.com>
References: <1405601143-31354-1-git-send-email-pclouds@gmail.com>
	<53C85625.6020808@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Karsten Blees <karsten.blees@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jul 18 18:46:21 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X8BIS-00075W-5a
	for gcvg-git-2@plane.gmane.org; Fri, 18 Jul 2014 18:46:12 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1030599AbaGRQqH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 18 Jul 2014 12:46:07 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51719 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1030383AbaGRQqG convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 18 Jul 2014 12:46:06 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 515D327A97;
	Fri, 18 Jul 2014 12:46:05 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=vXjkCgC6Taxh
	bck8pSNWjZOKmsI=; b=H9NZjpBo1p43Nrr6qQP31BnUn+/UWoD+BnZj36VJYq5D
	G/pjs7B/pX4vem4IN2lFCB0AXFjPBb41QrWKrQXKBWQEHjAxKsuobeRgqMS07mlK
	vHX5pX3Ou8cYSfD3RAIBZ/Rcj8rzZhGuAZHaLjQTJqDu5wW7P+Kot85CUELRxbk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=LBcUFx
	hIwxj03j2Ay/ByvROTi1sXbtX4HzQUuopyCUHvAJzcf6181fuFMZPg+UyElM/LQK
	O8CH2hZasuQq+JklAg9X9ORJB0YMUwTi+DO3zfmbiVpJ49CkToD8Q263N4hjzntQ
	zKmkvaaN0D2ogXvagMQFodISoNC0KAV+/3zpw=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 46C0D27A95;
	Fri, 18 Jul 2014 12:46:05 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id E891C27A8D;
	Fri, 18 Jul 2014 12:45:58 -0400 (EDT)
In-Reply-To: <53C85625.6020808@gmail.com> (Karsten Blees's message of "Fri, 18
	Jul 2014 01:03:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: FEBECD54-0E9A-11E4-AF38-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253825>

Karsten Blees <karsten.blees@gmail.com> writes:

> Am 17.07.2014 14:45, schrieb Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Du=
y:
>> e.g. "git init". Make it static too to reduce stack usage.
>
> But wouldn't this increase overall memory usage? Stack memory
> will be reused by subsequent code, while static memory cannot
> be reused (but still increases the process working set).

Correct.  And this is a function that is not involved in deep
recursion, so avoiding stack allocation seems quite misguided.
