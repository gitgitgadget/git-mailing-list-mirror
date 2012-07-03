From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/3] gitweb: Get rid of unnecessary check of $signoff
Date: Tue, 03 Jul 2012 12:58:38 -0700
Message-ID: <7v7gukvcpd.fsf@alter.siamese.dyndns.org>
References: <1341295377-22083-1-git-send-email-namhyung@kernel.org>
 <1341295377-22083-2-git-send-email-namhyung@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org,
	Arnaldo Carvalho de Melo <acme@ghostprotocols.net>
To: Namhyung Kim <namhyung@kernel.org>
X-From: git-owner@vger.kernel.org Tue Jul 03 21:58:55 2012
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Sm9FI-0006eq-AI
	for gcvg-git-2@plane.gmane.org; Tue, 03 Jul 2012 21:58:48 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933395Ab2GCT6m (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 3 Jul 2012 15:58:42 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:57487 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754286Ab2GCT6l (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 3 Jul 2012 15:58:41 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DC4248FFA;
	Tue,  3 Jul 2012 15:58:40 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=qxJ0EOCK7jZDb4SN0SCHZguN9Ng=; b=qnHBwM
	+cNUOsTz3spebK3JPyo4gqSqRd+KUHcSwDBR8+SLpfcCeqngNkVHKm5rZH5T2hW9
	E3VJX+CGvNWfVQfXGVNjvNbUeaV1jugUlokKzQJwQrcGyfKLYmaQTcE8nyVRYBGU
	X3/LpbqfmbeD8bXqynPXaZXSAI1uRqo9KW67g=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=oZWjjZMeV2RtqVQwAlVmHYKKSuYoCoue
	lZMXETUpy4r3SCdC2ehY0D1cv8TMTJ2Z/3A4yJQjEDkxaq4qINBaU49JDWTWj37s
	eI5xusf055RCpW2w7Oqp7/4oGwwi1oH5QWIWqahtrxM2PCgHfeu6qONFmRbw5gxH
	Ro0b+Hox+hk=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id D35288FF9;
	Tue,  3 Jul 2012 15:58:40 -0400 (EDT)
Received: from pobox.com (unknown [98.234.214.94]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 64BE88FF8; Tue,  3 Jul 2012
 15:58:40 -0400 (EDT)
In-Reply-To: <1341295377-22083-2-git-send-email-namhyung@kernel.org>
 (Namhyung Kim's message of "Tue, 3 Jul 2012 15:02:55 +0900")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: 7C29E104-C549-11E1-A358-FC762E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/200939>

Namhyung Kim <namhyung@kernel.org> writes:

> If $signoff set to 1, the $line would be handled in
> the if statement for the both cases. So the outer of
> the conditional always sees the $signoff always set
> to 0 and no need to check it. Thus we can finally get
> rid of it.

While this may not change the behaviour of the code, I think that
only shows the original is broken.  You even have the hint left in
the context of your patch:

>  		# print only one empty line
>  		# do not print empty line after signoff
>  		if ($line eq "") {
> -			next if ($empty || $signoff);
> +			next if ($empty);

Given this input:

	If $signoff is set to 1, ...
        ...
        rid of it.

	Signed-off-by: N K

        Signed-off-by: J C H

isn't the code trying (and failing) to remove the empty line between
the two S-o-b lines?

So something like this on top?  I renamed "$empty" which is unclear
what it means ("We just saw an empty line? What does the variable
want us to do?") to "$skip_blank_line" which more clearly instructs
us what to do.  If we see a blank line when it is set, we skip it.

 gitweb/gitweb.perl | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/gitweb/gitweb.perl b/gitweb/gitweb.perl
index 7585e08..202286b 100755
--- a/gitweb/gitweb.perl
+++ b/gitweb/gitweb.perl
@@ -4484,12 +4484,12 @@ sub git_print_log {
 	}
 
 	# print log
-	my $empty = 0;
+	my $skip_blank_line = 0;
 	foreach my $line (@$log) {
 		if ($line =~ m/^ *(signed[ \-]off[ \-]by[ :]|acked[ \-]by[ :]|cc[ :])/i) {
-			$empty = 0;
 			if (! $opts{'-remove_signoff'}) {
 				print "<span class=\"signoff\">" . esc_html($line) . "</span><br/>\n";
+				$skip_blank_line = 1;
 			}
 			next;
 		}
@@ -4497,10 +4497,10 @@ sub git_print_log {
 		# print only one empty line
 		# do not print empty line after signoff
 		if ($line eq "") {
-			next if ($empty);
-			$empty = 1;
+			next if ($skip_blank_line);
+			$skip_blank_line = 1;
 		} else {
-			$empty = 0;
+			$skip_blank_line = 0;
 		}
 
 		print format_log_line_html($line) . "<br/>\n";
