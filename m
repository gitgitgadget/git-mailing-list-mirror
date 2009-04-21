From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] grep: don't support "grep.color"-like config options
Date: Mon, 20 Apr 2009 22:55:34 -0700
Message-ID: <7vy6tua6uh.fsf@gitster.siamese.dyndns.org>
References: <1240268295-10296-1-git-send-email-markus.heidelberg@web.de>
 <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Markus Heidelberg <markus.heidelberg@web.de>, git@vger.kernel.org
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Apr 21 07:57:19 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Lw8ys-0003GN-1f
	for gcvg-git-2@gmane.org; Tue, 21 Apr 2009 07:57:18 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752789AbZDUFzq (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 21 Apr 2009 01:55:46 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752484AbZDUFzp
	(ORCPT <rfc822;git-outgoing>); Tue, 21 Apr 2009 01:55:45 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:58488 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752574AbZDUFzm (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 21 Apr 2009 01:55:42 -0400
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 87290AC996;
	Tue, 21 Apr 2009 01:55:40 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 09DBCAC993; Tue,
 21 Apr 2009 01:55:35 -0400 (EDT)
In-Reply-To: <alpine.DEB.1.00.0904210145260.10279@pacific.mpi-cbg.de>
 (Johannes Schindelin's message of "Tue, 21 Apr 2009 01:45:41 +0200 (CEST)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 0B4D0C7C-2E39-11DE-B3A5-C121C5FC92D5-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/117094>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> On Tue, 21 Apr 2009, Markus Heidelberg wrote:
>
>> color.grep and color.grep.* is the official and documented way to 
>> highlight grep matches. Comparable options like diff.color.* and 
>> status.color.* exist for backward compatibility reasons only and are not 
>> documented any more.
>
> But is it really so bad that we have to possibly break existing setups?
>
> The cost of keeping them is really small IMHO.

While I do not think these lines themselves will cost us a lot of
maintenance effort, people tend to mimick existing code, and these
patterns can proliferate if unchecked, and *that* would add to
maintenance.  As the feature has aleady been in master for 6 weeks or so,
Markus's patch is now-or-never, and I'd rather say we take it before the
1.6.3 final.

An alternative would be to:

 (1) Keep them undocumented;

 (2) add code comments about their deprecated status to discourage people
     from copying the style; and

 (3) possibly deprecate it in some future.

but I do not know if the last step is worth it.

In any case, I think perhaps we should squash this in.

 diff.c      |    5 +++++
 wt-status.c |    5 +++++
 2 files changed, 10 insertions(+), 0 deletions(-)

diff --git a/diff.c b/diff.c
index 3ac7168..f2432de 100644
--- a/diff.c
+++ b/diff.c
@@ -79,6 +79,11 @@ static int git_config_rename(const char *var, const char *value)
  */
 int git_diff_ui_config(const char *var, const char *value, void *cb)
 {
+	/*
+	 * Note: cmdname.color style of configuration variables are
+	 * deprecated; do not copy this pattern but accept only
+	 * color.cmdname in new code.
+	 */
 	if (!strcmp(var, "diff.color") || !strcmp(var, "color.diff")) {
 		diff_use_color_default = git_config_colorbool(var, value, -1);
 		return 0;
diff --git a/wt-status.c b/wt-status.c
index 929b00f..9726e0b 100644
--- a/wt-status.c
+++ b/wt-status.c
@@ -381,6 +381,11 @@ int git_status_config(const char *k, const char *v, void *cb)
 			wt_status_submodule_summary = -1;
 		return 0;
 	}
+	/*
+	 * Note: cmdname.color style of configuration variables are
+	 * deprecated; do not copy this pattern but accept only
+	 * color.cmdname in new code.
+	 */
 	if (!strcmp(k, "status.color") || !strcmp(k, "color.status")) {
 		wt_status_use_color = git_config_colorbool(k, v, -1);
 		return 0;
