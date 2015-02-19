From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: [PATCH 1/3] connect.c: Improve parsing of literal IPV6 addresses
Date: Thu, 19 Feb 2015 17:42:45 +0100
Message-ID: <54E61285.5070600@web.de>
References: <54BD3D14.90309@web.de>	<20150122200702.GA96498@vauxhall.crustytoothpaste.net>	<54C17429.1090403@web.de>	<20150122234117.GD96498@vauxhall.crustytoothpaste.net> <xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>,
	git@vger.kernel.org, lists@hcf.yourweb.de
To: Junio C Hamano <gitster@pobox.com>,
	"brian m. carlson" <sandals@crustytoothpaste.net>
X-From: git-owner@vger.kernel.org Thu Feb 19 17:43:04 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YOUBp-0007T1-IP
	for gcvg-git-2@plane.gmane.org; Thu, 19 Feb 2015 17:43:01 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751934AbbBSQm5 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Feb 2015 11:42:57 -0500
Received: from mout.web.de ([212.227.17.12]:56264 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751426AbbBSQm4 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Feb 2015 11:42:56 -0500
Received: from macce.local ([217.211.68.12]) by smtp.web.de (mrweb101) with
 ESMTPSA (Nemesis) id 0M3jwL-1XYAgM3pXF-00rFy0; Thu, 19 Feb 2015 17:42:52
 +0100
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.4.0
In-Reply-To: <xmqqtwyj2hdk.fsf@gitster.dls.corp.google.com>
X-Provags-ID: V03:K0:P6evyAHS6pPQLOMcrQMs/ii9Zul5nhZ2aFxCawMMW8ctRNDeI46
 osRRaJnovPUVlWgxLQ7CwNF4zUWmP5Ubbjpj4KQlf7u063PFD7K+1P7DP2t7nXZn9f98W+7
 Fl2AxcMEwGu2unIzg12/MSwrFmkNBd9ZJcjb20kpXM+EjT69pc0+NsLfx6sjWLzQzcXS2kc
 Gy+nwHhuuC/S0/PpafaYg==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/264103>

On 02/18/2015 07:40 PM, Junio C Hamano wrote:
> "brian m. carlson" <sandals@crustytoothpaste.net> writes:
>
>> On Thu, Jan 22, 2015 at 11:05:29PM +0100, Torsten B=C3=B6gershausen =
wrote:
>>> We want to support ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.gi=
t/
>>>   because e.g. the Git shipped with Debian (1.7.10.4) (and a lot of
>>> other installations) supports it.
>> I understand that this used to work, but it probably shouldn't have
>> ever been accepted.  It's nonstandard, and if we accept it for ssh,
>> people will want it to work for https, and due to libcurl, it simply
>> won't.
>>
>> I prefer to see our past acceptance of this format as a bug.  This i=
s
>> the first that I've heard of anyone noticing this (since 2013), so i=
t
>> can't be in common usage.
>>
>> If we accept it, we should explicitly document it as being deprecate=
d
>> and note that it's inconsistent with the way everything else works.
> I was reviewing my Undecided pile today, and I think your objection
> makes sense.
>
> Either of you care to update documentation, please, before I drop
> this series and forget about it?
The URL RFC is much stricter regarding which characters that are allowe=
d
in which part of the URL, as least as I read it.

The "problem" started when /usr/bin/ssh excepted things like
/usr/bin/ssh fe80:x:y:z%eth0 and Git simply passed the hostname
to ssh.

And when the [] was there, it was stripped because ssh doesn't like the=
m.
URLs like

ssh://bmc@2001:470:1f05:79::1/git/bmc/homedir.git/

simply worked, and nobody ever complained about this,
(until now),  Git never rejected IPV6 URLs without [], please correct m=
e if
I'm wrong.

Git never cared about the exact URL, so that IPV6 URL's without [] wher=
e allowed
from "day one".

On top of that, we support the short form,
user@host:~ or other variants.
But we never claimed to be compatible to RFC 1738, even if it makes sen=
se to do so.

What exactly should we write in the documentation ?

Git supports RFC1738 (but is not as strict in parsing the URL, because
we assume that the host name resolver will do some checking for us.

Git currently does not support user@[fe80::x:y:z], even if RFC suggests=
 it

Git never claimed to be 100% compatible to RFC 1738, and will
probably never be, (as we have old code that is as it is).

We (at least I) don't want to break existing repos, rejecting URL's tha=
t had been
working before and stopped working because the Git version is updated o=
r so)

This patch series is attempting to be backwards compatible to what
old, older. and oldest versions of Git accepted.

At the price that we accept URL's which do not conform to the RFC are a=
ccepted.
It fixes the long standing issue that user@[fe80:] did not work.

I'm somewhat unsure what to write in the documentation, I must admit.

Unfortunately URL parsing is a tricky thing, this patch tries to do imp=
rovements.
Especially it adds test cases, which are good to prevent further breaka=
ge.
=20
Updating the documentation was never part of the patch series,
and if the documentation is updated, this is done in a separate commit =
anyway.

How much does this series qualify for the "we didn't update the docs",
but fixed the code, let's drop it ?
=20


=20
