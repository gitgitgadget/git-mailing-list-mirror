From: =?UTF-8?B?SmFrdWIgTmFyxJlic2tp?= <jnareb@gmail.com>
Subject: Re: squash commits deep down in history
Date: Fri, 24 Oct 2014 13:43:22 +0200
Message-ID: <544A3B5A.6030801@gmail.com>
References: <trinity-6a57d894-cc4f-4213-9c51-5c73de2501d0-1414067657189@3capp-gmx-bs48> <54496036.8080109@kdbg.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: Johannes Sixt <j6t@kdbg.org>, Henning Moll <newsScott@gmx.de>,
	git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Oct 24 13:43:34 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1XhdHJ-00048V-CK
	for gcvg-git-2@plane.gmane.org; Fri, 24 Oct 2014 13:43:33 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756206AbaJXLn3 convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 24 Oct 2014 07:43:29 -0400
Received: from mail-la0-f53.google.com ([209.85.215.53]:51064 "EHLO
	mail-la0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756066AbaJXLn2 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 24 Oct 2014 07:43:28 -0400
Received: by mail-la0-f53.google.com with SMTP id gq15so2418950lab.40
        for <git@vger.kernel.org>; Fri, 24 Oct 2014 04:43:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=message-id:date:from:user-agent:mime-version:newsgroups:to:subject
         :references:in-reply-to:content-type:content-transfer-encoding;
        bh=vMX5DOOyhbHirzJHS+D7XcNZg/oyhY8DJU4JOVnL07o=;
        b=wC4EYSXbGn6vCLyBPVTse0Ni84eDtTEM0/LBZKWCl58xCgJuoZWqOw5ym4qRHpFJCq
         g4Wc1p9t6cWihYXyyCD5EC/jsqRLISFABmquXewpS7I9XvwvqOHnqlcVjLklQgwO599R
         mUZrYs0FoTTFVM2JEDI40REvCuRgbJJxRf+Cyj/VE+DdVv+81H9B8CboTd53BUWXLHOY
         ON1T2FC/U9eYrrE59o+9pb7y034GWC+0qZoUtRNKInbFlfh0Y6Cfah+ONzFoB0Tg1BDk
         AGhrwdd0wl/nJKKSeMd2jrOxQapEarM8V94Y7vRVMV1Q8qQUr67AUP2eKIiZr2hwou2o
         iB9A==
X-Received: by 10.112.138.39 with SMTP id qn7mr3814979lbb.57.1414151007036;
        Fri, 24 Oct 2014 04:43:27 -0700 (PDT)
Received: from [192.168.130.235] ([158.75.2.130])
        by mx.google.com with ESMTPSA id t6sm1782426lbb.23.2014.10.24.04.43.25
        for <multiple recipients>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 24 Oct 2014 04:43:26 -0700 (PDT)
User-Agent: Mozilla/5.0 (Windows NT 5.1; rv:24.0) Gecko/20100101 Thunderbird/24.6.0
Newsgroups: gmane.comp.version-control.git
In-Reply-To: <54496036.8080109@kdbg.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

W dniu 2014-10-23 22:08, Johannes Sixt pisze:
> Am 23.10.2014 um 14:34 schrieb Henning Moll:

>> i need to squash several commits into a single one in a automated
>> way. I know that there is interactive rebase, which can also be
>> automated using GIT_SEQUENCE_EDITOR. Unfortunately my history is ver=
y
>> large and i need to squash deep down in the history several times. S=
o
>> using interactive rebase seems not to be the right tool.
>>
>> I wonder if i can solve this task using filter-branch? I have a file
>> that list the SHA1s for each squash operation per line. All SHA1s of
>> a line are in chronological order (youngest to oldest), or in other
>> words: the first SHA1 is the child of the second, and so on.
>
> Use git-replace do construct a squashed commit that replaces the last
> child in each run such that its parent points to the parent of the fi=
rst
> in the run. Then use a git-filter-branch without filters to burn the
> parenthood into the history.

Using grafts (which are only about parentage, and are purely local) wit=
h=20
filter-less git-filter-branch might be easier than git-replace.

If you have the following history:

     ... <--- O <--- A <--- B <--- C <--- ...

and you want to squash A, B, C into

     ... <--- O <----------------- C <--- ...

simply add the following to .git/info/grafts

    <sha-1 of C> <sha-1 of O>

for example with

    echo "$(git rev-parse C) $(git rev-parse C^^^)" >>.git/info/grafts

Check if the history is correct e.g. with "git log --graph --oneline",
then use filter-branch.

BTW. do you know if it is possible to run filter-branch without=20
replacing replaces?


Just for completeness, yet another way to do scripted history rewriting=
=20
is to use git-fast-export + some editing script (e.g. reposurgeon[1]) +=
=20
git-fast-import.

[1]: http://www.catb.org/esr/reposurgeon/

--=20
Jakub Nar=C4=99bski
