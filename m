From: Johannes Sixt <j.sixt@viscovery.net>
Subject: Re: [PATCH v2 2/2] grep: stop looking at random places for .gitattributes
Date: Mon, 15 Oct 2012 08:02:24 +0200
Message-ID: <507BA6F0.4090500@viscovery.net>
References: <1349868894-3579-1-git-send-email-pclouds@gmail.com> <1349877544-17648-1-git-send-email-pclouds@gmail.com> <1349877544-17648-3-git-send-email-pclouds@gmail.com> <50758477.3030304@viscovery.net> <7vtxu2ayov.fsf@alter.siamese.dyndns.org> <50765CDC.8020509@viscovery.net> <7vpq4p80sn.fsf@alter.siamese.dyndns.org> <5077C7AC.9010301@viscovery.net> <7v4nlx3cc8.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: =?UTF-8?B?Tmd1eeG7hW4gVGjDoWkgTmfhu41jIER1eQ==?= 
	<pclouds@gmail.com>, git@vger.kernel.org, Jeff King <peff@peff.net>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Mon Oct 15 08:02:52 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1TNdlF-0003KI-Sc
	for gcvg-git-2@plane.gmane.org; Mon, 15 Oct 2012 08:02:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753335Ab2JOGCd (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 15 Oct 2012 02:02:33 -0400
Received: from so.liwest.at ([212.33.55.24]:34298 "EHLO so.liwest.at"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753281Ab2JOGCb (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 15 Oct 2012 02:02:31 -0400
Received: from [81.10.228.254] (helo=theia.linz.viscovery)
	by so.liwest.at with esmtpa (Exim 4.77)
	(envelope-from <j.sixt@viscovery.net>)
	id 1TNdku-0004eu-8C; Mon, 15 Oct 2012 08:02:24 +0200
Received: from [192.168.1.95] (J6T.linz.viscovery [192.168.1.95])
	by theia.linz.viscovery (Postfix) with ESMTP id E12861660F;
	Mon, 15 Oct 2012 08:02:23 +0200 (CEST)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:16.0) Gecko/20121010 Thunderbird/16.0.1
In-Reply-To: <7v4nlx3cc8.fsf@alter.siamese.dyndns.org>
X-Enigmail-Version: 1.4.5
X-Spam-Score: -1.0 (-)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/207691>

Am 10/14/2012 6:29, schrieb Junio C Hamano:
> Johannes Sixt <j.sixt@viscovery.net> writes:
> 
>> It might be worth it. We already have a similar special case in
>> write_or_die.c:maybe_flush_or_die() for Windows, although it is not about
>> a colon in a path name.
>>
>> Perhaps like this.
> 
> Hrm, the "we already have" one b2f5e26 (Windows: Work around an
> oddity when a pipe with no reader is written to., 2007-08-17) was
> what you added while I was looking the other way ;-) as a part of
> Windows specific pull.
> 
> That change, and this patch, seem to cover the cases to be ignored
> with a bit too wide a net to my taste.  On other systems, and even
> on Windows if the path does not have any colon, EINVAL is something
> we would want to noticbbe and report, as a potential problem, no?

For fopen(), EINVAL should occur only if the mode argument is wrong, which
it isn't. For fflush() (as in write_or_die.c), EINVAL is not even listed
as possible error code. Therefore, catching EINVAL wholesale should not be
a problem, IMO, at least not "on other systems".

On Windows, it is more problematic because there is a table of "customary"
Windows API error codes, which are mapped to errno values, and EINVAL is
used for all other Windows error codes (and for a few listed ones), and
ignoring EINVAL might indeed miss something worth to be reported.

Sooo... I don't mind if you do not pick up this patch because it handles a
rather theoretic case, i.e., where a project with strange paths somehow
ended up on a Windows drive.

But reverting the EINVAL check from write_or_die.c is out of question,
because that handles a real case.

-- Hannes
