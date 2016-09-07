Return-Path: <git-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on dcvr.yhbt.net
X-Spam-Level: 
X-Spam-ASN: AS31976 209.132.180.0/23
X-Spam-Status: No, score=-4.5 required=3.0 tests=AWL,BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,
	RP_MATCHES_RCVD shortcircuit=no autolearn=ham autolearn_force=no version=3.4.0
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by dcvr.yhbt.net (Postfix) with ESMTP id 2049B1F859
	for <e@80x24.org>; Wed,  7 Sep 2016 16:06:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1757149AbcIGQGi (ORCPT <rfc822;e@80x24.org>);
        Wed, 7 Sep 2016 12:06:38 -0400
Received: from pb-smtp2.pobox.com ([64.147.108.71]:58716 "EHLO
        sasl.smtp.pobox.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1757040AbcIGQGg (ORCPT <rfc822;git@vger.kernel.org>);
        Wed, 7 Sep 2016 12:06:36 -0400
Received: from sasl.smtp.pobox.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 54269382CD;
        Wed,  7 Sep 2016 12:06:34 -0400 (EDT)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; s=sasl; bh=0GD+sWfj9g/4Qv9Vkdk+k4QeXYw=; b=i9GGMF
        nDyyelh/ih+Ca3JetNT+eNASRV8kKxpkEKNolU1Fcpy5XPEvLXci6Ix71QIDFS5z
        O+ZciAGpG+mA6L3mXcEd4M1OvN1rX1vdNxxqmL0ko0X6dOTF58XFmLTB3gem6htD
        b5o5pQTUduiobo5wjRARZfPGipS0j/MghJQHc=
DomainKey-Signature: a=rsa-sha1; c=nofws; d=pobox.com; h=from:to:cc
        :subject:references:date:in-reply-to:message-id:mime-version
        :content-type; q=dns; s=sasl; b=SCr7r9O5kB3Vy2AyrRCjPvcE3vB8t5y+
        bN2iPyP/7zKNZ1JJgdLc7LhiAmmeVHYdWWGyPtSvpoUV37DSn5s7qsfBLe04DNMk
        Ct24CsaErbfy++/eKdz0SWVwzuei/SU51WukGZaWUUWofQRu63YcdxgJ4GK6OyRa
        odzYRK+e7rg=
Received: from pb-smtp2.nyi.icgroup.com (unknown [127.0.0.1])
        by pb-smtp2.pobox.com (Postfix) with ESMTP id 49C17382CC;
        Wed,  7 Sep 2016 12:06:34 -0400 (EDT)
Received: from pobox.com (unknown [104.132.0.95])
        (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by pb-smtp2.pobox.com (Postfix) with ESMTPSA id BF855382CB;
        Wed,  7 Sep 2016 12:06:33 -0400 (EDT)
From:   Junio C Hamano <gitster@pobox.com>
To:     Josh Triplett <josh@joshtriplett.org>
Cc:     git@vger.kernel.org
Subject: Re: format-patch base-commit: moving to above the patch?
References: <20160901152912.uhxapgd3isdjc4mn@x>
Date:   Wed, 07 Sep 2016 09:06:31 -0700
In-Reply-To: <20160901152912.uhxapgd3isdjc4mn@x> (Josh Triplett's message of
        "Thu, 1 Sep 2016 08:29:14 -0700")
Message-ID: <xmqqh99rpud4.fsf@gitster.mtv.corp.google.com>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Pobox-Relay-ID: 0C07E0F8-7515-11E6-8F87-51057B1B28F4-77302942!pb-smtp2.pobox.com
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org

Josh Triplett <josh@joshtriplett.org> writes:

> Currently, format-patch puts base-commit and prerequisite-patch-id
> information below the patch, and below the email signature.  Most mail
> clients automatically trim everything below the signature marker as
> unimportant when quoting a mail for a reply, which would make it
> difficult for someone to reply, quote the base-commit, and say something
> like "I don't have this commit, where did it come from?" or "Can you
> please rebase this on ...".
>
> Might it make sense to move this information adjacent to the diffstat,
> instead?  Or, at least, above the email signature?

I personally feel that it would be annoying to have them near
diffstat, especially given that unbounded many prereq patches can be
listed.  It would not be too bad to flip the order between the call
to print_signature() and print_bases(), though.  The extent of the
change needed to (note: not even compile-tested) does does not look
too bad, either.

I did not carefully think what the right adjustment for the MIME
case is, though.

I would expect some tests that expect the current order of the tail
end of the output to break, which you would need to adjust.  And if
there is no such test right now, you should add one, as your inquiry
and this patch _sets_ a concrete expectation as to what should come
before the signature line, which future updates should not break.


 builtin/log.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/builtin/log.c b/builtin/log.c
index 92dc34d..d69d5e6 100644
--- a/builtin/log.c
+++ b/builtin/log.c
@@ -1042,7 +1042,6 @@ static void make_cover_letter(struct rev_info *rev, int use_stdout,
 	diff_flush(&opts);
 
 	fprintf(rev->diffopt.file, "\n");
-	print_signature(rev->diffopt.file);
 }
 
 static const char *clean_message_id(const char *msg_id)
@@ -1720,6 +1719,7 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		make_cover_letter(&rev, use_stdout,
 				  origin, nr, list, branch_name, quiet);
 		print_bases(&bases, rev.diffopt.file);
+		print_signature(rev.diffopt.file);
 		total++;
 		start_number--;
 	}
@@ -1779,13 +1779,13 @@ int cmd_format_patch(int argc, const char **argv, const char *prefix)
 		if (!use_stdout)
 			rev.shown_one = 0;
 		if (shown) {
+			print_bases(&bases, rev.diffopt.file);
 			if (rev.mime_boundary)
 				fprintf(rev.diffopt.file, "\n--%s%s--\n\n\n",
 				       mime_boundary_leader,
 				       rev.mime_boundary);
 			else
 				print_signature(rev.diffopt.file);
-			print_bases(&bases, rev.diffopt.file);
 		}
 		if (!use_stdout)
 			fclose(rev.diffopt.file);
