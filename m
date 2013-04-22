From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] Silent data loss on merge with uncommited changes + renames
Date: Mon, 22 Apr 2013 08:19:50 -0700
Message-ID: <7v61zer3s9.fsf@alter.siamese.dyndns.org>
References: <vpqobd6q5nm.fsf@grenoble-inp.fr>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git <git@vger.kernel.org>
To: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>
X-From: git-owner@vger.kernel.org Mon Apr 22 17:19:59 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UUIX7-0000Ih-UK
	for gcvg-git-2@plane.gmane.org; Mon, 22 Apr 2013 17:19:58 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753522Ab3DVPTx (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 22 Apr 2013 11:19:53 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49383 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752711Ab3DVPTw (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 22 Apr 2013 11:19:52 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 2737616869;
	Mon, 22 Apr 2013 15:19:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=QTUTOY86T3JzCsQHZK0MUQXP92s=; b=ilQKqZ
	D676WGtOVu0bSzcIJaN14cgH7/PCSy1NF56K7T5YcSlkw4a8EWp3YSbMd0uq8aqf
	66zg9xjnV78SZE8AKiQlBQlMbeKoRK7TQJmTDpZ6EUkEXoZqlS9Pe9EWBOmlWKFY
	3LiJSzbXcZhWgYx4EPy07wmWzoo/24kb6Zsq0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=X5MxxhKHYjFZNmF8/uddaR/OXvHfTA6M
	jqKjnL/zQp0tP8ChSeUZuDtcsRbs+ae+2lphf2BoO7Sq1EeUo9NIMF6Wx72xLIQ0
	kE+uK0m292FSkzuM8j+6uu3jnj1HAWD+TGqJh7G/04ZRZFOKHkuR1mMcDXAdhY7E
	zBm4+OJ7lUM=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1BB6A16866;
	Mon, 22 Apr 2013 15:19:52 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id A6D8F16865;
	Mon, 22 Apr 2013 15:19:51 +0000 (UTC)
In-Reply-To: <vpqobd6q5nm.fsf@grenoble-inp.fr> (Matthieu Moy's message of
	"Mon, 22 Apr 2013 11:24:45 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 1418ADF4-AB60-11E2-BFA8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222023>

Matthieu Moy <Matthieu.Moy@grenoble-inp.fr> writes:

> I could have expected "git merge --abort" to fail, but the problem is
> really more serious here: data loss is done silently before giving me an
> opportunity to do or abort anything.

I think this is a well known and longstanding failure case in the
recursive merge.  As it does not perform its internal operation
while handling renames in clean and distinct steps (i.e. figure out
what goes to where before touching any index entry or working tree,
then check if a proposed change to the index or the working tree
conflicts with local changes, and finally carry out the proposed
change), it is somewhat hard to fix it correctly in the current
implementation, even though you probably could patch these up case
by case basis.
