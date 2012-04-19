From: Per Cederqvist <cederp@opera.com>
Subject: [GUILT] Preventing "git push" when guilt patches are applied
Date: Thu, 19 Apr 2012 09:23:15 +0200
Message-ID: <4F8FBD63.9050507@opera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Cc: cederp@opera.com, ceder@lysator.liu.se
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Apr 19 09:24:02 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1SKlij-0007N2-0X
	for gcvg-git-2@plane.gmane.org; Thu, 19 Apr 2012 09:24:01 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751751Ab2DSHXX (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 19 Apr 2012 03:23:23 -0400
Received: from smtp.opera.com ([213.236.208.81]:41871 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751342Ab2DSHXW (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 19 Apr 2012 03:23:22 -0400
Received: from [10.30.1.61] (oslo.jvpn.opera.com [213.236.208.46])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id q3J7NGMg022203
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT);
	Thu, 19 Apr 2012 07:23:17 GMT
User-Agent: Mozilla/5.0 (X11; U; Linux i686; en-US; rv:1.9.2.28) Gecko/20120313 Thunderbird/3.1.20
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/195930>

I have by accident done "git push" when I intended to write "guilt
push" a couple of times.  If there are guilt patches applied when I do
this the result is that (part of) my half-finished patch series is
pushed to the master branch.  That is of course not good.

TopGit avoids this issue since I'm on a separate branch when patches
are applied.

Mercurial Queues prevents this.  If I try to do "hg push" with a patch
applied, I get this error:

 > pushing to /home/cederp/pushstop/hgmaster
 > abort: source has mq patches applied

I'd like to add something similar to Guilt, to avoid making this
mistake ever again.  (It is quite embarrassing to clean up after you
push a couple of half-baked patches.)  But I don't know how the
feature should be designed.  Some ideas:

  - Add pre-push hooks to Git, like the one proposed back in 2008 in
    <http://thread.gmane.org/gmane.comp.version-control.git/92900>.
    Have Guilt automatically install a pre-push hook that produces an
    error message if Guilt patches are applied.

  - Have Guilt create a status file (maybe .git/PUSH_FORBIDDEN)
    whenever patches are applied, and remove the file when it pops all
    patches.  The file would contain the following text: "Refusing to
    push while guilt patches are applied.  Hint: see 'guilt -h
    commit'."  Have "git push" check for that file, and print its
    contents if it exists.  (Or should "git push" check for any file
    matching the glob pattern ".git/PUSH_FORBIDDEN.*" and Guilt create
    .git/PUSH_FORBIDDEN.Guilt so that this mechanism is more
    extensible?)

  - Have Guilt remove all remotes when patches are pushed, and restore
    them when all patches are popped.  (I don't like this idea; there
    are too many things that could go wrong.  But it would be possible
    to implement without doing any changes to Git itself.)

I hope the Git community can come up with a better design for this
feature.

     /ceder
