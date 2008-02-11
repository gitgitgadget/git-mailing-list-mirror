From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] apply: fix segfault
Date: Mon, 11 Feb 2008 15:06:26 -0800
Message-ID: <7vprv36qkt.fsf@gitster.siamese.dyndns.org>
References: <alpine.LSU.1.00.0802112227400.3870@racer.site>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, gitster@pobox.com
To: Johannes Schindelin <Johannes.Schindelin@gmx.de>
X-From: git-owner@vger.kernel.org Tue Feb 12 00:07:21 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1JOhk2-0004zU-H5
	for gcvg-git-2@gmane.org; Tue, 12 Feb 2008 00:07:14 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753326AbYBKXGk (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2008 18:06:40 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753592AbYBKXGk
	(ORCPT <rfc822;git-outgoing>); Mon, 11 Feb 2008 18:06:40 -0500
Received: from a-sasl-quonix.sasl.smtp.pobox.com ([208.72.237.25]:38448 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751744AbYBKXGj (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2008 18:06:39 -0500
Received: from a-sasl-quonix (localhost [127.0.0.1])
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id CC05E298D;
	Mon, 11 Feb 2008 18:06:37 -0500 (EST)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by a-sasl-quonix.pobox.com (Postfix) with ESMTP id 2BA61298C;
	Mon, 11 Feb 2008 18:06:33 -0500 (EST)
In-Reply-To: <alpine.LSU.1.00.0802112227400.3870@racer.site> (Johannes
	Schindelin's message of "Mon, 11 Feb 2008 22:28:25 +0000 (GMT)")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/73602>

Johannes Schindelin <Johannes.Schindelin@gmx.de> writes:

> When the patch reports a line number that is larger than the number of
> lines in the current version of the file, git-apply used to segfault.

I have to wonder if the correct fix should be like this
instead.  Under that condition, I think computation of the
initial "try" value already oversteps the line[] array for the
original image.

diff --git a/builtin-apply.c b/builtin-apply.c
index 2b8ba81..177f541 100644
--- a/builtin-apply.c
+++ b/builtin-apply.c
@@ -1809,6 +1809,9 @@ static int find_pos(struct image *img,
 	else if (match_end)
 		line = img->nr - preimage->nr;
 
+	if (line > preimage->nr)
+		line = preimage->nr;
+
 	try = 0;
 	for (i = 0; i < line; i++)
 		try += img->line[i].len;
