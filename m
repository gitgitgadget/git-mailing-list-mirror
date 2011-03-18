From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 3/3] clone: Free a few paths
Date: Fri, 18 Mar 2011 00:25:09 -0700
Message-ID: <7v4o70zy96.fsf@alter.siamese.dyndns.org>
References: <1300130318-11279-1-git-send-email-cmn@elego.de>
 <1300130318-11279-4-git-send-email-cmn@elego.de>
 <20110314194501.GA30483@elie>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org, Junio C Hamano <gitster@pobox.com>
To: Jonathan Nieder <jrnieder@gmail.com>
X-From: git-owner@vger.kernel.org Fri Mar 18 08:25:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q0U3x-0007VS-1W
	for gcvg-git-2@lo.gmane.org; Fri, 18 Mar 2011 08:25:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756367Ab1CRHZX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 18 Mar 2011 03:25:23 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:64414 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756320Ab1CRHZV (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 18 Mar 2011 03:25:21 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id AF510247B;
	Fri, 18 Mar 2011 03:26:54 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 s=sasl; bh=05hBqSDlDhbdSQLp1fvMopCLNeY=; b=wtiWdhcqqiXjpaSrZpRb
	9MrWuHOs9eM0NdJ53zB9IcNhJfi8WDzuOCXaT4XJOn28GwQBSbh4IhyQKMj+iKom
	KT7dDSelvK9TSXZCRV6jfXuuPtXirgh2G/iKJFPXJGYOmg5R7/sUJN8OcUJ7IjXn
	IgeY0y9rWipiDDPspZtz99A=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:message-id:mime-version:content-type;
	 q=dns; s=sasl; b=Zh/QwF8rZKuUjoYnq33PQKMLRSilceVCiT1SccRQzHhNXk
	qfsuUAK4qPNptPSSqFr9HjI5CrldmlDtKnwxLCp+drvV7y/6Ix6Nxdcs4BVni1u+
	IatUvGwj0k3EU6VHBVFkUxGDpi4ZmFXmrUkljxNV7wLAbWBbEBaM1slaeKGsE=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7C944247A;
	Fri, 18 Mar 2011 03:26:50 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 364BE2476; Fri, 18 Mar 2011
 03:26:44 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 171DFCA6-5131-11E0-9FB2-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169295>

Jonathan Nieder <jrnieder@gmail.com> writes:

> Thanks.  The commit message should probably mention that this is for
> the sake of valgrind rather a true memory leak, since the memory is
> freed by _exit at the appropriate time already.

Or perhaps you are planning to split larger later half of cmd_clone() into
a helper function, so that other people can call it after doing their own
command line processing.

> The patch itself seems sane, since the performance effect should be
> negligible.

Perhaps and yes.

I would have preferred a patch to free path and dir without doing anything
else, as path is coming from get_repo_path() that always return a string
on heap, and dir comes either directly from xstrdup() or guess_dir_name()
that gives strbuf_detach() or xstrndup() result to us, and they are
clearly leaking and are safely freed, though.
