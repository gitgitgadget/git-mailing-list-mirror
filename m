From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [BUG] auto-repack exits prematurely, locking other processing out
Date: Fri, 23 May 2014 15:42:34 -0700
Message-ID: <xmqqlhtsglr9.fsf@gitster.dls.corp.google.com>
References: <20140523195121.GA923@angband.pl>
	<xmqqy4xsgome.fsf@gitster.dls.corp.google.com>
	<20140523223437.GA4230@angband.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: =?utf-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41j?= Duy <pclouds@gmail.com>,
	git@vger.kernel.org
To: Adam Borowski <kilobyte@angband.pl>
X-From: git-owner@vger.kernel.org Sat May 24 00:42:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WnyAm-0006NU-Fp
	for gcvg-git-2@plane.gmane.org; Sat, 24 May 2014 00:42:44 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751257AbaEWWmk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 23 May 2014 18:42:40 -0400
Received: from smtp.pobox.com ([208.72.237.35]:54021 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751153AbaEWWmk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 23 May 2014 18:42:40 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 7167D1C08B;
	Fri, 23 May 2014 18:42:39 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=7hFgbsmOIv9a5yLPXoyAMnhptXU=; b=uKrrvb
	cemd1TYIjyP9nmhcIPgUz8LocP9eDLOKg1njeYM4fW+XErsZ69JN7+oc4uIAlaTq
	RoFiISji2ZHRBehB2XWR9rj2/rxMWcfzI2tVaeQIhO4TLO3nyj6fEsYTWvQrwEKf
	Z5BSuQZ20Md3OTqeu1/iZwKW54NpHBH1518Aw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tYNyxqV4uZuMdKoLTEjXJSA/psPaRC3q
	Qfwggv5FGhoxDyCBicgy2CE8HeMr+uSF18BNfq8YcPz+rkl6HEk4xwPUHVjd2BRa
	zTR/yZzJYxY0bYd87h/0Edu9PYSDruiXELKKfS312R7MP2t7XyXbfvAgwAes+qvZ
	unpsLaqQhZM=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 661561C089;
	Fri, 23 May 2014 18:42:39 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 3A2BA1C088;
	Fri, 23 May 2014 18:42:36 -0400 (EDT)
In-Reply-To: <20140523223437.GA4230@angband.pl> (Adam Borowski's message of
	"Sat, 24 May 2014 00:34:37 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 89636448-E2CB-11E3-8A97-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/250044>

Adam Borowski <kilobyte@angband.pl> writes:

> On Fri, May 23, 2014 at 02:40:41PM -0700, Junio C Hamano wrote:
>> Adam Borowski <kilobyte@angband.pl> writes:
>> > It looks like the periodic auto-repack backgrounds itself when it shouldn't
>> > do so.  This causes the command it has triggered as a part of to fail:
>> 
>> Duy, 9f673f94 (gc: config option for running --auto in background,
>> 2014-02-08) turns to be not such a hot idea.  Sure, if we kick it
>> off background after doing something heavy, immediately before
>> giving control back to the end-user, and expect that the user will
>> stay thinking without making new changes (i.e. read-only stuff like
>> "git show" would be OK), then daemonize might be a great thing, but
>> we forgot, while doing that commit, that long-running operations
>> trigger the auto gc in the middle *and* they want it finish before
>> they continue, as the purpose of gc is to help the performance
>> during their further operation.
>
> Just add a lock that's triggered by daemonize, and have things block on this
> lock.

Hmph, it defeats the whole point of running it in the background,
doesn't it?  How would "blocking on the lock" be different from
launching "gc --auto" and waiting for it to come back?

And it would also require addition of the big-repository-lock and
code to take the lock sprinkled all over the place.  I am not sure
if we want to go there...
