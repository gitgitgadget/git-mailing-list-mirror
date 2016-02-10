From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv9 3/6] fetching submodules: respect `submodule.fetchJobs` config option
Date: Tue, 09 Feb 2016 17:12:55 -0800
Message-ID: <xmqqy4atz7u0.fsf@gitster.mtv.corp.google.com>
References: <1455051274-15256-1-git-send-email-sbeller@google.com>
	<1455051274-15256-4-git-send-email-sbeller@google.com>
	<20160209223400.GI28749@google.com>
	<CAGZ79kazD22FLv19CvmG+-dzGEP-uwr=fC_1VXB=sdzPBU_uww@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Feb 10 02:13:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1aTJL4-0005l2-6O
	for gcvg-git-2@plane.gmane.org; Wed, 10 Feb 2016 02:13:02 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755229AbcBJBM6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 9 Feb 2016 20:12:58 -0500
Received: from pb-smtp0.int.icgroup.com ([208.72.237.35]:54115 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754700AbcBJBM5 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 9 Feb 2016 20:12:57 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id E7D7744820;
	Tue,  9 Feb 2016 20:12:56 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7KttsRU8LdmVZLElrxr45kVRTtc=; b=vQV/TD
	gc5uJtx0T1+NYZUWNl/q79noS0+OLSAAAOGEi5f3jCHgwh+ySmtCZJ7xxVtD20MX
	tmuXLRPBtGLDg6QuYADSa+8Q27cv3M29B2/gM2RhxmfVgzQzGgRz9qFzGuKnOgL8
	qNohk+ZVHyOcChSJtjEfS+eZTkukt8n2ziVfc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=JLuNJpkbD26Jgc4HhJB2zJak2ljy0lYh
	ehi41r8jcHCH4s/ZY6orgd8TN7OXqS+Iz6ouVohkZIuwg6FxdiKN4lc1nOz/56Y0
	6tO4F3ATabdMJbM+o5UlOGE6ZTUOFhLVR6L/Y9iswUiNZ2/gvpF5Lr/ZBAPpFTd6
	KDlhQFJlHdo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id DF7AE4481F;
	Tue,  9 Feb 2016 20:12:56 -0500 (EST)
Received: from pobox.com (unknown [104.132.0.64])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5E8E14481E;
	Tue,  9 Feb 2016 20:12:56 -0500 (EST)
In-Reply-To: <CAGZ79kazD22FLv19CvmG+-dzGEP-uwr=fC_1VXB=sdzPBU_uww@mail.gmail.com>
	(Stefan Beller's message of "Tue, 9 Feb 2016 16:11:14 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 6ADD8B96-CF93-11E5-8C52-79226BB36C07-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/285888>

Stefan Beller <sbeller@google.com> writes:

>>         int git_config_nonnegative_int(const char *name, const char *value)
>>         {
>>                 int ret;
>>                 if (!git_parse_nonnegative_int(value, &ret))
>>                         die_bad_number(name, value);
>>                 return ret;
>>         }
>>
>> allowing
>>
>>                 parallel_jobs = git_config_nonnegative_int(var, val);
>>                 return 0;
>
> And I thought we wanted to prevent inventing yet another helper?

I actually do not think we mind git_parse_int(), git_parse_long(),
and git_parse_uint() to complement git_parse_ulong().  I am not
enthused by the "nonnegative-int" thing, though.

Do we have enough cases where we want to use signed type and reserve
negative value for our own internal use (e.g. "unspecified yet")?
If not, a very generic git_config_int() with a caller specific range
check wouldn't look _so_ bad.

	parallel_jobs = git_config_int(var, val);
        if (parallel_jobs < 0)
	     	some corrective action;
	return 0;
