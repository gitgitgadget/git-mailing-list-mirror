From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] gc --auto: do not run 'pack-refs' and 'reflog expire' twice
Date: Tue, 02 Sep 2014 12:16:22 -0700
Message-ID: <xmqqtx4pzvcp.fsf@gitster.dls.corp.google.com>
References: <1409459610-8695-1-git-send-email-pclouds@gmail.com>
	<xmqqzjeh28p0.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Tue Sep 02 21:16:38 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XOtZB-00029I-DV
	for gcvg-git-2@plane.gmane.org; Tue, 02 Sep 2014 21:16:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754897AbaIBTQ2 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 2 Sep 2014 15:16:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51870 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750954AbaIBTQZ convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 2 Sep 2014 15:16:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id CD8D63784F;
	Tue,  2 Sep 2014 15:16:24 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=3u9WQQMjqWWx
	BgOnV+BgXpF4Lpw=; b=bnE6rVLiygkj03K7nAsd9H2svEpLmbNXPsZnzRmSe4Kl
	3geXNuBYw2HPoGfPxr4z5/3yGGOEzvwwZ2E8aM5Rxfk2iW+E7NCSSbQRhd/9M9lo
	lW6EXj6k4dXZWZ6a07YYvdu1K/Tblpbr1xxlNcjvhx1gAVSphoreSw9InBiqWdQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=IIH92O
	UmiD+F+pUT/ACxxTY3/lkIi28FgNiPvYBz4nf10pLKmmQkB/mfA3hDX5vHlDNcrV
	dBmX1J9q5JU4HEL3dWZixgZTaVQ/EhYb57FhtSBZeXnGl9v0WP2UuLZWk5vVLzz+
	vU5d72fXt0bTv/7VFN43NLC9TDViSBa2AQuc4=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id C495B3784E;
	Tue,  2 Sep 2014 15:16:24 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 4A1603784D;
	Tue,  2 Sep 2014 15:16:24 -0400 (EDT)
In-Reply-To: <xmqqzjeh28p0.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Tue, 02 Sep 2014 11:12:11 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A146689E-32D5-11E4-B3BB-BD2DC4D60FE0-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/256339>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> In the --auto code path, gc_before_repack() is called once in parent
>> process then again in the forked process. Stop the second run.
>
> Hmph.  Is the true reason why this happens because we have two calls
> to gc_before_repack() in the main, and one is before daemonize()?
> Shouldn't this protection be in the caller?

Actually, I think the function already is protecting wastage of
getting called twice by saying "I've done pack-refs already" and
"I've done prune-reflogs already" by setting the two variables to
zero.  Isn't that sufficient?

What problem is this patch trying to fix?

>> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gm=
ail.com>
>> ---
>>  builtin/gc.c | 5 +++++
>>  1 file changed, 5 insertions(+)
>>
>> diff --git a/builtin/gc.c b/builtin/gc.c
>> index 8d219d8..fb0cff3 100644
>> --- a/builtin/gc.c
>> +++ b/builtin/gc.c
>> @@ -261,6 +261,11 @@ static const char *lock_repo_for_gc(int force, =
pid_t* ret_pid)
>> =20
>>  static int gc_before_repack(void)
>>  {
>> +	static int nr_runs;
>> +
>> +	if (nr_runs++)
>> +		return 0;
>> +
>>  	if (pack_refs && run_command_v_opt(pack_refs_cmd.argv, RUN_GIT_CMD=
))
>>  		return error(FAILED_RUN, pack_refs_cmd.argv[0]);
