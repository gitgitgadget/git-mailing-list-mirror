From: Chris Packham <judge.packham@gmail.com>
Subject: Re: [RFC/PATCH] submodule: add 'exec' option to submodule update
Date: Sat, 29 Jun 2013 21:11:14 +1200
Message-ID: <51CEA4B2.1090008@gmail.com>
References: <1372413190-32732-1-git-send-email-judge.packham@gmail.com> <20130628104243.GD27497@paksenarrion.iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org, Jens.Lehmann@web.de,
	stefan.naewe@atlas-elektronik.com
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Jun 29 11:10:22 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UsrAj-0005DZ-KF
	for gcvg-git-2@plane.gmane.org; Sat, 29 Jun 2013 11:10:21 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752765Ab3F2JKR (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 29 Jun 2013 05:10:17 -0400
Received: from mail-pa0-f49.google.com ([209.85.220.49]:53971 "EHLO
	mail-pa0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752621Ab3F2JKO (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 29 Jun 2013 05:10:14 -0400
Received: by mail-pa0-f49.google.com with SMTP id ld11so3270909pab.36
        for <git@vger.kernel.org>; Sat, 29 Jun 2013 02:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:to:cc:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=2TEs1/wb69kwAaYttYCxGiISBOqwlWM3lNhinhjbSa8=;
        b=w09i++/uFv0WKgYw6xD+tz95fQl1P4v/wrCwy4KOsRcJ7136tqlv/FL6lPLQHDmcXd
         YAnpDgilaelC+6qG6lI1h83UDhs4/V/zYJ3bREiTJlfFBJr+boupwSSNGCCXzs3ERq/G
         C5uhddsRp2aMmzNr1NvufQK0ZV1GYkmxamcEoyrjXonjvjhLeZcDlEesLkqbXAbIYpwq
         yvob39FGvlAqZ6TUnHxJ9EwBmV+azG7iHNRzdXse+ZTMup7eaTy0Ff4OjCZo2jozWO+r
         D9Ud3xwTwmdZhgWIS6N8z/GeKpsKwlu7v811tzWWAVxsfT/fXP6tJnDVFdMEUNMxFVPP
         txew==
X-Received: by 10.66.248.68 with SMTP id yk4mr15443335pac.137.1372497014309;
        Sat, 29 Jun 2013 02:10:14 -0700 (PDT)
Received: from laptop.site (115-188-15-163.jetstream.xtra.co.nz. [115.188.15.163])
        by mx.google.com with ESMTPSA id aj3sm13103646pad.8.2013.06.29.02.10.11
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Sat, 29 Jun 2013 02:10:13 -0700 (PDT)
User-Agent: Mozilla/5.0 (X11; Linux i686; rv:17.0) Gecko/20130510 Thunderbird/17.0.6
In-Reply-To: <20130628104243.GD27497@paksenarrion.iveqy.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/229250>

On 28/06/13 22:42, Fredrik Gustafsson wrote:
> Hi,
> 
> On Fri, Jun 28, 2013 at 09:53:10PM +1200, Chris Packham wrote:
>> This allows the user some finer grained control over how the update is
>> done. The primary motivation for this was interoperability with stgit
>> however being able to intercept the submodule update process may prove
>> useful for integrating or extending other tools.
>>
>> Signed-off-by: Chris Packham <judge.packham@gmail.com>
>> --
>> Hi,
>>
>> At $dayjob we have a number of users that are accustomed to using stgit.
>> Stgit doesn't play nicely with git rebase which would be the logical
>> setting for submodule.*.update for our usage. Instead we need to run
>> 'stg rebase --merged' on those submodules that have been initialised
>> with stgit.
>>
>> Our current solution is an in-house script which is a poor substitute
>> for git submodule update. I'd much rather replace our script with git
>> submodule update but we do have a requirement to keep stgit for the
>> foreseeable future.  Rather than narrowing in on stgit it seems logical
>> to allow an arbitrary update command to be executed.
>> ---
>>  Documentation/git-submodule.txt |  8 +++++++-
>>  git-submodule.sh                | 22 +++++++++++++++++++++-
>>  2 files changed, 28 insertions(+), 2 deletions(-)
>>
> 
> technically it looks fine to me (except for the lack of tests) but I'm
> not sure I follow the use case.
> 
> In your case, you want to run a script to determinate if that certain
> submodule should use merge or rebase depending on "whatever". And this
> can't be done with git submodule foreach because you want to know the
> sha1 to update to. Have I understood you correctly?
>

Correct. We tend to have submodules that are just normal detached heads
which we don't usually touch and others that are actively developed
where we would use submodule.x.update=rebase (I personally do) but some
developers want to use stgit on those repositories.

Another approach could be to do a 'git pull --no-recurse-submodule' then
use 'git submodule foreach script-that-does-the-rebase'. The benefit of
the patch I sent is that it can be setup using the config variables[1]
and updated the normal way along with the detached HEADs and those using
plain git branches.

There may be other use-cases for integration with other tools as well
(e.g. something that updates a review tool when commits get rebased).

--
[1] I'm not crazy about the name of submodule.*.update.command but I
couldn't think of a better one.
