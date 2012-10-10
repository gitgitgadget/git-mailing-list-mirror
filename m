From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 'git grep needle rev' attempts to access
 'rev:.../.gitattributes' in the worktree
Date: Tue, 09 Oct 2012 22:33:44 -0700
Message-ID: <7vwqyydh6v.fsf@alter.siamese.dyndns.org>
References: <5073E87D.9020100@viscovery.net>
 <CACsJy8BFmUr5_E47900T6j9Lgdvj96_dNbo2LHP5hLYq3w7ZLA@mail.gmail.com>
 <20121009120144.GA8780@do> <20121009124144.GB12465@sigill.intra.peff.net>
 <7vk3uzfp3p.fsf@alter.siamese.dyndns.org>
 <CACsJy8Cku-XTbQBDpZpPh7AMDFMoNKLKeJNs5HKCQnBy420d2w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Jeff King <peff@peff.net>, Johannes Sixt <j.sixt@viscovery.net>,
	Git Mailing List <git@vger.kernel.org>
To: Nguyen Thai Ngoc Duy <pclouds@gmail.com>
X-From: git-owner@vger.kernel.org Wed Oct 10 07:33:59 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TLove-00063u-Pi
	for gcvg-git-2@plane.gmane.org; Wed, 10 Oct 2012 07:33:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752601Ab2JJFdr (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 10 Oct 2012 01:33:47 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:44401 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751862Ab2JJFdq (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 10 Oct 2012 01:33:46 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 595A160A0;
	Wed, 10 Oct 2012 01:33:46 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=C7CcgAc0dq7LPZauJyVeqffLfTk=; b=nRRV+X
	fQ0eGkzEzTcS3Td2V9e35FlYYoWIsOf0/FkxVNtopBz7bUxGkPFOsbIa16fampXj
	pPl3pMPYQ9R579E3debKu9C598p9tcBSiLo6SJZA3on9QPUlFYB/GAyOK4s2IISh
	3rr5xRV51oW70UJ+1y+jUQHrlWmiaQ3Jx5ySY=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ouOJMnqMG/M2brgNbXT19/8OhsGXkeWS
	wP7RA5uRmmZq+ZbGSAQVFRf+t6+ujl72KwxRJuDg5dWi0Y0QYHxkBVPsGu7zurH6
	V7HBnoWlMaf0zv7zcpN4L9YAsFmKhHrk5PP6QtxHIQJ/RWRw2wssqjG8IaYZ5yXs
	sQ3gKTiL9U0=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 45D80609F;
	Wed, 10 Oct 2012 01:33:46 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 95641609E; Wed, 10 Oct 2012
 01:33:45 -0400 (EDT)
In-Reply-To: <CACsJy8Cku-XTbQBDpZpPh7AMDFMoNKLKeJNs5HKCQnBy420d2w@mail.gmail.com> (Nguyen
 Thai Ngoc Duy's message of "Wed, 10 Oct 2012 12:17:53 +0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 0F58C7D4-129C-11E2-9291-BB652E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207364>

Nguyen Thai Ngoc Duy <pclouds@gmail.com> writes:

> On Wed, Oct 10, 2012 at 1:59 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Jeff King <peff@peff.net> writes:
>>
>>> I think we just need to have callers of grep_source_init provide us with
>>> the actual pathname (or NULL, in the case of GREP_SOURCE_BUF). That is
>>> where the information is lost.
>>
>> Yes.  I agree that is the right approach.
>
> Passing full path this way means prepare_attr_stack has to walk back
> to top directory for every files (even in the same directory). If
> .gitattributes are loaded while git-grep traverses the tree, then it
> can preload attr once per directory. But Jeff's approach looks
> simpler.

Why can't you do both?  That is, to build a full path as you
descend, and read per-directory .gitattributes as you go?

Confused...
