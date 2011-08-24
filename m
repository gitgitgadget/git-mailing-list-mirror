From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] submodule: Demonstrate known breakage during recursive
 merge
Date: Wed, 24 Aug 2011 12:24:22 -0700
Message-ID: <7vty96obo9.fsf@alter.siamese.dyndns.org>
References: <680d2679c3275c01152500760311b5f96a93ea62.1314193375.git.brad.king@kitware.com> <20110824191438.GA45292@book.hvoigt.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Brad King <brad.king@kitware.com>, git@vger.kernel.org
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Wed Aug 24 21:24:45 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QwJ48-0001rK-8r
	for gcvg-git-2@lo.gmane.org; Wed, 24 Aug 2011 21:24:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751160Ab1HXTY0 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 24 Aug 2011 15:24:26 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49579 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750767Ab1HXTYZ (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 24 Aug 2011 15:24:25 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E55454434;
	Wed, 24 Aug 2011 15:24:23 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=f26ghLoh4RvxUaOC3N0OH3EtTGY=; b=nIgiQK
	BJSf/wqOSk66PlaFLd3SO1Sez+5698F2ZEj+cawl1xvdL1SuCqaZ+5H11P0YIcUz
	nrhyO75oX9ppHElwowuHYo0q2To2Eqtf/DQbWYoDayjMwoSh70JeEfHdanipHPwW
	WXWk1/3Q9xQb06CEdFr3GfI8ZOKr1/66o6iS0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=BkXXb3EXVBEIes76R9AylnGn93eGok5B
	0xW9U0MlLi7Y4AcxEeTkZDoM+dk++19L03GVbJIwLkLlKPQx47/gM7SX5xRwh9sY
	rOFfSAdW4XW+lei115OYU0vvyk9ouj/adSAt5sI6+65np1sE76n+9eQQoiMBD7Cl
	JA1Vc2bN2tw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DCAC44433;
	Wed, 24 Aug 2011 15:24:23 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7279E4432; Wed, 24 Aug 2011
 15:24:23 -0400 (EDT)
In-Reply-To: <20110824191438.GA45292@book.hvoigt.net> (Heiko Voigt's message
 of "Wed, 24 Aug 2011 21:14:38 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: AC6BC7F2-CE86-11E0-B056-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/180028>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> ... Its a
> little bit workaroundish so if anymore has an idea how to fix this in
> nicer way, please tell me.
>
> [1]--8<----
> From: Heiko Voigt <hvoigt@hvoigt.net>
> Subject: [PATCH] protect submodule merge search against multiple calls for
>  the same path
>
> When multiple merge-bases are found for two commits to be merged the
> merge machinery will ask twice for a merge resolution. Currently its not
> possible to use the revision-walking api for walking the same commits
> multiple times.

I have been suspecting that most of this should be done in a separate
helper program that is run via run_command() interface, without
contaminating the object pool the main merge process has with data from
the submodule object store to begin with (i.e. add_submodule_odb() and
everything below should go). Wouldn't it be a lot cleaner solution?
