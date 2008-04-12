From: Junio C Hamano <gitster@pobox.com>
Subject: Re: Intricacies of submodules
Date: Fri, 11 Apr 2008 22:25:48 -0700
Message-ID: <7vej9blk4j.fsf@gitster.siamese.dyndns.org>
References: <47F15094.5050808@et.gatech.edu> <47FBDA77.2050402@et.gatech.edu>
 <32541b130804081401n743f39c9o3f016da9dee2eb92@mail.gmail.com>
 <8FE3B7A7-4C2D-4202-A5FC-EBC4F4670273@sun.com>
 <32541b130804082033q55c795b5ieaa4e120956ff030@mail.gmail.com>
 <49E9DCEC-8A9E-4AD7-BA58-5A40F475F2EA@sun.com>
 <32541b130804082334s604b62b0j82b510c331f48213@mail.gmail.com>
 <7vhcebcyty.fsf@gitster.siamese.dyndns.org>
 <6CFA8EC2-FEE0-4746-A4F6-45082734FEEC@sun.com>
 <7v63uqz265.fsf@gitster.siamese.dyndns.org>
 <46dff0320804112102t52a60072rc97c772a1e74f597@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Junio C Hamano" <gitster@pobox.com>,
	"Roman Shaposhnik" <rvs@sun.com>,
	"Avery Pennarun" <apenwarr@gmail.com>,
	stuart.freeman@et.gatech.edu, git@vger.kernel.org
To: "Ping Yin" <pkufranky@gmail.com>
X-From: git-owner@vger.kernel.org Sat Apr 12 07:26:51 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JkYGI-00086a-En
	for gcvg-git-2@gmane.org; Sat, 12 Apr 2008 07:26:50 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753318AbYDLF0G (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sat, 12 Apr 2008 01:26:06 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752275AbYDLF0F
	(ORCPT <rfc822;git-outgoing>); Sat, 12 Apr 2008 01:26:05 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:49481 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751440AbYDLF0D (ORCPT <rfc822;git@vger.kernel.org>);
	Sat, 12 Apr 2008 01:26:03 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 8A6C725C2;
	Sat, 12 Apr 2008 01:26:01 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTP id 5DBD325C1; Sat, 12 Apr 2008 01:25:52 -0400 (EDT)
In-Reply-To: <46dff0320804112102t52a60072rc97c772a1e74f597@mail.gmail.com>
 (Ping Yin's message of "Sat, 12 Apr 2008 12:02:25 +0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/79332>

"Ping Yin" <pkufranky@gmail.com> writes:

>>  After working with the project for a while (i.e. you pull and perhaps push
>>  back or send patches upstream), .gitmodules file changes and it now says
>>  the repository resides at host B.xz because the project relocated.  You
>>  would want the next "git submodule update" to notice that your .git/config
>>  records a URL you derived from git://A.xz/project.git/, and that you have
>>  not seen this new URL git://B.xz/project.git/, and give you a chance to
>>  make adjustments if needed.
>
> I think this should be done if "git submodule update" fails. The
> reason it fails may be different, such as newest commits not pushed
> out and the subproject relocated etc. So it can only given some hints
> with "maybe".
>
> However, how to detect the url has changed in .gitmodules? Compare the
> latest two version of .gitmodules?

That's why I suggested (and Roman seems to have got it, so I do not think
what I wrote was too confusing to be understood) you should record the set
of _all_ URLs you have _seen_ in .git/config.  If the URL in .gitmodules
checked out is included in that set, you do not do anything.  Otherwise
you ask.

I think "git submodule update" is a good place to do that check, but I'd
prefer it be done _before_ it actually goes to the network to start
accessing potentially stale URL.  The old URL may not be defunct but the
project decided not to advertise it to be used for some non-technical
reason (e.g. the site owner asked them not to point at it and instead use
some other mirrors).

> When bug happens, i only care the commit in the index of submodule and
> wheter i can check out the old submodule commit. However, does it
> really matter that what the url of the submodule is?

No.  The discussion was what should _not_ happen when you run "git
submodule update" from that state.  Usually in a steadily advancing
history, you _want_ "git submodule update" to notice that the suggested
remote URL has changed in .gitmodules and give the user a chance to adjust
the URL _before_ it hits the network, but you obviously do not want it to
happen only because you happened to be at a seeked back commit when you
initiated "git submodule update".  In other words, you are agreeing with
me without really reading what I wrote ;-)  It does not matter, and
recording the URLs you have _seen_ (not "the last one you saw", or "the
one you initialized .git/config with") is a way to make sure that the
fixed "git submodule update" agrees with us on that point.
