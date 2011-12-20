From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Debugging git-commit slowness on a large repo
Date: Mon, 19 Dec 2011 17:21:03 -0800
Message-ID: <7vehw0kphc.fsf@alter.siamese.dyndns.org>
References: <CB0BCE02.2CD42%joshua.redstone@fb.com>
 <CB1518AB.2D649%joshua.redstone@fb.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Nguyen Thai Ngoc Duy <pclouds@gmail.com>,
	Carlos =?utf-8?Q?Mart=C3=AD?= =?utf-8?Q?n?= Nieto 
	<cmn@elego.de>, Tomas Carnecky <tom@dbservice.com>,
	"git\@vger.kernel.org" <git@vger.kernel.org>
To: Joshua Redstone <joshua.redstone@fb.com>
X-From: git-owner@vger.kernel.org Tue Dec 20 02:21:16 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RcoOJ-0003ch-2U
	for gcvg-git-2@lo.gmane.org; Tue, 20 Dec 2011 02:21:15 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753790Ab1LTBVJ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 Dec 2011 20:21:09 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:60951 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753336Ab1LTBVI (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 Dec 2011 20:21:08 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5480A65F9;
	Mon, 19 Dec 2011 20:21:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=umowN1U0lqZDCmKb8fOaLxGFoQo=; b=h6J46r
	8sARxp+TL9lBOovZ4WO2yr1QSRayyy3lN4owQHe2eY8YmTmoGbt4/ecm1FN+tNoY
	wGYviI1T4gyDbSL0uZtQkQV+83u5A2PGEKLMc+dZ2sUY/4Gzlm26ituWDCqOO6Jn
	mnKZ93EUAZczqr3hGpbguw6AIlu81w14D3SAw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Sjw9VjhLxJdUNW+Ga0ZfSTAIITRmPoro
	X1NEuYKGAH29wDbNcQcdmbyjw8AmZb3JmlXCqdJGeleZYT032OjrE+fBvOhTztyx
	7geU7T7CrE7Tn1VIqq62hLbJnqjb4p4NUbqj6V1fs7/5Bh+FcBUvMlI+XhYyss9+
	Otr7uLuQKvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 4AEA465F8;
	Mon, 19 Dec 2011 20:21:05 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id B26C565F5; Mon, 19 Dec 2011
 20:21:04 -0500 (EST)
In-Reply-To: <CB1518AB.2D649%joshua.redstone@fb.com> (Joshua Redstone's
 message of "Tue, 20 Dec 2011 00:51:16 +0000")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: E2EAA0AE-2AA8-11E1-A258-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/187488>

Joshua Redstone <joshua.redstone@fb.com> writes:

> I've managed to speed up git-commit on large repos by 4x by removing some
> safeguards that caused git to stat every file in the repo on commits that
> touch a small number of files.  The diff, for illustrative purposes only,
> is at:
>
>     https://gist.github.com/1499621
>
>
> With a repo with 1 million files (but few commits), the diff drops the
> commit time down from 7.3 seconds to 1.8 seconds, a 75% decrease. The
> optimizations are:

I do not know if these kind of changes are called "optimizations" or
merely making the command record a random tree object that may have some
resemblance to what you wanted to commit but is subtly incorrect. I didn't
fetch your safety removal, though.

Wouldn't you get a similar speed-up without being unsafe if you simply ran
"git commit" without any parameter (i.e. write out the current index as a
tree and make a commit), combined with "--no-status" and perhaps "-q" to
avoid running the comparison between the resulting commit and the working
tree state after the commit?
