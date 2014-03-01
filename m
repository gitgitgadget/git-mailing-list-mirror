From: Duy Nguyen <pclouds@gmail.com>
Subject: Re: [PATCH v3 15/25] setup.c: detect $GIT_COMMON_DIR in is_git_directory()
Date: Sat, 1 Mar 2014 10:33:23 +0700
Message-ID: <CACsJy8BQxZOQOHEuw9w2-gCqiFyP=YZ_PQzHkydnSM1j3hUK-Q@mail.gmail.com>
References: <1392730814-19656-1-git-send-email-pclouds@gmail.com>
 <1392730814-19656-16-git-send-email-pclouds@gmail.com> <xmqqr46p1kbo.fsf@gitster.dls.corp.google.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: Git Mailing List <git@vger.kernel.org>
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Sat Mar 01 04:34:27 2014
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1WJah0-0006La-Nr
	for gcvg-git-2@plane.gmane.org; Sat, 01 Mar 2014 04:34:27 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752532AbaCADdz (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 28 Feb 2014 22:33:55 -0500
Received: from mail-qg0-f43.google.com ([209.85.192.43]:38633 "EHLO
	mail-qg0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752134AbaCADdy (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 28 Feb 2014 22:33:54 -0500
Received: by mail-qg0-f43.google.com with SMTP id f51so4622963qge.2
        for <git@vger.kernel.org>; Fri, 28 Feb 2014 19:33:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:from:date:message-id:subject:to
         :cc:content-type;
        bh=wqZH4YsDBJfTB9KRFTWL5p4HTubTUUhW2NlTfK2y6LM=;
        b=h6c5ayrlQd/FtvXQHDbJ4d7yZ/UukPwljbxj4b5ysOPjvc1lIfXgdDfSLJpLNviheU
         Sqy/BfnZjbVeyI5apkQrzjNHYNTBJm28qhbPh+trys+oaFpo77hhr1g0JJvYsQWZZjlh
         dm8MZDw8mz4W0BoAxeRz45H0J1KI2r+QKAIJHBbOQ6kO5bAFy+0qetEDfvHgbInepiq7
         hELpiHU8tbiwuvJTNTz0Iacb5RwPJ4op3hhEbL0fL++qddvzwb9ZIYi3n0rMqoUjTHDV
         XHJE9avt5/Ic1fJYQq0ZWna2vdAyLwb98NAIjctkBFyjcp/CKu6gl6QZboRYDUi9Uweb
         yVtg==
X-Received: by 10.140.91.23 with SMTP id y23mr8150104qgd.3.1393644833860; Fri,
 28 Feb 2014 19:33:53 -0800 (PST)
Received: by 10.96.215.102 with HTTP; Fri, 28 Feb 2014 19:33:23 -0800 (PST)
In-Reply-To: <xmqqr46p1kbo.fsf@gitster.dls.corp.google.com>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/243040>

On Thu, Feb 27, 2014 at 7:16 AM, Junio C Hamano <gitster@pobox.com> wrote:
>> +     if (file_exists(path.buf)) {
>> +             if (strbuf_read_file(&data, path.buf, 0) <= 0)
>> +                     die_errno(_("failed to read %s"), path.buf);
>
> Do we care about the case where we cannot tell if the file exists
> (e.g. stat() fails due to EPERM or something), or would it be not
> worth worrying about?

In that case we assume (incorrectly) that the repository is complete.
Following operations would fail. So not too bad, I think.

>> @@ -188,14 +212,20 @@ int is_git_directory(const char *suspect)
>>       int ret = 0;
>>       size_t len;
>>
>> -     strbuf_addstr(&path, suspect);
>> +     strbuf_addf(&path, "%s/HEAD", suspect);
>
>> +     if (validate_headref(path.buf))
>> +             goto done;
>
> Is there a reason why we want to check HEAD before other stuff?
> Just being curious, as I do not think of any (I am not saying that
> we shouldn't change the order).

Yes, it's reordered so that worktree signature (e.g. HEAD) is checked
first, against $GIT_DIR. Then non-worktree signatures ("refs" and
"objects") are checked against $GIT_COMMON_DIR (or $GIT_DIR still if
$GIT_DIR/commondir does not exist). Notice "path" is reset to
$GIT_COMMON_DIR just after checking HEAD. I should probably add a
comment about this separation.
-- 
Duy
