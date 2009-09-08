From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] git-rebase-interactive: avoid breaking when
 GREP_OPTIONS="-H"
Date: Tue, 08 Sep 2009 00:02:51 -0700
Message-ID: <7vpra1gbqc.fsf@alter.siamese.dyndns.org>
References: <1252328160-4359-1-git-send-email-carenas@sajinet.com.pe>
 <7v7hwar1fp.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe>,
	git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Sep 08 09:03:16 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1MkujS-0002ma-OA
	for gcvg-git-2@lo.gmane.org; Tue, 08 Sep 2009 09:03:15 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753751AbZIHHDB (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 8 Sep 2009 03:03:01 -0400
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1753746AbZIHHDA
	(ORCPT <rfc822;git-outgoing>); Tue, 8 Sep 2009 03:03:00 -0400
Received: from a-pb-sasl-sd.pobox.com ([64.74.157.62]:33778 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753606AbZIHHDA (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 8 Sep 2009 03:03:00 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 7FD0148326;
	Tue,  8 Sep 2009 03:03:02 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; s=
	sasl; bh=5dSBuCmDHb4KF6QkFIKuS5OTXHM=; b=CsQtQ81kqruI5by5CSokunX
	e8YUKeF68zYB7pA0aaLMs6no2yXXpJ3HKotc2pOlwU+kF9hseQWgn0Knc45wsFjo
	Jy+gpQE3xWn894DIv0ccSdTmVxzIgMwU3WlAr1GrCH0KbH2ZNDLoT4+Spj9m1Vgn
	N4xp2QpQeL7sXhsrNiPI=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=to:cc:subject
	:references:from:date:message-id:mime-version:content-type; q=
	dns; s=sasl; b=dDN72yg5S22lIpVmdiHbRQepzq8kPmaui/1Yfr7ErxmQDZrqP
	KQKIflvrsOnJSdztbKRZ2cY2UhOqXsyGNAYGbvCstxJ/+yZKA/41HLdY3dbVI/6a
	jkl+2hTHk6BkxyvkL+LJLTU3gHbwnp2DtqsN13JerOy2mqWqlwioZf3iBs=
Received: from a-pb-sasl-sd.pobox.com (unknown [127.0.0.1])
	by a-pb-sasl-sd.pobox.com (Postfix) with ESMTP id 62B4448325;
	Tue,  8 Sep 2009 03:03:00 -0400 (EDT)
Received: from pobox.com (unknown [68.225.240.211]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 a-pb-sasl-sd.pobox.com (Postfix) with ESMTPSA id C262E48323; Tue,  8 Sep 2009
 03:02:52 -0400 (EDT)
User-Agent: Gnus/5.11 (Gnus v5.11) Emacs/22.2 (gnu/linux)
X-Pobox-Relay-ID: A50EF300-9C45-11DE-B5C5-8B19076EA04E-77302942!a-pb-sasl-sd.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/127980>

Junio C Hamano <gitster@pobox.com> writes:

> Carlo Marcelo Arenas Belon <carenas@sajinet.com.pe> writes:
>
>> if GREP_OPTIONS is set and includes -H, using `grep -c` will fail
>> to generate a numeric count and result in the following error :
>>
>>   /usr/libexec/git-core/git-rebase--interactive: line 110: (standard
>>   input):1+(standard input):0: missing `)' (error token is
>>   "input):1+(standard input):0")
>>
>> instead of grep counting use `wc -l` to return the line count.
>
> Thanks.
>
> How does your patch help when the user has GREP_OPTIONS=-C3 in the
> environment?
>
> I think a saner workaround for this user environment bug (or GNU grep
> misfeature) is to unset GREP_OPTIONS at the beginning of the script, or
> even in git-sh-setup.

Or even this.

 git.c |   13 +++++++++++++
 1 files changed, 13 insertions(+), 0 deletions(-)

diff --git a/git.c b/git.c
index 0b22595..3548154 100644
--- a/git.c
+++ b/git.c
@@ -450,11 +450,24 @@ static int run_argv(int *argcp, const char ***argv)
 	return done_alias;
 }
 
+static void sanitize_env(void) {
+	static const char *vars[] = {
+		"GREP_OPTIONS",
+		"GREP_COLOR",
+		"GREP_COLORS",
+		NULL,
+	};
+	const char **p;
+
+	for (p = vars; *p; p++)
+		unsetenv(*p);
+}
 
 int main(int argc, const char **argv)
 {
 	const char *cmd;
 
+	sanitize_env();
 	cmd = git_extract_argv0_path(argv[0]);
 	if (!cmd)
 		cmd = "git-help";
