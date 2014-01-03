From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/4] Speed up is_git_command() by checking early for internal commands
Date: Fri, 03 Jan 2014 10:00:39 -0800
Message-ID: <xmqqob3tlzco.fsf@gitster.dls.corp.google.com>
References: <52C58FD7.6010608@gmail.com> <52C59107.6080005@gmail.com>
	<xmqq38l6qii6.fsf@gitster.dls.corp.google.com>
	<20140103154426.GA23534@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Sebastian Schuberth <sschuberth@gmail.com>,
	Git Mailing List <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Jan 03 19:00:49 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vz93A-0005p1-C7
	for gcvg-git-2@plane.gmane.org; Fri, 03 Jan 2014 19:00:48 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752042AbaACSAo (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 3 Jan 2014 13:00:44 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:56187 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751125AbaACSAn (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 3 Jan 2014 13:00:43 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id AB7535CB0C;
	Fri,  3 Jan 2014 13:00:42 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=5v1lvLU1Zg6+ereJKbdGwF23aAA=; b=txMzCn
	vB1aIIYFJjR8gBH2vTMa7inV54hDWmgXP3dxd/Hmkf4Wm7jzUiumBR4BEY2ZBwK7
	Uz0cSYzB4YzpzbAFj/aj0aZBcTSPmxBgt8yH9ytQOrYaMEhYF/syEQeiKPnaWc4F
	viu1IGPvmMm/ABswzRctnpw0wN4K9ct30t7kY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=DyXakgutyQkB+gEjLFK4I8PCxicsKzhx
	bdfp45XBCyG+ZO+hwHQgtsWTeEguBM03Xowi0cV8zrU9P2U1xHtfqMLZZ6A55DJe
	TD61lOCf8aKHp1K+QSVLXzVVeFUTtUXPw8beV7CDr9Bj0htLnyTyZ4++10dd72IR
	Z3mAYXXFEWA=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 962115CB0A;
	Fri,  3 Jan 2014 13:00:42 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 7A9B75CB07;
	Fri,  3 Jan 2014 13:00:41 -0500 (EST)
In-Reply-To: <20140103154426.GA23534@sigill.intra.peff.net> (Jeff King's
	message of "Fri, 3 Jan 2014 10:44:26 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: F596A2F4-74A0-11E3-BE7D-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239920>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 02, 2014 at 11:41:05AM -0800, Junio C Hamano wrote:
>
>>  - builtin/merge.c is the same, but it is conceptually even worse.
>>    It has the end-user supplied string and wants to see if it is a
>>    valid strategy.  If the user wants to use a custom strategy, a
>>    single stat() to make sure if it exists should suffice, and the
>>    error codepath should load the command list to present the names
>>    of available ones in the error message.
>
> Is it a single stat()? I think we would need to check each element of
> $PATH. 

Yeah, load_command_list() iterates over the members of env_path.

> Though in practice, the exec-dir would be the first thing we
> check, and where we would find the majority of hits. So it would still
> be a win, as we would avoid touching anything but the exec-dir in the
> common case.

Exactly.
