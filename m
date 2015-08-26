From: Junio C Hamano <gitster@pobox.com>
Subject: Re: [PATCH v2 2/2] trailer: support multiline title
Date: Wed, 26 Aug 2015 12:48:57 -0700
Message-ID: <xmqqegip3k5y.fsf@gitster.dls.corp.google.com>
References: <1440557461-1078-1-git-send-email-chriscool@tuxfamily.org>
	<1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
Mime-Version: 1.0
Content-Type: text/plain
Cc: Matthieu Moy <Matthieu.Moy@grenoble-inp.fr>,
	git <git@vger.kernel.org>,
	Christian Couder <chriscool@tuxfamily.org>
To: Christian Couder <christian.couder@gmail.com>
X-From: git-owner@vger.kernel.org Wed Aug 26 21:49:13 2015
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1ZUggy-00068U-SW
	for gcvg-git-2@plane.gmane.org; Wed, 26 Aug 2015 21:49:05 +0200
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S933274AbbHZTtA (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 26 Aug 2015 15:49:00 -0400
Received: from mail-pa0-f54.google.com ([209.85.220.54]:34916 "EHLO
	mail-pa0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S933174AbbHZTs7 (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 26 Aug 2015 15:48:59 -0400
Received: by pacdd16 with SMTP id dd16so170269728pac.2
        for <git@vger.kernel.org>; Wed, 26 Aug 2015 12:48:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=sender:from:to:cc:subject:references:date:in-reply-to:message-id
         :user-agent:mime-version:content-type;
        bh=RaFZj/T1VOeVginsdY6qBNYjfs/gpGKzgrvYwzsPEgY=;
        b=hVti9qHrNikhjcb3wZ8pieqg+ZW0Pl+U+yQXYLWKuLjoktTvCmlGs0ApTczKXK4IM6
         c/AsCefaGI+IJ5F0Qexdj89nL2XHfS2FEVAzAaxsb+aOMURabmyILtZf/mr8MSKKgVRX
         2SOEfbzCus8NXm3t3X+1UYaWWEPKFGqtXuXdLX7uXhRYYhAPt82Ud+yvpz8fetIiOKfk
         kmGuHHBXrd7U2wdEeTMhSfKFR8AoD+XIzyTSV0sWfrj89tNXTlwjxBLxA4wm39wwrqbe
         KrgPKy9dwNcfejelTEJrf3aj8g8MnC2WDqjcDUSu8tldJFjMGrbzgqgPKJGlG4eGsnGB
         scSw==
X-Received: by 10.68.65.77 with SMTP id v13mr242464pbs.157.1440618538896;
        Wed, 26 Aug 2015 12:48:58 -0700 (PDT)
Received: from localhost ([2620:0:10c2:1012:ac9b:ef8c:b4db:d257])
        by smtp.gmail.com with ESMTPSA id au10sm25574580pbd.81.2015.08.26.12.48.58
        (version=TLS1_2 cipher=AES128-SHA256 bits=128/128);
        Wed, 26 Aug 2015 12:48:58 -0700 (PDT)
In-Reply-To: <1440557461-1078-2-git-send-email-chriscool@tuxfamily.org>
	(Christian Couder's message of "Wed, 26 Aug 2015 04:51:01 +0200")
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/24.3 (gnu/linux)
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/276632>

Christian Couder <christian.couder@gmail.com> writes:

> We currently ignore the first line passed to `git interpret-trailers`,
> when looking for the beginning of the trailers.
>
> Unfortunately this does not work well when a commit is created with a
> line break in the title, using for example the following command:
>
> git commit -m 'place of
> code: change we made'
>
> In this special case, it is best to look at the first line and if it
> does not contain only spaces, consider that the second line is not a
> trailer.
> ---

Missing sign-off, but more importantly, "let's special case the
first line" followed by "oh, that is not enough, we need to check
the found one is sensible and tweak it otherwise" smells like
incrementally papering over things.

I think the analysis behind the first patch is correct.  It stops
the backward scan of the main loop to reach there by realizing that
the first line, which must be the first line of the patch title
paragraph, can never be a trailer.

To extend that correct realization to cover the case where the title
paragraph has more than one line, the right thing to do is to scan
forward from the beginning to find the first paragraph break, which
must be the end of the title paragraph, and exclude the whole thing,
wouldn't it?

That is, I am wondering why the patch is not more like this (there
may be off-by-one, but just to illustrate the approach; I didn't
even compile test this one so...)?

Puzzled...

 static int find_trailer_start(struct strbuf **lines, int count)
 {
-	int start, only_spaces = 1;
+	int start, end_of_title, only_spaces = 1;
+
+	/* The first paragraph is the title and cannot be trailer */
+	for (start = 0; start < count; start++)
+		if (!lines[start]->len)
+			break; /* paragraph break */
+	end_of_title = start;
 
 	/*
 	 * Get the start of the trailers by looking starting from the end
 	 * for a line with only spaces before lines with one separator.
-	 * The first line must not be analyzed as the others as it
-	 * should be either the message title or a blank line.
 	 */
-	for (start = count - 1; start >= 1; start--) {
+	for (start = count - 1; start >= end_of_title; start--) {
 		if (lines[start]->buf[0] == comment_line_char)
 			continue;
 		if (contains_only_spaces(lines[start]->buf)) {
