From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 3/3] for-each-ref: introduce %(color:...) for color
Date: Wed, 13 Nov 2013 12:19:25 -0800
Message-ID: <xmqq38n0dpgy.fsf@gitster.dls.corp.google.com>
References: <1384335406-16332-1-git-send-email-artagnon@gmail.com>
	<1384335406-16332-4-git-send-email-artagnon@gmail.com>
	<xmqqbo1odqb4.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: Git List <git@vger.kernel.org>
To: Ramkumar Ramachandra <artagnon@gmail.com>
X-From: git-owner@vger.kernel.org Wed Nov 13 21:19:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VgguU-0005SX-20
	for gcvg-git-2@plane.gmane.org; Wed, 13 Nov 2013 21:19:34 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1750843Ab3KMUTa (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 13 Nov 2013 15:19:30 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:39563 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750797Ab3KMUT3 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 13 Nov 2013 15:19:29 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 09927512DC;
	Wed, 13 Nov 2013 15:19:28 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=M3vwsjdpOsYHAwzd9q8jdBCeBUc=; b=Zlbp5/
	FmyIwwitqVVjM7ZUIJhykmB5+B06iKilp4EqPz7+1JEwtmE0ryAx8ajkgIibHojQ
	0gV/24dYmWQjXiUI/iMPgb1Q0ntuAJjgDxf1iu2yfKHgR+DocYUefib1EmWSQ8Pi
	L/NhK0Y6lFm81iWI1xx2U78H4fNJnjWRD5Qiw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=cUyy1F/VMQRyqX3WUV3TPqhhMgs8lO76
	rVYPBEP4Wcd7OLinfizsId6zREQm5glj7Tnt9tPsACkLhoRyYpXEjC5N/a5C6Eno
	I28hkfe5CbVMretd6tXK2e3llhezr0pYLoyd3Fo3r34J4TkoXn/rfMwS+MocP89a
	4cAc8rVEiAI=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E6FBA512DB;
	Wed, 13 Nov 2013 15:19:27 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 4054F512D8;
	Wed, 13 Nov 2013 15:19:27 -0500 (EST)
In-Reply-To: <xmqqbo1odqb4.fsf@gitster.dls.corp.google.com> (Junio C. Hamano's
	message of "Wed, 13 Nov 2013 12:01:19 -0800")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: E510B776-4CA0-11E3-BB68-D331802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/237802>

Junio C Hamano <gitster@pobox.com> writes:

> Ramkumar Ramachandra <artagnon@gmail.com> writes:
>
>> +		} else if (!prefixcmp(name, "color")) {
>> +			;
>
> How is "%(color:short)" parsed with this code?
>
> This part says, "Yeah, I see something starting with color", and
> then later strchr(name, ':') will point formatp to "short".
>
> Luckily, "%(colorgarbage:short)" does not even come this far because
> parse_atom() would not have allowed the codeflow to, but comparing
> with "color:" here may be a lot more defensive and safe, I think.
>
> And find the color-value here, stuffing v->s inside this "else if",
> continue, without letting the formatp part work on refname this
> piece of code does not even set.  Just like how we handle "flag"
> without falling thru to the formatp code.

Perhaps like this (obviously not tested as these three patches did
not add any tests ;-)

I also think that there should be a mechanism to do "color:reset"
after each record is issued automatically, and also have the color
output honor --color=auto from the command line, i.e.

	git for-each-ref --color=auto --format='%(color:blue)%(subject)' | cat

should turn the coloring off.

So I think this patch may be a first step in the right direction,
but there are quite a lot more work that is needed before it gets
ready for production use.

Thanks.

 builtin/for-each-ref.c | 14 ++++++--------
 1 file changed, 6 insertions(+), 8 deletions(-)

diff --git a/builtin/for-each-ref.c b/builtin/for-each-ref.c
index 9e07571..07a9385 100644
--- a/builtin/for-each-ref.c
+++ b/builtin/for-each-ref.c
@@ -664,8 +664,12 @@ static void populate_value(struct refinfo *ref)
 			    !branch->merge[0]->dst)
 				continue;
 			refname = branch->merge[0]->dst;
-		} else if (!prefixcmp(name, "color")) {
-			;
+		} else if (!prefixcmp(name, "color:")) {
+			char color[COLOR_MAXLEN] = "";
+
+			color_parse(name + 6, "--format", color);
+			v->s = xstrdup(color);
+			continue;
 		} else if (!strcmp(name, "flag")) {
 			char buf[256], *cp = buf;
 			if (ref->flag & REF_ISSYMREF)
@@ -733,12 +737,6 @@ static void populate_value(struct refinfo *ref)
 				else
 					v->s = "<>";
 				continue;
-			} else if (!prefixcmp(name, "color")) {
-				char color[COLOR_MAXLEN] = "";
-
-				color_parse(formatp, "--format", color);
-				v->s = xstrdup(color);
-				continue;
 			} else
 				die("unknown %.*s format %s",
 				    (int)(formatp - name), name, formatp);
