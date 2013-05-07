From: Felipe Contreras <felipe.contreras@gmail.com>
Subject: Re: [PATCH v2 1/3] fast-{import,export}: use get_sha1_hex() directly
Date: Tue, 7 May 2013 17:13:19 -0500
Message-ID: <CAMP44s0AipiEVhHrDS0-dB9jCoCqHYDd_s5gcGzqyuh0A+qehg@mail.gmail.com>
References: <1367793534-8401-1-git-send-email-felipe.contreras@gmail.com>
	<1367793534-8401-2-git-send-email-felipe.contreras@gmail.com>
	<7v38tyn9cq.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org, Antoine Pelisse <apelisse@gmail.com>,
	Johannes Schindelin <johannes.schindelin@gmx.de>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed May 08 00:13:27 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1UZq8U-0005yD-Jx
	for gcvg-git-2@plane.gmane.org; Wed, 08 May 2013 00:13:26 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751258Ab3EGWNV (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Tue, 7 May 2013 18:13:21 -0400
Received: from mail-lb0-f180.google.com ([209.85.217.180]:62621 "EHLO
	mail-lb0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750772Ab3EGWNV (ORCPT <rfc822;git@vger.kernel.org>);
	Tue, 7 May 2013 18:13:21 -0400
Received: by mail-lb0-f180.google.com with SMTP id v1so1276687lbd.11
        for <git@vger.kernel.org>; Tue, 07 May 2013 15:13:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=z3Hs9hQCH764SpKXIFWskRIPa2MOrxsHFSjtOE9yh90=;
        b=cn/I9eSRyxz6O+PqC67/Ga99ZwbWHlsTRBiRSp6aUruXdHXpjnaOZyrAQC9WsCRtoa
         PrwdkSjp0beBrri4FyYebKJSSobkI5ceXsDk9CJfvdjx8Ya6dAs7nbv0ea99ySLyMPEE
         N37YTw/1Ll67afUqWywIMPGpbTplP6X2tYN6P1ffjlFjDYPqGp8qLJWrZZ+9X1qWFUel
         h7Z81Sshb99NdJ6NPdHgBrOLNiCUngpXYQ8zLjX68IQFRDXuNolujw5GXwi43K40m/7L
         y/k+yqw0JyAnL2lZLWTSNDSFr3GrvEEqeIxO7FXtwID82FXk5MMojbS1uzMZo/IyXdpk
         BztA==
X-Received: by 10.152.29.165 with SMTP id l5mr1768155lah.8.1367964799817; Tue,
 07 May 2013 15:13:19 -0700 (PDT)
Received: by 10.114.184.3 with HTTP; Tue, 7 May 2013 15:13:19 -0700 (PDT)
In-Reply-To: <7v38tyn9cq.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/223623>

On Tue, May 7, 2013 at 9:38 AM, Junio C Hamano <gitster@pobox.com> wrote:
> Felipe Contreras <felipe.contreras@gmail.com> writes:
>
>> It's wrong to call get_sha1() if they should be SHA-1s, plus
>> inefficient.
>>
>> Signed-off-by: Felipe Contreras <felipe.contreras@gmail.com>
>> ---
>
> It appears that "they should be SHA-1s" assumption does not hold;
> this patch breaks at least 3303, 9020, and 9300.
>
> Also assuming these are always 40-hex goes directly against what is
> documented in Documentation/git-fast-import.txt (look for "Here
> committish is any of the following").  My bad while reviewing the
> earlier round.
>
> I've redone 'pu' (which was failing the test last night) after
> dropping this and keeping only patches 2 and 3 from the series.

Turns out most of the get_sha1() calls were correct; this does the trick:

diff --git a/builtin/fast-export.c b/builtin/fast-export.c
index 18fdfb3..d1d68e9 100644
--- a/builtin/fast-export.c
+++ b/builtin/fast-export.c
@@ -623,7 +623,7 @@ static void import_marks(char *input_file)

                mark = strtoumax(line + 1, &mark_end, 10);
                if (!mark || mark_end == line + 1
-                       || *mark_end != ' ' || get_sha1(mark_end + 1, sha1))
+                       || *mark_end != ' ' || get_sha1_hex(mark_end + 1, sha1))
                        die("corrupt mark line: %s", line);

                if (last_idnum < mark)
diff --git a/fast-import.c b/fast-import.c
index 5f539d7..3f32149 100644
--- a/fast-import.c
+++ b/fast-import.c
@@ -1822,7 +1822,7 @@ static void read_marks(void)
                *end = 0;
                mark = strtoumax(line + 1, &end, 10);
                if (!mark || end == line + 1
-                       || *end != ' ' || get_sha1(end + 1, sha1))
+                       || *end != ' ' || get_sha1_hex(end + 1, sha1))
                        die("corrupt mark line: %s", line);
                e = find_object(sha1);
                if (!e) {

-- 
Felipe Contreras
