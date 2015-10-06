From: Michael J Gruber <git@drmicha.warpmail.net>
Subject: Re: [PATCH] completion: fix completion after 'git -C path'
Date: Tue, 6 Oct 2015 10:52:07 +0200
Message-ID: <56138BB7.4000404@drmicha.warpmail.net>
References: <1444046535-18316-1-git-send-email-szeder@ira.uka.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org
To: =?UTF-8?Q?SZEDER_G=c3=a1bor?= <szeder@ira.uka.de>,
	Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Oct 06 10:52:40 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZjNzD-0008Uk-3H
	for gcvg-git-2@plane.gmane.org; Tue, 06 Oct 2015 10:52:39 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751340AbbJFIwd convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Tue, 6 Oct 2015 04:52:33 -0400
Received: from out4-smtp.messagingengine.com ([66.111.4.28]:53856 "EHLO
	out4-smtp.messagingengine.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751740AbbJFIwJ (ORCPT
	<rfc822;git@vger.kernel.org>); Tue, 6 Oct 2015 04:52:09 -0400
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
	by mailout.nyi.internal (Postfix) with ESMTP id B63682076B
	for <git@vger.kernel.org>; Tue,  6 Oct 2015 04:52:08 -0400 (EDT)
Received: from frontend1 ([10.202.2.160])
  by compute3.internal (MEProxy); Tue, 06 Oct 2015 04:52:08 -0400
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=warpmail.net; h=cc
	:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to:x-sasl-enc
	:x-sasl-enc; s=mesmtp; bh=hXL8sOD24VtmrogkY6zrgrRrKRQ=; b=QMXoHv
	bqkDlKSZ3iWLWSPZ0q4gIsuXxlc6ryIQniTjo9XGL09JSjCipDFgLejNO5li4u4V
	fwpRPa1Nq6M0/PF5CNspkj+hcc7eBBHKZpISm/+8vnGc7WJaonmYORBm0kGyQk2+
	+kr/7IjF+wHrA6iL0sn3i1xXmUzFy6/rYqM0o=
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-transfer-encoding:content-type
	:date:from:in-reply-to:message-id:mime-version:references
	:subject:to:x-sasl-enc:x-sasl-enc; s=smtpout; bh=hXL8sOD24Vtmrog
	kY6zrgrRrKRQ=; b=G8HEqCMAHQ6Xkn+V4YStN1Fh4ai40HT5f0zEDxhrGKZgXjl
	YJ18+R5BG6x66/hbcR4Nq9JNL4B1QexWNKWjGfkumw+TIqbtxyX4HygfBZBGediS
	QfiAGvyFeuuj/QxZnPErv4shCKBUUEo3Zokh1xvcprXs5+LMMiW9bv9kHQho=
X-Sasl-enc: ZKTvN3jzvjzOUinv5wqyH4WYf8ODFG7SRahB0Q7vWsL4 1444121528
Received: from dickson.math.uni-hannover.de (dickson.math.uni-hannover.de [130.75.46.56])
	by mail.messagingengine.com (Postfix) with ESMTPA id 20737C0001A;
	Tue,  6 Oct 2015 04:52:08 -0400 (EDT)
X-Enigmail-Draft-Status: N1110
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:38.0) Gecko/20100101
 Thunderbird/38.3.0
In-Reply-To: <1444046535-18316-1-git-send-email-szeder@ira.uka.de>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/279125>

SZEDER G=C3=A1bor venit, vidit, dixit 05.10.2015 14:02:
> The main completion function finds the name of the git command by
> iterating through all the words on the command line in search for the
> first non-option-looking word.  As it is not aware of 'git -C's
> mandatory path argument, if the '-C path' option is present, 'path' w=
ill
> be the first such word and it will be mistaken for a git command.  Th=
is
> breaks the completion script in various ways:
>=20
>  - If 'path' happens to match one of the commands supported by the
>    completion script, then its options will be offered.
>=20
>  - If 'path' doesn't match a supported command and doesn't contain an=
y
>    characters not allowed in Bash identifier names, then the completi=
on
>    script does basically nothing and lets Bash to fall back to filena=
me
>    completion.
>=20
>  - Otherwise, if 'path' contains such unallowed characters, then it
>    leads to a more or less ugly error in the middle of the command li=
ne.
>    The standard '/' directory separator is such a character, and it
>    happens to trigger one of the uglier errors:
>=20
>      $ git -C some/path <TAB>sh.exe": declare: `_git_some/path': not =
a valid identifier
>      error: invalid key: alias.some/path
>=20
> Fix this by skipping 'git -C's mandatory path argument while iteratin=
g
> over the words on the command line.  Extend the relevant test with th=
is
> case and, while at it, with cases that needed similar treatment in th=
e
> past ('--git-dir', '-c', '--work-tree' and '--namespace').
> Additionally, shut up standard error of the 'declare' commands lookin=
g
> for the associated completion function and of the 'git config' query =
for
> the aliased command, so if git learns a new option with a mandatory
> argument in the future, then at least the command line will not be
> utterly disrupted by those error messages.
>=20
> Note, that this change merely fixes the breakage related to 'git -C
> path', but the completion script will not take it into account as it
> does '--git-dir path'.

I don't understand the "as it does" part. Do you mean that the
completion script does '--git-dir path', or that git does it?

In any case, "git -C path ..." is more like "cd path && git ...". That
is, completion should take it into account at least when determining
GIT_DIR (though -C does not specifiy the git-dir directly), and possibl=
y
also for completion of untracked files. Otherwise, it's going by the
wrong repo (unless path is a subdir of cwd).

Michael
