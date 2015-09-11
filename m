From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v17 00/14] port tag.c to use ref-filter APIs
Date: Fri, 11 Sep 2015 11:05:17 -0700
Message-ID: <xmqqwpvwzvaa.fsf@gitster.mtv.corp.google.com>
References: <1441900110-4015-1-git-send-email-Karthik.188@gmail.com>
	<vpqr3m6nrf9.fsf@scolette.imag.fr>
	<CAOLa=ZQppSg0-kc5nCfRYfHMoD5ehTTOigKz48G01vn1Mn=FTw@mail.gmail.com>
	<CAPig+cTmnOz899k_xySb1Q-SeFctOrs6fnJJN=qc731nXmXwkw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Karthik Nayak <karthik.188@gmail.com>,
	Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	Git <git@vger.kernel.org>,
	Christian Couder <christian.couder@gmail.com>
To: Eric Sunshine <sunshine@sunshineco.com>
X-From: git-owner@vger.kernel.org Fri Sep 11 20:05:28 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZaShQ-0006xT-Ll
	for gcvg-git-2@plane.gmane.org; Fri, 11 Sep 2015 20:05:25 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751514AbbIKSFU (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 11 Sep 2015 14:05:20 -0400
Received: from mail-pa0-f53.google.com ([209.85.220.53]:35857 "EHLO
	mail-pa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751017AbbIKSFT (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 11 Sep 2015 14:05:19 -0400
Received: by padhk3 with SMTP id hk3so81008719pad.3
        for <git@vger.kernel.org>; Fri, 11 Sep 2015 11:05:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=s+4au2RjPYTDNDnOym+Q3pehMx/b5JfgCM69vVWZy0M=;
        b=sRng0idMl05XKeIb1AyZQGWELkfOB9uXqltM8TFOX7fxVhLaJcBu3IPER3d9j+jlKt
         3Hcv+9P/ymuTPHmE17dKAO6fY+lkyNFp57vz1v1cc0llUT+4wtqu3dTOOshAET9nXknx
         NTTFcP5SQZwpY5bb83B386NudiOY13fjGPrIXTLEnFhgjedUITaiJ5Pn2TyxW3S0K7+g
         tycKPfv4sz513AhW0TXx09Sz++o7JOYowV+dalZhBfXWAqhqY17EtjvJQKAjAOfm0g9G
         Qb56RVVEnSGWlzONt/Xe+EpfKDvZLmu8NqwVmMs7zJ4NCKd5X+eAE3yU/xbrl3b5l/NQ
         QiLg==
X-Received: by 10.68.69.70 with SMTP id c6mr239906pbu.28.1441994719247;
        Fri, 11 Sep 2015 11:05:19 -0700 (PDT)
Received: from localhost ([2620:0:1000:861b:7504:ea92:c75a:a933])
        by smtp.gmail.com with ESMTPSA id iv2sm1541704pbd.88.2015.09.11.11.05.17
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Fri, 11 Sep 2015 11:05:18 -0700 (PDT)
In-Reply-To: <CAPig+cTmnOz899k_xySb1Q-SeFctOrs6fnJJN=qc731nXmXwkw@mail.gmail.com>
	(Eric Sunshine's message of "Fri, 11 Sep 2015 13:30:07 -0400")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/277687>

Eric Sunshine <sunshine@sunshineco.com> writes:

> In addition to a link to the previous round and an interdiff, it would
> be helpful to reviewers for you to annotate each patch (in the
> commentary are below the "---" line after your sign-off) with a
> description of the changes in that patch since the previous round in
> order to focus the reviewer's attention (where it needs to be) on the
> latest changes.

I may have got confused by seeing the same v17 (if they were marked
as v18 or v17bis, it would have been easier to make sure I didn't
miss anything), but here is the difference between what I had last
night and what I queued.  The removal of !body[1] and flipping the
order of to_free/format are not seen because I already had a local
fix-up SQUASH??? commits queued in the yesterday's batch.


$ git diff --stat -p kn/for-each-tag@{4.hours} kn/for-each-tag
 ref-filter.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/ref-filter.c b/ref-filter.c
index 226e94d..fd839ac 100644
--- a/ref-filter.c
+++ b/ref-filter.c
@@ -47,9 +47,6 @@ static struct {
 	{ "subject" },
 	{ "body" },
 	{ "contents" },
-	{ "contents:subject" },
-	{ "contents:body" },
-	{ "contents:signature" },
 	{ "upstream" },
 	{ "push" },
 	{ "symref" },
@@ -58,7 +55,6 @@ static struct {
 	{ "color" },
 	{ "align" },
 	{ "end" },
-	{ "contents:lines" },
 };
 
 #define REF_FORMATTING_STATE_INIT  { 0, NULL }
@@ -899,6 +895,7 @@ static void populate_value(struct ref_array_item *ref)
 			align->position = ALIGN_LEFT;
 
 			while (*s) {
+				/*  Strip trailing comma */
 				if (s[1])
 					strbuf_setlen(s[0], s[0]->len - 1);
 				if (!strtoul_ui(s[0]->buf, 10, (unsigned int *)&width))
