From: Junio C Hamano <gitster@pobox.com>
Subject: Re: git-push error: Cannot write keep file
Date: Tue, 24 Feb 2009 09:31:21 -0800
Message-ID: <7v7i3fivx2.fsf@gitster.siamese.dyndns.org>
References: <49A428B7.4000003@spiralti.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Rafael Darder Calvo <rdarder@spiralti.com>
X-From: git-owner@vger.kernel.org Tue Feb 24 18:34:22 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lc1Ad-00046H-Qs
	for gcvg-git-2@gmane.org; Tue, 24 Feb 2009 18:34:16 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1759667AbZBXRba (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 24 Feb 2009 12:31:30 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1760384AbZBXRba
	(ORCPT <rfc822;git-outgoing>); Tue, 24 Feb 2009 12:31:30 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:34001 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757566AbZBXRb2 (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 24 Feb 2009 12:31:28 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 5615B2BD76;
	Tue, 24 Feb 2009 12:31:26 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 b-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 6D2122BD56; Tue,
 24 Feb 2009 12:31:23 -0500 (EST)
In-Reply-To: <49A428B7.4000003@spiralti.com> (Rafael Darder Calvo's message
 of "Tue, 24 Feb 2009 15:04:55 -0200")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: F69B81A8-0298-11DE-90A1-6F7C8D1D4FD0-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/111317>

Rafael Darder Calvo <rdarder@spiralti.com> writes:

> Hello,
> 	I am having the following error when I try to git push.
>
>
> rdarder@shiny:~/Sources/promotoras$ git push origin ranto:ranto
> Counting objects: 256, done.
> Compressing objects: 100% (199/199), done.
> Writing objects: 100% (213/213), 216.94 KiB, done.
> Total 213 (delta 60), reused 1 (delta 0)
>
> fatal: cannot write keep file
>
> error: unpack failed: index-pack abnormal exit
> To ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git
>  ! [remote rejected] ranto -> ranto (n/a (unpacker error))
> error: failed to push some refs to
> 'ssh://fherrero@10.7.1.20:2222/var/www/promotoras.git'
>
>
> I couldn't find any significant description on the error "cannot write
> keep file". git-fsck passes without errors in both repositories, and I
> find no permission problems. Can anyone give me some directions on how
> to diagnose this?

If you have access to the receiving side of the repository and the machine
that hosts it, the debug patch attached may help.

One possibility is the receiving repository was initialized long time ago
with an ancient git (ealier than f49fb35 (git-init-db: create "pack"
subdirectory under objects, 2005-06-27), and never had a packfile in it
since then.  We started creating '.git/objects/pack/' subdirectory in
git-init only after that commit.  It was Ok for a long time because we
lazily create "pack" subdirectory as needed, but a recent change 8b4eb6b
(Do not perform cross-directory renames when creating packs, 2008-09-22)
carelessly assumed that .git/objects/pack/ directory would always exist
and tries to create files in there without making sure the leading
directories exist.  See $gmane/110621

    Subject: [PATCH] Make sure objects/pack exists before creating a new pack
    To: git@vger.kernel.org
    Date: Wed, 18 Feb 2009 20:48:07 -0800
    Message-ID: <7vr61vnibc.fsf@gitster.siamese.dyndns.org>

for details.

And the debug patch...

 index-pack.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/index-pack.c b/index-pack.c
index f7a3807..acdc85f 100644
--- a/index-pack.c
+++ b/index-pack.c
@@ -802,14 +802,18 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		keep_fd = open(keep_name, O_RDWR|O_CREAT|O_EXCL, 0600);
 		if (keep_fd < 0) {
 			if (errno != EEXIST)
-				die("cannot write keep file");
+				die("cannot write keep file '%s' (%s)",
+				    keep_name,
+				    strerror(errno));
 		} else {
 			if (keep_msg_len > 0) {
 				write_or_die(keep_fd, keep_msg, keep_msg_len);
 				write_or_die(keep_fd, "\n", 1);
 			}
 			if (close(keep_fd) != 0)
-				die("cannot write keep file");
+				die("cannot close the written keep file '%s' (%s)",
+				    keep_name,
+				    strerror(errno));
 			report = "keep";
 		}
 	}
