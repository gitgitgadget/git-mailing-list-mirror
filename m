From: Junio C Hamano <junkio@cox.net>
Subject: Re: git-format-patch --subject-prefix support.
Date: Thu, 12 Apr 2007 03:04:05 -0700
Message-ID: <7vslb5kiy2.fsf@assigned-by-dhcp.cox.net>
References: <11763358884124-git-send-email-robbat2@gentoo.org>
	<7vodlumntw.fsf@assigned-by-dhcp.cox.net>
	<Pine.LNX.4.64.0704120150320.22924@beast.quantumfyre.co.uk>
	<7v4pnmmk9l.fsf@assigned-by-dhcp.cox.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: "Robin H. Johnson" <robbat2@gentoo.org>
X-From: git-owner@vger.kernel.org Thu Apr 12 12:04:15 2007
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1HbwA3-0008R0-Ed
	for gcvg-git@gmane.org; Thu, 12 Apr 2007 12:04:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1946043AbXDLKEL (ORCPT <rfc822;gcvg-git@m.gmane.org>);
	Thu, 12 Apr 2007 06:04:11 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S2992424AbXDLKEL
	(ORCPT <rfc822;git-outgoing>); Thu, 12 Apr 2007 06:04:11 -0400
Received: from fed1rmmtao102.cox.net ([68.230.241.44]:38992 "EHLO
	fed1rmmtao102.cox.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1945980AbXDLKEI (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 12 Apr 2007 06:04:08 -0400
Received: from fed1rmimpo02.cox.net ([70.169.32.72])
          by fed1rmmtao102.cox.net
          (InterMail vM.7.05.02.00 201-2174-114-20060621) with ESMTP
          id <20070412100406.VEQY1268.fed1rmmtao102.cox.net@fed1rmimpo02.cox.net>;
          Thu, 12 Apr 2007 06:04:06 -0400
Received: from assigned-by-dhcp.cox.net ([68.5.247.80])
	by fed1rmimpo02.cox.net with bizsmtp
	id mA451W00a1kojtg0000000; Thu, 12 Apr 2007 06:04:06 -0400
In-Reply-To: <7v4pnmmk9l.fsf@assigned-by-dhcp.cox.net> (Junio C. Hamano's
	message of "Wed, 11 Apr 2007 18:52:38 -0700")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/44332>

Junio C Hamano <junkio@cox.net> writes:

> Julian Phillips <julian@quantumfyre.co.uk> writes:
>
>> On Wed, 11 Apr 2007, Junio C Hamano wrote:
>>
>>> "Robin H\. Johnson" <robbat2@gentoo.org> writes:
>>>
>>>> Add a new option to git-format-patch, entitled --subject-prefix that allows
>>>> control of the subject prefix '[PATCH]'. Using this option, the text 'PATCH' is
>>>> replaced with whatever input is provided to the option. This allows easily
>>>> generating patches like '[PATCH 2.6.21-rc3]' or properly numbered series like
>>>> '[-mm3 PATCH N/M]'.
>>>>
>>>> 1/2 - Implementation and documentation
>>>> 2/2 - Test case

Gaah.

I applied it, pushed the results out and then found breakage.
How much I hate these random and non-essential "mean well to
enhance usability" patches X-<...

In the meantime, I think this should fix it.  Please test well.

-- >8 --
Fix git {log,show,...} --pretty=email

An earlier --subject-prefix forgot that format-patch is not the
only codepath that added the  "[PATCH]" prefix, breaking
everybody else in the log family.

Signed-off-by: Junio C Hamano <junkio@cox.net>
---
 builtin-log.c |    1 -
 revision.c    |    1 +
 2 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/builtin-log.c b/builtin-log.c
index 4a4890a..ffc269a 100644
--- a/builtin-log.c
+++ b/builtin-log.c
@@ -435,7 +435,6 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 	rev.ignore_merges = 1;
 	rev.diffopt.msg_sep = "";
 	rev.diffopt.recursive = 1;
-	rev.subject_prefix = "PATCH";
 
 	rev.extra_headers = extra_headers;
 
diff --git a/revision.c b/revision.c
index 486393c..37f1eab 100644
--- a/revision.c
+++ b/revision.c
@@ -567,6 +567,7 @@ void init_revisions(struct rev_info *revs, const char *prefix)
 	revs->min_age = -1;
 	revs->skip_count = -1;
 	revs->max_count = -1;
+	revs->subject_prefix = "PATCH";
 
 	revs->prune_fn = NULL;
 	revs->prune_data = NULL;
