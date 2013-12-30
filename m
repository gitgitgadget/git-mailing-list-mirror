From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH 1/2] merge-base: fix duplicates and not best ancestors in output
Date: Mon, 30 Dec 2013 11:01:01 -0800
Message-ID: <xmqqppoerwnm.fsf@gitster.dls.corp.google.com>
References: <CABEtfDFu=Fc0SXbyFctEyiMCJwqxP25K9mdVhAB0X_vKHxvW_A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-2022-jp
Cc: git@vger.kernel.org, jrnieder@gmail.com
To: =?iso-2022-jp?B?GyRCJyMnUSdjJ1onXSdaJ1sbKEIgGyRCJy4nUSdcJ1EnYidgGyhC?=
	 =?iso-2022-jp?B?GyRCJ1MbKEI=?= <einmalfel@gmail.com>
X-From: git-owner@vger.kernel.org Mon Dec 30 20:01:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Vxi5Q-0008MF-Om
	for gcvg-git-2@plane.gmane.org; Mon, 30 Dec 2013 20:01:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S932109Ab3L3TBI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 30 Dec 2013 14:01:08 -0500
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:49704 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932069Ab3L3TBH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 30 Dec 2013 14:01:07 -0500
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 9F53E5FDC7;
	Mon, 30 Dec 2013 14:01:05 -0500 (EST)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=WnvtcYbd4bii7OerqPeNE8peylE=; b=DIBrdI
	xWXFSpdWcVzSzBeQgEPgJ58wu6xGdeUFs8fVxFOYvYS9ZVbJkH+WaaMCFj2oO5AC
	JyLXJUAsV2+Nm/ksECp5p8W0bzBbmHyDzJlGSSsN/rLCxa0RPq4Nuu+ZOhAhWGdu
	HcxLl1DTFDOX7QGB3JSpj7P0TcyfbrAPS97tw=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=R1m1Pf5V3FnEIxdPhsoJpbWZgX/q3P/y
	Qnw/4Y1VW4jVC3fwqbCY5ejLVGXWvy/5Aul5cWsAtgfqKidcDyFNO6XvBRknqhdA
	EB9D8SZhBgPOlm8frGoq2/crlQTmjblm56V2sMREim3IJZJ86DByyVhuNH3NwmCi
	trYqU9CRD4M=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id 8CDD35FDC6;
	Mon, 30 Dec 2013 14:01:05 -0500 (EST)
Received: from pobox.com (unknown [72.14.226.9])
	(using TLSv1 with cipher DHE-RSA-AES128-SHA (128/128 bits))
	(No client certificate requested)
	by b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id D30F45FDC5;
	Mon, 30 Dec 2013 14:01:04 -0500 (EST)
In-Reply-To: <CABEtfDFu=Fc0SXbyFctEyiMCJwqxP25K9mdVhAB0X_vKHxvW_A@mail.gmail.com>
	(=?iso-2022-jp?B?IhskQicjJ1EnYydaJ10nWidbGyhCIBskQicuJ1EnXCdRJ2InYCdTGyhC?=
 =?iso-2022-jp?B?Iidz?= message of "Sat, 28 Dec 2013
	14:22:26 +0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.3 (gnu/linux)
X-Pobox-Relay-ID: BBA0B432-7184-11E3-9C63-1B26802839F8-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/239813>

Василий Макаров <einmalfel@gmail.com> writes:

> Hi there!
> First of all: I'm new to mailing-lists, sorry if I'm doing it wrong.
>
> I've found a bug in git merge-base, causing it to show not best common
> ancestors and duplicates under some circumstances (example is given in
> attached test case).

Attached???

> Problem cause is algorithm used in get_octopus_merge_bases(), it
> iteratively concatenates merge bases, and don't care if there are
> duplicates or decsendants/ancestors in result.
> What I suggest as a solution is to simply reduce bases list after
> get_octopus_merge_bases().

I do not offhand remember if it was deliberate that we do not dedup
the result from the underlying get_octopus_merge_bases() (the most
likely reason for not deduping is because the caller is expected to
do that if it wants to).

Whether it is an improvement to force deduping here or it is an
regression to do so, I think we should split that helper function
handle_octopus().  It does two totally unrelated things (one is only
to list independent heads without showing merge bases, the other is
to show one or more merge bases across all the heads given).
Perhaps if we split the "independent" codepath introduced by
a1e0ad78 (merge-base --independent to print reduced parent list in a
merge, 2010-08-17) into its own helper function, like this, it would
make it clear what is going on.

Thanks.

 builtin/merge-base.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/builtin/merge-base.c b/builtin/merge-base.c
index e88eb93..a00e8f5 100644
--- a/builtin/merge-base.c
+++ b/builtin/merge-base.c
@@ -44,19 +44,36 @@ static struct commit *get_commit_reference(const char *arg)
 	return r;
 }
 
-static int handle_octopus(int count, const char **args, int reduce, int show_all)
+static int handle_independent(int count, const char **args)
 {
 	struct commit_list *revs = NULL;
 	struct commit_list *result;
 	int i;
 
-	if (reduce)
-		show_all = 1;
+	for (i = count - 1; i >= 0; i--)
+		commit_list_insert(get_commit_reference(args[i]), &revs);
+
+	result = reduce_heads(revs);
+	if (!result)
+		return 1;
+
+	while (result) {
+		printf("%s\n", sha1_to_hex(result->item->object.sha1));
+		result = result->next;
+	}
+	return 0;
+}
+
+static int handle_octopus(int count, const char **args, int show_all)
+{
+	struct commit_list *revs = NULL;
+	struct commit_list *result;
+	int i;
 
 	for (i = count - 1; i >= 0; i--)
 		commit_list_insert(get_commit_reference(args[i]), &revs);
 
-	result = reduce ? reduce_heads(revs) : get_octopus_merge_bases(revs);
+	result = get_octopus_merge_bases(revs);
 
 	if (!result)
 		return 1;
@@ -114,8 +131,10 @@ int cmd_merge_base(int argc, const char **argv, const char *prefix)
 	if (reduce && (show_all || octopus))
 		die("--independent cannot be used with other options");
 
-	if (octopus || reduce)
-		return handle_octopus(argc, argv, reduce, show_all);
+	if (octopus)
+		return handle_octopus(argc, argv, show_all);
+	else if (reduce)
+		return handle_independent(argc, argv);
 
 	rev = xmalloc(argc * sizeof(*rev));
 	while (argc-- > 0)
