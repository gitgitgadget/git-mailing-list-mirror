From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v3 2/3] config: add hashtable for config parsing & retrieval
Date: Wed, 25 Jun 2014 11:21:21 -0700
Message-ID: <xmqq1tucalzy.fsf@gitster.dls.corp.google.com>
References: <1403518300-23053-1-git-send-email-tanayabh@gmail.com>
	<1403518300-23053-3-git-send-email-tanayabh@gmail.com>
	<53A84077.4010200@ramsay1.demon.co.uk>
	<xmqqsimv9pjx.fsf@gitster.dls.corp.google.com>
	<53A9276D.3020503@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, Ramkumar Ramachandra <artagnon@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Tanay Abhra <tanayabh@gmail.com>
X-From: git-owner@vger.kernel.org Wed Jun 25 20:21:36 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Wzrp6-0001pQ-C4
	for gcvg-git-2@plane.gmane.org; Wed, 25 Jun 2014 20:21:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757824AbaFYSV3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 25 Jun 2014 14:21:29 -0400
Received: from smtp.pobox.com ([208.72.237.35]:55069 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757641AbaFYSV2 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 25 Jun 2014 14:21:28 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 3BD1E21C5B;
	Wed, 25 Jun 2014 14:21:21 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=dGJTv8U1ldTJLHVggJLRPtExrzg=; b=bosWeD
	UhLg67ol1+VVwPittkUdDp6aVP6REA4khosuiOvCsyZtT3dNh1A7t/04AZby+diO
	+nS4DbJP/kM8BPZWtLZtQyJ8rKn8zlyXwCaNFGwqGykL1JPJH9wFegazETd9Bgom
	c4CnzONApTJZWylygwLfwnoJFZ89bBmOg+gUM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=mAjyqSCtVemXkQtnozW/MUzpPI7u9+P3
	zCJcNUb+3Xt2Ykk27eRritJI6aysGR0msVVExwZuxXeexWZUIqaCQyGTRmqrMP8I
	y0tgTZqJLWpz4hgIZ7mGwm1L8Ld4r+DpyBJ63ap5Qz2Z06egGZRSLFsFghDrej47
	k1fSYgMJvAM=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 2167721C5A;
	Wed, 25 Jun 2014 14:21:21 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 446B921C45;
	Wed, 25 Jun 2014 14:21:16 -0400 (EDT)
In-Reply-To: <53A9276D.3020503@gmail.com> (Tanay Abhra's message of "Tue, 24
	Jun 2014 12:53:25 +0530")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 7F0C5836-FC95-11E3-943A-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/252454>

Tanay Abhra <tanayabh@gmail.com> writes:

> What changes should I implement in this series? Should I add new
> user facing API adding to the singleton callers which are already in
> this series.

I think the underlying data structures that represent what the
entire set of config data is needs to be refined.

We did this kind of conversion once, back when we made it possible
to handle more than one instances of in-core cache.  You may want to
study the series that implemented the transition to learn ideas from.

 - We used to have a single "struct cache_entry **cache", a single
   pair of "unsigned int cache_nr, cache_alloc", etc. and the first
   patch to introduce the feature was to define "struct index_state"
   that holds all of these "what the entire set of data that
   represent the status of the in-core cache is" variables.

 - We also used to have a set of functions that work on the
   singleton instance of the in-core cache (read_cache(),
   write_cache(), etc.).  We introduced a new set of API functions
   to take an explicit pointer to the "struct index_state" we want
   to work on, and made these old "assume the singleton" functions a
   set of thin wrappers that pass &the_index to the corresponding
   new API functions.
