From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] diff/status: refactor opportunistic index update
Date: Mon, 21 Mar 2011 12:39:35 -0700
Message-ID: <7vmxkop8js.fsf@alter.siamese.dyndns.org>
References: <AANLkTikV4S51DXLADiRXWqjXdTD1OBLSdKjEWALZ9Ebh@mail.gmail.com>
 <7vipvcs9xt.fsf@alter.siamese.dyndns.org>
 <7vtyewqtmk.fsf@alter.siamese.dyndns.org>
 <AANLkTinUqzgpiX_X+kpUuOSxNqRVp+OC1HOreEkF6yhX@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org,
	Lasse Makholm <lasse.makholm@gmail.com>
To: Piotr Krukowiecki <piotr.krukowiecki@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 21 20:39:53 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q1kxE-0003rb-CJ
	for gcvg-git-2@lo.gmane.org; Mon, 21 Mar 2011 20:39:52 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754182Ab1CUTjs convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Mar 2011 15:39:48 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:48354 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab1CUTjr convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Mar 2011 15:39:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 2D4C44203;
	Mon, 21 Mar 2011 15:41:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=8dMoBVryX5si
	LOr6WgGSbK/8Pjo=; b=di0q9lXj6IzF/43ZDVW0OSe5PdseZwcSiTBKy8exoe1T
	lkAzXJmDExcW55QS7S1LC0y4fxLKr6nQdLxz+WXVj+zS/FHFWr/NrdavmIjpQWhF
	MUyUJtT7Ha8mKtIcduwUHbt0zL+GoLq+kB9/ptzGSv29fI4rW1iwU9hAaamkBmE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Wg9GBG
	R0Ew8ep6ppfu0aTCXqE0K/z1eGI0Y058WsjF284mOJo40SLpjpyGAHQHWwKGw551
	IHwJjyBCTiXcEBNsIiuhaVoaT/tQJFXUt7sZzD4i12zJtJf7j29/bebgJpjdSUjt
	7iKYuQ1EwTDGXtYWuE3rnMjVe7Z9S1bFCJGPw=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id F13A54201;
	Mon, 21 Mar 2011 15:41:21 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id A41D441FF; Mon, 21 Mar 2011
 15:41:16 -0400 (EDT)
In-Reply-To: <AANLkTinUqzgpiX_X+kpUuOSxNqRVp+OC1HOreEkF6yhX@mail.gmail.com>
 (Piotr Krukowiecki's message of "Mon, 21 Mar 2011 19:46:22 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 330245D4-53F3-11E0-A043-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169648>

Piotr Krukowiecki <piotr.krukowiecki@gmail.com> writes:

> On Mon, Mar 21, 2011 at 6:16 PM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> +void update_index_if_able(struct index_state *istate, struct lock_f=
ile *lockfile)
>> +{
>> + =C2=A0 =C2=A0 =C2=A0 if (istate->cache_changed) &&
>> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !write_index(istate, lockfile->=
fd))
>
> Mismatched parenthesis? Should be sth like
>
> + =C2=A0 =C2=A0 =C2=A0 if (istate->cache_changed &&
> + =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 !write_index(istate, lockfile->f=
d))

Yeah, "rebase -i" gotcha.  Applying [2/2] should get rid of it anyway.
