From: "Ping Yin" <pkufranky@gmail.com>
Subject: [RFC] git-submodule: multiple-level modules definition
Date: Mon, 3 Mar 2008 01:11:09 +0800
Message-ID: <46dff0320803020911m30c8e3b3w80c0c92258a45f0f@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
To: "Git Mailing List" <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Sun Mar 02 18:11:49 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JVrj2-0006QI-Uv
	for gcvg-git-2@gmane.org; Sun, 02 Mar 2008 18:11:49 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754476AbYCBRLM (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 2 Mar 2008 12:11:12 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754459AbYCBRLM
	(ORCPT <rfc822;git-outgoing>); Sun, 2 Mar 2008 12:11:12 -0500
Received: from an-out-0708.google.com ([209.85.132.243]:4596 "EHLO
	an-out-0708.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751984AbYCBRLK (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 2 Mar 2008 12:11:10 -0500
Received: by an-out-0708.google.com with SMTP id d31so1132379and.103
        for <git@vger.kernel.org>; Sun, 02 Mar 2008 09:11:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:received:received:message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        bh=mVqVtV1Y55nL+W/czu3Yfqpfka7oe/yfSCqTv7s7gPM=;
        b=m6/yQl7oLdm1vbFrIXIj+W3J0+hPKy1tS5buEbxuXJtFpaAV+Um4MLYIBpDEmsD73NA0HgyUTNNdCuPClNlrk6sGen3/WV/ZSmR72nJra2h3KQjEYw1G0EyeV/S0wwVLB+JcFJ3n4zUtGk1RVDLD1Pc27cWWbohd0x/5X6GHitE=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=message-id:date:from:to:subject:mime-version:content-type:content-transfer-encoding:content-disposition;
        b=GQzjoWsZfEq0Ht4w0V9k9HNRQ+OvOOji4owsatxyDTbTsanE0H1cMD2I1/95kZyPf+/oXyHhQGwxYtK7YwHTDBxf+UYMfVvSFn9Oe5t2ykMlGdLzWhV2Vtrj9eptZpQwaXuwJ5hHYNyoadAOgOSNVTTuJx6ILzebF0UNghe0Ek0=
Received: by 10.100.139.20 with SMTP id m20mr19544821and.63.1204477869869;
        Sun, 02 Mar 2008 09:11:09 -0800 (PST)
Received: by 10.100.95.20 with HTTP; Sun, 2 Mar 2008 09:11:09 -0800 (PST)
Content-Disposition: inline
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/75811>

1. .gitmodules supports multiple submodule level definition

This follows suggestions from Linus and and Sven Verdoolaege etc.
See "Let .git/config specify the url for submodules"
(http://article.gmane.org/gmane.comp.version-control.git/48939).

.gitmodules with with multiple level of indirection
------------------------------------------------------
[submodule "service"]
    submodule = crawler
    submodule = search
[submodule "crawler"]
    submodule = util
    submodule = imcrawter
[submodule "search"]
    submodule = util
    submodule = imsearch
[submodule "util"]                      (1)
    url = git://xyzzy/util.git
[submodule "imsearch"]
    path = search/imsearch
    url = git://xyzzy/imsearch.git
[submodule "imcrawler"]
    path = crawler/imcrawter
    url = git://xyzzy/imcrawter.git

(1): path default to submodule name
------------------------------------------------------

To simplify the case, submodule sections with submodule attribute should
have neither path attribute nor url attribute (if have, should be ignored).

2. Designate modules by logical names instead of real path

"--name|-n" options is proposed with which modules are designated by logical
names instead of real paths as following example shows.

Identical commands forms with/without "--name"
---------------------------------------------------
$ git submodule XXX util imcrawler              (1)
$ git submodule XXX -n crawler                  (2)
$ git submodule XXX util imcrawler imsearch     (3)
$ git submodule XXX -n service                  (4)
$ git submodule XXX -n crawler search           (5)

* XXX represent list, update or init, but not add
* (1) and (2) are idetical conditionally (explained below)
* (3), (4) and (5) are idetical conditionally
---------------------------------------------------

There are still minor difference between these two forms.

In the no "--name" form, the path parameter may be not the real submodule
path, and it just acts as the filter for real submodule paths.

In the "--name" form, name parameter must be the logical name, and the real
paths corresponding to the logical name may be neither a submodule path nor
even existent. How to handle such a path depends on the subcommand.

  1) status: Output 0{40} as the sha1. Doing this can remind the user to
     add the path as submodule or delete the path from .gitmodules.
  2) update: Skip that path and issue a warning
  3) init: Also init for that path

So in the example above, commands (1) and (2) are identical only when util and
imcrawler are already submodules.

3. Add submodules in batch with "git submodule add --name"

The former workflow to add submodules is adding one by one with
"git submodule add url path" which then modifies .gitmodules. However,
sometimes it may be more convenient to work in the reverse way: edit
.gitmodules first and then add submodules in batch.

Now "git submodule add --name modulename" can help us to do that. It will
find all submodules corresponding to the logical name and add them in batch
by using the path and url from .gitmodules. Of course, it will skip those
paths which have already been submodules.

4. Do we really need 'init' subcommand?

I think .gitmodules should have been bound more tightly with "git submodule".
Now it seems that 'update' or 'status' can still be performed without
.gitmodules after "git submodule init".

So why not to read submodules info from .gitmodules directly just like what
.gitignore nor .gitattributes have been dealt with? Just for editing them
more free?

>From another point, correspoingding to .gitignore we have .git/info/exclude
which just records some paths special to the local repository. But
.git/info/exclude can't replace .gitignore. But why can .git/config replace
.gitmodules which is a naive attribute of the repository?

After introducing multi-level module definition, .gitmodules becomes
more naive to the repository. And it becomes more inappropriate to put
all .gitmodules contents into .git/config since multi-level module
definition shouldn't be edited outside .gitmodules.


-- 
Ping Yin
