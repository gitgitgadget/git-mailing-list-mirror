From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
 submodules
Date: Mon, 22 Aug 2011 15:22:31 -0700
Message-ID: <7vd3fxulw8.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
 <7vwre9yodc.fsf@alter.siamese.dyndns.org>
 <7vippszj70.fsf@alter.siamese.dyndns.org>
 <7vmxf3xnsf.fsf@alter.siamese.dyndns.org> <20110822194728.GA11745@sandbox-rc>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Fredrik Gustafsson <iveqy@iveqy.com>, git@vger.kernel.org,
	jens.lehmann@web.de
To: Heiko Voigt <hvoigt@hvoigt.net>
X-From: git-owner@vger.kernel.org Tue Aug 23 00:22:41 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QvctE-000521-TT
	for gcvg-git-2@lo.gmane.org; Tue, 23 Aug 2011 00:22:41 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753959Ab1HVWWf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Aug 2011 18:22:35 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:41464 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753898Ab1HVWWe (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Aug 2011 18:22:34 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D0B894B84;
	Mon, 22 Aug 2011 18:22:33 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=nCn15g9dwUKwGvGIUkiOEU92vYQ=; b=XSoqos
	a7gIJA8giDJpx4QxGto+t1cxEy+LA+L5Ox5aFrr6KhdIkM4Omj6XRo7Tzb4F2UpT
	G3e2YJwsK89VbvGKh6Rqzvo4kpE838B/X/C8i35A1HctYZnjynp2OLLGzRbeQfgU
	p28/sBcO+LsE3bUMWqCJY8qwdTEy5AxGxgR1I=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=niOyU8WslsM8RKrQXPQ9TGRZn408Rsma
	LRCsDj8GPOKXXfT+6ECTiRu6XuYrwWFdYXbCo6/c0zMvZeiOIeRnXUYPNvT3tlOm
	37HwXiAQgdDNwr7rGIDcp7cgKF0oImQY9/IZctwg2jLDUyVwjuX3ojmtEJi3CNRP
	kOF4LDtca/4=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id C7A784B83;
	Mon, 22 Aug 2011 18:22:33 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 3B6E94B7F; Mon, 22 Aug 2011
 18:22:33 -0400 (EDT)
In-Reply-To: <20110822194728.GA11745@sandbox-rc> (Heiko Voigt's message of
 "Mon, 22 Aug 2011 21:47:29 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 3B3273EE-CD0D-11E0-9024-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179896>

Heiko Voigt <hvoigt@hvoigt.net> writes:

> Junio since you are one person listed in the api docs could you maybe
> quickly explain to me what this flag is used for?

It is used in order to avoid walking the object we have walked already.

Which in turn means that once you walk chain of objects, unless you
remember the ones you walked and clear the marks after you are done, you
cannot walk the object chain for unrelated purposes.  See how functions
like get_merge_bases_many() walk portions of graph for their own purpose
and then avoid disrupting others by calling clear_commit_marks(). The use
of TMP_MARK (and its clearing after the function is done with the marked
objects) in remove_duplicate_parents() serve the same purpose.
