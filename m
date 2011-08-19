From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v4 1/2] push: Don't push a repository with unpushed
 submodules
Date: Fri, 19 Aug 2011 16:26:23 -0700
Message-ID: <7vwre9yodc.fsf@alter.siamese.dyndns.org>
References: <1313791728-11328-1-git-send-email-iveqy@iveqy.com>
 <1313791728-11328-2-git-send-email-iveqy@iveqy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: git@vger.kernel.org, hvoigt@hvoigt.net, jens.lehmann@web.de
To: Fredrik Gustafsson <iveqy@iveqy.com>
X-From: git-owner@vger.kernel.org Sat Aug 20 01:26:43 2011
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@lo.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by lo.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1QuYSY-0007TW-Rg
	for gcvg-git-2@lo.gmane.org; Sat, 20 Aug 2011 01:26:43 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1753783Ab1HSX01 (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 19 Aug 2011 19:26:27 -0400
Received: from b-pb-sasl-quonix.pobox.com ([208.72.237.35]:64222 "EHLO
	smtp.pobox.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1750760Ab1HSX00 (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 19 Aug 2011 19:26:26 -0400
Received: from smtp.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id E411B52B3;
	Fri, 19 Aug 2011 19:26:25 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; s=sasl; bh=ecUaWHWG/X1JRIDsC0FQuuOpdYs=; b=ud6nOR
	pJqLgNv85LnXNOAv/SM6WNI3g83VOg3kNkMiptDya4fML4wkMyt/n9hlyl7h+p+a
	SFyevIc+hBq11RVYmiMm4TmBv/mnfdrPcLIgU44L/o6ovdCgYtozECO7VLta/qEO
	oIj2HoDHAq9OxtfcHTZIIDy4+xZofnK94mrkM=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
	:subject:references:date:in-reply-to:message-id:mime-version
	:content-type; q=dns; s=sasl; b=ZPF4ZuwfoFVzMvb29kLmFJ0fJHVN6b5m
	Y9Fn9UKCL4MTN2UtZaxRymNcBj8g+EGk6z2uDCb8Ojuwz/JY5uhLfvx8Bm9P0Ih9
	8FAXnH3e+zFBMz1jqv7LLcWbI27tY8CV/0gkGMAtuNIHjGNI1xUPbFo08wA7eKEk
	TxBTuqep4qw=
Received: from b-pb-sasl-quonix.pobox.com (unknown [127.0.0.1])
	by b-sasl-quonix.pobox.com (Postfix) with ESMTP id DB44052B2;
	Fri, 19 Aug 2011 19:26:25 -0400 (EDT)
Received: from pobox.com (unknown [76.102.170.102]) (using TLSv1 with cipher
 DHE-RSA-AES128-SHA (128/128 bits)) (No client certificate requested) by
 b-sasl-quonix.pobox.com (Postfix) with ESMTPSA id 60F4152B1; Fri, 19 Aug 2011
 19:26:25 -0400 (EDT)
In-Reply-To: <1313791728-11328-2-git-send-email-iveqy@iveqy.com> (Fredrik
 Gustafsson's message of "Sat, 20 Aug 2011 00:08:47 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/23.2 (gnu/linux)
X-Pobox-Relay-ID: A8196A76-CABA-11E0-BD8B-1DC62E706CDE-77302942!b-pb-sasl-quonix.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/179746>

Fredrik Gustafsson <iveqy@iveqy.com> writes:

> diff --git a/combine-diff.c b/combine-diff.c
> index b11eb71..f7a8978 100644
> --- a/combine-diff.c
> +++ b/combine-diff.c
> @@ -1074,7 +1074,7 @@ void diff_tree_combined(const unsigned char *sha1,
>  		 * when doing combined diff.
>  		 */
>  		int stat_opt = (opt->output_format &
> -				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT));
> +				(DIFF_FORMAT_NUMSTAT|DIFF_FORMAT_DIFFSTAT|DIFF_FORMAT_CALLBACK));
>  		if (i == 0 && stat_opt)
>  			diffopts.output_format = stat_opt;
>  		else

Sorry, but this is not what I meant. With this change, you are running N
(= number of parents) diffs with the end result, but only making a
callback while running a diff with the first parent, and not getting
anything from comparison with other parents.

The existing NUMSTAT/STAT exception is only justified because that is how
"diff --stat" shows merges (i.e. showing the extent of damage to the
mainline, assuming you are viewing a merge to the mainline from a side
branch).

What I meant was more along the lines of the following, but I think we
would need a new kind of callback that can take N-way parents (which is
not depicted here).

Let me cook up something and get back to you later tonight.

 combine-diff.c |    6 ++++++
 1 files changed, 6 insertions(+), 0 deletions(-)

diff --git a/combine-diff.c b/combine-diff.c
index 655fa89..51ebd31 100644
--- a/combine-diff.c
+++ b/combine-diff.c
@@ -1017,6 +1017,12 @@ void diff_tree_combined(const unsigned char *sha1,
 			num_paths++;
 	}
 	if (num_paths) {
+		if (opt->output_format & DIFF_FORMAT_CALLBACK) {
+			for (p = paths; p; p = p->next) {
+				if (p->len)
+					... make callback here ...
+			}
+		}
 		if (opt->output_format & (DIFF_FORMAT_RAW |
 					  DIFF_FORMAT_NAME |
 					  DIFF_FORMAT_NAME_STATUS)) {
