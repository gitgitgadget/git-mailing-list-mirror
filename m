From: Junio C Hamano <gitster@pobox.com>
Subject: Re: What's cooking in git/spearce.git (Oct 2008, #02; Sun, 12)
Date: Sun, 12 Oct 2008 20:49:53 -0700
Message-ID: <7vprm5duhq.fsf@gitster.siamese.dyndns.org>
References: <20081012212543.GG4856@spearce.org>
 <7v3aj1fdw2.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Shawn O. Pearce" <spearce@spearce.org>
X-From: git-owner@vger.kernel.org Mon Oct 13 05:51:17 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1KpESi-00069B-91
	for gcvg-git-2@gmane.org; Mon, 13 Oct 2008 05:51:16 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754165AbYJMDuE (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 12 Oct 2008 23:50:04 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753678AbYJMDuD
	(ORCPT <rfc822;git-outgoing>); Sun, 12 Oct 2008 23:50:03 -0400
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:35126 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752084AbYJMDuC (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 12 Oct 2008 23:50:02 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with ESMTP id 8B2798702A;
	Sun, 12 Oct 2008 23:50:00 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-quonix.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id AC96A87029; Sun, 12 Oct 2008 23:49:56 -0400 (EDT)
In-Reply-To: <7v3aj1fdw2.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Sun, 12 Oct 2008 19:05:33 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 02A44620-98DA-11DD-905D-4F5276724C3F-77302942!a-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/98076>

Junio C Hamano <gitster@pobox.com> writes:

> "Shawn O. Pearce" <spearce@spearce.org> writes:
>
>> * pb/rename-rowin32 (Fri Oct 3 12:20:43 2008 +0200) 1 commit
>>  - Do not rename read-only files during a push
>>
>> Supposedly fixes pack file renames on Windows, but it makes the
>> test suite fail on Linux.  I haven't debugged why yet.
>
> I am kind of surprised that it actually passes the test on Windows, which
> implies that these cats shown in the patch to fix this breakage below do
> not honor ro-ness of the file, which in turn makes me doubt if making the
> resulting packfiles read-only has any effect on that platform whatsoever..

Actually, the patch I posted was wrong and shouldn't be applied, as the
original breakage is a sign that the externally observable behaviour of
the command has changed, and the patch was just hiding it under the rug.

The thing is that 8c76006 (Do not rename read-only files during a push,
2008-10-03) makes unnecessary chmod() when there is no rename is involved,
namely when it is used to index an existing packfile on the filesystem.

I think the attached patch is a better fix, to be squashed in.

Note: I now have the pumpkin, so you do not have to apply and push the
results out --- this is just me showing a proposed change as usual.

 index-pack.c |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git c/index-pack.c w/index-pack.c
index 2c69f08..aec11cb 100644
--- c/index-pack.c
+++ w/index-pack.c
@@ -823,7 +823,8 @@ static void final(const char *final_pack_name, const char *curr_pack_name,
 		if (move_temp_to_file(curr_pack_name, final_pack_name))
 			die("cannot store pack file");
 	}
-	chmod(final_pack_name, 0444);
+	if (from_stdin)
+		chmod(final_pack_name, 0444);
 
 	if (final_index_name != curr_index_name) {
 		if (!final_index_name) {
