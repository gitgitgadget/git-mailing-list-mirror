From: Michael Haggerty <mhagger@alum.mit.edu>
Subject: Re: [PATCH 6/6] Retain caches of submodule refs
Date: Sun, 09 Oct 2011 13:12:20 +0200
Message-ID: <4E918194.5060102@alum.mit.edu>
References: <1313188589-2330-1-git-send-email-mhagger@alum.mit.edu> <1313188589-2330-7-git-send-email-mhagger@alum.mit.edu> <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jeff King <peff@peff.net>,
	Drew Northup <drew.northup@maine.edu>,
	Jakub Narebski <jnareb@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Oct 09 13:13:14 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RCrJf-000113-Hg
	for gcvg-git-2@lo.gmane.org; Sun, 09 Oct 2011 13:13:11 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752434Ab1JILNA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 9 Oct 2011 07:13:00 -0400
Received: from einhorn.in-berlin.de ([192.109.42.8]:53253 "EHLO
	einhorn.in-berlin.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752273Ab1JILMq (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 9 Oct 2011 07:12:46 -0400
X-Envelope-From: mhagger@alum.mit.edu
Received: from [192.168.69.134] (p54BEDFD0.dip.t-dialin.net [84.190.223.208])
	(authenticated bits=0)
	by einhorn.in-berlin.de (8.13.6/8.13.6/Debian-1) with ESMTP id p99BCM1q005114
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Sun, 9 Oct 2011 13:12:24 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.23) Gecko/20110921 Lightning/1.0b2 Thunderbird/3.1.15
In-Reply-To: <7v4o1hgemp.fsf@alter.siamese.dyndns.org>
X-Scanned-By: MIMEDefang_at_IN-Berlin_e.V. on 192.109.42.8
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/183196>

On 08/17/2011 12:45 AM, Junio C Hamano wrote:
> All the changes except for this one made sense to me, but I am not sure
> about this one. How often do we look into different submodule refs in the
> same process over and over again?

I am having pangs of uncertainty about this patch.

Previous to this patch, the submodule reference cache was only used for
the duration of one call to do_for_each_ref().  (It was not *discarded*
until later, but the old cache was never reused.)  Therefore, the
submodule reference cache was implicitly invalidated between successive
uses.

After this change, submodule ref caches are invalidated whenever
invalidate_cached_refs() is called.  But this function is static, and it
is only called when main-module refs are changed.

AFAIK there is no way within refs.c to add, modify, or delete a
submodule reference.  But if other code modifies submodule references
directly, then the submodule ref cache in refs.c would become stale.
Moreover, there is currently no API for invalidating the cache.

So I think I need help from a submodule guru (Heiko?) who can tell me
what is done with submodule references and whether they might be
modified while a git process is executing in the main module.  If so,
then either this patch has to be withdrawn, or more work has to be put
in to make such code invalidate the submodule reference cache.

Sorry for the oversight, but I forgot that not all code necessarily uses
the refs.c API when dealing with references (a regrettable situation, BTW).

Michael

-- 
Michael Haggerty
mhagger@alum.mit.edu
http://softwareswirl.blogspot.com/
