From: Junio C Hamano <junkio@cox.net>
Subject: Re: Handling merge conflicts a bit more gracefully..
Date: Wed, 08 Jun 2005 17:03:55 -0700
Message-ID: <7vzmu01jmc.fsf@assigned-by-dhcp.cox.net>
References: <Pine.LNX.4.58.0506081336080.2286@ppc970.osdl.org>
	<7vis0o30sc.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Jun 09 02:05:17 2005
Return-path: <git-owner@vger.kernel.org>
Received: from vger.kernel.org ([12.107.209.244])
	by ciao.gmane.org with esmtp (Exim 4.43)
	id 1DgAWk-0008UW-UT
	for gcvg-git@gmane.org; Thu, 09 Jun 2005 02:04:07 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S262241AbVFIAHW (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Wed, 8 Jun 2005 20:07:22 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S262234AbVFIAFr
	(ORCPT <rfc822;git-outgoing>); Wed, 8 Jun 2005 20:05:47 -0400
Received: from fed1rmmtao11.cox.net ([68.230.241.28]:15579 "EHLO
	fed1rmmtao11.cox.net") by vger.kernel.org with ESMTP
	id S262241AbVFIAD5 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 8 Jun 2005 20:03:57 -0400
Received: from assigned-by-dhcp.cox.net ([68.4.60.172])
          by fed1rmmtao11.cox.net
          (InterMail vM.6.01.04.00 201-2131-118-20041027) with ESMTP
          id <20050609000354.SWLH12158.fed1rmmtao11.cox.net@assigned-by-dhcp.cox.net>;
          Wed, 8 Jun 2005 20:03:54 -0400
To: Linus Torvalds <torvalds@osdl.org>
In-Reply-To: <Pine.LNX.4.58.0506081629370.2286@ppc970.osdl.org> (Linus
 Torvalds's message of "Wed, 8 Jun 2005 16:35:48 -0700 (PDT)")
User-Agent: Gnus/5.1007 (Gnus v5.10.7) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org

>>>>> "LT" == Linus Torvalds <torvalds@osdl.org> writes:

>> # Modified in both, but differently.
>> +	merge -p "$src1" "$orig" "$src2" > "$4"
>> 
>> Again, make sure "$4" is not a directory before redirecting into
>> it from merge, so that you can tell merge failures from it?

LT> Hmm.. What's the cleanest way to check for redirection errors, but still
LT> be able to distinguish those cleanly from "merge" itself returning an
LT> error?

I do not think you can, unless you are willing to parse shell
error messages, which I do not want you to be willing to ;-).

    : siamese; ls -dlF junk j.py
    ----------  1 junio junio  845 May  7  2004 j.py
    drwxrwxr-x  2 junio junio 4096 May  4 22:31 junk/
    : siamese; echo foo >j.py ; echo $?
    bash: j.py: Permission denied
    1
    : siamese; echo foo >junk ; echo $?
    bash: junk: Is a directory
    1

I think you have a bigger problem of leading paths, BTW.

Since we would want to have the merge result file at that path,
and not being able to create such is an error, how about doing
dumb and simple, like:

    d=`dirname "$4"` &&
    mkdir -p "$d" &&
    rm -f -- "$4" &&
    : >"$4" || {
        echo "barf"
        exit 1
    }
    merge -p "$src1" "$orig" "$src2" >"$4"
    ret=$?

