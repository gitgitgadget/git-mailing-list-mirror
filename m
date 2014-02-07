From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [WIP/PATCH 4/9] Teach merge the --[no-]recurse-submodules option
Date: Fri, 07 Feb 2014 22:23:35 +0100
Message-ID: <52F54ED7.2010302@web.de>
References: <xmqqd2k4hh4p.fsf@gitster.dls.corp.google.com>	<52CC3E16.4060909@web.de>	<xmqqvbxvekwv.fsf@gitster.dls.corp.google.com>	<52EFF25E.6080306@web.de> <52EFF311.1090202@web.de> <xmqq4n4fdcnd.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Jonathan Nieder <jrnieder@gmail.com>,
	Heiko Voigt <hvoigt@hvoigt.net>,
	"W. Trevor King" <wking@tremily.us>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Fri Feb 07 22:23:44 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WBsti-00020z-Hy
	for gcvg-git-2@plane.gmane.org; Fri, 07 Feb 2014 22:23:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751705AbaBGVXj (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 7 Feb 2014 16:23:39 -0500
Received: from mout.web.de ([212.227.17.12]:63222 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751617AbaBGVXi (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 7 Feb 2014 16:23:38 -0500
Received: from [192.168.178.41] ([84.132.186.180]) by smtp.web.de (mrweb102)
 with ESMTPA (Nemesis) id 0LwYs7-1V9Mwx1I35-018JFq for <git@vger.kernel.org>;
 Fri, 07 Feb 2014 22:23:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:24.0) Gecko/20100101 Thunderbird/24.3.0
In-Reply-To: <xmqq4n4fdcnd.fsf@gitster.dls.corp.google.com>
X-Enigmail-Version: 1.6
X-Provags-ID: V03:K0:NqLmSCkyJnpZtqme6LxObgBprsLwhZxgFtnKJgsgFMmYsR3osyp
 Loyv/KjO2wZW95As15KWR51Ho7uQZQSP91BrXyzGvngh6OsOessC2Aic26vxu4YZoLeqG1C
 ENIPklD/eYeuQUqmXHDZntj4++hkBq6wyOsv52jrdLeXYJExfMxNvVIH+ZC8LKlaSzv0onh
 TzZxAgqZlcQZuP4HWbmKQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/241802>

Am 04.02.2014 00:01, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
> 
>> This new option will allow the user to not only update the work tree of
>> the superproject according to the merge result but to also update the
>> work tree of all initialized submodules (so they match the SHA-1 recorded
>> in the superproject). But this commit only adds the option without any
>> functionality, that will be added to unpack_trees() in subsequent commits.
> 
> When the two branches of the superproject being merged wants to put
> a submodule project to commit A and B, that conflict needs to be
> resolved, but if they agree that the submodule project should be at
> C (which is different from what the current superproject HEAD has
> for the submodule in its gitlink), then we want a checkout of that
> commit to happen in that submodule.  Makes sense.
> 
> After resolving such a conflict between A and B, who is responsible
> to adjust the working tree state of the submodule involved, by the
> way?  "git merge --continue" does not exist and its moral equivalent
> to conclude such an interrupted merge is "git commit".  Should it
> learn to do "recurse-submodule", or should the user run a separate
> "checkout --recurse-submodule"?

I think the user needs to sort things out, just like she has to do
when a file has a merge conflict. But unfortunately we cannot use
conflict markers here, so I'd propose the following:

* When merge proposes a merge resolution (which it does today by
  telling the user "Found a possible merge resolution for the
  submodule ... [use] git update-index --cacheinfo 160000 ...")
  that commit should be checked out in the submodule but not
  staged. Then the user can simply add and commit.

* If the merge resolution is not obvious to merge, it leaves the
  submodule in an unmerged state, the local commit still being
  checked out. The user has to manually do the merge in the
  submodule and commits that in the superproject.

Does that make sense?
