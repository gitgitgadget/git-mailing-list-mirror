From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] t/gitweb-lib: Split HTTP response with non-GNU sed
Date: Mon, 23 Nov 2009 10:27:32 -0800
Message-ID: <7vocmtyu3v.fsf@alter.siamese.dyndns.org>
References: <1258997622-62403-1-git-send-email-brian@gernhardtsoftware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>, Jakub Narebski <jnareb@gmail.com>
To: Brian Gernhardt <brian@gernhardtsoftware.com>
X-From: git-owner@vger.kernel.org Mon Nov 23 19:28:01 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1NCddm-0005az-UI
	for gcvg-git-2@lo.gmane.org; Mon, 23 Nov 2009 19:27:59 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1754967AbZKWS1g (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 23 Nov 2009 13:27:36 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1754962AbZKWS1g
	(ORCPT <rfc822;git-outgoing>); Mon, 23 Nov 2009 13:27:36 -0500
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:43829 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754943AbZKWS1f (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Nov 2009 13:27:35 -0500
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 8D97AA1E2B;
	Mon, 23 Nov 2009 13:27:41 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=Gvo8cTzQ8PRY5cFxesaowOd2OHg=; b=qGEl1ouhmp+CPxXAKgB8uhr
	+GK4opTqtHPz9FemxnMus3nisfS4yWhibwdUAVAvJ5YWLW3v9uED41PTuR+Vnv5h
	97xDc9RSiKE8BirM0p/ALbpNqF6Qw3N4HfoEi88HnfaVvep/ti10r9b9mlvAMrXO
	k0hAZcCn4yJXiOz1EvbE=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=xCXow/2fywfIvmHDy7nBNmrhnfi7YtiTFhCLw6VqOaC/WYTzT
	s9XelUCDNANN1Uu4E/u1DS/O49SC5CedQQP59LmJZS1j9CXu3RojUhTA4ydefz70
	iSs9VzHBnaA+MyxqK3sNGWzJS+Tpcxja4+2Y7GWb/OqZCkd4YEAcdJypiM=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 5B861A1E28;
	Mon, 23 Nov 2009 13:27:38 -0500 (EST)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id 1A4A7A1E24; Mon, 23 Nov 2009
 13:27:33 -0500 (EST)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: E0D4F93A-D85D-11DE-94A9-EF34BBB5EC2E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/133521>

Brian Gernhardt <brian@gernhardtsoftware.com> writes:

> Recognizing \r in a regex is something GNU sed will do, but other sed
> implementation's won't.  (Found with BSD sed on OS X.) So use a
> literal carriage return instead.

I'd actually prefer not having to deal with this issue.  How about doing
something like this instead?

 t/gitweb-lib.sh |   14 ++++++++++++--
 1 files changed, 12 insertions(+), 2 deletions(-)

diff --git a/t/gitweb-lib.sh b/t/gitweb-lib.sh
index 32b841d..3121950 100644
--- a/t/gitweb-lib.sh
+++ b/t/gitweb-lib.sh
@@ -52,8 +52,18 @@ gitweb_run () {
 	rm -f gitweb.log &&
 	perl -- "$SCRIPT_NAME" \
 		>gitweb.output 2>gitweb.log &&
-	sed -e   '/^\r$/q' <gitweb.output >gitweb.headers &&
-	sed -e '1,/^\r$/d' <gitweb.output >gitweb.body    &&
+	perl -w -e '
+		open O, ">gitweb.headers";
+		while (<>) {
+			print O;
+			last if (/^\r$/ || /^$/);
+		}
+		open O, ">gitweb.body";
+		while (<>) {
+			print O;
+		}
+		close O;
+	' gitweb.output &&
 	if grep '^[[]' gitweb.log >/dev/null 2>&1; then false; else true; fi
 
 	# gitweb.log is left for debugging
