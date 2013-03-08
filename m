From: Junio C Hamano <gitster@pobox.com>
Subject: Re: inotify to minimize stat() calls
Date: Thu, 07 Mar 2013 16:04:11 -0800
Message-ID: <7vr4jqkb9g.fsf@alter.siamese.dyndns.org>
References: <7vehgqzc2p.fsf@alter.siamese.dyndns.org>
 <7va9rezaoy.fsf@alter.siamese.dyndns.org>
 <7vsj56w5y9.fsf@alter.siamese.dyndns.org>
 <9AF8A28B-71FE-4BBC-AD55-1DD3FDE8FFC3@gmail.com>
 <CALkWK0mttn6E+D-22UBbvDCuNEy_jNOtBaKPS-a8mTbO2uAF3g@mail.gmail.com>
 <CALkWK0nQVjKpyef8MDYMs0D9HJGCL8egypT3YWSdU8EYTO7Y+w@mail.gmail.com>
 <CACsJy8CEHzqH1X=v4yau0SyZwrZp1r6hNp=yXD+eZh1q_BS-0g@mail.gmail.com>
 <CALkWK0=6_n4rf6AWci6J+uhGHpjTUmK7YFdVHuSJedN2zLWtMA@mail.gmail.com>
 <CACsJy8DeM5--WVXg3b65RxLBS7Jho-7KmcGwWk7B5uAx77yOEw@mail.gmail.com>
 <20130210111732.GA24377@lanh> <20130210112205.GA28434@lanh>
 <7vhaljudos.fsf@alter.siamese.dyndns.org>
 <CACsJy8DnvAjQPL4aP_LRC7aqx6OC4M5dMtj-OUot76qET2z08Q@mail.gmail.com>
 <513911B3.7010903@web.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Duy Nguyen <pclouds@gmail.com>,
	Ramkumar Ramachandra <artagnon@gmail.com>,
	Robert Zeh <robert.allan.zeh@gmail.com>,
	Git List <git@vger.kernel.org>, finnag@pvv.org
To: Torsten =?utf-8?Q?B=C3=B6gershausen?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Fri Mar 08 01:04:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UDkng-0004I4-Mp
	for gcvg-git-2@plane.gmane.org; Fri, 08 Mar 2013 01:04:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758343Ab3CHAEP convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 7 Mar 2013 19:04:15 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39709 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752993Ab3CHAEO convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 7 Mar 2013 19:04:14 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C702BB6A2;
	Thu,  7 Mar 2013 19:04:13 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=bmEzgajA9j5d
	V3afGZ/8JuTu7Nk=; b=psL1gpOmlHhiSYpIhrG3Y5+nxut1bPwRSX1NX1X/qJkJ
	kBvy/UTVYTIAo7aUiaWmGODL2U9WEew+cphks8hpdXwkwa1bQqZjt38ZHOPxjJ1J
	8XteVAkZJ9WSn1vKqjBLdT0FvE73p10oAWkrmLLy58EV3BncZ54VKbnw8fuijT4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=azcGZp
	3Yx8NMdO+TZYQzQWoK6MDhOHpid2n7CUisBFJuYmrl94qf0vqndITivVG3bjqrsv
	vsrM3HEMvpbS8oQe8Da69K0BcD6SrHwaIGwN8brgP4ZAfRVwFkkcVqF6vOYs3TZ8
	9tNOrdMBvHaEpqgJ++w05kE2xvyqcACzoi8og=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B77B0B6A1;
	Thu,  7 Mar 2013 19:04:13 -0500 (EST)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 1D4A4B69F; Thu,  7 Mar 2013
 19:04:13 -0500 (EST)
In-Reply-To: <513911B3.7010903@web.de> ("Torsten =?utf-8?Q?B=C3=B6gershaus?=
 =?utf-8?Q?en=22's?= message of "Thu, 07 Mar 2013 23:16:19 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B592E6BE-8783-11E2-9614-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217633>

Torsten B=C3=B6gershausen <tboegi@web.de> writes:

> diff --git a/builtin/commit.c b/builtin/commit.c
> index d6dd3df..6a5ba11 100644
> --- a/builtin/commit.c
> +++ b/builtin/commit.c
> @@ -1158,6 +1158,8 @@ int cmd_status(int argc, const char **argv, con=
st char *prefix)
>  	unsigned char sha1[20];
>  	static struct option builtin_status_options[] =3D {
>  		OPT__VERBOSE(&verbose, N_("be verbose")),
> +		OPT_BOOLEAN('c', "changed-only", &s.check_changed_only,
> +			    N_("Ignore untracked files. Check if files known to git are m=
odified")),

Doesn't this make one wonder why a separate bit and implementation
is necessary to say "I am not interested in untracked files" when
"-uno" option is already there?
