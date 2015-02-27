From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] index-pack: kill union delta_base to save memory
Date: Fri, 27 Feb 2015 13:18:58 -0800
Message-ID: <xmqqzj7zhx31.fsf@gitster.dls.corp.google.com>
References: <1424397488-22169-1-git-send-email-pclouds@gmail.com>
	<1424947928-19396-1-git-send-email-pclouds@gmail.com>
	<1424947928-19396-3-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, msporleder@gmail.com
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Feb 27 22:19:18 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YRSJZ-0008D3-9t
	for gcvg-git-2@plane.gmane.org; Fri, 27 Feb 2015 22:19:17 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754787AbbB0VTM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 27 Feb 2015 16:19:12 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58655 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754632AbbB0VTL convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 27 Feb 2015 16:19:11 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 5AF9F3B304;
	Fri, 27 Feb 2015 16:19:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=lCldYAIkDuou
	dNtss/uFCX+oJ88=; b=aKIxN9aO7fKKjkw9MuaD+akw4sZwip+otJhPilf7PT0b
	FXPRToDNBJxLG3x6SJ+datBF/Zm5hZDWoLCpetystNo+gD7P1mHgPkb6mnFEkoW9
	3/3zJl4vP+uc0aG4l9ecs4V+9wEEyclM+/vjgzgdSFon6q9ToS7dWGbZMHPLv8A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=u9k0Nv
	NcVCx4VUaGZ5RmGN8TyKr0rfX/vffoketrKE+SMI6iKLPQwhV5F5Uem80EYSb+9B
	4IKO6PX2K0plSOOyPlYLXgvkr1mVy3/YFP7G3cMYKdU6tlIi+NJdhuG7FarzbhHb
	4w8VsNJKQaiwh8mcGiQp63v9p1C4VRGDKtuwA=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 534703B303;
	Fri, 27 Feb 2015 16:19:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 6B71E3B2FA;
	Fri, 27 Feb 2015 16:18:59 -0500 (EST)
In-Reply-To: <1424947928-19396-3-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Thu, 26
 Feb 2015 17:52:08 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 41CAD080-BEC6-11E4-92C0-29999F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264507>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> Notice that with "recent" Git versions, ofs-delta objects are
> preferred over ref-delta objects and ref-delta objects have no reason
> to be present in a clone pack.

It is true that we try to use ofs-delta as much as possible, but
where does "have no reason to be present" come from?

When an object cannot be represented as an ofs-delta (which can only
refer backwards), don't we use ref-delta, instead of storing it as a
deflated-full object?

Probably "Not so ancient versions of Git tries to use ofs-delta
encoding whenever possible, so it is expected that objects encoded
using ref-delta are minority" may be closer to the truth.  And that
observation does justify why using two separate pools (one with
8-byte entries for ofs-delta, the other with 20-byte entries for
ref-delta) is a better idean than using one pool with 20-byte
entries for both kinds.
