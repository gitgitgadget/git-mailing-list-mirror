From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs` config option
Date: Tue, 09 Feb 2016 18:04:45 -0800
Message-ID: <xmqqtwlhz5fm.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-4-git-send-email-sbeller@google.com>
	<20160209223400.GI28749@google.com>
	<CAGZ79kazD22FLv19CvmG+-dzGEP-uwr=fC_1VXB=sdzPBU_uww@mail.gmail.com>
	<xmqqy4atz7u0.fsf@gitster.mtv.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 03:05:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTK9K-0006bb-J6
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 03:04:58 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756668AbcBJCEz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 21:04:55 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:58021 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1756129AbcBJCEy (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 21:04:54 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2449944F9D;
	Tue,  9 Feb 2016 21:04:53 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ZPY8lkZ5nLFYdkfEHgaKqGLvyoQ=; b=gKbWX8
	gIWwV6tLFV65A/7jrHkEePjnbixuzw0clD/1v8zT796h4sKf6zTQ+ZhiA7QAYJ6O
	s8vIP8IAiggs+3SyrDIS9CzgQxeCdV+z/Sa+oKiDYutjBCCwK2XvERwI/O+S0miC
	NoDuEUCxZ1rkRo37r9KwyTg75+uoBSL6tUFeM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=n6wBQqPxkXvgNM6jPbXyBG6uvyGvgIIC
	i6Uvo4QwjPrG2FuHjF16PMcKaH18g1XmW2EnwBIxiSJNVqZqVx1youDwkgbixD6a
	e8e0JHl2m2MKz4U9IeyPE9mnm2J/ZLHgWoULeXFLjqlYQ9gheDKNO5tja/DaRh+f
	FywxXsP7B9E=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 1C52944F9C;
	Tue,  9 Feb 2016 21:04:53 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 8835044F9B;
	Tue,  9 Feb 2016 21:04:52 -0500 (EST)
In-Reply-To: <xmqqy4atz7u0.fsf@gitster.mtv.corp.google.com> (Junio C. Hamano's
	message of "Tue, 09 Feb 2016 17:12:55 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: AC34ACDA-CF9A-11E5-8883-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285889>

Junio C Hamano <gitster@pobox.com> writes:

> I actually do not think we mind git_parse_int(), git_parse_long(),
> and git_parse_uint() to complement git_parse_ulong().  I am not
> enthused by the "nonnegative-int" thing, though.
>
> Do we have enough cases where we want to use signed type and reserve
> negative value for our own internal use (e.g. "unspecified yet")?
> If not, a very generic git_config_int() with a caller specific range
> check wouldn't look _so_ bad.
>
> 	parallel_jobs = git_config_int(var, val);
>         if (parallel_jobs < 0)
> 	     	some corrective action;
> 	return 0;

And of course, if we _do_ have many callsites where the caller wants
a sub-range of the range allowed by the underlying type, we can have

 	<T> git_config_<T>_bounded(var, val, <T> lb, <T> ub)

where T are the usual integral types and lb and ub are (inclusive)
lower and upper bounds.  With that, Jonathan's non-negative-int
would fall out as a natural consequence:

	parallel_jobs = git_config_int_bounded(var, val, 0, INT_MAX);

I vaguely recall that Michael Haggerty had a series to add and use
helpers to parse values of integral types and something like that
interface was suggested in the discussion; and it may even have used
a word better than "bounded".
