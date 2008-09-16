From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] Documentation: replace [^~] with escapes everywhere
Date: Tue, 16 Sep 2008 09:48:10 -0700
Message-ID: <7vhc8g6nqt.fsf@gitster.siamese.dyndns.org>
References: <1221470398-8698-1-git-send-email-trast@student.ethz.ch>
 <1221470398-8698-3-git-send-email-trast@student.ethz.ch>
 <32541b130809151656n4f39018fu2045eb6280d6da00@mail.gmail.com>
 <200809160205.23371.trast@student.ethz.ch>
 <32541b130809151710j59963af9id84b3c1553ec738d@mail.gmail.com>
 <7vy71s7b26.fsf@gitster.siamese.dyndns.org>
 <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: "Avery Pennarun" <apenwarr@gmail.com>,
	"Thomas Rast" <trast@student.ethz.ch>
To: git@vger.kernel.org
X-From: git-owner@vger.kernel.org Tue Sep 16 18:49:43 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1Kfdk6-0008BM-5u
	for gcvg-git-2@gmane.org; Tue, 16 Sep 2008 18:49:34 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756339AbYIPQsZ (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 16 Sep 2008 12:48:25 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1755625AbYIPQsZ
	(ORCPT <rfc822;git-outgoing>); Tue, 16 Sep 2008 12:48:25 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:60606 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755603AbYIPQsY (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 16 Sep 2008 12:48:24 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id 2DC6E60472;
	Tue, 16 Sep 2008 12:48:21 -0400 (EDT)
Received: from pobox.com (ip68-225-240-211.oc.oc.cox.net [68.225.240.211])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 6EB866046B; Tue, 16 Sep 2008 12:48:15 -0400 (EDT)
In-Reply-To: <32541b130809160858k3c019f6pdc4831c831e22b55@mail.gmail.com>
 (Avery Pennarun's message of "Tue, 16 Sep 2008 11:58:58 -0400")
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 45396626-840F-11DD-9071-D0CFFE4BC1C1-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/96016>

"Avery Pennarun" <apenwarr@gmail.com> writes:

> Hmm, browsing around through a newer asciidoc package from Ubuntu, it
> appears that in asciidoc 8, those lines are in an
> "ifdef::asciidoc7compatible[]" section.  But the quoting mechanism in
> 8 appears to be improved.
>
> Perhaps a section like this (guessing from the new
> /etc/asciidoc/asciidoc.conf) will do the job instead (or in addition,
> if we're trying to support both versions):
>
> [quotes]
> ^=
> ~=

Ok, how about this patch?  I do not have an access to the box with
AsciiDoc 8 handy right now, so I cannot test this myself, but there must
be somebody on the list who can give a quick test to this.

The procedure would be:

	$ cd Documentation
        $ rm -fr ./+old ./+new && mkdir ./+old ./+new
        $ make git-{bundle,show-ref}.{html,1}
        $ mv git-{bundle,show-ref}.{html,1} ./+old
        $ git apply < this-patch
        $ make git-{bundle,show-ref}.{html,1}
        $ mv git-{bundle,show-ref}.{html,1} ./+new
        $ git diff --no-index --color-words ./+old ./+new

Then eyeball the output, ignoring the timestamps and see if <sup>/<sub>
disappears and there is no other change.  Other documentation pages should
also be verified, but these two are I know of with the issue.

diff --git i/Documentation/asciidoc.conf w/Documentation/asciidoc.conf
index 40d43b7..36b6509 100644
--- i/Documentation/asciidoc.conf
+++ w/Documentation/asciidoc.conf
@@ -15,6 +15,21 @@ startsb=&#91;
 endsb=&#93;
 tilde=&#126;
 
+[replacements]
+# Disable superscripts.
+\^(.+?)\^=^\1^
+# Disable subscripts.
+~(.+?)~=~\1~
+
+# We define asciidoc7compatible macro when running with AsciiDoc 8;
+# this ifdef protects the "empty" quotes rule that AsciiDoc 7 does
+# not know how to handle.
+ifdef::asciidoc7compatible[]
+[quotes]
+^=
+~=
+endif::asciidoc7compatible[]
+
 ifdef::backend-docbook[]
 [linkgit-inlinemacro]
 {0%{target}}
