From: Nicolas Morey-Chaisemartin <devel-git@morey-chaisemartin.com>
Subject: git submodule status during merge
Date: Wed, 16 Mar 2011 10:32:57 +0100
Message-ID: <4D8083C9.4070300@morey-chaisemartin.com>
Reply-To: devel-git@morey-chaisemartin.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Wed Mar 16 12:20:19 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Pzom3-0002Io-9G
	for gcvg-git-2@lo.gmane.org; Wed, 16 Mar 2011 12:20:19 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752641Ab1CPLUN (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 16 Mar 2011 07:20:13 -0400
Received: from 3.27.mail-out.ovh.net ([46.105.56.209]:42872 "HELO
	27.mail-out.ovh.net" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with SMTP id S1751686Ab1CPLUM (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 16 Mar 2011 07:20:12 -0400
X-Greylist: delayed 6000 seconds by postgrey-1.27 at vger.kernel.org; Wed, 16 Mar 2011 07:20:11 EDT
Received: (qmail 1532 invoked by uid 503); 16 Mar 2011 10:27:10 -0000
Received: from b9.ovh.net (HELO mail193.ha.ovh.net) (213.186.33.59)
  by 27.mail-out.ovh.net with SMTP; 16 Mar 2011 10:26:55 -0000
Received: from b0.ovh.net (HELO queueout) (213.186.33.50)
	by b0.ovh.net with SMTP; 16 Mar 2011 11:32:59 +0200
Received: from mailhost.kalray.eu (HELO sat.lin.mbt.kalray.eu) (devel-git@morey-chaisemartin.com@217.108.237.233)
  by ns0.ovh.net with SMTP; 16 Mar 2011 11:32:59 +0200
User-Agent: Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.13) Gecko/20101209 Fedora/3.1.7-0.35.b3pre.fc14 Lightning/1.0b2 Thunderbird/3.1.7
X-Ovh-Tracer-Id: 9496402764590407646
X-Ovh-Remote: 217.108.237.233 (mailhost.kalray.eu)
X-Ovh-Local: 213.186.33.20 (ns0.ovh.net)
X-Spam-Check: DONE|U 0.5/N
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/169138>

Hi,

While I was trying to merge a superproject with tons of submodule (conflicting) I noticed that several submodules show 3 times when running "git submodule status"

Ex:
+c31377d713fa3ef03960de6672ce69d2a1e7317e gdb (reverse-20080717-branchpoint-7820-gc31377d)
+c31377d713fa3ef03960de6672ce69d2a1e7317e gdb (reverse-20080717-branchpoint-7820-gc31377d)
+c31377d713fa3ef03960de6672ce69d2a1e7317e gdb (reverse-20080717-branchpoint-7820-gc31377d)

After a quick investigation, it appears this is due to module_list in git-submodule which uses
        git ls-files --error-unmatch --stage -- "$@" | sane_grep '^160000 '
to retrieve a list of all available submodules.

As there is a conflict, the submodules show in 3 different stages.
The status command later uses
    cd "$path" && git rev-parse --verify HEAD
so the same SHA1 is displayed for the 3 times the submodule appears.

Although it is not a big issue, it is quite puzzling for most people.
So here are the few questions:
    * Is this an expected behaviour and if yes, why?
    * If not, is module_list the place to fix it?
It does not seem that any of the git commands are using the stage information yet. So I suppose keeping only one of the entries should not be too problematic.
Simply filtering with something like awk '{ if ($3 == 0 || $3 == 1) print $0}'  seems to solve the problem

Thanks in advance

Nicolas Morey-Chaisemartin
