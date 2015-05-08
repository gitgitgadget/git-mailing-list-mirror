From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 2/3] sha1_name: get_sha1_with_context learns to follow symlinks
Date: Fri, 08 May 2015 13:25:45 -0700
Message-ID: <xmqq6182ke9i.fsf@gitster.dls.corp.google.com>
References: <1431108819-6831-1-git-send-email-dturner@twopensource.com>
	<1431108819-6831-2-git-send-email-dturner@twopensource.com>
	<CAPig+cRzXQp_afDrOdKrUQ-=DD1P_UcDzs8aSZnTfesd7R20wQ@mail.gmail.com>
	<CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: David Turner <dturner@twopensource.com>,
	Git List <git@vger.kernel.org>,
	David Turner <dturner@twitter.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri May 08 22:27:06 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YqoqG-00082i-K4
	for gcvg-git-2@plane.gmane.org; Fri, 08 May 2015 22:25:52 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932496AbbEHUZs (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 8 May 2015 16:25:48 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:52666 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932189AbbEHUZr (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 8 May 2015 16:25:47 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 80A1F4EE1A;
	Fri,  8 May 2015 16:25:47 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=6gfUKsYXBS4UM01bVyAG8dn7GbM=; b=aebOQw
	t8nMh2ayvNnx5M0cnaSqPCNW6MxxSEAlHwPbjKSyonIbZkn6o2QYMM1JY+5x1CbP
	4C2SeznrpDw87hY9aFufZK4CATvaLJ8Zc09F+kfuJrTAlekxXJgMWmLEU4sU5ySs
	euYBK84ULgo2XxDF4PzZsXYtS11x6MCnogB30=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=O36quqpcq40aA9BR6tywiwdQerCj68G0
	zk6oJca3xEPJ9vGXQDh7TXqpraQW0j4nzSmK61VI57AXzdY+NRFXvmtFPPRVtVai
	UbFxqsmoiyyNY2VjV7vqGrKLcRgRWmB415IsRVKpNaukXT5WsEEnnw00wU/UWuO+
	JtKqnRMW7ZM=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 6E8584EE19;
	Fri,  8 May 2015 16:25:47 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A0B8D4EE10;
	Fri,  8 May 2015 16:25:46 -0400 (EDT)
In-Reply-To: <CAPc5daXmJSfdB_eyQ5ppVp2NhYGZvPChGAyn4p2hEde=4x9EEQ@mail.gmail.com>
	(Junio C. Hamano's message of "Fri, 8 May 2015 13:17:58 -0700")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 68AE12C6-F5C0-11E4-B47F-83E09F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/268660>

Perhaps something like the attached patch is a good idea (I used
"BUG:" for now), I wonder?

 Documentation/CodingGuidelines | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/Documentation/CodingGuidelines b/Documentation/CodingGuidelines
index c6e536f..020370e 100644
--- a/Documentation/CodingGuidelines
+++ b/Documentation/CodingGuidelines
@@ -232,7 +232,12 @@ For C programs:
 	   to be translated, that follows immediately after it */
 	_("Here is a translatable string explained by the above.");
 
+ - Speaking of translations, do not mark the message to die() that
+   should never trigger unless there is an programming error.  E.g.
+
+	die("BUG: frotz() called with NULL pointer to xyzzy parameter");
+
- - Double negation is often harder to understand than no negation
+ - Double negation is not easier to understand than no negation
    at all.
 
  - There are two schools of thought when it comes to comparison,
