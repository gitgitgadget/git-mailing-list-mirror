From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] Add a REFNAME_ALLOW_UNNORMALIZED flag to check_ref_format()
Date: Sat, 10 Sep 2011 06:04:41 +0200
Message-ID: <4E6AE1D9.9010004@alum.mit.edu>
References: <1315568778-3592-1-git-send-email-mhagger@alum.mit.edu> <1315568778-3592-7-git-send-email-mhagger@alum.mit.edu> <7vpqj9s385.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, cmn@elego.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Sep 10 06:05:04 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1R2EoR-0002aO-Ga
	for gcvg-git-2@lo.gmane.org; Sat, 10 Sep 2011 06:05:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751706Ab1IJEE5 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 10 Sep 2011 00:04:57 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:32910 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751592Ab1IJEE5 (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 10 Sep 2011 00:04:57 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEAB10.dip.t-dialin.net [84.190.171.16])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p8A44fkj018899
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sat, 10 Sep 2011 06:04:42 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.21) Gecko/20110831 Lightning/1.0b2 Thunderbird/3.1.13
In-Reply-To: <7vpqj9s385.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/181137>

On 09/10/2011 01:30 AM, Junio C Hamano wrote:
> Michael Haggerty <mhagger@alum.mit.edu> writes:
>> Let the callers of check_ref_format() (and normalize_refname()) decide
>> whether to accept unnormalized refnames via a new
>> REFNAME_ALLOW_UNNORMALIZED flag.  Change callers to set this flag,
>> which preserves their current behavior.  (There are likely places
>> where this flag can be removed.)
> 
> [...]
> To put it another way, my knee jerk reaction is that we shouldn't need
> such a "flag". Shouldn't it be sufficient for normalize_refname() and
> nothing else to allow unnormalized input, and everybody else should barf
> when they see an un-normalized input?

That is a good idea.

I will make the current normalize_refname() function static and hide the
REFNAME_ALLOW_UNNORMALIZED option from the outside world.  Then I will
write a new public normalize_refname() function that calls the static
version with REFNAME_ALLOW_UNNORMALIZED set, and change
check_ref_format() to call normalize_refname() with
REFNAME_ALLOW_UNNORMALIZED unset.

What should I do with all of the current callers of check_ref_format(),
given that I don't want to be personally responsible for analyzing and
rewriting them all?  The hard-nosed approach would be to say that they
are calling check_ref_format() without normalizing the refnames, so they
are already broken (albeit perhaps sometimes accidentally functional),
and it is OK that the new behavior of check_ref_format() causes them to
fail explicitly.

A more forgiving approach would be to implement another transition
function like check_ref_format_deprecated_unsafe() that accepts
unnormalized refnames, change the callers to use this function during
the transition, and remove it only after all callers have been fixed.

Suggestions?

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
