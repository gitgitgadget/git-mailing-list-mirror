From: Thomas Rast <trast@student.ethz.ch>
Subject: Re: [PATCH v7 4/4] git-rebase: add keep_empty flag
Date: Thu, 19 Apr 2012 13:49:01 +0200
Message-ID: <873980q6vm.fsf@thomas.inf.ethz.ch>
References: <1333136922-12872-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-1-git-send-email-nhorman@tuxdriver.com>
	<1334776680-23460-5-git-send-email-nhorman@tuxdriver.com>
	<4F8FE2CD.3070300@in.waw.pl>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: Neil Horman <nhorman@tuxdriver.com>, <git@vger.kernel.org>,
	"Clemens Buchacher" <drizzd@aon.at>,
	Phil Hord <phil.hord@gmail.com>,
	Junio C Hamano <gitster@pobox.com>
To: Zbigniew =?utf-8?Q?J=C4=99drzejewski-Szmek?= <zbyszek@in.waw.pl>
X-From: git-owner@vger.kernel.org Thu Apr 19 13:49:31 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKprd-00013y-KU
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 13:49:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1755073Ab2DSLtH convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Thu, 19 Apr 2012 07:49:07 -0400
Received: from edge20.ethz.ch ([82.130.99.26]:26276 "EHLO edge20.ethz.ch"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755064Ab2DSLtF convert rfc822-to-8bit (ORCPT
	<rfc822;git@vger.kernel.org>); Thu, 19 Apr 2012 07:49:05 -0400
Received: from CAS21.d.ethz.ch (172.31.51.111) by edge20.ethz.ch
 (82.130.99.26) with Microsoft SMTP Server (TLS) id 14.2.283.3; Thu, 19 Apr
 2012 13:49:02 +0200
Received: from thomas.inf.ethz.ch.ethz.ch (129.132.153.233) by CAS21.d.ethz.ch
 (172.31.51.111) with Microsoft SMTP Server (TLS) id 14.1.355.2; Thu, 19 Apr
 2012 13:49:01 +0200
In-Reply-To: <4F8FE2CD.3070300@in.waw.pl> ("Zbigniew =?utf-8?Q?J=C4=99drze?=
 =?utf-8?Q?jewski-Szmek=22's?=
	message of "Thu, 19 Apr 2012 12:02:53 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Originating-IP: [129.132.153.233]
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195936>

Zbigniew J=C4=99drzejewski-Szmek <zbyszek@in.waw.pl> writes:

> On 04/18/2012 09:18 PM, Neil Horman wrote:
>> Add a command line switch to git-rebase to allow a user the ability =
to specify
>> that they want to keep any commits in a series that are empty.
>>
>> When git-rebase's type is am, then this option will automatically ke=
ep any
>> commit that has a tree object identical to its parent.
>>
>> This patch changes the default behavior of interactive rebases as we=
ll.  With
>> this patch, git-rebase -i will produce a revision set passed to
>> git-revision-editor, in which empty commits are commented out.  Empt=
y commits
>> may be kept manually by uncommenting them.  If the new --keep-empty =
option is
>> used in an interactive rebase the empty commits will automatically a=
ll be
>> uncommented in the editor.
>>
>> Signed-off-by: Neil Horman<nhorman@tuxdriver.com>
>
> Hi,
> this one seems to breaks many tests when /bin/sh=3Ddash. (Both v6 in =
pu
> and this v7).

Probably because of the strange return in this function:

>> is_empty_commit() {
>> 	tree=3D$(git rev-parse "$1"^{tree})
>> 	ptree=3D$(git rev-parse "$1"^^{tree})
>> 	return $(test "$tree" =3D "$ptree")
>> }

bash seems to pass on the exit status from $() to the caller, while das=
h
doesn't.  It seems bash is actually more correct here, because POSIX
says about 'return [n]':=20

    EXIT STATUS
       The value of the special parameter '?' shall be set to n, an
       unsigned decimal integer, or to the exit status of the last
       command executed if n is not specified.

Either way, it should simply be spelled as

is_empty_commit() {
	tree=3D$(git rev-parse "$1"^{tree})
	ptree=3D$(git rev-parse "$1"^^{tree})
	test "$tree" =3D "$ptree"
}

--=20
Thomas Rast
trast@{inf,student}.ethz.ch
