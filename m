From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] remote-hg: fix path when cloning with tilde expansion
Date: Fri, 09 Aug 2013 14:45:35 -0700
Message-ID: <7vfvui4jy8.fsf@alter.siamese.dyndns.org>
References: <CAMP44s1Jqao0YvBSh18t1C2LwAF4_u2GaTNx1RwdW+pmCFcxvQ@mail.gmail.com>
	<1376068387-28510-1-git-send-email-apelisse@gmail.com>
	<7veha266nq.fsf@alter.siamese.dyndns.org>
	<CALWbr2w2JjEr_hYX9ighu_-=iTV6etG=78g4AbKko64EsecxFA@mail.gmail.com>
	<7vy58a4mcy.fsf@alter.siamese.dyndns.org>
	<CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Felipe Contreras <felipe.contreras@gmail.com>,
	git <git@vger.kernel.org>
To: Antoine Pelisse <apelisse@gmail.com>
X-From: git-owner@vger.kernel.org Fri Aug 09 23:45:45 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1V7uVD-0001PF-Kv
	for gcvg-git-2@plane.gmane.org; Fri, 09 Aug 2013 23:45:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1031252Ab3HIVpj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 9 Aug 2013 17:45:39 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:36194 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1031224Ab3HIVpi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 9 Aug 2013 17:45:38 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id A61EE370B1;
	Fri,  9 Aug 2013 21:45:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=YqEf1diaJKb1ovEd7uiFh9VREyg=; b=u2e1f6
	Bsi4WEVx7tw9wpvWTjsT7ZU1qiI7KNw2F1VyE/Y1oP5Se2cHbvZwOgQ6T4aBhmC7
	SxZwoFjZhfaLvrEKc7n+H+vp9v2vzOSGo1d96TN2zSYI6q2ezgNQjICWX2lKmani
	KrvYcuOGFEmQHrgrwulPkhq65CqLZoB5qAMhk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=Yl3Cnj0rWda5awj8ULfJKFK7WQtud5bo
	uGWAqBXMPRSrnZ3iraMK2vfJ5LsWIv8fqHp4n2mO0ItJLyGM21wUK816/FAfTTTb
	mXpDIuPuXRaqVe3+/1vPtSzYFG/jkfb3ncmi6LkrhgPuZ0buj8DRG9gbGVBa+zGB
	XZvg0hiHCvo=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8FBE4370B0;
	Fri,  9 Aug 2013 21:45:37 +0000 (UTC)
Received: from pobox.com (unknown [50.161.4.97])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id CAD14370AE;
	Fri,  9 Aug 2013 21:45:36 +0000 (UTC)
In-Reply-To: <CALWbr2y5H_dfHAFW_qN+j8YtF4F9+VcG8G503hr4YN2Qv69CXA@mail.gmail.com>
	(Antoine Pelisse's message of "Fri, 9 Aug 2013 23:19:30 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 06B546B2-013D-11E3-8D40-E84251E3A03C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/232038>

Antoine Pelisse <apelisse@gmail.com> writes:

> OK, I think I see why you are puzzled.
> ...
> But my issue is when I do that:
>
>     git clone hg::~/my_repo my_new_repo
>
> The clone works successfully by cloning $HOME/my_repo, but then, when
> we try to fix the repo path, we think that ~/my_repo is not an
> absolute path, so we make it absolute: /home/user/~/my_repo which is
> now off. So I'm not able to fetch that remote.

OK, so clone works, but subsequent fetch from the cloned resoitory
does not?  "git fetch hg::~/my_repo" will still work but the call to
"git config" done near the place your patch touches does not store
"hg::~/my_repo" because it thinks "~/my_repo" refers to
"./~/my_repo" and tries to come up with an absolute path.  The patch
tries to notice this case and return without rewriting, so that
remote.*.url is kept as "hg::~/my_repo".

Assuming that I am following your reasoning so far, I think I can
agree with the patch (not that my agreement matters that much, as
you seem to be a lot more familiar with this codepath).

Thanks for explaining.
