From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v7 0/1] refs.c: SSE4.2 optimizations for check_refname_component
Date: Mon, 09 Jun 2014 23:55:12 -0700
Message-ID: <xmqqfvjdb6en.fsf@gitster.dls.corp.google.com>
References: <1402012575-16546-1-git-send-email-dturner@twitter.com>
	<xmqqfvjdenk5.fsf@gitster.dls.corp.google.com>
	<xmqqvbs9d6qn.fsf@gitster.dls.corp.google.com>
	<53969FDF.3050506@viscovery.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: David Turner <dturner@twopensource.com>, git@vger.kernel.org,
	mhagger@alum.mit.edu
To: Johannes Sixt <j.sixt@viscovery.net>
X-From: git-owner@vger.kernel.org Tue Jun 10 08:55:26 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WuFxs-0001EQ-L4
	for gcvg-git-2@plane.gmane.org; Tue, 10 Jun 2014 08:55:24 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754660AbaFJGzU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 10 Jun 2014 02:55:20 -0400
Received: from smtp.pobox.com ([208.72.237.35]:51386 "EHLO smtp.pobox.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751273AbaFJGzT (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 10 Jun 2014 02:55:19 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 6415710E1F;
	Tue, 10 Jun 2014 02:55:18 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=UxvV0byMir+8Llk4mdH2kpk9OwU=; b=Zue89Q
	P0eUFWD2kr+AqZwKL7EUZs2QhxVwkTWhDQd5n6uge94npbfztKMr3mP1XMhRbvNr
	LlyRpsgouKeJgbnXehHmZ0MxN5DtxgB5N6xpesX8OJeIf+tmRSTR1e8jceVRBPxv
	u3tcTsp9kgd/nd1yf1vjNfVzLbE7zRAaNn6sk=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ENc6j5ufjlTIRun912qutMXSsuT8RUv4
	I+0IN8Gwotmz5bnnHz4seRAhSjgI8qa7dg88iUY1y/jQH0TuURMgsBtUSBbXbedp
	5UXudAI9hLhj2Jg8D42ms1ebB+cUUQWTb3cRgfz4J8UMNtw/9fOSavnjwQCuLkjB
	G3kI6iPAgFo=
Received: from pb-smtp0.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp0.pobox.com (Postfix) with ESMTP id 47D1610E1D;
	Tue, 10 Jun 2014 02:55:18 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp0.pobox.com (Postfix) with ESMTPSA id 5910710E16;
	Tue, 10 Jun 2014 02:55:14 -0400 (EDT)
In-Reply-To: <53969FDF.3050506@viscovery.net> (Johannes Sixt's message of
	"Tue, 10 Jun 2014 08:04:15 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: 2C6DE07A-F06C-11E3-B843-9903E9FBB39C-77302942!pb-smtp0.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/251167>

Johannes Sixt <j.sixt@viscovery.net> writes:

> And I get this when I compile on Windows with msysgit:
>
>     CC abspath.o
> In file included from git-compat-util.h:694,
>                  from cache.h:4,
>                  from abspath.c:1:
> compat/cpuid.h: In function 'processor_supports_sse42':
> compat/cpuid.h:11: warning: implicit declaration of function '__cpuid'
> abspath.c: At top level:
> compat/cpuid.h:8: warning: 'processor_supports_sse42' defined but not used
> abspath.c: In function 'processor_supports_sse42':
> compat/cpuid.h:11: warning: 'eax' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'ebx' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'ecx' is used uninitialized in this function
> compat/cpuid.h:11: warning: 'edx' is used uninitialized in this function
>
> Perhaps our gcc is too old?

Maybe.

In any case, it is a good indication that it probably is a good idea
to start with an optional USE_SSE42 (not !NO_SSE42 or HAVE_SSE42) so
that it is clear to anybody that those with SSE42 does not have to
use this compilation option.  Once the code proves itself, we can
consider turning it on by default when able, but it seems that it is
a bit too premature for that (not that the code itself is premature
in the original author's environment, but its portability has not
been quite ready for everybody yet, it seems).
