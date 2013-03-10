From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 6/6] exclude: filter patterns by directory level
Date: Sun, 10 Mar 2013 03:58:13 -0700
Message-ID: <7vmwubcyii.fsf@alter.siamese.dyndns.org>
References: <1362802190-7331-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-1-git-send-email-pclouds@gmail.com>
 <1362896070-17456-7-git-send-email-pclouds@gmail.com>
 <7vtxojd5u7.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun Mar 10 11:58:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UEdxw-0008Hc-KR
	for gcvg-git-2@plane.gmane.org; Sun, 10 Mar 2013 11:58:56 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751280Ab3CJK6W convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 10 Mar 2013 06:58:22 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:35908 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751145Ab3CJK6V convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 10 Mar 2013 06:58:21 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 80E6BB080;
	Sun, 10 Mar 2013 06:58:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=w51nNfHYCULJ
	9cgOM2OxUnNVasA=; b=UJuLj4nhEfQ5B8vqaJzQUPMn6Uzk0xZaDf/a0O3Sp9mj
	p24BYpuqjHCvgFpiifzJO9IU3LoKAILaMDp+ZZDONQG95WlfoXMciwgaMhQPrvHv
	yPP6iamlkrFBChN1+lKgwZ0F19DEnY46XgJfPztZGXihAhqFi+EHo58JashNZxw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=Vcffko
	TOb3yNt4EtdtJjGjguTE1IT17rR92ZpNAPymrIcwmqExT72hDySGLTE0Zv19Zo0B
	oFu7ovlPOrvfCff4GGmc4G7OoXOFeNY9FO1p7Xm34rdUP7GJ2hsROpWo1CCfhu45
	XjDHcgH7HtIKKmc+/pWMTC0qB95zOpf2ALKJo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 76CB7B07F;
	Sun, 10 Mar 2013 06:58:15 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D866BB07B; Sun, 10 Mar 2013
 06:58:14 -0400 (EDT)
In-Reply-To: <7vtxojd5u7.fsf@alter.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 10 Mar 2013 00:20:00 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 68506E68-8971-11E2-AFB6-26A52E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/217797>

Junio C Hamano <gitster@pobox.com> writes:

> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes=
:
>
>> A non-basename pattern that does not contain /**/ can't match anythi=
ng
>> outside the attached directory. Record its directory level and avoid
>> matching unless the pathname is also at the same directory level.
>
> Without defining what a "directory level" is, the above is a bit
> hard to grok, but I think you mean an entry "b/c/*.c" that appears
> in "a/.gitignore" file will want to match a path that is directly
> in "a/b/c" directory (and not in its subdirectories),
> "a/b/x.c" at the two levels deep subdirectory or "a/b/c/d/x.c" that i=
s
> four levels deep will never match the pattern.
>
> The logic feels sound.

Actually, I think you may be able to do a lot more with a simpler
change.  If your top-level .gitignore has "a/b/c/*.c" in it, you
certainly want to mark it not to be applied when you are looking at
paths directly in directory a/b/ because they will never match, but
you also know that nothing will match when you are inside a/b/d/,
even though the pattern and the path you are checking are at the
same levels.  Your dirlen approach will fail for that case, no?

The idea behind prep_exclude() that organizes the exclode patterns
into a stack structure and update the groups near the leaves by
popping those for the old directory we were in and pushing those for
the new directory we are going into is to give us a place to tweak
the elements on the whole stack for optimization when we notice that
we are looking at paths in different directories.  Instead of giving
a "dirlen" member to each element, you could give a "do not look at
me" flag to it, and when you notice that you were in a/b/c/ and now
you are going to look at paths in a/b/d/, you can look at the group
that was read from the .gitignore from the top-level, and mark
entries that cannot be relevant (e.g. "a/b/c/*.c") as such.

The mark does not have to be a boolean.  "a/b/*.c" when you are in
"a/b/c/" can be marked as "This never matches, and I do not have to
re-check until I pop one level".  When digging deeper to "a/b/c/d",
you add one to that.  When switching to "a/b/e", you would first pop
twice ("d" and then "c"), each time decrementing the "I do not have
to re-check" counter by one, and then when pushing "e" down, you
notice that you need to re-check, and mark it again as "no need to
re-check for one pop".  So it is not like you have to re-scan all
entries textually every time you switch directories. Most entries
that are level-limited you would increment or decrement its counter
and only the ones at the level boundary need to be re-checked.

Hmm?
