From: Richard Purdie <richard.purdie@linuxfoundation.org>
Subject: Alternates corruption issue
Date: Tue, 31 Jan 2012 14:05:29 +0000
Message-ID: <1328018729.13744.26.camel@ted>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Cc: "Hart, Darren" <darren.hart@intel.com>,
	"Ashfield, Bruce" <Bruce.Ashfield@windriver.com>
To: GIT Mailing-list <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Tue Jan 31 15:32:23 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RsEkt-0002Fl-0W
	for gcvg-git-2@plane.gmane.org; Tue, 31 Jan 2012 15:32:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754338Ab2AaOcO (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 31 Jan 2012 09:32:14 -0500
Received: from 93-97-173-237.zone5.bethere.co.uk ([93.97.173.237]:57206 "EHLO
	tim.rpsys.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753368Ab2AaOcN (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 31 Jan 2012 09:32:13 -0500
X-Greylist: delayed 1594 seconds by postgrey-1.27 at vger.kernel.org; Tue, 31 Jan 2012 09:32:13 EST
Received: from localhost (localhost [127.0.0.1])
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0VE5aHX009933;
	Tue, 31 Jan 2012 14:05:36 GMT
Received: from tim.rpsys.net ([127.0.0.1])
 by localhost (tim.rpsys.net [127.0.0.1]) (amavisd-new, port 10024) with LMTP
 id 08722-05; Tue, 31 Jan 2012 14:05:32 +0000 (GMT)
Received: from [192.168.3.10] ([192.168.3.10])
	(authenticated bits=0)
	by tim.rpsys.net (8.13.6/8.13.8) with ESMTP id q0VE5QNl009927
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO);
	Tue, 31 Jan 2012 14:05:30 GMT
X-Mailer: Evolution 3.2.2- 
X-Virus-Scanned: amavisd-new at rpsys.net
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189454>

I have a problem with git clone commands using alternates failing by
mixing up different repositories. I have a situation where I could end
up with both:

/srv/mirrors/repo
/srv/mirrors/repo.git

as bare clones.

I then try cloning "repo" with alternates with the command:

$ git clone -s -n /srv/mirrors/repo /tmp/foo
Cloning into /tmp/foo...
done.

$ cat /tmp/foo/.git/objects/info/alternates
/srv/mirrors/repo.git/objects

Note how I'm now referencing repo.git, not repo. This doesn't work as
expected giving some very bizarre results when actually using the
repository.

I appreciate this is a rather bizarre corner case but its one that is
breaking the build system I work with. Ideally people would use a
consistent URL for the same repository but we have an example where they
haven't and this really shouldn't break like this.

Looking at the code, the cause seems to be

clone.c:get_repo_path():

	static char *suffix[] = { "/.git", ".git", "" };

since its looking in order for:
 repo/.git (fails)
 repo.git (suceeds, incorrect)
 repo (never looked at)

I'm not sure what would break if that order were to change, swapping the
last two options.

I can "force" the issue by running:

git clone -s -n /srv/mirrors/repo/ /tmp/foo

but this results in the slightly odd looking:

$ cat /tmp/foo/.git/objects/info/alternates
/srv/mirrors/repo//objects

which does at least work.

Any idea if its possible to fix the root cause of this problem?

Cheers,

Richard
