From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH] dir: allow a BOM at the beginning of exclude files
Date: Thu, 16 Apr 2015 10:16:49 -0700
Message-ID: <xmqqoamohu2m.fsf@gitster.dls.corp.google.com>
References: <1429193112-41184-1-git-send-email-cmn@elego.de>
	<xmqqsic0hyk4.fsf@gitster.dls.corp.google.com>
	<20150416155558.GA10390@peff.net>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Carlos =?utf-8?Q?Mart=C3=ADn?= Nieto <cmn@elego.de>,
	git@vger.kernel.org
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Thu Apr 16 19:16:59 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1YinPO-0002lO-S8
	for gcvg-git-2@plane.gmane.org; Thu, 16 Apr 2015 19:16:59 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753780AbbDPRQz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Thu, 16 Apr 2015 13:16:55 -0400
Received: from pb-smtp1.int.icgroup.com ([208.72.237.35]:51306 "EHLO
	sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752231AbbDPRQx (ORCPT <rfc822;git@vger.kernel.org>);
	Thu, 16 Apr 2015 13:16:53 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 42903490DC;
	Thu, 16 Apr 2015 13:16:52 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=E3jN1I1gf8kSdGky0K8CZ3pgjac=; b=xcxMMg
	GDyK8++O4oeLJrUsglnk9OtuAwJH8S+9P1OSKr/NnmhvvMMTDyD5uJKzKtKjlPzM
	VbL0VJqDIB/IjHKA1uBf6LpF/GWaOIDusIPHW3veRDZ2uAee+6Mi3EZdCQsNixDN
	wQM7IsFX+XXIfvjwBiuvNJPc0bub7EpAYjhC0=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=tryrvdAi5sW2yk9hhDGtEPpF41nMrgOq
	lCmX+Vd8yIA36D45/kxLnvB76/N9nWI8AYG0nU9kUDv2hdLDerPcMipSC9ZA5tPO
	knBKCkTC845CxeKonrUuApT3CYYwEs9Xwor8n1SIn49u3lnwD00STmQSjICH42BM
	lCzQeVZMOaw=
Received: from pb-smtp1.int.icgroup.com (unknown [127.0.0.1])
	by pb-smtp1.pobox.com (Postfix) with ESMTP id 3BC86490DA;
	Thu, 16 Apr 2015 13:16:52 -0400 (EDT)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by pb-smtp1.pobox.com (Postfix) with ESMTPSA id A269D490D7;
	Thu, 16 Apr 2015 13:16:50 -0400 (EDT)
In-Reply-To: <20150416155558.GA10390@peff.net> (Jeff King's message of "Thu,
	16 Apr 2015 11:55:58 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
X-Pobox-Relay-ID: 5ED01CCE-E45C-11E4-919F-11859F42C9D4-77302942!pb-smtp1.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/267311>

Jeff King <peff@peff.net> writes:

> On Thu, Apr 16, 2015 at 08:39:55AM -0700, Junio C Hamano wrote:
>
>> >  test_expect_success 'status untracked directory with --ignored' '
>> >  	echo "ignored" >.gitignore &&
>> > +	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
>> > +	mv .gitignore.new .gitignore &&
>> 
>> Is this "write literal in \xHEX on the replacement side of sed
>> substitution" potable?  In any case, replacing the above three with
>> something like:
>> 
>> 	printf "<bom>ignored\n" >.gitignore
>> 
>> may be more sensible, no?
>
> I'm not sure about sed, but I agree it is suspect. And note that printf
> with hex codes is not portable, either You have to use octal:
>
>   printf '\357\273\277ignored\n' >.gitignore
>
> Also, as a nit, I'd much rather see this in its own test rather than
> crammed into another test_expect_success. It's much easier to diagnose
> failures if the test description mentions the goal, and it is not tied
> up with testing other parts that might fail.

Yeah, I totally agree.

Carlos, something like this squashed in, perhaps?

 t/t7061-wtstatus-ignore.sh | 11 +++++++++--
 1 file changed, 9 insertions(+), 2 deletions(-)

diff --git a/t/t7061-wtstatus-ignore.sh b/t/t7061-wtstatus-ignore.sh
index 0a06fbf..cdc0747 100755
--- a/t/t7061-wtstatus-ignore.sh
+++ b/t/t7061-wtstatus-ignore.sh
@@ -13,8 +13,6 @@ EOF
 
 test_expect_success 'status untracked directory with --ignored' '
 	echo "ignored" >.gitignore &&
-	sed -e "s/^/\xef\xbb\xbf/" .gitignore >.gitignore.new &&
-	mv .gitignore.new .gitignore &&
 	mkdir untracked &&
 	: >untracked/ignored &&
 	: >untracked/uncommitted &&
@@ -22,6 +20,15 @@ test_expect_success 'status untracked directory with --ignored' '
 	test_cmp expected actual
 '
 
+test_expect_success 'same with gitignore starting with BOM' '
+	printf "\357\273\277ignored\n" >.gitignore &&
+	mkdir -p untracked &&
+	: >untracked/ignored &&
+	: >untracked/uncommitted &&
+	git status --porcelain --ignored >actual &&
+	test_cmp expected actual
+'
+
 cat >expected <<\EOF
 ?? .gitignore
 ?? actual
