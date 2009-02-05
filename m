From: Junio C Hamano <gitster@pobox.com>
Subject: Re: 026fa0d5ad Breaks installs with absolue $(gitexecdir) and
 $(template_dir) variables using older GNU makes
Date: Wed, 04 Feb 2009 23:44:31 -0800
Message-ID: <7vzlh1gwf4.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
 <7v63jpibe8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 05 08:46:10 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUyw5-0004kD-E8
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 08:46:09 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753506AbZBEHol (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 02:44:41 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753136AbZBEHol
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 02:44:41 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:50651 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753014AbZBEHok (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 02:44:40 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 551AC96BB9;
	Thu,  5 Feb 2009 02:44:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id CE56896BB7; Thu,
  5 Feb 2009 02:44:33 -0500 (EST)
In-Reply-To: <7v63jpibe8.fsf@gitster.siamese.dyndns.org> (Junio C. Hamano's
 message of "Wed, 04 Feb 2009 23:35:43 -0800")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: D7261774-F358-11DD-9258-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108515>

Junio C Hamano <gitster@pobox.com> writes:

> A Large Angry SCM <gitzilla@gmail.com> writes:
>
>> The new test is also wrong; (for *nix systems) in that it really wants
>> to test if the first character is a '/' but GNU make doesn't have a
>> way to do that directly.
>
> Hmph.  Isn't it just the matter of doing something silly like this?
>
> ifeq ($(filter /%,$(template_dir)),)
> 	... it does not start with a slash
> else
> 	... it does
> endif

That is, something like this.

The patch also protects the $(filter) check from sick users that use

	template_dir = My Files /the-leading-dir-ends-with-a-space

by using $(firstword)

No, I didn't test it.

 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git c/Makefile w/Makefile
index a82f173..605b147 100644
--- c/Makefile
+++ w/Makefile
@@ -1434,14 +1434,14 @@ remove-dashes:
 
 ### Installation rules
 
-ifeq ($(abspath $(template_dir)),$(template_dir))
+ifneq ($(filter /%,$(firstword $(template_dir))),)
 template_instdir = $(template_dir)
 else
 template_instdir = $(prefix)/$(template_dir)
 endif
 export template_instdir
 
-ifeq ($(abspath $(gitexecdir)),$(gitexecdir))
+ifneq ($(filter /%,$(firstword $(gitexecdir))),)
 gitexec_instdir = $(gitexecdir)
 else
 gitexec_instdir = $(prefix)/$(gitexecdir)
