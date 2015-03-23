From: Stefan Beller <sbeller@google.com>
Subject: [PATCH] builtin/apply.c: fix a memleak (Fixup, squashable)
Date: Mon, 23 Mar 2015 10:13:31 -0700
Message-ID: <1427130811-21222-1-git-send-email-sbeller@google.com>
References: <xmqqsiczau9p.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Cc: git@vger.kernel.org, Stefan Beller <sbeller@google.com>
To: gitster@pobox.com
X-From: git-owner@vger.kernel.org Mon Mar 23 18:13:47 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ya5v2-0006tq-8l
	for gcvg-git-2@plane.gmane.org; Mon, 23 Mar 2015 18:13:40 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752903AbbCWRNg convert rfc822-to-quoted-printable (ORCPT
	<rfc822;gcvg-git-2@m.gmane.org>); Mon, 23 Mar 2015 13:13:36 -0400
Received: from mail-ie0-f177.google.com ([209.85.223.177]:34514 "EHLO
	mail-ie0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752263AbbCWRNf (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 23 Mar 2015 13:13:35 -0400
Received: by iedfl3 with SMTP id fl3so47108604ied.1
        for <git@vger.kernel.org>; Mon, 23 Mar 2015 10:13:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20120113;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-type:content-transfer-encoding;
        bh=dU/ZGGJ1GdBOEBK+Dfljr4LroSta6tYzyJtzVri6ksY=;
        b=NivJ6m/JCg3ZDkaL1yOsfv6BsTDwOL+KGjJatHbgFkPvdSH+i8rmaqTwyAHBv2Ygvk
         lFyVlhFTZK0em7CBX7NXp02DI1wVg7SiecaH3QA6ttasaBn353F2WYYkjkvVZZMrXC2d
         DAtG2gYMg5Mgi2KMuSs+2yJEXyR3PmpthRrE9jIqII8so2aQ+bgwzbHXU7RMAlu/U1Ul
         tMJc362JJifcL01Birfn/NjEtssuVk+EORRCoRVqRbQLTK2SCRio4orWxb8XDZ9NE0CD
         Ef7RUr02SuHy5Gma1gx0wOxPXk2LHYjqpIBx5Pjk06w6peIPfYZ0qXBrHFEMTT43gcSV
         omfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20130820;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-type:content-transfer-encoding;
        bh=dU/ZGGJ1GdBOEBK+Dfljr4LroSta6tYzyJtzVri6ksY=;
        b=Eac4IpMYbYGEtVT7gByx/FBCQiQ1+Rn+ccbU5sy9Lb7r5qGT0AQFXwY4zd+nSO6q1x
         dyTCKPMUfsyAZAEAPFbrHF72lKvuuUEfXbIQD20V2Xgipgn8kVCHYzgng1bmWcSh0apz
         P8XEUp3vOnJ1gz+U3uKd2UuHidDeHr2HOxpI4eyZOJb0w7d6OGbS9ECgryxRynL4+diT
         r9fo7lFf/bBTm1ElDkpaYZHjdTfouC+CvSNAyIg3s5iagUsae/eQ9Mlx+mrSJhN6BUai
         r+qDcrpTqFB2ixMY8hRcuYpbTZtLCC9jve/i3IE72ELjgrpNQUlUsNipQLWW7BNUCYY/
         +VyA==
X-Gm-Message-State: ALoCoQnXYbZJY7iI5/U1xXLC3KkG4jReG/4Xo9htgIB6x0vN9Bc3tyeUsV+RvNFV9KIRekqRn3zc
X-Received: by 10.50.136.228 with SMTP id qd4mr16251677igb.13.1427130814666;
        Mon, 23 Mar 2015 10:13:34 -0700 (PDT)
Received: from localhost ([2620:0:1000:5b00:4d5:daa7:294c:bc0b])
        by mx.google.com with ESMTPSA id nv8sm2783603igb.6.2015.03.23.10.13.34
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Mon, 23 Mar 2015 10:13:34 -0700 (PDT)
X-Mailer: git-send-email 2.3.0.81.gc37f363
In-Reply-To: <xmqqsiczau9p.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/266150>

Signed-off-by: Stefan Beller <sbeller@google.com>
---

> By the way, aren't the following also leaking here?
>
> =C2=A0- the strbuf newlines that starts out as "size"
> =C2=A0- line[] arrays of preimage and postimage
>

yes :(

I think a viable replacement may be below.
That way the returned value of the function is not -1, but 1.
We're using the return value only as a boolean, so it doesn't
really matter.

 builtin/apply.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)
=20
diff --git a/builtin/apply.c b/builtin/apply.c
index e152c4d..0769b09 100644
--- a/builtin/apply.c
+++ b/builtin/apply.c
@@ -2776,8 +2776,8 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
 		default:
 			if (apply_verbosely)
 				error(_("invalid start of line: '%c'"), first);
-			free(oldlines);
-			return -1;
+			applied_pos =3D -1;
+			goto out;
 		}
 		if (added_blank_line) {
 			if (!new_blank_lines_at_end)
@@ -2916,6 +2916,7 @@ static int apply_one_fragment(struct image *img, =
struct fragment *frag,
 			      (int)(old - oldlines), oldlines);
 	}
=20
+out:
 	free(oldlines);
 	strbuf_release(&newlines);
 	free(preimage.line_allocated);
--=20
2.3.0.81.gc37f363
