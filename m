From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 05/10] abspath: convert real_path_internal() to strbuf
Date: Mon, 28 Jul 2014 14:42:13 -0700
Message-ID: <xmqqiomh40ui.fsf@gitster.dls.corp.google.com>
References: <53D694A2.8030007@web.de> <53D6964E.1070100@web.de>
	<20140728191649.GE11265@peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?utf-8?Q?Ren=C3=A9?= Scharfe <l.s.r@web.de>,
	Git Mailing List <git@vger.kernel.org>,
	Karsten Blees <karsten.blees@gmail.com>,
	=?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Mon Jul 28 23:42:28 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XBsgd-0005DH-9V
	for gcvg-git-2@plane.gmane.org; Mon, 28 Jul 2014 23:42:27 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751587AbaG1VmX convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 28 Jul 2014 17:42:23 -0400
Received: from smtp.pobox.com ([208.72.237.35]:65247 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750708AbaG1VmW convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 28 Jul 2014 17:42:22 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id AEC462DD48;
	Mon, 28 Jul 2014 17:42:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=37gOUcxGiUSX
	B8exD8BvvagzQZk=; b=s+E8fIZ9vhiK25fwcBFuRSFss/GlCMh7anZmQoPuWJWt
	p5gT33SzU4InjTfWGIUms5ZL/eZZNeTA4wc9VPso+TaASBdMm466gXyj8Otubb+e
	wLNGivlXtkDJxo2u1MkdgTpqD+8KLJeyL5MbLcL1SitWkFhfHA52etgUultqVq8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=x9+hvl
	qC5k+gRa1/1nVjxHsye1Vi0P5w41zZxqI9Y98QJ5YyqD3nE3Q20WqAZtx/pEW1ns
	aeMsP2inu7BHIoKJ2gp4kGoaE/n3KJWaBORrMVHQ9ggwsRe2qKY4qPqe7QXKJw8k
	hrkleQmDpgF6UWhMJGDnHotr4DjioX9iBdM8Y=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A3CEE2DD47;
	Mon, 28 Jul 2014 17:42:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 189B62DD39;
	Mon, 28 Jul 2014 17:42:15 -0400 (EDT)
In-Reply-To: <20140728191649.GE11265@peff.net> (Jeff King's message of "Mon,
	28 Jul 2014 15:16:49 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 0A4972DE-16A0-11E4-8CC9-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/254356>

Jeff King <peff@peff.net> writes:

> On Mon, Jul 28, 2014 at 08:28:30PM +0200, Ren=C3=A9 Scharfe wrote:
>
>> @@ -60,26 +58,22 @@ static const char *real_path_internal(const char=
 *path, int die_on_error)
>>  			goto error_out;
>>  	}
>> =20
>> -	if (strlcpy(buf, path, PATH_MAX) >=3D PATH_MAX) {
>> -		if (die_on_error)
>> -			die("Too long path: %.*s", 60, path);
>> -		else
>> -			goto error_out;
>> -	}
>> +	strbuf_init(&sb, 0);
>> +	strbuf_addstr(&sb, path);
>
> As with the other patch I just mentioned, should this be strbuf_reset=
,
> not strbuf_init? We want to reset the static buffer back to zero-size=
,
> not throw it away and leak whatever was there.
>
> -Peff

Yes, this one seems to be leaking.

"Next call to the function invalidates the return value the last
caller received" feels like playing with fire.  Most existing
callers are safe in that the first thing they do to the returned
string is xstrdup() it, but we would need to check all the other
callers.

I briefly thought it is not OK for set_git_work_tree(), which gets
new_work_tree, calls real_path() to receive the value from the
function, and then calls real_path() again on it.  The "We've
already done it" optimization is the only thing that makes it safe,
which feels overly fragile.
