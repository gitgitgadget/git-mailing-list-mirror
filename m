From: Christian Couder <christian.couder@gmail.com>
Subject: Re: [PATCH] drop support for "experimental" loose objects
Date: Fri, 22 Nov 2013 12:04:01 +0100
Message-ID: <CAP8UFD1fMTrJGo9Z4+jdWqc-=UmPG1jQjwTij4962WDoh_a1DA@mail.gmail.com>
References: <20131120203350.GA31139@kitenet.net>
	<20131120213348.GA29004@sigill.intra.peff.net>
	<20131120222805.GC26468@kitenet.net>
	<20131121114157.GA7171@sigill.intra.peff.net>
	<20131121160426.GA21843@kitenet.net>
	<CAP8UFD2S1HUDYLbmEGFqLcBFExuB0h7=gqwsQ0qjpMSc+YaXog@mail.gmail.com>
	<20131122095801.GB12042@sigill.intra.peff.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Cc: Joey Hess <joey@kitenet.net>, git <git@vger.kernel.org>,
	Junio C Hamano <gitster@pobox.com>
To: Jeff King <peff@peff.net>
X-From: git-owner@vger.kernel.org Fri Nov 22 12:04:13 2013
Return-path: <git-owner@vger.kernel.org>
Envelope-to: gcvg-git-2@plane.gmane.org
Received: from vger.kernel.org ([209.132.180.67])
	by plane.gmane.org with esmtp (Exim 4.69)
	(envelope-from <git-owner@vger.kernel.org>)
	id 1VjoWz-0005MB-98
	for gcvg-git-2@plane.gmane.org; Fri, 22 Nov 2013 12:04:13 +0100
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
	id S1752567Ab3KVLED (ORCPT <rfc822;gcvg-git-2@m.gmane.org>);
	Fri, 22 Nov 2013 06:04:03 -0500
Received: from mail-vc0-f169.google.com ([209.85.220.169]:39567 "EHLO
	mail-vc0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751956Ab3KVLEB (ORCPT <rfc822;git@vger.kernel.org>);
	Fri, 22 Nov 2013 06:04:01 -0500
Received: by mail-vc0-f169.google.com with SMTP id hu19so720385vcb.14
        for <git@vger.kernel.org>; Fri, 22 Nov 2013 03:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20120113;
        h=mime-version:in-reply-to:references:date:message-id:subject:from:to
         :cc:content-type;
        bh=63xVxDSzSher6pfeahY+M1Lk1vXnrMWHITtrJQNlA68=;
        b=otdo6RPorm0gyBEWrJkRa80/+og6Nvy0ehniD4fX/7Ikg27UVzPRHkEU1d6PO0u1Pl
         Rwk9XUQlvcmrYfHNxFQ9hK27lfO1zjPpQkCHWMcoZ10dMGIPB7GA6W0giMAx7hPTE32x
         dyyuK3W6/PUqXEyMKu2FO2PfLSSuqPmA65av6iEHPZ+LjRE+vio3PKaHemBnMLSFwuWA
         Lt/Ymu2qjN7j3jdt0o5sdJ1Z9zgjm1/1y1q1zfD9FepwnUajOX7BHs0FGcfvvQA2SAnQ
         IlUwBbmURNcgzeliMfWM3i30gA0CiBqpsHn+LAq/OpJzqOH3IeDyNJdyTJc14Xs9FW/s
         8iag==
X-Received: by 10.220.17.131 with SMTP id s3mr11009285vca.20.1385118241189;
 Fri, 22 Nov 2013 03:04:01 -0800 (PST)
Received: by 10.58.253.136 with HTTP; Fri, 22 Nov 2013 03:04:01 -0800 (PST)
In-Reply-To: <20131122095801.GB12042@sigill.intra.peff.net>
Sender: git-owner@vger.kernel.org
Precedence: bulk
List-ID: <git.vger.kernel.org>
X-Mailing-List: git@vger.kernel.org
Archived-At: <http://permalink.gmane.org/gmane.comp.version-control.git/238177>

On Fri, Nov 22, 2013 at 10:58 AM, Jeff King <peff@peff.net> wrote:
> On Thu, Nov 21, 2013 at 09:19:25PM +0100, Christian Couder wrote:
>
>> Yeah, I think it might report wrong size in case of replaced objects
>> for example.
>> I looked at that following Junio's comment about the
>> sha1_object_info() API, which,
>> unlike read_sha1_file() API, does not interact with the "replace" mechanism:
>>
>> http://thread.gmane.org/gmane.comp.version-control.git/234023/
>>
>> I started to work on a patch about this but didn't take the time to
>> finish and post it.
>
> That seems kind of crazy. Would the fix be as simple as this:
>
> diff --git a/sha1_file.c b/sha1_file.c
> index 10676ba..a051d6c 100644
> --- a/sha1_file.c
> +++ b/sha1_file.c
> @@ -2529,6 +2529,8 @@ int sha1_object_info_extended(const unsigned char *sha1, struct object_info *oi)
>         struct pack_entry e;
>         int rtype;
>
> +       sha1 = lookup_replace_object(sha1);
> +
>         co = find_cached_object(sha1);
>         if (co) {
>                 if (oi->typep)
>
> or do we need some way for callers to turn off replacement? I notice
> that read_sha1_file has such a feature, but it is only used in one
> place.

Yeah, indeed, I asked myself such a question and that's why it is not
so simple unfortunately.

In "sha1_file.c", there is:

void *read_sha1_file_extended(const unsigned char *sha1,
                              enum object_type *type,
                              unsigned long *size,
                              unsigned flag)
{
        void *data;
        char *path;
        const struct packed_git *p;
        const unsigned char *repl = (flag & READ_SHA1_FILE_REPLACE)
                ? lookup_replace_object(sha1) : sha1;

        errno = 0;
        data = read_object(repl, type, size);
...

And in cache.h, there is:

#define READ_SHA1_FILE_REPLACE 1
static inline void *read_sha1_file(const unsigned char *sha1, enum
object_type *type, unsigned long *size)
{
        return read_sha1_file_extended(sha1, type, size,
READ_SHA1_FILE_REPLACE);
}

So the READ_SHA1_FILE_REPLACE is a way to disable replacement at compile time.

But in my opinion if we want such a knob, we should use it when we set
the "read_replace_refs" global variable.
For example with something like this:

diff --git a/environment.c b/environment.c
index 0a15349..7c99af8 100644
--- a/environment.c
+++ b/environment.c
@@ -44,7 +44,7 @@ const char *editor_program;
 const char *askpass_program;
 const char *excludes_file;
 enum auto_crlf auto_crlf = AUTO_CRLF_FALSE;
-int read_replace_refs = 1; /* NEEDSWORK: rename to use_replace_refs */
+int read_replace_refs = READ_SHA1_FILE_REPLACE; /* NEEDSWORK: rename
to use_replace_refs */
 enum eol core_eol = EOL_UNSET;
 enum safe_crlf safe_crlf = SAFE_CRLF_WARN;
 unsigned whitespace_rule_cfg = WS_DEFAULT_RULE;

@Junio what would you think about such a change?

> I guess we would need to audit all the sha1_object_info callers.

Yeah but when I looked at them, there were not many that looked dangerous.

Thanks,
Christian.
