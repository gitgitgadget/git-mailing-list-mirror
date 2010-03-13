From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] git status: ignoring untracked files must apply to submodules
 too
Date: Sun, 14 Mar 2010 00:08:28 +0100
Message-ID: <4B9C1AEC.2070605@web.de>
References: <4B9C0AFB.1050306@web.de> <7vhboj6et9.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Sergio Callegari <sergio.callegari@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sun Mar 14 00:08:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1NqaRq-0001BF-00
	for gcvg-git-2@lo.gmane.org; Sun, 14 Mar 2010 00:08:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752219Ab0CMXIb (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 13 Mar 2010 18:08:31 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:45768 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751261Ab0CMXIa (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 13 Mar 2010 18:08:30 -0500
Received: from smtp05.web.de (fmsmtp05.dlan.cinetic.de [172.20.4.166])
	by fmmailgate03.web.de (Postfix) with ESMTP id 0B0E714437C0E;
	Sun, 14 Mar 2010 00:08:29 +0100 (CET)
Received: from [80.128.109.251] (helo=[192.168.178.26])
	by smtp05.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NqaRY-0004Ub-00; Sun, 14 Mar 2010 00:08:28 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.8) Gecko/20100227 Thunderbird/3.0.3
In-Reply-To: <7vhboj6et9.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+oc/pu6i7Ce7Bzzugd6WJddPEDLSZqjumYemM+
	T8O9rfIZAWYPMJFngrAy3VZLg8QFqtP5TeC41SvoktiELG5JDM
	Md/kvpyySll7zJZVBC0Q==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/142121>

Am 13.03.2010 23:24, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Since 1.7.0 submodules are considered dirty when they contain untracked
>> files. But when git status is called with the "-uno" option, the user
>> asked to ignore untracked files, so they must be ignored in submodules
>> too. To achieve this, the new flag DIFF_OPT_IGNORE_UNTRACKED_IN_SUBMODULES
>> is introduced.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>
>> This patch applies on top of current pu.
>>
>> I'm open to suggestions for a shorter name for the new diff option
>> IGNORE_UNTRACKED_IN_SUBMODULES; I did not manage to come up with a
>> shorter yet still descriptive enough name.
> 
> Why do you even need that flag?  Isn't it the matter of deciding to ignore
> or pay attention to the DIRTY_SUBMODULE_UNTRACKED bit in the return value
> of is_submodule_modified(), depending on whether the toplevel wt_status
> was called with -uno?

First: When called from "git status" run_diff_files() calls
wt_status_collect_changed_cb() for every file it considers changed, so
when the "-uno" option is given for a submodule with only untracked files
i thought it cleaner to let is_submodule_modified() return 0 so this
callback is not called at all and the submodule won't show up in the
"change" list of wt_status (Yes, this could be done by not adding such a
submodule to that list in the wt_status_collect_changed_cb() too).

Second: One of my next patches will be about adding an option to the git
diff family to not show submodules with only untracked files in their
work tree as modified, which calls for such a diff option AFAICS.

Third: We give is_submodule_modified() the possibility to stop parsing the
output of the "git status" run in the submodule early, because as soon as
it sees a modified file it will stop to parse the output further when
untracked files shall be ignored.
