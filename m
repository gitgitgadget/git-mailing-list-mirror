From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [RFC PATCH] repack: rewrite the shell script in C.
Date: Wed, 14 Aug 2013 10:26:31 -0700
Message-ID: <7vhaestc8o.fsf@alter.siamese.dyndns.org>
References: <520BAF9F.70105@googlemail.com>
	<1376497661-30714-1-git-send-email-stefanbeller@googlemail.com>
	<CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Stefan Beller <stefanbeller@googlemail.com>,
	git <git@vger.kernel.org>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	=?utf-8?B?Tmd1eeG7hW4gVGg=?= =?utf-8?B?w6FpIE5n4buNYw==?= Duy 
	<pclouds@gmail.com>, iveqy@iveqy.com
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 14 19:26:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V9eqI-0000LH-Md
	for gcvg-git-2@plane.gmane.org; Wed, 14 Aug 2013 19:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760004Ab3HNR0j (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 14 Aug 2013 13:26:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56779 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759464Ab3HNR0i (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 14 Aug 2013 13:26:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 34EA2373AE;
	Wed, 14 Aug 2013 17:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=1sGgoubm6hA2J5q2iF0ycQRd1/Y=; b=lPkwnn
	PLCD1lkdiZgw+3ga3eP2o05UFzFGn2OS5p9cqvOsnLdDQOQHaDjGuN0zxQNh03Wk
	dt1H3YmQ9Z7QmOpXhNRW5xDq1Qz4qmG5uDukWgBpNQ+GNkFZDTJ1XTZL4ATp++ZK
	LkZQwaxv7/oeO3EJczGazAN/zYpA7iLg5gFCw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZIAsy7WaT0GDz0TROwr4dyx8hV9XhpT3
	OJB/6xAJDsbDEDXPYd79QIN6ufExBh8qQYS/YM1eWmU3OZj51sSL50HXH0chmKDP
	oAe1SSxq7NDcjUKbR4atSNtUz+fVhTaL5N2H2bZPnv40LIG0a6hzz4rd1gBps4Sd
	gaAXiTjLOzQ=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A815C373A9;
	Wed, 14 Aug 2013 17:26:35 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6FE13739E;
	Wed, 14 Aug 2013 17:26:33 +0000 (UTC)
In-Reply-To: <CALWbr2xuV+V7M354+XoA3HCvLr0Cpx4t3cLVeTCx4xeNmQQX1w@mail.gmail.com>
	(Antoine Pelisse's message of "Wed, 14 Aug 2013 18:49:58 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AA80D35C-0506-11E3-8657-CA9B8506CD1E-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232302>

Antoine Pelisse <apelisse@gmail.com> writes:

> On Wed, Aug 14, 2013 at 6:27 PM, Stefan Beller
> <stefanbeller@googlemail.com> wrote:
>>  builtin/repack.c               | 410 +++++++++++++++++++++++++++++++++++++++++
>>  contrib/examples/git-repack.sh | 194 +++++++++++++++++++
>>  git-repack.sh                  | 194 -------------------
>
> I'm still not sure I understand the trade-off here.
>
> Most of what git-repack does is compute some file paths, (re)move
> those files and call git-pack-objects, and potentially
> git-prune-packed and git-update-server-info.
> Maybe I'm wrong, but I have the feeling that the correct tool for that
> is Shell, rather than C (and I think the code looks less intuitive in
> C for that matter).
> I'm not sure anyone would run that command a thousand times a second,
> so I'm not sure it would make a real-life performance difference.

I do not think the motivation of this patch is about performance in
the first place, though.

> Last and very less important: I think it's OK to format-patch with -M,
> especially when you move a file.
>
> Cheers,
> Antoine
