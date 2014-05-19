From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 03/31] refs.c: rename the transaction functions
Date: Mon, 19 May 2014 16:25:12 -0700
Message-ID: <xmqqlhtxuzaf.fsf@gitster.dls.corp.google.com>
References: <1400105610-21194-1-git-send-email-sahlberg@google.com>
	<1400105610-21194-4-git-send-email-sahlberg@google.com>
	<xmqq38g9a0i0.fsf@gitster.dls.corp.google.com>
	<CAL=YDW==tVrtonoDmBrucWgnTGbqEs70tq5zCp6xjDPgg4G16A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "git\@vger.kernel.org" <git@vger.kernel.org>,
	Michael Haggerty <mhagger@alum.mit.edu>
To: Ronnie Sahlberg <sahlberg@google.com>
X-From: git-owner@vger.kernel.org Tue May 20 01:25:24 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WmWvq-0001Af-Nq
	for gcvg-git-2@plane.gmane.org; Tue, 20 May 2014 01:25:23 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752133AbaESXZS (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 19 May 2014 19:25:18 -0400
Received: from smtp.pobox.com ([208.72.237.35]:57422 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbaESXZR (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 19 May 2014 19:25:17 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 9696C19AF2;
	Mon, 19 May 2014 19:25:16 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=wPbLp51qA3pNlKRitJ1vA3NYxNY=; b=UQmcW+
	cZhDjGXOLddw8O7P7u8mfqAbvIQAKv73U6qHRM5oSUfzZZpcEtX6TAw65gXkSYpd
	pCy8h1qRvCgwYHPpvRR8Cuzknq6MzFwAzShHkK0T0Bo8lfXHW/GjxChbh3HQ7OgK
	nnP+pPzEJoeGXR7v+D/KD0CFOo85H+VQN8Gu4=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=iXIskNc7YQOJNsZ+3DhU1zyrvZ3ogkxC
	h+Jv3JYKjwKgcMAyrB/mPcupn+NEajRTLSPGFXIaiD+2/BDkWcMNOGI/ijQxxg58
	STFKQxkGpV8/M1J6hOOHX15+NEBnYN5bDmw0LMXXipw594Sid8DXxa1wQK9umaax
	ifmfhzCPWZA=
Received: from pb-smtp0. (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 8DFBB19AF0;
	Mon, 19 May 2014 19:25:16 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 9D9FE19AEB;
	Mon, 19 May 2014 19:25:13 -0400 (EDT)
In-Reply-To: <CAL=YDW==tVrtonoDmBrucWgnTGbqEs70tq5zCp6xjDPgg4G16A@mail.gmail.com>
	(Ronnie Sahlberg's message of "Mon, 19 May 2014 16:11:37 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: D411A652-DFAC-11E3-B1F2-B784E8FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/249637>

Ronnie Sahlberg <sahlberg@google.com> writes:

> I am not sure if we need transactions for other types of data, such as
> sha1 objects, but if it turns out we do in the future we can rename
> these functions again.

I was wrong (and I think you read it in the later patch review).

If we need transaction for other types of data, and we will
eventually need to coordinate the transaction semantics over refs
and those other types of data.  It would be far cleaner to express
that coordination within the same transaction framework.

In other words, we do not want to be in a situation like this:

    other_transaction_begin();
    ref_transaction_begin();
    ref_transaction_update();
    other_transaction_update();
    ref_transaction_commit();
    if (other_transaction_commit() != SUCCESS) {
        ... oops it is too late to roll back the ref_transaction ...
        other_transaction_rollback();	
    }

and force us doing 3-phase commit inside ourselves to work it
around.
