From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Resumable clone
Date: Tue, 08 Mar 2016 09:25:27 -0800
Message-ID: <xmqqy49slw54.fsf@gitster.mtv.corp.google.com>
References: <CANtyZjSJf5_xbsBC5tUaazFT3uiEgJnx2_kHLwYwKcn50Jy_qg@mail.gmail.com>
	<CACsJy8CESL6vH22mGSLRE1OKTEbGz2Vqmsv5bY3mn_E+03wADw@mail.gmail.com>
	<xmqqoaasvkrt.fsf@gitster.mtv.corp.google.com>
	<CANtyZjRZzXabeWEhwCrwN_q_Zsrm1f_d+j2uDhTZeEjv3LjxaA@mail.gmail.com>
	<CACsJy8A_jkvdJPgBQ_huP-t8a0ra2RfP7jZ7C-ONNm87ktYaiA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Kevin Wern <kevin.m.wern@gmail.com>,
	Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 08 18:25:37 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1adLO3-0006DZ-KR
	for gcvg-git-2@plane.gmane.org; Tue, 08 Mar 2016 18:25:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754076AbcCHRZc (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Mar 2016 12:25:32 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:60383 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752063AbcCHRZb (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Mar 2016 12:25:31 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id EDD024A79C;
	Tue,  8 Mar 2016 12:25:29 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=aJ399pdWjwffSbXJUZL3dzDFy94=; b=frUaWS
	YMR4XAy3QZ3GX0QCM+TPVjL9Mph4g9LhmTTTOY3IA0WN41K6d2ZZKfS6c+77My+s
	iEuOVQhbQXBnykXWhnnf1A5Q5CoClZheKSbypq27GY2tvES3GqSfVx/oYzTibnmE
	Ak6hwIoHN28XzfJoMOgFpt77IuNicmEEM1htk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZzT5f7mp5/UXLSmRRb3vqu/OKY5M3D1y
	fERu08KpUtCt8k3NHHYDD30MIC14YDm6TfI+2Su0JSCBaK9bvV79VTPCPzDYkUYe
	kIXwTQ2BiQjlqQDPxrTcHCI/p484t2O8TnVuA+VfUvA9xyKXCyOCrgNV0iB8hR0y
	UQt9dwC6mNg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E4F2D4A79B;
	Tue,  8 Mar 2016 12:25:29 -0500 (EST)
Received: from pobox.com (unknown [104.132.1.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 627734A79A;
	Tue,  8 Mar 2016 12:25:29 -0500 (EST)
In-Reply-To: <CACsJy8A_jkvdJPgBQ_huP-t8a0ra2RfP7jZ7C-ONNm87ktYaiA@mail.gmail.com>
	(Duy Nguyen's message of "Tue, 8 Mar 2016 18:11:19 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: C1155CA8-E552-11E5-BAF3-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/288441>

Duy Nguyen <pclouds@gmail.com> writes:

> Yeah the determination is tricky, it depends on server setup. Let's
> start with select the pack for download first because there could be
> many of them. A heuristic (*) of choosing the biggest one in
> $GIT_DIR/objects/pack is probably ok for now (we don't need full
> history, "the biggest part of history" is good enough).

You need to choose a pack that is fully connected, though.  I was
envisioning that an updated "git repack" would have an extra option
that help server operators to manage it easily.  You would need to
consider for example:

 - You may not want to rebuild such a base pack too frequently
   (e.g. you may want to repack a busy repository twice a day, but
   you would want to redo the base pack only once a week).  It is
   possible to mark it with .keep for subsequent repacks to leave it
   alone, but there needs a mechanism to manage that .keep marker.

 - You may not want to have all refs in such a base pack (e.g. you
   may want to exclude refs/changes/ from it).  There need to be a
   configuration to specify which refs are included in the base
   pack.

while designing such an update.  Then the repack with such an option
would roughly be:

    - If it is time to redo a base repack, then

      - unplug the .keep bit the previous base pack has;

      - create a pack that contains full history reachable from the
        specified refs;

      - mark the new base pack as such;

    - Pack all objects that are not in the base pack that are
      reachable from any refs (and other anchoring points, such as
      reflogs and the index) into a separate pack.

And the prime_clone() advertisement would be just the matter of
knowing how the "base" pack is marked in the above process.
