From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCHv4 08/12] Teach the notes lookup code to parse notes trees
 with various fanout schemes
Date: Thu, 27 Aug 2009 13:55:00 -0700
Message-ID: <7vtyztq8nv.fsf@alter.siamese.dyndns.org>
References: <1251337437-16947-1-git-send-email-johan@herland.net>
 <1251337437-16947-9-git-send-email-johan@herland.net>
 <7v7hwp6ebb.fsf@alter.siamese.dyndns.org>
 <200908271135.31794.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Johannes.Schindelin@gmx.de,
	trast@student.ethz.ch, tavestbo@trolltech.com,
	git@drmicha.warpmail.net, chriscool@tuxfamily.org,
	spearce@spearce.org
To: Johan Herland <johan@herland.net>
X-From: git-owner@vger.kernel.org Thu Aug 27 22:55:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Mgm0I-0007c1-LY
	for gcvg-git-2@lo.gmane.org; Thu, 27 Aug 2009 22:55:31 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752713AbZH0UzW (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 27 Aug 2009 16:55:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752708AbZH0UzW
	(ORCPT <rfc822;git-outgoing>); Thu, 27 Aug 2009 16:55:22 -0400
Received: from a-pb-sasl-quonix.pobox.com ([208.72.237.25]:49090 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752409AbZH0UzU (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 27 Aug 2009 16:55:20 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id D04751B749;
	Thu, 27 Aug 2009 16:55:19 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=8gmUankcFOmDsKLD14AittU+bfY=; b=h83VBO
	UmPHv4OtMseO8gaAwNQqI47z9YAuio/vnk6jUAaXrXVLpeT6vx5nkUyTyYEMTDPV
	ZD2hmoUJANSamTCKCotTsVNBuha1FJW3mm0QtP9Tpkwa5biXSPeFgmHy8TmCnvL6
	j7FJqQzk4uinFLBsHjeIyaww81QwLFZx224FE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=K00PIzhckFqZrwn27/+msXQuxFtBCEfh
	BRn272XSqpcynR315OBFxE3C05tpQCPgAMu2sB5dyonfewY844ZllpNxIK27hyqn
	1U2CH+88Bmx7Ip9JX6srC2N+NIpTBPlbWJ5Cjob9+HZziRYaROR6cCoinPLBZq54
	joCM3VOT5+4=
Received: from a-pb-sasl-quonix. (unknown [127.0.0.1])
	by a-pb-sasl-quonix.pobox.com (Postfix) with ESMTP id 55C621B748;
	Thu, 27 Aug 2009 16:55:11 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-quonix.pobox.com (Postfix) with ESMTPSA id EF8DA1B746; Thu, 27 Aug
 2009 16:55:01 -0400 (EDT)
In-Reply-To: <200908271135.31794.johan@herland.net> (Johan Herland's message
 of "Thu\, 27 Aug 2009 11\:35\:31 +0200")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E941D946-934B-11DE-AB11-CA0F1FFB4A78-77302942!a-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127209>

Johan Herland <johan@herland.net> writes:

> 2. Simply decide on a constant 2/2/36 fanout. For the case with < 256K 
> notes, this is somewhat wasteful, but not prohibitively expensive. For the 
> case with > 64M notes, performance will start to degrade. The big advantage 
> with this approach is that when this is hardcoded into the notes code, we 
> have regained the property that notes for a given commit have exactly _one_ 
> unique position in the notes tree across all installations (enabling us to 
> fall back on the regular merge strategy).

I thought it was Gitney who suggested to use a top-level fan-out based on
the committer-date.  If you typically have already parsed the commit when
you want to look up notes objects for it, it won't have extra overhead,
and when looking at only recent history it will only need to access a
small subset of trees.  I thought it was a neat idea (except that the
question becomes what the granularity of the top level fan-out should
be---one a day?  one a month?---the optimum would depend on commit
density).  Was that idea shot down for some reason?
