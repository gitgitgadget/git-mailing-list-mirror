From: Junio C Hamano <gitster@pobox.com>
Subject: Re: smudge filters during checkout & crash consistency
Date: Wed, 12 Nov 2014 10:30:09 -0800
Message-ID: <xmqqk33046ha.fsf@gitster.dls.corp.google.com>
References: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: git@vger.kernel.org
To: Derek Moore <derek.p.moore@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 12 19:30:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XocgO-0000XZ-Bs
	for gcvg-git-2@plane.gmane.org; Wed, 12 Nov 2014 19:30:20 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753244AbaKLSaO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 12 Nov 2014 13:30:14 -0500
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:56394 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753056AbaKLSaN (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 12 Nov 2014 13:30:13 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 0B7E61B06B;
	Wed, 12 Nov 2014 13:30:12 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dD3MuRPmiKdNcKzM+rpajexs6K0=; b=sgBowe
	ypwLR+iqYWTcOQ71sbCt71m2CFvIamvpBxJCJ8DGugcA044eGstSXJoEJy9eH6I2
	2JTItDhuToNQldcdl4A76w/Xy6A/ZhbelfYUmDtoKp73FVQsrsbQkPfd40GHErK1
	8UJrOmIevVGMpxl5cOwpXxC2LZQ8pCm8Xr8fg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rGNUx6DdqpOuu3zPMdBSBQGbIITz5pMB
	DusH+VpsimzXmcmblo6rtd8/7Nj436HMgRZtXh7VGU3J1goqR8zFfjr/PG56E8FN
	MmKJen15ttTMlWrQu2Fm8aIOYmaqIOkvqqmfcOQMo+0ucuJ7FK+7JINpXClfGf7W
	1JCx3jugBMw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 025AC1B06A;
	Wed, 12 Nov 2014 13:30:12 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id 54C381B069;
	Wed, 12 Nov 2014 13:30:11 -0500 (EST)
In-Reply-To: <CAMsgyKbox7e2pv4+_=jG6Ywh3Km2gPsw+Qf6qj-28GWrVg7RZQ@mail.gmail.com>
	(Derek Moore's message of "Wed, 12 Nov 2014 11:46:19 -0600")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: EFCB0AA0-6A99-11E4-8846-42529F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Derek Moore <derek.p.moore@gmail.com> writes:

> I have a case where I would like to smudge files according to the
> reflog information of the switching-to branch.

Don't do that.

When you have branches A, B and C, and a path F is the same between
branches A and B but different in branch C, if you start from branch
C and switch to branch A, F will be updated and obtain your smudge
tailored for "branch A's instance of F".

But if you then switch to B from that state, F will not even be
modified (i.e. it will keep the contents you prepared for "branch
A's instance of F").

In short, do not make clean/smudge depend on anything but blob
contents.
