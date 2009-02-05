From: Jay Soffian <jaysoffian@gmail.com>
Subject: Re: Confused about diff-tree --cc output
Date: Wed, 4 Feb 2009 22:49:34 -0500
Message-ID: <76718490902041949v8fffd17l7cb19d836a3e1887@mail.gmail.com>
References: <76718490902041313y44eeb99bya33513bc9818aeb0@mail.gmail.com>
	 <7vk585n9x8.fsf@gitster.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Thu Feb 05 04:53:31 2009
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@gmane.org
Received: from vger.kernel.org ([209.132.176.167])
	by lo.gmane.org with esmtp (Exim 4.50)
	id 1LUvIw-0007Vy-RE
	for gcvg-git-2@gmane.org; Thu, 05 Feb 2009 04:53:31 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752245AbZBEDth (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 4 Feb 2009 22:49:37 -0500
Received: (majordomo@vger.kernel.org) by vger.kernel.org id S1752049AbZBEDtg
	(ORCPT <rfc822;git-outgoing>); Wed, 4 Feb 2009 22:49:36 -0500
Received: from rv-out-0506.google.com ([209.85.198.233]:11249 "EHLO
	rv-out-0506.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751235AbZBEDtf (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 4 Feb 2009 22:49:35 -0500
Received: by rv-out-0506.google.com with SMTP id k40so39269rvb.1
        for <git@vger.kernel.org>; Wed, 04 Feb 2009 19:49:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=gamma;
        h=domainkey-signature:mime-version:received:in-reply-to:references
         :date:message-id:subject:from:to:cc:content-type
         :content-transfer-encoding;
        bh=fxE++KQpCR8G01EYxikkXps55xhVXCzYb3VqFOlxKv4=;
        b=ISVBzink2NB9850rsavaSFEtiHeeovwFzf9PucJERK+OrgNKe5unuFZRELKgU4sKIa
         g5VRAAixoiyjrdwJUX0C2k3uXheZfH37queula5TSIrOQ7fo5nrh04lApPXa6iRX3Nvs
         jcCsyy/X5hVEYTmj+kgopft4KSt84olabbNUk=
DomainKey-Signature: a=rsa-sha1; c=nofws;
        d=gmail.com; s=gamma;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type:content-transfer-encoding;
        b=HtcKXX4Bjgpa+ZgXqF3fx5w/9yD7T6Y7wVlRst9FrI2PXs9uc5ejH4OpuYqJNKk3Z9
         wW55aWiWErYYDAwh26Q7GJjGGTsXSuJnI9X+puKNVAPDftkydvkqMGKfMV/wMS2WsEwH
         A/KvPedFK3yhds3iDkVgsmuiUxl+gZCsKB1nI=
Received: by 10.140.143.11 with SMTP id q11mr4121244rvd.260.1233805774196; 
	Wed, 04 Feb 2009 19:49:34 -0800 (PST)
In-Reply-To: <7vk585n9x8.fsf@gitster.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/108496>

On Wed, Feb 4, 2009 at 4:56 PM, Junio C Hamano <gitster@pobox.com> wrote:
> I think this is "more than two versions", in
>
>    http://thread.gmane.org/gmane.comp.version-control.git/15486/focus=15491
>
> Nothing new to see here, I think.

Okay, let me just make sure I understand. The output of git show has:

diff --cc builtin-remote.c
index abc8dd8,07cfdac..db18bcf

So, I can do:

git diff abc8dd8 db18bcf > parent1.diff
git diff 07cfdac db18bcf > parent2.diff

Then look at each for overlapping hunks. If I do so, I find that this
hunk in parent1.diff (I've annotated w/line numbers):

@@ -542,8 +552,11 @@ static int rm(int argc, const char **argv)
552 	struct strbuf buf = STRBUF_INIT;
553 	struct known_remotes known_remotes = { NULL, NULL };
554 	struct string_list branches = { NULL, 0, 0, 1 };
   -	struct branches_for_remote cb_data = { NULL, &branches, &known_remotes };
   -	int i;
555+	struct string_list skipped = { NULL, 0, 0, 1 };
556+	struct branches_for_remote cb_data = {
557+		NULL, &branches, &skipped, &known_remotes
558+	};
559+	int i, result;
560
561 	if (argc != 2)
562 		usage_with_options(builtin_remote_usage, options);

and this hunk in parent2.diff:

@@ -362,7 +549,7 @@ static int rm(int argc, const char **argv)
549 		OPT_END()
550 	};
551 	struct remote *remote;
   -	struct strbuf buf;
552+	struct strbuf buf = STRBUF_INIT;
553 	struct known_remotes known_remotes = { NULL, NULL };
554 	struct string_list branches = { NULL, 0, 0, 1 };
555 	struct string_list skipped = { NULL, 0, 0, 1 };

overlap (lines 552-555). Since the hunks overlap, and each introduces
a unique change, both hunks are shown in the combined format. I guess
this makes sense now that I know how it works, but my expectation had
been that I'd only see output if there was a merge conflict.

I also note that "git diff-tree -U2 --cc 8554af" produces no output,
and this is because there is no longer overlap (well, the context
lines overlap, but are identical, which I guess is good enough).

Is that about right?

(Aside, to reconstruct the merge manually I did the following, but I
bet there is an easier way:

git show 3613d1d:builtin-remote.c > mine
git show 441adf0:builtin-remote.c > other
git show $(git merge-base 3613d1d 441adf0):builtin-remote.c > base
git merge-file -p mine base other
)

j.
