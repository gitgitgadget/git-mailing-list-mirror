From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] exclude: do strcmp as much as possible before
 fnmatch
Date: Sat, 26 May 2012 23:51:57 -0700
Message-ID: <7vk3zyp14i.fsf@alter.siamese.dyndns.org>
References: <1338035474-4346-1-git-send-email-pclouds@gmail.com>
 <1338035474-4346-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Sun May 27 08:52:11 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SYXKl-0002IT-50
	for gcvg-git-2@plane.gmane.org; Sun, 27 May 2012 08:52:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751488Ab2E0GwB convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sun, 27 May 2012 02:52:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:40388 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750798Ab2E0GwA convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Sun, 27 May 2012 02:52:00 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C4AAD455E;
	Sun, 27 May 2012 02:51:59 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=zsXQh+olhrdA
	OvXaehLuE14L1YM=; b=kJixdDawwveBuKwoaQQjl2Y2t/FhSTuawZd9LhIrrZPN
	6RNrvPeAuyZKARH8OZgjKfpw2doqgF18GDEJn5S/ZuHDQMDV2HzAEmjRfwGC30a8
	T2UeW54/1O9d0UmUR0pL1msgIRtXHTAH9JMj1vlZauqA/7ZyWAVGPN7bqkGqcNQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=mj7og9
	zogamS2GJaNAfFvMOVqpmWGoKCdoabnj32S/1J91Hr1hSpzDmVhrQ1yoDLZ4s6z4
	sS1WAMi1jugwgUsa+i1rCzjdyv5+zf7PEROZZD1BC5tk8yoCtk4l3A5ym8RWTzYm
	AUyMQ160zM+CPmLvPyWFST6lsqSKrhTkHARnk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id B9E33455D;
	Sun, 27 May 2012 02:51:59 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4F14B455C; Sun, 27 May 2012
 02:51:59 -0400 (EDT)
In-Reply-To: <1338035474-4346-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Sat, 26 May
 2012 19:31:13 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 74D6A188-A7C8-11E1-A871-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/198580>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> this also avoids calling fnmatch() if the non-wildcard prefix is
> longer than basename
>
> Signed-off-by: Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy <pclouds@gma=
il.com>
> ---

I have been wondering if you can take a different approach based on the
same observation this patch is based on.  If you see an entry /foo/bar/=
*.c
in the top-level .gitignore, perhaps you can set it aside in a differen=
t
part of "struct exclude" for the top-level directory (because the patte=
rn
will never match outside foo/bar directory), so that it is not even use=
d
for matching, and only when you descend to foo/bar directory, add "/*.c=
"
to the "struct exclude" you create for that directory.

That way, instead of "strcmp is faster than fnmatch, but we always comp=
are
all elements in the huge pattern list given at the toplevel", you would=
 be
doing "we do not even bother to compare with the elements we know do no=
t
matter", which would be far more efficient, no?
