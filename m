From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/6] path: Make the 'get_st_mode_bits' symbol a file static
Date: Sun, 28 Apr 2013 12:06:13 -0700
Message-ID: <7vip36qxui.fsf@alter.siamese.dyndns.org>
References: <517C1BF9.2050604@ramsay1.demon.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: tboegi@web.de, GIT Mailing-list <git@vger.kernel.org>
To: Ramsay Jones <ramsay@ramsay1.demon.co.uk>
X-From: git-owner@vger.kernel.org Sun Apr 28 21:06:41 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UWWvo-0006pn-1V
	for gcvg-git-2@plane.gmane.org; Sun, 28 Apr 2013 21:06:40 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756517Ab3D1TGT (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 28 Apr 2013 15:06:19 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57318 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756491Ab3D1TGQ (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 28 Apr 2013 15:06:16 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 901821844B;
	Sun, 28 Apr 2013 19:06:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=JVyhwQcevSbr19AwvYzJM8qhnrs=; b=pZ8uhW
	XPUdVQk31wf+JCGVH0AbSgN3EfpNszuMvqdCvWrf+3J6C7RgZrcgDJ+ql9ar+SVF
	bHruIBBdjtBTRk+KvD8OBdoXGffuhj+GkTIER5WQs5Waz8cKRQ8DBy5h+VHM4dMK
	o8s6u7W+gmUEcjhueVF1O5m2OIGyidsBqPOjA=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=NSU324wuNdmbEaTYlq8UY9+nXGjJUA47
	3wkKc9LVFh3OvFQZcnWFH9wF8+9Ff6HFTxJtODf2RDiY7rAEIAEpUcQJRrNKy8jb
	bCVDuiCg3szfQLHDNd5fyXH4E6shdO7OJ8ShGZTjkJa+ppJ5iclwKE8zDUyn8Gel
	iezYJ8SIUtE=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 840D41844A;
	Sun, 28 Apr 2013 19:06:15 +0000 (UTC)
Received: from pobox.com (unknown [24.4.35.13])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 08BA118447;
	Sun, 28 Apr 2013 19:06:14 +0000 (UTC)
In-Reply-To: <517C1BF9.2050604@ramsay1.demon.co.uk> (Ramsay Jones's message of
	"Sat, 27 Apr 2013 19:42:01 +0100")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: B2E2DD44-B036-11E2-A4F8-BCFF4146488D-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/222743>

Ramsay Jones <ramsay@ramsay1.demon.co.uk> writes:

> On MinGW, sparse issues an "'get_st_mode_bits' not declared. Should
> it be static?" warning. The MinGW and MSVC builds do not see the
> declaration of this function, within git-compat-util.h, due to it's
> placement within an preprocessor conditional. (So, one solution would
> be to simply move the declaration to the top level of the header.)

Well, the idea was that the user of this function in path.c will
call get_st_mode_bits(), and whatever platform that provides a
replacement implementation would do

	#define get_st_mode_bits(a,b) cygwin_get_st_mode_bits((a),(b))

so that the calling site in path.c will end up calling that
replacement implementation.  So if anything get_st_mode_bits()
declaration may want to go at the _end_ (not top) after including
all the compatibility crufts.

We could make the declaration static to path.c, but then nobody
other than path.c would be able to make use of it in the future,
and we'll have the same discussion when somebody wants to hoist the
declaration to git-compat-util.h, no?
