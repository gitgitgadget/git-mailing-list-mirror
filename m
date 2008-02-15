From: Remi Vanicat <vanicat@debian.org>
Subject: [BUG] git filter-branch failed to suppress a file with an accentuated letter in the filename
Date: Fri, 15 Feb 2008 17:56:55 +0100
Message-ID: <87bq6iw42w.dlv@maison.homelinux.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Fri Feb 15 17:57:47 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JQ3sb-0002No-Pu
	for gcvg-git-2@gmane.org; Fri, 15 Feb 2008 17:57:42 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751723AbYBOQ5G convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Fri, 15 Feb 2008 11:57:06 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751683AbYBOQ5F
	(ORCPT <rfc822;git-outgoing>); Fri, 15 Feb 2008 11:57:05 -0500
Received: from neuf-infra-smtp-out-sp604006av.neufgp.fr ([84.96.92.121]:37508
	"EHLO neuf-infra-smtp-out-sp604006av.neufgp.fr" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751604AbYBOQ5E convert rfc822-to-8bit
	(ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 15 Feb 2008 11:57:04 -0500
Received: from neuf-infra-smtp-out-sp604011av.neufgp.fr ([84.96.92.116])
	by neuf-infra-smtp-out-sp604006av.neufgp.fr with neuf telecom
	id pswv1Y0062We0qU0600300; Fri, 15 Feb 2008 17:56:59 +0100
Received: from maison.homelinux.org ([84.103.71.93])
	by neuf-infra-smtp-out-sp604011av.neufgp.fr with neuf telecom
	id pswy1Y00920lBGc0B00000; Fri, 15 Feb 2008 17:56:58 +0100
Received: from moi by maison.homelinux.org with local (Exim 4.69)
	(envelope-from <moi@vanicat.homelinux.org>)
	id 1JQ3rs-0004sH-61
	for git@vger.kernel.org; Fri, 15 Feb 2008 17:56:57 +0100
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.1 (gnu/linux)
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: moi@vanicat.homelinux.org
X-Spam-Checker-Version: SpamAssassin 3.2.3 (2007-08-08) on maison.homelinux.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.0 required=5.0 tests=NO_RELAYS autolearn=ham
	version=3.2.3
X-SA-Exim-Version: 4.2.1 (built Tue, 21 Aug 2007 23:39:36 +0000)
X-SA-Exim-Scanned: Yes (on maison.homelinux.org)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73958>

git filter-branch --tree-filter has a problem with filename with
accentuated letter:

$ git add foo/bar=C3=A9
$ git commit -m "adding a file with an accent"
Created initial commit b27ae97: adding a file with an accent
 0 files changed, 0 insertions(+), 0 deletions(-)
 create mode 100644 "foo/bar\303\251"
$ git filter-branch --tree-filter "rm -rf foo"
Rewrite b27ae977459379e4e7eee1a3d523f908903ea6ae (1/1)
WARNING: Ref 'refs/heads/master' is unchanged

there the foo/bar=C3=A9 file still exists, but:
$ git filter-branch --tree-filter "rm -rf foo; git add -u"
will suppress the said file from history.

The culprit seem to be those line of filter-branch: (around line 279)=20
		git diff-index -r $commit | cut -f 2- | tr '\012' '\000' | \
			xargs -0 git update-index --add --replace --remove
git diff-index giving the filename as "foo/bar\303\251"


--=20
R=C3=A9mi Vanicat
