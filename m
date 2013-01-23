From: Lars Hjemli <hjemli@gmail.com>
Subject: Re: [PATCH v2] all: new command used for multi-repo operations
Date: Wed, 23 Jan 2013 19:19:01 +0100
Message-ID: <CAFXTnz5VJCwk7DWMe_9kZdY4OfLzbj0eqVB976DUT_bogzr4sg@mail.gmail.com>
References: <1358928767-16283-1-git-send-email-hjemli@gmail.com>
	<7v622nj0ys.fsf@alter.siamese.dyndns.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: git@vger.kernel.org
To: Junio C Hamano <gitster@pobox.com>
X-From: git-owner@vger.kernel.org Wed Jan 23 19:19:32 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1Ty4v1-0007ht-ME
	for gcvg-git-2@plane.gmane.org; Wed, 23 Jan 2013 19:19:28 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1756451Ab3AWSTF (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Wed, 23 Jan 2013 13:19:05 -0500
Received: from mail-bk0-f42.google.com ([209.85.214.42]:49894 "EHLO
	mail-bk0-f42.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756419Ab3AWSTC (ORCPT <rfc822;git@vger.kernel.org>);
	Wed, 23 Jan 2013 13:19:02 -0500
Received: by mail-bk0-f42.google.com with SMTP id ji2so4668575bkc.15
        for <git@vger.kernel.org>; Wed, 23 Jan 2013 10:19:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:x-received:in-reply-to:references:date:message-id
         :subject:from:to:cc:content-type;
        bh=JA59DKEjk0Aq1Nk9jov0LvCdk7ktLXWNMklBE+Jzdb8=;
        b=j++vCRGewO8qPMD5zCtO9SF9DXX0Xbu+yeFZWU1DDzBTSgxe9xPQrjIOid8zu3OHiq
         xgWeJVtP8N8BDBvIkNqdnHuM00u/Ec8la04N3uDNzJhTr3HwM/0g/3JgZfUMuaNviaSY
         jmqWtDQIL5szAhEB2mLW5VsYxvCfB+xh1BaIAD+EY4KbFGcBeAIE3ZOQQDV5xwUKc9Ms
         xrGVZszM5X6LtXvHF2XlJfKkZvc672j6HEl38UN+beOcDC22RBLbj3PNwc7sp8ner+Fy
         l/0lNUxXwDYAo4wygNu5PtS0CgZu/KQV4ortXmfYdz6C+lH9pcyHp7rs7t/5f9b2+zqk
         uwSQ==
X-Received: by 10.204.12.203 with SMTP id y11mr801046bky.27.1358965141543;
 Wed, 23 Jan 2013 10:19:01 -0800 (PST)
Received: by 10.205.83.199 with HTTP; Wed, 23 Jan 2013 10:19:01 -0800 (PST)
In-Reply-To: <7v622nj0ys.fsf@alter.siamese.dyndns.org>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/214340>

On Wed, Jan 23, 2013 at 5:52 PM, Junio C Hamano <gitster@pobox.com> wrote:
> Lars Hjemli <hjemli@gmail.com> writes:
>
>> +static int walk(struct strbuf *path, int argc, const char **argv)
>> +{
>> +     DIR *dir;
>> +     struct dirent *ent;
>> +     struct stat st;
>> +     size_t len;
>> +
>> +     dir = opendir(path->buf);
>> +     if (!dir)
>> +             return errno;
>> +     strbuf_addstr(path, "/");
>> +     len = path->len;
>> +     while ((ent = readdir(dir))) {
>> +             if (!strcmp(ent->d_name, ".") || !strcmp(ent->d_name, ".."))
>> +                     continue;
>> +             if (!strcmp(ent->d_name, ".git")) {
>> +                     strbuf_addstr(path, ent->d_name);
>> +                     setenv(GIT_DIR_ENVIRONMENT, path->buf, 1);
>> +                     strbuf_setlen(path, len - 1);
>> +                     setenv(GIT_WORK_TREE_ENVIRONMENT, path->buf, 1);
>> +                     handle_repo(path->buf, argv);
>> +                     strbuf_addstr(path, "/");
>> +                     continue;
>> +             }
>> +             strbuf_setlen(path, len);
>> +             strbuf_addstr(path, ent->d_name);
>> +             switch (DTYPE(ent)) {
>> +             case DT_UNKNOWN:
>> +                     /* Use stat() instead of lstat(), since we want to
>> +                      * know if we can follow this path into another
>> +                      * directory - it's  not important if it's actually
>> +                      * a symlink which gets us there.
>> +                      */
>
> This is wrong if you are on a platform that does have d_type, no?
> It may say it is a symbolic link, and until you stat you wouldn't
> know if it may lead to a directory.  You can add "case DT_LNK:" that
> behaves the same as DT_UNKNOWN, I think.

Yeah, that seems right, thanks.

-- 
larsh
