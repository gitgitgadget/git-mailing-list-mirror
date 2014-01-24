From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 0/9] About the trailing slashes
Date: Fri, 24 Jan 2014 11:22:09 -0800
Message-ID: <xmqqk3dprxr2.fsf@gitster.dls.corp.google.com>
References: <1390483326-32258-1-git-send-email-pclouds@gmail.com>
	<1390570836-20394-1-git-send-email-pclouds@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, pawel.sikora@agmk.net, Jens.Lehmann@web.de
To: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Fri Jan 24 20:22:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W6mKc-0002a4-QU
	for gcvg-git-2@plane.gmane.org; Fri, 24 Jan 2014 20:22:23 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752546AbaAXTWQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Jan 2014 14:22:16 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:48302 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752127AbaAXTWP convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Fri, 24 Jan 2014 14:22:15 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C2A3C6468D;
	Fri, 24 Jan 2014 14:22:14 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=MO6CcORDP8RM
	tgHQuPVyIqmfTRs=; b=mF47BGrHOoK/nR8oRcyNqyYAuIi3V8LX1EN01dtZYmAi
	GqSfQ70Ua35frSo/4K3vBmtZjUvbzs29LavERAg5lidJQK5zbfUV7rMn+As1i4L4
	JrQNym3yLslEzDWhA7u+v5i0l27nixaKlCHImKqRQtRLRbIGoVi+Lh8yaFGhnpQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=kadaHU
	v9xEujKIHKzfT2r9OAhq1JYvx2DhyWUTQT72hM0jN7zI6UV/+I6DM/P/S3AZ/gcC
	Q7CuSW2SxE9jH4jN1meGzojBOqTmu6ZSX/tqEibqbQ+kZT0lGGi2h0goqAqeAgm4
	G96KDbvPAOWGV3CN3KcEmjxa1CMRIaLGtF1j4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AFC636468C;
	Fri, 24 Jan 2014 14:22:14 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 80B1964686;
	Fri, 24 Jan 2014 14:22:13 -0500 (EST)
In-Reply-To: <1390570836-20394-1-git-send-email-pclouds@gmail.com>
 (=?utf-8?B?Ik5ndXnhu4VuCVRow6FpIE5n4buNYw==?= Duy"'s message of "Fri, 24
 Jan 2014 20:40:27 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D422E708-852C-11E3-8A0B-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241022>

Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> writes:

> While looking at this, I found a funny behavior of fill_directory.
>
>   $ git init
>   $ mkdir b
>   $ >b/c
>   $ >b/d
>   $ git status b
>   Untracked files:
>           b/
>   $ git status b/
>   Untracked files:
>           b/c b/d
>
> Notice how the trailing slash produces different untracked listing.
> This is because of common_prefix_len(). In the "b" case,
> common_prefix_len() returns empty prefix, so read_directory reads top
> directory, traverses through, reaches "b" and eventually calls
> treat_directory() on it, which results in "b/" in the output.
>
> In the "b/" case, common_prefix_len() found the prefix "b", so
> read_directory() starts at "b" instead of b's parent.
> treat_directory() is never called on "b" itself, which results in
> "b/c" and "b/d".

Hmm, this feels like a borderline case.

If the user asked "git status ?", or even "git status '?'", it seems
to me that the user wanted to get "git status" output but with a
scope limited to top-level entries with a single letter.  And the
unlimited output asks to consolidate output for directories that
have nothing interesting.  "git status b" and "git status '[b]'" are
asking similar thing, but not just limiting the scope to any one
letter but to 'b'.  So the output you showed above looks correct to
me.  On the other hand, the other request "git status b/" seems to
me that the user is very aware that 'b' is a directory and wants to
look inside, so again the output you showed looks correct to me.

How does "git status '[b]/'" behave?
