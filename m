From: Scott Lamb <slamb@slamb.org>
Subject: Re: git-p4import.py robustness changes
Date: Sun, 3 Jun 2007 13:12:17 -0700
Message-ID: <839AEF71-ED29-4A79-BE97-C79EAFEDC466@slamb.org>
References: <4ACE2ABC-8D73-4097-87AC-F3B27EDA97DE@slamb.org> <0EDF1E14-3682-4B1E-A7D2-F82388F752AA@slamb.org> <7vzm3inisa.fsf@assigned-by-dhcp.cox.net> <200706031511.31157.simon@lst.de>
Mime-Version: 1.0 (Apple Message framework v752.3)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Content-Transfer-Encoding: 7bit
Cc: Junio C Hamano <junkio@cox.net>, git@vger.kernel.org
To: Simon Hausmann <simon@lst.de>
X-From: git-owner@vger.kernel.org Sun Jun 03 22:12:34 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HuwRE-0003K4-La
	for gcvg-git@gmane.org; Sun, 03 Jun 2007 22:12:32 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750903AbXFCUMY (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Sun, 3 Jun 2007 16:12:24 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1750927AbXFCUMY
	(ORCPT <rfc822;git-outgoing>); Sun, 3 Jun 2007 16:12:24 -0400
Received: from hobbes.slamb.org ([208.78.103.243]:36357 "EHLO hobbes.slamb.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750867AbXFCUMX (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 3 Jun 2007 16:12:23 -0400
Received: from [172.16.1.4] (ppp-71-139-179-187.dsl.snfc21.pacbell.net [71.139.179.187])
	(using TLSv1 with cipher AES128-SHA (128/128 bits))
	(No client certificate requested)
	by hobbes.slamb.org (Postfix) with ESMTP id 6272B980A7;
	Sun,  3 Jun 2007 13:12:21 -0700 (PDT)
In-Reply-To: <200706031511.31157.simon@lst.de>
X-Gpgmail-State: !signed
X-Mailer: Apple Mail (2.752.3)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/49028>


On Jun 3, 2007, at 6:11 AM, Simon Hausmann wrote:

> On the topic of git integration with perforce, what are the chances  
> of getting
> git-p4 ( http://repo.or.cz/w/fast-export.git ) into git's contrib/ 
> fast-export
> area? :)
>
> git-p4 can do everything git-p4import can do plus a lot more (it  
> can track
> multiple branches, it's a hell of a lot faster, it can export back  
> to p4 and
> it also works on Windows!).

I missed that one...I just saw Tailor and the Perl script someone  
else had written.

Ergh. git-p4 imports both "subprocess" and "popen2" and also uses  
"system" and "os.popen". Why use four different modules to launch git  
and p4?

The branch support's interesting. Have you considered tracking  
integration history? I was pondering it and am not sure if it's  
feasible. Perforce doesn't seem to have an efficient way of  
displaying it (just "p4 integrates" that will fetch *all* revisions  
even if you want incremental results and "p4 filelog" which would  
have to be done on each file). Also, I think there's some mismatch  
between the Perforce and git models.

git-p4import.py should work fine on Windows, too - the binary mode on  
the pipe should be all handled by "subprocess", and git-p4's  
data.replace("\r\n", "\n") is not necessary if you use "LineEnd:  
unix" or "share" in the Perforce client specification.

As for performance...hmm. Looks like git-p4import.py runs these  
commands for each Perforce revision:

     realtime  operation
         3.4%  p4 describe -s N
        66.6%  p4 sync ...@N
    [*] 10.2%  git ls-files -m -d -o -z | git update-index --add -- 
remove -z --stdin
         2.6%  git rev-parse --verify HEAD
         4.2%  git write-tree
         2.8%  git commit-tree xxxxxx
         7.5%  git tag -f p4/N xxxxxx
         2.7%  git update-ref HEAD xxxxxx

That's with Perforce running over the network. Are you running locally?

git-p4 seems to use "git fast-import". I guess the big performance  
improvement there is removing the ls-files operation? So we're  
talking about a 0-10% speedup, right? Plus some fork()/exec() overhead.

[*] - Note that I just discovered a big performance regression in my  
patches. Reading the ls-files into Python, through a regexp, and back  
out through update-index was a horrible idea. The times above are  
with that fixed.

-- 
Scott Lamb <http://www.slamb.org/>
