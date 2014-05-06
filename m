From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] add a reflog_exists and delete_reflog abstraction
Date: Tue, 06 May 2014 12:15:10 -0700
Message-ID: <xmqq1tw6g1mp.fsf@gitster.dls.corp.google.com>
References: <1399330677-17930-1-git-send-email-sahlberg@google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, mhagger@alum.mit.edu
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue May 06 21:53:14 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Whkpp-0005UI-Ft
	for gcvg-git-2@plane.gmane.org; Tue, 06 May 2014 21:15:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754133AbaEFTPT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 6 May 2014 15:15:19 -0400
Received: from smtp.pobox.com ([208.72.237.35]:58662 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753444AbaEFTPQ (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 6 May 2014 15:15:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 61147144AC;
	Tue,  6 May 2014 15:15:15 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=/3l8kN3JfGoQEO8HZdqlu1uThtw=; b=MOSucM
	TJ7gx2fVCj8KIKoWQbixaJjp1eUT+IebRvjNGlF1meUdnr2AR34HU/VnypdmbbZo
	nTlNavQVZqKh7En+yoPfr6rsX+P6Nwl4vYqibLJ9Efg2iVlLuyv8l/09pRf3sPDP
	s36YLkAhmLQxqNBlT9u+mMpyiwW77vpKT7OFU=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=nyz9MMY7NIW4YfRqccz6LmZzP5rFo1Ku
	cuhv6dvFnPHDTqkptocbW3COMbnPa5ttnUuTMlZjOVkSk18Q08Tav1NBvcqN2axU
	HWAiR0/69C88rwknKeO8rKVRIiAeYpg3iX/iBN4OHtmF6TZ/IWXFMeCa5SuANEkq
	ChjTN2L58Zs=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 42F35144AB;
	Tue,  6 May 2014 15:15:15 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 6B645144AA;
	Tue,  6 May 2014 15:15:12 -0400 (EDT)
In-Reply-To: <1399330677-17930-1-git-send-email-sahlberg@google.com> (Ronnie
	Sahlberg's message of "Mon, 5 May 2014 15:57:56 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BF493F82-D552-11E3-9AAC-9CEB01674E00-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/248225>

Ronnie Sahlberg <sahlberg@google.com> writes:

> It currently has a hard assumption that the loose ref file must exist at this
> stage or else it would end up deleting the reflog which is true today, as far
> as I can tell, but would break if git would change such that we could have
> a branch checked out without having a loose ref file for that branch.

Hmmmm.  Do you mean this sequence will break?

        : gitster x; git init lo
        Initialized empty Git repository in /var/tmp/x/lo/.git/
        : gitster x; cd lo
        : gitster lo/master; git commit --allow-empty -m initial
        [master (root-commit) db2b430] initial
        : gitster lo/master; git branch next

Now we have two branches, master and next, and we are on master.

        : gitster lo/master; git pack-refs --all
        : gitster lo/master; ls .git/refs/heads
        ./  ../
        : gitster lo/master; cat .git/packed-refs
        # pack-refs with: peeled fully-peeled 
        db2b43072749258d1e3c119c9570349d77c26b3a refs/heads/master
        db2b43072749258d1e3c119c9570349d77c26b3a refs/heads/next

And loose refs are fully packed.

        : gitster lo/master; git checkout next
        Switched to branch 'next'
        : gitster lo/next; ls .git/refs/heads
        ./  ../
