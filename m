From: Junio C Hamano <gitster@pobox.com>
Subject: [PATCH] Makefile: fix misdetection of relative pathnames
Date: Thu, 05 Feb 2009 00:18:09 -0800
Message-ID: <7vhc39guv2.fsf@gitster.siamese.dyndns.org>
References: <4985E8E1.90303@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Steffen Prohaska <prohaska@zib.de>, Pascal Obry <pascal@obry.net>,
	git@vger.kernel.org
To: gitzilla@gmail.com
X-From: git-owner@vger.kernel.org Thu Feb 05 09:19:50 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUzSc-0004z2-Cz
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 09:19:46 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1758070AbZBEISV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 5 Feb 2009 03:18:21 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1758048AbZBEISU
	(ORCPT <rfc822;git-outgoing>); Thu, 5 Feb 2009 03:18:20 -0500
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:32820 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758029AbZBEIST (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 5 Feb 2009 03:18:19 -0500
Received: from localhost.localdomain (unknown [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 69AEC96E85;
	Thu,  5 Feb 2009 03:18:17 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES256-SHA (256/256 bits)) (No client certificate requested) by
 a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTPSA id 9E1DF96E83; Thu,
  5 Feb 2009 03:18:11 -0500 (EST)
In-Reply-To: <4985E8E1.90303@gmail.com> (A. Large Angry's message of "Sun, 01
 Feb 2009 13:24:33 -0500")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 8A9DDAAE-F35D-11DD-B59B-8B21C92D7133-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108532>


A Large Angry SCM <gitzilla@gmail.com> writes:

> In 026fa0d5ad9538ca76838070861531c037d7b9ba, "Move computation of
> absolute paths from Makefile to runtime (in preparation for
> RUNTIME_PREFIX)", the following change was made to the Makefile. The
> problem is that $(abspath names...) is a relatively recent addition to
> GNU make and when used in an older GNU make, the test always fails
> resulting incorrect installation dirs for the templates and commands.
>
> The new test is also wrong; (for *nix systems) in that it really wants
> to test if the first character is a '/'

Ok, here is the final one from me that I am considering to commit, but it
would be nice to hear success/failure feedback from people who had trouble
with Steffen's changes.  I'd also like to hear from people who have been
happy with Steffen's changes that this does not break things for them.

-- >8 --

The installation rules wanted to differentiate between a template_dir that
is given as an absolute path (e.g. /usr/share/git-core/templates) and a
relative one (e.g. share/git-core/templates) but it was done by checking
if $(abspath $(template_dir)) and $(template_dir) yield the same string.

This was wrong in number of ways.

 * The user can give template_dir with a trailing slash from the command
   line to invoke make, or in the included config.mak.  A directory path
   ought to mean the same thing with or without such a trailing slash but
   use of $(abspath) means with an absolute path with a trailing slash
   fails the test.

 * The compilation could be done inside /usr directory with a relative
   pathname share/git-core/templates and it will be mistaken as an
   absolute path.

 * Versions of GNU make older than 3.81 do not have $(abspath) to begin
   with.

This changes the detection logic to see if the given path begins with a
slash.

Signed-off-by: Junio C Hamano <gitster@pobox.com>
---
 Makefile |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Makefile b/Makefile
index a82f173..605b147 100644
--- a/Makefile
+++ b/Makefile
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
-- 
1.6.1.2.382.gda69a
