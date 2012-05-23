From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <rene.scharfe@lsrfire.ath.cx>
Subject: Re: [PATCH 3/3] refs: use strings directly in find_containing_dir()
Date: Wed, 23 May 2012 19:15:34 +0200
Message-ID: <4FBD1B36.5060404@lsrfire.ath.cx>
References: <1337692566-3718-1-git-send-email-mhagger@alum.mit.edu> <4FBBE012.6090702@lsrfire.ath.cx> <7vlikj3nzc.fsf@alter.siamese.dyndns.org> <4FBC0F12.2000001@lsrfire.ath.cx> <7vhav73lnl.fsf@alter.siamese.dyndns.org> <4FBD0E33.4060309@lsrfire.ath.cx> <7v4nr625vf.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: mhagger@alum.mit.edu, Jeff King <peff@peff.net>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 23 19:15:50 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SXFA2-0004T1-EZ
	for gcvg-git-2@plane.gmane.org; Wed, 23 May 2012 19:15:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933050Ab2EWRPl convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 23 May 2012 13:15:41 -0400
Received: from india601.server4you.de ([85.25.151.105]:33203 "EHLO
	india601.server4you.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932155Ab2EWRPk (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 May 2012 13:15:40 -0400
Received: from [192.168.2.105] (p579BE06F.dip.t-dialin.net [87.155.224.111])
	by india601.server4you.de (Postfix) with ESMTPSA id 6ADD42F8058;
	Wed, 23 May 2012 19:15:38 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:12.0) Gecko/20120428 Thunderbird/12.0.1
In-Reply-To: <7v4nr625vf.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198314>

Am 23.05.2012 18:56, schrieb Junio C Hamano:
> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>  writes:
>=20
>> Am 23.05.2012 00:18, schrieb Junio C Hamano:
>>> Ren=C3=A9 Scharfe<rene.scharfe@lsrfire.ath.cx>   writes:
>>>
>>>> What has git grep to do with refs?  It checks if the path in the c=
ommand
>>>> above is a ref, which makes it iterate over all of them..
>>>
>>> Do you mean:
>>>
>>> 	/* Is it a rev? */
>>>           get_sha1()
>>>           ->   ...
>>>             ->   get_sha1_basic()
>>>               ->   dwim_ref()
>>>
>>> callpath?
>>
>> Yes, indeed.  Hmm, this is done even if the paths come after a
>> double-dash.  Anyway, I don't consider the check to be a performance
>> issue, just a quick way to test the allocation count that i stumbled
>> upon while working on the recent grep patches.
>=20
> I was merely reacting "iterate over all of them"; dwim_ref() only che=
cks
> if .git/blah, .git/refs/heads/blah, .git/refs/tags/blah, etc.  exists=
 and
> the number of checks do not depend on the number of refs you have, so=
 I
> was wondering if I overlooked something that does for_each_ref() of
> everything.

Yeah, for loose refs that's true. However, I have 470 packed refs, and
this command:

	$ valgrind --tool=3Dexp-dhat ./git grep guess xdiff/xutils.c

reports (among other findings):

=3D=3D28255=3D=3D max-live:    30,334 in 470 blocks
=3D=3D28255=3D=3D tot-alloc:   30,334 in 470 blocks (avg size 64.54)
=3D=3D28255=3D=3D deaths:      none (none of these blocks were freed)
=3D=3D28255=3D=3D acc-ratios:  7.76 rd, 0.95 wr  (235,582 b-read, 28,92=
4 b-written)
=3D=3D28255=3D=3D    at 0x402AEE8: malloc (in /usr/lib/valgrind/vgprelo=
ad_exp-dhat-x86-linux.so)
=3D=3D28255=3D=3D    by 0x813691D: xmalloc (wrapper.c:50)
=3D=3D28255=3D=3D    by 0x8106B1A: create_ref_entry.constprop.8 (refs.c=
:250)
=3D=3D28255=3D=3D    by 0x8107761: read_packed_refs (refs.c:817)
=3D=3D28255=3D=3D    by 0x810785F: get_packed_refs (refs.c:843)
=3D=3D28255=3D=3D    by 0x8107BE7: resolve_ref_unsafe (refs.c:1028)
=3D=3D28255=3D=3D    by 0x81090AA: dwim_ref (refs.c:1549)
=3D=3D28255=3D=3D    by 0x8122E06: get_sha1_1 (sha1_name.c:304)
=3D=3D28255=3D=3D    by 0x81237EF: get_sha1_with_context_1 (sha1_name.c=
:1044)
=3D=3D28255=3D=3D    by 0x8124016: get_sha1 (cache.h:795)
=3D=3D28255=3D=3D    by 0x75782F65: ???

Ren=C3=A9
