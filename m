From: Nathan Bullock <nathanbullock@gmail.com>
Subject: Autocompletion - commands no longer work as stand alone
Date: Fri, 20 Jan 2012 11:32:05 -0500
Message-ID: <CAPx=Vfqj3UZuFv3Xmupy7k9arUxyZJyprm628p9QVKabdOz8cw@mail.gmail.com>
References: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Jan 20 17:32:13 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RoHNs-0005Q2-5T
	for gcvg-git-2@lo.gmane.org; Fri, 20 Jan 2012 17:32:12 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754276Ab2ATQcI convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 20 Jan 2012 11:32:08 -0500
Received: from mail-tul01m020-f174.google.com ([209.85.214.174]:45920 "EHLO
	mail-tul01m020-f174.google.com" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1753732Ab2ATQcF convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 20 Jan 2012 11:32:05 -0500
Received: by obcva7 with SMTP id va7so903783obc.19
        for <git@vger.kernel.org>; Fri, 20 Jan 2012 08:32:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :content-type:content-transfer-encoding;
        bh=zxbDRBDBT7lLKwiNcFGk0kGJNyLG+cZ4URhiktq8rMM=;
        b=MDaadMxp1pkiIBtxcFeyMrc5zNg9UX62Zsr2QApXqEopv/taR2FyBIrqakM1scHbWB
         cVTq9eKmBptTMZYgUSnnJGajhS0cMxpaCiDRxSNf09hJ6Lyd6HSKfU8wlUcFdekfQK2V
         TC2FrrCGG0fyeQHLvX5C+CgcLJNfxcEVS+UTA=
Received: by 10.182.76.134 with SMTP id k6mr27349844obw.10.1327077125216; Fri,
 20 Jan 2012 08:32:05 -0800 (PST)
Received: by 10.60.43.170 with HTTP; Fri, 20 Jan 2012 08:32:05 -0800 (PST)
In-Reply-To: <CAPx=Vfp_HVr5W1fFic_1k+JsKr2RAKd-RK=VkfSgo7qkb5GsAw@mail.gmail.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/188885>

I have for a number of years had the following in my .bashrc

alias br=3D"git branch"
complete -F _git_branch br

As well as similar commands for co and log.

Recently though this broke, now when I type something like "br
mas<command completion>"=A0it will occasionally complain with=A0message=
s
like:
bash: [: 1: unary operator expected

=46rom digging through the source it looks like this was broken back in
April. (The commit is show at the bottom of this email.)

So my questions are:
1. Is it reasonable for things like _git_branch to work as a
standalone autocompletion function instead of having to go through
_git? I certainly like it to work as a standalone function. I also use
it to add autocompletion to other bash scripts that I use frequently.

2. If I add code that verifies that the variable cword exists at the
start of these functions and only if not call something like
_get_comp_words_by_ref -n =3D: cur words cword prev. Would that be
reasonable? I think this should address the performance concerns that
caused these to be removed in the first place, but it may make the
code uglier.

I have already added wrapper functions in my bashrc so that this is no
longer a problem for me, but there may be other people who start
hitting this as well once they start using newer versions of git.

Nathan


commit da4902a73017ad82b9926d03101ec69a2802d1e7
Author: SZEDER G=E1bor <szeder@ira.uka.de>
Date: =A0 Thu Apr 28 18:01:52 2011 +0200

=A0 =A0completion: remove unnecessary _get_comp_words_by_ref() invocati=
ons

=A0 =A0In v1.7.4-rc0~11^2~2 (bash: get --pretty=3Dm<tab> completion to =
work
=A0 =A0with bash v4, 2010-12-02) we started to use _get_comp_words_by_r=
ef()
=A0 =A0to access completion-related variables. =A0That was large change=
, and to
=A0 =A0make it easily reviewable, we invoked _get_comp_words_by_ref() i=
n each
=A0 =A0completion function and systematically replaced every occurance =
of
=A0 =A0bash's completion-related variables ($COMP_WORDS and $COMP_CWORD=
) with
=A0 =A0variables set by _get_comp_words_by_ref().

=A0 =A0This has the downside that _get_comp_words_by_ref() is invoked s=
everal
=A0 =A0times during a single completion. =A0The worst offender is perha=
ps 'git
=A0 =A0log mas<TAB>': during the completion of 'master'
=A0 =A0_get_comp_words_by_ref() is invoked no less than six times.

=A0 =A0However, the variables $prev, $cword, and $words provided by
=A0 =A0_get_comp_words_by_ref() are not modified in any of the completi=
on
=A0 =A0functions, and the previous commit ensures that the $cur variabl=
e is
=A0 =A0not modified as well. =A0This makes it possible to invoke
=A0 =A0_get_comp_words_by_ref() to get those variables only once in our
=A0 =A0toplevel completion functions _git() and _gitk(), and all other
=A0 =A0completion functions will inherit them.

=A0 =A0Signed-off-by: SZEDER G=E1bor <szeder@ira.uka.de>
=A0 =A0Signed-off-by: Junio C Hamano <gitster@pobox.com>
