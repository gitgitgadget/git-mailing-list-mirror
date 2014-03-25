From: Andrew Keller <andrew@kellerfarm.com>
Subject: Re: Borrowing objects from nearby repositories
Date: Tue, 25 Mar 2014 09:13:56 -0400
Message-ID: <9A24D2D1-DD59-41DC-8237-2B5829695753@kellerfarm.com>
References: <BFF5FBC7-8F53-4958-8D56-90EADD3AD626@kellerfarm.com> <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
Mime-Version: 1.0 (Mac OS X Mail 6.6 \(1510\))
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Git List <git@vger.kernel.org>
To: =?iso-8859-1?Q?=C6var_Arnfj=F6r=F0_Bjarmason?= <avarab@gmail.com>
X-From: git-owner@vger.kernel.org Tue Mar 25 14:14:06 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WSRB6-00006W-7M
	for gcvg-git-2@plane.gmane.org; Tue, 25 Mar 2014 14:14:04 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753126AbaCYNN6 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 25 Mar 2014 09:13:58 -0400
Received: from atl4mhob06.myregisteredsite.com ([209.17.115.44]:49569 "EHLO
	atl4mhob06.myregisteredsite.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751838AbaCYNN5 convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 25 Mar 2014 09:13:57 -0400
Received: from mailpod.hostingplatform.com ([10.30.71.208])
	by atl4mhob06.myregisteredsite.com (8.14.4/8.14.4) with ESMTP id s2PDDt1c024853
	for <git@vger.kernel.org>; Tue, 25 Mar 2014 09:13:55 -0400
Received: (qmail 5381 invoked by uid 0); 25 Mar 2014 13:13:55 -0000
X-TCPREMOTEIP: 69.41.14.130
X-Authenticated-UID: andrew@kellerfarm.com
Received: from unknown (HELO ?10.0.13.36?) (andrew@kellerfarm.com@69.41.14.130)
  by 0 with ESMTPA; 25 Mar 2014 13:13:55 -0000
In-Reply-To: <CACBZZX5teZuqtNkPT4PdXJn=g34cOhRH2oNehROT8kJ_M2cgfg@mail.gmail.com>
X-Mailer: Apple Mail (2.1510)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/245030>

On Mar 24, 2014, at 5:21 PM, =C6var Arnfj=F6r=F0 Bjarmason <avarab@gmai=
l.com> wrote:
> On Wed, Mar 12, 2014 at 4:37 AM, Andrew Keller <andrew@kellerfarm.com=
> wrote:
>> Hi all,
>>=20
>> I am considering developing a new feature, and I'd like to poll the =
group for opinions.
>>=20
>> Background: A couple years ago, I wrote a set of scripts that speed =
up cloning of frequently used repositories.  The scripts utilize a bare=
 Git repository located at a known location, and automate providing a -=
-reference parameter to `git clone` and `git submodule update`.  Recent=
ly, some coworkers of mine expressed an interest in using the scripts, =
so I published the current version of my scripts, called `git repocache=
`, described at the bottom of <https://github.com/andrewkeller/ak-git-t=
ools>.
>>=20
>> Slowly, it has occurred to me that this feature, or something simila=
r to it, may be worth adding to Git, so I've been thinking about the be=
st approach.  Here's my best idea so far:
>>=20
>> 1)  Introduce '--borrow' to `git-fetch`.  This would behave similarl=
y to '--reference', except that it operates on a temporary basis, and d=
oes not assume that the reference repository will exist after the opera=
tion completes, so any used objects are copied into the local objects d=
atabase.  In theory, this mechanism would be distinct from '--reference=
', so if both are used, some objects would be copied, and some objects =
would be accessible via a reference repository referenced by the altern=
ates file.
>=20
> Isn't this the same as git clone --reference <path> --no-hardlinks <u=
rl> ?

'--reference` adds an entry to 'info/alternates' inside the objects fol=
der.  When an object is looked up, any objects folder listed in 'object=
s/info/alternates' is considered to be an extension of the local object=
s folder.  So, when, for example, fetch runs, when it goes to decide wh=
ether or not it already has a blob locally, it may decide "yes", and no=
t download the blob at all, because it already exists in one of the ref=
erence repositories.  If I clone one of my 80 GB repositories over SSH =
using a reference repository, the resulting clone is only about 175 KB,=
 because it's assuming the reference repository will exist going forwar=
d, so it doesn't actually own any objects itself at all.

The '--no-hardlinks' option is only applicable when hard linking is ava=
ilable in the first place - i.e., when cloning from one local folder to=
 another on the same filesystem (assuming the filesystem supports hard =
links).

Thanks,
 - Andrew
