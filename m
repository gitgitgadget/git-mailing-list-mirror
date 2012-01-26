From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 4/4] config: allow including config from repository blobs
Date: Thu, 26 Jan 2012 13:14:46 -0800
Message-ID: <7vbopq2mk9.fsf@alter.siamese.dyndns.org>
References: <20120126073547.GA28689@sigill.intra.peff.net>
 <20120126074208.GD30474@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Jan 26 22:14:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1RqWel-0005nE-Fq
	for gcvg-git-2@lo.gmane.org; Thu, 26 Jan 2012 22:14:55 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752699Ab2AZVOv (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 26 Jan 2012 16:14:51 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:42131 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751544Ab2AZVOu (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 26 Jan 2012 16:14:50 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 243F76818;
	Thu, 26 Jan 2012 16:14:49 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=goujCJOE8BH1PuJ6FQ2rH2cdS0k=; b=CqDOrh
	pJSb8kryJoWrhZe+sABSdUi1ovTYQ7wnVqr1DZ6CHXPx+NpBGLMgTsBUmBPvsPOl
	6Ylb1+ciKbMkLos1lEe/vMEGb6iYrVm2tLiQMw0HSgX3ZE7rINyZEG3+gRjKBU2j
	TE8gckhl98rpQpktxtliQEiox+gYsfxsnD4y8=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=B/83SGCTS64OhmcqXbkIzCbq77huFYkW
	F6yF67sYnDNDd9A4TulkC+3B+igOKgWm/YRoPAGiqHVNQ6xgZtADW7ExJWagze7L
	VeHqBXq+Iu/Oup3TQgzzjcfTNjI4AnwYq8vdrlzT51Bqo0njw+N2Swd373/MUCGA
	XQb4Rmj55Xs=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 1B2866817;
	Thu, 26 Jan 2012 16:14:49 -0500 (EST)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 71BFB6816; Thu, 26 Jan 2012
 16:14:48 -0500 (EST)
In-Reply-To: <20120126074208.GD30474@sigill.intra.peff.net> (Jeff King's
 message of "Thu, 26 Jan 2012 02:42:08 -0500")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: C74142E0-4862-11E1-9861-9DB42E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/189165>

Jeff King <peff@peff.net> writes:

> +You can also include configuration from a blob stored in your repository
> +by setting the special `include.ref` variable to the name of an object
> +containing your configuration data (in the same format as a regular
> +config file).

Hmm, the concept is surely *fun*, but is this really worth it?

With this, projects could include README that says something like this:

	When working with our project, we would suggest using some tweaks
	to the configuration file. For your convenience, a copy of it
	already exists in the clone of your repository, and all you have
	to do is to run this in your repository:

	$ git config include.ref 4774acaf6657efed

	We may update the set of recommended tweaks from time to time, so
        watch this README file for such updates, and re-run the above command
	with the updated blob object name as needed.

	Note: if you are paranoid and suspect that the project might
	give you trojan horse, you could inspect the recommended
	tweaks first before including them, like this:

	$ git cat-file -p 4774acaf6657efed

The blob will be included in the repository and the most natural way for
such a project to arrange things is to keep it together with the source
tree, perhaps in a separate hierarchy, say "dev_tools/std_gitconfig" or
something.  Without the update in patches 3 and 4, the project should be
able to update the above for its participants with minimum fuss, e.g.

diff --git a/README b/README
index af31555..203d255 100644
--- a/README
+++ b/README
@@ -3,14 +3,15 @@
 	already exists in the clone of your repository, and all you have
 	to do is to run this in your repository:
 
-	$ git config include.ref 4774acaf6657efed
+	$ cp dev_tools/std_gitconfig .git/std_gitconfig
+	$ git config include.path std_gitconfig
 
 	We may update the set of recommended tweaks from time to time, so
-        watch this README file for such updates, and re-run the above command
-	with the updated blob object name as needed.
+        watch "git log -p dev_tools/std_gitconfig" for such updates and
+	update your .git/std_gitconfig as needed.
 
 	Note: if you are paranoid and suspect that the project might
 	give you trojan horse, you could inspect the recommended
 	tweaks first before including them, like this:
 
-	$ git cat-file -p 4774acaf6657efed
+	$ less dev_tools/std_gitconfig
