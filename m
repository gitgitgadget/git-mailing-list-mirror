From: Jens Lehmann <Jens.Lehmann@web.de>
Subject: Re: Possible bug: Git submodules can get into broken state
Date: Thu, 04 Apr 2013 21:56:33 +0200
Message-ID: <515DDAF1.7080503@web.de>
References: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Cc: git@vger.kernel.org
To: Chris Wilson <chris+gitscm@aptivate.org>
X-From: git-owner@vger.kernel.org Thu Apr 04 21:57:08 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UNqHU-0000II-72
	for gcvg-git-2@plane.gmane.org; Thu, 04 Apr 2013 21:57:08 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1763432Ab3DDT4k (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 4 Apr 2013 15:56:40 -0400
Received: from mout.web.de ([212.227.15.3]:58540 "EHLO mout.web.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1763393Ab3DDT4j (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 4 Apr 2013 15:56:39 -0400
Received: from [192.168.178.41] ([79.193.90.93]) by smtp.web.de (mrweb101)
 with ESMTPA (Nemesis) id 0LnSGg-1UpjEh0NkU-00h6xE; Thu, 04 Apr 2013 21:56:37
 +0200
User-Agent: Mozilla/5.0 (X11; Linux i686 on x86_64; rv:17.0) Gecko/20130328 Thunderbird/17.0.5
In-Reply-To: <alpine.DEB.2.02.1304041758140.965@lap-x201.fen.aptivate.org>
X-Enigmail-Version: 1.5.1
X-Provags-ID: V02:K0:ouvz8CetLztyvGmiXKV5MRtab/1Jkd6zhCNwo6Ct3iM
 ce5taz92p9YzKlO4Y07RJW3XHeMhLn/2N22voWbIOxiX/WTU8g
 kHbc0MJkYZ5ts/vDTifU9EGyRMwKW24wFLjLZJTdIzTdxmCjwl
 c9BEQGQ+bZU6EC6NS7MxSQgZS6CMhfwqoTSCUzgkutbMYdUPZS
 LhEtjgexT8+MgCKPSdsWA==
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/220083>

Am 04.04.2013 19:10, schrieb Chris Wilson:
> If your git repo's .gitmodules contains a URL that you don't have access to (for example you download someone else's code and it references a submodule using their writable git@github.com URL) then:
> 
> * git submodule init will add them to .git/config, with the wrong URLs.
> 
> * git submodule update will fail to check out the repos, leaving an empty directory for the first one, and nothing for the others.
> 
> This state is broken (wrong URLs in .git/config), and AFAIK there's nothing you can do to check out these submodules without either:
> 
> (a) manually hacking them out of .git/config, or

... or:

(c) Enter the correct URL in .git/config.

> (b) doing "git submodule rm" and then "git checkout .gitmodules" to undo the damage to that file.

Hmm ... that leaves your superproject dirty, right?

(d) Update the .gitmodules file to use the correct URL (you
    want to do a commit fixing that anyway, no? ;-) and do a
    "git submodule sync", which will copy the corrected URL
    into .git/config.


> The procedure I tried, which I expected to work, was:
> 
> * git submodule sync (doesn't sync them, because the directories don't exist or don't contain a valid git repo?)

No, because .gitmodules still contained the broken URL which a
sync then copies into .git/config again.

> * git submodule init (ignores them, because they're already in .git/config?)

Correct.

> * git submodule update (still fails because the URL in .git/config is wrong).

Sure.

> The new deinit command may help, but for the wrong reasons. I don't want to have to deinit my modules every time in the fabric deployment script, just so that if they get into this state, they will get unbroken automatically.

I doubt deinit will help here (except after running that you'll
be able to use "git submodule update" to populate the remaining
submodules) unless you fix the broken URL in .git/config or
.gitmodules.

> It seems wrong to me that neither "git submodule init" nor "git submodule sync" will modify the URL in .git/config, if the submodule is not already checked out. I think I'd expect "git submodule init" to be idempotent, so it would update the URLs in .git/config if they already exist, just like it adds the URLs if they don't.
> 
> Any advice? Is this a real bug?

Hmm, at first glance this looks like a pilot error. Maybe we could
update the documentation to help other users falling into that
trap or extend some commands to be a bit more helpful in such a
case, but it looks like the behavior you observed is documented
(while fixing the problem you observed isn't explicitly). Also an
option for "git submodule update" to continue even if it fails to
populate some submodules might help here.
