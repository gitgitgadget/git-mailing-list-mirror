From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: [1.7.5] Let fetch and pull recurse into submodules when new commits
 are recorded
Date: Sat, 19 Feb 2011 17:40:04 +0100
Message-ID: <4D5FF264.5050002@web.de>
References: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Feb 19 17:40:18 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pqpqz-0001kE-ME
	for gcvg-git-2@lo.gmane.org; Sat, 19 Feb 2011 17:40:18 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751584Ab1BSQkM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 19 Feb 2011 11:40:12 -0500
Received: from fmmailgate03.web.de ([217.72.192.234]:51554 "EHLO
	fmmailgate03.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750842Ab1BSQkL (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 19 Feb 2011 11:40:11 -0500
Received: from smtp02.web.de  ( [172.20.0.184])
	by fmmailgate03.web.de (Postfix) with ESMTP id 50A9A188F48F0;
	Sat, 19 Feb 2011 17:40:10 +0100 (CET)
Received: from [93.246.50.213] (helo=[192.168.178.43])
	by smtp02.web.de with asmtp (WEB.DE 4.110 #2)
	id 1Pqpqs-00061F-00; Sat, 19 Feb 2011 17:40:10 +0100
User-Agent: Mozilla/5.0 (X11; U; Linux i686; de; rv:1.9.2.13) Gecko/20101207 Thunderbird/3.1.7
In-Reply-To: <7vwrky5f48.fsf@alter.siamese.dyndns.org>
X-Sender: Jens.Lehmann@web.de
X-Provags-ID: V01U2FsdGVkX1+D+2rD6C1/MG3T7aaCd15/lrjbFV7jWwvRs2fT
	tAbdiU+716OiVU37lBCbUU8npZWoOs1rHuCV9S46XnAYj25u2W
	W6p2JFJV+WONFPPd65sA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167301>

Am 18.02.2011 02:02, schrieb Junio C Hamano:
> It seems that not many things need breaking, but we will break some.
> 
> Here are the ones that needed discussion and were discussed that I am
> aware of, with my comments (which shouldn't be read as final decision).

Sorry for not having posted this earlier:

Proposal:
Add a new "on-demand" mode to fetch and pull and make it the default.

When using the new "on-demand" mode every time new commits are fetched
in the superproject they will be parsed for submodule commits. If these
commits aren't present in a populated submodule, run "git fetch" inside
that submodule. (Also see this thread for an in depth discussion:
http://article.gmane.org/gmane.comp.version-control.git/158979/ )

Additionally change "git submodule update" to only then run fetch in a
submodule when the commit it wants to check out is not already present
there.

This behavior can be configured per submodule, per repo and globally.

Advantages:
* Disconnected operation. Right now it is really easy to forget to fetch
  all submodules before you get on a plane, possibly leaving you unable
  to check out certain revisions.
* "git diff --submodule" (which is used by git gui and gitk) needs those
   submodule commits to provide meaningful output
* "git merge" needs them to be able to merge submodule commits
* This is the least surprising behavior for new submodule users
(The upcoming recursive checkout will rely on the commits being present
too)

Risks:
People might be annoyed by the extra time it takes to fetch the submodules
when they only expect the superproject to be fetched. Others might be
surprised that "git submodule update" doesn't do a fetch anymore.

Migration plan:
Announce the change in behavior and document how to easily configure the
old behavior when wanted and enable this functionality in 1.7.5.
