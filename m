From: =?UTF-8?B?UmVuw6kgU2NoYXJmZQ==?= <l.s.r@web.de>
Subject: Re: t5150-request-pull.sh fails on newest master in Debian
Date: Wed, 09 Jul 2014 16:52:00 +0200
Message-ID: <53BD5710.7040409@web.de>
References: <CAA787r=78UWio3E==s+J2PbVqshQdWXpS9hiJrmNz+F0vLiuGg@mail.gmail.com>	 <1404505370.3109.15.camel@stross>	 <CAA787rmf36V1=Sd8TZrc7DboTkeJDYKuEGgCe90mZLLKSp6=tw@mail.gmail.com>	 <1404525502.3109.25.camel@stross>	 <CAA787rnMonCuON+C0U5FDXKzjTBdpOusCpGLeWytDWaA1torEw@mail.gmail.com>	 <CAA787r=Q5B7R1sxiVhRgobPHHPro6D5YyqVO+P_MZC=aGa+ZHw@mail.gmail.com> <1404868702.3775.2.camel@stross>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?IsOYeXZpbmQgXCJBLiBIb2xtXCIi?= <sunny@sunbase.org>,
	"git@vger.kernel.org" <git@vger.kernel.org>
To: David Turner <dturner@twopensource.com>
X-From: git-owner@vger.kernel.org Wed Jul 09 16:52:35 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1X4tEY-00012C-5o
	for gcvg-git-2@plane.gmane.org; Wed, 09 Jul 2014 16:52:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755657AbaGIOwM convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Wed, 9 Jul 2014 10:52:12 -0400
Received: from mout.web.de ([212.227.17.12]:52469 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754182AbaGIOwK (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 9 Jul 2014 10:52:10 -0400
Received: from [192.168.178.27] ([79.253.169.45]) by smtp.web.de (mrweb101)
 with ESMTPSA (Nemesis) id 0MBkPj-1WvIBr3YNb-00Aq46; Wed, 09 Jul 2014 16:52:08
 +0200
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
In-Reply-To: <1404868702.3775.2.camel@stross>
X-Provags-ID: V03:K0:V/o2WYOABvMXH+DgRn2sOpPOK1OmXuyqnpu0mUiZ17ca1KlJTiX
 msDNTbVWJp3PUoIN/8qnak9ZIPCpyCWhKvshO253HMpwdf+E6j3Ha4do+5QpAC/j2brqdXg
 01+M6r3squc3ioYz5Q1wCLGQ2nNE08PFVbnKcc+wXA4l7/pOr9fruFhPwrkA1CRh5wO4cwD
 rfPhcEWENYww0q02bwIng==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/253126>

Am 09.07.2014 03:18, schrieb David Turner:
> On Wed, 2014-07-09 at 02:52 +0200, =C3=98yvind A. Holm wrote:
>> On 3 July 2014 23:55, =C3=98yvind A. Holm <sunny@sunbase.org> wrote:
>>> When compiling newest master (v2.0.1-472-g6f92e5f) on Debian 7.5
>>> (64-bit), t5150-request-pull.sh fails when compiling with
>>>
>>> $ make configure
>>> $ ./configure --prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6=
f92e5f
>>> $ make prefix=3D/usr/local/varprg/git.master.v2.0.1-472-g6f92e5f
>>> $ cd t
>>> $ ./t5150-request-pull.sh
>>
>> FYI, t5150-request-pull.sh passes all tests now on newest master
>> (v2.0.1-474-g72c7794) in Debian. There are two new commits on master
>> since I wrote this, and the commit that makes things work again is
>> 4602f1a ("diff-tree: call free_commit_list() instead of duplicating
>> its code"). Reverting this commit brings the failure back.
>>
>> The whole thing is still a mystery to me, though. I can't see why th=
is
>> should have anything to do with the use of ./configure --prefix.
>
> The problem only happens when a ref with an allowed wildcard winds up=
 on
> a page boundary (with the wildcard before the page boundary).  This
> depends intricately on the details of memory allocation, so pretty mu=
ch
> anything could make it come and go.
>
> Does the fix I posted work for you?  If not, let me know and I'll loo=
k
> into it more.

Sounds fragile overall.  How could a test program look like?  All I can=
=20
think of is a brute force check of all combinations of three characters=
=20
(is that enough?), PAGE_SIZE offsets, three flags, with and without=20
".lock" appended (and embedded?) against the old implementation, which=20
must be quite expensive.

Some callers of check_refname_format() know the length of the string or=
=20
can determine it cheaply because they copy the whole string anyway.=20
Would it make sense to do away with the page boundary magic and require=
=20
the callers of the fast version to pass that length?  The tailing bytes=
=20
(up to 15) would have to be loaded carefully, though.  Not sure.

Ren=C3=A9
