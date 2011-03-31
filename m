From: Johan Herland <johan@herland.net>
Subject: Problems with stale .keep files on git server
Date: Thu, 31 Mar 2011 12:46:25 +0200
Message-ID: <201103311246.25645.johan@herland.net>
Mime-Version: 1.0
Content-Type: text/plain;
  charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Thu Mar 31 12:46:46 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Q5FOo-0008Dj-9E
	for gcvg-git-2@lo.gmane.org; Thu, 31 Mar 2011 12:46:46 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1757265Ab1CaKq3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 31 Mar 2011 06:46:29 -0400
Received: from smtp.opera.com ([213.236.208.81]:56935 "EHLO smtp.opera.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1757254Ab1CaKq2 (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 31 Mar 2011 06:46:28 -0400
Received: from johanh.eng.oslo.osa (pat-tdc.opera.com [213.236.208.22])
	(authenticated bits=0)
	by smtp.opera.com (8.14.3/8.14.3/Debian-5+lenny1) with ESMTP id p2VAkPOC014017
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <git@vger.kernel.org>; Thu, 31 Mar 2011 10:46:25 GMT
User-Agent: KMail/1.9.9
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/170466>

Hi,

I have a problem in a server repo where it seems that some previous
"git push" command by some user has left a stale .keep file in the
repo.git/objects/pack/ directory.

Now, when trying to clone the repo on the server, the clone fails with:

$ git clone --bare /path/to/repo.git myclone.git
Cloning into bare repository myclone.git...
fatal: failed to copy file to 'myclone.git/objects/pack/pack-6195737bf980830662f9a44eced023ca4ebe083a.keep': Permission denied

(This is a local clone across filesystems, which I assume simply
copies the objects/ directory from the source repo)

Looking at the .keep file that it's trying to copy from the source
repo, it is owned by the same user as the corresponding .pack and
.idx files, but while the .pack and .idx files have 0440 permissions,
the .keep file has 0600 permission (which explains the "Permission
denied" error). The .keep file itself contains the following text:

  receive-pack 6932 on gitmain

(where gitmain is the hostname of this server)

The timestamp on the .keep file is over a month old, and there is
currently no process with ID 6932 running on this server.

AFAICS, this indicates that someone pushed this pack over a month ago,
and for some reason it failed/aborted, and left the .keep file lying
around. From browsing the source, I see that the .keep file is created
by receive-pack protect the pack from a concurrent "git gc" while it is
being created. However, I have yet to find under which conditions
receive-pack will die without removing the .keep file.

Some questions:

1. Why does the .keep file have 0600 permissions (preventing a local
   clone by any other user)

2. Under which conditions will receive-pack leave stale .keep files
   in the filesystem? Is this a bug?

3. Do I need to scan for and remove stale .keep files in a cron job
   in order to keep repos healthy and clonable?


Thanks,

...Johan

-- 
Johan Herland, <johan@herland.net>
www.herland.net
