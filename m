From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 7/8] remote-bzr: reorganize the way 'wanted' works
Date: Tue, 28 May 2013 10:02:55 -0700
Message-ID: <7vvc632g1s.fsf@alter.siamese.dyndns.org>
References: <1369448666-17515-1-git-send-email-felipe.contreras@gmail.com>
	<1369448666-17515-8-git-send-email-felipe.contreras@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Felipe Contreras <felipe.contreras@gmail.com>
X-From: git-owner@vger.kernel.org Tue May 28 19:03:11 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UhNIi-0005W3-Ih
	for gcvg-git-2@plane.gmane.org; Tue, 28 May 2013 19:03:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S934859Ab3E1RDD (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 28 May 2013 13:03:03 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:53853 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S934805Ab3E1RDC (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 28 May 2013 13:03:02 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id F2A2C23C8F;
	Tue, 28 May 2013 17:02:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=0bkStYdGbkXF+YHMsDrYFk09WlE=; b=ItM0OF5Hu8CY1EV8kWkd
	Ty2VquwzpF9TMBWqzeUgo6ld7Xj+zhA/pLKCrXIXqMcoNwO6p2fUAInwsPoa6oCt
	jsElfinaanYTbayULSDLYksnFDpGb273nmRPRUzbrL/B9o5ChdYZtGFzGuO5ne+L
	Yg4mCPQVdZNjdqxTud1NIa0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Cig4PCqm7XS8vEa4Eo3Savkey9Oy6xkqxDZhEis52zpmYu
	hAIfVrMRrdstkhk9lZVytOXvLRfSXvF5pyx8SQ8i5l4ZjrzxZW2dgd1BhDfbnQJ3
	rDzFmdu/DtWCicxlFuA7yTYekWPC8WbQDEbbFDUfOlo23dXh8UrauefBfAw4Y=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E920F23C8E;
	Tue, 28 May 2013 17:02:58 +0000 (UTC)
Received: from pobox.com (unknown [50.152.208.16])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 025E123C8C;
	Tue, 28 May 2013 17:02:57 +0000 (UTC)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 724EA12A-C7B8-11E2-A047-E56BAAC0D69C-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/225662>

Felipe Contreras <felipe.contreras@gmail.com> writes:

> +    wanted = get_config('remote-bzr.branches').rstrip().split(', ')

Two minor nits and one design suggestion:

 - Why rstrip() not strip()?  It appears that this only is helping
   an end-user "mistake" like this:

	git config remote-bzr.branches 'trunk, devel, test '

   without helping people who have done this:

	git config remote-bzr.branches 'trunk,  devel, test'

 - Is

     git config remote-bzr.branches trunk,devel,test

   a grave sin?

   In other words, wouldn't we want something like this instead?

	map(lambda s: s.strip(), get_config('...').split(','))

 - Doesn't allowing multi-valued variable, e.g.

	[remote-bzr]
            branches = trunk
            branches = devel
            branches = test

   make it easier for the user to manage this configuration by
   e.g. selectively removing or adding tracked branches?
