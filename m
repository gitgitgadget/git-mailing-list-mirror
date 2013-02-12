From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCHv2] parse-options: report uncorrupted multi-byte options
Date: Tue, 12 Feb 2013 09:30:36 +0700
Message-ID: <CACsJy8DZy0_1RyeNtuobzABUD0rr6oE6RB=rXdqbG72SK4kNUw@mail.gmail.com>
References: <1360624428-4728-1-git-send-email-kusmabite@gmail.com>
 <CACsJy8BByNnEhhE3TieM_kOy65t75rmB45ZzjJJ8AtL2N4-UFA@mail.gmail.com> <7va9rajn99.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Erik Faye-Lund <kusmabite@gmail.com>, git@vger.kernel.org,
	peff@peff.net, matthieu.moy@grenoble-inp.fr, tboegi@web.de
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Tue Feb 12 03:31:34 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1U55ef-0005wa-7f
	for gcvg-git-2@plane.gmane.org; Tue, 12 Feb 2013 03:31:33 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1751489Ab3BLCbI (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Mon, 11 Feb 2013 21:31:08 -0500
Received: from mail-oa0-f53.google.com ([209.85.219.53]:48319 "EHLO
	mail-oa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751367Ab3BLCbH (ORCPT <rfc822;git@vger.kernel.org>);
	Mon, 11 Feb 2013 21:31:07 -0500
Received: by mail-oa0-f53.google.com with SMTP id m1so7128061oag.12
        for <git@vger.kernel.org>; Mon, 11 Feb 2013 18:31:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=x-received:mime-version:in-reply-to:references:from:date:message-id
         :subject:to:cc:content-type;
        bh=gb+qrc3eNfBF1CR7Ov/cJA//fUEmYM1T85+TVvgyMhs=;
        b=VQAr9gAc3yIqWbydxco8WZ+oPpw3nD9mcQteRbvlfsUtde/9PBC2MMOam1oYoaEkJ1
         NZ4N5aEYVcXnOo5IVyTjQy6CZHEwMwgH5SDLmbqivKZtU0ko3HG8Zfz7RrhLpCFYGlPf
         +1iTMjyiOoUqFvg5ZeL8bxzi2TC88ifK2DSOGXdGSzScHdjDtJ7mnhRpeNIdlTJTS9/H
         trOWodSjAlNWSepG/fQ5FZap+SLkoi9HYuJCiPpOXmgQjoPtz57mxoYv4bqSz6vaSiUA
         VV+iUmDIzEg7qIk7S3DSmiZse89XJqnqq8RpmbdJxb8rUG/HjYpfotmJPtesbgBy6BOb
         dtUw==
X-Received: by 10.182.43.103 with SMTP id v7mr12169185obl.17.1360636266448;
 Mon, 11 Feb 2013 18:31:06 -0800 (PST)
Received: by 10.76.154.197 with HTTP; Mon, 11 Feb 2013 18:30:36 -0800 (PST)
In-Reply-To: <7va9rajn99.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/216112>

On Tue, Feb 12, 2013 at 9:10 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> Similar cases:
>>
>> config.c:git_default_core_config() assumes core.commentchar is ascii.
>> We should catch and report non-ascii chars, or simply accept it as a
>> string.
>
> That one is just an uninterpreted byte.  core.commentString might be
> a nice extension to the concept, but it is an entirely different
> category.

My point is not to output broken utf-8 if we can. If someone
accidentally puts a UTF-8 character in core.commentChar, it will
produce broken utf-8 templates that editors might react, but hard to
see by eye. Something like this may give sufficient protection:

diff --git a/config.c b/config.c
index aefd80b..b6f73e0 100644
--- a/config.c
+++ b/config.c
@@ -726,8 +726,11 @@ static int git_default_core_config(const char
*var, const char *value)
        if (!strcmp(var, "core.commentchar")) {
                const char *comment;
                int ret = git_config_string(&comment, var, value);
-               if (!ret)
+               if (!ret) {
+                       if (comment[1])
+                               return error("core.commentchar must be
one ASCII character");
                        comment_line_char = comment[0];
+               }
                return ret;
        }
-- 
Duy
