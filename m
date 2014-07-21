From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/4] use strbuf_getcwd() to get the current working directory without fixed-sized buffers
Date: Mon, 21 Jul 2014 12:02:59 -0700
Message-ID: <xmqqsiluilgc.fsf@gitster.dls.corp.google.com>
References: <53CBF277.3090101@web.de> <53CBF332.2050301@web.de>
	<20140721023312.GC22750@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 21 21:03:30 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X9Irv-0006Uo-VE
	for gcvg-git-2@plane.gmane.org; Mon, 21 Jul 2014 21:03:28 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933497AbaGUTDJ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 21 Jul 2014 15:03:09 -0400
Received: from smtp.pobox.com ([208.72.237.35]:52884 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S933447AbaGUTDH convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 21 Jul 2014 15:03:07 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9C5DB29BC9;
	Mon, 21 Jul 2014 15:03:06 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=GFvvRS5Nez3g
	JRwG+FjG6989Bn4=; b=I6JMP5/qnwBZaSNVZlIRr9JAsmEZXXvTc7vCOsWdnn34
	CJvQAHnzbWRRAj8qAL2IsFO1LnToGX2sQ3716PspZA0wqYw4fO8MWyJlLtX+Szkp
	Lpx+avKEgQoHdCnP0XF2NGONv3ZLZ4GZ4RKDvt5137nDSGUkfdnS19Db38oMaog=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=TGAKnl
	Uh9TARz6EVpbS7G7dRpnxXRttpMOzAtU5RVseh38Ws8wQ2ZNtIm70AtBSacXLxy6
	/oOJqxdfjZzVvYQRSUOTtU1MCNoz4yey7g+keX5X+aVu9R9HFQudyOYGy2nTyh5W
	QaiynJX18UivhPMzYtT8ULAUnKt4VC0dHZ8Lg=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DEDF29BC8;
	Mon, 21 Jul 2014 15:03:06 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9E4EC29BB6;
	Mon, 21 Jul 2014 15:03:00 -0400 (EDT)
In-Reply-To: <20140721023312.GC22750@peff.net> (Jeff King's message of "Sun,
	20 Jul 2014 22:33:12 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: A289E106-1109-11E4-B76D-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253989>

Jeff King <peff@peff.net> writes:

> On Sun, Jul 20, 2014 at 06:49:54PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> diff --git a/builtin/init-db.c b/builtin/init-db.c
>> index 56f85e2..c4958b6 100644
>> --- a/builtin/init-db.c
>> +++ b/builtin/init-db.c
>> @@ -535,10 +535,10 @@ int cmd_init_db(int argc, const char **argv, c=
onst char *prefix)
>>  		usage(init_db_usage[0]);
>>  	}
>>  	if (is_bare_repository_cfg =3D=3D 1) {
>> -		static char git_dir[PATH_MAX+1];
>> -
>> -		setenv(GIT_DIR_ENVIRONMENT,
>> -			getcwd(git_dir, sizeof(git_dir)), argc > 0);
>> +		struct strbuf cwd =3D STRBUF_INIT;
>> +		strbuf_getcwd(&cwd);
>> +		setenv(GIT_DIR_ENVIRONMENT, cwd.buf, argc > 0);
>> +		strbuf_release(&cwd);
>
> Hmm. You are not making anything worse here, as we already do not che=
ck
> the return value of getcwd. But what happens if it fails? Looks like =
we
> currently get a segfault, and the new code will silently set the
> variable to the empty string. Neither is particularly helpful.
>
> Should we be using the xgetcwd helper that you add in the next patch?
>
>> -			setenv(GIT_DIR_ENVIRONMENT, getcwd(git_dir, sizeof(git_dir)), 0)=
;
>> +			strbuf_getcwd(&cwd);
>> +			setenv(GIT_DIR_ENVIRONMENT, cwd.buf, 0);
>> +			strbuf_release(&cwd);
>
> Ditto here.

Good eyes.
