From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Question about the revision walking API
Date: Tue, 06 Jan 2015 02:24:58 -0800
Message-ID: <xmqq4ms4qk91.fsf@gitster.dls.corp.google.com>
References: <20150106020230.GA28274@glandium.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Mike Hommey <mh@glandium.org>
X-From: git-owner@vger.kernel.org Tue Jan 06 11:26:51 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Y8RJy-0003Bn-Ck
	for gcvg-git-2@plane.gmane.org; Tue, 06 Jan 2015 11:25:06 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754677AbbAFKZC (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 Jan 2015 05:25:02 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:58044 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754243AbbAFKZB (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 Jan 2015 05:25:01 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 75AE024DA1;
	Tue,  6 Jan 2015 05:25:00 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=fZAKEwBuWscTdVmpez+C+b+/Fpg=; b=UiadtU
	h2qXo++cUE5mxzX48FXVzwSwwPeGSHMDphUtfM9uAE4TFhuPQSupGBMPcD33f4bo
	n/jH5SeBStzZEVnCPaV/nRC3mEY7kxqCX5jNG2qQfI65E7hDfIfWXCIjvPhuMTs4
	jpCSEd2FzFJ+J1YaOoJqXej/c9eTUU1jIcJOQ=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=He0O/KkaZFxH/aG837VYFgKoMYXCsuAD
	y0wayRVRJJpq0hMQNLuK5hf1c/bD3b2Lk0ZQn/feZIhObAoEBywtOiZ8gBDGOhlL
	i4hTpdbK84532yzGaUFp+cWx7bNY4bsFxe/TSB+TtF0B5cVCkiSswIXzKUmozkv+
	PXq48YnJE6Q=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3D50024D9F;
	Tue,  6 Jan 2015 05:25:00 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id B21E624D9E;
	Tue,  6 Jan 2015 05:24:59 -0500 (EST)
In-Reply-To: <20150106020230.GA28274@glandium.org> (Mike Hommey's message of
	"Tue, 6 Jan 2015 11:02:30 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 44A2F046-958E-11E4-A112-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/262051>

Mike Hommey <mh@glandium.org> writes:

> I would like to know if the revision walking API works as one would
> expect with a calling sequence like the following:
>
> - init_revisions
> - add_pending_object/setup_revisions
> - prepare_revision_walk
> - get_revision (repeated)
> - reset_revision_walk (I guess)

Around here you would need to clear flag bits left on the objects by
your previous traversal.  After "git log A..B", commits in that
range would have various combinations of SEEN, ADDED and SHOWN
flags, and also some commits reachable from A would be marked as
UNINTERESTING.  You do not want these to interfere with your next
traversal which may not have anything to do with what you computed
with the previous round.

> - add_pending_object
> - prepare_revision_walk
> - get_revision (repeated)
