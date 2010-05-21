From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: git-status and git-diff now very slow in project with a submodule
Date: Fri, 21 May 2010 14:05:36 +0200
Message-ID: <4BF67710.30805@web.de>
References: <ht3194$1vc$1@dough.gmane.org> <7vy6fe7ldo.fsf@alter.siamese.dyndns.org> <201005201817.05593.andyparkins@gmail.com> <7vbpca6uxi.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Andy Parkins <andyparkins@gmail.com>, git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri May 21 14:05:48 2010
connect(): No such file or directory
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1OFQz4-0000ti-86
	for gcvg-git-2@lo.gmane.org; Fri, 21 May 2010 14:05:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754236Ab0EUMFl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 21 May 2010 08:05:41 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:55525 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753490Ab0EUMFk (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 21 May 2010 08:05:40 -0400
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id B2DCF1514B00E;
	Fri, 21 May 2010 14:05:38 +0200 (CEST)
Received: from [80.128.116.178] (helo=[192.168.178.26])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #4)
	id 1OFQyv-0005M5-00; Fri, 21 May 2010 14:05:37 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.9) Gecko/20100317 Thunderbird/3.0.4
In-Reply-To: <7vbpca6uxi.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX18b2PXl/IxzkTyAyMPoiCFxZRtcf8M8Pi1KKSqi
	0gf9qHQDKCLafyCoL4jO2nx8N9DOW0HV+GSrQWPW4L6naEighi
	RgySaOf8+CBqfKXkVl5A==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/147448>

Am 21.05.2010 00:59, schrieb Junio C Hamano:
> At least we should be able to let the users say, with "git status -uno",
> "I don't care about untracked and unignored paths; I don't make such a
> mistake to forget adding new paths", and optimize the scanning of
> submodule directories taking advantage of that statement.  Is there a
> fundamental reason why things shouldn't work that way, or is it just a
> bug in the current code?

It works that way since 3bfc450. "git status" (and the diff family when
comparing against the work tree) forks a "git status" for each submodule
that is populated. If the status command in the superproject is started
with "-uno" the same option is used for the "git status" forked in the
populated submodules, so no checking for untracked files is done in that
case.

But that doesn't speed up that process much, as the tracked files inside
the submodules have to be checked for modifications anyway, no matter if
"-uno" is used or not. Getting rid of the fork of a new "git status" by
using an alternate odb is on my to do list. Apart from gaining some time
by avoiding the fork (which is a per-submodule-constant) we could terminate
early in case we find a modification (instead of continuing as the current
approach does). But only dirty submodules would profit from that, a clean
submodule won't be scanned much faster that way AFAICS.
