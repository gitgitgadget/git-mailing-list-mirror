From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Submodule relative URL problems
Date: Mon, 13 Jan 2014 12:44:07 -0800
Message-ID: <xmqqppnv6294.fsf@gitster.dls.corp.google.com>
References: <DC691CA7-BE36-4FE7-895A-FE8E1FD0C080@kcl.ac.uk>
	<DAD6CF7D-49F2-4FB5-9EF2-EBAAF86881AA@kcl.ac.uk>
	<20140113195518.GB18964@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Lianheng Tong <lianheng.tong@kcl.ac.uk>, git@vger.kernel.org,
	Jens Lehmann <Jens.Lehmann@web.de>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Mon Jan 13 21:44:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1W2oMz-0000NX-79
	for gcvg-git-2@plane.gmane.org; Mon, 13 Jan 2014 21:44:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751832AbaAMUoW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 13 Jan 2014 15:44:22 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64555 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751317AbaAMUoU (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 13 Jan 2014 15:44:20 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 5322863EE4;
	Mon, 13 Jan 2014 15:44:20 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=g1oDqv3HMkP8fUBF2yk77rKLThY=; b=gdEnZD
	Ug9hfgeGJWpOnj2BAtzdtaRH07tJQCSda+Wb9SnCWiAp4kLQua3tdm35uHrvCq8y
	RBZhB1JHvRqkBe9ZWBCgNym3eQQDb7rQdVLJDsrnOZVmdK3ha9314oUavWf0pJ0e
	X/QlSGidE6cTTW9vKrETqq8IGo9zMZhF14Clc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=QbDNxhhJsYmEJJR/ixtDoW7SuMbapH8u
	zxYLV75CLaPodlMGesjPWz30KDn0w4rnpRLsvzoj1nVHMbXeX8BM6u9/6/R9dLkY
	hnCl6NzA73LPF3R4xvvq5DDsOgdM9gm+uToqx0WLFAV9FfIlorf7rIhoe2Hag9eE
	8lsTm2LsiKA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C11F463EDD;
	Mon, 13 Jan 2014 15:44:18 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id AF95E63ED4;
	Mon, 13 Jan 2014 15:44:16 -0500 (EST)
In-Reply-To: <20140113195518.GB18964@google.com> (Jonathan Nieder's message of
	"Mon, 13 Jan 2014 11:55:18 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 780B3674-7C93-11E3-B7D7-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/240374>

Jonathan Nieder <jrnieder@gmail.com> writes:

>  * More typical usage is to clone from a bare repository (A.git), which
>    wouldn't have this problem.  But I think your case is worth
>    supporting, too.

I think the relative URL among nested submodules was specifically
designed for hosting environments that have forest of bare
repositories to serve as publishing or meeting points.  I personally
do not know where that "worth supporting" comes from, but if the
change can be done without confusing the codepaths involved, I
wouldn't object too much ;-)

>  * Perhaps as a special case when the superproject is foo/.git, git
>    should treat relative submodule paths as relative to foo/ instead
>    of relative to foo/.git/.  I think that would take care of your
>    case without breaking existing normal practices, though after the
>    patch is made it still wouldn't take care of people using old
>    versions of git without that patch.  What do you think?

If we were to start adding special cases, it may also be sensible to
clean up the more normal case of using subdirectories of bare
repositories to represent nestedness (i.e. you can have a submodule
"logs.git", but not "logs").  We could reuse the $GIT_DIR/modules/$sm_name
convention somehow perhaps?

Any change to implement the special case you suggest likely has to
touch the same place as such a change does, as both require some
reorganization of the code that traverses the pathnames to find
related repositories.
