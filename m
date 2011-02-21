From: Will Palmer <wmpalmer@gmail.com>
Subject: [BUG] git-svn fails to rename files with %20 in filename
Date: Mon, 21 Feb 2011 10:12:24 +0000
Message-ID: <1298283144.2772.7.camel@wpalmer.simply-domain>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
To: git <git@vger.kernel.org>
X-From: git-owner@vger.kernel.org Mon Feb 21 11:12:35 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1PrSks-00081f-Mf
	for gcvg-git-2@lo.gmane.org; Mon, 21 Feb 2011 11:12:35 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754544Ab1BUKM3 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 21 Feb 2011 05:12:29 -0500
Received: from mail-wy0-f174.google.com ([74.125.82.174]:43838 "EHLO
	mail-wy0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750840Ab1BUKM2 (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 21 Feb 2011 05:12:28 -0500
Received: by wyb38 with SMTP id 38so921476wyb.19
        for <git@vger.kernel.org>; Mon, 21 Feb 2011 02:12:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:subject:from:to:content-type:date:message-id
         :mime-version:x-mailer:content-transfer-encoding;
        bh=hfHvFLcTFDiSE686KM0OD9Uhy2lfoyzS/R1F3vV3wYw=;
        b=b8ibFDwta3Rat7kI3of27UhWxpvGBBnz7EJmY3O1fVOb9RoNkKg1Cbj+O3fY/SURAM
         Uj+RClkgIBJJQV74QkK5SVTkLSnus/A5ag8YUNoSheYSv/OXomB3J/BTBZhlSDeZwtJD
         vnqxIcY1cOfBuBzp10FFLgxOpaxcxXQf38+UA=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=subject:from:to:content-type:date:message-id:mime-version:x-mailer
         :content-transfer-encoding;
        b=iCZVuSCEowqZOs8H/VH9BvS7o/UZ60J4Q5CrAkuzEtXRpaoJKsoeEZoe/P3SA6JS7E
         3K8ikHGLwVOZzFsg/A8PBBsjFbruHX6Rc/jf9dqDzKiyLXE8hoxHEgrEO0gmdkw5XAUB
         PDIcQeLKV+4oe4PIqXi2yhafPprPM7/RWches=
Received: by 10.216.58.130 with SMTP id q2mr996350wec.57.1298283147395;
        Mon, 21 Feb 2011 02:12:27 -0800 (PST)
Received: from [192.168.2.128] (tontine65c.demon.co.uk [80.176.141.31])
        by mx.google.com with ESMTPS id n1sm907985weq.31.2011.02.21.02.12.25
        (version=SSLv3 cipher=OTHER);
        Mon, 21 Feb 2011 02:12:26 -0800 (PST)
X-Mailer: Evolution 2.28.3 
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/167454>

Someone accidentally checked some files containing "%20" in their names
into our svn repository, which is accessed with either svn or git-svn
depending on the developer.
When I attempted to correct this by renaming the file, I received (on
dcommit):
Filesystem has no item: File not found: revision 1, path
'/theBeginningOfTheOriginalFileName theRestOfTheOriginalFilename'
at /home/wpalmer/libexec/git-core/git-svn line 576


A recipe for reproducing this bug is as follows:
#!/bin/bash
temp="$(mktemp -t -d 'git-svn.XXXXXXXXXX')"
[ -n "$temp" ] || { echo "Failed to create temporary directory" >&2;
exit 1; }
function _cleanup(){
	rm -rf "$temp"
}
trap _cleanup INT EXIT
cd "$temp" || exit 1

set -x
svnadmin create svn-repos &&
svn co file://$PWD/svn-repos svn-wc &&
cd svn-wc &&
touch 'foo%20bar' &&
svn add 'foo%20bar' &&
svn ci -m 'add foo%20bar' &&
cd .. &&
git svn clone file://$PWD/svn-repos git-wc &&
cd git-wc &&
git mv 'foo%20bar' 'foo-bar' &&
git commit -m 's/%20/-/ in filename' &&
git svn dcommit # BUG HERE
