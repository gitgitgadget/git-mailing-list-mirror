From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] config: fix several access(NULL) calls
Date: Fri, 13 Jul 2012 09:49:55 -0700
Message-ID: <7vy5mn8v2k.fsf@alter.siamese.dyndns.org>
References: <877gu9wh05.fsf@thomas.inf.ethz.ch>
 <1342094660-3052-1-git-send-email-Matthieu.Moy@imag.fr>
 <7vtxxcc36v.fsf@alter.siamese.dyndns.org> <vpq1ukgai4e.fsf@bauges.imag.fr>
 <7vwr28agcq.fsf@alter.siamese.dyndns.org> <vpq1ukg82st.fsf@bauges.imag.fr>
 <20120713130021.GA2553@sigill.intra.peff.net>
 <vpqliin6bva.fsf@bauges.imag.fr> <87hatboiwr.fsf@thomas.inf.ethz.ch>
 <vpq1ukf68ow.fsf@bauges.imag.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Thomas Rast <trast@student.ethz.ch>, Jeff King <peff@peff.net>,
	<git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Fri Jul 13 18:50:18 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Spj4J-0004p1-7q
	for gcvg-git-2@plane.gmane.org; Fri, 13 Jul 2012 18:50:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1163083Ab2GMQuB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 13 Jul 2012 12:50:01 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64067 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1161401Ab2GMQt6 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 13 Jul 2012 12:49:58 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5025E6F66;
	Fri, 13 Jul 2012 12:49:57 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dx4UiaodziIx9n+5Z/KBsLnd+eU=; b=Xm+XRu
	HAXT/KRggvA2KVslKmLJzlwUG4UcWyDUBzK/aTnekOCrQEExDWCIMExiNDV5eAOT
	A16EkEApwtrqVzsoxatCOqvwSH3CqEFMgUzfV3D6d4yT+RqgbPPTWfip3vFBPem9
	2ziEmrbd7EshxV/t0mF74QYiAZYt/DjCsOls4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=rezhgGesbSE2bXz+pUCTr6UsV+knplNX
	GNtyR5Y61hT/9o6thovgjB8Fs8aVjnxK3tKHzDGFNpBHddoHvtWdQzQstnVXywPD
	jHiNTEtVqZdD05UvN6VG3DMmllnmEsVRfO6qBgSbBCSYqaGwTjtl5uGFlrCTs3qB
	GBs+OOUdDb4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 3E0CA6F65;
	Fri, 13 Jul 2012 12:49:57 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 958706F61; Fri, 13 Jul 2012
 12:49:56 -0400 (EDT)
In-Reply-To: <vpq1ukf68ow.fsf@bauges.imag.fr> (Matthieu Moy's message of
 "Fri, 13 Jul 2012 16:23:59 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C6C8542A-CD0A-11E1-8242-01B42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/201410>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> The old code was:
>
>         if (use_global_config) {
>                 char *home = getenv("HOME");
>                 if (home) {
>                         char *user_config = xstrdup(mkpath("%s/.gitconfig", home));
>                         given_config_file = user_config;
>                 } else {
>                         die("$HOME not set");
>                 }
>         }

I think the above is a good illustration of the crux of the issue,
as the natural way to introduce XDG that is used when the one at
$HOME/.gitconfig is not there seems at least to me to do this:

	if (use_global_config) {
                if (is $HOME/.gitconfig usable?) {
			use it;
		} else if (is $XDG/git/config usable?) {
                	use $XDG location;
		} else {
			die("Neither $XDG or $HOME is usable");
		}
	}

In other words, we are not trying to say "You do not have $HOME --
there is something wrong, so we will give up" in this codepath.  We
were saying "Can we use _the_ place we place personal config?  It is
an error if we cannot find it, so we die." and the above says "Can
we use this place?  Can we use that place?  If no place is found to
be usable, we die."

And the intent of the "NULL-buggy" version seems to want the same
"If we cannot use home/.gitconfig but xdg_config one is usable, use
xdg one" semantics to me.

		if (access(user_config, R_OK) && !access(xdg_config, R_OK))
 			given_config_file = xdg_config;
 		else if (user_config)
 			given_config_file = user_config;
