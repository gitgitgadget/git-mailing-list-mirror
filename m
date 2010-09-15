From: Kevin Ballard <kevin@sb.org>
Subject: Re: [RFC PATCH 0/2] Teach fetch and pull to recursively fetch submodules too
Date: Tue, 14 Sep 2010 19:40:50 -0700
Message-ID: <89574F83-293C-4E3E-A99D-EB6CE6D47646@sb.org>
References: <4C7A819B.3000403@web.de> <7vocckhcb6.fsf@alter.siamese.dyndns.org> <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
Mime-Version: 1.0 (Apple Message framework v1081)
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8BIT
To: Git Mailing List <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Wed Sep 15 04:41:00 2010
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ovhvf-00077U-M6
	for gcvg-git-2@lo.gmane.org; Wed, 15 Sep 2010 04:41:00 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752222Ab0IOCky (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Sep 2010 22:40:54 -0400
Received: from mail-pw0-f46.google.com ([209.85.160.46]:50513 "EHLO
	mail-pw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752066Ab0IOCkx convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 14 Sep 2010 22:40:53 -0400
Received: by pwi3 with SMTP id 3so22126pwi.19
        for <git@vger.kernel.org>; Tue, 14 Sep 2010 19:40:53 -0700 (PDT)
Received: by 10.114.88.15 with SMTP id l15mr968170wab.191.1284518452767;
        Tue, 14 Sep 2010 19:40:52 -0700 (PDT)
Received: from [10.8.0.89] ([69.170.160.74])
        by mx.google.com with ESMTPS id d2sm1438570wam.2.2010.09.14.19.40.51
        (version=TLSv1/SSLv3 cipher=RC4-MD5);
        Tue, 14 Sep 2010 19:40:51 -0700 (PDT)
In-Reply-To: <778BC76C-FDFA-4EF0-AA94-6631272DEC02@sb.org>
X-Mailer: Apple Mail (2.1081)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/156223>

To those CC'd on the original message, sorry for the repeat send to the list but the original was rejected due to not being text/plain.

On Sep 14, 2010, at 5:18 PM, Kevin Ballard wrote:

> On Aug 29, 2010, at 10:58 PM, Junio C Hamano wrote:
> 
>> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> 
>>> So I extended the fetch command to fetch populated submodules too. I
>>> also added a command line option to fetch and pull and the second patch
>>> introduces a per submodule config option to give users the chance to
>>> control that behavior.
>>> 
>>> And maybe we need a config option to customize that behavior
>>> for all submodules or all repos too?
>>> 
>>> Opinions?
>> 
>> I think your "if a particular submodule is already initialized, recursing
>> into it is more likely than not what the user wants" is a sound heuristic.
> 
> This was just merged onto the next branch a few days ago, so I finally got a chance to test it out, and it's not pretty. The project I'm working in has a bunch of submodules, and this makes a simple `git fetch` take about 20 seconds. Even worse, it makes `git remote update` take significantly longer, as it apparently fetches all submodules twice. As a comparison, with all the submodule fetching turned off, a normal `git fetch` takes about 1.5 seconds. Oddly enough, it doesn't seem to be fetching submodules recursively - one of my submodules has a whole tree of about 6 different submodules, but those embedded submodules aren't being fetched.
> 
> There seems to be 3 issues here. The first is `git remote update`, which I am fond of using, causes buggy behavior where it fetches all submodules twice. The second is this submodule fetch doesn't appear to be recursive. The third issue is `git fetch` doesn't have any business fetching submodules when the submodule reference was never changed as part of the fetch, especially if the main fetch itself didn't even find any changes. It seems to me that the correct behavior would be to look at all the fetched commits to see if any of them change the submodule reference, and only in that case should it automatically fetch any submodules whose references were modified. The stated desire of avoiding "(commits not present)" when doing a diff will still be met, but it will avoid slowing down the n
 ormal case of a `git fetch`.
> 
> It also seems like there ought to be a config variable one can set for the default behavior if submodule.<name>.fetch is not present in .gitmodules or in .git/config.

Turns out the recursive fetch behavior is a bit more subtle than I thought. It actually recurses one level deep into submodules, but no further. I have a submodule foo, which has a submodule bar, which has a submodule baz, and when I run `git fetch` I get

Fetching submodule foo
Fetching submodule bar

There's two problems here. The first is it doesn't tell me that bar is actually foo/bar, and the second is it never fetches baz.

-Kevin Ballard