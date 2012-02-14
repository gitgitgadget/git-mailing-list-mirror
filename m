From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: [PATCH v2 2/2] submodules: always use a relative path from gitdir
 to work tree
Date: Tue, 14 Feb 2012 18:36:24 +0100
Message-ID: <4F3A9B98.6040908@web.de>
References: <4F32F252.7050105@web.de> <4F32F465.7090401@web.de> <4F338156.9090507@web.de> <7vlio6ec7q.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>,
	Antony Male <antony.male@gmail.com>,
	Phil Hord <phil.hord@gmail.com>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 14 21:14:41 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RxOls-0007V7-3L
	for gcvg-git-2@plane.gmane.org; Tue, 14 Feb 2012 21:14:41 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1760661Ab2BNUOf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 14 Feb 2012 15:14:35 -0500
Received: from fmmailgate02.web.de ([217.72.192.227]:48878 "EHLO
	fmmailgate02.web.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757115Ab2BNUOf (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 14 Feb 2012 15:14:35 -0500
Received: from moweb001.kundenserver.de (moweb001.kundenserver.de [172.19.20.114])
	by fmmailgate02.web.de (Postfix) with ESMTP id 55ADE1C1BC169
	for <git@vger.kernel.org>; Tue, 14 Feb 2012 18:36:32 +0100 (CET)
Received: from [192.168.178.48] ([91.3.171.179]) by smtp.web.de (mrweb002)
 with ESMTPA (Nemesis) id 0MMW5u-1RrHkp3gpq-00809D; Tue, 14 Feb 2012 18:36:30
 +0100
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:10.0) Gecko/20120129 Thunderbird/10.0
In-Reply-To: <7vlio6ec7q.fsf@alter.siamese.dyndns.org>
X-Provags-ID: V02:K0:CYWiD6gHTjeeCukRulEQUAUgDDMkhTgFo9FHtWVcpky
 ZTx1auxgtX9XyDpPt/wYXlWnKNfiq0xB2uD+PZnPs2DkjduIDr
 T5dCxihZ9+64oATWE2tiq3086bNHaoUivzKMGp4ktU6345792z
 e7jkaqUN6nWsFVS/RIsxqOM+6uAZqO8OKXJYKqdr24Q6q0Ti9u
 BEOvgGEEp+HOesxVYKTDQ==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/190746>

Am 13.02.2012 20:59, schrieb Junio C Hamano:
> Jens Lehmann <Jens.Lehmann@web.de> writes:
>> +	a=$(cd "$gitdir" && pwd)
>> +	b=$(cd "$path" && pwd)
>> +	while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
>> +	do
>> +		a=${a#*/} b=${b#*/};
>> +	done
>> +	rel=$(echo $a | sed -e 's|[^/]*|..|g')
>> +	(clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
>>  }
> 
> 
> The style ([ "$b" ] vs "test -n "$b") aside, it strikes me odd that you
> only check $b; it is unclear what guarantees that "$a" is always longer.
> Maybe there is a reason but then a one-line comment here would not hurt?

I just copied that while loop from a few lines up, but you are right
about the style and logic issues (Will send a cleanup patch for the
other loop too when we agree on how to write this one).

After adding a comment, using test instead of [], testing both $a and
$b and assigning each variable on it's own line I get the following
interdiff. Does that make more sense?

diff --git a/git-submodule.sh b/git-submodule.sh
index 3463d6d..ed76ce2 100755
--- a/git-submodule.sh
+++ b/git-submodule.sh
@@ -172,9 +172,11 @@ module_clone()

        a=$(cd "$gitdir" && pwd)
        b=$(cd "$path" && pwd)
-       while [ "$b" ] && [ "${a%%/*}" = "${b%%/*}" ]
+       # Remove all common leading directories
+       while test -n "$a" && test -n "$b" && test "${a%%/*}" = "${b%%/*}"
        do
-               a=${a#*/} b=${b#*/};
+               a=${a#*/}
+               b=${b#*/}
        done
        rel=$(echo $a | sed -e 's|[^/]*|..|g')
        (clear_local_git_env; cd "$path" && git config core.worktree "$rel/$b")
