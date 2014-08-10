From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v8 0/8] Rewrite `git_config()` using config-set API
Date: Sun, 10 Aug 2014 10:29:18 -0700
Message-ID: <xmqqppg88d8x.fsf@gitster.dls.corp.google.com>
References: <1407336792-16962-1-git-send-email-tanayabh@gmail.com>
	<vpqy4v1vdui.fsf@anie.imag.fr>
	<xmqq8un0ktqu.fsf@gitster.dls.corp.google.com>
	<vpq61i4nld7.fsf@anie.imag.fr>
	<xmqqoavwjb3i.fsf@gitster.dls.corp.google.com>
	<53E4D986.6040708@gmail.com> <53E4DF6D.8070904@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Tanay Abhra <tanayabh@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Aug 10 19:29:32 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XGWvz-0000EZ-SD
	for gcvg-git-2@plane.gmane.org; Sun, 10 Aug 2014 19:29:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751407AbaHJR32 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 10 Aug 2014 13:29:28 -0400
Received: from smtp.pobox.com ([208.72.237.35]:56967 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751249AbaHJR31 (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 10 Aug 2014 13:29:27 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id BCE402F822;
	Sun, 10 Aug 2014 13:29:26 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=NJ8Q9PqS15LFVJc8PAkJYlPyI3E=; b=lDZ0tM
	SaYo705/tdZ1i+UwTArhXkV0m1HOX8HnKYsUQZ7WHerQeMbuYaBYbgQHqujmk92D
	qmM7mmuQXNP8LzpF9iCdo2f0gaScIbv8hReX4/ew93BqMpZKLYHU/k8Ue2Ynh24N
	EkAZgNkV6wBNXOw0gsi+/b7RxEfdzjaZjkZzM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Nk9+vnh/b47whpJ9vz3K8BbMfmSPZFnd
	K/t4AjaVYnM0JrhEW5+HAid8444lkOdb2XaD898z1ldcDGh92aErZS+hTz9C8ezY
	MYG6md/4gRtmC1Dm9KTetwImrijBWt8oEhXds/qDo5shE6J7/T0K3Fx1aF3Fu8Yg
	vL5le/AM8CE=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id A953B2F820;
	Sun, 10 Aug 2014 13:29:26 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id D2F6E2F817;
	Sun, 10 Aug 2014 13:29:19 -0400 (EDT)
In-Reply-To: <53E4DF6D.8070904@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Fri, 08 Aug 2014 15:32:13 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: DC8317F6-20B3-11E4-8602-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/255098>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On 08/08/14 15:07, Tanay Abhra wrote:
> ...
>> (cc to Ramsay)
>> 
>> The discussion in both threads (v8 and v9), boils down to this,
>> is the `key_value_info` struct really required to be declared public or should be
>> just an implementation detail. I will give you the context,
>
> No, this is not the issue for me. The patch which introduces the
> struct in cache.h does not make use of that struct in any interface.
> It *is* an implementation detail of some code in config.c only.
>
> I do not know how that structure will be used in future patches. ;-)

It is debatable if it is a good API that tells the users "In the
data I return to you, there is a structure hanging there with these
two fields. Feel free to peek into it if you need what is recorded
in them".  But the contract between the the endgame "API" and its
callers can include such a direct access, and then you can say that
it is a part of the API, not just an implementation detail.

I think you and Tanay are both right (and I am wrong ;-).

You are right in that the "API" is giving more than the callers
converted to it at this point in the series.

Tanay is right in that the way the struct will be used, which is
illustrated by the example in the message you are responding to,
should be in the part of this series that gives the implementation
of the API before presenting the converted users, as the series
deems it part of the API to let the users peek into the struct.

It may turn out that we have to abstract it further when we need a
more elaborate data structure kept in the kv-info in the future.  At
that point it will become undesirable to keep giving the callers
direct access to it, because direct struct access means that the
particular aspect of the implementaiton detail will be cast in stone
and would not allow to be replaced with some other representation
that is more efficient for the implementation.

But as I said, what we see in this series can do for now.  The
future can come later ;-)
