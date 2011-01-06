From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Concurrent pushes updating the same ref
Date: Thu, 06 Jan 2011 11:37:57 -0800
Message-ID: <7v1v4pbz6y.fsf@alter.siamese.dyndns.org>
References: <4D25E3DE.7050801@xiplink.com>
 <20110106163035.GA7812@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Marc Branchaud <marcnarc@xiplink.com>,
	Git Mailing List <git@vger.kernel.org>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 06 20:38:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pavf3-0006K4-95
	for gcvg-git-2@lo.gmane.org; Thu, 06 Jan 2011 20:38:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752071Ab1AFTiI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 6 Jan 2011 14:38:08 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:36063 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751233Ab1AFTiH (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 6 Jan 2011 14:38:07 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 0DD0F3E55;
	Thu,  6 Jan 2011 14:38:44 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=Pdfsrbcrv6z+bBk4NmiINdI2Xis=; b=opiStY
	BVoJdEGB768ffEbSNBDdy/x8XvhRo2O3MP0D3PvLlSxF4krKmq5rqYNwny/rHQZF
	UKH8QXI+gJ6pZMRxbUm2M3Bxt5R03hoyrBX4MdsVYg36JQRwlek9yCe276B6NAFR
	XIVB6S0GE/O7i84K2Uc9sAdnCPD7E3wxwTjQc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=eiqJUWcGDNY1XRJ2PBuTt/H8RB+kt7Up
	r3Pwqgio9nitqRI+vtWltDosRpYCNA1zn2tfFno+kJ/q4GsJHdNZ1jzi5VBF1ohN
	jefO83xqpj3LtfS5epHjctZDyqT1gPX3jjhXlqj2t7IJuQMa1NgZNG13WBW+eCoQ
	3zKSjLe8500=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id D04583E52;
	Thu,  6 Jan 2011 14:38:40 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 9A9D83E50; Thu,  6 Jan 2011
 14:38:36 -0500 (EST)
In-Reply-To: <20110106163035.GA7812@sigill.intra.peff.net> (Jeff King's
 message of "Thu\, 6 Jan 2011 11\:30\:35 -0500")
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: 906C3862-19CC-11E0-A13A-CBB45B885003-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/164658>

Jeff King <peff@peff.net> writes:

> On Thu, Jan 06, 2011 at 10:46:38AM -0500, Marc Branchaud wrote:
>
>> fatal: Unable to create
>> '/usr/xiplink/git/public/Main.git/refs/builds/3.3.0-3.lock': File exists.
>> If no other git process is currently running, this probably means a
>> git process crashed in this repository earlier. Make sure no other git
>> process is running and remove the file manually to continue.
>> fatal: The remote end hung up unexpectedly
>> 
>> I think the cause is pretty obvious, and in a normal interactive situation
>> the solution would be to simply try again.  But in a script trying again
>> isn't so straightforward.
>> 
>> So I'm wondering if there's any sense or desire to make git a little more
>> flexible here.  Maybe teach it to wait and try again once or twice when it
>> sees a lock file.  I presume that normally a ref lock file should disappear
>> pretty quickly, so there shouldn't be a need to wait very long.
>
> Yeah, we probably should try again. The simplest possible (and untested)
> patch is below. However, a few caveats:
>
>   1. This patch unconditionally retries for all lock files. Do all
>      callers want that?

I actually have to say that _no_ caller should want this.  If somebody
earlier crashed, we would want to know about it (and how).  If somebody
else alive is actively holding a lock, why not make it the responsibility
of a calling script to decide if it wants to retry itself or perhaps
decide to do something else?
