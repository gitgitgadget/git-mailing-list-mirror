From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] add -p: 'q' should really quit
Date: Fri, 29 Apr 2011 15:34:43 -0700
Message-ID: <7vzkn8vg8s.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Matthieu Moy <Matthieu.Moy@imag.fr>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Sat Apr 30 00:35:05 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QFwH9-0000IW-Fi
	for gcvg-git-2@lo.gmane.org; Sat, 30 Apr 2011 00:35:03 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753963Ab1D2We6 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 29 Apr 2011 18:34:58 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:49199 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323Ab1D2We5 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 29 Apr 2011 18:34:57 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 12F6A5468;
	Fri, 29 Apr 2011 18:36:55 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; s=sasl; bh=e
	402KdaSymcDA7XINbidO9odx5E=; b=fCHik9YkUo4lsll2acT1F470HDRnZkOa4
	SjiQ0xrVAWhw5wf5bpU+GLGWNLpMpq/HQUVRdxmI2NcQdGy+CeAG4fCOTgXkq3uw
	JO05MODmiFNewgNL2vP3AKWRfeRReV4WLhe4YTiasC8RYdQjY/7+zeNchWGot5c3
	5UzXLJpmPg=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:date:message-id:mime-version:content-type; q=dns; s=
	sasl; b=QMHYRtPndGH/8syDiXPi1gKwDzis5EQk2uOLHOEFRYG1mNfysfYaZcDZ
	C+nDu1gQVp8JzPHgLO2JuAzI4Ti8XDi3BRBWy9NtB/ZCB45uIBqm759YKmzWfojC
	RMnCzQzciJvVsrXaUjAjQnnWdStzZ/I3QwM5822ydZekdSk/6VY=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id DB8C65467;
	Fri, 29 Apr 2011 18:36:51 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id D91395465; Fri, 29 Apr 2011
 18:36:47 -0400 (EDT)
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 2D6C0D4E-72B1-11E0-AA61-E8AB60295C12-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/172501>

The "quit" command was added in 9a7a1e0 (git add -p: new "quit" command at
the prompt, 2009-04-10) to allow the user to say that hunks other than
what have already been chosen are undesirable, and exit the interactive
loop immediately.  It forgot that there may be an undecided hunk before
the current one.  In such a case, the interactive loop still goes back to
the beginning.

Clear all the USE bit for undecided hunks and exit the loop.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 git-add--interactive.perl |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/git-add--interactive.perl b/git-add--interactive.perl
index a329c5a..4fb8cd0 100755
--- a/git-add--interactive.perl
+++ b/git-add--interactive.perl
@@ -1366,14 +1366,13 @@ sub patch_update_file {
 				next;
 			}
 			elsif ($line =~ /^q/i) {
-				while ($ix < $num) {
-					if (!defined $hunk[$ix]{USE}) {
-						$hunk[$ix]{USE} = 0;
+				for ($i = 0; $i < $num; $i++) {
+					if (!defined $hunk[$i]{USE}) {
+						$hunk[$i]{USE} = 0;
 					}
-					$ix++;
 				}
 				$quit = 1;
-				next;
+				last;
 			}
 			elsif ($line =~ m|^/(.*)|) {
 				my $regex = $1;
-- 
1.7.5.252.g565191
