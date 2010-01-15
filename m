From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH] Show submodules as modified when they contain a dirty
 work tree
Date: Fri, 15 Jan 2010 01:24:05 +0100
Message-ID: <4B4FB5A5.7080401@web.de>
References: <4B4BA096.5000909@web.de> <7vtyusb6rv.fsf@alter.siamese.dyndns.org> <4B4CA13F.6020505@web.de> <7vbpgyqy4a.fsf@alter.siamese.dyndns.org> <4B4E1817.1070202@web.de> <7v6375lkpj.fsf@alter.siamese.dyndns.org> <4B4F8EF1.3080709@web.de> <7v3a288em2.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Johannes Schindelin <Johannes.Schindelin@gmx.de>,
	"Shawn O. Pearce" <spearce@spearce.org>,
	Heiko Voigt <hvoigt@hvoigt.net>, Lars Hjemli <hjemli@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Jan 15 01:24:46 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NVZzY-0002Sy-TG
	for gcvg-git-2@lo.gmane.org; Fri, 15 Jan 2010 01:24:45 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757470Ab0AOAYl (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 14 Jan 2010 19:24:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1757351Ab0AOAYl
	(ORCPT <rfc822;git-outgoing>); Thu, 14 Jan 2010 19:24:41 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:43522 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757346Ab0AOAYk (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 14 Jan 2010 19:24:40 -0500
Received: from smtp08.web.de (fmsmtp08.dlan.cinetic.de [172.20.5.216])
	by fmmailgate03.web.de (Postfix) with ESMTP id E596A13C187EA;
	Fri, 15 Jan 2010 01:24:05 +0100 (CET)
Received: from [80.128.55.33] (helo=[192.168.178.26])
	by smtp08.web.de with asmtp (WEB.DE 4.110 #314)
	id 1NVZyv-00063A-00; Fri, 15 Jan 2010 01:24:05 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.1.5) Gecko/20091204 Thunderbird/3.0
In-Reply-To: <7v3a288em2.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1/YrRcXl2wM3cUSEQoTwFG0gdN78OfHuN+6D80F
	dA4tUxAB0Ptzx0uF5/0t05rFLl2CDo/mMFJTiWDoX3NlVP1Qaw
	anTvx7d2y9DBOidr6ZdA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/137044>

Am 15.01.2010 00:13, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> Subject: Show a modified submodule directory as dirty even if the refs match
>>
>> When the submodules HEAD and the ref committed in the HEAD of the
>> superproject were the same, "git diff[-index] HEAD" did not show the
>> submodule as dirty when it should.
>>
>> Signed-off-by: Jens Lehmann <Jens.Lehmann@web.de>
>> ---
>>  diff-lib.c                |    3 ++-
>>  t/t4027-diff-submodule.sh |   35 +++++++++++++++++++++++++++++++++++
>>  2 files changed, 37 insertions(+), 1 deletions(-)
>>
>> diff --git a/diff-lib.c b/diff-lib.c
>> index 5ce226b..9cdf6da 100644
>> --- a/diff-lib.c
>> +++ b/diff-lib.c
>> @@ -233,7 +233,8 @@ static int get_stat_data(struct cache_entry *ce,
>>  			return -1;
>>  		}
>>  		changed = ce_match_stat(ce, &st, 0);
>> -		if (changed) {
>> +		if (changed
>> +		    || (S_ISGITLINK(ce->ce_mode) && is_submodule_modified(ce->name))) {
> 
> You had a check in your previous patch that decides to call or skip
> diff_change() based on is_submodule_modified() for diff-files, but forgot
> to have the same for diff-index, which this patch does.  Perhaps we want
> to squash this into 4519d9c (Show submodules as modified when they contain
> a dirty work tree, 2010-01-13).

Of course you are right, the change you quoted should have been in my
patch in the first place. So squashing it seems to be the right thing to
do (but AFAICS the tests i added might be a problem, as they use
expect_from_to() which your intermediate patch added. Maybe squash these
tests into your patch and the diff you quoted above into mine?).


> The existing code is a bit unfortunate; by the time we come to the output
> routine, the information we found from is_submodule_modified() is lost;
> that is why my "would look like this" patch calls is_submodule_modified().
> 
> We may want to add one parameter to diff_change() and diff_addremove(), to
> tell them if the work-tree side (if we are comparing something with the
> work tree) is a modified submodule, and add one bit to the diff_filespec
> structure to record that in diff_change() and diff_addremove() (obviously
> only when adding).  That way, my "would looks like this" patch needs to
> check the result of is_submodule_modified() the front-ends left in the
> filespec, instead of running it again.

Good idea, i've been already exploring this line of thought too and came
to the same conclusion (i noticed that when calling plain "git diff" in a
repo with submodules, is_submodule_modified() gets called *three* times
for each submodule, which is not /that/ good for performance ;-). But i
intended to do this optimization in a subsequent patch (and in preparation
for "git diff --submodule" being able to print /how/ the submodule is
dirty without having to scan it again).
