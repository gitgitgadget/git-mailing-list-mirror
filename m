From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 01/15] string_list: add string_list_duplicate
Date: Wed, 27 Apr 2016 14:11:54 -0700
Message-ID: <xmqqzise7o4l.fsf@gitster.mtv.corp.google.com>
References: <1461703833-10350-1-git-send-email-sbeller@google.com>
	<1461703833-10350-2-git-send-email-sbeller@google.com>
	<xmqqh9eoc7zc.fsf@gitster.mtv.corp.google.com>
	<CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Jonathan Nieder <jrnieder@gmail.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Duy Nguyen <pclouds@gmail.com>
To: Stefan Beller <sbeller@google.com>
X-From: git-owner@vger.kernel.org Wed Apr 27 23:12:03 2016
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1avWkc-0006xF-6E
	for gcvg-git-2@plane.gmane.org; Wed, 27 Apr 2016 23:12:02 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752977AbcD0VL6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 27 Apr 2016 17:11:58 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:56877 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752353AbcD0VL5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 27 Apr 2016 17:11:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 69BA1168A3;
	Wed, 27 Apr 2016 17:11:56 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=pRojkG+Yt/5OhbEbb1cxDH8OGfc=; b=owisEv
	vnHyNA0qKHqGR1dJ3EfpWZQeqnL8Yqvr4gipCS3ni4Ao1ahIN15QGcyEPsl83KaA
	RQRv+2wAah0tDjT8AQPM1rxn2kCDAdz0hGdsWN3TfyWKPVfMfjCMeaws0vq1H+BN
	Wfa33SPwxOlgvVrWSO0HtNVf4mjFjLz+MQK7I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cDy092ZsWNPSxAn+CCIfeHfFxoEB3hNI
	hIYZZOThja84OfTgNLz9J2C5pmV4R8DUF2oXebQ+l9xkupa3SW/4oZlU09JqEpVV
	KpGU1OPLlBnN274pXrysh8M/mI013kQOzYmOp2OqwCseymjoT63TtPYDSNxRMD3l
	Sa9AfO51S3c=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
	by pb-smtp2.pobox.com (Postfix) with ESMTP id 61A99168A2;
	Wed, 27 Apr 2016 17:11:56 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BD717168A1;
	Wed, 27 Apr 2016 17:11:55 -0400 (EDT)
In-Reply-To: <CAGZ79kbWMN3YG5Jtz8i8Y9A3id8bX-YxSWp19+yGAdzMX_wKKA@mail.gmail.com>
	(Stefan Beller's message of "Wed, 27 Apr 2016 11:02:29 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: ABD900CE-0CBC-11E6-80BE-D05A70183E34-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/292826>

Stefan Beller <sbeller@google.com> writes:

> When not duplicating git_config_get_value_multi("submodule.defaultGroup");
> I run into
>
> Program received signal SIGSEGV, Segmentation fault.
> ...
> So the string list seems to be corrupted here.
> Someone stomping over our memory? How long is the result
> of git_config_get_value_multi deemed to be stable and usable?

That call goes to

    git_config_get_value_multi()
    -> git_configset_get_value_multi()
       -> configset_find_element()

the returned value from there would be either NULL or the list of
values that belong to the config cache layer, i.e. a caller of the
API can peek but is not allowed to modify it.

So if you are modifying the value you obtain from the API, you must
make a copy; otherwise you will "stomp over" memory that belongs to
the config cache layer, not to you.
