From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: GSOC proposal
Date: Sat, 26 Mar 2011 00:07:00 +0100
Message-ID: <4D8D2014.3050603@web.de>
References: <20110324220104.GA18721@paksenarrion.iveqy.com> <4D8BD358.1030603@web.de> <7vtyes6pya.fsf@alter.siamese.dyndns.org> <20110325100600.GA30376@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <gitster@pobox.com>, git@vger.kernel.org
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Mar 26 00:07:29 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q3G6H-00021L-Bo
	for gcvg-git-2@lo.gmane.org; Sat, 26 Mar 2011 00:07:25 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755515Ab1CYXHU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 25 Mar 2011 19:07:20 -0400
Received: from fmmailgate03.web.de ([217.72.192.234]:49016 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753072Ab1CYXHU (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 25 Mar 2011 19:07:20 -0400
Received: from smtp01.web.de  ( [172.20.0.243])
	by fmmailgate03.web.de (Postfix) with ESMTP id 70C3C18A73F77;
	Sat, 26 Mar 2011 00:07:08 +0100 (CET)
Received: from [93.240.108.46] (helo=[192.168.178.43])
	by smtp01.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Q3G60-00034B-00; Sat, 26 Mar 2011 00:07:08 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.15) Gecko/20110303 Thunderbird/3.1.9
In-Reply-To: <20110325100600.GA30376@paksenarrion.iveqy.com>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX194hw3rI4aUyfCfM9HtThAq6zaVEfW4wJ5o9aFA
	vF6K10xHFmqJ0B3PqPumVCYd0nQNZ2ZddMzItsTKbNdU+Tyl+i
	IRcIeCLts/qJH4b7/tug==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170031>

Am 25.03.2011 11:06, schrieb Fredrik Gustafsson:
> On Thu, Mar 24, 2011 at 04:47:41PM -0700, Junio C Hamano wrote:
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>>
>>>> == Preventing false "pointers" ==
>>>> It's far too easy to push a gitrepo pointing to a submodule version that
>>>> is not existing on the server. Prevent this by checking for available
>>>> submodule versions before acceptingt the push.
>>>
>>> Yes, requiring to force such a push is an issue raised quite often (I
>>> think addressing this issue would be a good starting point for people
>>> who want to get involved in enhancing the submodule experience).
>>
>> You need to be careful, though.
>>
>> That check can only be sanely done at a hosting site that hosts _both_ the
>> superproject and the submodule repositories.  It might make more sense to
>> have this check on the side that pushes, which by definition should have
>> both superprojet and the submodule.  Fail, or prompt to confirm, a push
>> from the superproject when it is detected that the submodule commits bound
>> to the commits in the superproject have not been pushed out.
> 
> I can see three different ways of doing this:
> 1. the reciever (server) checks for available submodules before
> accepting a commit
> 
> 2. the sender checks for available submodules on the server before
> sending a commit.
> 
> 3. each submodule contains a flag that tells if the last command was a
> commit or a push. The core-repository wont allow a push if one (or more)
> submodules has a commit as "last command".
> 
> Although alternative 1 is the only one that is certain of preventing the
> problem with "false pointers", it has several other drawbacks. I believe
> that alt. 3 is the proper way of handling this in git. Although we
> doesn't guarantee a sane server-repo we does prevent the client from
> doing stupid things by mistake.

I concur with Junio and am in favor of the following solution, as I
think we already have all the information needed present on the side
that pushes:

Before doing a push in the superproject collect all submodule commits
that are recorded in the commits to be pushed out to the superproject's
remote. Then check that they all are contained in at least one remote
ref of the submodule they are recorded for. If not, error out and tell
the user he should push the submodule first or has to use the "-f" flag
to force the push if he really knows what he is doing. Commits of those
submodules that aren't checked out are ignored.

This approach would achieve the goal you stated in your last sentence,
which me thinks is a sane thing to do.
