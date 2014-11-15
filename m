From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [RFC] On watchman support
Date: Sat, 15 Nov 2014 08:24:44 +0100
Message-ID: <5466FFBC.6020207@web.de>
References: <20141111124901.GA6011@lanh> <54643C30.6010204@web.de> <CACsJy8AKsvL2XcBMGG1Jy_W2KaOCuYm16Ffk529KDOARr68XNQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git Mailing List <git@vger.kernel.org>,
	David Turner <dturner@twopensource.com>
To: Duy Nguyen <pclouds@gmail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
X-From: git-owner@vger.kernel.org Sat Nov 15 08:25:07 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XpXjG-0001dL-Qd
	for gcvg-git-2@plane.gmane.org; Sat, 15 Nov 2014 08:25:07 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752717AbaKOHY4 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Sat, 15 Nov 2014 02:24:56 -0500
Received: from mout.web.de ([212.227.17.12]:53361 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752003AbaKOHYz (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 15 Nov 2014 02:24:55 -0500
Received: from macce.local ([78.72.74.102]) by smtp.web.de (mrweb102) with
 ESMTPSA (Nemesis) id 0MOilO-1XsGkn11Gw-0066UZ; Sat, 15 Nov 2014 08:24:51
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.2.0
In-Reply-To: <CACsJy8AKsvL2XcBMGG1Jy_W2KaOCuYm16Ffk529KDOARr68XNQ@mail.gmail.com>
X-Provags-ID: V03:K0:mKNqJmlt5S74gz63VO4o8WrCb5dyCrDP6A7A0OFELHgoTLHWQPa
 v2ms1F76WCVQhCBjgE4IxNCZkUtn1QK6DdUadDE3zs7CDi3IIYG+xvV5YjIU+30624SZ/vd
 Y4q+nh5xCfwGCnwIpaWdDFhE68Wh9hG9fHkVkap/RHdXed3Xo2dvn8cgyuYprHYbYQXcH9Y
 vdS/zezR1Vg5+aptR/UsA==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

On 11/13/2014 01:22 PM, Duy Nguyen wrote:
> On Thu, Nov 13, 2014 at 12:05 PM, Torsten B=C3=B6gershausen <tboegi@w=
eb.de> wrote:
>> From a Git user perspective it could be good to have something like =
this:
>>
>> a) git status -u
>> b) git status -uno
>> c) git status -umtime
>> d) git status -uwatchman
>>
>> We know that a) and b) already exist.
>> c) Can be convenient to have, in order to do benchmarking and testin=
g.
>>   When the UNTR extension is not found, Git can give an error,
>>   saying something like this:
>>   No mtime information found, use "git update-index --untracked-cach=
e"
>> d) does not yet exist
>>
>> Of course we may want to configure the default for "git status" in a=
 default variable,
>> like status.findUntrackedFiles, which can be empty "", "mtime" or "w=
atchman",
>> and we may add other backends later.
> While "git status" is in the spotlight, these optimizations have wide=
r
> impact. Faster index read/refresh/write helps the majority of
> commands. Faster untracked listing hits git-status, git-add,
> git-commit -A... This is why I go with environment variable for
> temporarily disabling something, or we'll need many config and comman=
d
> line options, one per command.
>
>> A short test showed that watchman compiles under Mac OS.
>> The patch did not compile out of the box (both Git and watchman decl=
are
>> there own version of usage(), some C99 complaints from the compiler =
in watchman,
>> nothing that can not be fixed easily)
> Yeah it's not perfect. It's mainly to show speeding up refresh with
> watchman could be done easily and with low impact
>
>> I will test the mtime patch under networked file systems the next we=
eks.


Thinks become to get a little bit clearer.
What I can understand is that we have 2 different "update-helpers" for =
Git,
thanks for that.

just in case there is re-roll, does the following makes sense:
We want to enable them (probably only one at a time) either by command =
line or
persistent in a repo.

As I think we have 2 different update helpers
(and may be more in the future)
GIT_UPDATE_HELPER=3Ddirmtime git status
GIT_UPDATE_HELPER=3Dwatchman git status
GIT_UPDATE_HELPER=3Dnone git status

of course we want to be able to configure it:
git config core.updatehelper dirmtime


After configuring we may want to override it:
GIT_UPDATE_HELPER=3Dnone git status
or
git -c core.updatehelper=3Dnone status

> Hmm.. you remind me mtime series may have this as an advantage over w=
atchman..
I had the time to do a short test, sharing a copy of git.git under NFS:
The time for git status dropped from 0.4 seconds to 0.15 seconds or so.
Very nice.
The next test will be to share the same repo under samba to Windows
and Mac OS and see how this works.
