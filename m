From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2] gitweb: use Git.pm, and use its parse_rev method for
 git_get_head_hash
Date: Sun, 01 Jun 2008 01:23:13 -0700
Message-ID: <7vzlq5bm32.fsf@gitster.siamese.dyndns.org>
References: <20080531130450.GI18781@machine.or.cz>
 <1212243564-30109-1-git-send-email-LeWiemann@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org
To: Lea Wiemann <lewiemann@gmail.com>
X-From: git-owner@vger.kernel.org Sun Jun 01 10:24:36 2008
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1K2ird-0007Ji-7J
	for gcvg-git-2@gmane.org; Sun, 01 Jun 2008 10:24:29 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751530AbYFAIXf (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Sun, 1 Jun 2008 04:23:35 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1751462AbYFAIXf
	(ORCPT <rfc822;git-outgoing>); Sun, 1 Jun 2008 04:23:35 -0400
Received: from a-sasl-fastnet.sasl.smtp.pobox.com ([207.106.133.19]:44241 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751401AbYFAIXe (ORCPT <rfc822;git@vger.kernel.org>);
	Sun, 1 Jun 2008 04:23:34 -0400
Received: from localhost.localdomain (localhost [127.0.0.1])
	by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with ESMTP id DB5C73D87;
	Sun,  1 Jun 2008 04:23:32 -0400 (EDT)
Received: from pobox.com (ip68-225-240-77.oc.oc.cox.net [68.225.240.77])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits)) (No client
 certificate requested) by a-sasl-fastnet.sasl.smtp.pobox.com (Postfix) with
 ESMTPSA id 036E23D86; Sun,  1 Jun 2008 04:23:27 -0400 (EDT)
User-Agent: Gnus/5.110006 (No Gnus v0.6) Emacs/21.4 (gnu/linux)
X-Pobox-Relay-ID: 05CC1E5C-2FB4-11DD-AF5D-F9737025C2AA-77302942!a-sasl-fastnet.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/83437>

Lea Wiemann <lewiemann@gmail.com> writes:

> This simplifies git_get_head_hash a lot; the method might eventually
> even go away.
>
> I haven't checked whether this causes an IO performance regression by
> instantiating a new Git repository instance, but in the end
> Git->repository will be as fast as possible and do no eager disk
> accesses.  No benchmarking yet at this stage.
>
> Signed-off-by: Lea Wiemann <LeWiemann@gmail.com>

With this on top of your parse_rev patch (I used v2 but I do not think v3
changes the situation in any way), you seem to have broken t9500.

gitweb.log left in the trash directory says that it cannot find Git.pm in
@INC.  I suspect that you are not using your own Git in the build tree in
your test, but an already installed one.

Please make sure that you are testing with Git.pm that you are shipping.
A good way to do so would be to add a deliberate error in perl/Git.pm to
cause loading of the module to fail, and make sure test barfs upon "use
Git".

Something like this is needed on top of your patch, I think.

---

 t/t9500-gitweb-standalone-no-errors.sh |    3 ++-
 1 files changed, 2 insertions(+), 1 deletions(-)

diff --git a/t/t9500-gitweb-standalone-no-errors.sh b/t/t9500-gitweb-standalone-no-errors.sh
index ae7082b..a62231f 100755
--- a/t/t9500-gitweb-standalone-no-errors.sh
+++ b/t/t9500-gitweb-standalone-no-errors.sh
@@ -47,8 +47,9 @@ gitweb_run () {
 	PATH_INFO=""$2""
 	export GATEWAY_INTERFACE HTTP_ACCEPT REQUEST_METHOD QUERY_STRING PATH_INFO
 
+	PERL5LIB=$(pwd)/../../perl/blib/lib
 	GITWEB_CONFIG=$(pwd)/gitweb_config.perl
-	export GITWEB_CONFIG
+	export GITWEB_CONFIG PERL5LIB
 
 	# some of git commands write to STDERR on error, but this is not
 	# written to web server logs, so we are not interested in that:
