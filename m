From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 07/25] reflog: avoid constructing .lock path with git_path
Date: Mon, 03 Mar 2014 10:07:57 -0800
Message-ID: <xmqqk3cbrw8y.fsf@gitster.dls.corp.google.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
	<1392730814-19656-8-git-send-email-pclouds@gmail.com>
	<xmqqr46q4xt6.fsf@gitster.dls.corp.google.com>
	<CACsJy8A3mGCJzacaVrVUSxJnqXZ=GUhgOzpheUixpyWtYE6gDw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>
To: Duy Nguyen <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Mon Mar 03 19:08:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WKXHu-00033f-Eo
	for gcvg-git-2@plane.gmane.org; Mon, 03 Mar 2014 19:08:26 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753990AbaCCSIT convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 3 Mar 2014 13:08:19 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:38529 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752726AbaCCSIR convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Mon, 3 Mar 2014 13:08:17 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 618FB707E1;
	Mon,  3 Mar 2014 13:08:02 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; s=sasl; bh=oFmQohZXNnjI
	7KNoHA6mbWCFB6Y=; b=b0ziN0jFArwnUXUIb1eA/DoCFcHClr5EyP8iBR/Yvwo1
	LIpR6ZJtZElBEGhewNZqlEF7QEEoC5+k+vQ1ZW6BdmilcE0/63j1I6IdbZ1b1ctH
	nd6+7QhqaTVhsLeQKQYwKIS0d/v4sWKIavg/v8/uk+WxAM8dT8BxLpnYoQlM1ZA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type:content-transfer-encoding; q=dns; s=sasl; b=jqXA0i
	Nlfv6t35wvp/VhScXpX/dIdSUpfdZFvt638cOTeufcSLZ1nOubUlldGPJNP8UqDY
	Jg/8XgDea5LQpa6I00gLNQQc34ht3kvIBgIFdcNLi4WLjhLHl0et4SgQWKbuoVOd
	GCkd5pRRPJ+vxXc81RvLQTelywkeBmUuAG9c4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 0258F707D9;
	Mon,  3 Mar 2014 13:08:02 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 53BFE707D7;
	Mon,  3 Mar 2014 13:08:00 -0500 (EST)
In-Reply-To: <CACsJy8A3mGCJzacaVrVUSxJnqXZ=GUhgOzpheUixpyWtYE6gDw@mail.gmail.com>
	(Duy Nguyen's message of "Sat, 1 Mar 2014 10:42:51 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: C187A792-A2FE-11E3-9F25-8D19802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243241>

Duy Nguyen <pclouds@gmail.com> writes:

> On Wed, Feb 26, 2014 at 5:44 AM, Junio C Hamano <gitster@pobox.com> w=
rote:
>> Nguy=E1=BB=85n Th=C3=A1i Ng=E1=BB=8Dc Duy  <pclouds@gmail.com> write=
s:
>>
>>> git_path() soon understands the path given to it. Some paths "abc" =
may
>>> become "def" while other "ghi" may become "ijk". We don't want
>>> git_path() to interfere with .lock path construction. Concatenate
>>> ".lock" after the path has been resolved by git_path() so if "abc"
>>> becomes "def", we'll have "def.lock", not "ijk".
>>
>> Hmph.  I am not sure if the above is readable (or if I am reading it
>> correctly).
>
> Definitely not now that I have had my break from the series and rerea=
d it.
>
>> If "abc" becomes "def", it would take deliberate work to make
>> "abc.lock" into "ijk", and it would be natural to expect that
>> "abc.lock" would become "def.lock" without any fancy trick, no?
>
> A better explanation may be, while many paths are not converted by
> git_path() ("abc" -> "abc"), some of them will be based on the given
> path ("def" -> "ghi"). Giving path def.lock to git_path() may confuse
> it and make it believe def.lock should not be converted because the
> signature is "def.lock" not "def". But we want the lock file to have
> the same base name with the locked file (e.g. "ghi.lock", not
> "def.lock"). So it's best to append ".lock" after git_path() has done
> its conversion.
>
> The alternative is teach git_path about ".lock", but I don't really
> want to put more logic down there.

I think your attempt to sound generic by using "abc", "def",
etc. backfired and made the description only obscure.  It would have
been immediately understandable if it were more like this:

	Among pathnames in $GIT_DIR, e.g. "index" or "packed-refs",
	we want to automatically and silently map some of them to
	the $GIT_DIR of the repository we are borrowing from via
	$GIT_COMMON_DIR mechanism.  When we formulate the pathname
	for its lockfile, we want it to be in the same location as
	its final destination.  "index" is not shared and needs to
	remain in the borrowing repository, while "packed-refs" is
	shared and needs to go to the borrowed repository.

	git_path() could be taught about the ".lock" suffix and map
	"index.lock" and "packed-refs.lock" the same way their
	basenames are mapped, but instead the caller can help by
	asking where the basename (e.g. "index") is mapped to
	git_path() and then appending ".lock" after the mapping is
	done.

Thanks for an explanation.  With that understanding, the patch makes
sense.

=09
