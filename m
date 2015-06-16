From: =?UTF-8?B?VG9yc3RlbiBCw7ZnZXJzaGF1c2Vu?= <tboegi@web.de>
Subject: Re: Should the --encoding argument to log/show commands make any
 guarantees about their output?
Date: Tue, 16 Jun 2015 22:04:03 +0200
Message-ID: <55808133.6070802@web.de>
References: <557E91D2.3000908@googlemail.com> <557EFB94.3040104@web.de> <557FEEA5.2080006@googlemail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Jan-Philip Gehrcke <jgehrcke@googlemail.com>,
	=?UTF-8?B?VG9yc3RlbiBCw7Y=?= =?UTF-8?B?Z2Vyc2hhdXNlbg==?= 
	<tboegi@web.de>, git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Jun 16 22:04:21 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Z4x5o-0004Fh-0u
	for gcvg-git-2@plane.gmane.org; Tue, 16 Jun 2015 22:04:20 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756943AbbFPUEQ convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 16 Jun 2015 16:04:16 -0400
Received: from mout.web.de ([212.227.15.3]:65514 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752992AbbFPUEO (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Jun 2015 16:04:14 -0400
Received: from macce.local ([213.66.56.100]) by smtp.web.de (mrweb003) with
 ESMTPSA (Nemesis) id 0MT8cQ-1ZX6sh2Zew-00S5EK; Tue, 16 Jun 2015 22:04:09
 +0200
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.6; rv:31.0) Gecko/20100101 Thunderbird/31.7.0
In-Reply-To: <557FEEA5.2080006@googlemail.com>
X-Provags-ID: V03:K0:mnwj4pTQKoRABuftG4HIonKTVtc0rSfIaQqcZQyvPdG7TIcoAEQ
 1O+rNn54p6WsEY4FJszM8xMQToA9Qh6xD8kefRRTrwPjy7/9jwfkpg0nwA3dYI+6Nf0ovQx
 jzHz/VIKc4DpN3VNU7MEsmWp7ag8rsXzJaeZ0YZe7XQUiAVHtCMeOfqj3qkzGeftQhwVg/o
 Z7fd/G9ryjM4719LEPvmQ==
X-UI-Out-Filterresults: notjunk:1;
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/271793>

On 2015-06-16 11.38, Jan-Philip Gehrcke wrote:
> On 15.06.2015 18:21, Torsten B=C3=B6gershausen wrote:
>> On 2015-06-15 10.50, Jan-Philip Gehrcke wrote:
>>> Let me describe what I think it currently does:
>>>
>>> The program attempts to re-code a log message, so it follows the ch=
ain
>>>
>>>      raw input -> unicode -> raw output
>> Not sure what "raw input/output" means.
>> But there is only one reencode step involved, e.g.
>> input(8859) -> output(UTF-8)

I probably need to correct myself:
pretty.c
void format_commit_message(const struct commit *commit,

The the message is converted from the commit encoding into UTF-8.
When the log encoding is different from UTF-8,
There is a second conversio (as you said).
(But not in your case, here the second conversion is skipped)

[snip]

>=20
> I'd be willing to contribute, but of course there must be a discussio=
n and an
> agreement before that, if there is need to change something at all, a=
nd what
> exactly.
[]
> What do you think?
See commit.c:

/*
 * This verifies that the buffer is in proper utf8 format.
 *
 * If it isn't, it assumes any non-utf8 characters are Latin1,
 * and does the conversion.
 */
static int verify_utf8(struct strbuf *buf)

>=20
> I think the --encoding option would have ideal semantics for describe=
d behavior.
>=20
> However, I guess maintaining backwards compatibility is an issue here=
=2E On the
> other hand, I realize that the --encoding option undergoes changes: t=
he docs for
> git log in release 2.4.3 do not even list the --encoding option anymo=
re. Why is
> that? I haven't found a corresponding changelog/release notes entry.

It still seems to work:
git log --encoding ISO-8859-1 | xxd | grep gersha | less
includes this line:
7465 6e20 42f6 6765 7273 6861 7573 656e  ten B.gershausen


So my suggestion (in short):
move verify_utf8() from commit.c into utf8.c,
make it non-static, and add a prototype in utf8.h

Use that function in pretty.c (and commit.c), test it.
Make a patch out of it and send it to the list.

In the ideal world the patch will include a test case,
but I don't know how easy it is to create such a commit.
